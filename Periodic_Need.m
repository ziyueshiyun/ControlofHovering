function [T] = Periodic_Need(Theta,Dyinit,R)
%Periodic_Need 计算运行一个周期所需要的时间
%   输入默认距离R = 5km Theta 和角度Dyinit,输出轨道周期
% 初始设定探测器到小行星的距离都是5km
Rinit = R;
% 时间单位m
Tu = 6.5e6;
% 长度单位s
Lu = 1.1e5;

Theta_size = size(Theta,2);
Dyinit_size = size(Dyinit,2);
T = zeros(Theta_size,Dyinit_size);
% 仿真持续时间为100天
t_term = 100*24*3600/Tu;
Time = 0;
for i = 1:Theta_size
    for j = 1:Dyinit_size
        Xinit = Rinit*cos(Theta(i)/180*pi);
        Zinit = Rinit*sin(Theta(i)/180*pi);
        x0 = 1000*Xinit/Lu;
        z0 = 1000*Zinit/Lu;
        Dy0 = Dyinit(j)/100/(Lu/Tu);
        X0 = [x0,0,z0,0,Dy0,0];
        op = odeset('Events',@EventFun);
        [t,x,Tend,~,~] = ode45(@DynamicEq02,[0,t_term],X0,op);
        %注意这里的时间T实际只是旋转半个周期的所需要时间
        T(i,j) = Tend(end)*Tu/3600/24;
        distance = (x(end,1)^2 + x(end,3)^2)^(1/2)*Lu;
        if distance < 500 || T(i,j) <0.01
            T(i,j) =0;  %剔除逃逸的撞上的等不合格周期轨道
        end
        Time = Time+1;
        Time
    end
end
T = T';
end



