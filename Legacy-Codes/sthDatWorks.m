gpuDevice(1)
net = feedforwardnet([100 50 50 50 50 50 50 100],'trainscg');
net.trainParam.epochs = 250;
net.trainParam.max_fail=12;
net.output.processFcns={'fixunknowns'}
net.input.processFcns={'fixunknowns'}
net.performFcn='mae'
net.divideParam.trainRatio=0.9;
net.divideParam.valRatio=0.05;
net.divideParam.testRatio=0.05;

ct=1

for l=1:4
for i=1:3
    name=strcat('t',num2str(i),'.mat');
    load(name)
    [net,tr] = train(net,a(:,1:30000),b(:,1:30000));
    finalTr{ct}={tr.perf;tr.vperf;tr.tperf;tr.gradient};
    ct=ct+1;
end
l
end


clear a absoluteError b linearForm linearOriginal linearRaw

plot(1:max(size(gg)),gg,'lineWidth',2)