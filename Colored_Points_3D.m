function [XOYPot] = Colored_Points_3D()
% Colored_Points_3D 该函数计算三维空间内的周期轨道解空间
% 将可以形成周期轨道的点的Theta_init以及初始速度Dy_init
% 和需要的delta_V的大小存储到一个n*3列的矩阵中

% 由于探测器在z方向上运动的对称性，所以只需要计算z>0的情况
% 首先固定Rinit = 5km
% 定义cos(Theta)=x/Rinit，那么当x从5km减少到-5km时候，
% Theta恰好从0度到180度

% 设定初始条件
% 初始设定探测器到小行星的距离都是5km
Rinit = 5;

% 时间单位m
Tu = 6.5e6;
% 长度单位s
Lu = 1.1e5;

% 角度
% Theta = 0;

% dy最大值为40cm/s
yMax = 12;   

% 仿真持续时间为100天
t_term = 100*24*3600/Tu;
XOYPot = zeros(100,5);
Row = 1;
% 网格化搜索解空间
for Theta = 0:180
	for Dyinit = -yMax:0.1:yMax
		 
		% 先利用角度Theta和Rinit = 5km求出Xinit、Zinit即是x、z坐标的初始值
        % 对于坐标为x0,Dy0的点先对单位进行归一化
        Th = Theta/180*pi;
		Xinit = Rinit*cos(Th);
		Zinit = Rinit*sin(Th);
        x0 = 1000*Xinit/Lu;
		z0 = 1000*Zinit/Lu;
        Dy0 = Dyinit/100/(Lu/Tu);
        
        % 用ode45工具对方程进行积分，确定积分步长及其意义
        X0 = [x0,0,z0,0,Dy0,0];
        
        
        % 将仿真时间段进行单位化
        op = odeset('Events',@EventFun);
        [~,x,Tend,~,~] = ode45(@DynamicEq02,[0,t_term],X0,op);
        
        Xhalf = x(end,:);
        
        
        % 还原时间单位为天
        Time_Need = 2*Tend(end)*Tu/3600/24;
        % 还原速度单位为米每秒
        Dx = Xhalf(4);
        Dz = Xhalf(6);
        Dv_Need = 2*Lu*(Dx^2+Dz^2)^(1/2);
        
        XOYPot(Row,1) = Theta;
        XOYPot(Row,2) = Dyinit;
        XOYPot(Row,3) = Time_Need;
        XOYPot(Row,4) = Dv_Need;
        % xtermal
        XOYPot(Row,5) = (Xhalf(1)^2+Xhalf(3)^2)^(1/2)*Lu;
        Row = Row+1;
        Row
	end
end
end

