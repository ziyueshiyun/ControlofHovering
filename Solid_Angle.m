function [SA] = Solid_Angle(x,PosInit)
% Solid_Angle 计算立体角大小
% 输入量为前面ode45计算出来的x前三列，即是x坐标，y坐标和z坐标
% 还有初始位置，这里的引力常数采用前文使用的mu故不需要再进行输入

% 首先计算所有点到初始点的距离，取最大值为最小圆锥面的半径
% 矩阵行数
row = size(x,1);

% 距离初始值设置为0
Distance = 0;
x0 = PosInit(1);
y0 = PosInit(2);
z0 = PosInit(3);


for i = 1:row
    x1 = x(i,1);
    y1 = x(i,2);
    z1 = x(i,3);
    temp = ((x1-x0)^2+(y1-y0)^2+(z1-z0)^2)^(1/2);
    if temp > Distance
        Distance = temp;
    end
    
end
Radius = (x0^2+y0^2+z0^2)^(1/2);
tan_x = Distance/Radius;
% tan_x = ((1+tan_2x^2)^(1/2)-1)/tan_2x;
cos_x = 1/(1+tan_x^2)^(1/2);

SA = 2*pi*(1-cos_x);


end

