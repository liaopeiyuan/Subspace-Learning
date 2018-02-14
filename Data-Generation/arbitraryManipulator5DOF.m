% Obtain an observation of the 5-DOF manipulator distribution with given radius of the interval
%
%
% [m,robotFeature] = randomManipulator5DOF(distribution, r, opt) returns
% a robot object m with its vector form robotFeature given sampling
% distribution, radius of interval r if the distribution is uniform, and
% other options.
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

function [m,robotFeature] = randomManipulator5DOF(distribution, r, opt)
    if opt
        mdl_puma560;
        m=p560;
        robotFeature=[0,0,0.150050000000000,0.431800000000000,0,0,0,0.431800000000000,0.0203000000000000,0,0,0,1.57079632679490,0,-1.57079632679490,1.57079632679490,-1.57079632679490,0];
    else
        switch distribution
            case "uniform"
                D=    [rand()*r rand()*r rand()*r rand()*r rand()*r];
                A=    [rand()*r rand()*r rand()*r rand()*r rand()*r];
                alpha=[rand()*r rand()*r rand()*r rand()*r rand()*r];
            case "normal"
                D=    [randn() randn() randn() randn() randn()];
                A=    [randn() randn() randn() randn() randn()];
                alpha=[randn() randn() randn() randn() randn()];        
            otherwise
                D=    [rand()*r rand()*r rand()*r rand()*r rand()*r];
                A=    [rand()*r rand()*r rand()*r rand()*r rand()*r];
                alpha=[rand()*r rand()*r rand()*r rand()*r rand()*r];
                warning("Distribution not recognized. Using default distribution. (uniform)");
        end

        l1=Link([0 D(1) A(1) alpha(1)]);
        l2=Link([0 D(2) A(2) alpha(2)]);
        l3=Link([0 D(3) A(3) alpha(3)]);
        l4=Link([0 D(4) A(4) alpha(4)]);
        l5=Link([0 D(5) A(5) alpha(5)]);
        l6=Link([0 D(6) A(6) alpha(6)]);
        m=SerialLink([l1,l2,l3,l4,l5,l6]);
        robotFeature=[D,A,alpha];
    end
end