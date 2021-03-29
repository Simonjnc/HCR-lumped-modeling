function pro=common(heat_HCR1index, heat_HCR2index)
% ------------------------------
% 父函数有:
% DE
% 子函数有:
% [area, L]=getDimension
% Coefficient=calculateCoefficient(Mn)
% ------------------------------

% 所有单位均为标准单位
% 所有向量均为列向量

% 装置尺寸
pro.NumOfBed.Reactor1=3;% 加氢精制反应器床层数
pro.NumOfBed.Reactor2=4;% 加氢裂化反应器床层数
pro.NumOfBed.Total=pro.NumOfBed.Reactor1+pro.NumOfBed.Reactor2;% 总床层数
[area, L]=getDimension;
pro.area=area;% 反应器横截面积,m^2
pro.L=L;% 床层高度,m
pro.total_L=sum(pro.L);% 床层总高度,m

% 平均分子质量Mn(g/mol)
% 1Feed	2Diesel	3Kerosene	4HeavyNaphtha	5LightNaphtha	6轻端
pro.Mn=[350.39	220.32	152.97	102.06	71.58	23.15]'/1000;% kg/mol
pro.aa=calculateCoefficient(pro.Mn);

% 进料
pro.p_Feed=905.2;% 原料油密度kg/m^3(20℃)
% 在标准条件下（0度,1atm）,空气密度约为1.29kg/m3。
% pro.p_H2=0.115297*1.29; % 氢气密度kg/m^3,0.115297为比重
pro.CpColdH2=8.89*1000; % J/(kg*K) （63℃）
pro.CpHotH2 =9.438*1000; % J/(kg*K) （370℃）
%%%%%%%%注意,其中气体（混合物中仍呈液态）热容有待计算
%J/kg*K原料油、  柴油、 航煤、 重石、  轻石、 轻端  % 
% pro.Cp=[3326.9 2634.4 2623.6 2601.7 2476.3 1634];
pro.Cp=[3.05	3.18	3.19	3.41	3.50	3.58]'*1000;%J/kg*K

% 反应
% 加氢为放热,裂化吸热,综合为放热
% 《石油炼制工程》p269页的表格显示单体烃加裂反应热大致在60kJ/mol左右
% pro.heat_HCR=[297000 197000 127000];% J/mol,加氢裂化反应热297000
% pro.heat_HCR=[60000 60000 60000];% J/mol,加氢裂化反应热297000
% pro.heat_HCR2=40000;% J/mol,加氢裂化反应热297000
heat=60000;
pro.heat_HCR1=[heat heat heat]'.*heat_HCR1index;% J/mol
pro.heat_HCR2=[heat heat heat heat]'.*heat_HCR2index;

pro.R=8.314472145136;% R一气体常数,8.314J*mol^-1*K^-1;
