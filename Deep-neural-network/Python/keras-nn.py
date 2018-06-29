from keras.layers import Input, Dense, Dropout, BatchNormalization, PReLU, LeakyReLU
from keras.models import Model, Sequential
from keras import optimizers
from keras import regularizers
import numpy
from scipy.io import loadmat
import tensorflow as tf
from sklearn.preprocessing import normalize, scale
from sklearn.metrics import r2_score
from sklearn.preprocessing import minmax_scale
from datetime import datetime
import pandas as pd
import shutil
import keras
import json

#a=pd.read_csv('featureTrain.csv' ,dtype='double')
#print(a)

"""
Xtrain=scale(pd.read_csv('featureTrain.csv' ,dtype='double').dropna(axis=1),axis=0)
Ytrain=pd.read_csv('labelTrain.csv' ,dtype='double').dropna(axis=1)

Xtest=scale(pd.read_csv('featureTest.csv' ,dtype='double').dropna(axis=1),axis=0)
Ytest=pd.read_csv('labelTest.csv' ,dtype='double').dropna(axis=1)
"""

Xtrain=pd.read_csv('featureTrain.csv' ,dtype='double')
Xtrain=scale(Xtrain.dropna(axis=1).loc[:, ~(Xtrain == 0).any(0)],axis=0)
Ytrain=pd.read_csv('labelTrain.csv' ,dtype='double').dropna(axis=1)

Xtest=pd.read_csv('featureTest.csv' ,dtype='double')
Xtest=scale(Xtest.dropna(axis=1).loc[:, ~(Xtest == 0).any(0)],axis=0)
Ytest=pd.read_csv('labelTest.csv' ,dtype='double').dropna(axis=1)
# fix random seed for reproducibility
numpy.random.seed(7)
#Xtrain=numpy.nonzero(numpy.loadtxt('featureTrain.csv',dtype='float32',delimiter=','))
#Ytrain=numpy.loadtxt('labelTrain.csv',dtype='float32',delimiter=',')
#Xtrain=Xtrain[1:30000,:]
#Ytrain=Ytrain[1:30000,:]
#Ｙtrain=minmax_scale(Ytrain, feature_range=(0, 1), axis=0, copy=True)
#Xtrain=normalize(Xtrain,axis=1)
#Xtrain = scale( Xtrain, axis=0, with_mean=True, with_std=True, copy=True )
#Ytrain = scale( Ytrain, axis=0, with_mean=True, with_std=True, copy=True )
print(type(Xtrain))
#Xtest=numpy.nonzero(numpy.loadtxt('featureTest.csv',dtype='float32',delimiter=','))
#Ytest=numpy.loadtxt('labelTest.csv',dtype='float32',delimiter=',')
#Xtest=Xtest[1:30000,:]
#Ytest=Ytest[1:30000,:]
#Ｙtest=minmax_scale(Ytest, feature_range=(0, 1), axis=0, copy=True)
#Xtest=normalize(Xtest,axis=1)
#Xtest = scale( Xtest, axis=0, with_mean=True, with_std=True, copy=True )
#Ytest = scale( Ytest, axis=0, with_mean=True, with_std=True, copy=True )
#print(type(Xtrain))
#print(type(Ytrain))

def nn_1(input_length):
    #LeakyReLU()=PReLU(alpha_initializer='zeros', alpha_regularizer=None, alpha_constraint=None, shared_axes=None)
    #BatchNormalization()=BatchNormalization()alization(axis=-1, momentum=0.99, epsilon=0.001, center=True, scale=True, beta_initializer='zeros', gamma_initializer='ones', moving_mean_initializer='zeros', moving_variance_initializer='ones', beta_regularizer=None, gamma_regularizer=None, beta_constraint=None, gamma_constraint=None)
    #Dropout(0.5, noise_shape=None, seed=None)=Dropout(0.5, noise_shape=None, seed=None)(0.5, noise_shape=None, seed=None)
    model = Sequential()
    model.add(Dense(32, input_dim=input_length, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))

    model.add(Dense(64, input_dim=32, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))

    model.add(Dense(128, input_dim=64, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))

    model.add(Dense(256, input_dim=128, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))

    
    model.add(Dense(512, input_dim=256, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))


    model.add(Dense(1024, input_dim=512, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))

    """
    model.add(Dense(2048, input_dim=1024, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))

    model.add(Dense(1024, input_dim=2048, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))
    """

    model.add(Dense(512, input_dim=1024, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))

    model.add(Dense(256, input_dim=512, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))


    model.add(Dense(128, input_dim=256, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))

    model.add(Dense(64, input_dim=128, kernel_initializer='RandomUniform'))
    #model.add(BatchNormalization())
    model.add(LeakyReLU())
    model.add(Dropout(0.5))

    model.add(Dense(32, input_dim=64, kernel_initializer='RandomUniform'))
    model.add(Dense(1, activation="sigmoid"))

    #Dense(64, input_dim=24, kernel_initializer="RandomUniform")`    
    opt = optimizers.SGD(lr=0.001, momentum=0.9, decay=0.0001, nesterov=False)

    model.compile(optimizer="adam", loss="binary_crossentropy")
    #model.compile(optimizer="adam", loss="softmax")

    return model


def routine(Ytest,nn_predictor):
    acc=r2_score(Ytest,nn_predictor.predict(Xtest))
    print(acc)
    string=str(datetime.now()).replace(".","").replace(" ","")+'-'+str(round(acc,2))
    nn_predictor.save(string+'.hdf5')
    shutil.move(string+'.hdf5','./models/'+string+'.hdf5')
    print(r2_score(Ytest,nn_predictor.predict(Xtest)))
    return string

nn_predictor = nn_1(len(Xtrain[0,:]))

with tf.device('/gpu:0'):
    try:
        callback=keras.callbacks.TensorBoard(log_dir='./graph', histogram_freq=0, write_graph=True, write_images=True)
        history=nn_predictor.fit(Xtrain,Ytrain, batch_size=512, epochs=1, validation_split=0.2,verbose=1, callbacks=[callback])
        print(type(history))
    except (KeyboardInterrupt, SystemExit):
        routine(Ytest,nn_predictor)

string=routine(Ytest,nn_predictor)
json.dump(history.history, open( string+".json", "w" ))
shutil.move(string+'.json','./histories/'+string+'.pickle')

