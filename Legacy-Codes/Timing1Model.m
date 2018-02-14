sNum=20;
t1=zeros(1,sNum);
for i=1:sNum
    tic;
    rawNetData=net(resM(i,:)');
    rND=bR(rawNetData,0.5);
    a{i}=decoder(resM(i,:),rND);
    t1(i)=toc;
end
plot(t1,'lineWidth',2)


t2=zeros(1,sNum);
for i=1:sNum
    tic;
    b{i}=CL(resM(i,:));
    t2(i)=toc;
end
hold on
semilogy(1:sNum,t2,'lineWidth',2)


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

function P = CL(resM)

M=resM;
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
[~,sizeX]=size(xArray);
[~,sizeY]=size(yArray);
[~,sizeZ]=size(zArray);

xmin=xArray(1);
xmax=xArray(sizeX);
ymin=yArray(1);
ymax=yArray(sizeY);
zmin=zArray(1);
zmax=zArray(sizeZ);
deltaX=xArray(2)-xArray(1);
deltaY=yArray(2)-yArray(1);
deltaZ=zArray(2)-zArray(1);
    
i=xmin;
j=ymin;
k=zmin;
c1=1;
c2=1;
c3=1;

l1=Link([0 D(1) A(1) alpha(1)]);
    l2=Link([0 D(2) A(2) alpha(2)]);
    l3=Link([0 D(3) A(3) alpha(3)]);
    l4=Link([0 D(4) A(4) alpha(4)]);
    l5=Link([0 D(5) A(5) alpha(5)]);
    l6=Link([0 D(6) A(6) alpha(6)]);
    
   
    m=SerialLink([l1,l2,l3,l4,l5,l6]);
 
    
H=cell( int32(((xmax-xmin)/deltaX)+1), int32(((ymax-ymin)/deltaY)+1), int32(((zmax-zmin)/deltaZ)+1) );
%The coordinates of the node is stored in a 3-D cell array

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

  P=zeros(size(H));
  
   for k=1:sizeZ
       for j=1:sizeY
          for i=1:sizeX  
             try
                if all(not(isnan(m.ikine(  trotx(angleX) * troty(angleY) * trotz(angleZ)* transl(H{i,j,k})  ))))
                %               Analytical Inverse Kinematics     Homogeneous Transformation Matrix
                    P(i,j,k)=1;
                end
             catch
             end
          end
       end
   end
    
end

function P= decoder(resM,resB1)

M=resM;
B=resB1;
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
[~,sizeX]=size(xArray);
[~,sizeY]=size(yArray);
[~,sizeZ]=size(zArray);

xmin=xArray(1);
xmax=xArray(sizeX);
ymin=yArray(1);
ymax=yArray(sizeY);
zmin=zArray(1);
zmax=zArray(sizeZ);
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

end
