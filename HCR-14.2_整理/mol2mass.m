function C_mass=mol2mass(C, Mn, vorm)
% vorm='v'����CΪ������vorm='m'����CΪ����
% ------------------------------
% ��������:
% YandT=HCR(x_DE, flag, pro, opr)
% Cp_mixture=calculateCp_mixture(C, Cp, Mn)
% �Ӻ�����
% ------------------------------

% pro=common;
% Mn=pro.Mn;
% N=size(C,2); % C���еĸ���
% C_mass=zeros(size(C));

% if N==1
%     for i=1:6
%         C_mass(i)=C(i).*Mn(i);% kg/m^3
%     endstr
% end
if strcmp(vorm,'v') % vorm='v'����CΪ����
    C_mass=C.*Mn;% kg/m^3
end

% if N==6
%     for i=1:6
%         C_mass(:,i)=C(:,i).*Mn(i);% kg/m^3
%     end
% end
if strcmp(vorm,'m') % vorm='m'����CΪ����
    for i=1:size(C, 2)
        C_mass(:,i)=C(:,i)*Mn(i);% kg/m^3
    end
end

end