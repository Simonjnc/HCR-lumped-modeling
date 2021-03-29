function dCondition=ode15s_hcr(~,Condition,k0,E,bed,pro,opr,Fw_H2_next)
% ------------------------------
% 父函数有:
% HCR
% ode15s
% 子函数有:
% u=calculateU(C, Mn, area, Fw_Feed)
% Cp_mixture=calculateCp_mixture(C, Cp, Mn)
% ------------------------------

NumOfBed1 = pro.NumOfBed.Reactor1;

Y =Condition(1:24);
Tr=Condition(25);

if bed<=NumOfBed1
    k=k0(1,:).*exp(-E(1,:)/(pro.R*Tr*opr.T0))/3600;
else
    k=k0(2,:).*exp(-E(2,:)/(pro.R*Tr*opr.T0))/3600;
end
%K(0,:)=[      1                  2                   3               4                5                 6                  7                  8                    9                  10                11                 12                   13                 14                15                16                  17                   18                 19                20                 21                   22                 23               24];
K(1,:)=[sum(k([2 23 32 33]))      0                   0               0                0                 0                  0           -k(1)*pro.aa(1)             0                  0                 0                  0                    0                  0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0];
K(2,:)=[-k(32)*pro.aa(32)  sum(k([4 24 36 37 38]))    0               0                0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0                  0          -k(74)*pro.aa(74)            0                  0                 0          -k(84)*pro.aa(84)            0                  0                 0];
K(3,:)=[       0          -k(36)*pro.aa(36) sum(k([6 27 45 46 51]))   0                0                 0                  0                  0                    0             -k(7)*pro.aa(7)        0                  0                    0                  0                 0                  0                  0              -k(76)*pro.aa(76)        0                 0                  0                    0                  0                 0];
K(4,:)=[-k(2)*pro.aa(2)           0                   0       sum(k([23 34 35]))       0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0];
K(5,:)=[       0          -k(4)*pro.aa(4)             0      -k(34)*pro.aa(34) sum(k([25 26 39 40 41]))  0                  0                  0             -k(5)*pro.aa(5)           0                 0                  0                    0                  0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0];
K(6,:)=[       0                  0            -k(6)*pro.aa(6)        0       -k(39)*pro.aa(39)  sum(k([28 47 48 52]))      0                  0                    0           -k(8)*pro.aa(8)          0                  0                    0                  0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0];
K(7,:)=[       0                  0                   0               0                0         -k(52)*pro.aa(52)   sum(k([29 55]))           0                    0                  0           -k(9)*pro.aa(9)          0                    0                  0                 0                  0                  0           -k(78)*pro.aa(78)           0                 0                  0                    0                  0                 0];
K(8,:)=[-k(22)*pro.aa(22)         0                   0               0                0                 0                  0           sum(k([1 30 31]))           0                  0                 0                  0                    0                  0                 0          -k(69)*pro.aa(69)          0                    0                  0          -k(88)*pro.aa(88)         0                    0                  0                 0];
K(9,:)=[       0            -k(24)*pro.aa(24)         0               0                0                 0                  0          -k(30)*pro.aa(30)  sum(k([3 5 42 43 44]))       0                 0                  0                    0                  0                 0          -k(82)*pro.aa(82)   -k(72)*pro.aa(72)           0                  0          -k(87)*pro.aa(87)         0                    0                  0                 0];
K(10,:)=[      0                  0            -k(27)*pro.aa(27)      0                0                 0                  0                  0           -k(42)*pro.aa(42)   sum(k([7 8 49 50 53]))    0                  0                    0                  0                 0                  0                  0           -k(75)*pro.aa(75)           0                 0                  0                    0                  0                 0];
K(11,:)=[      0                  0            -k(51)*pro.aa(51)      0                0                 0                  0                  0                    0          -k(53)*pro.aa(53)  sum(k([9 54]))            0                    0                  0                 0                  0                  0           -k(77)*pro.aa(77)     -k(79)*pro.aa(79)       0                  0              -k(85)*pro.aa(85)        0                 0];
K(12,:)=[      0                  0                   0       -k(23)*pro.aa(23)        0                 0                  0                  0                    0                  0                 0            sum(k([10 18]))            0                  0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0];
K(13,:)=[-k(33)*pro.aa(33)        0                   0       -k(35)*pro.aa(35)        0                 0                  0           -k(31)*pro.aa(31)           0                  0                 0           -k(10)*pro.aa(10)     sum(k(11))             0                 0                  0                  0                    0                  0           -k(62)*pro.aa(62)        0                    0                  0                 0];
K(14,:)=[      0                  0                   0               0         -k(25)*pro.aa(25)   -k(28)*pro.aa(28)       0                  0                    0                  0                 0                  0             -k(11)*pro.aa(11)       sum(k(12))          0     -k([57 83])*pro.aa([57 83])  -k(15)*pro.aa(15)       0                  0           -k(63)*pro.aa(63)        0                    0                  0                 0];
K(15,:)=[      0           -k(37)*pro.aa(37)     -k(45)*pro.aa(45)    0   -k([26 40])*pro.aa([26 40]) -k(47)*pro.aa(47)  -k(29)*pro.aa(29)     0             -k(43)*pro.aa(43)  -k(49)*pro.aa(49)        0                  0                    0           -k(12)*pro.aa(12)   sum(k(13))              0          -k(16)*pro.aa(16)   -k(20)*pro.aa(20)   -k(81)*pro.aa(81)   -k(59)*pro.aa(59)   -k(65)*pro.aa(65)         0                  0                 0];
K(16,:)=[      0                  0                   0               0                0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0     sum(k([56 57 69 70 71 82 83]))  0                    0                  0                 0                  0                    0                  0                 0];
K(17,:)=[      0                  0                   0               0                0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0       -k(56)*pro.aa(56)   sum(k([14 15 16 17 72 73 74])) 0                  0                 0                  0                    0                  0                 0];
K(18,:)=[      0                  0                   0               0                0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0        -k(71)*pro.aa(71)   -k(14)*pro.aa(14) sum(k([19 20 21 75 76 77 78])) 0                 0                  0                    0                  0                 0];
K(19,:)=[      0                  0                   0               0                0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0                  0                  0           -k(19)*pro.aa(19)   sum(k([58 79 80 81]))     0                  0                    0                  0                 0];
K(20,:)=[      0                  0                   0               0                0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0                  0                  0                    0                  0   sum(k([59 60 61 62 63 87 88]))   0                    0                  0                 0];
K(21,:)=[      0            -k(84)*pro.aa(84)         0               0                0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0                  0                  0                    0                  0         -k(61)*pro.aa(61) sum(k([64 65 66]))            0                  0                 0];
K(22,:)=[      0                  0                   0               0                0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0                  0                  0                    0                  0                 0         -k(64)*pro.aa(64)       sum(k([67 68 85]))       0                 0];
K(23,:)=[      0                  0                   0               0                0                 0                  0                  0                    0                  0                 0                  0                    0                  0                 0                  0                  0                    0                  0                 0                  0           -k(67)*pro.aa(67)      sum(k(86))             0];
K(24,:)=[      0            -k(38)*pro.aa(38)    -k(46)*pro.aa(46)    0               -k(41)*pro.aa(41)  -k(48)*pro.aa(48)  -k(55)*pro.aa(55)  0                    -k(44)*pro.aa(44)  -k(56)*pro.aa(56) -k(54)*pro.aa(54)  -k(18)*pro.aa(18)    0                  0       -k(13)*pro.aa(13)  -k(70)*pro.aa(70)  -k(17)*pro.aa(17)    -k(21)*pro.aa(21)  -k([58 80])*pro.aa([58 80]) -k(60)*pro.aa(60)  -k(66)*pro.aa(66)    -k(68)*pro.aa(68)  -k(86)*pro.aa(86) 0];

