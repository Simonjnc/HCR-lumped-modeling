clc
clear 
close all

%% 初始化ACO参数
% 指前因子
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

E=0.001;
maxnum=5;%最大迭代次数
narvs=21;%目标函数的自变量个数
particlesize=20;%粒子群规模
c1=2;%每个粒子的个体学习因子，加速度常数
c2=2;%每个粒子的社会学习因子，加速度常数
w=0.6;%惯性因子
vmax=5;%粒子的最大飞翔速度
v=2*rand(particlesize,narvs);%粒子飞翔速度
x=(rand(particlesize,1).*0.2 + 0.9 )*k0E;%粒子所在位置
%定义适应度函数
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

%% PSO优化

% fitness=inline('(x(1)^2+x(2)^2)/10000','x');
for i=1:particlesize
	f(i)=object_fun_multiCase( (x(i,:)), pro, opr_multi, OBJparameter );
end
personalbest_x=x; %
personalbest_faval=f; %
[globalbest_faval,i]=min(personalbest_faval);
globalbest_x=personalbest_x(i,:); 
k=1;
while (k<=maxnum)
	for i=1:particlesize
			f(i)=object_fun_multiCase( (x(i,:)), pro, opr_multi, OBJparameter );
		if f(i)<personalbest_faval(i)
			personalbest_faval(i)=f(i);
			personalbest_x(i,:)=x(i,:);
		end
	end
	[globalbest_faval,i]=min(personalbest_faval);
	globalbest_x=personalbest_x(i,:);
	for i=1:particlesize
		v(i,:)=w*v(i,:)+c1*rand*(personalbest_x(i,:)-x(i,:))...
			+c2*rand*(globalbest_x-x(i,:));
		for j=1:narvs
			if v(i,j)>vmax
				v(i,j)=vmax;
			elseif v(i,j)<-vmax
				v(i,j)=-vmax;
            end
		end
		x(i,:)=x(i,:)+v(i,:);
    end
    ff(k)=globalbest_faval;
    if globalbest_faval<E
        break
    end
%       figure(1)
%       for i= 1:particlesize
%       plot(x(i,1),x(i,2),'*')
%       end
	k=k+1
end
xbest=globalbest_x;
figure(2)
set(gcf,'color','white');
plot(1:length(ff),ff)

% save('HCR6_PSO_DATA');