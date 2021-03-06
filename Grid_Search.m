function [X_half,T] = Grid_Search(M,t)
% Grid_Search 根据生成的矩阵M，以及对应时刻矩阵t
% 获得第一次y坐标归为0
% 时刻的x,y,z,dx,dy,dz 以及步长(时间单位的万分之一0.0001)
% 这里为方便后面的绘图，直接转换为常用时间
% 和长度单位

X_half = [0,0,0,0,0,0];
T = -1;
Row = size(M,1);
for i = 2:Row
    if M(i,2) < 0
        X_half = M(i-1,:);
        T = t(i-1);
        break;
    end
end
end

