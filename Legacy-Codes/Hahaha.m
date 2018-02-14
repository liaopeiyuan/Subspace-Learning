gpu1 = gpuDevice(1);
%resM=resM';
%resB=resB';

z=zeros(10,10);
id1=1;
id2=1;
for epochs=100:-5:55
    for batchNum=1:10
        
        load train27
        bSize=150000/batchNum;
        bNum=batchNum;

        net = feedforwardnet([100 50 100],'trainscg');
        net.trainParam.epochs = epochs;
        net.trainParam.max_fail=12;
        net.output.processFcns={'fixunknowns'};
        net.input.processFcns={'mapminmax'};
        %net.performFcn='mse';

        for i=1:bNum
            [net,tr] = train(net,datasample(resM,round(bSize))',datasample(resB,round(bSize))');
            %finalTr{i}={tr.perf;tr.vperf;tr.tperf;tr.gradient};
        end

        
        load test27
        
        resB=resB';
        resM=resM';

        rawNetData=net(resM);
        roundedNetData=round(rawNetData);


        linearForm=[];
        linearOriginal=[];
        linearRaw=[];
        [x,y]=size(roundedNetData);
        resB=resB;

        linearForm=zeros(1,x*y);
        linearOriginal=zeros(1,x*y);
        linearRaw=zeros(1,x*y);
        ct=1;
        for i=1:x
            for j=1:y
                linearForm(ct)=roundedNetData(i,j);
                linearOriginal(ct)=resB(i,j);
                linearRaw(ct)=rawNetData(i,j);
                ct=ct+1;
            end
        end

        absoluteError=abs(linearRaw-linearOriginal);
        truePos=0;
        falseNeg=0;
        falsePos=0;
        [~,se]=size(linearForm);
        for i=1:se
           if and(linearForm(i)==1,linearOriginal(i)==1)
              truePos=truePos+1; 
           end
           if and(linearForm(i)==1,linearOriginal(i)==0)
              falsePos=falsePos+1; 
           end
           if and(linearForm(i)==0,linearOriginal(i)==1)
              falseNeg=falseNeg+1; 
           end

        end


        precision=truePos/(truePos+falsePos);
        recall=truePos/(truePos+falseNeg);
        f_score=2*precision*recall/(precision+recall);
        
        z1(id1,id2)=f_score;
        z2(id1,id2)=precision;
        z3(id1,id2)=recall;
        id2=id2+1;
    end
    id1=id1+1;
end
%genFunction(net);