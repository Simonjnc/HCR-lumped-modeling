%�ڲ�֪112��������ʼֵ������£�ͨ�����ģ�⣬�ҵ����Ƴ�ʼֵ
clear
clc
numb=10;%����������Դ���
Gmm=10;%��������
aa=3;bb=4;%��ͼ���з�ʽ
best0=zeros(numb,112);%���ÿ�����Ų���
best_val=zeros(Gmm,numb);%���ÿ�����
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
title('ÿ����С������');


