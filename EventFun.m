function [value,isterminal,direction] = EventFun( t,x )
%EventFun �¼���⺯����������ֹode45���ض�λ�ô��Ļ���

value = x(2); % ����ʱ�䣬����ֵΪ0ʱ��ʱ��ᴥ��
isterminal = 1; % �趨Ϊ1ʱ�ᣬ����ʱ���ֹͣ���������0ʱ������Ӱ�칤��
direction = 0;% ����������1ʱ��������������-1���½���������0��˫�򴥷�



end

