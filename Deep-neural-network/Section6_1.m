
for i=1:10
load train
resB=resB';
resM=resM';
resB=datasample(resB',1.5e4)';
resM=datasample(resM',1.5e4)';

gpuDevice(1)
section6_1 = feedforwardnet([100 80 80 80 80 100],'trainrp');
section6_1.trainParam.epochs = 400;
section6_1.trainParam.max_fail=30;
section6_1.output.processFcns={'fixunknowns'}
section6_1.input.processFcns={'fixunknowns'}
section6_1.performFcn='mse'

[section6_1,tr] = train(section6_1,resM,resB,'useGPU','yes');
save(strcat('section6_1_',num2str(i),'.mat'),'net','tr','-v7.3')
end