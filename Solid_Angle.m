function [SA] = Solid_Angle(x,PosInit)
% Solid_Angle ��������Ǵ�С
% ������Ϊǰ��ode45���������xǰ���У�����x���꣬y�����z����
% ���г�ʼλ�ã������������������ǰ��ʹ�õ�mu�ʲ���Ҫ�ٽ�������

% ���ȼ������е㵽��ʼ��ľ��룬ȡ���ֵΪ��СԲ׶��İ뾶
% ��������
row = size(x,1);
distances = zeros(row,1);

x0 = PosInit(1);
y0 = PosInit(2);
z0 = PosInit(3);


for i = 1:row
    x1 = x(i,1);
    y1 = x(i,2);
    z1 = x(i,3);
    distances(i) = ((x1-x0)^2+(y1-y0)^2+(z1-z0)^2)^(1/2);   
end

Distance = max(distances);
Radius = (x0^2+y0^2+z0^2)^(1/2);
tan_x = Distance/Radius;

cos_x = 1/(1+tan_x^2)^(1/2);

SA = 2*pi*(1-cos_x);


end

