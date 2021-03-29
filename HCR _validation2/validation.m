%ʹ����ʵ���ͳ����ݽ��м���
clc;
clear;
load matlab
clearvars -except best_vector
X0=best_vector;%����HCRȡ��֮ǰ��x_DE
date_multi=1:20;
heat_HCR1index=[6.8 3 3]';
heat_HCR2index=[0.65 0.95 1.35 1]';
pro=common(heat_HCR1index, heat_HCR2index);

days=length(date_multi);% ������
opr_multi(days)=operationCondition(pro, date_multi(days)); % ���������ṹ�����ʼ��
for j=1:days-1
    % ע:���1>days-1,��days==1,��ӦΪ�������Ż�,��for��䲻ִ��
    date=date_multi(j);
    opr_multi(j)=operationCondition(pro, date);
end

%% ģ��Ԥ��,ת��Ϊʵ�ʲ�Ʒ���������ռ��ܵķе��и�
error_mean=zeros(days,1);
error_sum=zeros(days,1);
for i=1:days
    [YandTlast, ~]=HCR(X0,'optimization',pro,opr_multi(i));
    massvalue=YandTlast(11:34);
    molvalue0=YandTlast(11:34)./pro.Mn';
    molvalue=100*molvalue0/sum(molvalue0);
    lumpcal=zeros(97,4);
    concal=zeros(6,1);
    getnorm_sum=zeros(24,725);
    getnorm_sum2=zeros(24,725);
    lumpcal(:,1)=1:97;
    % 1VNA 2HNA 3MNA 4VN 5HN 6MN 7LN 8VA 9HA 10MA 11LA 12VP 13HP 14MP 15LP
    % 16VS 17HS 18MS 19LS 20VNI 21HNI 22MNI 23LNI 24L˳��ߵ�
    % lumpcal(:,2)=[-195.8 -33.43 -60.35 -252.8 -161.5 -88.6 -42.02 -11.72 27.84 60.26 89.78 115.6 124.1 174.2 253.6 316.7 412.7 563.7 71.81 100.9 119.4 156.7 187.3 262.3 270.9 271.2 325.5 334.7 335.1 372.0 375.0 375.4 381.7 569.2 581.7 582.1 588.5 80.09 110.6 138.4 165.2 207.6 264.0 296.2 326.7 360.0 372.1 400.5 443.5 481.3 569.2 607.7 652.0 691.1 219.9 84.16 165.0 248.6 258.9 266.0 352.2 371.7 448.7 458.8 468.1 610.5 700.2 86.57 129.9 232.5 237.2 266.0 448.7 479.7 479.7 692.2 603.5 286.1 299.0 318.1 333.4 349.9 363.9 383.6 396.5 390.3 404.8 414.9 424.2 424.2 437.1 597.3 611.7 622.5 632.0 645.3 645.3];
    lumpcal(:,2)=[25  25  25  25  25  25  25  25  27.84 60.26 89.78 115.6 124.1 174.2 253.6 316.7 412.7 563.7 71.81 100.9 119.4 156.7 187.3 262.3 270.9 271.2 325.5 334.7 335.1 372.0 375.0 375.4 381.7 569.2 581.7 582.1 588.5 80.09 110.6 138.4 165.2 207.6 264.0 296.2 326.7 360.0 372.1 400.5 443.5 481.3 569.2 607.7 652.0 691.1 219.9 84.16 165.0 248.6 258.9 266.0 352.2 371.7 448.7 458.8 468.1 610.5 700.2 86.57 129.9 232.5 237.2 266.0 448.7 479.7 479.7 692.2 603.5 286.1 299.0 318.1 333.4 349.9 363.9 383.6 396.5 390.3 404.8 414.9 424.2 424.2 437.1 597.3 611.7 622.5 632.0 645.3 645.3];
    getnorm=normchange(lumpcal(:,2));
    getnorm_sum(1,:)=sum(getnorm(1:9,:))/9.*massvalue(24);%���ܵ���������
    getnorm_sum(2,:)=sum(getnorm(10:14,:))/5.*massvalue(23);
    getnorm_sum(3,:)=sum(getnorm(15:16,:))/2.*massvalue(22);
    getnorm_sum(4,:)=getnorm(17,:)/1.*massvalue(21);
    getnorm_sum(5,:)=getnorm(18,:)/1.*massvalue(20);
    getnorm_sum(6,:)=sum(getnorm(19:23,:))/5.*massvalue(19);
    getnorm_sum(7,:)=sum(getnorm(24:29,:))/6.*massvalue(18);
    getnorm_sum(8,:)=sum(getnorm(30:33,:))/40.*massvalue(17);
    getnorm_sum(9,:)=sum(getnorm(34:37,:))/4.*massvalue(16);
    getnorm_sum(10,:)=sum(getnorm(38:42,:))/5.*massvalue(15);
    getnorm_sum(11,:)=sum(getnorm(43:46,:))/4.*massvalue(14);
    getnorm_sum(12,:)=sum(getnorm(47:50,:))/4.*massvalue(13);
    getnorm_sum(13,:)=sum(getnorm(51:54,:))/4.*massvalue(12);
    getnorm_sum(14,:)=sum(getnorm(55:57,:))/3.*massvalue(11);
    getnorm_sum(15,:)=sum(getnorm(58:62,:))/5.*massvalue(10);
    getnorm_sum(16,:)=sum(getnorm(63:65,:))/30.*massvalue(9);
    getnorm_sum(17,:)=sum(getnorm(66:67,:))/2.*massvalue(8);
    getnorm_sum(18,:)=sum(getnorm(68:69,:))/2.*massvalue(7);
    getnorm_sum(19,:)=sum(getnorm(70:72,:))/3.*massvalue(6);
    getnorm_sum(20,:)=sum(getnorm(73:75,:))/3.*massvalue(5);
    getnorm_sum(21,:)=sum(getnorm(76:77,:))/2.*massvalue(4);
    getnorm_sum(22,:)=sum(getnorm(78:85,:))/8.*massvalue(3);
    getnorm_sum(23,:)=sum(getnorm(86:91,:))/6.*massvalue(2);
    getnorm_sum(24,:)=sum(getnorm(92:97,:))/6.*massvalue(1);
    
    getnorm_sum2(1,:)=sum(getnorm(1:9,:))/9.*molvalue(24);%���ܵ���������
    getnorm_sum2(2,:)=sum(getnorm(10:14,:))/5.*molvalue(23);
    getnorm_sum2(3,:)=sum(getnorm(15:16,:))/2.*molvalue(22);
    getnorm_sum2(4,:)=getnorm(17,:)/1.*molvalue(21);
    getnorm_sum2(5,:)=getnorm(18,:)/1.*molvalue(20);
    getnorm_sum2(6,:)=sum(getnorm(19:23,:))/5.*molvalue(19);
    getnorm_sum2(7,:)=sum(getnorm(24:29,:))/6.*molvalue(18);
    getnorm_sum2(8,:)=sum(getnorm(30:33,:))/40.*molvalue(17);
    getnorm_sum2(9,:)=sum(getnorm(34:37,:))/4.*molvalue(16);
    getnorm_sum2(10,:)=sum(getnorm(38:42,:))/5.*molvalue(15);
    getnorm_sum2(11,:)=sum(getnorm(43:46,:))/4.*molvalue(14);
    getnorm_sum2(12,:)=sum(getnorm(47:50,:))/4.*molvalue(13);
    getnorm_sum2(13,:)=sum(getnorm(51:54,:))/4.*molvalue(12);
    getnorm_sum2(14,:)=sum(getnorm(55:57,:))/3.*molvalue(11);
    getnorm_sum2(15,:)=sum(getnorm(58:62,:))/5.*molvalue(10);
    getnorm_sum2(16,:)=sum(getnorm(63:65,:))/30.*molvalue(9);
    getnorm_sum2(17,:)=sum(getnorm(66:67,:))/2.*molvalue(8);
    getnorm_sum2(18,:)=sum(getnorm(68:69,:))/2.*molvalue(7);
    getnorm_sum2(19,:)=sum(getnorm(70:72,:))/3.*molvalue(6);
    getnorm_sum2(20,:)=sum(getnorm(73:75,:))/3.*molvalue(5);
    getnorm_sum2(21,:)=sum(getnorm(76:77,:))/2.*molvalue(4);
    getnorm_sum2(22,:)=sum(getnorm(78:85,:))/8.*molvalue(3);
    getnorm_sum2(23,:)=sum(getnorm(86:91,:))/6.*molvalue(2);
    getnorm_sum2(24,:)=sum(getnorm(92:97,:))/6.*molvalue(1);
    
    for ik=1:24
        concal(1)=concal(1)+sum(getnorm_sum(ik,1:50));%�����
        concal(2)=concal(2)+sum(getnorm_sum(ik,50:79));%��ʯ����
        concal(3)=concal(3)+sum(getnorm_sum(ik,80:270)); %��ʯ����
        concal(4)=concal(4)+sum(getnorm_sum(ik,271:354));%��ú
        concal(5)=concal(5)+sum(getnorm_sum(ik,355:419));%����
        concal(6)=concal(6)+sum(getnorm_sum(ik,420:end));%β��
    end


    concal=concal/sum(concal)*100;
    error_mean(i)=mean((abs(opr_multi(i).Ym-rot90(concal(:,1)',2))./opr_multi(i).Ym));%������ƽ��ֵ
    error_sum(i)=sum(abs(opr_multi(i).Ym-rot90(concal(:,1)',2)));%�������֮��
    disp(['��',num2str(i),'��  ģ�Ͳ��Խ��                ������Ʒ����']);
    disp(['�������������Ϊ��',num2str(concal(1)),'%            ',num2str(opr_multi(i).Ym(6)),'%']);
    disp(['��ʯ��������Ϊ��',num2str(concal(2)),'%              ',num2str(opr_multi(i).Ym(5)),'%']);
    disp(['��ʯ��������Ϊ��',num2str(concal(3)),'%              ',num2str(opr_multi(i).Ym(4)),'%']);
    disp(['��ú��������Ϊ��',num2str(concal(4)),'%             ',num2str(opr_multi(i).Ym(3)),'%']);
    disp(['������������Ϊ��',num2str(concal(5)),'%              ',num2str(opr_multi(i).Ym(2)),'%      ��',num2str(i),'��ԭ�����ݵ�������Ϊ��',num2str(100*error_mean(i)),'%.']);
    disp(['β����������Ϊ��',num2str(concal(6)),'%             ',num2str(opr_multi(i).Ym(1)),'%       ��',num2str(i),'��ԭ�����ݵľ������֮��Ϊ��',num2str(error_sum(i)),'%.']);
    note(i,1:6)=rot90(opr_multi(i).Ym,2);
    note(i,7:12)=concal(:,1);
    for kkk=1:6
        errornote(i,kkk)=abs(opr_multi(i).Ym(7-kkk)-concal(kkk));
    end
    
    %     disp(['��',num2str(i),'��  ģ�Ͳ��Խ����������Ʒ�������']);
    %     disp(['�������������Ϊ��',num2str(abs(concal(1)-opr_multi(i).Ym(6))),'%']);
    %     disp(['��ʯ��������Ϊ��',num2str(abs(concal(2)-opr_multi(i).Ym(5))),'%']);
    %     disp(['��ʯ��������Ϊ��',num2str(abs(concal(3)-opr_multi(i).Ym(4))),'%']);
    %     disp(['��ú��������Ϊ��',num2str(abs(concal(4)-opr_multi(i).Ym(3))),'%']);
    %     disp(['������������Ϊ��',num2str(abs(concal(5)-opr_multi(i).Ym(2))),'%%.']);
    %     disp(['β����������Ϊ��',num2str(abs(concal(6)-opr_multi(i).Ym(1))),'%.']);
    
    %     disp(['���ͳ�:',num2str(opr_multi(i).Ym)]);
    %     disp(['ģ�Ͳ��Խ����',num2str(rot90(concal(:,1)',2))]);
    %     disp(['�����Ħ������Ϊ��',num2str(concal(1,2)),'%']);
    %     disp(['��ʯĦ������Ϊ��',num2str(concal(2,2)),'%']);
    %     disp(['��ʯĦ������Ϊ��',num2str(concal(3,2)),'%']);
    %     disp(['��úĦ������Ϊ��',num2str(concal(4,2)),'%']);
    %     disp(['����Ħ������Ϊ��',num2str(concal(5,2)),'%']);
    %     disp(['β��Ħ������Ϊ��',num2str(concal(6,2)),'%']);
    
end
% for i=1:6
%     figure(i)
%     plot(1:20,note(:,i),'r.','markersize',15)
%     hold on
%     plot(1:20,note(:,i+6),'b','LineWidth',1.5)
%     legend('Ԥ��ֵ','ʵ��ֵ');
%     xlabel('���');
%     ylabel('�����ٷֺ���(%)');
% end
% 
% for i=1:6
%     figure(i)
%     plot(1:20,errornote(:,i),'r.','markersize',15)
%     legend('�������ֵ');
%     xlabel('���');
%     ylabel('�������(%)');
% end

figure(1)%ÿ��ͼ�����ƣ���һ��ͼ����
A(1,:)=sum(getnorm_sum);
plot(1:725,A(1,:),'-b','LineWidth',1.5);
legend('�¶�-�����ٷֺ�������');
xlabel('�¶�(��)');
ylabel('��������(%)');
% 
figure(2)%ÿ��ͼ�����ƣ���һ��ͼ����
B(1,:)=sum(getnorm_sum2);
plot(1:725,B(1,:),'-b','LineWidth',1.5);
legend('�¶�-Ħ���ٷֺ�������');
xlabel('�¶�(��)');
ylabel('Ħ������(%)');