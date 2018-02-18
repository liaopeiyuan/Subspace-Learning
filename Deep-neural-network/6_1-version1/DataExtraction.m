perf=zeros(10,1001);
grad=zeros(10,1001);
f_score=zeros(1,10);
for i=1:10
   load(strcat('section6_1_train',num2str(i),'.mat'))
   perf(i,:)=tr.perf;
   grad(i,:)=tr.gradient;
   f_score(i)=predictionValidation(section6_1);
end
meanGrad=mean(grad(:,1:1000));
stdGrad=std(grad(:,1:1000));
meanPerf=mean(grad(:,1:1000));
stdPerf=std(grad(:,1:1000));
z=1.645
z=(x-mean)/std
zx/std-mean/std