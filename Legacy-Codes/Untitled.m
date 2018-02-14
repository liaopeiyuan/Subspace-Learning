D=10*round(rand(1,6),3);
        A=10*round(rand(1,6),3);
        alpha=zeros(1,6);
        r1=rand(1,6)*10;
        %r2=rand(1,5)*10;
        r3=rand(1,6)*10;
        logic = 0;
        for i = 1:5
            if and(r1(i)>3, logic==0)
                D(i)=0;
                A(i)=0;
                D(i+1)=0;
                A(i+1)=0;
                alpha(i)=0;
                logic=1;
            end
            
            %if 6>r3(i)>3
            %    alpha(i)=pi/2;
            %elseif r3(i)>6
            %    alpha(i)=-pi/2;
            %end

        end
        lt=[0 0 0 0 0 0];
        %lD=50*round(rand(1,5),3);
        %lA=50*round(rand(1,5),3);
        %lD(round(rand(1)*5))=0;
        %la=pi+pi/2*-(rand(1,5));

        %Creating the SerialLink object
        for j = 1:6
            L(j)=Link([0 D(j) A(j) alpha(j)]);
        end

        intm = 0;
        Mani=SerialLink(L);