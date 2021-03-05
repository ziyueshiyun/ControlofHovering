function  dX  = DynamicEq(t,X)
%DynamicEq 探测器动力学方程，x(m)为小天体固连坐标系下的状态，t为时间（占位）
%当前函数主要算未施加控制的动力学

mu = 5.2826e+05;
w = 2*pi/36000;
t0 = Torigin(18000,8000,7000,mu,w);
%dX的1到3行对应x的4到6行，就是位置的一阶导对应速度
% V = X(4:6);
x = X(1);
y = X(2);
z = X(3);
dx = X(4);
dy = X(5);
dz = X(6);
t1 = Tdb(x,y,z,mu);
%x4 = 2*w*x(5) -(mu*x)/(x^2 + y^2 + z^2)^(3/2)
% dx = X(4);
% dy = X(5);
% dz = X(6);
d2x = 2*w*dy -(mu*x)/(x^2 + y^2 + z^2)^(3/2) + w^2*x + t0(1) +t1(1);
d2y = -(mu*y)/(x^2 + y^2 + z^2)^(3/2) -2*w*dx + w^2*y+t0(2) + t1(2);
d2z = -(mu*z)/(x^2 + y^2 + z^2)^(3/2)+t0(3) + t1(3);

dX = [dx dy dz d2x d2y d2z]';

end


