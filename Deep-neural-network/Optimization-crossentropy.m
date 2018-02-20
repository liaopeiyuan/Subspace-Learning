
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,1:6e4);
        
        resM=resM(:,1:6e4);
        
        gpuDevice(1)
        section6_5 = feedforwardnet([125 100 100 125],'trainrp');
        section6_5.trainParam.epochs = 1000;
        section6_5.trainParam.max_fail=1000;
        section6_5.output.processFcns={'fixunknowns'}
        section6_5.input.processFcns={'fixunknowns'}
        section6_5.performFcn='crossentropy'

        [section6_5,tr] = train(section6_5,resM,resB,'useGPU','yes');
        save(strcat('section6_5_crossentropy_rp','.mat'),'section6_5','tr','-v7.3')
    



        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,1:6e4);
        
        resM=resM(:,1:6e4);
        
        gpuDevice(1)
        section6_5 = feedforwardnet([125 100 100 125],'trainscg');
        section6_5.trainParam.epochs = 1000;
        section6_5.trainParam.max_fail=1000;
        section6_5.output.processFcns={'fixunknowns'}
        section6_5.input.processFcns={'fixunknowns'}
        section6_5.performFcn='crossentropy'

        [section6_5,tr] = train(section6_5,resM,resB,'useGPU','yes');
        save(strcat('section6_5_crossentropy_scg','.mat'),'section6_5','tr','-v7.3')
    



        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,1:6e4);
        
        resM=resM(:,1:6e4);
        
        gpuDevice(1)
        section6_5 = feedforwardnet([125 100 100 125],'traincgb');
        section6_5.trainParam.epochs = 1000;
        section6_5.trainParam.max_fail=1000;
        section6_5.output.processFcns={'fixunknowns'}
        section6_5.input.processFcns={'fixunknowns'}
        section6_5.performFcn='crossentropy'

        [section6_5,tr] = train(section6_5,resM,resB,'useGPU','yes');
        save(strcat('section6_5_crossentropy_cgb','.mat'),'section6_5','tr','-v7.3')
    



        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,1:6e4);
        
        resM=resM(:,1:6e4);
        
        gpuDevice(1)
        section6_5 = feedforwardnet([125 100 100 125],'trainoss');
        section6_5.trainParam.epochs = 1000;
        section6_5.trainParam.max_fail=1000;
        section6_5.output.processFcns={'fixunknowns'}
        section6_5.input.processFcns={'fixunknowns'}
        section6_5.performFcn='crossentropy'

        [section6_5,tr] = train(section6_5,resM,resB,'useGPU','yes');
        save(strcat('section6_5_crossentropy_oss','.mat'),'section6_5','tr','-v7.3')
    



        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,1:6e4);
        
        resM=resM(:,1:6e4);
        
        gpuDevice(1)
        section6_5 = feedforwardnet([125 100 100 125],'traingdx');
        section6_5.trainParam.epochs = 1000;
        section6_5.trainParam.max_fail=1000;
        section6_5.output.processFcns={'fixunknowns'}
        section6_5.input.processFcns={'fixunknowns'}
        section6_5.performFcn='crossentropy'

        [section6_5,tr] = train(section6_5,resM,resB,'useGPU','yes');
        save(strcat('section6_5_crossentropy_gdx','.mat'),'section6_5','tr','-v7.3')
    
