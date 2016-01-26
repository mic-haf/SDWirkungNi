# Vorbereiten der Daten für die Documente
#
# folgende data.frame werden vorbereitet und in auswertungData.Rdata file gespeichert
# - spectWideDf: df von Spektren und Levels jede Vorbeifahrt, Abschnitt und Auswertungsintervall
# - vDf:
# - TDRni: TDR df aus Niederwangen
# - SRni: Schinenerauheit df Niedrewangen
# - TDRniWide: TDR df aus Niederwangen in wide format
# - SRniWide: Schinenerauheit df Niedrewangen in wide format 


# import library and functions
library(jsonlite)
library(dplyr)
library(tidyr)

#set db connections
library(rmongodb)
# your connection details will likely differ from these defaults
host <- "127.0.0.1"
username <- "esrWR"
password <- "esrWR"
db <- "OBdata"
#connect to mongo
conn <- mongo.create(host=host , db=db)#, username=username, password=password)

# -----------------------#
#   spektren und levels
# -----------------------#

# Daten in DSPResults.json Importieren und verarbeiten
# Die .json Daten werden in einer R `data.frame` umgewandelt so dass gewisse Operationen (Darstellung, #Gruppierungen,...) einfacher werden.
DSPResults = fromJSON("DSPResults.json")

FREQ = c(100, 125, 160, 200, 250, 315, 400, 500, 630, 800, 1000,
         1250, 1600, 2000, 2500, 3150, 4000, 5000, 6300, 8000)

#funktionen zur umwandlung
intervals_to_df = function(colN, l){
  func = function(n){
    df = data.frame(c(interval=n, as.list(setNames(l[[n]],colN))))
    return(df)
  }
  d = do.call(rbind,
              # filter some intervals spectra and leq
              lapply(setdiff(names(l), c('FAMOS','f','vorbei')), func)
  )
  return(d)
} 

get_level = function(pb,A){
  f = FREQ
  # crete list o variables attributes
  variables = list(
    'leq' = list(var = 'leq', colN = 'leq.tot'),
    's' = list(var = 'spektrum', colN = paste('leq', f,sep='.'))
  )
  #create list of df each for a given variable
  d = lapply( variables , 
              function(l)intervals_to_df(l$colN, DSPResults[[pb]][[A]][[l$var]])
  )
  # merge list of df to a single df by common interval
  df = Reduce(function(x,y) merge(x,y, all=TRUE, by = 'interval'), d)
  return(df)
}

# read passby and sections names from DSPResults
pbNames =  setdiff(names(DSPResults), c('Beschreibung'))
absch = c('Q1','Q2','Q3','Q4')

# create df of spectra and levels in wide format
spectWideDf = expand.grid(passby = pbNames, A = absch) %>% rowwise()%>% 
  do(data.frame(passby = as.character(.$passby),
                A = as.character(.$A),
                get_level(as.character(.$passby), as.character(.$A))
  )
  )
spectWideDf$A = factor(spectWideDf$A)

# create df of zugstyp
typDf = data.frame(passby = pbNames) %>% rowwise() %>% 
  do(data.frame(passby = as.character(.$passby), 
                Zugstyp = DSPResults[[as.character(.$passby)]]$Zugstyp ))

# create df of speed, speed is know on sec B2 and B% for all bogies
vDf = expand.grid(passby = pbNames, A = c('Q1','Q4')) %>% rowwise() %>% 
  do(data.frame(passby = as.character(.$passby),
                A = as.character(.$A),
                Zugstyp = DSPResults[[as.character(.$passby)]][['Zugstyp']],
                v  = round(DSPResults[[as.character(.$passby)]][[as.character(.$A)]]$vAv ),
                dv  = round(DSPResults[[as.character(.$passby)]][[as.character(.$A)]]$dv ),
                bogie = 1:length(DSPResults[[as.character(.$passby)]][[as.character(.$A)]][['ti_vi']][2,]),
                vi = DSPResults[[as.character(.$passby)]][[as.character(.$A)]][['ti_vi']][2,], 
                ti = DSPResults[[as.character(.$passby)]][[as.character(.$A)]][['ti_vi']][1,]
  )
  )
