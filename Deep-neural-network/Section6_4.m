
    for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_4 = feedforwardnet([100 50 50 100],'trainrp');
        section6_4.trainParam.epochs = 80;
        section6_4.trainParam.max_fail=30;
        section6_4.output.processFcns={'mapminmax'}
        section6_4.input.processFcns={'fixunknowns'}
        section6_4.performFcn='mse'

        [section6_4,tr] = train(section6_4,resM,resB,'useGPU','yes');
        save(strcat('section6_4_inMap','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
    end
    

    for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_4 = feedforwardnet([100 50 50 100],'trainrp');
        section6_4.trainParam.epochs = 80;
        section6_4.trainParam.max_fail=30;
        section6_4.output.processFcns={'fixunknowns'}
        section6_4.input.processFcns={'fixunknowns'}
        section6_4.performFcn='mse'

        [section6_4,tr] = train(section6_4,resM,resB,'useGPU','yes');
        save(strcat('section6_4_noTune','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
    end
    
    for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_4 = feedforwardnet([100 50 50 100],'trainrp');
        section6_4.trainParam.epochs = 80;
        section6_4.trainParam.max_fail=30;
        section6_4.output.processFcns={'fixunknowns'}
        section6_4.input.processFcns={'mapminmax'}
        section6_4.performFcn='mse'

        [section6_4,tr] = train(section6_4,resM,resB,'useGPU','yes');
        save(strcat('section6_4_outMap','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
    end
    
    for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_4 = feedforwardnet([100 50 50 100],'trainrp');
        section6_4.trainParam.epochs = 80;
        section6_4.trainParam.max_fail=30;
        section6_4.output.processFcns={'mapminmax'}
        section6_4.input.processFcns={'mapminmax'}
        section6_4.performFcn='mse'

        [section6_4,tr] = train(section6_4,resM,resB,'useGPU','yes');
        save(strcat('section6_4_mapBoth','_',num2str(j),'.mat'),'net','tr','-v7.3')
    
    end
