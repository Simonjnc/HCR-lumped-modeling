function yw=mass2yield(Fm)
% ------------------------------
% ��������:
% YandT=HCR(x_DE, flag, pro, opr)
% myplot(result,date,plotwhat)
% �Ӻ�����
% ------------------------------

% yw=zeros(size(Fm));
% for i=1:6
%     yw(:,i)=Fm(:,i)./s; % ��һ��,�õ���������
% end
s=sum(Fm(1,:));% ��y_mass��һ�����
yw=Fm/s;

end