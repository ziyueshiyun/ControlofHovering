function xyPlanePoints(  )
%��xozƽ��������һ����������ĵ�����꣬������x02,y02,z02��
%������״ȡ15x6x7km��С������x,y����-40km��40kmȡ�㣬���1000m
A = 15000;
B = 7000;
%C = 6000;
mSize = 1;
Res = zeros(5000,3);%��Ϊ80*80 = 6400����������ȡ
for i = -50000 : 2000: 50000
    for j = -50000: 2000 : 50000
        if i^2/A^2 + j^2/B^2 > 1
            Res(mSize,1) = i;
            Res(mSize,2) = j;
            mSize  = mSize + 1;
        end
    end
end
xyPos = Res(1:mSize-1,:);
disp('�ɹ��������ļ�xyPos.mat');
save xyPos;
end

