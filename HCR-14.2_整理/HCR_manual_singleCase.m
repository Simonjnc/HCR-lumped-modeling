% ------------------------------
% 多样本手调参数
% 父函数无
% 子函数有:
% common
% operationCondition(date)
% ode15s
% ode15s_hcr(~,Condition,k0,E,bed,pro,opr,Fw_H2_next)
% k2t(K)
% calculateInitialCondition(lastCondition,bed,pro,opr)
% ------------------------------
clear
close all
clc

date=1;
pro=common([0 0 0]',[0 0 0 0]');
opr=operationCondition(pro, date);
NumOfBed=pro.NumOfBed.Total;
Fw_H2_next=0;

% load best_vector
% 指前因子
k0(1,1 :5 )=[1270176 1016328 0911112 0040000 0050206];%原料->
k0(1,6 :9 )=[0250815 0549612 0040000 0050900];%柴油->
k0(1,10:12)=[0280966 0040000 0060300];%航煤->
k0(1,13:14)=[0020000 0052000];%重石->
k0(1,15)   = 0061482;%轻石->
% k0(1,:)    =best_vector(1:15);
k0(2,:)=k0(1,:);

% EEE=best_vector(16:20);
% E1=EEE(1);E2=EEE(2);E3=EEE(3);E4=EEE(4);E5=EEE(5);
% 《石油炼制工程》p230:减压瓦斯油裂化活化能125-210kJ/mol,但也是虚拟数值,p244也有些数据
E1=81367.6;
E2=93052.0;
E3=80481.8;
E4=70662.7;
E5=69286.1;
% Eplus=best_vector(21);
E(1,:)=[E1 E1 E1 E1 E1 E2 E2 E2 E2 E3 E3 E3 E4 E4 E5]*1.1;% 反应活化能1.07
E(2,:)=[E1 E1 E1 E1 E1 E2 E2 E2 E2 E3 E3 E3 E4 E4 E5]*1;%0.96
% E=ones(1,15)*0.7e5;

% date=1;
% [~, ~, T_Input, T_Output]=getData(date);
% detaT=T_Output-T_Input;
% coefficient=detaT./L;
heat=60000;
% heat_=zeros(1,7);
% for i=1:7
%     heat_(i)=heat*coefficient(i)/2;
% end
% heat_ZJ=heat_(1:3)*exp(1.1);
% heat_LH=heat_(4:7);
% heat_ZJ=[heat heat heat].*[6.0 2.2 1.6];
% heat_LH=[heat heat heat heat].*[0.5 0.8 1.2 0.45];
heat_ZJ=[heat heat heat].*[8.6 2.7 1.8];
heat_LH=[heat heat heat heat].*[1.1 0.9 1.0 0.6];
pro.heat_HCR1=heat_ZJ;
pro.heat_HCR2=heat_LH;

C0=[opr.C10 0 0 0 0 0]';% 初始浓度
Y0=C0/opr.C10;
Tr0=opr.T_Input(1)/opr.T0;
InitialCondition=[Y0;Tr0];% 初始条件

% 每个反应床层迭代次数
% num=10;
% result=zeros(NumOfBed*num+1,7);
num=11; %num>=3,小于3时会报错,应该是系统函数ode15s的问题
result=zeros(NumOfBed*num,7);
YandT=zeros(1,6+2*NumOfBed);
Fw_H2=zeros(1,NumOfBed);

for bed=1:NumOfBed
    %=============
    %调用ode15s
    %为了更节省时间,无因次化应该在调用ode之前,这样每次ode计算的数据都是无因次化的数据
    z=linspace(0,1,num);%无因次化长度
    Options=odeset('AbsTol',1e-9);
    [z,Condition]=ode15s(@ode15s_hcr,z,InitialCondition,Options,k0,E,bed,pro,opr,Fw_H2_next);
    Fw_H2(bed)=Fw_H2_next;
    %=============
    
    %     result((bed-1)*num+1:bed*num+1,:)=Condition;% 这里每次覆盖一个记录,如对1-11赋值,再对11-21赋值,11被覆盖,但是目前优化用的数据（YandT）是准确的,
    result((bed-1)*num+1:bed*num,:)=[Condition(:,1:6)*opr.C10  Condition(:,7)*opr.T0];%
    
    if bed<NumOfBed
        [Fw_H2_next, InitialCondition]=calculateInitialCondition(result(bed*num,:)',bed,pro,opr);
        InitialCondition=[InitialCondition(1:6)/opr.C10; InitialCondition(7)/opr.T0];
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plotwhat.NormOrReal='Norm';        %
% plotwhat.NormOrReal='Real';
plotwhat.Fv  = 'no';               %
plotwhat.Fmol= 'no';               %
plotwhat.Fm  = 'no';               %
plotwhat.Yw  = 'yes';              %
plotwhat.T   = 'yes';              %
plotwhat.Fw_H2   = 'ye';          %
plotwhat.myTitle = '手调';      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
myplot(result, Fw_H2, pro, opr, plotwhat);

