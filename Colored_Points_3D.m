function [XOYPot] = Colored_Points_3D()
% Colored_Points_3D �ú���������ά�ռ��ڵ����ڹ����ռ�
% �������γ����ڹ���ĵ��Theta_init�Լ���ʼ�ٶ�Dy_init
% ����Ҫ��delta_V�Ĵ�С�洢��һ��n*3�еľ�����

% ����̽������z�������˶��ĶԳ��ԣ�����ֻ��Ҫ����z>0�����
% ���ȹ̶�Rinit = 5km
% ����cos(Theta)=x/Rinit����ô��x��5km���ٵ�-5kmʱ��
% Thetaǡ�ô�0�ȵ�180��

% �趨��ʼ����
% ��ʼ�趨̽������С���ǵľ��붼��5km
Rinit = 5;

% ʱ�䵥λm
Tu = 6.5e6;
% ���ȵ�λs
Lu = 1.1e5;

% �Ƕ�
% Theta = 0;

% dy���ֵΪ40cm/s
yMax = 12;   

% �������ʱ��Ϊ100��
t_term = 100*24*3600/Tu;
XOYPot = zeros(100,5);
Row = 1;
% ����������ռ�
for Theta = 0:180
	for Dyinit = -yMax:0.1:yMax
		 
		% �����ýǶ�Theta��Rinit = 5km���Xinit��Zinit����x��z����ĳ�ʼֵ
        % ��������Ϊx0,Dy0�ĵ��ȶԵ�λ���й�һ��
        Th = Theta/180*pi;
		Xinit = Rinit*cos(Th);
		Zinit = Rinit*sin(Th);
        x0 = 1000*Xinit/Lu;
		z0 = 1000*Zinit/Lu;
        Dy0 = Dyinit/100/(Lu/Tu);
        
        % ��ode45���߶Է��̽��л��֣�ȷ�����ֲ�����������
        X0 = [x0,0,z0,0,Dy0,0];
        
        
        % ������ʱ��ν��е�λ��
        op = odeset('Events',@EventFun);
        [~,x,Tend,~,~] = ode45(@DynamicEq02,[0,t_term],X0,op);
        
        Xhalf = x(end,:);
        
        
        % ��ԭʱ�䵥λΪ��
        Time_Need = 2*Tend(end)*Tu/3600/24;
        % ��ԭ�ٶȵ�λΪ��ÿ��
        Dx = Xhalf(4);
        Dz = Xhalf(6);
        Dv_Need = 2*Lu*(Dx^2+Dz^2)^(1/2);
        
        XOYPot(Row,1) = Theta;
        XOYPot(Row,2) = Dyinit;
        XOYPot(Row,3) = Time_Need;
        XOYPot(Row,4) = Dv_Need;
        % xtermal
        XOYPot(Row,5) = (Xhalf(1)^2+Xhalf(3)^2)^(1/2)*Lu;
        Row = Row+1;
        Row
	end
end
end

