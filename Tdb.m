function T = Tdb(x,y,z,PosInit)
%对于给定的悬停高度h0，当探测器的实际高度大于悬停高度h0时，施加控制力使探测
%降低，反之则施加相反的控制力,利用此函数求出控制加速度
%此处我们先选取悬停点的坐标为18km 8km 7km处 后面可根据需要增减函数功能
mu = 5.2805e+05;
 w = 2*pi/36000;
x0 = PosInit(1);
y0 = PosInit(2);
z0 = PosInit(3);
% t0 = Torigin(x0,y0,z0,mu,w);%标称加速度
dh = 10;
Tm = 1;%系数大小
h0 = (x0^2 + y0^2 + z0^2)^(1/2);
hx = (x^2 + y^2 + z^2)^(1/2);
[V,D] =eig(New_Hm(x0,y0,z0,mu));
%[V,D] =eig(HM(x0,y0,z0,mu));
% t0 = Gravitional_Potential(x0,y0,z0);
% r=[x y z];
% g=r/norm(r);
if(h0-hx > dh)
   T = Tm*V(:,3);
elseif(h0 -hx < -dh)
   T = -Tm*V(:,3);
else
   T = [0 0 0]';
end


