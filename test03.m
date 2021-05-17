clear;
load('xyPos.mat');
T = My_Plot(xyPos);
% T = My_Plot(yzPos);

save T;
% T(:,4) = T(:,4)*(180/pi)^2;
Tsize = size(T,1);
% 最小误差点集合
Tmin = zeros(1,4);
im = 1;
% 中等误差点集合
Tmed = zeros(1,4);
me = 1;
% 比较大误差点集合
Tmax = zeros(1,4);
ma = 1;

% 偏离平衡点的集合
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