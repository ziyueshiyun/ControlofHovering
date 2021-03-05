function [V] = Gravitional_Potential(x,y,z,u,c20,c22)
%Gravitional_Potential
%������Ϊ̽������С������ת����ϵ�µ�λ������r(x,y,z)
%���Ϊ�õ��������(V)
%u = GM = dens*a*b*c*4*pi/3

%����������С���ǵ�λ��
r = sqrt(x*x + y*y +z*z);

%С��������ģ��������᳤��ȡ15km;
ae = 15000;

%�õ������λ��
V = u/r*(1+(ae/r)^2*(1/2 * c20*(3*z^2/r^2-1)+3*c22*(1-z^2/r^2)*(1-2*y^2/r^2)^2));

end

