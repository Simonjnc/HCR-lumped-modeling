% load matlab
%%
x1=1:88;
figure(1)
plot(x1,k0E(1:88),'r');
hold on
plot(x1,best_vector(1:88),'b');
title('88����Ӧָǰ�����Ż�ǰ��Ա�')
legend('��ʼֵ','�Ż����ֵ')
%%
% x1=1:23;
% figure(1)
% plot(x1,k0E(89:111),'r');
% hold on
% plot(x1,best_vector(89:111),'b');
% title('23����Ӧ����Ż�ǰ��Ա�')
% legend('��ʼֵ','�Ż����ֵ')