

load train
resB=resB';
resM=resM';
%}


resB=resB(1323*3+1:1323*4,1:7e4);
resM=resM(:,1:7e4);
%}

gpuDevice(1)
net = feedforwardnet([150 150 150 150],'traingdx');
net.trainParam.epochs = 1999;
net.trainParam.max_fail=30;
net.output.processFcns={'fixunknowns'}
net.input.processFcns={'fixunknowns'}
net.performFcn='mse'
perf=[];
grad=[];

[net,tr] = train(net,resM,resB,'useParallel','yes');
save(strcat(num2str(i),'.mat'),'net','tr','-v7.3')