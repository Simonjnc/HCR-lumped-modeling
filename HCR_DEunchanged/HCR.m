function [YandT, Fw_H2]=HCR(x_DE, flag, pro, opr, num)
% function YandT=HCR(kkk0,EEE,Eplus,flag,date)
% ------------------------------
% �����ѻ�������
% ������Parents (calling functions):
% fun=object_fun(x_DE, pro, opr)
% �Ӻ���Children (called functions):
% ode15s
% dCondition=ode15s_hcr(~,Condition,k0,E,bed,pro,opr,Fw_H2_next)
% T=k2t(K)
% [Fw_H2_next, InitialCondition]=calculateInitialCondition(lastCondition,bed,pro,opr)
% C_mass=mol2mass(C, Mn, vorm)
% yw=mass2yield(Fm)
% ------------------------------

%% ��ù�������
% pro=common; % ���������������Ǽ���,��ʡʱ��
% opr=operationCondition(date);
NumOfBed=pro.NumOfBed.Total;
% C10=opr.C10;% ��ʼ����Ũ��mol/m^3
% T0=opr.T0;% ��λK
% T_Input1=opr.T_Input(1);
Fw_H2_next=0;

%% ����k0&E
kkk0=x_DE(1:88);
EEE=x_DE(89:111);
Eplus=x_DE(112);
% ָǰ����
k0=[kkk0;kkk0];
% ��Ӧ���
E1=EEE(1);E2=EEE(2);E3=EEE(3);E4=EEE(4);E5=EEE(5);E6=EEE(6);E7=EEE(7);E8=EEE(8);E9=EEE(9);E10=EEE(10);E11=EEE(11);E12=EEE(12);E13=EEE(13);E14=EEE(14);E15=EEE(15);E16=EEE(16);E17=EEE(17);E18=EEE(18);E19=EEE(19);E20=EEE(20);E21=EEE(21);E22=EEE(22);E23=EEE(23);
E(2,:)=[E8 E1 E9 E2 E9 E3 E10 E10 E11 E12 E13 E14 E15 E17 E17 E17 E17 E12 E18 E18 E18 E1 E4 E2 E5 E5 E3 E6 E7 E8 E8 E1 E1 E4 E4 E2 E2 E2 E5 E5 E5 E9 E9 E9 E3 E3 E6 E6 E10 E10 E3 E6 E10 E11 E7 E16 E16 E19 E20 E20 E20 E20 E20 E21 E21 E21 E22 E22 E16 E16 E16 E17 E17 E17 E18 E18 E18 E18 E19 E19 E19 E16 E16 E21 E22 E23 E20 E20];% ��Ӧ���
E(1,:)=E(2,:)*Eplus;%Eplus>1

%% ��һ��
% z=l/L:����θ߶ȣ�
% Tr=T/T0:������¶ȣ�
% T0:����ζԱ��¶�,ȡֵΪ:673.15K��
% Yij=Cij/C10:���θ�������������Ũ��������
% C10:��Ӧ������ԭ���͵�Ħ��Ũ��,mol*m^-3��
% Rij-���θ������������η�Ӧ����������
C0=[opr.C10 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 ]';% ��ʼŨ��
Y0=C0/opr.C10;
Tr0=opr.T_Input(1)/opr.T0;
InitialCondition=[Y0;Tr0];% ��ʼ����


%% ode����
% ÿ����Ӧ�����������
% num=10;
% result=zeros(NumOfBed*num+1,7);
if nargin==4 % ������������4��,��û��ָ��num,��num=3
    num=3; %num>=3,С��3ʱ�ᱨ��,Ӧ����ϵͳ����ode15s������
end
result=zeros(NumOfBed*num,25);
YandT=zeros(1,2*NumOfBed+24);
Fw_H2=zeros(1,NumOfBed);

for bed=1:NumOfBed
    %=============
    %����ode15s
    %Ϊ�˸���ʡʱ��,����λ�Ӧ���ڵ���ode֮ǰ,����ÿ��ode��������ݶ�������λ�������
    %     z=linspace(0,1,num+1);%����λ�����
    z=linspace(0,1,num);%����λ�����
    Options=odeset('AbsTol',1e-9);
    [~,Condition]=ode15s(@ode15s_hcr,z,InitialCondition,Options,k0,E,bed,pro,opr,Fw_H2_next);
    Fw_H2(bed)=Fw_H2_next;
    %=============
    
    %     result((bed-1)*num+1:bed*num+1,:)=Condition;% ����ÿ�θ���һ����¼,���1-11��ֵ,�ٶ�11-21��ֵ,11������,����Ŀǰ�Ż��õ����ݣ�YandT����׼ȷ��,
    result((bed-1)*num+1:bed*num,:)=[Condition(:,1:24)*opr.C10  Condition(:,25)*opr.T0];%
    
    YandT(bed)         =k2t(result((bed-1)*num+1,  25));%�����¶�
    YandT(NumOfBed+bed)=k2t(result(bed*num,25));%�����¶�
    
    if bed<NumOfBed
        [Fw_H2_next, InitialCondition]=calculateInitialCondition(result(bed*num,:)',bed,pro,opr);
        InitialCondition=[InitialCondition(1:24)/opr.C10; InitialCondition(25)/opr.T0];
    end
end

C_mass=mol2mass(result(end,1:24)',pro.Mn,'v'); % ����������
YandT(2*NumOfBed+1:end)=100*mass2yield(C_mass');

if strcmp(flag,'plot')
    YandT=result;
end

end