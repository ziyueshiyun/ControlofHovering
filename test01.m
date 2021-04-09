% 
% r = sqrt(x.*x + y.*y);

% %该点的引力位：
% V = (u./r).*(1+(ae./r).^2*(1/2 * c20*(-1)+3*c22));
% surf(x,y,V);

% x1 = [1 1 1;
%       2 2 2;
%       3 3 3];
% y1 = [1 2 3;
%       4 5 6;
%       7 8 9];
% z1 = x1 + y1;
% surf(x1,y1,z1);
% [x2,y2]  = meshgrid(-20000:200:20000);
% r = sqrt(x2.*x2+ y2.*y2);
% u = 5.2826e+5;
% %小行星椭球模型中最长半轴长，取15km;
% ae = 15000;
% c20 = -0.0898;
% c22 = 0.0391;
% %该点的引力位：
% Z = u./r.*(1+(ae./r).^2*(1/2 * c20*(-1)+3*c22));
% figure;
% surf(x2,y2,Z);

% x=rand(1,100)*4-2;
% y=rand(1,100)*4-2;
% z=x.*exp(-x.^2-y.^2);
% ti=-2:0.25:2;
% [xi,yi]=meshgrid(ti,ti);
% figure;
% subplot(121);
% zi=griddata(x,y,z,xi,yi); %采用默认的linear算法
% mesh(xi,yi,zi);
% hold on;
% plot3(x,y,z,'o');
% hold off;
% title('Linear');
% subplot(122);
% zi=griddata(x,y,z,xi,yi,'cubic'); %采用cubic算法
% mesh(xi,yi,zi);
% hold on;
% plot3(x,y,z,'o');
% hold off;
% title('Cubic');



%根据探测器相对于小天体位置求黑塞矩阵
%求出黑塞矩阵特征值特征向量
%找出与重力方向一致的v3


%取小天体模型为15km * 7km * 6km，假定小行星的密度是均匀的，设定为3g/cm^3 = 3000千克每立方米
%算出GM如下
mu = 5.2826e+05;

%这里先设小天体引力为u/r 小天体的自转角速度为10h一圈w = 2*pi/10/3600 = 1.7453e-04 
%先求一下共振半径Rs = (mu/w^2)^(1/3) = 25884m;
w = 2*pi/10/3600;
Rs = (mu/w^2)^(1/3);


%计算黑塞矩阵过程
syms mu x y z;
V = mu/sqrt(x^2 + y^2 + z^2);
HM01 = diff(V,x,1);
HM02 = diff(V,y,1);
HM03 = diff(V,z,1);

HM11 = diff(HM01,x,1);
HM22 = diff(V,y,2);
HM33 = diff(V,z,2);

HM13 = diff(HM01,z,1);
HM12 = diff(HM01,y,1);
HM23 = diff(HM02,z,1);


% %将符号运算结果存储到一个符号矩阵SHM中
% SHM = sym(zeros(3,3));
% SHM(1,1) =  HM11;
% SHM(1,2) =  HM12;
% SHM(1,3) =  HM13;
% SHM(2,1) =  HM12;
% SHM(2,2) =  HM22;
% SHM(2,3) =  HM23;
% SHM(3,1) =  HM13;
% SHM(3,2) =  HM23;
% SHM(3,3) =  HM33;
% % function HM = PosToHM(x,y,z,MU)
% % end
% save SHM




% function [T] = HM(x,y,z,mu)
% %编写一个函数，输入量为小天体外一点的位置坐标，输出为该点的3x3黑塞矩阵
% %为了求后面的特征向量和特征值
% T = zeros(3,3);
% T(1,1) = (3*mu*x^2)/(x^2 + y^2 + z^2)^(5/2) - mu/(x^2 + y^2 + z^2)^(3/2);
% T(1,2) = (3*mu*x*y)/(x^2 + y^2 + z^2)^(5/2);
% T(1,3) = (3*mu*x*z)/(x^2 + y^2 + z^2)^(5/2);
% T(2,1) = T(1,2);
% T(2,2) = (3*mu*y^2)/(x^2 + y^2 + z^2)^(5/2) - mu/(x^2 + y^2 + z^2)^(3/2);
% T(2,3) = (3*mu*y*z)/(x^2 + y^2 + z^2)^(5/2);
% T(3,1) = T(1,3);
% T(3,2) = T(2,3);
% T(3,3) = (3*mu*z^2)/(x^2 + y^2 + z^2)^(5/2) - mu/(x^2 + y^2 + z^2)^(3/2);
%    
% end