vDf$A = factor(vDf$A)
vDf$interval = floor(vDf$bogie/2)
#select bogies that are loc or strange
vDf$bogie.type = sapply(abs(vDf$vi-vDf$v) < 5, function(b)if(b){'Wagen'}else{'Antrieb'})

#unbennen der Abschnitten in df
levels(spectWideDf$A) = c('B5','B4','B3','B2')
levels(vDf$A) = c('B5','B2')

# kategorisierung von Auswertungsintervalle
X = vDf%>%group_by(passby,A,interval)%>%
  do(data.frame(passby = .$passby, 
                bogie=as.character(.$bogie),
                nBogies = nrow(.), 
                A = as.character(.$A), 
                interval.kat = if(any(.$bogie.type=='Antrieb')){'Antrieb/Wagen'}else{'Wagen'}
  )
  )

intervalKat = merge(vDf,X, by=c('passby','A', 'bogie','interval'))%>%
  filter(nBogies == 2)%>%
  group_by(passby,A,interval)%>%
  do(data.frame(interval.kat = .$interval.kat[1]))

# add Interval Kat to spectWideDf
spectWideDf = merge( intervalKat, spectWideDf,  by= c('passby','A', 'interval'), all = TRUE)
# if intervall.kat is NA set kat to full
spectWideDf$interval.kat[spectWideDf$interval =='full'] = "full" 

# add speeds to spectWideDf
spectWideDf = merge( vDf[,c('passby','A', 'v','dv')]%>%group_by(passby,A)%>%do(.[1,]),
                     spectWideDf,  by=c('passby','A'), all.y = TRUE)
# add zugstyp to spectWideDf
spectWideDf = merge( typDf, spectWideDf,  by = c('passby'),all.y = TRUE)

# -----------------------#
#   TDR
# -----------------------#

buildTDRdf = function(cursor, conn, TDRvar, OBsetupVar){
  TDR_Data=data.frame()
  i= 1
  while(mongo.cursor.next(cursor)){
    doc = mongo.cursor.value(cursor)
    ##
    OBsetup_id <- mongo.bson.value(doc, "OBsetup_id")
    OBsetup = mongo.find.one(conn, 'OBdata.OBsetup', query = list('_id'= OBsetup_id) )
    ##
    df1 <- data.frame(lapply(OBsetupVar, function(x){
      if(!is.null(mongo.bson.value(OBsetup, x))){
        return(mongo.bson.value(OBsetup, x))
      }else{
        return(NA)
      }
    })
    )
    df1$tdr_id = i
    ##
    df2 <- data.frame(
      lapply(TDRvar, function(x){
        if(!is.null(mongo.bson.value(doc, x))){
          return(mongo.bson.value(doc, x))
        }else{
          return(NA)
        }
      })
    )
    TDR_Data = rbind(TDR_Data,cbind(df1,df2))
    i=i+1
  }
  return(TDR_Data)
}
### TDR variables
TDRvar = list(
  Author = 'Author',
  messdatum='measurementDate',
  padCalc = 'calculatedPadStiffnes',
  calcQ= 'calcQuality',
  temp= 'temperature',
  rail='rail',
  dir='tdrDirection',
  freq='tdr.freq',
  tdr='tdr.value')

OBsetupVar = list( loc='loc',sec='sec', pad = 'pad', FX='MBBMvar',damp = 'damp',dampType = 'dampType' )


## Niderwangen TDR
q1 = list('$and' = list(list('loc' = 'Ni')))
cursor = mongo.find(conn, 'OBdata.OBsetup', query=q1)

ids = list()
i=1

while (mongo.cursor.next(cursor)) {
  OBsetup = mongo.cursor.value(cursor)
  OBsetup_id <- mongo.bson.value(OBsetup, "_id")
  ids[[i]]= OBsetup_id
  # make it a dataframe
  i=i+1
}
cursor = mongo.find(conn, 'OBdata.TDR', query = list(OBsetup_id = list("$in"=ids)))
TDRni = buildTDRdf(cursor , conn, TDRvar, OBsetupVar)

