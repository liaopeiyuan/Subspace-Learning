ct1=2647;
ct2=3969;

for i=3:7
load train
resB=resB';
resM=resM';
resB=resB(ct1:ct2,:);

gpuDevice(1)
net = feedforwardnet([250 250 250 250 300 300 300 500],'trainscg');
net.trainParam.epochs = 2999;
net.trainParam.max_fail=6;
net.output.processFcns={'fixunknowns'}
net.input.processFcns={'fixunknowns'}
net.performFcn='mse'
perf=[];
grad=[];

[net,tr] = train(net,resM,resB);
save(strcat(num2str(i),'.mat'),'net','tr','-v7.3')

ct1=ct2+1;
ct2=ct1+1322;

end

%{
If the computer has a strong GPU, replace 20 by "[net,tr] = train(net,resM,resB,'useGPU','yes');"
%}

