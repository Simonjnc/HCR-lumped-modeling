function [Fw_Feed, Ym, T_Input, T_Output]=getData(date)
% ------------------------------
% date为日期列/行向量,代表多样本参数优化
% 返回值的单位均为标准单位
% 父函数有:
% opr=operationCondition(pro, date)
% 子函数有:
% K=t2k(T)
% ------------------------------

%2016/3/1-3/21数据
feed=[
% 进料	    出料
224.7468	217.0344
231.1071	219.7491
227.7724	222.0770
226.5573	222.7255
226.8736	222.3386
225.1566	222.9903
211.8691	209.2586
229.4836	220.8575
220.5463	221.7726
197.9398	219.5187
217.0326	222.4465
226.5946	222.7729
226.6898	223.2673
226.2467	221.9029
218.9190	217.8991
216.4323	213.6842
220.9053	216.5608
221.1638	217.2775
220.5463	217.6008
213.9910	211.3170
207.0234	202.9962
]*1000/3600;% kg/s
Fw_Feed=feed(date,1);

yield=[
%尾油比  柴油比  航煤比   重石比  轻石比  轻端比
0.2715	0.2758	0.1997	0.1992	0.0130	0.0408
0.2735	0.2743	0.2034	0.1995	0.0087	0.0407
0.2661	0.2873	0.1996	0.1913	0.0156	0.0400
0.2737	0.2846	0.1936	0.1926	0.0153	0.0403
0.2568	0.2933	0.1986	0.1963	0.0143	0.0407
0.2658	0.2871	0.1981	0.1938	0.0149	0.0404
0.2722	0.2824	0.1984	0.1924	0.0141	0.0405
0.2681	0.2845	0.1980	0.1918	0.0182	0.0394
0.2666	0.2828	0.1967	0.1955	0.0183	0.0401
0.2633	0.2827	0.1956	0.2007	0.0162	0.0415
0.2763	0.2798	0.1874	0.1998	0.0152	0.0415
0.2695	0.2832	0.1902	0.1983	0.0162	0.0426
0.2661	0.2847	0.1883	0.2024	0.0147	0.0439
0.2509	0.2938	0.1914	0.2061	0.0141	0.0437
0.2475	0.2932	0.1962	0.2028	0.0173	0.0430
0.2300	0.3045	0.1966	0.2068	0.0175	0.0445
0.2523	0.2895	0.1966	0.2020	0.0180	0.0414
0.2542	0.2866	0.1981	0.2003	0.0184	0.0424
0.2664	0.2782	0.1937	0.2019	0.0170	0.0429
0.2663	0.2869	0.1947	0.1956	0.0174	0.0391
0.2712	0.2941	0.1911	0.1890	0.0168	0.0378
]*100;
Ym=yield(date,:);

% % 床层温度,测温点共有8个,数据为A点温度,以后可以采用8个点的平均值即TIC的数据
% T_R1=[
% %R1B1上 R1B1下  R1B2上  R1B2下  R1B3上  R1B3下
% 341.4	366.0	357.7	368.3	368.0	382.1
% 339.7	363.4	356.9	368.0	368.6	383.4
% 339.5	363.5	356.7	368.1	368.3	383.2
% 339.2	363.5	356.2	368.4	368.0	383.4
% 339.5	364.3	356.1	367.8	367.9	382.8
% 339.6	364.4	355.9	367.3	367.5	382.0
% 339.9	363.8	357.1	368.6	367.8	382.5
% 342.0	367.1	358.7	370.7	368.3	383.1
% 340.9	366.5	358.9	370.8	367.3	382.4
% 340.2	365.1	357.2	368.6	367.1	381.7
% 340.6	366.3	356.0	366.4	366.8	381.8
% 341.4	367.5	356.9	367.8	367.4	382.0
% 341.5	367.4	356.9	367.5	367.2	381.6
% 340.7	366.4	355.9	366.4	366.6	381.5
% 340.3	365.8	355.6	366.3	365.9	380.1
% 340.9	365.8	357.0	368.3	367.1	381.0
% 340.5	366.1	356.0	366.9	366.3	381.9
% 340.4	366.6	355.8	366.8	366.0	380.6
% 340.8	367.8	355.0	365.8	365.0	380.1
% 339.9	367.6	354.1	364.5	364.0	379.4
% 339.5	365.8	354.5	364.6	364.7	379.3
% ];

