function [T] = My_Plot( Points )
% My_Plot 根据输入的一系列点的初始坐标，进行绘图统计
% Points为n行3列的矩阵，代表输入的点的坐标
% 然后计算每个点使用该控制方式后的立体角大小
% 存入矩阵T中

% 矩阵行数；
row = size(Points,1);

% 创建结果矩阵，存储目标数组
T = Points;
DataT = zeros(1,20001);
DataX = zeros(20001,6);

for i = 1:row
    pos_init = Points(i,:);
    sum = 0;
    % 指定随机误差矩阵10行3列的范围为-0.1到0.1m/s
    Errors= (rand(10,3)*2-1)/10;
    for j = 1:10
        
        x0 = [pos_init(1),pos_init(2),pos_init(3),Errors(j,1),Errors(j,2),Errors(j,3)];
        t0 = Gravitional_Potential(pos_init(1),pos_init(2),pos_init(3));
        
        
        DataT(1)=0;
        DataX(1,:) = x0';
        for k = 1:20000
            
            %动力学
            t_control = tcontrol(DataX(end,1),DataX(end,2),DataX(end,3),pos_init);
            [~,x] = ode45(@DynamicEq,[DataT(end) DataT(end)+1],DataX(end,:),[],t0,t_control);
            DataT(k+1)= DataT(k)+1;%时间
            DataX(k+1,:) = x(end,:);%状态量
        end
        sum = sum + Solid_Angle(DataX,pos_init)/pi*180;
    end
    T(i,4) = sum/10;
    i
end


end


