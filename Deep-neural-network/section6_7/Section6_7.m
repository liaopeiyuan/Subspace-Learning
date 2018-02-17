        final=[]
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(5293:5293+1322,:);
        
       
        
        for i=1:500
            a=datasample(resM',5e3);
            b=datasample(resB',5e3);
            save(strcat('t',num2str(k),'.mat'));
        end
        for i=1:20
            
            for j=1:20
                gpuDevice(1)
                section6_7 = feedforwardnet([125 100 100 125],'trainrp');
                section6_7.trainParam.epochs = j;
                section6_7.trainParam.max_fail=j;
                section6_7.output.processFcns={'fixunknowns'}
                section6_7.input.processFcns={'fixunknowns'}
                section6_7.performFcn='mse'
                for k=1:i
                    load(strcat('t',num2str(k),'.mat'));
                    [~,tr] = train(section6_7,a,b,'useGPU','yes');
                    performance=max(tr.perf);
                    final(i,j)=performance;
                end

            end
        end
        
        save(strcat('section6_7','_',num2str(j),'.mat'),'net','tr','-v7.3')