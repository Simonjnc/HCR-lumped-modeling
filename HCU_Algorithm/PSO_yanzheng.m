%使用真实炼油厂数据进行检验
clc;
clear;
load HCR6_PSO_DATA.mat
clearvars -except best_vector
X0=best_vector;%带入HCR取代之前的x_DE
date_multi=11:20;
heat_HCR1index=[6.0 2.2 1.6]';
heat_HCR2index=[0.5 0.8 1.2 0.45]';
pro=common(heat_HCR1index, heat_HCR2index);

days=length(date_multi);% 样本数
opr_multi(days)=operationCondition(pro, date_multi(days)); % 操作条件结构数组初始化
for j=1:days-1
    % 注:如果1>days-1,即days==1,对应为单样本优化,则for语句不执行
    date=date_multi(j);
    opr_multi(j)=operationCondition(pro, date);
end

%% 模拟预测,转化为实际产品产量，按照集总的沸点切割
Yield = zeros(days,6); %每天每种产品的产率
error=zeros(days,6); %每天每种产品产品和实际的误差质量百分含率，单位为%
error_mean=zeros(days,1); %每天所有产品的平均误差
for i=1:days
    [YandTlast, ~]=HCR(X0,'optimization',pro,opr_multi(i));
    Yield(i,:) = YandTlast(15:20);
    error(i,:)  = abs( YandTlast(15:20) - opr_multi(i).Ym );
    error_mean(i) = mean(error(i,:));
end

 Y = mean(Yield); %每种产品的平均产率
 E = mean(error); %每种产品的平均误差
 E_All = sum(E); %所有数据平均误差
