function [T ] = Is_Stable(Theta,Dyinit,r)
% Is_Stable 计算三维空间中某个点形成的周期轨道是否稳定
% Theta满足 cos(Theta) = x/r;
% Dyinit为探测器初始速度在y方向上的分量cm/s,也是一个行向量1xn行
% 默认在x方向和z方向的初始速度为0
% r为输入的探测器初始位置与小行星的距离km
% Theta为输入角度，为一个行向量，1~180度，记得要在后面转换为弧度

Rinit = r;
% 时间单位m
Tu = 6.5e6;
% 长度单位s
Lu = 1.1e5;
% 首先根据输入参数确定输出矩阵纬度
Theta_size = size(Theta,2);
Dyinit_size = size(Dyinit,2);
T = zeros(Theta_size,Dyinit_size);

% 利用前面的函数Periodic_Need求出轨道周期，便于后面积分运算其Floquet
% 乘数，从而判断该轨道是否稳定
% Half_Orbit_Times = Periodic_Need(Theta,Dyinit,Rinit);
% Half_Orbit_Times = Half_Orbit_Times';%注意这里需要转置一下才能使用
% save Half_Orbit_Times;
% 对满足条件的轨道，从矩阵Half_Orbit_Times获取其半周期时间
time = 0;
load('Half_Orbit_Times.mat');
for i = 1:Theta_size
    for j = 1:Dyinit_size
        if(Half_Orbit_Times(i,j) ~= 0)
            period  = Half_Orbit_Times(i,j)*24*3600/Tu;
            Xinit = Rinit*cos(Theta(i)/180*pi);
            Zinit = Rinit*sin(Theta(i)/180*pi);
            x0 = 1000*Xinit/Lu;
            z0 = 1000*Zinit/Lu;
            Dy0 = Dyinit(j)/100/(Lu/Tu);
            yn = [x0,0,z0,0,Dy0,0];
            [MonMat,~]=MonodromyMatrix(yn,2*period);
            T(i,j) = MonMat_Operate(MonMat);
            %如果T(i,j)为1就稳定，为-1就不稳定，为0就是没有周期轨道
        end
        time = time + 1;%计数
        time
    end
end

end

