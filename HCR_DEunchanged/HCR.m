function [YandT, Fw_H2]=HCR(x_DE, flag, pro, opr, num)
% function YandT=HCR(kkk0,EEE,Eplus,flag,date)
% ------------------------------
% 加氢裂化主程序
% 父函数Parents (calling functions):
% fun=object_fun(x_DE, pro, opr)
% 子函数Children (called functions):
% ode15s
% dCondition=ode15s_hcr(~,Condition,k0,E,bed,pro,opr,Fw_H2_next)
% T=k2t(K)
% [Fw_H2_next, InitialCondition]=calculateInitialCondition(lastCondition,bed,pro,opr)
% C_mass=mol2mass(C, Mn, vorm)
% yw=mass2yield(Fm)
% ------------------------------

%% 获得公用数据
% pro=common; % 参数传进来而不是计算,节省时间
% opr=operationCondition(date);
NumOfBed=pro.NumOfBed.Total;
% C10=opr.C10;% 初始进料浓度mol/m^3
% T0=opr.T0;% 单位K
% T_Input1=opr.T_Input(1);
Fw_H2_next=0;

%% 传递k0&E
kkk0=x_DE(1:88);
EEE=x_DE(89:111);
Eplus=x_DE(112);
% 指前因子
k0=[kkk0;kkk0];
% 反应活化能
E1=EEE(1);E2=EEE(2);E3=EEE(3);E4=EEE(4);E5=EEE(5);E6=EEE(6);E7=EEE(7);E8=EEE(8);E9=EEE(9);E10=EEE(10);E11=EEE(11);E12=EEE(12);E13=EEE(13);E14=EEE(14);E15=EEE(15);E16=EEE(16);E17=EEE(17);E18=EEE(18);E19=EEE(19);E20=EEE(20);E21=EEE(21);E22=EEE(22);E23=EEE(23);
E(2,:)=[E8 E1 E9 E2 E9 E3 E10 E10 E11 E12 E13 E14 E15 E17 E17 E17 E17 E12 E18 E18 E18 E1 E4 E2 E5 E5 E3 E6 E7 E8 E8 E1 E1 E4 E4 E2 E2 E2 E5 E5 E5 E9 E9 E9 E3 E3 E6 E6 E10 E10 E3 E6 E10 E11 E7 E16 E16 E19 E20 E20 E20 E20 E20 E21 E21 E21 E22 E22 E16 E16 E16 E17 E17 E17 E18 E18 E18 E18 E19 E19 E19 E16 E16 E21 E22 E23 E20 E20];% 反应活化能
E(1,:)=E(2,:)*Eplus;%Eplus>1

%% 归一化
% z=l/L:无因次高度；
% Tr=T/T0:无因次温度；
% T0:无因次对比温度,取值为:673.15K；
% Yij=Cij/C10:各段各集总组分无因次浓度向量；
% C10:反应器进口原料油的摩尔浓度,mol*m^-3；
% Rij-各段各集总组分无因次反应速率向量；
C0=[opr.C10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ]';% 初始浓度
Y0=C0/opr.C10;
Tr0=opr.T_Input(1)/opr.T0;
InitialCondition=[Y0;Tr0];% 初始条件


%% ode计算
% 每个反应床层迭代次数
% num=10;
% result=zeros(NumOfBed*num+1,7);
if nargin==4 % 如果输入参数是4个,即没有指定num,则num=3
    num=3; %num>=3,小于3时会报错,应该是系统函数ode15s的问题
end
result=zeros(NumOfBed*num,25);
YandT=zeros(1,2*NumOfBed+24);
Fw_H2=zeros(1,NumOfBed);

for bed=1:NumOfBed
    %=============
    %调用ode15s
    %为了更节省时间,无因次化应该在调用ode之前,这样每次ode计算的数据都是无因次化的数据
    %     z=linspace(0,1,num+1);%无因次化长度
    z=linspace(0,1,num);%无因次化长度
    Options=odeset('AbsTol',1e-9);
    [~,Condition]=ode15s(@ode15s_hcr,z,InitialCondition,Options,k0,E,bed,pro,opr,Fw_H2_next);
    Fw_H2(bed)=Fw_H2_next;
    %=============
    
    %     result((bed-1)*num+1:bed*num+1,:)=Condition;% 这里每次覆盖一个记录,如对1-11赋值,再对11-21赋值,11被覆盖,但是目前优化用的数据（YandT）是准确的,
    result((bed-1)*num+1:bed*num,:)=[Condition(:,1:24)*opr.C10  Condition(:,25)*opr.T0];%
    
    YandT(bed)         =k2t(result((bed-1)*num+1,  25));%进口温度
    YandT(NumOfBed+bed)=k2t(result(bed*num,25));%出口温度
    
    if bed<NumOfBed
        [Fw_H2_next, InitialCondition]=calculateInitialCondition(result(bed*num,:)',bed,pro,opr);
        InitialCondition=[InitialCondition(1:24)/opr.C10; InitialCondition(25)/opr.T0];
    end
end

C_mass=mol2mass(result(end,1:24)',pro.Mn,'v'); % 返回列向量
YandT(2*NumOfBed+1:end)=100*mass2yield(C_mass');

if strcmp(flag,'plot')
    YandT=result;
end

end
