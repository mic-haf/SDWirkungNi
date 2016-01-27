import numpy as np
import matplotlib.pyplot as plt
from scipy.io import loadmat, wavfile
import json
import acoustics
from acoustics import Signal

import peakutils
import statsmodels
import statsmodels.api as sm

def signal_from_mat(matfile):
    """
    Return signals contained in .mat file from EMPA
    - for sections Q1 and Q4 the files contain the LS and MIC signals with time vector
    - for sections Q2 and Q3 the files contain the MIC signal with time vector
    
    param:
    -----
    matfile: str
        path of the .mat file
    
    return:
    ------
    d: dict
        dict containing the signals
    """
    dataMat = loadmat(matfile)
    d = {}
    # structure of .mat files defined by EMPA
    varKey =['LSVorbeifahrt', 'Sound_', 'Vorbeifahrt']
    tKey =['LSVorbeifahrt_time', 'Sound__time', 'Vorbeifahrt_time']
    print(dataMat.keys())
    varName = ['LS', 'MIC', 'MIC']
    for vk, tk, name in zip(varKey,tKey,varName):
        try:
            data = dataMat[vk]
        except KeyError:
            print('no key ' , vk )
        else:
            t =  dataMat[tk].ravel()             
            sR = int(np.round(1/(t[1]-t[0])))
            assert(sR == int(np.round(1/(t[-1]-t[-2]))))    
            d[name] = Signal(data.ravel(), sR, t.min())
    return(d)


def fill_passby_with_signals(passby):
    """
    load signals in passby dict
    
    param:
    -----
    passby: dict
        dict containing passby
    
    effect:
    ------
        fill passby with MIC and LS signals for given passby and section
    """
    #for abschnitt and values in E1
    for k, pB in passby.items():
        print('ereigniss ', k ,':')
        for abschnitt,v in pB.items():
            if not abschnitt == 'Zugstyp':
                #signal
                print( 'initaite abschnitt: ' + abschnitt + '; Index: '+v['ID'], end=' | ') 
                matfile = 'Ereignisse/'+ v['ID'] + '.mat'
                v['signals'] = signal_from_mat(matfile)
                #correct LAF FAMOS time
                # t0 = v['signals']['MIC'].t0
                # v['LAF']['FAMOS'][0] = np.array(v['LAF']['FAMOS'][0])+t0
        print('\n---------') 
        
def detect_weel_times(LSsn, decimation = 8):
    """
    Return the passby times of the train axes
    
    param:
    ------
    LSsn: Signal
        LS signal
    decimation: int pow of 2
        decimate and filter the signal
    
    return:
    ------
    - tPeaks: np.array
        passby times of the train axes
    """
    s = LSsn.decimate(decimation)
    y = np.array(s)
    t = s.times()
    # define the minimal possible distance in time between two axes
    maxSpeed = 200/3.6
    axleDistance = 1.5
    dt = axleDistance/maxSpeed
    # minimal distance in frames
    min_dist =  int(np.round(dt * s.fs))
    # use peaksUtils module for detecting maxima
    indexes = peakutils.indexes(y, thres = 0.05, min_dist = min_dist)
    tPeaks = peakutils.interpolate(t, y, ind=indexes)
    print('Minimal time interval between maxima is: ', dt,',which is equvalent to ', min_dist,' samples')
    return tPeaks

