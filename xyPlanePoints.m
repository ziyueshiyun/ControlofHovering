function xyPlanePoints(  )
%在xoz平面上生成一组在椭球外的点的坐标，保存在x02,y02,z02中
%椭球形状取15x6x7km大小，所以x,y均从-40km到40km取点，间隔1000m
A = 15000;
B = 7000;
%C = 6000;
mSize = 1;
Res = zeros(6500,3);%因为80*80 = 6400，先往大了取
for i = -40000 : 1000: 40000
    for j = -40000: 1000 : 40000
        if i^2/A^2 + j^2/B^2 > 1
            Res(mSize,1) = i;
            Res(mSize,2) = j;
            mSize  = mSize + 1;
        end
    end
end
xyPos = Res(1:mSize-1,:);
disp('成功生成了文件xyPos.mat');
save xyPos;
end

