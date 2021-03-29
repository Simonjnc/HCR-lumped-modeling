function [area, L]=getDimension
% ------------------------------
% 父函数有:
% pro=common
% 子函数无
% ------------------------------
area=3.14*4^2/4;% 反应器横截面积,m^2
%装填高度,没有算空高
L_R1B1=sum([190 470 485 870 5200 80 100])/1000;
L_R1B2=sum([70 6910 80 100])/1000;
L_R1B3=sum([100 9170 100 100 200])/1000;
L_R2B1=sum([100 70 3470 100 100])/1000;
L_R2B2=sum([100 3490 90 100])/1000;
L_R2B3=sum([100 3480 90 100])/1000;
L_R2B4=sum([100 3680 1510 100 100 200])/1000;

L=[L_R1B1 L_R1B2 L_R1B3 L_R2B1 L_R2B2 L_R2B3 L_R2B4]';% 床层高度,m
end