%编写一个函数，输入为一个3x3的矩阵，输出三个特征值和三个特征向量
%matlab自带函数？

%先测试一下matlab自带的求特征值和特征向量的函数[V,D] = eig(A);
A = [1 -3 3; 3 -5 3;6 -6 4];
[V1,D1] = eig(A);

%对于这6476个位置的特征值和特征向量进行分析
 for k = 1:20
    disp(k)
 end

%先看看xy平面上的点的特征值特点
CHofxy = EDofPoints(x01,y01,z01);


%继续测试测试
B = zeros(4,2);
b1 = [1 1; 1 1];
b2 = [2 2; 2 2];
B(1:2,:) = b1;
B(3:4,:) = b2;
l1 = 1:2:10-3;

%从前面的结果中，发现，前面两个特征值的大小相等，都是负数，第三个特征值正数
%是不是因为取点都在xoy平面上造成的呢，现在试试xoz平面上的点
%即x02 y02 z02
%在xoz平面上生成一组在椭球外的点的坐标，保存在x02,y02,z02中

%现在再看看yoz平面上的点的情况
Chofyz = EDofPoints(yzPos(:,1),yzPos(:,2),yzPos(:,3));


%从现在开始转入控制部分，要求当探测器的高度超过h0，施加-Ta0，当探测器的高度
%低于h0,施加Ta0;

%首先，训练一下微分方程组的积分问题
% dsolve('Dy = 3*x*x','x')
% 
% syms y(t)
% eqn = diff(y) == y+exp(-y);
% % sol = dsolve(eqn)
% sol = dsolve(eqn,'Implicit',true)

%编写ode句柄函数，当航天器的位置低于目标高度时，使用OdeLow
%当航天器的位置高于目标高度时，使用OdeHigh


%先测试一下在未施加控制的情况下的探测器运动情况
%初始位置设置为18km,8km,7km, 初始速度设置0m/s , 3m/s , 3m/s
%初始位置误差设置为400m,300m,200m
x0 = [18050,8050,7050,0,0.3,0.3];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:1600],x0);
plot3(x(:,1),x(:,2),x(:,3));
%先算出18km 8km 7km处的T0
%t0 = Torigin(18000,8000,7000,mu,w);
% hold on;
x1 = x(:,1);
x2 = x(:,2);
x3 = x(:,3);
z = (x1.^2 + x2.^2+x3.^2).^(1/2);
plot(t,z);
title('高度时间变化曲线');
xlabel('时间t/s');
ylabel('高度h/m');

plot(t,x1,t,x2,t,x3);
title('x,y,z坐标时间变化曲线');
xlabel('时间t/s');
ylabel('x/m');


% %画一个三轴椭球在空间坐标系中
% 
% ellipsoid(0,-0.5,0,15,7,6)
% axis equal
% 
% tiledlayout(2,2);
% ax3 = nexttile;
% ellipsoid(ax3,0,0,0,2,1,1,80)
% axis equal
% title('80-by-80 faces')

%寻找xoy平面上的点，满足黑塞矩阵的值
%新任务，寻找并稳定区域并且绘图

% 条件19
Rn = 1.26:0.01:3;
Zn = ((-2+Rn.^3)./Rn).^(1/2);
plot(Rn,Zn);
hold on;
% 条件20
Rn = 0.5:0.01:3;
Zn = 1./Rn;
plot(Rn,Zn);

hold on;
% 条件20
Rn = 1;
Zn = 0:0.01:3;
plot(Rn,Zn);
hold on;
% 条件21.1
Rn = 4^(1/3);
plot(Rn,Zn);
hold on;
% 条件21.2 Rn >= 1.5874;
Rn = 1.59:0.01:3;
Zn = ((5.*Rn.^3-8+((5.*Rn.^3-8).^2-9.*Rn.^6).^(1/2))./9.*Rn).^(1/2);
plot(Rn,Zn);
hold on;
% 条件21.3
Zn = ((5.*Rn.^3-8-((5.*Rn.^3-8).^2-9.*Rn.^6).^(1/2))./9.*Rn).^(1/2);
plot(Rn,Zn);

