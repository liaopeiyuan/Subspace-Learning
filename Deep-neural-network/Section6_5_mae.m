for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_5 = feedforwardnet([100 50 50 100],'trainrp');
        section6_5.trainParam.epochs = 80;
        section6_5.trainParam.max_fail=80;
        section6_5.output.processFcns={'fixunknowns'}
        section6_5.input.processFcns={'fixunknowns'}
        section6_5.performFcn='mae'

        [section6_5,tr] = train(section6_5,resM,resB,'useGPU','yes');
        save(strcat('section6_5_mae_rp','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_5 = feedforwardnet([100 50 50 100],'trainscg');
        section6_5.trainParam.epochs = 80;
        section6_5.trainParam.max_fail=80;
        section6_5.output.processFcns={'fixunknowns'}
        section6_5.input.processFcns={'fixunknowns'}
        section6_5.performFcn='mae'

        [section6_5,tr] = train(section6_5,resM,resB,'useGPU','yes');
        save(strcat('section6_5_mae_scg','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_5 = feedforwardnet([100 50 50 100],'traincgb');
        section6_5.trainParam.epochs = 80;
        section6_5.trainParam.max_fail=80;
        section6_5.output.processFcns={'fixunknowns'}
        section6_5.input.processFcns={'fixunknowns'}
        section6_5.performFcn='mae'

        [section6_5,tr] = train(section6_5,resM,resB,'useGPU','yes');
        save(strcat('section6_5_mae_cgb','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_5 = feedforwardnet([100 50 50 100],'trainoss');
        section6_5.trainParam.epochs = 80;
        section6_5.trainParam.max_fail=80;
        section6_5.output.processFcns={'fixunknowns'}
        section6_5.input.processFcns={'fixunknowns'}
        section6_5.performFcn='mae'

        [section6_5,tr] = train(section6_5,resM,resB,'useGPU','yes');
        save(strcat('section6_5_mae_oss','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end

for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_5 = feedforwardnet([100 50 50 100],'traingdx');
        section6_5.trainParam.epochs = 80;
        section6_5.trainParam.max_fail=80;
        section6_5.output.processFcns={'fixunknowns'}
        section6_5.input.processFcns={'fixunknowns'}
        section6_5.performFcn='mae'

        [section6_5,tr] = train(section6_5,resM,resB,'useGPU','yes');
        save(strcat('section6_5_mae_gdx','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
end