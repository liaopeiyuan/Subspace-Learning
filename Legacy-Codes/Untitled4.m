answer=zeros(1,200);
matrix = zeros(18,200);
L=struct();


        D=[ 0 0 14.7313 14.7713  0 0];
        A=[ 0 14.7029 0  0 0 0];
        alpha=[ pi/2 0 -pi/2 pi/2 -pi/2 0];
        l1=Link([0 D(1) A(1) alpha(1)]);
        l2=Link([0 D(2) A(2) alpha(2)]);
        l3=Link([0 D(3) A(3) alpha(3)]);
        l4=Link([0 D(4) A(4) alpha(4)]);
        l5=Link([0 D(5) A(5) alpha(5)]);
        l6=Link([0 D(6) A(6) alpha(6)]);
        
        Mn=SerialLink([l1,l2,l3,l4,l5,l6]);
        
        intm=0;
        qMn= Mn.jtraj(transl(0.5,0,0),transl(0.5,1,0),0);
        %qMn=Mn.ikine6s(traj);
        %in=Mn.maniplty(qMn);
        %intm=sum(in);
        %intm = M.maniplty([0 pi/4 pi/4 0 pi/4 pi/4]);
        %answer(me)=intm;
        Mn.plot(Mn.ikine6s(transl(0.5,0,0)))
       
        
        %matrix(:,me)=[D,A,alpha];
%end
  

