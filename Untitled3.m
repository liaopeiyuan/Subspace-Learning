bSize=2500;
bNum=30;

load train
resM=resM';
resB=resB';
ct=1;

for i=1:bNum
    sample1=resM(:,ct:ct+bSize);
    sample2=resB(:,ct:ct+bSize);
    a=gpuArray(sample1);
    b=gpuArray(sample2);
    save(strcat('t',num2str(i),'.mat'),'a','b')
    ct=ct+bSize;
end


gpu1 = gpuDevice(1)
clear resB resM sample1 sample2
net = feedforwardnet([100 100 50 100 100],'traingdm');
net.trainParam.epochs = 5;
net.trainParam.max_fail=10;
net.output.processFcns={'mapminmax'}
net.input.processFcns={'fixunknowns'}
net.performFcn='mae'

lr=0.8;
    
for l=1:3
        
    for i=1:8
        net.biases{i}.learnParam.lr=lr;
        net.layerweights{i}.learnParam.lr=lr;
    end
    %}
    for i=1:bNum
        
        if and(i<30,l==1)
            for j=1:8
                net.biases{j}.learnParam.lr=(1-(i/30))*lr+(i/30)*.01*lr;
                net.layerweights{j}.learnParam.lr=(1-(i/30))*lr+(i/30)*.01*lr;
            end
        end
        
        name=strcat('t',num2str(i),'.mat');
        load(name)
        [net,tr] = train(net,a,b,'useGPU','yes');
        finalTr{i}={tr.perf;tr.vperf;tr.tperf;tr.gradient};
    end
    l
end

%genFunction(net);