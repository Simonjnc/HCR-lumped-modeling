function u=calculateU(C, Mn, area, Fw_Feed)
% ------------------------------
% ��������:
% dCondition=ode15s_hcr(~,Condition,k0,E,bed,pro,opr,Fw_H2_next):��ʱCΪ������
% myplot(result,date,plotwhat):��ʱCΪ����
% ------------------------------

u=Fw_Feed./(area*Mn'*C); % һ�����������������ֻ���õ��

end
