#!/usr/bin/python
import sys
import datetime
import time
import json
import math

####################################################
# lib required: 
# sudo pip install math-tokenizer
####################################################

class MyEtFAOGenerator:
    __rsc=0.082
    __ks=1
    __latitude=None
    __kc=None
    __fi=None
    __sin_fi=None
    __cos_fi=None
    __doy=None
    __delta=None
    __dr=None
    __ws=None
    __ra=None
    __ra_mm_day=None
    
    def __init__(self, latitude, doy, kc):
        self.__kc=kc
        self.__latitude=latitude
        self.__fi= 0.01744444444444444444444444444444 * latitude  #(3.14/180)*latitude
        self.__doy=doy
        self.__delta=0.409*math.sin(0.0172*self.__doy-1.39)
        self.__dr=1+0.033*math.cos(6.28/365*self.__doy)
        self.__ws=math.acos(-math.tan(self.__fi)*math.tan(self.__delta))
		          #((24*60)/3.14)*self.__rsc*self.__dr*(self.__ws*math.sin(self.__fi)*math.sin(self.__delta)+math.cos(self.__fi)*math.cos(self.__delta)*math.sin(self.__ws))
        self.__ra= 458.59872611464968152866242038217*self.__rsc*self.__dr*(self.__ws*math.sin(self.__fi)*math.sin(self.__delta)+math.cos(self.__fi)*math.cos(self.__delta)*math.sin(self.__ws)) 
        self.__ra_mm_day=self.__ra*(0.408)

    def getEt0(self,tmax,tmin):
        return round((0.0023*(((tmax+tmin)/2)+17.8)*(tmax-tmin)**0.5)*self.__ra_mm_day,2)

    def getEtMax(self,tmax,tmin):
        return round(self.getEt0(tmax,tmin) * self.__kc,2)

    def getEtReal(self,tmax,tmin):
        return round(self.getEtMax(tmax,tmin) * self.__ks,2)

def main():
    lat=float(sys.argv[1])
    lng=float(sys.argv[2])
    kc=float(sys.argv[3])
    tmax=float(sys.argv[4])
    tmin=float(sys.argv[5])
	
    today = datetime.datetime.now()
    doy=(today - datetime.datetime(today.year, 1, 1)).days + 1
    lib_version="00.08.00_alpha"
   
    et=MyEtFAOGenerator(lat,doy,kc)
    print (et.getEt0(tmax,tmin))
if __name__ == "__main__":
     main()