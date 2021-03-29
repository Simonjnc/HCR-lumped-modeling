function u=calculateU(C, Mn, area, Fw_Feed)
% ------------------------------
% 父函数有:
% dCondition=ode15s_hcr(~,Condition,k0,E,bed,pro,opr,Fw_H2_next):此时C为列向量
% myplot(result,date,plotwhat):此时C为矩阵
% ------------------------------

u=Fw_Feed./(area*Mn'*C); % 一个数除以向量或矩阵只能用点除

end
