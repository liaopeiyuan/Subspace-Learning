gpu1 = gpuDevice(1)
load train
%resM=resM';
%resB=resB';

bSize=2.5e4;
bNum=30;

for i=1:bNum
    sample1=datasample(resM,bSize)';
    sample2=datasample(resB,bSize)';
    save(strcat('t',num2str(i),'.mat'),'sample1','sample2')
end


clear resB resM
net = feedforwardnet([100 50 50 50 50 50 50 100],'trainscg');
net.trainParam.epochs = 50;
net.trainParam.max_fail=12;
net.output.processFcns={'fixunknowns'}
net.input.processFcns={'mapminmax'}
net.performFcn='mse'

for i=1:bNum
    name=strcat('t',num2str(i),'.mat');
    load(name)
    [net,tr] = train(net,sample1,sample2);
    finalTr{i}={tr.perf;tr.vperf;tr.tperf;tr.gradient};
end

%genFunction(net);