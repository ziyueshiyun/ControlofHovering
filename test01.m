% 
% r = sqrt(x.*x + y.*y);

% %�õ������λ��
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
% %С��������ģ��������᳤��ȡ15km;
% ae = 15000;
% c20 = -0.0898;
% c22 = 0.0391;
% %�õ������λ��
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
% zi=griddata(x,y,z,xi,yi); %����Ĭ�ϵ�linear�㷨
% mesh(xi,yi,zi);
% hold on;
% plot3(x,y,z,'o');
% hold off;
% title('Linear');
% subplot(122);
% zi=griddata(x,y,z,xi,yi,'cubic'); %����cubic�㷨
% mesh(xi,yi,zi);
% hold on;
% plot3(x,y,z,'o');
% hold off;
% title('Cubic');



%����̽���������С����λ�����������
%���������������ֵ��������
%�ҳ�����������һ�µ�v3


%ȡС����ģ��Ϊ15km * 7km * 6km���ٶ�С���ǵ��ܶ��Ǿ��ȵģ��趨Ϊ3g/cm^3 = 3000ǧ��ÿ������
%���GM����
mu = 5.2826e+05;

%��������С��������Ϊu/r С�������ת���ٶ�Ϊ10hһȦw = 2*pi/10/3600 = 1.7453e-04 
%����һ�¹���뾶Rs = (mu/w^2)^(1/3) = 25884m;
w = 2*pi/10/3600;
Rs = (mu/w^2)^(1/3);


%��������������
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


% %�������������洢��һ�����ž���SHM��
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
% %��дһ��������������ΪС������һ���λ�����꣬���Ϊ�õ��3x3��������
% %Ϊ����������������������ֵ
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

%��дһ������������Ϊһ��3x3�ľ��������������ֵ��������������
%matlab�Դ�������

%�Ȳ���һ��matlab�Դ���������ֵ�����������ĺ���[V,D] = eig(A);
A = [1 -3 3; 3 -5 3;6 -6 4];
[V1,D1] = eig(A);

%������6476��λ�õ�����ֵ�������������з���
 for k = 1:20
    disp(k)
 end

%�ȿ���xyƽ���ϵĵ������ֵ�ص�
CHofxy = EDofPoints(x01,y01,z01);


%�������Բ���
B = zeros(4,2);
b1 = [1 1; 1 1];
b2 = [2 2; 2 2];
B(1:2,:) = b1;
B(3:4,:) = b2;
l1 = 1:2:10-3;

%��ǰ��Ľ���У����֣�ǰ����������ֵ�Ĵ�С��ȣ����Ǹ���������������ֵ����
%�ǲ�����Ϊȡ�㶼��xoyƽ������ɵ��أ���������xozƽ���ϵĵ�
%��x02 y02 z02
%��xozƽ��������һ����������ĵ�����꣬������x02,y02,z02��

%�����ٿ���yozƽ���ϵĵ�����
Chofyz = EDofPoints(yzPos(:,1),yzPos(:,2),yzPos(:,3));


%�����ڿ�ʼת����Ʋ��֣�Ҫ��̽�����ĸ߶ȳ���h0��ʩ��-Ta0����̽�����ĸ߶�
%����h0,ʩ��Ta0;

%���ȣ�ѵ��һ��΢�ַ�����Ļ�������
% dsolve('Dy = 3*x*x','x')
% 
% syms y(t)
% eqn = diff(y) == y+exp(-y);
% % sol = dsolve(eqn)
% sol = dsolve(eqn,'Implicit',true)

%��дode�������������������λ�õ���Ŀ��߶�ʱ��ʹ��OdeLow
%����������λ�ø���Ŀ��߶�ʱ��ʹ��OdeHigh


%�Ȳ���һ����δʩ�ӿ��Ƶ�����µ�̽�����˶����
%��ʼλ������Ϊ18km,8km,7km, ��ʼ�ٶ�����0m/s , 3m/s , 3m/s
%��ʼλ���������Ϊ400m,300m,200m
x0 = [18050,8050,7050,0,0.3,0.3];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:1600],x0);
plot3(x(:,1),x(:,2),x(:,3));
%�����18km 8km 7km����T0
%t0 = Torigin(18000,8000,7000,mu,w);
% hold on;
x1 = x(:,1);
x2 = x(:,2);
x3 = x(:,3);
z = (x1.^2 + x2.^2+x3.^2).^(1/2);
plot(t,z);
title('�߶�ʱ��仯����');
xlabel('ʱ��t/s');
ylabel('�߶�h/m');

plot(t,x1,t,x2,t,x3);
title('x,y,z����ʱ��仯����');
xlabel('ʱ��t/s');
ylabel('x/m');


% %��һ�����������ڿռ�����ϵ��
% 
% ellipsoid(0,-0.5,0,15,7,6)
% axis equal
% 
% tiledlayout(2,2);
% ax3 = nexttile;
% ellipsoid(ax3,0,0,0,2,1,1,80)
% axis equal
% title('80-by-80 faces')

