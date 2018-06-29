
    
        %
        load train
        resB=resB';
        resM=resM';
        %}

        resB=resB(5293:5293+1322,1:6e4);
        
        resM=resM(:,1:6e4);
        
        gpuDevice(1)
        section6_4 = feedforwardnet([125 100 100 125],'trainrp');
        section6_4.trainParam.epochs = 1000;
        section6_4.trainParam.max_fail=1000;
        section6_4.output.processFcns={'mapminmax'}
        section6_4.input.processFcns={'fixunknowns'}
        section6_4.performFcn='mse'

        [section6_4,tr] = train(section6_4,resM,resB,'useGPU','yes');
        save(strcat('section6_4_inMap','.mat'),'section6_4','tr','-v7.3')
    
    
    

    
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,1:9e4);
        
        resM=resM(:,1:9e4);
        
        gpuDevice(1)
        section6_4 = feedforwardnet([125 100 100 125],'trainrp');
        section6_4.trainParam.epochs = 1000;
        section6_4.trainParam.max_fail=1000;
        section6_4.output.processFcns={'fixunknowns'}
        section6_4.input.processFcns={'fixunknowns'}
        section6_4.performFcn='mse'

        [section6_4,tr] = train(section6_4,resM,resB,'useGPU','yes');
        save(strcat('section6_4_noTune','.mat'),'section6_4','tr','-v7.3')
    
    
    
    
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,1:9e4);
        
        resM=resM(:,1:9e4);
        
        gpuDevice(1)
        section6_4 = feedforwardnet([125 100 100 125],'trainrp');
        section6_4.trainParam.epochs = 1000;
        section6_4.trainParam.max_fail=1000;
        section6_4.output.processFcns={'fixunknowns'}
        section6_4.input.processFcns={'mapminmax'}
        section6_4.performFcn='mse'

        [section6_4,tr] = train(section6_4,resM,resB,'useGPU','yes');
        save(strcat('section6_4_outMap','.mat'),'section6_4','tr','-v7.3')
    
    
    
    
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,1:9e4);
        
        resM=resM(:,1:9e4);
        
        gpuDevice(1)
        section6_4 = feedforwardnet([125 100 100 125],'trainrp');
        section6_4.trainParam.epochs = 1000;
        section6_4.trainParam.max_fail=1000;
        section6_4.output.processFcns={'mapminmax'}
        section6_4.input.processFcns={'mapminmax'}
        section6_4.performFcn='mse'

        [section6_4,tr] = train(section6_4,resM,resB,'useGPU','yes');
        save(strcat('section6_4_mapBoth','.mat'),'section6_4','tr','-v7.3')
    
    
