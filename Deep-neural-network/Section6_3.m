
load train1
resB=resB';
resM=resM';

gpuDevice(1)
section6_3_R3_1 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_R3_1.trainParam.epochs = 400;
section6_3_R3_1.trainParam.max_fail=400;
section6_3_R3_1.output.processFcns={'fixunknowns'}
section6_3_R3_1.input.processFcns={'fixunknowns'}
section6_3_R3_1.performFcn='mse'

[section6_3_R3_1,tr] = train(section6_3_R3_1,resM,resB,'useGPU','yes');
save('section6_3_R3_1.mat','net','tr','-v7.3')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load train05
resB=resB';
resM=resM';

gpuDevice(1)
section6_3_R3_05 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_R3_05.trainParam.epochs = 400;
section6_3_R3_05.trainParam.max_fail=400;
section6_3_R3_05.output.processFcns={'fixunknowns'}
section6_3_R3_05.input.processFcns={'fixunknowns'}
section6_3_R3_05.performFcn='mse'

[section6_3_R3_05,tr] = train(section6_3_R3_05,resM,resB,'useGPU','yes');
save('section6_3_R3_05.mat','net','tr','-v7.3')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load train011323
resB=resB';
resM=resM';
resB=resB(5293:5293+1322,:);

gpuDevice(1)
section6_3_R3_01_1323 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_R3_01_1323.trainParam.epochs = 400;
section6_3_R3_01_1323.trainParam.max_fail=400;
section6_3_R3_01_1323.output.processFcns={'fixunknowns'}
section6_3_R3_01_1323.input.processFcns={'fixunknowns'}
section6_3_R3_01_1323.performFcn='mse'

[section6_3_R3_01_1323,tr] = train(section6_3_R3_01_1323,resM,resB,'useGPU','yes');
save('section6_3_R3_01_1323.mat','net','tr','-v7.3')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load train01
resB=resB';
resM=resM';


gpuDevice(1)
section6_3_R3_01 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_R3_01.trainParam.epochs = 400;
section6_3_R3_01.trainParam.max_fail=400;
section6_3_R3_01.output.processFcns={'fixunknowns'}
section6_3_R3_01.input.processFcns={'fixunknowns'}
section6_3_R3_01.performFcn='mse'

[section6_3_R3_01,tr] = train(section6_3_R3_01,resM,resB,'useGPU','yes');
save('section6_3_R3_01.mat','net','tr','-v7.3')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load train013087
resB=resB';
resM=resM';
resB=resB(5293:5293+3086,:);

gpuDevice(1)
section6_3_R3_01_3086 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_R3_01_3086.trainParam.epochs = 400;
section6_3_R3_01_3086.trainParam.max_fail=400;
section6_3_R3_01_3086.output.processFcns={'fixunknowns'}
section6_3_R3_01_3086.input.processFcns={'fixunknowns'}
section6_3_R3_01_3086.performFcn='mse'

[section6_3_R3_01_3086,tr] = train(section6_3_R3_01_3086,resM,resB,'useGPU','yes');
save('section6_3_R3_01_3086.mat','net','tr','-v7.3')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load trainSO3pi33

resB=resB';
resM=resM';

gpuDevice(1)
section6_3_SO3_pi33 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_SO3_pi33.trainParam.epochs = 400;
section6_3_SO3_pi33.trainParam.max_fail=400;
section6_3_SO3_pi33.output.processFcns={'fixunknowns'}
section6_3_SO3_pi33.input.processFcns={'fixunknowns'}
section6_3_SO3_pi33.performFcn='mse'

[section6_3_SO3_pi33,tr] = train(section6_3_SO3_pi33,resM,resB,'useGPU','yes');
save('section6_3_SO3_pi33','net','tr','-v7.3')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load trainSO3pi125

resB=resB';
resM=resM';


gpuDevice(1)
section6_3_SO3_pi125 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_SO3_pi125.trainParam.epochs = 400;
section6_3_SO3_pi125.trainParam.max_fail=400;
section6_3_SO3_pi125.output.processFcns={'fixunknowns'}
section6_3_SO3_pi125.input.processFcns={'fixunknowns'}
section6_3_SO3_pi125.performFcn='mse'

[section6_3_SO3_pi125,tr] = train(section6_3_SO3_pi125,resM,resB,'useGPU','yes');
save('section6_3_SO3_pi125','net','tr','-v7.3')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load trainSO3pi1

resB=resB';
resM=resM';


gpuDevice(1)
section6_3_SO3_pi1 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_SO3_pi1.trainParam.epochs = 400;
section6_3_SO3_pi1.trainParam.max_fail=400;
section6_3_SO3_pi1.output.processFcns={'fixunknowns'}
section6_3_SO3_pi1.input.processFcns={'fixunknowns'}
section6_3_SO3_pi1.performFcn='mse'

[section6_3_SO3_pi1,tr] = train(section6_3_SO3_pi1,resM,resB,'useGPU','yes');
save('section6_3_SO3_pi1','net','tr','-v7.3')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load train5R31

resB=resB';
resM=resM';


gpuDevice(1)
section6_3_5R3_1 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_5R3_1.trainParam.epochs = 400;
section6_3_5R3_1.trainParam.max_fail=400;
section6_3_5R3_1.output.processFcns={'fixunknowns'}
section6_3_5R3_1.input.processFcns={'fixunknowns'}
section6_3_5R3_1.performFcn='mse'

[section6_3_5R3_1,tr] = train(section6_3_5R3_1,resM,resB,'useGPU','yes');
save('section6_3_5R3_1','net','tr','-v7.3')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load train5R305

resB=resB';
resM=resM';


gpuDevice(1)
section6_3_5R3_05 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_5R3_05.trainParam.epochs = 400;
section6_3_5R3_05.trainParam.max_fail=400;
section6_3_5R3_05.output.processFcns={'fixunknowns'}
section6_3_5R3_05.input.processFcns={'fixunknowns'}
section6_3_5R3_05.performFcn='mse'

[section6_3_5R3_05,tr] = train(section6_3_5R3_05,resM,resB,'useGPU','yes');
save('section6_3_5R3_05','net','tr','-v7.3')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load train5SO3pi5

resB=resB';
resM=resM';


gpuDevice(1)
section6_3_5SO3_p5 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_5SO3_p5.trainParam.epochs = 400;
section6_3_5SO3_p5.trainParam.max_fail=400;
section6_3_5SO3_p5.output.processFcns={'fixunknowns'}
section6_3_5SO3_p5.input.processFcns={'fixunknowns'}
section6_3_5SO3_p5.performFcn='mse'

[section6_3_5SO3_p5,tr] = train(section6_3_5SO3_p5,resM,resB,'useGPU','yes');
save('section6_3_5SO3_p5','net','tr','-v7.3')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load train5SO3pi33

resB=resB';
resM=resM';


gpuDevice(1)
section6_3_5SO3_p33 = feedforwardnet([150 150 150 150],'trainrp');
section6_3_5SO3_p33.trainParam.epochs = 400;
section6_3_5SO3_p33.trainParam.max_fail=400;
section6_3_5SO3_p33.output.processFcns={'fixunknowns'}
section6_3_5SO3_p33.input.processFcns={'fixunknowns'}
section6_3_5SO3_p33.performFcn='mse'

[section6_3_5SO3_p33,tr] = train(section6_3_5SO3_p33,resM,resB,'useGPU','yes');
save('section6_3_5SO3_p33','net','tr','-v7.3')