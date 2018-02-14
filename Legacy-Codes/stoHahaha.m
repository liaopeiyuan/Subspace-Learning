bSize=1000;
bNum=5000;

%load train

%resM=resM';
%resB=resB';

stopE=400;
%{
for i=501:5000
    sample1=datasample(resM,bSize)';
    sample2=datasample(resB,bSize)';
    a=gpuArray(sample1);
    b=gpuArray(sample2);
    save(strcat('t',num2str(i),'.mat'),'a','b')
    %ct=ct+bSize;
end
%}

gpu1 = gpuDevice(1)
clear resB resM sample1 sample2
net = feedforwardnet([100 100 100 100 100 100 200 400],'trainscg');
net.trainParam.epochs = 1;
net.output.processFcns={'mapminmax'}
net.input.processFcns={'fixunknowns'}
net.performFcn='mae'

lr=0.1;

finalTr=zeros(bNum,4);
%for l=1:3
       
net.trainParam.lr=lr;
    %}
    for i=1:bNum      
        if (i<stopE)
           net.trainParam.lr=(1-(i/stopE))*lr+(i/stopE)*.01*lr;
        end
        
        name=strcat('t',num2str(i),'.mat');
        load(name)
        [net,tr] = train(net,a,b,'useGPU','yes');
        finalTr(i,:)=[tr.perf(2),tr.vperf(2),tr.tperf(2),tr.gradient(2)];
        if mod(i,100)==0
          plot(1:max(max(size(finalTr))),finalTr(:,1)');
        end
    end
%    l
%end