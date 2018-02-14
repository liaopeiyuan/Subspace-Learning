count = gpuDeviceCount;
gpu1 = gpuDevice(1);

myNet = fitnet([9261,100,81],'trainscg');
myNet.trainParam.epochs = 2000;
myNet = train(myNet, resB', resM','useGPU','yes','showResources','yes');
genFunction(myNet);