%Ѱ��xoyƽ���ϵĵ㣬������������ֵ
%������Ѱ�Ҳ��ȶ������һ�ͼ

% ����19
Rn = 1.26:0.01:3;
Zn = ((-2+Rn.^3)./Rn).^(1/2);
plot(Rn,Zn);
hold on;
% ����20
Rn = 0.5:0.01:3;
Zn = 1./Rn;
plot(Rn,Zn);

hold on;
% ����20
Rn = 1;
Zn = 0:0.01:3;
plot(Rn,Zn);
hold on;
% ����21.1
Rn = 4^(1/3);
plot(Rn,Zn);
hold on;
% ����21.2 Rn >= 1.5874;
Rn = 1.59:0.01:3;
Zn = ((5.*Rn.^3-8+((5.*Rn.^3-8).^2-9.*Rn.^6).^(1/2))./9.*Rn).^(1/2);
plot(Rn,Zn);
hold on;
% ����21.3
Zn = ((5.*Rn.^3-8-((5.*Rn.^3-8).^2-9.*Rn.^6).^(1/2))./9.*Rn).^(1/2);
plot(Rn,Zn);

% Ѱ������������������������xozƽ����

% x = 13697 y=0 Z = 15530
x0 = [13697,0,15530,0,0.1,0.1];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:1200],x0);
plot3(x(:,1),x(:,2),x(:,3));

%ʱ��߶ȱ仯����
x1 = x(:,1);
y1 = x(:,2);
z1 = x(:,3);
h = (x1.^2+y1.^2+z1.^2).^(1/2);
plot(t,h,'r');
xlabel('ʱ��t/s');
ylabel('�߶�h/m');

plot(t,x1,'r')
xlabel('ʱ��t/s');
ylabel('xλ��/m');

plot(t,y1,'g')
xlabel('ʱ��t/s');
ylabel('xλ��/m');

plot(t,z1,'k')
xlabel('ʱ��t/s');
ylabel('xλ��/m');

------------------------------------------------------
%ע��Ҫͬ���޸�Tdb����ĳ�ʼλ�ã��������ûʱ���޸��ˣ��ȴպ���һ��
% x = 13697 y=0 Z = 15530
x0 = [13697,0,15530,0,0.3,0.3];
pos_init = [13697,0,15530];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:50000],x0,[],pos_init);
plot3(x(:,1),x(:,2),x(:,3));


%�ı��ʼλ�ú��ٶ������Կ�
x0 = [25229,0,18119,0,3,3];
pos_init = [25229,0,18119];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:24000],x0,[],pos_init);
plot3(x(:,1),x(:,2),x(:,3));

%ʱ��߶ȱ仯����
x1 = x(:,1);
y1 = x(:,2);
z1 = x(:,3);
h = (x1.^2+y1.^2+z1.^2).^(1/2);
plot(t,h,'r');
xlabel('ʱ��t/s');
ylabel('�߶�h/m');

plot(t,x1,'r')
xlabel('ʱ��t/s');
ylabel('xλ��/m');

plot(t,y1,'g')
xlabel('ʱ��t/s');
ylabel('xλ��/m');

plot(t,z1,'k')
xlabel('ʱ��t/s');
ylabel('xλ��/m');

% ��������ϵ���Ĵ�С�߶�
% x = 13697 y=0 Z = 15530
% X_test = 13697;
% Y_test = 0;
% Z_test = 15530;
% [V_Test,T_Test] = eig(HM(X_test,Y_test,Z_test,mu));
% ��������V3������СԼ����1


% ���Դ��ȡ0.7������뾶��������
% xozƽ���ϵĵ� 
% 25884 * 0.7 = 18119m
% x^2 + z^2 = 18119m �� x^2/15km^2 + z^2/6km^2 >1
% 12814^2/15000^2 + 12814^2/6000^2 = 5.2908

%�ı��ʼλ�ú��ٶ������Կ�
x0 = [12184,12814,0,0,0.3,0.3];
pos_init = [12184,12814,0];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:50000],x0,[],pos_init);


%ʱ��߶ȵȱ仯����
x1 = x(:,1);
y1 = x(:,2);
z1 = x(:,3);
% ��ά����
plot3(x1,y1,z1);


% ʱ��߶�����
h = (x1.^2+y1.^2+z1.^2).^(1/2);
plot(t,h,'r');
xlabel('ʱ��t/s');
ylabel('�߶�h/m');

plot(t,x1,'r')
xlabel('ʱ��t/s');
ylabel('xλ��/m');


plot(t,y1,'g')
xlabel('ʱ��t/s');
ylabel('xλ��/m');

plot(t,z1,'k')
xlabel('ʱ��t/s');
ylabel('xλ��/m');

% % ��λ�����ά��̬���ߣ�
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


%����ʹ�õ����ڹ���뾶��Χ�ڵĵ�
%��ʼλ������Ϊ18km,8km,7km, ��ʼ�ٶ�����0m/s , 3m/s , 3m/s
x0 = [18000,8000,7000,0,0.3,0.3];
pos_init = [18000,8000,7000];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:50000],x0,[],pos_init);


