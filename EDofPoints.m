function [ T ] = EDofPoints(X,Y,Z)
% EDofPoints������������󣬷���������������ɵľ�������T
%   �˴���ʾ��ϸ˵��
len = length(X); %��ȡX���ȣ�ȷ�����ά��
T = zeros(len*3,6);
Mu = 5.2826e+05;
for i = 1:1:len
    [D,V] =eig(HM(X(i),Y(i),Z(i),Mu));
    T(i*3-2:i*3,1:3) = D;
    T(i*3-2:i*3,4:6) = V;
end

end


