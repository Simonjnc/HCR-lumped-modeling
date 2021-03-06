function Coefficient=calculateCoefficient(Mn)
% ------------------------------
% 父函数有:
% pro=common
% 子函数无
% ------------------------------

% pro=common;
% Mn=pro.Mn;% 平均分子质量Mn(kg/mol)

Coefficient=zeros(88,1); % 列向量
Coefficient(1)=Mn(8)/Mn(1);
Coefficient(2)=Mn(1)/Mn(4);
Coefficient(3)=Mn(9)/Mn(2);
Coefficient(4)=Mn(2)/Mn(5);
Coefficient(5)=Mn(9)/Mn(5);
Coefficient(6)=Mn(3)/Mn(6);
Coefficient(7)=Mn(10)/Mn(3);
Coefficient(8)=Mn(10)/Mn(6);
Coefficient(9)=Mn(11)/Mn(7);
Coefficient(10)=Mn(12)/Mn(13);
Coefficient(11)=Mn(13)/Mn(14);
Coefficient(12)=Mn(14)/Mn(15);
Coefficient(13)=Mn(15)/Mn(24);
Coefficient(14)=Mn(17)/Mn(18);
Coefficient(15)=Mn(17)/Mn(14);
Coefficient(16)=Mn(17)/Mn(15);
Coefficient(17)=Mn(17)/Mn(24);
Coefficient(18)=Mn(12)/Mn(24);
Coefficient(19)=Mn(18)/Mn(19);
Coefficient(20)=Mn(18)/Mn(15);
Coefficient(21)=Mn(18)/Mn(24);
Coefficient(22)=Mn(1)/Mn(8);
Coefficient(23)=Mn(4)/Mn(12);
Coefficient(24)=Mn(2)/Mn(9);
Coefficient(25)=Mn(5)/Mn(14);
Coefficient(26)=Mn(5)/Mn(15);
Coefficient(27)=Mn(3)/Mn(10);
Coefficient(28)=Mn(6)/Mn(14);
Coefficient(29)=Mn(7)/Mn(15);
Coefficient(30)=Mn(8)/Mn(9);
Coefficient(31)=Mn(8)/Mn(13);
Coefficient(32)=Mn(1)/Mn(2);
Coefficient(33)=Mn(1)/Mn(13);
Coefficient(34)=Mn(4)/Mn(5);
Coefficient(35)=Mn(4)/Mn(13);
Coefficient(36)=Mn(2)/Mn(3);
Coefficient(37)=Mn(2)/Mn(15);
Coefficient(38)=Mn(2)/Mn(24);
Coefficient(39)=Mn(5)/Mn(6);
Coefficient(40)=Mn(5)/Mn(15);
Coefficient(41)=Mn(5)/Mn(24);
Coefficient(42)=Mn(9)/Mn(10);
Coefficient(43)=Mn(9)/Mn(15);
Coefficient(44)=Mn(9)/Mn(24);
Coefficient(45)=Mn(3)/Mn(15);
Coefficient(46)=Mn(3)/Mn(24);
Coefficient(47)=Mn(6)/Mn(15);
Coefficient(48)=Mn(6)/Mn(24);
Coefficient(49)=Mn(10)/Mn(15);
Coefficient(50)=Mn(10)/Mn(24);
Coefficient(51)=Mn(3)/Mn(11);
Coefficient(52)=Mn(6)/Mn(7);
Coefficient(53)=Mn(10)/Mn(11);
Coefficient(54)=Mn(11)/Mn(24);
Coefficient(55)=Mn(7)/Mn(24);
Coefficient(56)=Mn(16)/Mn(17);
Coefficient(57)=Mn(16)/Mn(14);
Coefficient(58)=Mn(19)/Mn(24);
Coefficient(59)=Mn(20)/Mn(15);
Coefficient(60)=Mn(20)/Mn(24);
Coefficient(61)=Mn(20)/Mn(21);
Coefficient(62)=Mn(20)/Mn(13);
Coefficient(63)=Mn(20)/Mn(14);
Coefficient(64)=Mn(21)/Mn(22);
Coefficient(65)=Mn(21)/Mn(15);
Coefficient(66)=Mn(21)/Mn(24);
Coefficient(67)=Mn(22)/Mn(23);
Coefficient(68)=Mn(22)/Mn(24);
Coefficient(69)=Mn(16)/Mn(8);
Coefficient(70)=Mn(16)/Mn(24);
Coefficient(71)=Mn(16)/Mn(18);
Coefficient(72)=Mn(17)/Mn(9);
Coefficient(73)=Mn(17)/Mn(24);
Coefficient(74)=Mn(17)/Mn(2);
Coefficient(75)=Mn(18)/Mn(10);
Coefficient(76)=Mn(18)/Mn(3);
Coefficient(77)=Mn(18)/Mn(11);
Coefficient(78)=Mn(18)/Mn(7);
Coefficient(79)=Mn(19)/Mn(11);
Coefficient(80)=Mn(19)/Mn(24);
Coefficient(81)=Mn(19)/Mn(15);
Coefficient(82)=Mn(16)/Mn(9);
Coefficient(83)=Mn(16)/Mn(14);
Coefficient(84)=Mn(21)/Mn(2);
Coefficient(85)=Mn(22)/Mn(11);
Coefficient(86)=Mn(23)/Mn(24);
Coefficient(87)=Mn(20)/Mn(9);
Coefficient(88)=Mn(20)/Mn(8);


% Coefficient=zeros(15,1); % 列向量
% Coefficient(1)=Mn(1)/Mn(2);
% Coefficient(2)=Mn(1)/Mn(3);
% Coefficient(3)=Mn(1)/Mn(4);
% Coefficient(4)=Mn(1)/Mn(5);
% Coefficient(5)=Mn(1)/Mn(6);
% Coefficient(6)=Mn(2)/Mn(3);
% Coefficient(7)=Mn(2)/Mn(4);
% Coefficient(8)=Mn(2)/Mn(5);
% Coefficient(9)=Mn(2)/Mn(6);
% Coefficient(10)=Mn(3)/Mn(4);
% Coefficient(11)=Mn(3)/Mn(5);
% Coefficient(12)=Mn(3)/Mn(6);
% Coefficient(13)=Mn(4)/Mn(5);
% Coefficient(14)=Mn(4)/Mn(6);
% Coefficient(15)=Mn(5)/Mn(6);
end