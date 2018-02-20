%
num=7
perf=zeros(num,1001);
grad=zeros(num,1001);
f_score=zeros(1,num);
error=zeros(num,1323000);
for i=1:num
   load(strcat('section6_2_',num2str(i),'.mat'))
   perf(i,:)=tr.perf;
   grad(i,:)=tr.gradient;
   [f_score(i),error(i,:)]=predictionValidation(section6_2);
end
meanGrad=mean(grad(:,1:1000));
stdGrad=std(grad(:,1:1000));
meanPerf=mean(perf(:,1:1000));
stdPerf=std(perf(:,1:1000));

for i=1:num
    
    semilogy(1:1000,perf(i,1:1000),'LineWidth',1);
    hold on
end
%}
histo=cell(1,num);
subplot(2,2,1);
for i=1:2
    histogram(error(i,:),[-1:0.025:1]);
    set(gca,'Yscale','log')
    xlabel('Error')
    ylabel('# predictions')
    legend('subspace1','subspace2')
    hold on
end
subplot(2,2,2);
for i=3:4
    histogram(error(i,:),[-1:0.025:1]);
    set(gca,'Yscale','log')
    xlabel('Error')
    ylabel('# predictions')
    legend('subspace3','subspace4')
    hold on
end
subplot(2,2,3);
for i=5:6
    histogram(error(i,:),[-1:0.025:1]);
    set(gca,'Yscale','log')
    xlabel('Error')
    ylabel('# predictions')
    legend('subspace5','subspace6')
    hold on
end
subplot(2,2,4);
for i=7
    histogram(error(i,:),[-1:0.025:1]);
    set(gca,'Yscale','log')
    xlabel('Error')
    ylabel('# predictions')
    legend('subspace7')
    hold on
end