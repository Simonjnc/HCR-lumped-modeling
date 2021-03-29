function myplot(result, Fw_H2, pro, opr, plotwhat)
% MATLAB R2013b��ͼ��ͼ���ϴ�R2015a��ͼʱ��ɫ��Ũ��Ϻã�R2016aͼ����������С
figureWidth = 7.5; % ��λ��cm
figureHeight= 6.5; % ��λ��cm
FontName = 'Arial'; % ��������
FontSize = 8; % �����С

% mylegend_lump={'Feed';'Diesel';'Kerosene';'Heavy Naphtha';'Light Naphtha';'Light Ends';'Total'};
mylegend_lump={'FE';'DI';'KE';'HN';'LN';'LE';'Total'}; % ����ͼ��
mylegend_t={'R1B1','R1B2','R1B3','R2B1','R2B2','R2B3','R2B4'}; % �¶�ͼ��
coltyp_y = {'rd','g+','k<','m*','bo','cp','r>'}; % color and type % ���ܻ�ͼ����
col_y = {'r','g','k','m','b','c','r'};

area=pro.area;
L=pro.L;
NumOfBed=pro.NumOfBed.Total;
Mn=pro.Mn;
Fw_Feed=opr.Fw_Feed;
T_Input=k2t(opr.T_Input);
T_Output=k2t(opr.T_Output);
Ym=opr.Ym;

num=size(result,1)/NumOfBed;
if num~=fix(num)
    disp('error! num is not an integer in the myplot function');
end

