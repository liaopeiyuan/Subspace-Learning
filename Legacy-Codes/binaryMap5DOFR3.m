function [M,bMap]= binaryMap5DOFR3(H,xmax,xmin,ymax,ymin,zmax,zmin,deltaX,deltaY,deltaZ,angleX,angleY,angleZ)
    
    %Randomized DH standard parameter for manipulator
    %{
    D=    [0    0        rand()/2  0 rand()/2 ];
    A=    [0    rand()/2 rand()/20 0        0 ];
    alpha=[pi/2 0        0     -pi/2     pi/2];
    %}
    
    D=    [0    0        rand()/2 0 rand()/2 ];
    A=    [0    rand()/2 rand()/2 0        0 ];
    alpha=[pi/2 0        0     -pi/2     pi/2];
    l1=Link([0 D(1) A(1) alpha(1)]);
    l2=Link([0 D(2) A(2) alpha(2)]);
    l3=Link([0 D(3) A(3) alpha(3)]);
    l4=Link([0 D(4) A(4) alpha(4)]);
    l5=Link([0 D(5) A(5) alpha(5)]);

    m=SerialLink([l1,l2,l3,l4,l5]);
    
    P=zeros(size(H));
    %Binary matrix
    
    [sizeX,sizeY,sizeZ]=size(P);
   

    
    
    %Optional PUMA560 Model for demonstration purposes
    %mdl_puma560;
    %m=p560;
    
    
    %Determining if the point is within the workspace of robot
    for k=1:sizeZ
       for j=1:sizeY
          for i=1:sizeX  
             try
                if all(not(isempty(m.ikine(  trotx(angleX) * troty(angleY) * trotz(angleZ)* transl(H{i,j,k}), 'ilimit',250,'tol',5e-9,'mask',[1 1 1 0 0 0] ))))
                %              Numerical Inverse Kinematics     Homogeneous Transformation Matrix
                    P(i,j,k)=1;
                end
             catch
             end
          end
       end
    end
    
    M=[D,A,alpha];
    %DH parameters
    
    cdData=[xmin:deltaX:xmax,ymin:deltaY:ymax,zmin:deltaZ:zmax];
    M=[M,cdData];
    
    bMap=zeros(1,sizeX*sizeY*sizeZ);
    
    %Foiling the binary map into a vector
    index=1;                
    for k=1:sizeZ                   
        for j=1:sizeY                    
            for i=1:sizeX                         
                bMap(1,index)=P(i,j,k);            
                index=index+1;                        
            end           
        end  
    end
 
end

  