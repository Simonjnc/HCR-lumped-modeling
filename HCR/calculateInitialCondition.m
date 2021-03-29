function [Fw_H2_next, InitialCondition]=calculateInitialCondition(lastCondition,bed,pro,opr)
% ------------------------------
% ��������:
% YandT=HCR(x_DE, flag, pro, opr)
% HCR_.m
% �Ӻ�����:
% Cp_mixture=calculateCp_mixture(C, Cp, Mn)
% ------------------------------

% pro=common;
% opr=operationCondition(date);

CpColdH2=pro.CpColdH2;
Fw_Feed=opr.Fw_Feed;% kg/s
% Fw_H2=opr.Fw_H2;% kg/s
T_H2=opr.T_H2; % ÿ�δ������H2���¶�,�ο�hysysģ������¶ȣ�DCSװ�ý�ͼ��Ҳ�У�K
To_LastBed=lastCondition(25);% K
Cp_mix=calculateCp_mixture(lastCondition(1:24), pro.Cp, pro.Mn); % Һ������ı���,J/(kg*K)
% T_InputNext=(Fw_Feed*Cp_mix*To_LastBed+Fw_H2(bed+1)*CpH2*T_H2(bed+1))/(Fw_Feed*Cp_mix+Fw_H2(bed+1)*CpH2);% K
T_InputNext=opr.T_Input(bed+1);
Fw_H2_next=(To_LastBed-T_InputNext)*Fw_Feed*Cp_mix/((T_InputNext-T_H2(bed+1))*CpColdH2);
InitialCondition=[lastCondition(1:24);T_InputNext];