[x,y] = meshgrid(-5:.5:10);
z=cos(x-y)+sin(x+y)+cos(exp(y));

figure
mesh(z)