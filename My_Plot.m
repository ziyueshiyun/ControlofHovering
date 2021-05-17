function [T] = My_Plot( Points )
% My_Plot ���������һϵ�е�ĳ�ʼ���꣬���л�ͼͳ��
% PointsΪn��3�еľ��󣬴�������ĵ������
% Ȼ�����ÿ����ʹ�øÿ��Ʒ�ʽ�������Ǵ�С
% �������T��

% ����������
row = size(Points,1);

% ����������󣬴洢Ŀ������
T = Points;
DataT = zeros(1,20001);
DataX = zeros(20001,6);

for i = 1:row
    pos_init = Points(i,:);
    sum = 0;
    % ָ�����������10��3�еķ�ΧΪ-0.1��0.1m/s
    Errors= (rand(10,3)*2-1)/10;
    for j = 1:10
        
        x0 = [pos_init(1),pos_init(2),pos_init(3),Errors(j,1),Errors(j,2),Errors(j,3)];
        t0 = Gravitional_Potential(pos_init(1),pos_init(2),pos_init(3));
        
        
        DataT(1)=0;
        DataX(1,:) = x0';
        for k = 1:20000
            
            %����ѧ
            t_control = tcontrol(DataX(end,1),DataX(end,2),DataX(end,3),pos_init);
            [~,x] = ode45(@DynamicEq,[DataT(end) DataT(end)+1],DataX(end,:),[],t0,t_control);
            DataT(k+1)= DataT(k)+1;%ʱ��
            DataX(k+1,:) = x(end,:);%״̬��
        end
        sum = sum + Solid_Angle(DataX,pos_init)/pi*180;
    end
    T(i,4) = sum/10;
    i
end


end


