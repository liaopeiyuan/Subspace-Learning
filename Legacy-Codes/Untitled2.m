D=[0 0 0 0.15 0.4318 0];
A=[0 0 0.4318 0.0203 0 0];
alpha=[pi/2 0 -pi/2 pi/2 -pi/2 0];

for j = 1:6
            L(j)=Link([0 D(j) A(j) alpha(j)]);
        end

        intm = 0;
        M=SerialLink(L);