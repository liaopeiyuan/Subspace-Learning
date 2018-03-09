import numpy as np
from numpy import genfromtxt

def transig_apply(n):
   return np.array(2/(1+np.exp(-2*n))-1)

input = np.array(genfromtxt('input.dat',delimiter=','))

bias1 = np.array(genfromtxt('bias1.dat',delimiter=','))
bias2 = np.array(genfromtxt('bias2.dat',delimiter=','))
bias3 = np.array(genfromtxt('bias3.dat',delimiter=','))
bias4 = np.array(genfromtxt('bias4.dat',delimiter=','))
bias5 = np.array(genfromtxt('bias5.dat',delimiter=','))

inputweight = np.array(genfromtxt('inputweight.dat',delimiter=','))
layerweight1 = np.array(genfromtxt('layerweight1.dat',delimiter=','))
layerweight2 = np.array(genfromtxt('layerweight2.dat',delimiter=','))
layerweight3 = np.array(genfromtxt('layerweight3.dat',delimiter=','))
layerweight4 = np.array(genfromtxt('layerweight4.dat',delimiter=','))

a1=transig_apply(bias1+np.dot(inputweight,input))
print(a1)
a2=transig_apply(bias2+np.dot(layerweight1,a1))
print(a2)
a3=transig_apply(bias3+np.dot(layerweight2,a2))
print(a3)
a4=transig_apply(bias4+np.dot(layerweight3,a3))
print(a4)
a5=bias5+np.dot(layerweight4,a4)



print(a5)