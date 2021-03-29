function fun=object_fun(x_DE, pro, opr, OBJparameter)
% ------------------------------
% x_DE:优化变量
% pro:物性数据
% opr:操作条件
% AoR:绝对误差or相对误差
% 父函数有:
% DE
% 子函数有:
% T=k2t(K)
% YandT=HCR(x_DE, flag, pro, opr)
% ------------------------------

[YandT, ~]=HCR(x_DE,'optimization',pro,opr);

%%%%%%%%%%%%%%%%%%%%%%
YandT_mea(1:7) = k2t(opr.T_Input);
YandT_mea(8:14)= k2t(opr.T_Output);
YandT_mea(15:38)= opr.Ym;

% %%%%%%%%%%%%%%%%%%%%优化进口温度、出口温度、产率%%%%%%%%%%%%%%%%%%%%%%
% fun=sum(((YandT-YandT_mea)./YandT_mea).^2);
% fun=sqrt(fun/size(YandT,2));
%%%%%%%%%%%%%%%%%%%%%优化出口温度、产率%%%%%%%%%%%%%%%%%%%%%%
if OBJparameter.AoR=='A' % 绝对误差
%     W=[ones(1,7) 20*ones(1,6)]; % 权值,暂时不对父函数开放
    fun=sum( ( (YandT(8:38)-YandT_mea(8:38)).*OBJparameter.Weight ).^2 );
elseif OBJparameter.AoR=='R' % 相对误差
    fun=sum( ( ( ( YandT(8:38)-YandT_mea(8:38) )./YandT_mea(8:38) ).*OBJparameter.Weight ).^2 );
end
fun=sqrt(fun/size(YandT(8:38),2));
% 严格意义上讲不是平均相对误差/加权平均绝对误差！！！

end
