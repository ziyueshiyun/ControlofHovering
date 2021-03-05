% syms x y z c20 c22 u ae
% %V = u/r*(sqrt(x^2+y^2*(1+(ae/r)^2*(1/2 * c20*(3*z^2/r^2-1)+3*c22*(1-z^2/r^2)*(1-2*z^2/r^2)^2))
% r = sqrt(x^2+y^2+z^2);
% V = u/r*(1+(ae/r)^2*(1/2 * c20*(3*z^2/r^2-1)+3*c22*(1-z^2/r^2)*(1-2*z^2/r^2)^2));
% v1 = diff(V,x,1);
% v2 = diff(V,y,1);
% v3 = diff(V,z,1);
% v2

% [c20,c22]=SphericalHaromic(18,8,6);
% a1 = Acceleration(0,10,9,c20,c22,)
% x1 = [1 2;3 4];
% x2 = [1 2;3 4];
% z = test01(x1,x2)
% 
% myresult = Acceleration(16000,5000,4000,c20,c22,u,a);
% 
%  G=6.67259e-11;
% rho=2670;
% [A,U] = AttractionAndGravitionalPotential([16000,5000,4000],Eros433face,Eros433model,G,rho);

%读取txt文件
a = 15000;
b = 7000;
c = 6000;
[c20,c22] = SphericalHaromic(15,7,6);

dens = 3000;

%算一下小行星的质量(kg)
M = (4/3)*pi*a*b*c*dens;
%算一下引力常数u = G*M G取G=6.67259e-11;
G = 6.67259e-11;
u = G*M;

ae = 15000;

filename = '.\xyplane.txt';
[x,y,z] = textread(filename,'%f %f %f');
A = xyPlane(x,y,z,c20,c22,u,ae);
figure;
surf(x,y,A);



 






