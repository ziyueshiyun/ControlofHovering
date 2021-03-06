%时间单位化为TU = 1/n
%长度单位化为LU = (u/n^2)^(1/3);
% T = 2*pi*6.5e6/365/24/3600;
% TU ≈ 6.5e6s LU ≈ 1.1e5m;

Tu = 6.5e6;
Lu = 1.1e5;
% 如果在xz平面上的起始位置被设定为（x0,0,z0)
% 然后对应的初始速度设定为(0,y'0,0)

%x 初始位置
Xinit = 10000;
%y 初始速度
DYinit = 5;
% 取初始位置坐标为(10000m,0,0) , 初始速度为(0,5cm/s,0)
% 进行积分计算，当y坐标第一次变为0时刻即为半个周期的长度
% 此时的x'即为需要施加的脉冲速度大小


% 对初始位置和速度进行单位化操作
% 即是初始位置坐标为(,0,0) , 初始速度为(0,,0)

x0 = Xinit/Lu;
Dy0 = DYinit/100/Lu/(1/Tu);

% 用ode45工具对方程进行积分，确定积分步长及其意义
X0 = [x0,0,0,0,Dy0,0];

% 初始仿真时间设置为0，结束仿真时间设置为T_term 假设半个周期最长为20天
t_term = 20*24*3600/Tu;
% 将仿真时间段进行单位化
% [t,x] = ode45(@DynamicEq02,[0,t_term],X0);
% plot(x(:,1),x(:,2));

% 发现Y坐标第一次变为0的时间为第76个步长时刻，即为0.001 * 76 * Tu
% T01 = 0.001 * 76 * Tu * 2/24/3600 = 11.4352天
% 即当取初始位置坐标为(10000m,0,0) , 初始速度为(0,5cm/s,0)时，
% 轨道的周期长度为11.4天左右，此时刻探测器的x轴坐标速度为4.1301
% 进行还原即可得到
% v = 4.1301 * Lu/Tu = 0.0699m/s
% 也就是说所需要的速度大小仅仅为7cm/s，方向与x轴方向相反

%测试一下X(2)所代表的意义
% A = [1 2 3;
%      4 5 6;
%      7 8 9]
%  B = A(2)

% 根据画图得到的结果，毫无疑问前面的步骤都是正确的
% 现在需要解决的问题是怎样获知y坐标第一次变为0的时刻及此时刻的x坐标速度
% 可以设计一个函数来解决多个文件的问题
% 输入为n张表格，输出为每个表格所对应的初始位置，初始速度，终点位置，终点速度
% 等，一张1330x6的表格大小大约为41kb , 进行网格化搜索大概需要绘制60*80 = 4800
% 张表格，所需要的内存最大也只能为196Mb,也可以每次进行搜索位置后将该表格删除
% 可以节省一些内存空间

% 新建一个函数，运行这个函数后可以得到这4800个点所代表的周期轨道类型，并用
% 不同的颜色标注出在Xinit,Dyinit二维平面图上
% 函数名叫Colored_Points

% 为何在Colored_Points里面部分数据出现积分误差过大的情况
% 再试试用同样的方法，不适用Colored_Points所积分得到的结果

% 1.试验meshgrid产生的是什么向量？
% x1 = 0:6;
% x2 = 1:4;
%
% [X1,X2] = meshgrid(x1,x2);

% 产生的X1 , X2 均为4 x 7的矩阵 即假如x1 = 1xn向量
% x2 = 1xm 向量 则 X1 = mxn向量 X2 = mxn向量
% 不同的是，X1的每一行都是x1 X2的每一列都是x2'
% 而X1 Y1的相对坐标恰好组成了mxn个点的横纵坐标

% 开始进行绘图工作，从最简单的规则开始，在xoy平面中用不同颜色的点来标注
% 各个不同的初始条件下所产生的周期轨道的特征
% %

% %起始x坐标
% a0 = Colored_Points;
% x = a0(:,1);
%
% %起始y坐标
% dyi = a0(:,2);
%
% %轨道周期天
% T = a0(:,3);
%
% %半周期后速度
% dy = a0(:,4);
%
% %半周期后x位置
% xt = a0(:,5);
% % figure
% % plot(x,dy,'k.')
% % 决定改用scatter
%
% scatter(x,dyi,dyi)

%如何绘制对称图形？
FormerHalf = x(1:64,:);
LaterHalf = -x(1:64,2);
LH = FormerHalf;
LH(:,2) = LaterHalf;
Result = cat(1,FormerHalf,LH);
% plot(Result(:,1),Result(:,2));
plot(x(1:64,1),x(1:64,2));
hold on;
plot(LH(1:64,1),LH(1:64,2));


% Orbit_Result = Colored_Points;
% 可能是积分步长出现了问题，需要对积分步长也进行归一化
% 同时需要加入事件函数，加入停止积分条件，即y第一次等于0
% 也可以使用y第一次变号的位置

op = odeset('Events',@EventFun);
[t,x,Tend,Xend,evenum] = ode45(@DynamicEq02,[0,t_term],X0,op);
x1 = x(:,1);
y1 = x(:,2);
z1 = x(:,3);
scatter(x1,y1);

Orbit_Result = Colored_Points;

% 对轨道类型进行分类
Row = size(Orbit_Result,1);

% 无法形成周期轨道的点
New_Results = zeros(1,5);
Other_Results = zeros(1,5);
% 首先剔除时间小于0.01天的轨道，那些都是无法在二十天内
% 环绕半圈后使得y再次变为0的轨道
icount = 1;
kcount = 1;
for i = 1:Row
    if Orbit_Result(i,3)>0.01 && abs(Orbit_Result(i,5))>500
        New_Results(icount,:) = Orbit_Result(i,:);
        icount  = icount +1;
    else
        Other_Results(kcount,:) = Orbit_Result(i,:);
        kcount = kcount+1;
    end
end

% x1 = New_Results(:,1);
% y1 = New_Results(:,2);
% Time = New_Results(:,3);
% Terminal_Speed = New_Results(:,4);
% X_Terminal = New_Results(:,5);



% Xinit > 0 , Xterm < 0,dy > 0 顺行心形轨道
Pho = zeros(1,5);
Pho_Num = 1;
% Xinit > 0 , Xterm < 0,dy < 0 逆行心形轨道
Rho = zeros(1,5);
Rho_Num = 1;
% Xinit < 0,  Xterm > 0,dy > 0 逆行泪形轨道
Rto = zeros(1,5);
Rto_Num = 1;
% Xinit < 0,  Xterm > 0,dy < 0 顺行泪形轨道
Pto = zeros(1,5);
Pto_Num = 1;
% Xinit < 0,  Xterm < 0  白天轨道
Do = zeros(1,5);
Do_Num = 1;
% Xinit > 0,  Xterm > 0  夜间轨道
No = zeros(1,5);
No_Num = 1;
% 其他轨道？
jcount = size(New_Results,1);

for j = 1:jcount
    if New_Results(j,1) >0 && New_Results(j,5)<0 && New_Results(j,2)>0
        Pho(Pho_Num,:) = New_Results(j,:);
        Pho_Num = Pho_Num + 1;
    elseif New_Results(j,1) >0 && New_Results(j,5)<0 && New_Results(j,2)<0
        Rho(Rho_Num,:) = New_Results(j,:);
        Rho_Num = Rho_Num + 1;
    elseif New_Results(j,1) < 0 && New_Results(j,5)>0 && New_Results(j,2)>0
        Rto(Rto_Num,:) = New_Results(j,:);
        Rto_Num = Rto_Num +1;
    elseif New_Results(j,1) < 0 && New_Results(j,5)>0 && New_Results(j,2)<0
        Pto(Pto_Num,:) = New_Results(j,:);
        Pto_Num = Pto_Num + 1;
    elseif New_Results(j,1) < 0 && New_Results(j,2)<0
        Do(Do_Num,:) = New_Results(j,:);
        Do_Num = Do_Num + 1;
    elseif New_Results(j,1) > 0 && New_Results(j,2)>0
        No(No_Num,:) = New_Results(j,:);
        No_Num = No_Num + 1;
   
        
    end

end

scatter(Pho(:,1),Pho(:,2),20,'r');
hold on;
scatter(Rho(:,1),Rho(:,2),20,'b');
hold on;
scatter(Rto(:,1),Rto(:,2),20,'g');
hold on; 
scatter(Pto(:,1),Pto(:,2),20,'k');
hold on; 
scatter(Do(:,1),Do(:,2),20,'m');
hold on; 
scatter(No(:,1),No(:,2),20,'y');
hold on;
scatter(Other_Results(:,1),Other_Results(:,2),20,'c');

% 前面仍然忽略了一个条件，就是探测器的轨迹在运行过程中，
% 一定不能撞上小天体，如何把这个限定条件加进去？

% 作图八张左右，首先Xinit = 10km Dyinit = 0
Tu = 6.5e6;
Lu = 1.1e5;
%x 初始位置
Xinit = 7000;
%y 初始速度
DYinit = -11;
x0 = Xinit/Lu;
Dy0 = DYinit/100/Lu/(1/Tu);
X0 = [x0,0,0,0,Dy0,0];
t_term = 40*24*3600/Tu;
op = odeset('Events',@EventFun);
[t,x,Tend,Xend,evenum] = ode45(@DynamicEq02,[0,t_term],X0,op);
x1 = x(:,1)*Lu/1000;
y1 = x(:,2)*Lu/1000;
z1 = x(:,3)*Lu/1000;
plot(x1,y1)
xlim([-10,50]);
hold on;

% 如何画出转回去的轨迹？
X1 = Xend(end,:);
X1(4) = -X1(4);
[t1,x1,Tend1,Xend1,evneum1] = ode45(@DynamicEq02,[0,t_term],X1,op);
x2 = x1(:,1)*Lu/1000;
y2 = x1(:,2)*Lu/1000;
z2 = x1(:,3)*Lu/1000;
plot(x2,y2)

2*t(end)*Tu/3600/24

% 开始对三维空间的周期轨道进行形成过程仿真
% 假设探测器的初始位置在xoz平面上，则探测器的初始条件
% 可以表示为(Xinit,0,Zinit,Dyinit) 
% 定义r_init = (Xinit^2 + Zinit^2)^(1/2)
% 定义Theta_init = atan(Zinit/Xinit);
% 注意：atan()生成弧度值，atand()生成角度值

ThreeD_Res = Colored_Points_3D;
% save ThreeD_Res;
x1 = ThreeD_Res(:,1);
y1 = ThreeD_Res(:,2);
z1 = ThreeD_Res(:,3);
% [X,Y,Z]=griddata(x1,y1,z1,linspace(0,180)',linspace(0,60),'v4');
% figure,contourf(X,Y,Z);
% c = abs(z1*([0 1 0])/150);
% scatter(x1,y1,20,c,'fill');

% 还需要筛除撞上小行星的点和不能形成周期轨道的点\
New_Results = zeros(100,5);
icount = 1;
row = size(x1);
for i = 1:row
    if ThreeD_Res(i,3)>0.01 && abs(ThreeD_Res(i,5))>500
        New_Results(icount,:) = ThreeD_Res(i,:);
        icount  = icount +1;
    end
end
x2 = New_Results(:,1);
y2 = New_Results(:,2);
z2 = New_Results(:,3);
[X,Y,Z]=griddata(x2,y2,z2,linspace(0,180)',linspace(-12,12),'v4');
figure,contourf(X,Y,Z);
c = abs(z2*([1 1 0])/80);
scatter(x2,y2,10,c,'fill');


-------------------------------------------------
-------------------------------------------------




% 验证三维的一个点是否稳定？
Tu = 6.5e6;
Lu = 1.1e5;
%x 初始位置
% -160度情况下，x为负，z值也为负数
Rinit = 5000;
Theta = -160/180*pi;
Xinit = Rinit*cos(Theta);
Zinit = Rinit*sin(Theta);
%y 初始速度
DYinit = 9.3;
x0 = Xinit/Lu;
z0 = Zinit/Lu;
Dy0 = DYinit/100/Lu/(1/Tu);
X0 = [x0,0,z0,0,Dy0,0];
t_term = 100*24*3600/Tu;
op = odeset('Events',@EventFun);
[t,x,Tend,Xend,evenum] = ode45(@DynamicEq02,[0,t_term],X0,op);
% 轨道周期，转换为天数
2*t(end)*Tu/3600/24
x(end,4)*Lu/Tu
x1 = x(:,1)*Lu/1000;
y1 = x(:,2)*Lu/1000;
z1 = x(:,3)*Lu/1000;
plot(x1,y1)
xlim([-10,50]);
cos




% 用画等高线图的方式改写函数Colored_Points_3D

% 角度x坐标
x = linspace(0,180,181);
% 速度y坐标
y = linspace(-12,12);
[X,Y] = meshgrid(x,y);
Z = Periodic_Need(x,y,5);

contourf(X,Y,Z',30);
    
x1 = linspace(1,10,11);
y1 = linspace(5,7,3);
[X1,Y1] = meshgrid(x1,y1);
Z1 = X1+Y1;


% 新任务，对于平面上的众多离散点，得出其弗洛伊德常数，并且对稳定和不稳定的进行绘图
% 画出平面上的稳定与不稳定区域的坐标

% 角度x坐标
x = linspace(0,180,181);
% 速度y坐标
y = linspace(-12,12);
[X,Y] = meshgrid(x,y);
Z = Is_Stable(x,y,5);
stable_area = Z;
save stable_area;
contour(X,Y,Z');