def train_speed(tPeaks, axleDistance = 1.8, plot = False):
    """
    Calculate average train speed and delta speed using robust regression
    
    params:
    --------
    tPeaks: np.array
        array of axle passby times
    axleDistance: float
        distance in meter between two axes in a boogie
        https://de.wikipedia.org/wiki/Drehgestelltypen_%28Schweiz%29
    plot: bool
        visualize calculations
    
    return:
    --------
    meanV: float
        average speed of the train
    dt: float
        delta speed of the train
    (t, vkmh, f, est): np.array, np.array, matplotlib.figure, statistics sm model
        bogie times, bogies speeds, 
        if plot is 'True'
            figure, fitted statistical model 
    """
    v_calc = lambda  t1, t2: 3.6*axleDistance/abs(t1-t2)
    #control if nAxes even
    nAxes = len(tPeaks)
    try:
        assert(nAxes%2==0)
    except AssertionError:
        print('number of detected axle not multipe of 2 ',file= sys.stderr)
    #calc speed    
    vkmh = np.array([v_calc(t1,t2) for t1,t2 in tPeaks.reshape(nAxes//2,2)])
    #calt time
    t = np.array([np.mean(t) for t in tPeaks.reshape(nAxes//2,2)])
    
    #stats sm
    #weightning
    #http://statsmodels.sourceforge.net/devel/examples/
    X = sm.add_constant(t)
    M = sm.robust.norms.TrimmedMean(1)
    est = sm.RLM(vkmh, X, M)
    est = est.fit()
    
    #calculate the predicted values
    vkmh_hat = est.predict(X)
    # calculate delta speed
    deltaV = np.round(3.6*est.params[1]*abs(tPeaks.min()-tPeaks.max()),1)
    # calculate mean speed
    meanV = vkmh_hat.mean()
    # output if plot = True
    if plot:
        print(est.summary())
        # plot
        f,ax = plt.subplots()
        ax.scatter(t,vkmh,label='bogiespeeds')
        ax.set_ybound(80,120)
        # Add the mean speed
        ax.axhline(vkmh_hat.mean(),alpha = 0.5, lw=2, color = 'green',\
        label='average speed of estimate')
        # Add the regression line, colored in red
        t_prime = np.linspace(tPeaks.min(), tPeaks.max(), 100)
        ax.plot(t_prime, est.predict(sm.add_constant(t_prime)), 'r', alpha=0.7,\
                lw=2, label='estimate')
        # legend
        ax.legend(bbox_to_anchor=(0., 1.02, 1., .102), loc=3,
                ncol=2, mode="expand", borderaxespad=0.)
        return meanV, deltaV, ( t, vkmh,f, est)
    else:
        return meanV, deltaV, ( t, vkmh)
        
def level_from_octBank( octFilterBank, lType = 'leq' ):
    """
    calculate level and spektrum given filtered signals
    param:
    -----
    octFiltBank: Signal
        multichannel signal where channels are the output of a filter bank
    lType: str `sel` `leq`
        type of integration on the signals
    return:
    ------
    spektrum: np.array
        integrated filterbank
    level: float
        integrated spektrum levels
    
    """
    if lType == 'sel':
        spektrum = octFilterBank.sound_exposure_level().T
    elif lType == 'leq':
        spektrum = octFilterBank.leq().T
    level = 10*np.log10((10**(spektrum/10)).sum())
    return(np.round(spektrum,2) , np.round(level,2))

def cut_third_oct_spectrum(octFilterBank, tInterval , lType = 'sel'):
    """
    integrate octFilterBank signals to obtain spektrum and levels. Integration intervals for intervals passed with dict tIntervals
    
    param:
    -----
    octFilterBank: Signal
        multichannel signal where channels are the output of a filter bank
    lType: str `sel` `leq`
        type of integration on the signals
    tInterval:dict
        dict with integration intervals

    return:
    ------
    spektrum: dict
        dict containig spectrum calculations for given intervals
    levels: dict
        dict containig levels calculations
    """
    level = {}
    spektrum = {}
    if not isinstance(tInterval, dict):
        print('tInterval has to be a dict of tuples')
        raise( TypeError())
    t = octFilterBank.times()
    for k,(t1,t2) in tInterval.items():
        if k == 'full':
            tInterval[k] = (t.min(),t.max())
        mask = np.logical_and(t>t1 ,t<t2)
        spektrum[k] , level[k] = level_from_octBank(octFilterBank[:,mask], lType)
    return spektrum, level
    

class MyEncoder(json.JSONEncoder):

    def default(self, obj):
        """If input object is an ndarray it will be converted into a dict 
        holding dtype, shape and the data, base64 encoded.
        """
        if isinstance(obj, Signal):
            return None
        if isinstance(obj, np.ndarray):
            return obj.tolist()
        return json.JSONEncoder(self, obj)

REF_P = 2e-5
def level_from_spect(spect):
    return 10*np.log10((10**(spect/10)).sum())
    
def level_from_LAF(LAF, dt=0.1):
    return 10*np.log10((10**(LAF/10)).sum()/len(LAF))