% 床层温度,测温点共有8个,取平均值
T_R1=[
%R1B1进 R1B1下  R1B2上  R1B2下  R1B3上  R1B3下
333.5	366.7	356.8	370.5	367.0	381.7
332.1	364.3	356.1	370.0	367.4	382.5
332.0	364.3	356.0	369.9	367.2	382.5
331.6	364.3	355.7	370.0	366.9	382.7
331.6	364.9	355.5	369.9	366.9	382.2
331.8	365.1	355.4	369.4	366.7	381.4
332.7	364.7	356.3	370.7	366.8	381.7
334.5	367.9	358.3	372.8	367.1	382.3
333.1	367.3	358.1	372.9	365.9	381.4
332.6	365.8	356.6	370.7	366.0	381.0
332.9	367.1	355.3	369.1	365.8	381.3
333.7	368.3	356.2	370.4	366.3	381.3
333.8	368.2	356.1	370.2	366.3	381.1
333.1	367.2	355.2	369.1	365.5	380.8
332.7	366.6	355.0	368.9	365.0	379.5
333.5	366.7	356.6	370.9	366.4	380.6
332.8	367.1	355.3	369.5	365.2	381.3
332.9	367.4	355.0	369.6	365.1	380.2
333.3	368.7	354.3	368.4	364.3	379.8
332.7	368.5	353.2	367.2	363.3	379.1
332.5	366.9	353.7	367.1	363.9	378.9
];


% T_R2=[
% %R2B1上 R2B1下  R2B2上  R2B2下  R2B3上  R2B3下   R2B4上  R2底
% 382.7	392.3	380.4	392.0	379.3	394.4	382.5	390.6
% 383.4	393.9	380.4	392.4	380.1	396.0	382.7	391.6
% 382.6	393.0	379.6	391.3	379.5	395.2	382.1	391.0
% 381.6	392.2	378.3	390.1	378.4	394.2	381.4	390.5
% 382.6	392.9	379.4	391.2	379.3	395.1	382.5	391.3
% 383.2	393.5	380.1	392.6	379.8	396.4	382.6	391.9
% 381.8	391.4	379.2	391.0	377.9	393.5	380.5	389.3
% 385.0	393.8	380.6	392.6	380.0	396.4	382.9	391.8
% 384.3	393.2	380.7	392.4	379.8	396.1	382.6	390.7
% 383.1	392.6	380.2	391.8	379.5	395.8	382.6	390.9
% 382.4	392.6	378.8	390.7	378.6	395.0	382.1	391.0
% 381.9	391.7	378.3	390.2	378.6	395.4	382.6	392.2
% 382.5	392.1	378.7	390.2	379.0	395.7	383.2	392.7
% 382.0	392.1	377.9	389.6	378.3	394.9	382.4	391.9
% 382.2	391.9	378.8	390.9	378.3	395.0	381.8	391.2
% 382.1	391.9	378.8	390.6	378.4	394.6	382.3	392.1
% 380.8	391.3	377.8	389.2	377.2	392.8	381.1	390.4
% 381.7	392.4	378.3	390.5	378.0	393.8	381.7	391.1
% 381.4	392.1	378.2	390.2	377.4	392.5	381.1	390.2
% 381.3	392.3	377.7	390.1	376.6	391.7	380.8	389.5
% 381.7	392.5	378.6	391.4	377.3	392.6	380.6	389.1
% ];

T_R2=[
%R2B1进 R2B1下  R2B2上  R2B2下  R2B3上  R2B3下   R2B4上  R2B4下
374.3	391.4	380.9	394.0	381.6	394.3	382.2	392.0
375.5	393.1	381.3	394.9	382.6	395.8	382.6	392.7
375.0	392.3	380.6	393.9	382.0	395.1	382.0	392.0
373.9	391.4	379.4	392.7	381.0	394.3	381.3	391.5
374.6	392.1	380.5	393.7	381.8	395.0	382.2	392.6
375.1	392.7	381.2	395.0	382.2	396.0	382.5	393.2
374.2	391.0	379.8	393.2	380.3	393.3	380.3	390.3
376.3	393.5	381.7	395.1	382.6	396.3	382.7	393.1
375.4	392.8	381.6	394.7	382.2	395.8	382.2	392.3
374.8	392.3	381.1	394.2	381.9	395.6	382.2	392.6
374.5	392.3	380.2	393.5	381.0	394.6	381.7	392.3
374.1	391.2	379.6	392.9	381.2	395.2	382.3	393.5
374.7	391.6	380.1	393.0	381.7	395.6	382.8	394.2
374.3	391.6	379.5	392.4	381.1	394.8	382.1	393.4
374.1	391.6	380.1	393.6	380.8	394.6	381.5	392.4
374.5	391.4	380.1	393.2	381.0	394.5	382.0	393.0
373.6	390.8	379.0	391.8	380.0	392.8	380.8	391.3
374.1	391.9	379.9	393.2	380.5	393.5	381.5	392.1
374.2	391.6	379.7	393.0	379.8	392.2	380.9	391.3
373.2	391.8	379.1	393.0	379.2	391.6	380.5	390.5
373.8	392.1	379.5	393.9	379.7	392.5	380.3	390.2
];


T_Input =[T_R1(date,[1 3 5]) T_R2(date,[1 3 5 7])];
T_Output=[T_R1(date,[2 4 6]) T_R2(date,[2 4 6 8])];
T_Input =t2k(T_Input);
T_Output=t2k(T_Output);