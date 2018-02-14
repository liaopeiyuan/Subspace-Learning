% Generate the coordinate cell given scope information
%
%
% H = coordinateCell(xmin,xmax,ymin,ymax,zmin,zmax,deltaX,deltaY,deltaZ)
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

function H = coordinateCell(xmin,xmax,ymin,ymax,zmin,zmax,deltaX,deltaY,deltaZ)
    
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
    
end