% 寻找满足上述条件的特例，在xoz平面上

% x = 13697 y=0 Z = 15530
x0 = [13697,0,15530,0,0.1,0.1];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:1200],x0);
plot3(x(:,1),x(:,2),x(:,3));

%时间高度变化曲线
x1 = x(:,1);
y1 = x(:,2);
z1 = x(:,3);
h = (x1.^2+y1.^2+z1.^2).^(1/2);
plot(t,h,'r');
xlabel('时间t/s');
ylabel('高度h/m');

plot(t,x1,'r')
xlabel('时间t/s');
ylabel('x位置/m');

plot(t,y1,'g')
xlabel('时间t/s');
ylabel('x位置/m');

plot(t,z1,'k')
xlabel('时间t/s');
ylabel('x位置/m');

------------------------------------------------------
%注意要同步修改Tdb里面的初始位置，这个函数没时间修改了，先凑合用一下
% x = 13697 y=0 Z = 15530
x0 = [13697,0,15530,0,0.3,0.3];
pos_init = [13697,0,15530];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:50000],x0,[],pos_init);
plot3(x(:,1),x(:,2),x(:,3));


%改变初始位置和速度再试试看
x0 = [25229,0,18119,0,3,3];
pos_init = [25229,0,18119];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:24000],x0,[],pos_init);
plot3(x(:,1),x(:,2),x(:,3));

%时间高度变化曲线
x1 = x(:,1);
y1 = x(:,2);
z1 = x(:,3);
h = (x1.^2+y1.^2+z1.^2).^(1/2);
plot(t,h,'r');
xlabel('时间t/s');
ylabel('高度h/m');

plot(t,x1,'r')
xlabel('时间t/s');
ylabel('x位置/m');

plot(t,y1,'g')
xlabel('时间t/s');
ylabel('x位置/m');

plot(t,z1,'k')
xlabel('时间t/s');
ylabel('x位置/m');

% 测试推力系数的大小尺度
% x = 13697 y=0 Z = 15530
% X_test = 13697;
% Y_test = 0;
% Z_test = 15530;
% [V_Test,T_Test] = eig(HM(X_test,Y_test,Z_test,mu));
% 算出来大概V3向量大小约等于1


% 测试大概取0.7倍共振半径来看看先
% xoz平面上的点 
% 25884 * 0.7 = 18119m
% x^2 + z^2 = 18119m 且 x^2/15km^2 + z^2/6km^2 >1
% 12814^2/15000^2 + 12814^2/6000^2 = 5.2908

%改变初始位置和速度再试试看
x0 = [12184,12814,0,0,0.3,0.3];
pos_init = [12184,12814,0];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:50000],x0,[],pos_init);


%时间高度等变化曲线
x1 = x(:,1);
y1 = x(:,2);
z1 = x(:,3);
% 三维曲线
plot3(x1,y1,z1);


% 时间高度曲线
h = (x1.^2+y1.^2+z1.^2).^(1/2);
plot(t,h,'r');
xlabel('时间t/s');
ylabel('高度h/m');

plot(t,x1,'r')
xlabel('时间t/s');
ylabel('x位置/m');


plot(t,y1,'g')
xlabel('时间t/s');
ylabel('x位置/m');

plot(t,z1,'k')
xlabel('时间t/s');
ylabel('x位置/m');

% % 如何绘制三维动态曲线？
% for i = 1::10*pi
%     hold on;
%     plot3(cos(i),sin(i),i,'--ro')
%     i = i+1;
%     pause(0.5);
% end
for i = 1:10:50000
    hold on;
    plot3(x1(i),y1(i),z1(i),'--r');
    pause(0.01);
end


%重新使用当初在共振半径范围内的点
%初始位置设置为18km,8km,7km, 初始速度设置0m/s , 3m/s , 3m/s
x0 = [18000,8000,7000,0,0.3,0.3];
pos_init = [18000,8000,7000];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:50000],x0,[],pos_init);


