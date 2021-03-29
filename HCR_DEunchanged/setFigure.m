function setFigure( width, height, FontSize, FontName, digits )

%%% 图形大小及字体设置

set(gcf,'Units','Centimeters'); % 设置单位为厘米
set(gcf,'Position',[2 2 width, height]); % [x, y, width, height]
% 这句是设置绘图的大小，不需要到word里再调整大小

% set(gca,'Position',[.13 .17 .80 .74]);
% 这句是设置xy轴在图片中占的比例，可能需要自己微调。

% set(get(gca,'XLabel'),'FontSize',FontSize,'FontName','Arial','Vertical','top');
% set(get(gca,'YLabel'),'FontSize',FontSize,'FontName','Arial','Vertical','middle');
set(get(gca,'XLabel'),'FontSize',FontSize,'FontName',FontName);
set(get(gca,'YLabel'),'FontSize',FontSize,'FontName',FontName);
set(findobj('FontSize',10),'FontSize',FontSize);
% 这4句是将字体大小改为8号字，在小图里很清晰

% set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
% 这句是将线宽改为2

if nargin==4 % 如果输入参数是4个,即没有指定坐标轴小数位数
    % 采用默认值
else
%     set(gca,'YTickLabel',num2str((get(gca,'YTick'))','%1.1f')); % 保留一位小数
    set(gca,'YTickLabel',num2str((get(gca,'YTick'))',['%1.',num2str(digits),'f'])); % 保留digits位小数
end

end

