function yw=mass2yield(Fm)
% ------------------------------
% 父函数有:
% YandT=HCR(x_DE, flag, pro, opr)
% myplot(result,date,plotwhat)
% 子函数无
% ------------------------------

% yw=zeros(size(Fm));
% for i=1:6
%     yw(:,i)=Fm(:,i)./s; % 归一化,得到质量产率
% end
s=sum(Fm(1,:));% 对y_mass第一行求和
yw=Fm/s;

end