function [XOYPot] = Colored_Points()
% �½�һ�����������������������Եõ���4800��������������ڹ�����ͣ�����
% ��ͬ����ɫ��ע����Xinit,Dyinit��άƽ��ͼ��
% ��������Colored_Points

% ʱ�䵥λm
Tu = 6.5e6;
% ���ȵ�λs
Lu = 1.1e5;
% ȷ����άͼ�ε�x�����y���귶Χȡ����Ϊ60 x 80
% x���ֵΪ30km
xMax = 30;

% dy���ֵΪ40cm/s
yMax = 40;    

% ��һ��n��4�еľ������洢x���꣬y�����Լ���Ӧ���ڣ��ٶȱ仯��cm/s
% Row = xLabel*yLabel;

XOYPot = zeros(1,5);
Row = 1;
% ��ʼ����ʱ������Ϊ0����������ʱ������ΪT_term �������������Ϊ20��

% �������ʱ��20��
t_term = 100*24*3600/Tu;



% ע�⣬�˴�Ҫ�ų�Xinit = 0 �ĵ㣬��Ϊ�ڸõ�λ����С������ײ��
for Xinit = -xMax:0.1:xMax
    if Xinit == 0; continue;
    end
    for Dyinit = -yMax:0.1:yMax

        
        % ��������Ϊx0,Dy0�ĵ��ȶԵ�λ���й�һ��
        x0 = 1000*Xinit/Lu;
        Dy0 = Dyinit/100/(Lu/Tu);
        
        % ��ode45���߶Է��̽��л��֣�ȷ�����ֲ�����������
        X0 = [x0,0,0,0,Dy0,0];
        
        
        % ������ʱ��ν��е�λ��
        op = odeset('Events',@EventFun);
        [t,x,Tend,Xend,evenum] = ode45(@DynamicEq02,[0,t_term],X0,op);
        
        Xhalf = x(end,:);
        
        
        % ��ԭʱ�䵥λΪ��
        Time_Needed = 2*Tend(end)*Tu/3600/24;
        % ��ԭ�ٶȵ�λΪ��ÿ��
        Dx = Xhalf(4)*Lu/Tu;
        
        
        XOYPot(Row,1) = Xinit;
        XOYPot(Row,2) = Dyinit;
        XOYPot(Row,3) = Time_Needed;
        XOYPot(Row,4) = Dx;
        % xtermal
        XOYPot(Row,5) = Xhalf(1)*Lu;
        Row = Row+1;
        Row
    end
end


% x_init = -xLabel/2 :10000: xLabel/2;
% dy_init= -yLabel/2 :10: yLabel/2;
% [Xinit,Dyinit] = meshgrid(x_init,dy_init);


end


