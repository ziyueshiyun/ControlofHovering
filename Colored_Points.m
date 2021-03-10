function [XOYPot] = Colored_Points()
% 新建一个函数，运行这个函数后可以得到这4800个点所代表的周期轨道类型，并用
% 不同的颜色标注出在Xinit,Dyinit二维平面图上
% 函数名叫Colored_Points

Tu = 6.5e6;
Lu = 1.1e5;
% 确定二维图形的x坐标和y坐标范围取点数为60 x 80
% 其中x坐标代表初始x坐标，单位为km y坐标代表初始y速度，单位为cm/s
xLabel = 60;
yLabel = 80;

% 用一个4800行4列的矩阵来存储x坐标，y坐标以及对应周期，速度变化量cm/s
Row = xLabel*yLabel;

XOYPot = zeros(xLabel*yLabel,4);
% 初始仿真时间设置为0，结束仿真时间设置为T_term 假设整个周期最长为40天

% 仿真持续时间为半个周期长度
t_term = 20*24*3600/Tu;

% 每个点使用ode45函数所生成的矩阵行数
% OdeRow = t_term / 0.001;

        
for Xinit = -xLabel/2 : xLabel/2
    for Dyinit = -yLabel/2 : yLabel/2
        
        % 对于坐标为x0,Dy0的点
        x0 = Xinit/Lu;
        Dy0 = Dyinit/100/Lu/(1/Tu);
        
        % 用ode45工具对方程进行积分，确定积分步长及其意义
        X0 = [x0,0,0,0,Dy0,0];
        
        
        % 将仿真时间段进行单位化
        [t,x] = ode45(@DynamicEq02,[0 t_term],X0);
        
        [Xhalf,Time_Needed] = Grid_Search(x,t);
        
        % 还原时间单位为天
        Time_Needed = 2*Time_Needed*Tu/3600/24;
        % 还原速度单位为秒
        Dy = Xhalf(5)*Lu/Tu;
        XOYPot(Row,1) = Xinit;
        XOYPot(Row,2) = Dyinit;
        XOYPot(Row,3) = Time_Needed;
        XOYPot(Row,4) = Dy;
        Row = Row-1;
    end
end


end


