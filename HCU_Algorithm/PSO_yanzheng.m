%ʹ����ʵ���ͳ����ݽ��м���
clc;
clear;
load HCR6_PSO_DATA.mat
clearvars -except best_vector
X0=best_vector;%����HCRȡ��֮ǰ��x_DE
date_multi=11:20;
heat_HCR1index=[6.0 2.2 1.6]';
heat_HCR2index=[0.5 0.8 1.2 0.45]';
pro=common(heat_HCR1index, heat_HCR2index);

days=length(date_multi);% ������
opr_multi(days)=operationCondition(pro, date_multi(days)); % ���������ṹ�����ʼ��
for j=1:days-1
    % ע:���1>days-1,��days==1,��ӦΪ�������Ż�,��for��䲻ִ��
    date=date_multi(j);
    opr_multi(j)=operationCondition(pro, date);
end

%% ģ��Ԥ��,ת��Ϊʵ�ʲ�Ʒ���������ռ��ܵķе��и�
Yield = zeros(days,6); %ÿ��ÿ�ֲ�Ʒ�Ĳ���
error=zeros(days,6); %ÿ��ÿ�ֲ�Ʒ��Ʒ��ʵ�ʵ���������ٷֺ��ʣ���λΪ%
error_mean=zeros(days,1); %ÿ�����в�Ʒ��ƽ�����
for i=1:days
    [YandTlast, ~]=HCR(X0,'optimization',pro,opr_multi(i));
    Yield(i,:) = YandTlast(15:20);
    error(i,:)  = abs( YandTlast(15:20) - opr_multi(i).Ym );
    error_mean(i) = mean(error(i,:));
end

 Y = mean(Yield); %ÿ�ֲ�Ʒ��ƽ������
 E = mean(error); %ÿ�ֲ�Ʒ��ƽ�����
 E_All = sum(E); %��������ƽ�����
