function fun=object_fun(x_DE, pro, opr, OBJparameter)
% ------------------------------
% x_DE:�Ż�����
% pro:��������
% opr:��������
% AoR:�������or������
% ��������:
% DE
% �Ӻ�����:
% T=k2t(K)
% YandT=HCR(x_DE, flag, pro, opr)
% ------------------------------

[YandT, ~]=HCR(x_DE,'optimization',pro,opr);

%%%%%%%%%%%%%%%%%%%%%%
YandT_mea(1:7) = k2t(opr.T_Input);
YandT_mea(8:14)= k2t(opr.T_Output);
YandT_mea(15:38)= opr.Ym;

% %%%%%%%%%%%%%%%%%%%%�Ż������¶ȡ������¶ȡ�����%%%%%%%%%%%%%%%%%%%%%%
% fun=sum(((YandT-YandT_mea)./YandT_mea).^2);
% fun=sqrt(fun/size(YandT,2));
%%%%%%%%%%%%%%%%%%%%%�Ż������¶ȡ�����%%%%%%%%%%%%%%%%%%%%%%
if OBJparameter.AoR=='A' % �������
%     W=[ones(1,7) 20*ones(1,6)]; % Ȩֵ,��ʱ���Ը���������
    fun=sum( ( (YandT(8:38)-YandT_mea(8:38)).*OBJparameter.Weight ).^2 );
elseif OBJparameter.AoR=='R' % ������
    fun=sum( ( ( ( YandT(8:38)-YandT_mea(8:38) )./YandT_mea(8:38) ).*OBJparameter.Weight ).^2 );
end
fun=sqrt(fun/size(YandT(8:38),2));
% �ϸ������Ͻ�����ƽ��������/��Ȩƽ������������

end
