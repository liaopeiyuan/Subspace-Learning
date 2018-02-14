
        D=[ 0 0 rand() rand()  0 0];
        A=[ 0 rand() 0  0 0 0];
        alpha=[ pi/2 0 -pi/2 pi/2 -pi/2 0];
        l1=Link([0 D(1) A(1) alpha(1)]);
        l2=Link([0 D(2) A(2) alpha(2)]);
        l3=Link([0 D(3) A(3) alpha(3)]);
        l4=Link([0 D(4) A(4) alpha(4)]);
        l5=Link([0 D(5) A(5) alpha(5)]);
        l6=Link([0 D(6) A(6) alpha(6)]);
        
        Mn=SerialLink([l1,l2,l3,l4,l5,l6]);
xmin=0.2;
xmax=0.6;
ymin=-0.2;
ymax=0.2;
zmin=-0.4;
zmax=0;
q1=Mn.ikine6s(transl(xmin,ymin,zmin));
q2=Mn.ikine6s(transl(xmin,ymax,zmin));
q3=Mn.ikine6s(transl(xmax,xmin,zmin));
q4=Mn.ikine6s(transl(xmax,ymax,zmin));
q5=Mn.ikine6s(transl(xmin,ymin,zmax));
q6=Mn.ikine6s(transl(xmin,ymax,zmax));
q7=Mn.ikine6s(transl(xmax,ymin,zmax));
q8=Mn.ikine6s(transl(xmax,ymax,zmax));
mat=[q1;q2;q3;q4;q5;q6;q7;q8];
difmat=zeros(2,6);
for i=1:6
    difmat(1,i)=min(mat(:,i));
    difmat(2,i)=max(mat(:,i));
end

x1=[xmin xmin xmax xmax];
y1=[ymin ymax ymax ymin];
z1=[zmin zmin zmin zmin];

x2=[xmin xmin xmax xmax];
y2=[ymin ymax ymax ymin];
z2=[zmax zmax zmax zmax];

x3=[xmin xmin xmin xmin];
y3=[ymin ymax ymax ymin];
z3=[zmax zmax zmin zmin];

x4=[xmax xmax xmax xmax];
y4=[ymin ymax ymax ymin];
z4=[zmax zmax zmin zmin];

x5=[xmin xmax xmax xmin];
y5=[ymin ymin ymin ymin];
z5=[zmax zmax zmin zmin];

x6=[xmin xmax xmax xmin];
y6=[ymax ymax ymax ymax];
z6=[zmax zmax zmin zmin];

Mn.plot(qn);
hold on
patch(x1,y1,z1,'blue','facealpha',.25)
hold on

patch(x2,y2,z2,'blue','facealpha',.25)
hold on

patch(x3,y3,z3,'red','facealpha',.25)
hold on

patch(x4,y4,z4,'red','facealpha',.25)
hold on

patch(x5,y5,z5,'yellow','facealpha',.25)
hold on

patch(x6,y6,z6,'yellow','facealpha',.25)
hold on
diff=(difmat(2,:)-difmat(1,:))/20

%{
for j=1:20
    %{
    for i=difmat(1,j):0.2:difmat(2:j)
        qmat=difmat(1,:);
        qmat(j)=i;
        p560.plot(qmat);
        hold on
    end
    %}
    
    Mn.plot(difmat(1,:)+j*diff);
    
    
    
end
%}
    

%{
0.2-0.7 x
-0.2-0.3 y
-0.5-0 z
%}