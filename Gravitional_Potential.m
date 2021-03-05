function [V] = Gravitional_Potential(x,y,z,u,c20,c22)
%Gravitional_Potential
%输入量为探测器在小天体旋转坐标系下的位置坐标r(x,y,z)
%输出为该点的引力势(V)
%u = GM = dens*a*b*c*4*pi/3

%航天器距离小行星的位置
r = sqrt(x*x + y*y +z*z);

%小行星椭球模型中最长半轴长，取15km;
ae = 15000;

%该点的引力位：
V = u/r*(1+(ae/r)^2*(1/2 * c20*(3*z^2/r^2-1)+3*c22*(1-z^2/r^2)*(1-2*y^2/r^2)^2));

end

