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
kkk0=x_DE(1:15);
EEE=x_DE(16:20);
Eplus=x_DE(21);
% ָǰ����
k0=[kkk0;kkk0];
% ��Ӧ���
E1=EEE(1);E2=EEE(2);E3=EEE(3);E4=EEE(4);E5=EEE(5);
E(2,:)=[E1 E1 E1 E1 E1 E2 E2 E2 E2 E3 E3 E3 E4 E4 E5];% ��Ӧ���
E(1,:)=E(2,:)*Eplus;%Eplus>1

%% ��һ��
% z=l/L:����θ߶ȣ�
% Tr=T/T0:������¶ȣ�
% T0:����ζԱ��¶�,ȡֵΪ:673.15K��
% Yij=Cij/C10:���θ�������������Ũ��������
% C10:��Ӧ������ԭ���͵�Ħ��Ũ��,mol*m^-3��
% Rij-���θ������������η�Ӧ����������
C0=[opr.C10 0 0 0 0 0]';% ��ʼŨ��
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
result=zeros(NumOfBed*num,7);
YandT=zeros(1,6+2*NumOfBed);
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
    result((bed-1)*num+1:bed*num,:)=[Condition(:,1:6)*opr.C10  Condition(:,7)*opr.T0];%
    
    YandT(bed)         =k2t(result((bed-1)*num+1,  7));%�����¶�
    YandT(NumOfBed+bed)=k2t(result(bed*num,7));%�����¶�
    
    if bed<NumOfBed
        [Fw_H2_next, InitialCondition]=calculateInitialCondition(result(bed*num,:)',bed,pro,opr);
        InitialCondition=[InitialCondition(1:6)/opr.C10; InitialCondition(7)/opr.T0];
    end
end

C_mass=mol2mass(result(end,1:6)',pro.Mn,'v'); % ����������
YandT(2*NumOfBed+1:end)=100*mass2yield(C_mass');

if strcmp(flag,'plot')
    YandT=result;
end

end
