load train
resB=resB';
resM=resM';
resB=resB(1:1323,:);


for i=6:17
[net,tr] = train(net,resM,resB);
save(strcat(num2str(i),'.mat'),'net','tr','-v7.3')
end