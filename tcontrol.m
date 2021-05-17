function [T] = tcontrol(x,y,z,PosInit)
%�����������ٶȴ�С��������Ϊ��ʱ��λ�ã����Ϊ�����������ٶ�
%����������������ٶȴ�Ϊ3x1�еľ���
mu = 5.2805e+05;
w = 2*pi/36000;
x0 = PosInit(1);
y0 = PosInit(2);
z0 = PosInit(3);

dh = 10;
Tm = 1e-2;%ϵ����С
h0 = (x0^2 + y0^2 + z0^2)^(1/2);
hx = (x^2 + y^2 + z^2)^(1/2);
[V,~] =eig(New_Hm(x0,y0,z0,mu));

if(h0-hx > dh)
   T = Tm*V(:,3);
elseif(h0 -hx < -dh)
   T = -Tm*V(:,3);
else
   T = [0 0 0]';
   
end
T(1) = T(1) - w^2*x0;
T(2) = T(2) - w^2*y0;
end


