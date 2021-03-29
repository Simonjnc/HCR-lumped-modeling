%% 清空环境
clear
clc

%% 参数设置
k0(1,1:5)  =[1270176 1016328 0911112 0040000 0050206];%原料->
k0(1,6:9)  =[0250815 0549612 0040000 0050900];%柴油->
k0(1,10:12)=[0280966 0040000 0060300];%航煤->
k0(1,13:14)=[0020000 0052000];%重石->
k0(1,15)   = 0061482;%轻石->
E1=81367.6;
E2=93052.0;
E3=80481.8;
E4=70662.7;
E5=69286.1;
k0E=[k0 E1 E2 E3 E4 E5 1.1];

Lb = k0E*0.9;
Ub = k0E*1.1;

Vmax = 1;
Vmin = -1;

w = 0.6;      % 惯性因子 
c1 = 2;       % 加速常数
c2 = 2;       % 加速常数

Dim = 21;            % 维数
SwarmSize = 10;    % 粒子群规模
% ObjFun = @PSO_PID;  % 待优化函数句柄

MaxIter = 10;      % 最大迭代次数  
MinFit = 0.1;       % 最小适应值 

date_multi=1:10; %选取时间

heat_HCR1index=[6.0 2.2 1.6]';
heat_HCR2index=[0.5 0.8 1.2 0.45]';
pro=common(heat_HCR1index, heat_HCR2index);

days=length(date_multi);% 样本数
opr_multi(days)=operationCondition(pro, date_multi(days)); % 操作条件结构数组初始化
for i=1:days-1 
    % 注:如果1>days-1,即days==1,对应为单样本优化,则for语句不执行
    date=date_multi(i);
    opr_multi(i)=operationCondition(pro, date);
end

% 目标函数参数
OBJparameter.AoR='A';
% OBJparameter.AoR='R';
OBJparameter.Weight=[1 1 1 1 1 1 1 20 20 20 20 20 20];


%% 粒子群初始化
    Range = ones(SwarmSize,1)*(Ub-Lb);
    Swarm = rand(SwarmSize,Dim).*Range + ones(SwarmSize,1)*Lb;      % 初始化粒子群
    VStep = rand(SwarmSize,Dim)*(Vmax-Vmin) + Vmin;             % 初始化速度
    fSwarm = zeros(SwarmSize,1);
for i=1:SwarmSize
    fSwarm(i,:) = object_fun_multiCase( Swarm(i,:), pro, opr_multi, OBJparameter );                        % 粒子群的适应值
end

%% 个体极值和群体极值
[bestf bestindex]=min(fSwarm);
zbest=Swarm(bestindex,:);   % 全局最佳
gbest=Swarm;                % 个体最佳
fgbest=fSwarm;              % 个体最佳适应值
fzbest=bestf;               % 全局最佳适应值

%% 迭代寻优
iter = 0;
y_fitness = zeros(1,MaxIter);   % 预先产生4个空矩阵
K_p = zeros(1,MaxIter);         
K_i = zeros(1,MaxIter);
K_d = zeros(1,MaxIter);
while( (iter < MaxIter) && (fzbest > MinFit) )
    for j=1:SwarmSize
        % 速度更新
        VStep(j,:) = w*VStep(j,:) + c1*rand*(gbest(j,:) - Swarm(j,:)) + c2*rand*(zbest - Swarm(j,:));
        if VStep(j,:)>Vmax, VStep(j,:)=Vmax; end
        if VStep(j,:)<Vmin, VStep(j,:)=Vmin; end
        % 位置更新
        Swarm(j,:)=Swarm(j,:)+VStep(j,:);
        for k=1:Dim
            if Swarm(j,k)>Ub(k), Swarm(j,k)=Ub(k); end
            if Swarm(j,k)<Lb(k), Swarm(j,k)=Lb(k); end
        end
        % 适应值
        fSwarm(j,:) = object_fun_multiCase( Swarm(i,:), pro, opr_multi, OBJparameter ); 
        % 个体最优更新     
        if fSwarm(j) < fgbest(j)
            gbest(j,:) = Swarm(j,:);
            fgbest(j) = fSwarm(j);
        end
        % 群体最优更新
        if fSwarm(j) < fzbest
            zbest = Swarm(j,:);
            fzbest = fSwarm(j);
        end
    end 
    iter = iter+1                     % 迭代次数更新
    y_fitness(1,iter) = fzbest;         % 为绘图做准备
    K_p(1,iter) = zbest(1);
    K_i(1,iter) = zbest(2);
    K_d(1,iter) = zbest(3);
end

figure(1)      % 绘制性能指标ITAE的变化曲线
plot(y_fitness,'LineWidth',2)
title('最优个体适应值','fontsize',18);
xlabel('迭代次数','fontsize',18);ylabel('适应值','fontsize',18);
set(gca,'Fontsize',18);