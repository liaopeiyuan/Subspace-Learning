
load train;
resM=resM';
resB=resB';
%}




gpuDevice(1)
net = feedforwardnet([125,100,100,100,125],'trainrp');
net.trainParam.epochs = 499;
net.trainParam.max_fail=75;
net.output.processFcns={'fixunknowns'};
net.input.processFcns={'fixunknowns'};
net.performFcn='mse';
perf=[];
grad=[];
%}
for i=1:5
resM1=datasample(resM',1.5e4)';
resB1=datasample(resB',1.5e4)';
clear resM resB
gpuDevice(1)
[net,tr] = train(net,resM1,resB1,'showResources','yes','useGPU','yes');
save(strcat(num2str(i),'.mat'),'net','tr','-v7.3')
perf=horzcat(perf,tr.perf);
grad=horzcat(grad,tr.gradient);
load train;
resM=resM';
resB=resB';
end

