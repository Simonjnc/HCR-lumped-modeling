% ------------------------------
% ��/������ѵ��
% ��������
% �Ӻ�����:
% T=k2t(K)
% pro=common
% opr=operationCondition(date)
% fun=object_fun(x_DE, pro, opr)
% ------------------------------
clear
close all
%clc



% �������ݼ���������
% ע:date_multi��Ϊ����(������ѵ��),Ҳ��Ϊһ����(������ѵ��)
% date_multi=[1 2 4 7 9 10];% 3��1��-10��������Ϊ�����Ż�����
date_multi=1:10;

heat_HCR1index=[6.0 2.2 1.6]';
heat_HCR2index=[0.5 0.8 1.2 0.45]';
pro=common(heat_HCR1index, heat_HCR2index);

days=length(date_multi);% ������
opr_multi(days)=operationCondition(pro, date_multi(days)); % ���������ṹ�����ʼ��
for i=1:days-1 
    % ע:���1>days-1,��days==1,��ӦΪ�������Ż�,��for��䲻ִ��
    date=date_multi(i);
    opr_multi(i)=operationCondition(pro, date);
end

% ��ֽ�������
Gm = 10;  % Gm����������
F0 = 0.5;% F0�Ǳ�����
Np = 5;
CR = 0.9;  % �������
G= 1; % ��ʼ������
D = 112; % ���������ά��
Gmin = zeros(Gm,1); % ����������ֵ
best_x = zeros(Gm,D); % ���������Ž�
value = zeros(1,Np);
lastvalue = zeros(1,Np);
trace_allvalue   = zeros(Gm,Np); % ��¼ÿ�����и����ֵ
trace_best_value = zeros(Gm,2);
trace_cputime    = zeros(Gm,2);
trace_clock      = zeros(Gm,2);
minerr = 1;% ��Ȩƽ���������
% minerr = 0.005;% ƽ��������

% Ŀ�꺯������
OBJparameter.AoR='A';
% OBJparameter.AoR='R';
OBJparameter.Weight=[1 1 1 1 1 1 1 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20];
% OBJparameter.Weight=[1 1 1 1 1 1 1 1 1 1 1 1 1];
rng('default');
% ָǰ����
k0(1,1:88)=floor(rand(1,88)*1000000);
% k0(1,1:5)  =[1270176 1016328 0911112 0040000 0050206];%ԭ��->
% k0(1,6:9)  =[0250815 0549612 0040000 0050900];%����->
% k0(1,10:12)=[0280966 0040000 0060300];%��ú->
% k0(1,13:14)=[0020000 0052000];%��ʯ->
% k0(1,15)   = 0061482;%��ʯ->
E1=81367.6;
E2=93052.0;
E3=80481.8;
E4=70662.7;
E5=69286.1;
E6=81367.6;
E7=93052.0;
E8=80481.8;
E9=70662.7;
E10=69286.1;
E11=93052.0;
E12=80481.8;
E13=70662.7;
E14=69286.1;
E15=81367.6;
E16=93052.0;
E17=80481.8;
E18=70662.7;
E19=69286.1;
E20=69286.1;
E21=93052.0;
E22=80481.8;
E23=70662.7;
k0E=[k0 E1 E2 E3 E4 E5 E6 E7 E8 E9 E10 E11 E12 E13 E14 E15 E16 E17 E18 E19 E20 E21 E22 E23 1.1];%112���Զ���������
% load matlab-hcr_11_0_manual best_vector
% k0E=best_vector;

% xmin = k0E*0.85;
% xmax = k0E*1.15;
xmin = k0E*0.9;
xmax = k0E*1.1;
% xmin(end)=1;% ȷ��Eplus>1
% xmax(end)=1.2;

X0=zeros(Np,D);
for i=1:Np
    X0(i,:) = (xmax-xmin).*rand(1,D) + xmin;  % ����1��Dά����
end
XG = X0;

for i=1:Np
    %     lastvalue(i) = object_fun(XG(i,:), pro, opr);
    lastvalue(i) = object_fun_multiCase( XG(i,:), pro, opr_multi, OBJparameter );
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

XG_next_1= zeros(Np,D); % ��ʼ��
XG_next_2 = zeros(Np,D);
XG_next = zeros(Np,D);

t0_cputime = cputime;
last_cputime = t0_cputime;
t0_clock = clock;
last_clock = t0_clock;

