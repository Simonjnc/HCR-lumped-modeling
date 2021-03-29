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
% 1VNA 2HNA 3MNA 4VN 5HN 6MN 7LN 8VA 9HA 10MA 11LA 12VP 13HP 14MP 15LP 16VS 17HS 18MS 19LS 20VNI 21HNI 22MNI 23LNI 24L
pro.Mn=[636.33 281 212 655.5 291 222 111.6 643 279 215 103.2 660 366 226 114 690 349.33 190.8 120.67 570 291 131 69 30.56]'/1000;% kg/mol
pro.C0=[1/6   0    0    1/6   0    0   0   1/6    0    0   0   1/6   0    0    0    1/6    0    0    0    1/6    0    0    0    0]'/100;% 初始质量百分含量
% pro.C0=[1.1200   15.9000    3.5500    0   0.7770    0.1160   0.0034    0    6.1600    0.9160    0.0269    0.6590   11.8000    6.4500    0.1480    4.9200   24.5000   10.5000  0.1870    0   9.0265  3.1800  0.0552   0]'/100;% 初始质量百分含量
pro.Mnave=pro.Mn'*pro.C0/sum(pro.C0);
% pro.Mn=[350.39	220.32	152.97	102.06	71.58	23.15]'/1000;% kg/mol
pro.aa=calculateCoefficient(pro.Mn);

% 进料
pro.p_Feed=920.6;% 原料油密度kg/m^3(20℃)
% 在标准条件下（0度,1atm）,空气密度约为1.29kg/m3。
% pro.p_H2=0.115297*1.29; % 氢气密度kg/m^3,0.115297为比重
pro.CpColdH2=8.89*1000; % J/(kg*K) （63℃）
pro.CpHotH2=9.438*1000; % J/(kg*K) （370℃）
%%%%%%%%注意,其中气体（混合物中仍呈液态）热容有待计算
%J/kg*K原料油、  柴油、 航煤、 重石、  轻石、 轻端  % 
% pro.Cp=[3326.9 2634.4 2623.6 2601.7 2476.3 1634];
pro.Cp=[0.53 0.395 0.477 0.4687 0.3907 0.33065 0.45067 0.454733 0.46 0.381524 0.389361 0.44734 0.45 0.36314 0.336995 0.44 0.45 0.425948 0.36907 0.44 0.45 0.360886 0.44734 0.45]'*4186;%J/kg*K

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
