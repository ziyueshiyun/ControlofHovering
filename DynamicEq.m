function  dX  = DynamicEq(t,X,t0,t_control)
%DynamicEq 探测器动力学方程，x(m)为小天体固连坐标系下的状态，t为时间（占位）
%当前函数主要算未施加控制的动力学
%PosInit为初始位置
%mu = 5.2826e+05;
w = 2*pi/36000;
      
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
% t1 = IATNS(x,y,z,PosInit);

Potential = Gravitional_Potential(x,y,z); %计算引力加速度
d2x = 2*w*dy + Potential(1) + w^2*x + t_control(1)-t0(1);
d2y = Potential(2)-2*w*dx + w^2*y + t_control(2)-t0(2);
d2z = Potential(3)+ t_control(3)-t0(3);

% d2x = 2*w*dy + w^2*x + t1(1);
% d2y = -2*w*dx + w^2*y + t1(2);
% d2z =t1(3);

dX = [dx dy dz d2x d2y d2z]';

end


