times=100;
answer=zeros(1,times);
error=answer;
matrix = zeros(18,times);

parfor me =1:times
    
        D=[ 0 0 rand() rand()  0 0];
        A=[ 0 rand() 0  0 0 0];
        
        alpha=[ pi/2 0 -pi/2 pi/2 -pi/2 0];
        l1=Link([0 D(1) A(1) alpha(1)],'m',0,'l',[0.066,0,0;0,0.086,0;0,0,0.0125],[-0.0203,-0.0141,0.07]);
        l2=Link([0 D(2) A(2) alpha(2)]);
        l3=Link([0 D(3) A(3) alpha(3)],'m',A(2)*40);
        l4=Link([0 D(4) A(4) alpha(4)],'m',D(3)*40);
        l5=Link([0 D(5) A(5) alpha(5)],'m',D(4)*20);
        l6=Link([0 D(6) A(6) alpha(6)]);
        
        Mn=SerialLink([l1,l2,l3,l4,l5,l6]);

        
        qtraj=ctraj(transl(0.5,0,0),transl(0.5,0.5,0),25);
        traj=Mn.ikine6s(qtraj);
        vec=Mn.maniplty(traj,'asada');
        intm=sum(vec);
        answer(me)=intm;
        
        matrix(:,me)=[D,A,alpha];
end
        
gee=zeros(1,6);   

for t = 1:times
   if answer(t)==max(answer)
       gee=matrix(:,t);
   end
end

nD=gee(1:6,1);
nA=gee(7:12,1);
nAlpha=gee(13:18,1);

for nj = 1:6
            nL(nj)=Link([0 nD(nj) nA(nj) nAlpha(nj)]);
end
nM=SerialLink(nL);
q0=[0 0 0 0 0 0];
%nM.plot(q0);
%nM.teach();

scatter3(matrix(3,:),matrix(4,:),matrix(8,:),7.5,answer,'filled')