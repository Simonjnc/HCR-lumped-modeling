%% ������ʼ��
k0(1,1:5)  =[1280176 1086328 0841112 0042000 0045206];%ԭ��->
k0(1,6:9)  =[0250815 0569612 0036000 0050900];%����->
k0(1,10:12)=[0290966 0039000 0062300];%��ú->
k0(1,13:14)=[0019000 0048000];%��ʯ->
k0(1,15)   = 0057482;%��ʯ->
E1=81367.6;
E2=93052.0;
E3=76481.8;
E4=68662.7;
E5=64286.1;
k0E=[k0 E1 E2 E3 E4 E5 1.08];
xmin = k0E*0.9;
xmax = k0E*1.1;

% �������ݼ���������
date_multi=1:10; %ѡȡʱ��

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

% Ŀ�꺯������
OBJparameter.AoR='A';
% OBJparameter.AoR='R';
OBJparameter.Weight=[1 1 1 1 1 1 1 20 20 20 20 20 20];

%% SA��ʼ����
% N=20;%��������
% temp=20;%��ʼ�¶�
% T=50;%��������
% k=0.1;%�¶�λ��ϵ��
% kt=0.05;%�¶ȸ���ϵ��
% de=0.99;%�¶Ƚ�������
% minx=0;
% maxx=10;%����
% (xmax-xmin).*rand(1,chromlength) + xmin;
% location=10*rand(1,N);%���ӳ�ʼλ��
% present_value=equation(location);%���ӵ�ǰ��


%% SA������
ObjectiveFunction = @(x)object_fun_multiCase( x, pro, opr_multi, OBJparameter );   % Function handle to the objective function
X0 = k0E;   % Starting point
lb = k0E*0.9;     % Lower bound
ub = k0E*1.1;       % Upper bound

options = saoptimset('MaxIter',200,'StallIterLim',200,'TolFun',1e-15,'AnnealingFcn',@annealingfast,'InitialTemperature',50,'TemperatureFcn',@temperatureexp,'ReannealInterval',500,'PlotFcns',{@saplotbestx, @saplotbestf, @saplotx, @saplotf,@saplottemperature});

[x,fval] = simulannealbnd(ObjectiveFunction,X0,lb,ub,options);

best_vector = x;

save('HCR6_SA_DATA');
%% ��ʼ����
% 
% for i=1:popsize
%     
%     pop(i,:) = (xmax-xmin).*rand(1,chromlength) + xmin;  % ����1��Dά����
% 
% end
% 
% for t=1:T
% 
%     dx_av=k*temp;%��ǰ�¶�������ƽ���ƶ�����
%     probability=exp(-1/(kt*temp));
%     disp(probability);
%     temp=temp*de;%�¶ȱ仯
% 
%     for p=1:N
% 
%         dx=0.5*dx_av*randn+dx_av;%��ƽ���ƶ�����Ϊ������̬�ֲ���
% 
%         if rand>0.5  %0.5�ĸ���Ϊ-
%             dx=-dx;
%         end
% 
%         local=location(p)+dx;
% 
%         if (local<maxx)&&(local>minx)%�ж��Ƿ�Խ��
%             local_value=equation(local);
% 
%             if local_value>present_value(p)
%                 location(p)=local;
%                 present_value(p)=local_value;
%             elseif rand<probability
%                 location(p)=local;
%                 present_value(p)=local_value;
%             end
% 
%         end
%     end
% end
% end
% 
% 
% x=minx:0.01:maxx;
% y=equation(x);
% plot(x,y);
% hold on;
% plot(location, present_value,'*');
% disp(location);
% 
% function y=equation(x)
% y=10*cos(0.4*pi*x).*sin(0.1*pi*x);
% end


