load train
resB=resB';
resM=resM';
resB=resB(1324:(1324+1322),:);


gpuDevice(1)
net = feedforwardnet([250 250 250 250 300 300 300 500],'trainscg');
net.trainParam.epochs = 499;
net.trainParam.max_fail=6;
net.output.processFcns={'fixunknowns'}
net.input.processFcns={'fixunknowns'}
net.performFcn='mse'
perf=[];
grad=[];

for i=1:5
[net,tr] = train(net,resM,resB);
save(strcat(num2str(i),'.mat'),'net','tr','-v7.3')
perf=horzcat(perf,tr.perf);
grad=horzcat(grad,tr.gradient);
end
