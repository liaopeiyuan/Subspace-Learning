%{
load('test.mat')
load('Subspace (1).mat')
s1=section6_2
load('Subspace (2).mat')
s2=section6_2
load('Subspace (3).mat')
s3=section6_2
load('Subspace (4).mat')
s4=section6_2
load('Subspace (5).mat')
s5=section6_2
load('Subspace (6).mat')
s6=section6_2
load('Subspace (7).mat')
s7=section6_2
%}
fac = [1 2 6 5;2 3 7 6;3 4 8 7;4 1 5 8;1 2 3 4;5 6 7 8];
color =['y','m','c','r','g','b','k'];


for j=501:509
    subplot(3,3,j-500)  
    postProcessing(resM(j,:),[ptFilter(s1(resM(j,:)')',0.5),ptFilter(s2(resM(j,:)')',0.5),ptFilter(s3(resM(j,:)')',0.5),ptFilter(s4(resM(j,:)')',0.5),ptFilter(s5(resM(j,:)')',0.5),ptFilter(s6(resM(j,:)')',0.5),ptFilter(s7(resM(j,:)')',5)],'ptSize',3.5);
    hold on
    set(gca,'xtick',[],'XTickLabel',[])
    set(gca,'ytick',[],'XTickLabel',[])
    set(gca,'ztick',[],'XTickLabel',[])
    xlim([-1,1])
    ylim([-1,1])
    zlim([-1,1])
    xlabel('', 'FontSize', 2);
    ylabel('', 'FontSize', 2);
    zlabel('', 'FontSize', 2);
   
    ct=1;
    for i=-1:0.3:1
vert = [-1 -1 i;...
        1 -1 i;...
        1 1 i;...
        -1 1 i;...
        -1 -1 i+0.2;...
        1 -1 i+0.2;...
        1 1 i+0.2;...
        -1 1 i+0.2];
h(ct)=patch('vertices',vert,'Faces',fac,'FaceAlpha',0.025,'FaceColor',color(ct),'LineStyle','--');
hold on
ct=ct+1;
end
    

    grid on
end
   % tightfig;