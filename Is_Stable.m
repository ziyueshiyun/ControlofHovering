function [T ] = Is_Stable(Theta,Dyinit,r)
% Is_Stable ������ά�ռ���ĳ�����γɵ����ڹ���Ƿ��ȶ�
% Theta���� cos(Theta) = x/r;
% DyinitΪ̽������ʼ�ٶ���y�����ϵķ���cm/s,Ҳ��һ��������1xn��
% Ĭ����x�����z����ĳ�ʼ�ٶ�Ϊ0
% rΪ�����̽������ʼλ����С���ǵľ���km
% ThetaΪ����Ƕȣ�Ϊһ����������1~180�ȣ��ǵ�Ҫ�ں���ת��Ϊ����

Rinit = r;
% ʱ�䵥λm
Tu = 6.5e6;
% ���ȵ�λs
Lu = 1.1e5;
% ���ȸ����������ȷ���������γ��
Theta_size = size(Theta,2);
Dyinit_size = size(Dyinit,2);
T = zeros(Theta_size,Dyinit_size);

% ����ǰ��ĺ���Periodic_Need���������ڣ����ں������������Floquet
% �������Ӷ��жϸù���Ƿ��ȶ�
% Half_Orbit_Times = Periodic_Need(Theta,Dyinit,Rinit);
% Half_Orbit_Times = Half_Orbit_Times';%ע��������Ҫת��һ�²���ʹ��
% save Half_Orbit_Times;
% �����������Ĺ�����Ӿ���Half_Orbit_Times��ȡ�������ʱ��
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
            %���T(i,j)Ϊ1���ȶ���Ϊ-1�Ͳ��ȶ���Ϊ0����û�����ڹ��
        end
        time = time + 1;%����
        time
    end
end

end

