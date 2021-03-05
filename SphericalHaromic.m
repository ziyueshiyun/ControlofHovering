function [ C20,C22 ] = SphericalHaromic(a,b,c)
%建立小行星的三轴椭球模型，1/a^2 + 1/b^2 + 1/c^2 = 1;
%本函数输入量为三个轴的半长轴长a15km,7km,c6km,输出为球谐系数C20,C22
Ixx = (b^2 + c^2)/5;
Iyy = (a^2 + c^2)/5;
Izz = (a^2 + b^2)/5;
C20 = (Ixx + Iyy - 2*Izz)/2/a^2;
C22 = (Iyy - Ixx)/4/a^2;
end

