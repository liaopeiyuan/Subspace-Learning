sSize=1323;
iterator1=1;
iterator2=sSize;

for i=1:7
    
    
        
        load trainOrg

        

        resB=resB(1:1e5,iterator1:iterator2);
        resM=resM(1:1e5,:);
        
        gpuDevice(1)
        section6_2 = feedforwardnet([125 100 100 125],'trainrp');
        section6_2.trainParam.epochs = 1000;
        section6_2.trainParam.max_fail=100;
        section6_2.output.processFcns={'fixunknowns'}
        section6_2.input.processFcns={'fixunknowns'}
        section6_2.performFcn='mse'

        [section6_2,tr] = train(section6_2,resM',resB','useGPU','yes');
        save(strcat('section6_2_',num2str(i),'.mat'),'section6_2','tr','-v7.3')
    
    
    
    iterator1=iterator2+1;
    iterator2=iterator1+sSize-1;
    
end

