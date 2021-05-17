x0 = [13697,0,15530,0,0.3,0.3];
pos_init = [13697,0,15530];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:24000],x0,[],pos_init);
plot3(x(:,1),x(:,2),x(:,3));

plot(t,x(:,1),'r')
xlabel('时间t/s');
ylabel('x位置/m');
hold on;

figure;
X0 = [20000,0,0,0,0.1,0.1];
pos_init = [20000,0,0];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
t0 = Gravitional_Potential(pos_init(1),pos_init(2),pos_init(3));
[t,x] = ode45(@DynamicEq,[0 5000],X0,[],pos_init,t0);

% 初值
h0=120;v0=400;theta0=0;xi0=alpha0;omegaz0=0;x0=0;
m0=151.5;
y0 = [v0;theta0;omegaz0;x0;h0;xi0;m0 ];

DataT(1)=0;
DataY(1,:)=y0';
for i=1:500

    %动力学
    [t,y] = ode45( @dynamic, [DataT(end) DataT(end)+0.1], DataY(end,:)',[],con,delta_z );
    %控制
    delta_z = Control(y(end,5),y(end,1)*sin(y(end,2)) ,y(end,1),y(end,7),con);
    %数据记录
    DataT = [DataT ;t];%时间
    DataY = [DataY;y];%状态量
    dz(i)=delta_z;%舵偏角
end


X0 = [20000,0,0,0,0.1,0.1];
pos_init = [20000,0,0];
t0 = Gravitional_Potential(pos_init(1),pos_init(2),pos_init(3));
DataT(1)=0;
DataX(1,:) = X0';
for i = 1:20000
    
    %动力学
    t_control = tcontrol(DataX(end,1),DataX(end,2),DataX(end,3),pos_init);
    [t,x] = ode45(@DynamicEq,[DataT(end) DataT(end)+1],DataX(end,:),[],t0,t_control);
    DataT(i+1)= DataT(i)+1;%时间
    DataX(i+1,:) = x(end,:);%状态量
end


%时间高度变化曲线
x1 = DataX(:,1);
y1 = DataX(:,2);
z1 = DataX(:,3);
h = (x1.^2+y1.^2+z1.^2).^(1/2);
plot(DataT',h,'r');
xlabel('时间t/s');
ylabel('高度h/m');

%时间x坐标变化曲线
plot(DataT,x1,'r')
xlabel('时间t/s');
ylabel('x位置/m');


%时间y坐标变化曲线
plot(DataT,y1,'g')
xlabel('时间t/s');
ylabel('x位置/m');

%时间z坐标变化曲线
plot(DataT,z1,'k')
xlabel('时间t/s');
ylabel('x位置/m');


%开始计算立体角的工作
%把曲线上所有坐标投影到高度垂直的平面上，比较Xmax-Xmin 与Ymax-Ymin
%将其中大的作为圆锥面的直径，计算立体角

%顶角为2x的圆锥立体角大小为 2*pi(1-cos(x))
%寻找Xmin,Ymax,Ymin,Xmax
% 
% dis = 0;
% for i = 1:100
%     if mod(i,10)==0
%         dis = i;
%         disp(i);
%         
%     end
% end

% 把6236个样本点的立体角进行统计，并且绘图
% 

T = My_Plot(xyPos);
% T = My_Plot(yzPos);
clear;
save T;
% T(:,4) = T(:,4)*(180/pi)^2;
Tsize = size(T,1);
% 最小误差点集合
Tmin = zeros(1,4);
im = 1;
% 中等误差点集合
Tmed = zeros(1,4);
me = 1;
% 比较大误差点集合
Tmax = zeros(1,4);
ma = 1;

% 偏离平衡点的集合
Tmm = zeros(1,4);
mk  = 1;
for k = 1:Tsize
    
    if T(k,4) < 0.2
        Tmin(im,:) = T(k,:);
        im = im + 1;
    elseif T(k,4) < 0.4
        Tmed(me,:) = T(k,:);
        me = me +1;
    elseif T(k,4) < 0.6
        Tmax(ma,:) = T(k,:);
        ma = ma+1;
    else
        Tmm(mk,:) = T(k,:);
        mk = mk+1;
    end
end
% figure;
scatter(Tmin(:,1),Tmin(:,2),40,'.');
hold on;
scatter(Tmed(:,1),Tmed(:,2),20,'rx');
hold on;
scatter(Tmax(:,1),Tmax(:,2),20,'g+');
hold on; 
scatter(Tmm(:,1),Tmm(:,2),20,'yd');


% 分别计算速度误差为(1,1,0)(1,-1,0)(-1,-1,0)(-1,1,0)的点的稳定性
% 保存为四个矩阵文件和四张图片

% 
% scatter(Tmin(:,2),Tmin(:,3),40,'.');
% hold on;
% scatter(Tmed(:,2),Tmed(:,3),20,'rx');
% hold on;
% scatter(Tmax(:,2),Tmax(:,3),20,'g+');
% hold on; 
% scatter(Tmm(:,2),Tmm(:,3),20,'yd');



