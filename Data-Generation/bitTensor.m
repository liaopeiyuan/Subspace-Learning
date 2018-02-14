% Generate a bit tensor according to the given coordinate info and manipulator
%
%
% P = bitTensor(m,P,H,opt,dim2) populates the third order tensor given the
% manipulator object m, the empty tensor P, coordinate cell H, fixed
% dimensions information dim2 and options in opt.
%
%
% Code tested on MATLAB R2017b. Usage independent from other functions is not recommended.
%
% Used by:: dataGenScopeSubspace, dataGenWSsubspace
%
% Dependency:: RTB
%
% Reference::
% @book{CorkeRobotics,
% Author = {Peter I. Corke},
% Note = {ISBN 978-3-319-54413-7},
% Edition = {Second},
% Publisher = {Springer},
% Title = {Robotics, Vision \& Control: Fundamental Algorithms in {MATLAB}},
% Year = {2017}}
%
%
%
%BSD 3-Clause License
%
%Copyright (c) 2018, Alexander (Peiyuan) Liao
%All rights reserved.
%
%Redistribution and use in source and binary forms, with or without
%modification, are permitted provided that the following conditions are met:
%
%* Redistributions of source code must retain the above copyright notice, this
%  list of conditions and the following disclaimer.
%
%* Redistributions in binary form must reproduce the above copyright notice,
%  this list of conditions and the following disclaimer in the documentation
%  and/or other materials provided with the distribution.
%
%* Neither the name of the copyright holder nor the names of its
%  contributors may be used to endorse or promote products derived from
%  this software without specific prior written permission.
%
%THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
%AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
%IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
%DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
%FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
%DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
%SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
%CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
%OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
%OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

function P = bitTensor(m,P,H,opt,dim2)
    [sizeX,sizeY,sizeZ]=size(P);
    
    switch opt.ikine
        
        case 'numerical'
            switch opt.workspace
                case 'R3'
                    %Determining if the point is within the workspace of robot
                    for k=1:sizeZ
                       for j=1:sizeY
                          for i=1:sizeX  
                             try
                                if all(not(isnan(m.ikine(  trotx(dim2(1)) * troty(dim2(2)) * trotz(dim2(3))* transl(H{i,j,k}),'ikine',opt.ikine,'ilimit',opt.ilimit,'rlimit',opt.rlimit,'slimit',opt.slimit,'tol',opt.tol,'lambda',opt.lambda,'lambdamin',opt.lambdamin,'search',opt.search  ))))
                                %               Numerical Inverse Kinematics     Homogeneous Transformation Matrix
                                    P(i,j,k)=1;
                                end
                             catch
                             end
                          end
                       end
                    end
                    
                case 'SO3'
                    %Determining if the point is within the workspace of robot
                    for k=1:sizeZ
                       for j=1:sizeY
                          for i=1:sizeX  
                             try
                                if all(not(isnan(m.ikine( trotx(H{i,j,k}(1)) * troty(H{i,j,k}(2)) * trotz(H{i,j,k}(3))* transl(dim2),'ikine',opt.ikine,'ilimit',opt.ilimit,'rlimit',opt.rlimit,'slimit',opt.slimit,'tol',opt.tol,'lambda',opt.lambda,'lambdamin',opt.lambdamin,'search',opt.search ))))
                                %               Numerical Inverse Kinematics     Homogeneous Transformation Matrix
                                    P(i,j,k)=1;
                                end
                             catch
                             end
                          end
                       end
                    end
            end       
            
        case 'analytic'
            switch opt.workspace
                case 'R3'
                    %Determining if the point is within the workspace of robot
                    for k=1:sizeZ
                       for j=1:sizeY
                          for i=1:sizeX  
                             try
                                if all(not(isnan(m.ikine6s(  trotx(dim2(1)) * troty(dim2(2)) * trotz(dim2(3))* transl(H{i,j,k})  ))))
                                %               Analytic Inverse Kinematics     Homogeneous Transformation Matrix
                                    P(i,j,k)=1;
                                end
                             catch
                             end
                          end
                       end
                    end
                    
                case 'SO3'
                    %Determining if the point is within the workspace of robot
                    for k=1:sizeZ
                       for j=1:sizeY
                          for i=1:sizeX  
                             try
                                if all(not(isnan(m.ikine6s( trotx(H{i,j,k}(1)) * troty(H{i,j,k}(2)) * trotz(H{i,j,k}(3))* transl(dim2) ))))
                                %               Analytic Inverse Kinematics     Homogeneous Transformation Matrix
                                    P(i,j,k)=1;
                                end
                             catch
                             end
                          end
                       end
                    end  
            end
    end 
    
end

