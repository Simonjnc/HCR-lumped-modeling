%% ��ջ���
clear
clc

%% ��������
k0(1,1:5)  =[1270176 1016328 0911112 0040000 0050206];%ԭ��->
k0(1,6:9)  =[0250815 0549612 0040000 0050900];%����->
k0(1,10:12)=[0280966 0040000 0060300];%��ú->
k0(1,13:14)=[0020000 0052000];%��ʯ->
k0(1,15)   = 0061482;%��ʯ->
E1=81367.6;
E2=93052.0;
E3=80481.8;
E4=70662.7;
E5=69286.1;
k0E=[k0 E1 E2 E3 E4 E5 1.1];

Lb = k0E*0.9;
Ub = k0E*1.1;

Vmax = 1;
Vmin = -1;

w = 0.6;      % �������� 
c1 = 2;       % ���ٳ���
c2 = 2;       % ���ٳ���

Dim = 21;            % ά��
SwarmSize = 10;    % ����Ⱥ��ģ
% ObjFun = @PSO_PID;  % ���Ż��������

MaxIter = 10;      % ����������  
MinFit = 0.1;       % ��С��Ӧֵ 

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


%% ����Ⱥ��ʼ��
    Range = ones(SwarmSize,1)*(Ub-Lb);
    Swarm = rand(SwarmSize,Dim).*Range + ones(SwarmSize,1)*Lb;      % ��ʼ������Ⱥ
    VStep = rand(SwarmSize,Dim)*(Vmax-Vmin) + Vmin;             % ��ʼ���ٶ�
    fSwarm = zeros(SwarmSize,1);
for i=1:SwarmSize
    fSwarm(i,:) = object_fun_multiCase( Swarm(i,:), pro, opr_multi, OBJparameter );                        % ����Ⱥ����Ӧֵ
end

%% ���弫ֵ��Ⱥ�弫ֵ
[bestf bestindex]=min(fSwarm);
zbest=Swarm(bestindex,:);   % ȫ�����
gbest=Swarm;                % �������
fgbest=fSwarm;              % ���������Ӧֵ
fzbest=bestf;               % ȫ�������Ӧֵ

%% ����Ѱ��
iter = 0;
y_fitness = zeros(1,MaxIter);   % Ԥ�Ȳ���4���վ���
K_p = zeros(1,MaxIter);         
K_i = zeros(1,MaxIter);
K_d = zeros(1,MaxIter);
while( (iter < MaxIter) && (fzbest > MinFit) )
    for j=1:SwarmSize
        % �ٶȸ���
        VStep(j,:) = w*VStep(j,:) + c1*rand*(gbest(j,:) - Swarm(j,:)) + c2*rand*(zbest - Swarm(j,:));
        if VStep(j,:)>Vmax, VStep(j,:)=Vmax; end
        if VStep(j,:)<Vmin, VStep(j,:)=Vmin; end
        % λ�ø���
        Swarm(j,:)=Swarm(j,:)+VStep(j,:);
        for k=1:Dim
            if Swarm(j,k)>Ub(k), Swarm(j,k)=Ub(k); end
            if Swarm(j,k)<Lb(k), Swarm(j,k)=Lb(k); end
        end
        % ��Ӧֵ
        fSwarm(j,:) = object_fun_multiCase( Swarm(i,:), pro, opr_multi, OBJparameter ); 
        % �������Ÿ���     
        if fSwarm(j) < fgbest(j)
            gbest(j,:) = Swarm(j,:);
            fgbest(j) = fSwarm(j);
        end
        % Ⱥ�����Ÿ���
        if fSwarm(j) < fzbest
            zbest = Swarm(j,:);
            fzbest = fSwarm(j);
        end
    end 
    iter = iter+1                     % ������������
    y_fitness(1,iter) = fzbest;         % Ϊ��ͼ��׼��
    K_p(1,iter) = zbest(1);
    K_i(1,iter) = zbest(2);
    K_d(1,iter) = zbest(3);
end

figure(1)      % ��������ָ��ITAE�ı仯����
plot(y_fitness,'LineWidth',2)
title('���Ÿ�����Ӧֵ','fontsize',18);
xlabel('��������','fontsize',18);ylabel('��Ӧֵ','fontsize',18);
set(gca,'Fontsize',18);