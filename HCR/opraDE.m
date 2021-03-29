%在不知112个参数初始值的情况下，通过随机模拟，找到近似初始值
clear
clc
numb=10;%随机参数测试次数
Gmm=10;%迭代次数
aa=3;bb=4;%子图排列方式
best0=zeros(numb,112);%存放每次最优参数
best_val=zeros(Gmm,numb);%存放每次误差
for iii=1:numb
   DE
   best0(iii,:)=best_vector;
   best_val(:,iii)=trace_best_value(1:G,2);
end 

best=zeros(1,112);
for jjj=1:112
    best(jjj)=(sum(best0(:,jjj))-min(best0(:,jjj))-max(best0(:,jjj)))/(numb-2);
end

for kkk=1:numb
    figure(1)
    subplot(aa,bb,kkk);
    plot(1:Gmm,best_val(:,kkk));
end

figure(1)
subplot(aa,bb,numb+1);
plot(1:numb,best_val(end,1:numb));
title('每次最小误差汇总');


