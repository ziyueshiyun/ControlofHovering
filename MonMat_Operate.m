function [ T ] = MonMat_Operate(M)
% MonMat_Operate��״̬ת�ƾ������6������ֵ����ʹ���
% ����6������ֵ�У�ģ��������ֵ��1��ƫ�����ĳ������
% ����0.001�����ж�Ϊ���ȶ������Ϊ1������Ϊ0�ȶ�
T = -1;
[~,y] = eig(M);
evens = diag(y);
if abs(max(abs(evens))-1) < 0.01
    T = 1;
end
end

