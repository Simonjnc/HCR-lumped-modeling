%% 参数初始化
k0(1,1:5)  =[1280176 1086328 0841112 0042000 0045206];%原料->
k0(1,6:9)  =[0250815 0569612 0036000 0050900];%柴油->
k0(1,10:12)=[0290966 0039000 0062300];%航煤->
k0(1,13:14)=[0019000 0048000];%重石->
k0(1,15)   = 0057482;%轻石->
E1=81367.6;
E2=93052.0;
E3=76481.8;
E4=68662.7;
E5=64286.1;
k0E=[k0 E1 E2 E3 E4 E5 1.08];
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

%% SA初始参数
% N=20;%粒子数量
% temp=20;%初始温度
% T=50;%迭代次数
% k=0.1;%温度位移系数
% kt=0.05;%温度概率系数
% de=0.99;%温度降低速率
% minx=0;
% maxx=10;%区间
% (xmax-xmin).*rand(1,chromlength) + xmin;
% location=10*rand(1,N);%粒子初始位置
% present_value=equation(location);%粒子当前解


%% SA工具箱
ObjectiveFunction = @(x)object_fun_multiCase( x, pro, opr_multi, OBJparameter );   % Function handle to the objective function
X0 = k0E;   % Starting point
lb = k0E*0.9;     % Lower bound
ub = k0E*1.1;       % Upper bound

options = saoptimset('MaxIter',200,'StallIterLim',200,'TolFun',1e-15,'AnnealingFcn',@annealingfast,'InitialTemperature',50,'TemperatureFcn',@temperatureexp,'ReannealInterval',500,'PlotFcns',{@saplotbestx, @saplotbestf, @saplotx, @saplotf,@saplottemperature});

[x,fval] = simulannealbnd(ObjectiveFunction,X0,lb,ub,options);

best_vector = x;

save('HCR6_SA_DATA');
%% 开始迭代
% 
% for i=1:popsize
%     
%     pop(i,:) = (xmax-xmin).*rand(1,chromlength) + xmin;  % 产生1个D维向量
% 
% end
% 
% for t=1:T
% 
%     dx_av=k*temp;%当前温度下粒子平均移动距离
%     probability=exp(-1/(kt*temp));
%     disp(probability);
%     temp=temp*de;%温度变化
% 
%     for p=1:N
% 
%         dx=0.5*dx_av*randn+dx_av;%以平均移动距离为中心正态分布，
% 
%         if rand>0.5  %0.5的概率为-
%             dx=-dx;
%         end
% 
%         local=location(p)+dx;
% 
%         if (local<maxx)&&(local>minx)%判断是否越界
%             local_value=equation(local);
% 
%             if local_value>present_value(p)
%                 location(p)=local;
%                 present_value(p)=local_value;
%             elseif rand<probability
%                 location(p)=local;
%                 present_value(p)=local_value;
%             end
% 
%         end
%     end
% end
% end
% 
% 
% x=minx:0.01:maxx;
% y=equation(x);
% plot(x,y);
% hold on;
% plot(location, present_value,'*');
% disp(location);
% 
% function y=equation(x)
% y=10*cos(0.4*pi*x).*sin(0.1*pi*x);
% end