RR=K*Y;

u=calculateU(Y*opr.C10, pro.Mn, pro.area, opr.Fw_Feed);
dudz=opr.detau0*opr.u0/pro.total_L;

dY=zeros(24,1);
for i=1:24
dY(i)=-(pro.L(bed)/u)*(RR(i)+Y(i)*dudz);
end

% dY=[
%     -(pro.L(bed)/u)*(RR(1)+Y(1)*dudz)
%     -(pro.L(bed)/u)*(RR(2)+Y(2)*dudz)
%     -(pro.L(bed)/u)*(RR(3)+Y(3)*dudz)
%     -(pro.L(bed)/u)*(RR(4)+Y(4)*dudz)
%     -(pro.L(bed)/u)*(RR(5)+Y(5)*dudz)
%     -(pro.L(bed)/u)*(RR(6)+Y(6)*dudz)
%     -(pro.L(bed)/u)*(RR(7)+Y(7)*dudz)
%     -(pro.L(bed)/u)*(RR(8)+Y(8)*dudz)
%     -(pro.L(bed)/u)*(RR(9)+Y(9)*dudz)
%     -(pro.L(bed)/u)*(RR(10)+Y(10)*dudz)
%     -(pro.L(bed)/u)*(RR(11)+Y(11)*dudz)
%     -(pro.L(bed)/u)*(RR(12)+Y(12)*dudz)
%     -(pro.L(bed)/u)*(RR(13)+Y(13)*dudz)
%     -(pro.L(bed)/u)*(RR(14)+Y(14)*dudz)
%     -(pro.L(bed)/u)*(RR(15)+Y(15)*dudz)
%     -(pro.L(bed)/u)*(RR(16)+Y(16)*dudz)
%     -(pro.L(bed)/u)*(RR(17)+Y(17)*dudz)
%     -(pro.L(bed)/u)*(RR(18)+Y(18)*dudz)
%     -(pro.L(bed)/u)*(RR(19)+Y(19)*dudz)
%     -(pro.L(bed)/u)*(RR(20)+Y(20)*dudz)
%     -(pro.L(bed)/u)*(RR(21)+Y(21)*dudz)
%     -(pro.L(bed)/u)*(RR(22)+Y(22)*dudz)
%     -(pro.L(bed)/u)*(RR(23)+Y(23)*dudz)
%     -(pro.L(bed)/u)*(RR(24)+Y(24)*dudz)
%     ];

