        D=[  0 0 6 4  0 0];
        A=[  0 3 0  0 0 0];
        alpha=[ pi/2 0 -pi/2 pi/2 -pi/2 0];
        l1=Link([0 D(1) A(1) alpha(1)]);
        l2=Link([0 D(2) A(2) alpha(2)]);
        l3=Link([0 D(3) A(3) alpha(3)]);
        l4=Link([0 D(4) A(4) alpha(4)]);
        l5=Link([0 D(5) A(5) alpha(5)]);
        l6=Link([0 D(6) A(6) alpha(6)]);
        
        Mn=SerialLink([l1,l2,l3,l4,l5, l6]);
        
        