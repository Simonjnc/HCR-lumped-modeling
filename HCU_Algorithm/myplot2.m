% load matlab
%%
x1=1:88;
figure(1)
plot(x1,k0E(1:88),'r');
hold on
plot(x1,best_vector(1:88),'b');
title('88个反应指前因子优化前后对比')
legend('初始值','优化后的值')
%%
% x1=1:23;
% figure(1)
% plot(x1,k0E(89:111),'r');
% hold on
% plot(x1,best_vector(89:111),'b');
% title('23个反应活化能优化前后对比')
% legend('初始值','优化后的值')