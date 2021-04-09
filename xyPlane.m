function [ A ] = xyPlane(x,y,z,c20,c22,ae,u)
%UNTITLED2 此处显示有关此函数的摘要
%   此处显示详细
r = sqrt(x.^2+y.^2+z.^2);
A = u/r.*(1+(ae/r).^2*(1/2 * c20*(3*z.^2/r.^2-1)+3*c22*(1-z.^2/r.^2)*(1-2*z.^2/r.^2)^2));
end

