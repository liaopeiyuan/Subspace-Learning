% Post-processing of output data from DNN/discretized method
%
% [P,delP,xData,yData,zData]= postProcessing(feature,label,varargin)
% returns the workspace of robot within the indicated scope P, optional
% workspace boundary delP, and scatter-point data of points on workspace
% xData, yData and zData
%
% Options::
% type              robot kinematic structure (default '6DOF')
% visualization     optional visualization (default true)
% filter            optional filter function threshold (default -1, no filter)
% boundary          optional workspace boundary (default true)
% jointAngle        visualization robot joint angle(default [pi/4 pi/4 pi/4 pi/4 pi/4 pi/4])
% ptSize            visualization size of points on scatter plot (default 20)
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

function [P,delP,xData,yData,zData]= postProcessing(feature,label,varargin)

    opt.type='6DOF';
    opt.visualization=true;
    opt.filter=1;
    opt.boundary=true;
    opt.jointAngle=[pi/4 pi/4 pi/4 pi/4 pi/4 pi/4];
    opt.ptSize=30;
    
    opt = tb_optparse(opt, varargin);
    
    if (opt.filter~=-1)
        label=ptFilter(label,opt.filter);
    end
    
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
    
    %coordinates=M(3*TYPE+1:sizeFeature);
    
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

    %scope=[xmin:deltaX:xmax,ymin:deltaY:ymax,zmin:deltaZ:zmax];
    
    H = coordinateCell(xmin,xmax,ymin,ymax,zmin,zmax,deltaX,deltaY,deltaZ);    
    P = zeros(size(H));

    [sizeX,sizeY,sizeZ]=size(H);
    
    disp(sizeX);
    disp(sizeY);
    disp(sizeZ);
    
    index=1;
    
    for k=1:sizeZ
        for j=1:sizeY
            for i=1:sizeX
                P(i,j,k)=label(index);
                %disp(index);
                index=index+1;
            end
        end
    end
    
    if opt.boundary
        delP=zeros(size(P));
         for k=2:sizeZ-1
                for j=2:sizeY-1
                    for i=2:sizeX-1
                        if and(sum(sum(sum(P(i-1:i+1, j-1:j+1, k-1:k+1))))<27, P(i,j,k)==1)
                            delP(i,j,k)=1;
                        end
                    end
                end
         end 
    else
        delP=null(1);
    end
    
    if true
        rawXdata=zeros(1,sizeX*sizeY*sizeZ);
        rawYdata=zeros(size(rawXdata));
        rawZdata=zeros(size(rawXdata));
        binMap=zeros(size(rawXdata));
        binBound=zeros(size(rawXdata));
        dexMap=zeros(size(rawXdata));
        indexRaw=1;

        for k=1:sizeZ
            for j=1:sizeY
                for i=1:sizeX          
                    rawXdata(indexRaw)=H{i,j,k}(1);
                    rawYdata(indexRaw)=H{i,j,k}(2);
                    rawZdata(indexRaw)=H{i,j,k}(3);
                    binMap(indexRaw)=P(i,j,k);
                    binBound(indexRaw)=delP(i,j,k);
                    indexRaw=indexRaw+1;
                end
            end
        end

        xData=zeros(size(rawXdata));
        yData=zeros(size(rawXdata));
        zData=zeros(size(rawXdata));
        [~,lBin]=size(binMap);
        for i=1:lBin
            if binMap(i)>0.1
                xData(i)=rawXdata(i);
                yData(i)=rawYdata(i);
                zData(i)=rawZdata(i);
            end
        end

        indexData=1;
        [~,lF]=size(xData);
        while indexData<=lF
            if all([xData(indexData)==0;yData(indexData)==0;zData(indexData)==0])
                xData(indexData)=[];
                yData(indexData)=[];
                zData(indexData)=[];
                dexMap(indexData)=[];
                binMap(indexData)=[];
                binBound(indexData)=[];
            else
                indexData=indexData+1;
            end
            [~,lF]=size(xData);
        end

        figure
        m.plot(opt.jointAngle);
        hold on;
        
        scatter3(xData,yData,zData,opt.ptSize,binMap,'filled')
        figure
        scatter3(xData,yData,zData,opt.ptSize,binBound,'filled')
        
    end
end