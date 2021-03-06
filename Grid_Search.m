function [X_half] = Grid_Search(M,Row)
% Grid_Search 根据生成的矩阵M，以及矩阵的行数Row
% 获得第一次y坐标归为0
% 时刻的x,y,z,dx,dy,dz 以及步长，这里为方便后面的绘图，直接转换为常用时间
% 和长度单位
X_half = [0,0,0,0,0,0];
for i = 1:Row
    if M(Row,2)*M(Row+1,2) < 0
        X_half = M(Row,:);
        break;
    end
end
end

