load trainOrg
resM=resM(1:1e5,:);
resB=resB(1:1e5,1323*4+1:1323*5);

for i=1:10


gpuDevice(1)
section6_1 = feedforwardnet([150 100 100 150],'trainrp');
section6_1.trainParam.epochs = 1000;
section6_1.trainParam.max_fail=1000;
section6_1.output.processFcns={'fixunknowns'}
section6_1.input.processFcns={'fixunknowns'}
section6_1.performFcn='mse'

[section6_1,tr] = train(section6_1,resM',resB','useGPU','yes');
save(strcat('section6_1_train',num2str(i),'.mat'),'section6_1','tr','-v7.3')
end