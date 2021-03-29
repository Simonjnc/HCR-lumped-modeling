function Cp_mixture=calculateCp_mixture(C, Cp, Mn)
% ------------------------------
% ��������:
% dCondition=ode15s_hcr(~,Condition,k0,E,bed,pro,opr,Fw_H2_next):��ʱCΪ������
% [Fw_H2_next, InitialCondition]=calculateInitialCondition(lastCondition,bed,pro,opr)
% �Ӻ�����:
% C_mass=mol2mass(C, Mn, vorm)
% ------------------------------

% pro=common;
% Cp=pro.Cp;
Y_mass=mol2mass(C, Mn, 'v'); % 'v'����CΪ������
s=sum(Y_mass);
% Cp_mixture=0;
% for i=1:6
%     Cp_mixture=Cp_mixture+(Y_mass(i)/s)*Cp(i);
% end
Cp_mixture=sum((Y_mass/s).*Cp); % ������forѭ���ȼ�

end