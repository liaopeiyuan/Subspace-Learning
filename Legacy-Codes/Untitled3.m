times=5000;
answer=zeros(1,times);
error=answer;
matrix = zeros(18,times);
L=struct();
parfor me = 1:times
        
    
        D=[ 0 0 0.2+0.5*rand() 0.2+0.5*rand()  0 0];
        A=[ 0 0.2+0.5*rand() 0  0 0 0];
        alpha=[ pi/2 0 -pi/2 pi/2 -pi/2 0];

    %{
          D=[ 0 0 0 rand() rand()  0 ];
        A=[ 0 0 rand() 0  0 0 ];
        alpha=[ pi/2 pi/2 0 -pi/2 pi/2 -pi/2 ];
        

        for j = 1:6
            L(j)=Link([0 D(j) A(j) alpha(j)]);
        end
        %}
        l1=Link([0 D(1) A(1) alpha(1)]);
        l2=Link([0 D(2) A(2) alpha(2)]);
        l3=Link([0 D(3) A(3) alpha(3)]);
        l4=Link([0 D(4) A(4) alpha(4)]);
        l5=Link([0 D(5) A(5) alpha(5)]);
        l6=Link([0 D(6) A(6) alpha(6)]);
        
        Mn=SerialLink([l1,l2,l3,l4,l5,l6]);
        ger=[0 0 0 0 0 0];
        intm=0;
        %step=0:pi/4:pi/2
        traj= ctraj(transl(0.5,0,0),transl(0.5,0.5,0),10);
        traj1=traj(:,:,1);
        qMn=zeros(10,6);
        logic=1;
        logic2=1;
        ger=Mn.ikine(traj1,'rlimit',500,'ilimit',500);
        if sum(ger)==0
            answer(me)=0;
            logic=0;
        end
        if logic==1
            qMn(1,:)=ger;
            for i = 2:10
                ger=Mn.ikine(traj(:,:,i),'rlimit',200,'q0',qMn(i-1,:));
                if sum(ger)==0
                    logic2=0;
                else
                    qMn(i,:)=ger;
                end
            end
            if logic2==1
            in=Mn.maniplty(qMn);
            intm=sum(in);
            %intm = M.maniplty([0 pi/4 pi/4 0 pi/4 pi/4]);
            answer(me)=intm;
            %error(me)=sum(err1);
            end
        end
       
        
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