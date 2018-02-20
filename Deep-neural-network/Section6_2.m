sSize=1323;
iterator1=1;
iterator2=sSize;

for i=1:7
    
    for j=1:4
        
        load train
        resB=resB';
        resM=resM';
        

        resB=resB(iterator1:iterator2,:);
        resB=datasample(resB',1.5e4)';
        resM=datasample(resM',1.5e4)';
        
        gpuDevice(1)
        section6_2 = feedforwardnet([100 50 50 100],'trainrp');
        section6_2.trainParam.epochs = 75;
        section6_2.trainParam.max_fail=30;
        section6_2.output.processFcns={'fixunknowns'}
        section6_2.input.processFcns={'fixunknowns'}
        section6_2.performFcn='mse'

        [section6_2,tr] = train(section6_2,resM,resB,'useGPU','yes');
        save(strcat('section6_2_',num2str(i),'_',num2str(j),'.mat'),'net','tr','-v7.3')
    
    end
    
    iterator1=iterator2+1;
    iterator2=iterator1+sSize-1;
    
end
