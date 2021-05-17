clear;
load('xyPos.mat');
T = My_Plot(xyPos);
% T = My_Plot(yzPos);

save T;
% T(:,4) = T(:,4)*(180/pi)^2;
Tsize = size(T,1);
% ��С���㼯��
Tmin = zeros(1,4);
im = 1;
% �е����㼯��
Tmed = zeros(1,4);
me = 1;
% �Ƚϴ����㼯��
Tmax = zeros(1,4);
ma = 1;

% ƫ��ƽ���ļ���
Tmm = zeros(1,4);
mk  = 1;
for k = 1:Tsize
    
    if T(k,4) < 0.2
        Tmin(im,:) = T(k,:);
        im = im + 1;
    elseif T(k,4) < 0.4
        Tmed(me,:) = T(k,:);
        me = me +1;
    elseif T(k,4) < 0.6
        Tmax(ma,:) = T(k,:);
        ma = ma+1;
    else
        Tmm(mk,:) = T(k,:);
        mk = mk+1;
    end
end
% figure;
scatter(Tmin(:,1),Tmin(:,2),20,'k.');
hold on;
scatter(Tmed(:,1),Tmed(:,2),20,'rx');
hold on;
scatter(Tmax(:,1),Tmax(:,2),20,'g+');
hold on; 
scatter(Tmm(:,1),Tmm(:,2),20,'yd');