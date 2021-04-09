function [T] = My_Plot( Points )
% My_Plot 根据输入的一系列点的初始坐标，进行绘图统计
% Points为n行3列的矩阵，代表输入的点的坐标
% 然后计算每个点使用该控制方式后的立体角大小
% 存入矩阵T中

% 矩阵行数；
row = size(Points,1);

% 创建结果矩阵，存储目标数组
T = Points;

for i = 1:row
    pos_init = Points(i,:);
    x0 = [pos_init(1),pos_init(2),pos_init(3),0,0.3,0.3];
    [t,x] = ode45(@DynamicEq,[0:24000],x0,[],pos_init);
    T(i,4) = Solid_Angle(x,pos_init);
end


end


