
%{
load train
resB=resB';
resM=resM';
%


resB=resB(1323*4+1:1323*5,1:2e4);
resM=resM(:,1:2e4);
%}

gpuDevice(1)
net = feedforwardnet([50 50 50 50 50],'trainrp');
net.trainParam.epochs = 2999;
net.trainParam.max_fail=30;
net.output.processFcns={'mapminmax'}
net.input.processFcns={'fixunknowns'}
net.performFcn='mse'
perf=[];
grad=[];

[net,tr] = train(net,resM,resB,'useParallel','yes');
save(strcat(num2str(i),'.mat'),'net','tr','-v7.3')

%{
for i=3:15
[net,tr] = train(net,resM,resB);
save(strcat(num2str(i),'.mat'),'net','tr','-v7.3')
end
%}