while G <= Gm
    
    %%%%%%%%%%%%%%%%%%%%%%%%----�������----%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:Np
        % ����j,k,p������ͬ����
        a = 1;
        b = Np;
        dx = randperm(b-a+1) + a-1;% ����a~b���������
        j = dx(1);
        k = dx(2);
        p = dx(3);
        % Ҫ��֤��i��ͬ
        if j == i
            j  = dx(4);
        elseif k == i
            k = dx(4);
        elseif p == i
            p = dx(4);
        end
        
        % ��������
        suanzi = exp(1-Gm/(Gm + 1-G));
        F = F0*2^suanzi; %F0~2F0
        
        % ����ĸ������������������        
        son = XG(p,:) + F*(XG(j,:) - XG(k,:));
        for j = 1: D
            if son(1,j) >xmin(j) && son(1,j) < xmax(j) % ��ֹ���쳬���߽�
                XG_next_1(i,j) = son(1,j); % son(1,j)=son(j),��Ϊson��������
            else
                XG_next_1(i,j) = (xmax(j) - xmin(j))*rand(1) + xmin(j);
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%----�������----%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1: Np
        randx = randperm(D);% [1,2,3,...D]���������
        for j = 1: D
            if rand > CR && randx(1) ~= j % CR = 0.9
                XG_next_2(i,j) = XG(i,j);
            else
                XG_next_2(i,j) = XG_next_1(i,j);
            end
        end
    end
    
    %%%%%%%%%%%%%%%%%%%%%%%%----ѡ�����----%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:Np
        %         a=object_fun(XG_next_2(i,:), pro, opr);
        a = object_fun_multiCase( XG_next_2(i,:), pro, opr_multi, OBJparameter );
        %         b=object_fun(XG(i,:), pro, opr); % (1)
        b = lastvalue(i); % (2)lastvalue(i) = object_fun_multiCase( XG(i,:), pro, opr_multi, OBJparameter );
        if a < b
            XG_next(i,:) = XG_next_2(i,:);
            value(i)=a;
        else
            XG_next(i,:) = XG(i,:);
            value(i)=b;
        end
    end
    lastvalue=value; % (3) 
    
    % �ҳ���Сֵ
    %     for i = 1:Np
    %         value(i) = object_fun(XG_next(i,:));
    %     end
    [value_min,pos_min] = min(value);
    
    % ��G���е�Ŀ�꺯������Сֵ
    Gmin(G) = value_min;
    % �������ŵĸ���
    best_x(G,:) = XG_next(pos_min,:);
    
    %%%%%%%%%%%%%%%%%%%%%%%%----��������----%%%%%%%%%%%%%%%%%%%%%%%%
    %     [value_min,pos_min] = min(Gmin(1:G)); % ��Ϊ���þ�Ӣ��������,��������ط�����ֱ��ȡGmin�����һ��ֵ
    best_value_of_now = value_min;
    disp(['Gm=',num2str(Gm),', G=',num2str(G)]);
    disp(['best_value_of_now = ',num2str(best_value_of_now)]);
    %     best_vector_of_now =  best_x(pos_min,:); % ͬ��,��Ϊ���þ�Ӣ��������,��������ط�����ֱ��ȡGmin�����һ��ֵ
    %     disp(['best_vector_of_now = ',num2str(best_vector_of_now)]);
    %     hold on
    %     plot(G,best_value_of_now,'*');
    
    XG = XG_next;
    trace_allvalue(G,:) = value;
    trace_best_value(G,1) = G;
    trace_best_value(G,2) = best_value_of_now;
    trace_cputime(G,1)    = G;
    trace_cputime(G,2)    = cputime - last_cputime;
    fprintf('cputime spended = %d seconds\n',round(trace_cputime(G,2)));
    last_cputime=cputime;
    trace_clock(G,1)      = G;
    trace_clock(G,2)      = etime(clock,last_clock);
    fprintf('clock time spended = %d seconds\n',round(trace_clock(G,2)));
    last_clock=clock;
    G = G + 1;
    save; % ����ÿ�ε������
    
    if best_value_of_now < minerr
        break;
    end
    %     if etime(clock,t1)>60*60
    %         break;
    %     end
end
% hold off

G = G - 1;% ����:�ܵ�������,��Ϊwhileѭ������G=G+1;���Դ˴���1
best_value = best_value_of_now;
disp(['best_value = ',num2str(best_value)]);
best_vector = best_x(G,:);% ���һ��������õ�,ע�ⲻ��end,���ǵ�G��
disp(['best_vector = ',num2str(best_vector)]);
fprintf('DE���ĵ�ʱ��(cputime)Ϊ:%.2f\n',cputime-t0_cputime);
DEtime=etime(clock,t0_clock);
fprintf('DE���ĵ�ʱ��(etime)Ϊ:%.2f',etime(clock,t0_clock));
save; % �������ս��
% �������������ź���ֵ֮��Ĺ�ϵͼ
figure;
plot(trace_best_value(1:G,1),trace_best_value(1:G,2));

% profile viewer;%�����������ʱ�䣩
