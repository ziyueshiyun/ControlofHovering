function [X_half] = Grid_Search(M,Row)
% Grid_Search �������ɵľ���M���Լ����������Row
% ��õ�һ��y�����Ϊ0
% ʱ�̵�x,y,z,dx,dy,dz �Լ�����������Ϊ�������Ļ�ͼ��ֱ��ת��Ϊ����ʱ��
% �ͳ��ȵ�λ
X_half = [0,0,0,0,0,0];
for i = 1:Row
    if M(Row,2)*M(Row+1,2) < 0
        X_half = M(Row,:);
        break;
    end
end
end

