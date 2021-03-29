function opr=operationCondition(pro, date)
% ------------------------------
% date为日期
% 所有单位均为标准单位
% 父函数有:
% DE
% 子函数有:
% [Fw_Feed, Ym, T_Input, T_Output]=getData(date)
% K=t2k(T)
% ------------------------------

% pro=common;

% 获得数据
opr.date=date;
[Fw_Feed, Ym, T_Input, T_Output]=getData(date);

opr.T_Input  = T_Input; % 单位 K /行向量
opr.T_Output = T_Output; % R2B4下温度没有,暂用底温度代替,两者差不多

% 产率
opr.Ym = Ym;

% 进料
opr.Fw_Feed = Fw_Feed;% kg/s
opr.Fv_Feed = opr.Fw_Feed/pro.p_Feed;% 原料油进料m^3/s
opr.u0 = opr.Fv_Feed/pro.area;% 反应物初始流速m/s
opr.detau0 = 0.2;% 速度u对反应器长度total_L的导数,即变化率
opr.C10=pro.p_Feed/pro.Mnave;% 初始进料浓度mol/m^3
opr.T0=t2k(400);% T0:无因次对比温度,取值为:673.15K

% 循环氢
T_Input_H2=63;% 冷氢温度,摄氏度
opr.T_H2=ones(1,pro.NumOfBed.Total)*t2k(T_Input_H2);% 240万吨加氢裂化装置物料平衡及操作数据.xlsx:Gas Quench Temperature

end
