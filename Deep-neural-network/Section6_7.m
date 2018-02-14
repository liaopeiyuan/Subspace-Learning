        final=[]
        
        for i=1:20
            section6_7.trainParam.epochs = j;
            for j=1:20
                gpuDevice(1)
                section6_7 = feedforwardnet([100 50 50 100],'trainrp');
                section6_7.trainParam.epochs = 80;
                section6_7.trainParam.max_fail=1000;
                section6_7.output.processFcns={'fixunknowns'}
                section6_7.input.processFcns={'fixunknowns'}
                section6_7.performFcn='mse'
                for k=1:i
                    load(strcat('t',num2str(k),'.mat'));
                    [~,tr] = train(section6_7,resM,resB,'useGPU','yes');
                    performance=max(tr.perf);
                    final(i,j)=performance;
                end

            end
        end
        
        save(strcat('section6_7','_',num2str(j),'.mat'),'net','tr','-v7.3')