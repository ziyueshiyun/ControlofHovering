function T = IATNS(x,y,z,PosInit)
%���ڸ�������ͣ�߶�h0����̽������ʵ�ʸ߶ȴ�����ͣ�߶�h0ʱ��ʩ�ӿ�����ʹ̽��
%���ͣ���֮��ʩ���෴�Ŀ�����,���ô˺���������Ƽ��ٶ�
%��ʱʹ�õڶ��ֿ�����������a0����һ��

%��������
mu = 5.2826e+05;

%С������ת���ٶ�
w = 2*pi/36000;

% ̽������ʼλ��
x0 = PosInit(1);
y0 = PosInit(2);
z0 = PosInit(3);
% t0 = Torigin(x0,y0,z0,mu,w);%��Ƽ��ٶ�
dh = 10;
Tm = 1;%ϵ����С
h0 = (x0^2 + y0^2 + z0^2)^(1/2);
hx = (x^2 + y^2 + z^2)^(1/2);

t0 = Torigin(PosInit(1),PosInit(2),PosInit(3),mu,w);
a0 = -t0/norm(t0);

% r=[x y z];
% g=r/norm(r);
% 
if(h0-hx > dh)
   T = (-Tm*a0)';
elseif(h0 -hx < -dh)
   T = (Tm*a0)';
else
   T = [0 0 0]';
end


