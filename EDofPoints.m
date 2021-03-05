function [ T ] = EDofPoints(X,Y,Z)
% EDofPoints输入点的坐标矩阵，返回由特征向量组成的矩阵数组T
%   此处显示详细说明
len = length(X); %获取X长度，确定输出维度
T = zeros(len*3,6);
Mu = 5.2826e+05;
for i = 1:1:len
    [D,V] =eig(HM(X(i),Y(i),Z(i),Mu));
    T(i*3-2:i*3,1:3) = D;
    T(i*3-2:i*3,4:6) = V;
end

end


