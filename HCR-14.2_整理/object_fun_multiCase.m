function fun_multi = object_fun_multiCase( x_DE, pro, opr_multi, OBJparameter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

fun_multi=0;
days=length(opr_multi); % ������
for i=1:days
    fun_multi=fun_multi+object_fun(x_DE, pro, opr_multi(i), OBJparameter);% object_fun����ƽ��������/��Ȩƽ���������
end
fun_multi=fun_multi/days;% �õ��ܵ�ƽ��������/��Ȩƽ���������
% �ϸ������Ͻ�����ƽ��������/��Ȩƽ������������

end

