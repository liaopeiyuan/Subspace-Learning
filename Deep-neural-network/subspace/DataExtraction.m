
num=5
perf=zeros(num,1001);
grad=zeros(num,1001);
f_score=zeros(1000,num);
recall=zeros(1,num);
precision=zeros(1,num);

error=zeros(num,1323,1000);
for i=1:num
   load(strcat('section_6_6_',num2str(i+4),'0_3.mat'))
   trFcn(i)={section_sl1.trainFcn};
   %perf(i,:)=tr.perf;
   %grad(i,:)=tr.gradient;
   [f_score(:,i),error(i,:,:),precision,recall]=predictionValidation(section_sl1);
end
meanGrad=mean(grad(:,1:1000));
stdGrad=std(grad(:,1:1000));
meanPerf=mean(perf(:,1:1000));
stdPerf=std(perf(:,1:1000));

for i=1:num
    
    semilogy(1:1000,grad(i,1:1000));
    hold on
end

f_mean=nanmean(f_score);
f_std=nanstd(f_score);
p_mean=nanmean(precision);
r_mean=nanmean(recall);
p_std=nanstd(precision);
r_std=nanstd(recall);
%{
z=1.645
z=(x-mean)/std
zx/std-mean/std
%}