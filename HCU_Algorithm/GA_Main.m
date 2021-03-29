close all
clear
clc
%% ������ʼ��
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

%% GA��ʼ����
popsize=20;                         %Ⱥ���С
chromlength=21;                  %Ⱦɫ���������������ά��
pc=0.8;                                %������ʣ�ֻ���������С��pcʱ���Ż��������
pm=0.01;                           %�������
Gm = 50;                          %��������
% best_pop = ones(1,chromlength);      %��¼���Ÿ���
% best_fit = 0;                                        %��¼������Ӧ��ֵ
%% ��ʼ����
t0 = cputime;
for i=1:popsize
    pop(i,:) = (xmax-xmin).*rand(1,chromlength) + xmin;  % ����1��Dά����
    fitvalue(i) = object_fun_multiCase( pop(i,:), pro, opr_multi, OBJparameter ); %������Ӧ��
end

for G=1:Gm
     cputime1 = cputime;
%     pop=initpop(popsize,chromlength); %���������ʼȺ��

    [notebestindividual ,notebestfit]=best(pop,fitvalue);
    [newpop]=selection(pop,fitvalue);               %����
    
    [newpop]=crossover(newpop,pc);               %����              
        
%     [newpop]=mutation(newpop,pm);               %����
%%%%%%%%%%%%%%%%%%%%%%%    �������    %%%%%%%%%%%%%%%%%%%%%
     for mu = 1:popsize
            % ����j,k,p������ͬ����
            a = 1;
            b = popsize;
            dx = randperm(b-a+1) + a- 1;% ����a~b���������
            j = dx(1);
            k = dx(2);
            p = dx(3);
            % Ҫ��֤��i��ͬ
            if j == mu
                j  = dx(4);
            elseif k == mu
                k = dx(4);
            elseif p == mu
                p = dx(4);
            end

            % ��������
            suanzi = exp(1-Gm/(Gm + 1-G)); %����Ӧ����
            F = pm*2^suanzi;  %����Ӧ��������pm~2pm֮��

            % ����ĸ������������������        
            son = newpop(p,:) + F*(newpop(j,:) - newpop(k,:));
            for j = 1: chromlength
                if son(1,j) >xmin(j) && son(1,j) < xmax(j) % ��ֹ���쳬���߽�
                    newpop(mu,j) = son(1,j); % son(1,j)=son(j),��Ϊson��������
                else
                    newpop(mu,j) = (xmax(j) - xmin(j))*rand(1) + xmin(j);
                end
            end
     end
    
    newpop(1,:) =  notebestindividual; %�̳�ǰһ������ø���
    fitvalue(1) = notebestfit;
    
    for ip=1:popsize
        fitvalue(ip) = object_fun_multiCase( newpop(ip,:), pro, opr_multi, OBJparameter ); %���¼�����Ⱥ������Ӧ��
    end
    
    [bestindividual ,bestfit]=best(newpop,fitvalue);     %���Ⱥ������Ӧֵ���ĸ��弰����Ӧֵ
    
    youhuaindividual(G,:) = bestindividual;
    youhuazhi(G)=bestfit;                                                              %���ص� y ������Ӧ��ֵ�����Ǻ���ֵ

    pop = newpop;
    cputime2 = cputime;
    
    disp(['�ѹ�',num2str(G),'����','��Ӧ��ֵΪ��',num2str(bestfit),'����ʱ��Ϊ��',num2str(cputime2-cputime1)]);
end
t_all = cputime-t0;
best_vector = bestindividual; %��¼��������

save('HCR6_GA_DATA'); % �������ս��

figure;
youhuazhi = 1./(youhuazhi/100);
plot(1:Gm,youhuazhi);

legend('��Ӧ������');
xlabel('��������');
ylabel('��Ӧ��');