        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,1:1.5e4);
        resM=resM(:,1:1.5e4);
        
        gpuDevice(1)
        section6_8 = feedforwardnet([100 50 50 100],'trainrp');
        section6_8.trainParam.epochs = 80;
        section6_8.trainParam.max_fail=80;
        section6_8.output.processFcns={'fixunknowns'}
        section6_8.input.processFcns={'fixunknowns'}
        section6_8.performFcn='mse'

        [section6_8,tr] = train(section6_8,resM,resB,'useGPU','yes');
        save(strcat('section6_8','.mat'),'net','tr','-v7.3')
    
        load trainScopeSubspace
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,1:1.5e4);
        resM=resM(:,1:1.5e4);
        
        gpuDevice(1)
        section6_8 = feedforwardnet([100 50 50 100],'trainrp');
        section6_8.trainParam.epochs = 80;
        section6_8.trainParam.max_fail=80;
        section6_8.output.processFcns={'fixunknowns'}
        section6_8.input.processFcns={'fixunknowns'}
        section6_8.performFcn='mse'

        [section6_8,tr] = train(section6_8,resM,resB,'useGPU','yes');
        save(strcat('section6_8_scopesubspace','.mat'),'net','tr','-v7.3')
        
        load trainNoSubspace
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,1:1.5e4);
        resM=resM(:,1:1.5e4);
        
        gpuDevice(1)
        section6_8 = feedforwardnet([100 50 50 100],'trainrp');
        section6_8.trainParam.epochs = 80;
        section6_8.trainParam.max_fail=80;
        section6_8.output.processFcns={'fixunknowns'}
        section6_8.input.processFcns={'fixunknowns'}
        section6_8.performFcn='mse'

        [section6_8,tr] = train(section6_8,resM,resB,'useGPU','yes');
        save(strcat('section6_8_nosubspace','.mat'),'net','tr','-v7.3')