C=result(:,1:6);
u=calculateU(C',Mn,area,Fw_Feed); % �����ٶ�������m/s
Fv=u'*area*3600; % ���������m^3/h
Fmol=[Fv Fv Fv Fv Fv Fv].*C;% Ħ������(mol/h)
C_mass=mol2mass(C, Mn, 'm'); % kg/m^3, ����'m'����CΪ����
Fm=[Fv Fv Fv Fv Fv Fv].*C_mass;

if strcmp(plotwhat.NormOrReal,'Norm')
    %     z=linspace(0,NumOfBed,size(C,1));%����λ�����
    z=zeros(1,size(C,1));%����λ�����
    for i=1:NumOfBed
        a=(i-1)*num+1;
        b=i*num;
        z(a:b)=(i-1)+linspace(0,1,num);
    end
    xlimBound=NumOfBed;
    xlabelName = 'Reactor bed (dimensionless)';
elseif strcmp(plotwhat.NormOrReal,'Real')
    %     z=linspace(0,NumOfBed,size(C,1));%��ʵ����
    %     zz=linspace(0,1,num+1);
    %     for i=1:length(L)
    %         if i==1
    %             z(1:num+1)=zz*L(1);
    %         else
    %             z((i-1)*num+1:i*num+1)=zz*L(i)+sum(L(1:i-1));
    %         end
    %     end
    z=zeros(1,size(C,1));%����λ�����
    for i=1:NumOfBed
        a=(i-1)*num+1;
        b=i*num;
        if i==1
            z(a:b)=0+linspace(0,1,num)*L(i);
        else
            z(a:b)=sum(L(1:(i-1)))+linspace(0,1,num)*L(i);
        end
    end
    xlimBound=sum(L);
    xlabelName = 'Length of beds (m)'; % 'Axial position'    
else
    disp('error!!! myplot(result,date,plotwhat):date,plotwhat.NormOrReal=''Norm''or''Real''');
end

%%%%%%%%%%%%--�������--%%%%%%%%%%%%
if strcmp(plotwhat.Fv,'yes')
    figure
    set(gcf,'color','w'); %����figure�ı���Ϊ��ɫ
    plot(z,Fv);
    grid on;
    xlabel(xlabelName);
    ylabel('Fv (m^3/h)');
    xlim([0,xlimBound]);
    set(gca,'Box','on'); %ͼ�η��
    title([plotwhat.myTitle,': ','Date ',num2str(opr.date),'-Fv']);
end

%%%%%%%%%%%--Ħ������--%%%%%%%%%%%%
if strcmp(plotwhat.Fmol,'yes')
    figure
    set(gcf,'color','w'); %����figure�ı���Ϊ��ɫ
    plot(z,Fmol(:,1),coltyp_y{1},z,Fmol(:,2),coltyp_y{2},z,Fmol(:,3),coltyp_y{3},z,Fmol(:,4),coltyp_y{4},z,Fmol(:,5),coltyp_y{5},z,Fmol(:,6),coltyp_y{6},z,sum(Fmol,2)',coltyp_y{7});
    grid on;
    xlabel(xlabelName);
    ylabel('Fmol (mol/h)');
    legend(mylegend_lump);
    xlim([0,xlimBound]);
    set(gca,'Box','on'); %ͼ�η��
    title([plotwhat.myTitle,': ','Date ',num2str(opr.date),'-Fmol']);
end

%%%%%%%%%%%--��������--%%%%%%%%%%%%
if strcmp(plotwhat.Fm,'yes')
    figure
    set(gcf,'color','w'); %����figure�ı���Ϊ��ɫ
    plot(z,Fm(:,1),coltyp_y{1},z,Fm(:,2),coltyp_y{2},z,Fm(:,3),coltyp_y{3},z,Fm(:,4),coltyp_y{4},z,Fm(:,5),coltyp_y{5},z,Fm(:,6),coltyp_y{6},z,sum(Fm,2)',coltyp_y{7});
    grid on;
    xlabel(xlabelName);
    ylabel('Fm (kg/h)');
    legend(mylegend_lump);
    xlim([0,xlimBound]);
    set(gca,'Box','on'); %ͼ�η��
    title([plotwhat.myTitle,': ','Date ',num2str(opr.date),'-Fm']);
end

%%%%%%%%%%%%--��������--%%%%%%%%%%%%
if strcmp(plotwhat.Yw,'yes')
    figure
    set(gcf,'color','w'); %����figure�ı���Ϊ��ɫ
    yw=100*mass2yield(Fm);
    plot(z,yw(:,1),coltyp_y{1},z,yw(:,2),coltyp_y{2},z,yw(:,3),coltyp_y{3},z,yw(:,4),coltyp_y{4},z,yw(:,5),coltyp_y{5},z,yw(:,6)',coltyp_y{6});
    xlabel(xlabelName);
    ylabel('Mass yield (%)');
    legend(mylegend_lump(1:6));
%     title([plotwhat.myTitle,': ','Date ',num2str(opr.date),'-Yw']);
    hold on;
%     ym=[Ym;Ym]';
%     yx=[0 xlimBound];
%     plot(yx,ym(1,:),col_y{1},yx,ym(2,:),col_y{2},yx,ym(3,:),col_y{3},yx,ym(4,:),col_y{4},yx,ym(5,:),col_y{5},yx,ym(6,:),col_y{6});
    xlim([0,xlimBound]);
    set(gca,'Box','on'); %ͼ�η��
    grid on;
    hold off;
    
    setFigure( figureWidth, figureHeight, FontSize, FontName ); % %%% ͼ�δ�С����������
end

%%%%%%%%%%%%--�¶ȷֲ�--%%%%%%%%%%%%
if strcmp(plotwhat.T,'yes')
    figure
    set(gcf,'color','w'); %����figure�ı���Ϊ��ɫ
    hold on;
    col_t={'b+';'b*';'b<';'rd';'r>';'ro';'rp'};
    to=[T_Output;T_Output]';
    ti=[T_Input;T_Input]';
    for i=1:NumOfBed
        a=(i-1)*num+1;
        b=i*num;
        plot(z(a:b),k2t(result(a:b,7)),col_t{i});
        
%         plot([z(a) z(b)],to(i,:),col_t{i}(1));
%         plot([z(a) z(b)],ti(i,:),col_t{i}(1));
       
    end
    xlabel(xlabelName);
    ylabel('Temperature (��C)');
    %     title([plotwhat.myTitle,': ','Date ',num2str(opr.date),'-Temperature']);
    xlim([0,xlimBound]);
    set(gca,'Box','on'); %ͼ�η��
    legend(mylegend_t);
    grid on;
    hold off;
    
    setFigure( figureWidth, figureHeight, FontSize, FontName ); % %%% ͼ�δ�С����������
end

%%%%%%%%%%%%--��������--%%%%%%%%%%%%
if strcmp(plotwhat.Fw_H2,'yes')
    figure;
    set(gcf,'color','w'); %����figure�ı���Ϊ��ɫ
    bar(Fw_H2);
    %     set(gca,'XTickLabel',{'R1B1','R1B2','R1B3','R2B1','R2B2','R2B3','R2B4'});
    set(gca,'XTickLabel',{'1','2','3','4','5','6','7'});
    xlabel('Reactor bed');
    %     ylabel('Fw\_H_2 (kg/s)');
    ylabel('Mass flow of RH (kg/s)');
    %     title([plotwhat.myTitle,': ','Date ',num2str(opr.date),'-Fw\_H_2']);
    
    setFigure( figureWidth, figureHeight, FontSize, FontName ); % %%% ͼ�δ�С����������
end