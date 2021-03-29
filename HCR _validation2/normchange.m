%以行向量的形式获取97个集总的沸点数值，对每个集总的沸点扩展为正态分布的沸点范围，转化为一个97*700的分布矩阵
function [getnorm]=normchange(lump)
len=length(lump);
temp=zeros(97,725);
dev=-2.4:.1:2.4;%制造正态分布偏差，共49个点，围绕原沸点上下24℃，数据集中在上下8摄氏度左右
norm=normpdf(dev,0,1);%正态分布函数
norm=norm./sum(norm);%归一化

for ii=1:97
    a=round(lump(ii));
    for jj=25:700
        if jj==a
            count=1;
            for kk=jj-24:jj+24
                temp(ii,kk)=temp(ii,kk)+norm(count);
                count=count+1;
            end
        end
    end
end
getnorm=temp;
