function [T] = Periodic_Need(Theta,Dyinit,R)
%Periodic_Need ��������һ����������Ҫ��ʱ��
%   ����Ĭ�Ͼ���R = 5km Theta �ͽǶ�Dyinit,����������
% ��ʼ�趨̽������С���ǵľ��붼��5km
Rinit = R;
% ʱ�䵥λm
Tu = 6.5e6;
% ���ȵ�λs
Lu = 1.1e5;

Theta_size = size(Theta,2);
Dyinit_size = size(Dyinit,2);
T = zeros(Theta_size,Dyinit_size);
% �������ʱ��Ϊ100��
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
        %ע�������ʱ��Tʵ��ֻ����ת������ڵ�����Ҫʱ��
        T(i,j) = Tend(end)*Tu/3600/24;
        distance = (x(end,1)^2 + x(end,3)^2)^(1/2)*Lu;
        if distance < 500 || T(i,j) <0.01
            T(i,j) =0;  %�޳����ݵ�ײ�ϵĵȲ��ϸ����ڹ��
        end
        Time = Time+1;
        Time
    end
end
T = T';
end



