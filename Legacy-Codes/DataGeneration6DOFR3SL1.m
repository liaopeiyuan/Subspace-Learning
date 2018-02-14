%{
Author: Alexander Liao Kent'20
Library: MATLAB RTB
Description: Discretization method of serial-link manipulator workspace
calculation by binary maps
6-DOF Spherical wrist with shoulder offset
Constant Orientation Workspace
\\Data Generation for Neural Network//
%}

function []=DataGeneration6DOFR3SL1(n,entry,orientation)
%clear all; 

%n=50; %Number of samples 


%entry=[   -1   1      -1  1      -1  1      .1      .1       .1  ];
%         x-range     y-range   z range   deltaX  deltaY  deltaZ


xmin=entry(1);
xmax=entry(2);
ymin=entry(3);
ymax=entry(4);
zmin=entry(5);
zmax=entry(6);
deltaX=entry(7);
deltaY=entry(8);
deltaZ=entry(9);

orientation            = [  rand()*2*pi   rand()*2*pi   rand()*2*pi];
%  Angular displacement   x-axis y  z (in radians)

angleX=orientation(1);
angleY=orientation(2);
angleZ=orientation(3);
    
i=xmin;
j=ymin;
k=zmin;
c1=1;
c2=1;
c3=1;

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
%Assigning values to the cell array

%Initializing
[ M,                        bMap         ]  = binaryMap6DOFR3SL1(H,xmax,xmin,ymax,ymin,zmax,zmin,deltaX,deltaY,deltaZ,angleX,angleY,angleZ);
%Input vector     corresponding binary map

[~,sM]=size(M);
[~,s]=size(bMap);

%Creating arrays to store the results
resM=zeros(n,sM+3);
resB=zeros(n,s);

resM(1,:)=[M,orientation];
resB(1,:)=bMap;

parfor num=2:n
   orientation            = [  rand()*2*pi   rand()*2*pi   rand()*2*pi];
   angleX=orientation(1);
angleY=orientation(2);
angleZ=orientation(3);
  [M,bMap]= binaryMap6DOFR3SL1(H,xmax,xmin,ymax,ymin,zmax,zmin,deltaX,deltaY,deltaZ,angleX,angleY,angleZ);
  resM(num,:)=[M,orientation];
  resB(num,:)=bMap;
  
end

[~,l]=size(bMap);


filename = horzcat('6DOFR3SL1.','n',num2str(n),'.','L',num2str(l),'.',datestr(datetime('now'),'mm.dd.yy.HH.MM'),'.mat');
%                   Type      Number of Samples                      Date

save(filename,'resM','resB');
end
