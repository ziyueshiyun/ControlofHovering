function [ C20,C22 ] = SphericalHaromic(a,b,c)
%����С���ǵ���������ģ�ͣ�1/a^2 + 1/b^2 + 1/c^2 = 1;
%������������Ϊ������İ볤�᳤a15km,7km,c6km,���Ϊ��гϵ��C20,C22
Ixx = (b^2 + c^2)/5;
Iyy = (a^2 + c^2)/5;
Izz = (a^2 + b^2)/5;
C20 = (Ixx + Iyy - 2*Izz)/2/a^2;
C22 = (Iyy - Ixx)/4/a^2;
end

