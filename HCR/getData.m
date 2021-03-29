function [Fw_Feed, Ym, T_Input, T_Output]=getData(date)
% ------------------------------
% dateΪ������/������,���������������Ż�
% ����ֵ�ĵ�λ��Ϊ��׼��λ
% ��������:
% opr=operationCondition(pro, date)
% �Ӻ�����:
% K=t2k(T)
% ------------------------------

%2016/3/1-3/21����
feed=[
% ����	    ����
208000  	212947
208000  	213000
208000  	212800
208000  	212890
208000      212933
208000      212829
208000	    212853
208000   	212966
208000	    212984
208000	    212984
208000	    212951
208000	    212901
208000	    212895
208000	    212888
208000	    212877
208000      212849
208000      212826
208000      212843
208000      212810
208000      212772
208000      212793
]/3600;% kg/s
Fw_Feed=feed(date,1);

yield=[
% 1VNA 2HNA 3MNA 4VN 5HN 6MN 7LN 8VA 9HA 10MA 11LA 12VP 13HP 14MP 15LP 16VS 17HS 18MS 19LS 20VNI 21HNI 22MNI 23LNI 24L
 0.0006    0.1655    0.0141         0    0.0030    0.0001         0         0    0.0047    0.0001         0    0.0001    0.0296    0.0028    0.0715    0.0140    0.2326    0.0250    0.0655    0.0001    0.1226    0.0328    0.1709    0.0444
 0.0005    0.1620    0.0138         0    0.0033    0.0001         0         0    0.0051    0.0001         0    0.0001    0.0307    0.0028    0.0722    0.0139    0.2300    0.0246    0.0672    0.0001    0.1210    0.0325    0.1740    0.0455
 0.0006    0.1680    0.0152         0    0.0034    0.0001         0         0    0.0052    0.0001         0    0.0001    0.0330    0.0032    0.0683    0.0145    0.2420    0.0265    0.0590    0.0001    0.1270    0.0339    0.1590    0.0403
 0.0006    0.1660    0.0145         0    0.0033    0.0001         0         0    0.0051    0.0001         0    0.0001    0.0317    0.0030    0.0701    0.0142    0.2370    0.0257    0.0626    0.0001    0.1250    0.0333    0.1660    0.0425
 0.0006    0.1640    0.0140         0    0.0032    0.0001         0         0    0.0050    0.0001         0    0.0001    0.0308    0.0029    0.0713    0.0140    0.2330    0.0250    0.0655    0.0001    0.1230    0.0329    0.1710    0.0443
 0.0006    0.1650    0.0150         0    0.0037    0.0001    0.0000    0.0000    0.0055    0.0001    0.0000    0.0001    0.0342    0.0032    0.0688    0.0144    0.2400    0.0263    0.0601    0.0001    0.1260    0.0337    0.1610    0.0410
 0.0006    0.1660    0.0145    0.0000    0.0033    0.0001    0.0000    0.0000    0.0050    0.0001    0.0000    0.0001    0.0317    0.0030    0.0700    0.0142    0.2370    0.0257    0.0625    0.0001    0.1250    0.0334    0.1660    0.0424
 0.0005    0.1610    0.0136    0.0000    0.0034    0.0001    0.0000    0.0000    0.0052    0.0001    0.0000    0.0001    0.0311    0.0028    0.0724    0.0139    0.2280    0.0244    0.0682    0.0001    0.1210    0.0324    0.1750    0.0460
 0.0006    0.1630    0.0138    0.0000    0.0032    0.0001    0.0000    0.0000    0.0049    0.0001    0.0000    0.0001    0.0302    0.0028    0.0722    0.0139    0.2300    0.0247    0.0670    0.0001    0.1220    0.0325    0.1740    0.0454
 0.0006    0.1660    0.0139    0.0000    0.0028    0.0001    0.0000    0.0000    0.0044    0.0001    0.0000    0.0001    0.0282    0.0027    0.0719    0.0140    0.2310    0.0248    0.0665    0.0001    0.1220    0.0327    0.1730    0.0450
 0.0006    0.1670    0.0143    0.0000    0.0029    0.0001    0.0000    0.0000    0.0046    0.0001    0.0000    0.0001    0.0296    0.0029    0.0710    0.0141    0.2350    0.0253    0.0641    0.0001    0.1240    0.0331    0.1690    0.0436
 0.0006    0.1660    0.0143    0.0000    0.0031    0.0001    0.0000    0.0000    0.0048    0.0001    0.0000    0.0001    0.0304    0.0029    0.0708    0.0141    0.2350    0.0253    0.0640    0.0001    0.1240    0.0331    0.1680    0.0434
 0.0006    0.1640    0.0139    0.0000    0.0032    0.0001    0.0000    0.0000    0.0049    0.0001    0.0000    0.0001    0.0305    0.0029    0.0715    0.0140    0.2320    0.0250    0.0656    0.0001    0.1230    0.0329    0.1710    0.0443
 0.0006    0.1670    0.0143    0.0000    0.0030    0.0001    0.0000    0.0000    0.0046    0.0001    0.0000    0.0001    0.0297    0.0029    0.0708    0.0141    0.2350    0.0254    0.0639    0.0001    0.1240    0.0332    0.1680    0.0433
 0.0006    0.1670    0.0143    0.0000    0.0030    0.0001    0.0000    0.0000    0.0046    0.0001    0.0000    0.0001    0.0297    0.0029    0.0708    0.0141    0.2350    0.0254    0.0639    0.0001    0.1240    0.0332    0.1680    0.0433
 0.0015    0.2010    0.0118    0.0000    0.0041    0.0001    0.0000    0.0000    0.0064    0.0001    0.0000    0.0002    0.0363    0.0026    0.0347    0.0396    0.2930    0.0249    0.0315    0.0003    0.1930    0.0347    0.0719    0.0118
 0.0015    0.2020    0.0121    0.0000    0.0040    0.0001    0.0000    0.0000    0.0063    0.0001    0.0000    0.0002    0.0366    0.0027    0.0339    0.0398    0.2950    0.0253    0.0300    0.0003    0.1940    0.0348    0.0694    0.0113
 0.0015    0.2010    0.0120    0.0000    0.0041    0.0001    0.0000    0.0000    0.0064    0.0001    0.0000    0.0002    0.0366    0.0027    0.0342    0.0397    0.2940    0.0252    0.0307    0.0003    0.1940    0.0348    0.0705    0.0115
 0.0015    0.2020    0.0121    0.0000    0.0040    0.0001    0.0000    0.0000    0.0063    0.0001    0.0000    0.0002    0.0365    0.0027    0.0339    0.0398    0.2950    0.0253    0.0302    0.0003    0.1940    0.0348    0.0696    0.0113
 0.0015    0.2010    0.0123    0.0000    0.0042    0.0001    0.0000    0.0000    0.0065    0.0001    0.0000    0.0002    0.0376    0.0028    0.0334    0.0399    0.2960    0.0255    0.0292    0.0003    0.1950    0.0349    0.0680    0.0109
 0.0015    0.2010    0.0122    0.0000    0.0042    0.0001    0.0000    0.0000    0.0066    0.0001    0.0000    0.0002    0.0375    0.0027    0.0336    0.0398    0.2960    0.0254    0.0296    0.0003    0.1950    0.0348    0.0687    0.0111
 % 0.2681	0.2845	0.1980	0.1918	0.0182	0.0394 0.2681	0.2845	0.1980	0.1918	0.0182	0.0394 0.2681	0.2845	0.1980	0.1918	0.0182	0.0394 0.2681	0.2845	0.1980	0.1918	0.0182	0.0394 
% 0.2666	0.2828	0.1967	0.1955	0.0183	0.0401 0.2666	0.2828	0.1967	0.1955	0.0183	0.0401 0.2666	0.2828	0.1967	0.1955	0.0183	0.0401 0.2666	0.2828	0.1967	0.1955	0.0183	0.0401 
% 0.2633	0.2827	0.1956	0.2007	0.0162	0.0415 0.2633	0.2827	0.1956	0.2007	0.0162	0.0415 0.2633	0.2827	0.1956	0.2007	0.0162	0.0415 0.2633	0.2827	0.1956	0.2007	0.0162	0.0415 
% 0.2763	0.2798	0.1874	0.1998	0.0152	0.0415 0.2763	0.2798	0.1874	0.1998	0.0152	0.0415 0.2763	0.2798	0.1874	0.1998	0.0152	0.0415 0.2763	0.2798	0.1874	0.1998	0.0152	0.0415
% 0.2695	0.2832	0.1902	0.1983	0.0162	0.0426 0.2695	0.2832	0.1902	0.1983	0.0162	0.0426 0.2695	0.2832	0.1902	0.1983	0.0162	0.0426 0.2695	0.2832	0.1902	0.1983	0.0162	0.0426 
% 0.2661	0.2847	0.1883	0.2024	0.0147	0.0439 0.2715	0.2758	0.1997	0.1992	0.0130	0.0408 0.2715	0.2758	0.1997	0.1992	0.0130	0.0408 0.2715	0.2758	0.1997	0.1992	0.0130	0.0408
% 0.2509	0.2938	0.1914	0.2061	0.0141	0.0437 0.2509	0.2938	0.1914	0.2061	0.0141	0.0437 0.2509	0.2938	0.1914	0.2061	0.0141	0.0437 0.2509	0.2938	0.1914	0.2061	0.0141	0.0437
% 0.2475	0.2932	0.1962	0.2028	0.0173	0.0430 0.2475	0.2932	0.1962	0.2028	0.0173	0.0430 0.2475	0.2932	0.1962	0.2028	0.0173	0.0430 0.2475	0.2932	0.1962	0.2028	0.0173	0.0430
% 0.2300	0.3045	0.1966	0.2068	0.0175	0.0445 0.2300	0.3045	0.1966	0.2068	0.0175	0.0445 0.2300	0.3045	0.1966	0.2068	0.0175	0.0445 0.2300	0.3045	0.1966	0.2068	0.0175	0.0445
% 0.2523	0.2895	0.1966	0.2020	0.0180	0.0414 0.2523	0.2895	0.1966	0.2020	0.0180	0.0414 0.2523	0.2895	0.1966	0.2020	0.0180	0.0414 0.2523	0.2895	0.1966	0.2020	0.0180	0.0414
% 0.2542	0.2866	0.1981	0.2003	0.0184	0.0424 0.2542	0.2866	0.1981	0.2003	0.0184	0.0424 0.2542	0.2866	0.1981	0.2003	0.0184	0.0424 0.2542	0.2866	0.1981	0.2003	0.0184	0.0424
% 0.2664	0.2782	0.1937	0.2019	0.0170	0.0429 0.2664	0.2782	0.1937	0.2019	0.0170	0.0429 0.2664	0.2782	0.1937	0.2019	0.0170	0.0429 0.2664	0.2782	0.1937	0.2019	0.0170	0.0429 
% 0.2663	0.2869	0.1947	0.1956	0.0174	0.0391 0.2663	0.2869	0.1947	0.1956	0.0174	0.0391 0.2663	0.2869	0.1947	0.1956	0.0174	0.0391 0.2663	0.2869	0.1947	0.1956	0.0174	0.0391 
% 0.2712	0.2941	0.1911	0.1890	0.0168	0.0378 0.2712	0.2941	0.1911	0.1890	0.0168	0.0378 0.2712	0.2941	0.1911	0.1890	0.0168	0.0378 0.2712	0.2941	0.1911	0.1890	0.0168	0.0378 
];
data_Mn=[636.33 281 212 655.5 291 222 111.6 643 279 215 103.2 660 366 226 114 690 349.33 190.8 120.67 570 291 131 69 30.56]'/1000;% kg/mol
Ym0=mol2mass(yield(date,:),data_Mn,'m');
Ym=mass2yield(Ym0);

