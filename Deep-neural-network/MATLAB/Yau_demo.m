feature = resM(1,:)';
feature(1:18)=[0,0,0.150050000000000,0.431800000000000,0,0,0,0.431800000000000,0.0203000000000000,0,0,0,1.57079632679490,0,-1.57079632679490,1.57079632679490,-1.57079632679490,0];
%label= [zeros(5293,1);section6_1(feature);zeros(9261-1323-5293,1)];
label=[section6_2_1(feature);section6_2_2(feature);section6_2_3(feature);section6_2_4(feature);section6_2_5(feature);section6_2_6(feature);section6_2_7(feature)];
[P,delP,xData,yData,zData]=postProcessing(feature',label');
disp(delP);


%[P,delP,xData,yData,zData]=postProcessing(feature',label',"filter",-1,"boundary",false);
%disp(delP);

