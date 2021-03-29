function fun_multi = object_fun_multiCase( x_DE, pro, opr_multi, OBJparameter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

fun_multi=0;
days=length(opr_multi); % 样本数
for i=1:days
    fun_multi=fun_multi+object_fun(x_DE, pro, opr_multi(i), OBJparameter);% object_fun返回平均相对误差/加权平均绝对误差
end
fun_multi=fun_multi/days;% 得到总的平均相对误差/加权平均绝对误差
% 严格意义上讲不是平均相对误差/加权平均绝对误差！！！

end

