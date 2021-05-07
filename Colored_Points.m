function [XOYPot] = Colored_Points()
% 新建一个函数，运行这个函数后可以得到这4800个点所代表的周期轨道类型，并用
% 不同的颜色标注出在Xinit,Dyinit二维平面图上
% 函数名叫Colored_Points

% 时间单位m
Tu = 6.5e6;
% 长度单位s
Lu = 1.1e5;
% 确定二维图形的x坐标和y坐标范围取点数为60 x 80
% x最大值为30km
xMax = 30;

% dy最大值为40cm/s
yMax = 40;    

% 用一个n行4列的矩阵来存储x坐标，y坐标以及对应周期，速度变化量cm/s
% Row = xLabel*yLabel;

XOYPot = zeros(1,5);
Row = 1;
% 初始仿真时间设置为0，结束仿真时间设置为T_term 假设整个周期最长为20天

% 仿真持续时间20天
t_term = 100*24*3600/Tu;



% 注意，此处要排除Xinit = 0 的点，因为在该点位置与小天体碰撞了
for Xinit = -xMax:0.1:xMax
    if Xinit == 0; continue;
    end
    for Dyinit = -yMax:0.1:yMax

        
        % 对于坐标为x0,Dy0的点先对单位进行归一化
        x0 = 1000*Xinit/Lu;
        Dy0 = Dyinit/100/(Lu/Tu);
        
        % 用ode45工具对方程进行积分，确定积分步长及其意义
        X0 = [x0,0,0,0,Dy0,0];
        
        
        % 将仿真时间段进行单位化
        op = odeset('Events',@EventFun);
        [t,x,Tend,Xend,evenum] = ode45(@DynamicEq02,[0,t_term],X0,op);
        
        Xhalf = x(end,:);
        
        
        % 还原时间单位为天
        Time_Needed = 2*Tend(end)*Tu/3600/24;
        % 还原速度单位为米每秒
        Dx = Xhalf(4)*Lu/Tu;
        
        
        XOYPot(Row,1) = Xinit;
        XOYPot(Row,2) = Dyinit;
        XOYPot(Row,3) = Time_Needed;
        XOYPot(Row,4) = Dx;
        % xtermal
        XOYPot(Row,5) = Xhalf(1)*Lu;
        Row = Row+1;
        Row
    end
end


% x_init = -xLabel/2 :10000: xLabel/2;
% dy_init= -yLabel/2 :10: yLabel/2;
% [Xinit,Dyinit] = meshgrid(x_init,dy_init);


end


