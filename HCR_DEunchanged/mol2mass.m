function C_mass=mol2mass(C, Mn, vorm)
% vorm='v'代表C为向量，vorm='m'代表C为矩阵
% ------------------------------
% 父函数有:
% YandT=HCR(x_DE, flag, pro, opr)
% Cp_mixture=calculateCp_mixture(C, Cp, Mn)
% 子函数无
% ------------------------------

% pro=common;
% Mn=pro.Mn;
% N=size(C,2); % C的列的个数
% C_mass=zeros(size(C));

% if N==1
%     for i=1:6
%         C_mass(i)=C(i).*Mn(i);% kg/m^3
%     endstr
% end
if strcmp(vorm,'v') % vorm='v'代表C为向量
    C_mass=C.*Mn;% kg/m^3
end

% if N==6
%     for i=1:6
%         C_mass(:,i)=C(:,i).*Mn(i);% kg/m^3
%     end
% end
if strcmp(vorm,'m') % vorm='m'代表C为矩阵
    for i=1:size(C, 2)
        C_mass(:,i)=C(:,i)*Mn(i);% kg/m^3
    end
end

end