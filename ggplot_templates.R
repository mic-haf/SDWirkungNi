#
# ggplt2 templates for following graphics:
# ---------------------------------------
# TDR: Track Decay rate
# SR: Schienenrauheit 
# Spectrum: Autopowerspetrum


library(grid)
library(ggplot2)
library(chron)
library(latex2exp)

my.date = function(x){ 
  x=as.character(x)
  d = as.Date(x,"%d.%m.%Y")
  if(is.na(d)){
    d= as.Date(x,"%Y")
  }
  return(d)
}

# ----------------------------- #
#             TDR
# ----------------------------- #
freqTDR <-c(100,125,160,200,250,315,400,500,630,800,1000,1250,1600,2000,2500,3150,4000,5000)

TSI_TDR = data.frame(foct = rep(freqTDR,times=2) ,
               dir=rep(c("h","v"),each=18), 
               TDR= c(3,3,3,3,#h
                      10^(log10(3)+log10(0.2/3)/log10(1000/200)*log10(freqTDR[6:11]/freqTDR[5])),
                      0.2,0.2,
                      10^(log10(0.2)+log10(0.5/0.2)/log10(2000/1250)*log10(1600/1250)),
                      0.5,0.5,0.5,0.5,0.5,#v
                      2,2,2,2,2,2,6,6,6,
                      10^(log10(6)+log10(0.8/6
                      )/log10(1000/630)*log10(freqTDR[10]/freqTDR[9])),
                      0.8,0.8,0.8,0.8,0.8,0.8,0.8,0.8)
)

TDRplot = function(plotTSI = NULL){
  plot = ggplot() + 
    scale_x_log10(breaks=freqTDR)+
    scale_y_log10(breaks =c((1:10)/10,2:10,seq(20,100,10)),
                  labels=c(0.1 , rep("",times=8),  1,rep(" ",times=8),10,rep("",times=8),100),
                  limits=c(0.1,100)
    )+
    xlab("Frequenz, Hz")+ylab("TDR, dB/m")+
    theme_bw()+
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major =element_line(colour= 'grey', size = 0.3),
      axis.text.x = element_text(angle = 45, hjust = 1),
      #     axis.ticks = element_line(colour = "black", size = 0.3),
      #     axis.text.x = element_text(size = 8,colour="black"),
      #     axis.text.y = element_text(size =  8,colour="black"),
      #     plot.title = element_text(lineheight=.5, face="bold"),
      legend.position="bottom" 
      )
    
  if(!is.null(plotTSI)){
    TSI = subset(TSI_TDR, sapply(dir,function(d) d %in% plotTSI))
    plot = plot + geom_line(data=TSI, aes(x=foct,y=TDR, group = dir), size = 1,color='black')
  }
  return(plot)
}

# ----------------------------- #
#              SR
# ----------------------------- #
require("scales")
reverselog_trans <- function(base = exp(1)) {
  trans <- function(x) -log(x, base)
  inv <- function(x) base^(-x)
  trans_new(paste0("reverselog-", format(base)), trans, inv, 
            log_breaks(base = base), 
            domain = c(1e-100, Inf))
}
wlR = c(0.315,0.25,0.2,0.16,0.125,0.1,0.08,0.063,0.05,0.04,0.0315,
        0.025,0.02,0.016,0.0125,0.01,0.008,0.0063,0.005,0.004,0.00315,0.0025,
        0.001995, 0.001585, 0.001259)*100

TSI_ROUGH = data.frame(wl = wlR[which(wlR==3.15)+c(-9,-6,-3,0,5,10,14)],
                       R= c( 13,7,1,-5,-8,-11,-11-3*4/5)
)

RauheitsPlot = function(){
  plot = ggplot() + 
    geom_line(data=TSI_ROUGH, aes(x=wl,y=R), size = 1, color='black')+
    scale_x_continuous(breaks = wlR ,
                       labels = as.character(round(wlR,1)),
                       trans=reverselog_trans(10))+
    scale_y_continuous(breaks = seq(-30,15,5))+
                      #labels = ylabel )+
#                   limits=c(0.1,100)
    xlab(latex2exp('wavelength, cm'))+ ylab(latex2exp('roughness, dB $r_0 = 10^{-6} m$'))+
    theme_bw()+
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major =element_line(colour= 'grey', size = 0.3),
      axis.text.x = element_text(angle = 45, hjust = 1,size = 10),
      #     axis.ticks = element_line(colour = "black", size = 0.3),
      #     axis.text.x = element_text(size = 8,colour="black"),
      #     axis.text.y = element_text(size =  8,colour="black"),
      #     plot.title = element_text(lineheight=.5, face="bold"),
      legend.position="bottom" 
    )
  return(plot)
}


# ----------------------------- #
#           Spectrum
# ----------------------------- #
SpectPlot = function(freq){
  plot = ggplot() + 
    scale_x_log10(breaks=freq)+
    xlab("frequency Hz")+ylab("spectrum dB")+
    theme_bw()+
    theme(
      panel.grid.minor = element_blank(),
      panel.grid.major =element_line(colour= 'grey', size = 0.3),
      axis.text.x = element_text(angle = 45, hjust = 1),
      #     axis.ticks = element_line(colour = "black", size = 0.3),
      #     axis.text.x = element_text(size = 8,colour="black"),
      #     axis.text.y = element_text(size =  8,colour="black"),
      #     plot.title = element_text(lineheight=.5, face="bold"),
      legend.position="bottom" 
    )
  return(plot)
}
