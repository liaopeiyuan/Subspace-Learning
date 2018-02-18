%Classical discretization method for 5-DOF and 6-DOF manipulator (constant) orientation workspace
%
%
% P = discretizedWorkspace(feature, varargin) returns the workspace of robot given information contained in feature 
%
%
% Options::
% 'type',S          degree-of-freedom of robot (default '6DOF')
% 'workspace',S     targeted workspace (default 'R3')    
% 'ikine',S         method of inverse kinematics (default 'numerical')
%
% The following are aquired from RTB, which applies to the 'numerical' option in 'ikine'
% 'ilimit',L        maximum number of iterations (default 500)
% 'rlimit',L        maximum number of consecutive step rejections (default 100)
% 'tol',T           final error tolerance (default 1e-10)
% 'lambda',L        initial value of lambda (default 0.1)
% 'lambdamin',M     minimum allowable value of lambda (default 0)
% 'search'          search over all configurations
% 'slimit',L        maximum number of search attempts (default 100)   
%
% Code tested on MATLAB R2017b. Usage independent from other functions is not recommended.
%
% Used by:: discretizedWorkspace
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
% @article{AW1BinaryMapCastelli,
% author = { Gianni   Castelli  and  Erika   Ottaviano  and  Marco   Ceccarelli },
% title = {A Fairly General Algorithm to Evaluate Workspace Characteristics of Serial and Parallel Manipulators}, 
% journal = {Mechanics Based Design of Structures and Machines},
% volume = {36},
% number = {1},
% pages = {14-33},
% year  = {2008},
% publisher = {Taylor \& Francis},
% doi = {10.1080/15397730701729478}}
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

function P = discretizedWorkspace(feature, varargin)

    opt.type='6DOF';
    opt.ikine='numerical';
    opt.workspace='R3';
    opt.ilimit = 100;
    opt.rlimit = 100;
    opt.slimit = 100;
    opt.tol = 1e-10;
    opt.lambda = 0.1;
    opt.lambdamin = 0;
    opt.search = false;
    
    opt = tb_optparse(opt, varargin);
    
    switch opt.type
        case '6DOF'
            TYPE=6;
        case '5DOF'
            TYPE=5;        
        otherwise
            error('Please enter a valid robot kinematics structure type');
    end
    
    M=feature;
    [~,sizeFeature]=size(M);
    dim2=M(sizeFeature-2:sizeFeature);
    sizeFeature=sizeFeature-3;
    D=M(1:TYPE);
    A=M(TYPE+1:2*TYPE);
    alpha=M(2*TYPE+1:3*TYPE);

    
    for i=1:TYPE
        l(i)=Link([0,D(i),A(i),alpha(i)]);
    end
    m=SerialLink(l);
    
    coordinates=M(3*TYPE+1:sizeFeature);
    stopPt=[];
    deltaPt=M(3*TYPE+2)-M(3*TYPE+1);

    for i=20:sizeFeature-1
        if round((M(i+1)-M(i)),2)~=round(deltaPt,2)
            stopPt=horzcat(stopPt,i);
            deltaPt=M(i+2)-M(i+1);
        end
    end
    
    if size(stopPt)==[1 1]
        stopPt=horzcat(stopPt,18+(2*(sizeFeature-18)/3)+1);
    elseif isempty(stopPt)
        stopPt=[18+((sizeFeature-18)/3)+1, 18+(2*(sizeFeature-18)/3)+1];
    end

    xArray=M(19:stopPt(1));
    yArray=M(stopPt(1)+1:stopPt(2));
    zArray=M(stopPt(2)+1:sizeFeature);
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

    scope=[xmin:deltaX:xmax,ymin:deltaY:ymax,zmin:deltaZ:zmax];
    
    H = coordinateCell(xmin,xmax,ymin,ymax,zmin,zmax,deltaX,deltaY,deltaZ);    
    P = zeros(size(H));
    
    P = bitTensor(m,P,H,opt,dim2);

end