TDRni$tdr = round(TDRni$tdr,1)
TDRniWide = TDRni %>% spread(freq,tdr)

# 
# ##FX
# 
# q1 = list('$and' = list(
#   list('MBBMvar' = list("$exists"=TRUE)),
#   list('damp'= FALSE),
#   list('pad' = list("$eq"="h")),
#   list('Schw' = list("$ne"="H"))
#   )
#   )
# cursor = mongo.find(conn, 'OBdata.OBsetup', query=q1)
# 
# ids = list()
# i=1
# while (mongo.cursor.next(cursor)) {
#   OBsetup = mongo.cursor.value(cursor)
#   OBsetup_id <- mongo.bson.value(OBsetup, "_id")
#   ids[[i]]= OBsetup_id
#   # make it a dataframe
#   i=i+1
# }
# 
# TDRfx = buildTDRdf(mongo.find(conn, 'OBdata.TDR', 
#                               query = list(OBsetup_id = list("$in"=ids)) 
#                               ), 
#                    conn, 
#                    TDRvar, 
#                    OBsetupVar)


# -----------------------#
#           SR
# -----------------------#
#select interesting OB setups: Niderwangen without B1
q1 = list('$or' = list(
  list('$and'= list(list('loc'='Ni'),list('sec'=list('$ne'='B1')),list('damp'=TRUE))),
  list('$and'= list(list('loc'='Ni'),list('sec'='B5')))
)
)
cursor = mongo.find(conn, 'OBdata.OBsetup', query=q1)

ids = list()
i=1
while (mongo.cursor.next(cursor)) {
  OBsetup = mongo.cursor.value(cursor)
  OBsetup_id <- mongo.bson.value(OBsetup, "_id")
  ids[[i]] =list('OBsetup_id'= OBsetup_id)
  i=i+1
  # make it a dataframe
}

#load Roughness Data
R_fromdb = function(cursor,conn,Rvar,OBsetupVar){
  # return df of a given roughness in long format
  df_R=data.frame()
  i = 1
  while(mongo.cursor.next(cursor)){
    rR = mongo.cursor.value(cursor)
    ##
    rR_id <- mongo.bson.value(rR, "OBsetup_id")
    OBsetup = mongo.find.one(conn, 'OBdata.OBsetup', query = list('_id'= rR_id) )
    ##
    df1 <- data.frame(lapply(OBsetupVar, function(x) mongo.bson.value(OBsetup, x)))
    df1$r_id = i
    ##
    df2 <- data.frame(
      lapply(Rvar, function(x){
        if(!is.null(mongo.bson.value(rR, x))){
          return(mongo.bson.value(rR, x))
        }else{
          return(1)
        }
      }
      )
    )
    df_R = rbind(df_R,cbind(df1,df2))
    i=i+1
  }
  # reorder sections
  df_R$sec = factor(as.character(df_R$sec),levels = c("B2","B3","B4","B5"))
  df_R$Author = factor(as.character(df_R$Author),levels = c("MBBM","ACCON"))
  
  return(df_R)
}
OBsetupVar = list(loc='loc',sec='sec',damp='damp')

Rvar =list(
  Author = 'Author',
  kampagne='kampagne_n',
  messdatum='measurementDate',
  rail='rail',
  wl='roughness.wavelength',
  R='roughness.value')

#select R ids to load
cursor =mongo.find(conn, 'OBdata.railRoughness', query = list("$or"=ids) )
#
SRni = R_fromdb(cursor,conn, Rvar,OBsetupVar)
######################################################
# uniform wl da ACCON and MBBM have different rounding
wlMBBM = sort(as.numeric(levels(factor(SRni$wl[SRni$Author=='MBBM']))))

SRni$wl = sapply(SRni$wl, function(x){
  y=abs(x-wlMBBM)
  return(wlMBBM[y==min(y)])}
)
SRni$R = round(SRni$R,1)
SRniWide = SRni %>% spread(wl,R)

# save df
save(list=c('spectWideDf','vDf',"TDRni","SRni","TDRniWide","SRniWide" ),file = 'auswertungData.Rdata')