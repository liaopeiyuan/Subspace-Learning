for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_6 = feedforwardnet([50 50 50],'trainrp');
        section6_6.trainParam.epochs = 80;
        section6_6.trainParam.max_fail=80;
        section6_6.output.processFcns={'fixunknowns'}
        section6_6.input.processFcns={'fixunknowns'}
        section6_6.performFcn='mse'

        [section6_6,tr] = train(section6_6,resM,resB,'useGPU','yes');
        save(strcat('section6_6_50_3','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_6 = feedforwardnet([60 60 60],'trainrp');
        section6_6.trainParam.epochs = 80;
        section6_6.trainParam.max_fail=80;
        section6_6.output.processFcns={'fixunknowns'}
        section6_6.input.processFcns={'fixunknowns'}
        section6_6.performFcn='mse'

        [section6_6,tr] = train(section6_6,resM,resB,'useGPU','yes');
        save(strcat('section6_6_60_3','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_6 = feedforwardnet([70 70 70],'trainrp');
        section6_6.trainParam.epochs = 80;
        section6_6.trainParam.max_fail=80;
        section6_6.output.processFcns={'fixunknowns'}
        section6_6.input.processFcns={'fixunknowns'}
        section6_6.performFcn='mse'

        [section6_6,tr] = train(section6_6,resM,resB,'useGPU','yes');
        save(strcat('section6_6_70_3','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_6 = feedforwardnet([80 80 80],'trainrp');
        section6_6.trainParam.epochs = 80;
        section6_6.trainParam.max_fail=80;
        section6_6.output.processFcns={'fixunknowns'}
        section6_6.input.processFcns={'fixunknowns'}
        section6_6.performFcn='mse'

        [section6_6,tr] = train(section6_6,resM,resB,'useGPU','yes');
        save(strcat('section6_6_80_3','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_6 = feedforwardnet([90 90 90],'trainrp');
        section6_6.trainParam.epochs = 80;
        section6_6.trainParam.max_fail=80;
        section6_6.output.processFcns={'fixunknowns'}
        section6_6.input.processFcns={'fixunknowns'}
        section6_6.performFcn='mse'

        [section6_6,tr] = train(section6_6,resM,resB,'useGPU','yes');
        save(strcat('section6_6_90_3','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_6 = feedforwardnet([100 100 100],'trainrp');
        section6_6.trainParam.epochs = 80;
        section6_6.trainParam.max_fail=80;
        section6_6.output.processFcns={'fixunknowns'}
        section6_6.input.processFcns={'fixunknowns'}
        section6_6.performFcn='mse'

        [section6_6,tr] = train(section6_6,resM,resB,'useGPU','yes');
        save(strcat('section6_6_100_3','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end
for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_6 = feedforwardnet([50 50 50 50],'trainrp');
        section6_6.trainParam.epochs = 80;
        section6_6.trainParam.max_fail=80;
        section6_6.output.processFcns={'fixunknowns'}
        section6_6.input.processFcns={'fixunknowns'}
        section6_6.performFcn='mse'

        [section6_6,tr] = train(section6_6,resM,resB,'useGPU','yes');
        save(strcat('section6_6_50_4','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_6 = feedforwardnet([50 50 50 50 50],'trainrp');
        section6_6.trainParam.epochs = 80;
        section6_6.trainParam.max_fail=80;
        section6_6.output.processFcns={'fixunknowns'}
        section6_6.input.processFcns={'fixunknowns'}
        section6_6.performFcn='mse'

        [section6_6,tr] = train(section6_6,resM,resB,'useGPU','yes');
        save(strcat('section6_6_50_5','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_6 = feedforwardnet([50 50 50 50 50 50],'trainrp');
        section6_6.trainParam.epochs = 80;
        section6_6.trainParam.max_fail=80;
        section6_6.output.processFcns={'fixunknowns'}
        section6_6.input.processFcns={'fixunknowns'}
        section6_6.performFcn='mse'

        [section6_6,tr] = train(section6_6,resM,resB,'useGPU','yes');
        save(strcat('section6_6_50_6','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_6 = feedforwardnet([50 50 50 50 50 50 50],'trainrp');
        section6_6.trainParam.epochs = 80;
        section6_6.trainParam.max_fail=80;
        section6_6.output.processFcns={'fixunknowns'}
        section6_6.input.processFcns={'fixunknowns'}
        section6_6.performFcn='mse'

        [section6_6,tr] = train(section6_6,resM,resB,'useGPU','yes');
        save(strcat('section6_6_50_7','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end