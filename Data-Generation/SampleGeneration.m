%{
Options (the first is default):

type            '6DOF','5DOF'
workspace       'R3','SO3'
sampleDist      'uniform' 'normal'
sampleRadius    a real number
fileType        '-v7.3','-v7','-v6','-v4'
ikine           'numerical','analytic'
tensor          false,true
showcase        false,true
%}

[feature, label]=dataGenWSsubspace(10,[-1 1 -1 1 -1 1 1 1 1] ,[0 0 0],'ikine','6DOF');

