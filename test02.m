x0 = [13697,0,15530,0,0.3,0.3];
pos_init = [13697,0,15530];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
[t,x] = ode45(@DynamicEq,[0:24000],x0,[],pos_init);
plot3(x(:,1),x(:,2),x(:,3));

plot(t,x(:,1),'r')
xlabel('ʱ��t/s');
ylabel('xλ��/m');
hold on;

figure;
X0 = [20000,0,0,0,0.1,0.1];
pos_init = [20000,0,0];
%options = odeset('RelTol',1e-8,'AbsTol',[1e-5 1e-5 1e-5 1e-5 1e-5 1e-5]);
t0 = Gravitional_Potential(pos_init(1),pos_init(2),pos_init(3));
[t,x] = ode45(@DynamicEq,[0 5000],X0,[],pos_init,t0);

% ��ֵ
h0=120;v0=400;theta0=0;xi0=alpha0;omegaz0=0;x0=0;
m0=151.5;
y0 = [v0;theta0;omegaz0;x0;h0;xi0;m0 ];

DataT(1)=0;
DataY(1,:)=y0';
for i=1:500

    %����ѧ
    [t,y] = ode45( @dynamic, [DataT(end) DataT(end)+0.1], DataY(end,:)',[],con,delta_z );
    %����
    delta_z = Control(y(end,5),y(end,1)*sin(y(end,2)) ,y(end,1),y(end,7),con);
    %���ݼ�¼
    DataT = [DataT ;t];%ʱ��
    DataY = [DataY;y];%״̬��
    dz(i)=delta_z;%��ƫ��
end


X0 = [20000,0,0,0,0.1,0.1];
pos_init = [20000,0,0];
t0 = Gravitional_Potential(pos_init(1),pos_init(2),pos_init(3));
DataT(1)=0;
DataX(1,:) = X0';
for i = 1:20000
    
    %����ѧ
    t_control = tcontrol(DataX(end,1),DataX(end,2),DataX(end,3),pos_init);
    [t,x] = ode45(@DynamicEq,[DataT(end) DataT(end)+1],DataX(end,:),[],t0,t_control);
    DataT(i+1)= DataT(i)+1;%ʱ��
    DataX(i+1,:) = x(end,:);%״̬��
end


%ʱ��߶ȱ仯����
x1 = DataX(:,1);
y1 = DataX(:,2);
z1 = DataX(:,3);
h = (x1.^2+y1.^2+z1.^2).^(1/2);
plot(DataT',h,'r');
xlabel('ʱ��t/s');
ylabel('�߶�h/m');

%ʱ��x����仯����
plot(DataT,x1,'r')
xlabel('ʱ��t/s');
ylabel('xλ��/m');


%ʱ��y����仯����
plot(DataT,y1,'g')
xlabel('ʱ��t/s');
ylabel('xλ��/m');

%ʱ��z����仯����
plot(DataT,z1,'k')
xlabel('ʱ��t/s');
ylabel('xλ��/m');


%��ʼ��������ǵĹ���
%����������������ͶӰ���߶ȴ�ֱ��ƽ���ϣ��Ƚ�Xmax-Xmin ��Ymax-Ymin
%�����д����ΪԲ׶���ֱ�������������

%����Ϊ2x��Բ׶����Ǵ�СΪ 2*pi(1-cos(x))
%Ѱ��Xmin,Ymax,Ymin,Xmax
% 
% dis = 0;
% for i = 1:100
%     if mod(i,10)==0
%         dis = i;
%         disp(i);
%         
%     end
% end

% ��6236�������������ǽ���ͳ�ƣ����һ�ͼ
% 

T = My_Plot(xyPos);
% T = My_Plot(yzPos);
clear;
save T;
% T(:,4) = T(:,4)*(180/pi)^2;
Tsize = size(T,1);
% ��С���㼯��
Tmin = zeros(1,4);
im = 1;
% �е����㼯��
Tmed = zeros(1,4);
me = 1;
% �Ƚϴ����㼯��
Tmax = zeros(1,4);
ma = 1;

% ƫ��ƽ���ļ���
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


% �ֱ�����ٶ����Ϊ(1,1,0)(1,-1,0)(-1,-1,0)(-1,1,0)�ĵ���ȶ���
% ����Ϊ�ĸ������ļ�������ͼƬ

% 
% scatter(Tmin(:,2),Tmin(:,3),40,'.');
% hold on;
% scatter(Tmed(:,2),Tmed(:,3),20,'rx');
% hold on;
% scatter(Tmax(:,2),Tmax(:,3),20,'g+');
% hold on; 
% scatter(Tmm(:,2),Tmm(:,3),20,'yd');



