'''
convert Ereignisse.xlsx table to erignisse.json
run this scrips in the sam path as table
'''

import numpy as np
import pandas as pd
import copy,sys,pathlib
import collections
import xlrd,json
import datetime
import acoustics
path = 'EreignisListe.xlsx'

passby = {}
#open xls
wb = xlrd.open_workbook(path)
ws = wb.sheet_by_name('Ereignisliste')

# Abschnitt info row 3
abschnitt = [ws.cell_value(2,i) for i in range(ws.ncols)]
for n,ai in enumerate(abschnitt):
    if ai =="":
        abschnitt[n] = abschnitt[n-1]
print(abschnitt)
#colnames
colnames= [ws.cell_value(4,i) for i in range(ws.ncols)]
print(colnames)


#read values
for EN, row in enumerate(range(5,ws.nrows)):
    d = {}
    for a, col, i in zip(abschnitt, colnames, range(ws.nrows)):
        value = ws.cell_value(row,i)
        try:
            value = float(value)
        except ValueError:
            pass
        #assign value to datastructure
        if  a == 'Protokoll':
            d[col] = value
        elif not col=='':
            d.setdefault(a,{}).update({col:value})
    print('added Vorbeifahrt:' + str(EN))
    passby[EN] = d
    
# fill dict with LAF and Spektrum
ePath = pathlib.Path().absolute().parent.joinpath('Ereignisse')
Bands = acoustics.signal.OctaveBand(fstart = 50,fstop=8000, fraction=3).nominal
#for abschnitt and values in E1
for k,E in passby.items():
    print('Vorbeifahrt ', k ,':')
    for a,v in E.items():
        if not a == 'Zugstyp':
            #LAfast
            path = ePath.joinpath('LAFast_' + v['ID']+'.asc')
            with path.open('r+') as file:
                LAF = [np.round(float(i),2)  for i in file]
            #100ms sampling 
            t = np.round(np.arange(0,len(LAF))*0.1,3).tolist() 
            v.setdefault('LAF',{})['FAMOS'] = [t,LAF, 0.1]
            #Spectrum
            path = ePath.joinpath('Spektrum_' + v['ID']+'.asc')
            with path.open('r+') as file:
                spect = [np.round(float(i),2) for i in file]
            v.setdefault('spektrum',{})['FAMOS'] = [list(Bands) , spect]
    print('\n---------')
    
#Manulellen änderungen:
print('Manuellen anderungen an passby 13 und 14')
passby[13]['Zugstyp'] = 'IC'
passby[14]['Zugstyp'] = 'Regio'

dataPath = pathlib.Path('passby.json')
with dataPath.open('w+') as data:
    json.dump( passby, data)
print('Data saved to ' + dataPath.as_posix())
