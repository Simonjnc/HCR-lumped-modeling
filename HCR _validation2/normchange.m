%������������ʽ��ȡ97�����ܵķе���ֵ����ÿ�����ܵķе���չΪ��̬�ֲ��ķе㷶Χ��ת��Ϊһ��97*700�ķֲ�����
function [getnorm]=normchange(lump)
len=length(lump);
temp=zeros(97,725);
dev=-2.4:.1:2.4;%������̬�ֲ�ƫ���49���㣬Χ��ԭ�е�����24�棬���ݼ���������8���϶�����
norm=normpdf(dev,0,1);%��̬�ֲ�����
norm=norm./sum(norm);%��һ��

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
