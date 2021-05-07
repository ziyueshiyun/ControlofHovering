function [ T ] = MonMat_Operate(M)
% MonMat_Operate对状态转移矩阵进行6个特征值计算和处理
% 假如6个特征值中，模最大的特征值与1的偏差大于某个界限
% 比如0.001，就判定为不稳定，输出为1，否则为0稳定
T = -1;
[~,y] = eig(M);
evens = diag(y);
if abs(max(abs(evens))-1) < 0.01
    T = 1;
end
end

