function  dX  = DynamicEq(t,X,PosInit)
%DynamicEq 探测器动力学方程，x(m)为小天体固连坐标系下的状态，t为时间（占位）
%当前函数主要算未施加控制的动力学
%PosInit为初始位置
mu = 5.2826e+05;
w = 2*pi/36000;
%注意下面这行随初始位置改变而改变
% 
%dX的1到3行对应x的4到6行，就是位置的一阶导对应速度
% V = X(4:6);
x = X(1);
y = X(2);
z = X(3);
dx = X(4);
dy = X(5);
dz = X(6);

% 控制推力加速度大小计算函数

% Tdb代表第一种控制方式
% t1 = Tdb(x,y,z,PosInit);

% IATNS代表第二种控制方式
t1 = IATNS(x,y,z,PosInit);
%x4 = 2*w*x(5) -(mu*x)/(x^2 + y^2 + z^2)^(3/2)
% dx = X(4);
% dy = X(5);
% dz = X(6);
d2x = 2*w*dy -(mu*x)/(x^2 + y^2 + z^2)^(3/2) + w^2*x + t1(1);
d2y = -(mu*y)/(x^2 + y^2 + z^2)^(3/2) -2*w*dx + w^2*y + t1(2);
d2z = -(mu*z)/(x^2 + y^2 + z^2)^(3/2)+ t1(3);

dX = [dx dy dz d2x d2y d2z]';

end


