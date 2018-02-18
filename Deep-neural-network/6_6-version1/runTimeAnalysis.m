% Run time analysis 
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
trainFeature=resM;
final=zeros(7,50);
sampleSize=50;
for j=1:4
tDNN=zeros(1,sampleSize);
net=n{j};
for i=1:sampleSize
    tic;
    rawNetData=net(trainFeature(i,:)');
    rND=ptFilter(rawNetData,0.5);
    a{i}=postProcessing(trainFeature(i,:),[zeros(1,1323*(i-1)),rND',zeros(1,1323*(7-i))],'visualization',false);
    tDNN(i)=toc;
end
plot(tDNN)
final(i,:)=tDNN;
hold on
end
%{
tClassical=zeros(1,sampleSize);
for i=1:sampleSize
    tic;
    b{i}=discretizedWorkspace(trainFeature(i,:));
    tClassical(i)=toc;
end
hold on
semilogy(1:sampleSize,tClassical,'lineWidth',2)
%}