% 液相混合物的比热,J/(kg*K)
Cp_mixture=calculateCp_mixture(Y, pro.Cp, pro.Mn); % 传递参数Y(归一化浓度)或Y*opr.C10(真实浓度)是一样的效果

react=sum(RR);

if bed<=NumOfBed1
    % 分母有近似,这时的Fw_H2_next是不是应该算累计氢流量？如果算也没办法算,因为不知道反应了多少氢
    % 反应的氢包括加裂的氢+加氢脱杂质的氢+加氢饱和的氢
    % 只能近似认为进去的氢都反应了,但是这样的话下面的分母还用算氢吗？
    % 由（1）和（1）式的输出可知,Fw_H较Fw_F很小,可以忽略,所以算不算影响不大
    %     Fw_H=Fw_H2_next*CpHotH2 % （1）
    %     Fw_F=Fw_Feed*Cp_mixture % （2）
    dTr=(pro.L(bed)*pro.area*opr.C10/opr.T0)*react*(-pro.heat_HCR1(bed))/(Fw_H2_next*pro.CpHotH2+opr.Fw_Feed*Cp_mixture);
else
    dTr=(pro.L(bed)*pro.area*opr.C10/opr.T0)*react*(-pro.heat_HCR2(bed-NumOfBed1))/(Fw_H2_next*pro.CpHotH2+opr.Fw_Feed*Cp_mixture);
end

dCondition=[
    dY
    dTr
    ];

end
