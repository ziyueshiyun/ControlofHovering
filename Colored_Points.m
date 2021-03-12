function [XOYPot] = Colored_Points()
% �½�һ�����������������������Եõ���4800��������������ڹ�����ͣ�����
% ��ͬ����ɫ��ע����Xinit,Dyinit��άƽ��ͼ��
% ��������Colored_Points

Tu = 6.5e6;
Lu = 1.1e5;
% ȷ����άͼ�ε�x�����y���귶Χȡ����Ϊ60 x 80
% ����x��������ʼx���꣬��λΪm y��������ʼy�ٶȣ���λΪcm/s
xLabel = 60000;
yLabel = 80;

% ��һ��4800��4�еľ������洢x���꣬y�����Լ���Ӧ���ڣ��ٶȱ仯��cm/s
% Row = xLabel*yLabel;

XOYPot = zeros(56,4);
% ��ʼ����ʱ������Ϊ0����������ʱ������ΪT_term �������������Ϊ20��

% �������ʱ��Ϊ������ڳ���
t_term = 100*24*3600/Tu;

% ÿ����ʹ��ode45���������ɵľ�������
% OdeRow = t_term / 0.001;

% ͳ�������ɵľ��������
Row = 1;
        
for Xinit = -xLabel/2 :10000: xLabel/2
    for Dyinit = -yLabel/2 :10: yLabel/2
        
        % ��������Ϊx0,Dy0�ĵ��ȶԵ�λ���й�һ��
        x0 = Xinit/Lu;
        Dy0 = Dyinit/100/Lu/(1/Tu);
        
        % ��ode45���߶Է��̽��л��֣�ȷ�����ֲ�����������
        X0 = [x0,0,0,0,Dy0,0];
        
        
        % ������ʱ��ν��е�λ��
        [t,x] = ode45(@DynamicEq02,[0 t_term],X0);
        
        [Xhalf,Time_Needed] = Grid_Search(x,t);
        
        % ��ԭʱ�䵥λΪ��
        Time_Needed = abs(2*Time_Needed*Tu/3600/24);
        % ��ԭ�ٶȵ�λΪ��ÿ��
        Dy = Xhalf(5)*Lu/Tu;
        
        
        XOYPot(Row,1) = Xinit;
        XOYPot(Row,2) = Dyinit;
        XOYPot(Row,3) = Time_Needed;
        XOYPot(Row,4) = Dy;
        Row = Row+1;
    end
end


end


