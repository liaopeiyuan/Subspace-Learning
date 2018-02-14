load test
resB=resB';
resM=resM';
resB=resB(1323*3+1:1323*4,:);


f_final=[];
for filter=-1:0.1:1
rawNetData=net(resM);
roundedNetData=bR(rawNetData,filter);


linearForm=[];
linearOriginal=[];
linearRaw=[];
[x,y]=size(roundedNetData);


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

f_final=horzcat(f_final,f_score);
end

l=[]
for i=1:5
l=horzcat(l,cell2mat(finalTr{i}(4)))
end

function Mout = bR(Min,n)
    [x,y]=size(Min);
    Mout = zeros(x,y);
    for i=1:x
        for j=1:y
            if (Min(i,j)>n)
                Mout(i,j)=1;
            end
        end
    end
end