% �����¶�,���µ㹲��8��,ȡƽ��ֵ
T_R1=[
%R1B1�� R1B1��  R1B2��  R1B2��  
333.5	370.6	356.8	376.7
332.1	368.5	356.1	375.7
331.0	367.6	354.6	374.4
331.5	368.0	355.7	375.5
332.0   368.5   356.5   376.4
330.0   366.1   353.0   372.3
331.6	368.2	355.5	375.3
331.8	368.0	355.4	374.8
332.7	369.3	356.3	376.0
334.5	371.9	358.3	378.5
333.1	370.1	358.1	378.4
332.6	369.4	356.6	376.6
332.9	369.7	355.3	374.8
333.7	371.0	356.2	376.0
333.8	371.1	356.1	375.9
333.1	370.1	355.2	374.7
332.8	369.9	355.3	375.0
332.9	370.0	355.0	374.6
333.3	370.6	354.3	373.7
332.7	369.9	353.2	372.4
332.5	369.6	353.7	373.0
];

T_R2=[
%R2B1�� R2B1��  R2B2��  R2B2��  R2B3��  R2B3��  
374.3	394.2	380.9	412.1	381.6	404.7
375.5	395.9	381.3	412.7	382.6	407.9
372.0   390.8   378.6   407.0   379.5   400.3
373.9	393.6	379.4	408.7	381.0	403.0
374.6	394.6	380.5	411.0	381.8	405.2
373.1   392.5   379.2   408.0   380.2   401.6
374.2	394.1	379.8	409.6	380.3	401.1
376.3	397.1	381.7	413.5	382.6	407.8
375.4	395.8	381.6	413.5	382.2	406.5
374.8	394.8	381.1	412.5	381.9	405.6
374.5	394.6	380.2	410.8	381.0	402.7
374.1	394.1   379.6	409.4   381.2   403.3
374.7	394.9	380.1	410.4	381.7	404.9
374.3	394.4	379.5	409.2	381.1	403.0
374.1	394.1	380.1	410.5	380.8	402.1
374.5	394.7	380.1	410.5	381.0	402.6
373.6	393.5	379.0	408.4	380.0	400.6
374.1	393.8	379.9	409.8	380.5	401.5
374.2	394.1	379.7	409.5	379.8	399.9
373.2	392.7	379.1	408.4	379.2	399.1
373.8	393.4	379.5	408.9	379.7	400.0
];


T_Input =[T_R1(date,[1 3]) T_R2(date,[1 3 5])];
T_Output=[T_R1(date,[2 4]) T_R2(date,[2 4 6])];
T_Input =t2k(T_Input);
T_Output=t2k(T_Output);