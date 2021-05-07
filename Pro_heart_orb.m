function [T] = Pro_heart_orb( M )
%   Pro_heart_orb 提取目标矩阵M中的顺行轨道等其他轨道
%   此处显示详细说明
%   初始化输出矩阵的值

T1 = zeros(1,5);
Row = size(M,1);
Count = 1;
%   提取顺行心形轨道 M(1)>0,M(5)<0,M(2)>0
for i = 1:Row
    if M(i,1)>0 && M(i,5)<0 && M(2)>0
        T1(Count,:) = M(i,:)
        Count += 1; 
    end
end

        
        
%   提取逆行心形轨道 M(1)>0,M(5)<0,M(2)<0
%   提取逆行泪形轨道 M(1)<0,M(5)>0,M(2)>0
%   提取顺行泪形轨道 M(1)<0,M(5)>0,M(2)<0
%   提取白昼轨道 M(1)<0,M(5)<0
%   提取夜间轨道 M(1)>0,M(5)>0

 


end

