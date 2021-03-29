function Coefficient=calculateCoefficient(Mn)
% ------------------------------
% 父函数有:
% pro=common
% 子函数无
% ------------------------------

% pro=common;
% Mn=pro.Mn;% 平均分子质量Mn(kg/mol)
Coefficient=zeros(15,1); % 列向量
Coefficient(1)=Mn(1)/Mn(2);
Coefficient(2)=Mn(1)/Mn(3);
Coefficient(3)=Mn(1)/Mn(4);
Coefficient(4)=Mn(1)/Mn(5);
Coefficient(5)=Mn(1)/Mn(6);
Coefficient(6)=Mn(2)/Mn(3);
Coefficient(7)=Mn(2)/Mn(4);
Coefficient(8)=Mn(2)/Mn(5);
Coefficient(9)=Mn(2)/Mn(6);
Coefficient(10)=Mn(3)/Mn(4);
Coefficient(11)=Mn(3)/Mn(5);
Coefficient(12)=Mn(3)/Mn(6);
Coefficient(13)=Mn(4)/Mn(5);
Coefficient(14)=Mn(4)/Mn(6);
Coefficient(15)=Mn(5)/Mn(6);
end