function setFigure( width, height, FontSize, FontName, digits )

%%% ͼ�δ�С����������

set(gcf,'Units','Centimeters'); % ���õ�λΪ����
set(gcf,'Position',[2 2 width, height]); % [x, y, width, height]
% ��������û�ͼ�Ĵ�С������Ҫ��word���ٵ�����С

% set(gca,'Position',[.13 .17 .80 .74]);
% ���������xy����ͼƬ��ռ�ı�����������Ҫ�Լ�΢����

% set(get(gca,'XLabel'),'FontSize',FontSize,'FontName','Arial','Vertical','top');
% set(get(gca,'YLabel'),'FontSize',FontSize,'FontName','Arial','Vertical','middle');
set(get(gca,'XLabel'),'FontSize',FontSize,'FontName',FontName);
set(get(gca,'YLabel'),'FontSize',FontSize,'FontName',FontName);
set(findobj('FontSize',10),'FontSize',FontSize);
% ��4���ǽ������С��Ϊ8���֣���Сͼ�������

% set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
% ����ǽ��߿��Ϊ2

if nargin==4 % ������������4��,��û��ָ��������С��λ��
    % ����Ĭ��ֵ
else
%     set(gca,'YTickLabel',num2str((get(gca,'YTick'))','%1.1f')); % ����һλС��
    set(gca,'YTickLabel',num2str((get(gca,'YTick'))',['%1.',num2str(digits),'f'])); % ����digitsλС��
end

end

