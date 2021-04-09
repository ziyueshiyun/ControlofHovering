function T = IATNS(x,y,z,PosInit)
%对于给定的悬停高度h0，当探测器的实际高度大于悬停高度h0时，施加控制力使探测
%降低，反之则施加相反的控制力,利用此函数求出控制加速度
%此时使用第二种控制推力，在a0方向一致

%引力常数
mu = 5.2826e+05;

%小行星自转加速度
w = 2*pi/36000;

% 探测器初始位置
x0 = PosInit(1);
y0 = PosInit(2);
z0 = PosInit(3);
% t0 = Torigin(x0,y0,z0,mu,w);%标称加速度
dh = 10;
Tm = 1;%系数大小
h0 = (x0^2 + y0^2 + z0^2)^(1/2);
hx = (x^2 + y^2 + z^2)^(1/2);

t0 = Torigin(PosInit(1),PosInit(2),PosInit(3),mu,w);
a0 = -t0/norm(t0);

% r=[x y z];
% g=r/norm(r);
% 
if(h0-hx > dh)
   T = (-Tm*a0)';
elseif(h0 -hx < -dh)
   T = (Tm*a0)';
else
   T = [0 0 0]';
end


