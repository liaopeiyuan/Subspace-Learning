function [f_final,error] = predictionValidation(net)
load test

trainLabel=resB;
trainFeature=resM;

trainLabel=trainLabel';
trainFeature=trainFeature';
trainLabel=trainLabel(1323*4+1:1323*5,:);

f_final=[];

for filter=0.5
    
    rawNetData=net(trainFeature);
    roundedNetData=ptFilter(rawNetData,filter);


    linearForm=[];
    linearOriginal=[];
    linearRaw=[];
    [x,y]=size(roundedNetData);


    linearForm=zeros(x,y);
    linearOriginal=zeros(x,y);
    linearRaw=zeros(x,y);
    %ct=1;
    for i=1:x
        for j=1:y
            linearForm(i,j)=roundedNetData(i,j);
            linearOriginal(i,j)=trainLabel(i,j);
            linearRaw(i,j)=rawNetData(i,j);
            %ct=ct+1;
        end
    end

    absoluteError=abs(linearRaw-linearOriginal);
    error=(linearRaw-linearOriginal);
    truePos=zeros(1,y);
    falseNeg=zeros(1,y);
    falsePos=zeros(1,y);
    [x1,y1]=size(linearForm);
    for i=1:x1
    for j=1:y1
       if and(linearForm(i,j)==1,linearOriginal(i,j)==1)
          truePos(j)=truePos(j)+1; 
       end
       if and(linearForm(i,j)==1,linearOriginal(i,j)==0)
          falsePos(j)=falsePos(j)+1; 
       end
       if and(linearForm(i,j)==0,linearOriginal(i,j)==1)
          falseNeg(j)=falseNeg(j)+1; 
       end

    end
    end

    precision=truePos./(truePos+falsePos);
    recall=truePos./(truePos+falseNeg);
    f_score=2.*precision.*recall./(precision+recall);

    f_final=horzcat(f_final,f_score);
    
end






