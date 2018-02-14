for i=1:50
    z=1;
    data{i}=resM(z:z+1000,:)';
    label{i}=resB(z:z+1000,:)';
    z=z+1000;
end