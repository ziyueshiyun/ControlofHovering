function  dX  = DynamicEq(t,X,t0,t_control)
%DynamicEq ̽��������ѧ���̣�x(m)ΪС�����������ϵ�µ�״̬��tΪʱ�䣨ռλ��
%��ǰ������Ҫ��δʩ�ӿ��ƵĶ���ѧ
%PosInitΪ��ʼλ��
%mu = 5.2826e+05;
w = 2*pi/36000;
      
%dX��1��3�ж�Ӧx��4��6�У�����λ�õ�һ�׵���Ӧ�ٶ�
% V = X(4:6);
x = X(1);
y = X(2);
z = X(3);
dx = X(4);
dy = X(5);
dz = X(6);

% �����������ٶȴ�С���㺯��

% Tdb�����һ�ֿ��Ʒ�ʽ
% t1 = Tdb(x,y,z,PosInit);

% IATNS����ڶ��ֿ��Ʒ�ʽ
% t1 = IATNS(x,y,z,PosInit);

Potential = Gravitional_Potential(x,y,z); %�����������ٶ�
d2x = 2*w*dy + Potential(1) + w^2*x + t_control(1)-t0(1);
d2y = Potential(2)-2*w*dx + w^2*y + t_control(2)-t0(2);
d2z = Potential(3)+ t_control(3)-t0(3);

% d2x = 2*w*dy + w^2*x + t1(1);
% d2y = -2*w*dx + w^2*y + t1(2);
% d2z =t1(3);

dX = [dx dy dz d2x d2y d2z]';

end


