answer=zeros(1,100);
matrix = zeros(18,100);
for me = 1:100
        
        %SerialLink Parameters
        l=10*round(rand(1,4),3);
       
        alpha=zeros(1,6);
        r=2+round(rand()*3);
        aRand=-1+round(rand(1,6)*2);
        rLength=round(rand(1,4),3);
        L(r)=Link([0 rLength(1) rLength(2) -pi/2]);
        L(r+1)=Link([0 rLength(3) 0 pi/2]);
        L(r-1)=Link([0 0 rLength(4) 0]);
        for i = r-1:-1:1
            L(i)=Link([0 0 0 pi/2]);
        end
        for i = r+1:6
            L(i)=Link([0 0 0 pi/2]);
        end
        
        intm = 0;
        M=SerialLink(L);
        %{
        for k = 0:pi/16:pi/2
            intm=intm+sigmf(Mani.maniplty([k pi/8 pi/8 pi/8 pi/8 pi/8]),[1,0]);
        end
        %}
        intm = M.maniplty([pi/8 pi/8 pi/8 pi/8 pi/8 pi/8]);
        answer(me)=intm;
        
        matrix(:,me)=[D,A,alpha];
end
        
for t = 1:size(answer)
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