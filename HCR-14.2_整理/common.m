function pro=common(heat_HCR1index, heat_HCR2index)
% ------------------------------
% ��������:
% DE
% �Ӻ�����:
% [area, L]=getDimension
% Coefficient=calculateCoefficient(Mn)
% ------------------------------

% ���е�λ��Ϊ��׼��λ
% ����������Ϊ������

% װ�óߴ�
pro.NumOfBed.Reactor1=3;% ���⾫�Ʒ�Ӧ��������
pro.NumOfBed.Reactor2=4;% �����ѻ���Ӧ��������
pro.NumOfBed.Total=pro.NumOfBed.Reactor1+pro.NumOfBed.Reactor2;% �ܴ�����
[area, L]=getDimension;
pro.area=area;% ��Ӧ��������,m^2
pro.L=L;% ����߶�,m
pro.total_L=sum(pro.L);% �����ܸ߶�,m

% ƽ����������Mn(g/mol)
% 1Feed	2Diesel	3Kerosene	4HeavyNaphtha	5LightNaphtha	6���
pro.Mn=[350.39	220.32	152.97	102.06	71.58	23.15]'/1000;% kg/mol
pro.aa=calculateCoefficient(pro.Mn);

% ����
pro.p_Feed=905.2;% ԭ�����ܶ�kg/m^3(20��)
% �ڱ�׼�����£�0��,1atm��,�����ܶ�ԼΪ1.29kg/m3��
% pro.p_H2=0.115297*1.29; % �����ܶ�kg/m^3,0.115297Ϊ����
pro.CpColdH2=8.89*1000; % J/(kg*K) ��63�棩
pro.CpHotH2 =9.438*1000; % J/(kg*K) ��370�棩
%%%%%%%%ע��,�������壨��������Գ�Һ̬�������д�����
%J/kg*Kԭ���͡�  ���͡� ��ú�� ��ʯ��  ��ʯ�� ���  % 
% pro.Cp=[3326.9 2634.4 2623.6 2601.7 2476.3 1634];
pro.Cp=[3.05	3.18	3.19	3.41	3.50	3.58]'*1000;%J/kg*K

% ��Ӧ
% ����Ϊ����,�ѻ�����,�ۺ�Ϊ����
% ��ʯ�����ƹ��̡�p269ҳ�ı����ʾ���������ѷ�Ӧ�ȴ�����60kJ/mol����
% pro.heat_HCR=[297000 197000 127000];% J/mol,�����ѻ���Ӧ��297000
% pro.heat_HCR=[60000 60000 60000];% J/mol,�����ѻ���Ӧ��297000
% pro.heat_HCR2=40000;% J/mol,�����ѻ���Ӧ��297000
heat=60000;
pro.heat_HCR1=[heat heat heat]'.*heat_HCR1index;% J/mol
pro.heat_HCR2=[heat heat heat heat]'.*heat_HCR2index;

pro.R=8.314472145136;% Rһ���峣��,8.314J*mol^-1*K^-1;
