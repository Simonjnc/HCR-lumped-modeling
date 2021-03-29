function opr=operationCondition(pro, date)
% ------------------------------
% dateΪ����
% ���е�λ��Ϊ��׼��λ
% ��������:
% DE
% �Ӻ�����:
% [Fw_Feed, Ym, T_Input, T_Output]=getData(date)
% K=t2k(T)
% ------------------------------

% pro=common;

% �������
opr.date=date;
[Fw_Feed, Ym, T_Input, T_Output]=getData(date);

opr.T_Input  = T_Input; % ��λ K /������
opr.T_Output = T_Output; % R2B4���¶�û��,���õ��¶ȴ���,���߲��

% ����
opr.Ym = Ym;

% ����
opr.Fw_Feed = Fw_Feed;% kg/s
opr.Fv_Feed = opr.Fw_Feed/pro.p_Feed;% ԭ���ͽ���m^3/s
opr.u0 = opr.Fv_Feed/pro.area;% ��Ӧ���ʼ����m/s
opr.detau0 = 0.2;% �ٶ�u�Է�Ӧ������total_L�ĵ���,���仯��
opr.C10=pro.p_Feed/pro.Mnave;% ��ʼ����Ũ��mol/m^3
opr.T0=t2k(400);% T0:����ζԱ��¶�,ȡֵΪ:673.15K

% ѭ����
T_Input_H2=63;% �����¶�,���϶�
opr.T_H2=ones(1,pro.NumOfBed.Total)*t2k(T_Input_H2);% 240��ּ����ѻ�װ������ƽ�⼰��������.xlsx:Gas Quench Temperature

end
