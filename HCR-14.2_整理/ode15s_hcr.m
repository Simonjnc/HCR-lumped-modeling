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

Y =Condition(1:6);
Tr=Condition(7);

if bed<=NumOfBed1
    k=k0(1,:).*exp(-E(1,:)/(pro.R*Tr*opr.T0))/3600;
else
    k=k0(2,:).*exp(-E(2,:)/(pro.R*Tr*opr.T0))/3600;
end

K(1,:)=[sum(k(1:5))        0                  0                    0                  0                 0];
K(2,:)=[-k(1)*pro.aa(1)    sum(k(6:9))        0                    0                  0                 0];
K(3,:)=[-k(2)*pro.aa(2)    -k(6)*pro.aa(6)    sum(k(10:12))        0                  0                 0];
K(4,:)=[-k(3)*pro.aa(3)    -k(7)*pro.aa(7)    -k(10)*pro.aa(10)    sum(k(13:14))      0                 0];
K(5,:)=[-k(4)*pro.aa(4)    -k(8)*pro.aa(8)    -k(11)*pro.aa(11)    -k(13)*pro.aa(13)  k(15)             0];
K(6,:)=[-k(5)*pro.aa(5)    -k(9)*pro.aa(9)    -k(12)*pro.aa(12)    -k(14)*pro.aa(14)  -k(15)*pro.aa(15) 0];

RR=K*Y;

u=calculateU(Y*opr.C10, pro.Mn, pro.area, opr.Fw_Feed);
dudz=opr.detau0*opr.u0/pro.total_L;

dY=[
    -(pro.L(bed)/u)*(RR(1)+Y(1)*dudz)         %可以用for循环代替
    -(pro.L(bed)/u)*(RR(2)+Y(2)*dudz)
    -(pro.L(bed)/u)*(RR(3)+Y(3)*dudz)
    -(pro.L(bed)/u)*(RR(4)+Y(4)*dudz)
    -(pro.L(bed)/u)*(RR(5)+Y(5)*dudz)
    -(pro.L(bed)/u)*(RR(6)+Y(6)*dudz)
    ];

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
