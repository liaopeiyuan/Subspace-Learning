load testNosl
trainLabel=resB;
trainFeature=resM;

trainLabel=trainLabel';
trainFeature=trainFeature';
trainLabel=trainLabel(1323*4+1:1323*5,:);

f_final=[];

for filter=0.5
    
    rawNetData=section_sl1(trainFeature);
    roundedNetData=ptFilter(rawNetData,filter);


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
            linearOriginal(ct)=trainLabel(i,j);
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