close all
clear
clc
%% 参数初始化
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

xmin = k0E*0.9;
xmax = k0E*1.1;

% 物性数据及操作条件
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

%% GA初始参数
popsize=20;                         %群体大小
chromlength=21;                  %染色体数量，即问题的维数
pc=0.8;                                %交叉概率，只有在随机数小于pc时，才会产生交叉
pm=0.01;                           %变异概率
Gm = 50;                          %迭代次数
% best_pop = ones(1,chromlength);      %记录最优个体
% best_fit = 0;                                        %记录最优适应度值
%% 开始迭代
t0 = cputime;
for i=1:popsize
    pop(i,:) = (xmax-xmin).*rand(1,chromlength) + xmin;  % 产生1个D维向量
    fitvalue(i) = object_fun_multiCase( pop(i,:), pro, opr_multi, OBJparameter ); %个体适应度
end

for G=1:Gm
     cputime1 = cputime;
%     pop=initpop(popsize,chromlength); %随机产生初始群体

    [notebestindividual ,notebestfit]=best(pop,fitvalue);
    [newpop]=selection(pop,fitvalue);               %复制
    
    [newpop]=crossover(newpop,pc);               %交叉              
        
%     [newpop]=mutation(newpop,pm);               %变异
%%%%%%%%%%%%%%%%%%%%%%%    变异操作    %%%%%%%%%%%%%%%%%%%%%
     for mu = 1:popsize
            % 产生j,k,p三个不同的数
            a = 1;
            b = popsize;
            dx = randperm(b-a+1) + a- 1;% 产生a~b的随机排列
            j = dx(1);
            k = dx(2);
            p = dx(3);
            % 要保证与i不同
            if j == mu
                j  = dx(4);
            elseif k == mu
                k = dx(4);
            elseif p == mu
                p = dx(4);
            end

            % 变异算子
            suanzi = exp(1-Gm/(Gm + 1-G)); %自适应算子
            F = pm*2^suanzi;  %自适应变异率在pm~2pm之间

            % 变异的个体来自三个随机父代        
            son = newpop(p,:) + F*(newpop(j,:) - newpop(k,:));
            for j = 1: chromlength
                if son(1,j) >xmin(j) && son(1,j) < xmax(j) % 防止变异超出边界
                    newpop(mu,j) = son(1,j); % son(1,j)=son(j),因为son是行向量
                else
                    newpop(mu,j) = (xmax(j) - xmin(j))*rand(1) + xmin(j);
                end
            end
     end
    
    newpop(1,:) =  notebestindividual; %继承前一代的最好个体
    fitvalue(1) = notebestfit;
    
    for ip=1:popsize
        fitvalue(ip) = object_fun_multiCase( newpop(ip,:), pro, opr_multi, OBJparameter ); %重新计算种群个体适应度
    end
    
    [bestindividual ,bestfit]=best(newpop,fitvalue);     %求出群体中适应值最大的个体及其适应值
    
    youhuaindividual(G,:) = bestindividual;
    youhuazhi(G)=bestfit;                                                              %返回的 y 是自适应度值，而非函数值

    pop = newpop;
    cputime2 = cputime;
    
    disp(['已过',num2str(G),'代，','适应度值为：',num2str(bestfit),'所花时间为：',num2str(cputime2-cputime1)]);
end
t_all = cputime-t0;
best_vector = bestindividual; %记录最优向量

save('HCR6_GA_DATA'); % 保存最终结果

figure;
youhuazhi = 1./(youhuazhi/100);
plot(1:Gm,youhuazhi);

legend('适应度曲线');
xlabel('迭代次数');
ylabel('适应度');