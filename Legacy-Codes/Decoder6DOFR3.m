%Please load the ".mat" file first
nume=2;
M=resM(:,nume)';
B=horzcat(zeros(1,1323*3),bR(net(resM(:,nume))',0.5),zeros(1,1323*3));
[~,s]=size(M);
D=M(1:6);
A=M(7:12);
alpha=M(13:18);

Coordinates=M(19:s);
stopPt=[];
dif=M(20)-M(19);
for i=20:s-1
    if round((M(i+1)-M(i)),2)~=round(dif,2)
        stopPt=horzcat(stopPt,i);
        dif=M(i+2)-M(i+1);
    end
end
if size(stopPt)==[1 1]
    stopPt=horzcat(stopPt,18+(2*(s-18)/3)+1);
elseif isempty(stopPt)
    stopPt=[18+((s-18)/3)+1, 18+(2*(s-18)/3)+1];
end

xArray=M(19:stopPt(1));
yArray=M(stopPt(1)+1:stopPt(2));
zArray=M(stopPt(2)+1:s);
[~,sX]=size(xArray);
[~,sY]=size(yArray);
[~,sZ]=size(zArray);

xmin=xArray(1);
xmax=xArray(sX);
ymin=yArray(1);
ymax=yArray(sY);
zmin=zArray(1);
zmax=zArray(sZ);
deltaX=xArray(2)-xArray(1);
deltaY=yArray(2)-yArray(1);
deltaZ=zArray(2)-zArray(1);

i=xmin;
j=ymin;
k=zmin;
c1=1;
c2=1;
c3=1;
index=1;

for k=zmin:deltaZ:zmax
        c2=1;
        for j=ymin:deltaY:ymax
            c1=1;
            for i=xmin:deltaX:xmax
                H{c1, c2, c3}=[i,j,k];
                c1=c1+1;
            end
            c2=c2+1;
        end
        c3=c3+1;
end

[sizeX,sizeY,sizeZ]=size(H);
P=zeros(size(H));
for k=1:sizeZ
    for j=1:sizeY
        for i=1:sizeX
            P(i,j,k)=B(index);
            index=index+1;
        end
    end
end
            

delP=zeros(size(P));

 for k=2:sizeZ-1
        for j=2:sizeY-1
            for i=2:sizeX-1
                if and(sum(sum(sum(P(i-1:i+1, j-1:j+1, k-1:k+1))))<27, P(i,j,k)==1)
                    delP(i,j,k)=1;
                end
                %{
                if and(sum(sum(sum(P(i-1:i+1, j-1:j+1, k-1:k+1))))==27, P(i,j,k)==1)
                   delP(i,j,k)=0;
                end
                if P(i,j,k)==0
                    delP(i,j,k)=0;
                end
                %}
            end
        end
 end


    
  l1=Link([0 D(1) A(1) alpha(1)]);
    l2=Link([0 D(2) A(2) alpha(2)]);
    l3=Link([0 D(3) A(3) alpha(3)]);
    l4=Link([0 D(4) A(4) alpha(4)]);
    l5=Link([0 D(5) A(5) alpha(5)]);
    l6=Link([0 D(6) A(6) alpha(6)]);
    
   
    m=SerialLink([l1,l2,l3,l4,l5,l6]);
 
 
 
    xData=zeros(1,sizeX*sizeY*sizeZ);
    yData=zeros(size(xData));
    zData=zeros(size(xData));
    binMap=zeros(size(xData));
    binBound=zeros(size(xData));
    dexMap=zeros(size(xData));
    ct=1;

    for k=1:sizeZ
        for j=1:sizeY
            for i=1:sizeX          
                xData(ct)=H{i,j,k}(1);
                yData(ct)=H{i,j,k}(2);
                zData(ct)=H{i,j,k}(3);
                binMap(ct)=P(i,j,k);
                binBound(ct)=delP(i,j,k);
                ct=ct+1;
            end
        end
    end

    fXData=zeros(size(xData));
    fYData=zeros(size(xData));
    fZData=zeros(size(xData));
    [~,lBin]=size(binMap);
    for i=1:lBin
        if binMap(i)>0
            fXData(i)=xData(i);
            fYData(i)=yData(i);
            fZData(i)=zData(i);
        end
    end

    ct2=1;
    [~,lF]=size(fXData);
    while ct2<=lF
        if all([fXData(ct2)==0;fYData(ct2)==0;fZData(ct2)==0])
            fXData(ct2)=[];
            fYData(ct2)=[];
            fZData(ct2)=[];
            dexMap(ct2)=[];
            binMap(ct2)=[];
            binBound(ct2)=[];
        else
            ct2=ct2+1;
        end
        [~,lF]=size(fXData);
    end

    for i=1:sizeZ
        area(i)=sum(sum(P(:,:,i))*deltaX)*deltaY;
    end
    volume=sum(area)*deltaZ;
    
    
    
    figure
    m.plot([pi/4 pi/4 pi/4 pi/4 pi/4 pi/4]);
    hold on;

    
    scatter3(fXData,fYData,fZData,20,binBound,'filled')
    figure
    scatter3(fXData,fYData,fZData,20,binMap,'filled')
 
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

    