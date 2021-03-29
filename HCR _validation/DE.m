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

lump.name={'VNA','HNA','MNA','VN','HN','MN','LN','VA','HA','MA','LA','VP','HP','MP','LP','VS','HS','MS','LS','VNI','HNI','MNI','LNI','L'};

% �������ݼ���������
% ע:date_multi��Ϊ����(������ѵ��),Ҳ��Ϊһ����(������ѵ��)
date_multi=1:5;

heat_HCR1index=[6.8 3]';
heat_HCR2index=[0.65 0.95 1.35]';
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
F0 = 0.3;% F0�Ǳ�����
Np = 10;
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
% OBJparameter.Weight=[1 1 1 1 1 10 10 10 10 10 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13 13];
OBJparameter.Weight=[1 1 1 1 1 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20 20];
% rng('default');
% k0(1,1:88)=floor(rand(1,88)*1000000);% ָǰ����
% E=floor(rand(1,23)*50000+50000);
% k0E=[k0 E 1.12];
k0(1,1:88)=[600702  780540  149221  699382  451116  81532  256726   602395   1072377  952148  103731  800095  849124  535088  1195090  149998  435249  1119368  819520  689937  747988  30792  705443  834571  959018  797557  490092   329210  630909  126701  751543  30082  209038  24583  83866  1002390  528933  420891  764762  47742   572514  341272  537029  1132061  223275   613399   572398  827870  1038223  953031  222670  677945   431346   159465   107061  378437  1066774   450371   776385  185200   1021127  133118  558739  405423  540050  1037503  512731  158992   158128   259175  726487  151961  743456   314369  1146954  386645  183512  224090  701702  597731  463685  950801  445524  393497  1080433  285010   1033752  926755];

E1=81295;
E2=98597;
E3=107308;
E4=80337;
E5=81751;
E6=60361;
E7=60474;
E8=62589;
E9=78152;
E10=43322;
E11=71561;
E12=98956;
E13=63847;
E14=65446;
E15=102218;
E16=82768;
E17=65521;
E18=69371;
E19=60876;
E20=79935;
E21=65733;
E22=92356;
E23=58556;
k0E=[k0 E1 E2 E3 E4 E5 E6 E7 E8 E9 E10 E11 E12 E13 E14 E15 E16 E17 E18 E19 E20 E21 E22 E23 1.12];%112���Զ���������
% load matlab-hcr_11_0_manual best_vector
% k0E=best_vector;

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
%     save; % ����ÿ�ε������
    
    if best_value_of_now < minerr
        break;
    end
    %     if etime(clock,t1)>60*60
    %         break;
    %     end
end
% hold off

G = G - 1;% ����:�ܵ�������,��Ϊwhileѭ������G=G+1;���Դ˴���1
fprintf('DE���ĵ�ʱ��(cputime)Ϊ:%.2f\n',cputime-t0_cputime);
best_value = best_value_of_now;
best_vector = best_x(G,:);% ���һ��������õ�,ע�ⲻ��end,���ǵ�G��
disp(['best_value = ',num2str(best_value)]);
disp(['   �Ż�ǰ               �Ż���']);
for i=1:88
    fprintf('k%d=%-15.4f   k%d=%-15.4f\n',i,k0(i),i,best_vector(i));
end
for i=1:23
    fprintf('E%d=%-15.4f   E%d=%-15.4f\n',i,k0E(i+88),i,best_vector(i+88));
end
fprintf('Eplus%d=%-11.4f   Eplus%d=%-11.4f\n',i,k0E(112),i,best_vector(112));
% disp(['best_vector = ',num2str(best_vector)]);
% DEtime=etime(clock,t0_clock);
% fprintf('DE���ĵ�ʱ��(etime)Ϊ:%.2f',etime(clock,t0_clock));
%save; % �������ս��

figure;
plot(trace_best_value(1:G,1),trace_best_value(1:G,2));% �������������ź���ֵ֮��Ĺ�ϵͼ

%% ģ��Ԥ��
Test_day=1;%Ԥ��ĳһ��Ĳ��ʣ�����Ϊ��1��
[YandTlast, ~]=HCR(best_vector,'optimization',pro,opr_multi(Test_day));
massvalue=YandTlast(11:34);
molvalue0=YandTlast(11:34)./pro.Mn';
molvalue=100*molvalue0/sum(molvalue0);

Residue_mass=sum(massvalue([1,4,8,12,20]));
Residue_mol=sum(molvalue([1,4,8,12,20]));
Gasoil_mass=sum(massvalue([2,5,9,13,21]));
Gasoil_mol=sum(molvalue([2,5,9,13,21]));
Distillate_mass=sum(massvalue([3,6,10,14,22]));
Distillate_mol=sum(molvalue([3,6,10,14,22]));
Naphtha_mass=sum(massvalue([4,7,11,15,3]));
Naphtha_mol=sum(molvalue([4,7,11,15,23]));
Light_mass=massvalue(24);
Light_mol=molvalue(24);
for i=1:24
    fprintf(' %s������������Ϊ��%.3f%% , Ħ������Ϊ��%.3f%%.\n',lump.name{i},massvalue(i),molvalue(i));
end
disp([' Light(�����)����������Ϊ��',num2str(Light_mass),'%, Ħ������Ϊ��',num2str(Light_mol),'%.']);
disp([' Naphtha(C6-221��)����������Ϊ��',num2str(Naphtha_mass),'%, Ħ������Ϊ��',num2str(Naphtha_mol),'%.']);
disp([' Distillate(221��-371��)����������Ϊ��',num2str(Distillate_mass),'%, Ħ������Ϊ��',num2str(Distillate_mol),'%.']);
disp([' Gas Oil(371��-538��)����������Ϊ��',num2str(Gasoil_mass),'%, Ħ������Ϊ��',num2str(Gasoil_mol),'%.']);
disp([' Residue(>538��)����������Ϊ��',num2str(Residue_mass),'%, ��Ħ������Ϊ��',num2str(Residue_mol),'%.']);

%% ת��Ϊʵ�ʲ�Ʒ���������ռ��ܵķе��и�
lumpcal=zeros(97,4);
concal=zeros(6,2);
lumpcal(:,1)=1:97;
lumpcal(:,2)=[-195.8 -33.43 -60.35 -252.8 -161.5 -88.6 -42.02 -11.72 27.84 60.26 89.78 115.6 124.1 174.2 253.6 316.7 412.7 563.7 71.81 100.9 119.4 156.7 187.3 262.3 270.9 271.2 325.5 334.7 335.1 372.0 375.0 375.4 381.7 569.2 581.7 582.1 588.5 80.09 110.6 138.4 165.2 207.6 264.0 296.2 326.7 360.0 372.1 400.5 443.5 481.3 569.2 607.7 652.0 691.1 219.9 84.16 165.0 248.6 258.9 266.0 352.2 371.7 448.7 458.8 468.1 610.5 700.2 86.57 129.9 232.5 237.2 266.0 448.7 479.7 479.7 692.2 603.5 286.1 299.0 318.1 333.4 349.9 363.9 383.6 396.5 390.3 404.8 414.9 424.2 424.2 437.1 597.3 611.7 622.5 632.0 645.3 645.3];
lumpcal(1:9,3)=massvalue(24)/9;%���ܵ���������
lumpcal(10:14,3)=massvalue(23)/5;
lumpcal(15:16,3)=massvalue(22)/2;
lumpcal(17,3)=massvalue(21);
lumpcal(18,3)=massvalue(20);
lumpcal(19:23,3)=massvalue(19)/5;
lumpcal(24:29,3)=massvalue(18)/6;
lumpcal(30:33,3)=massvalue(17)/4;
lumpcal(34:37,3)=massvalue(16)/5;
lumpcal(38:42,3)=massvalue(15)/5;
lumpcal(43:46,3)=massvalue(14)/4;
lumpcal(47:50,3)=massvalue(13)/4;
lumpcal(51:54,3)=massvalue(12)/4;
lumpcal(55:57,3)=massvalue(11)/3;
lumpcal(58:62,3)=massvalue(10)/5;
lumpcal(63:65,3)=massvalue(9)/3;
lumpcal(66:67,3)=massvalue(8)/2;
lumpcal(68:69,3)=massvalue(7)/2;
lumpcal(70:72,3)=massvalue(6)/3;
lumpcal(73:75,3)=massvalue(5)/3;
lumpcal(76:77,3)=massvalue(4)/2;
lumpcal(78:85,3)=massvalue(3)/8;
lumpcal(86:91,3)=massvalue(2)/6;
lumpcal(92:97,3)=massvalue(1)/6;

lumpcal(1:9,4)=molvalue(24)/9;%���ܵ�Ħ������
lumpcal(10:14,4)=molvalue(23)/5;
lumpcal(15:16,4)=molvalue(22)/2;
lumpcal(17,4)=molvalue(21);
lumpcal(18,4)=molvalue(20);
lumpcal(19:23,4)=molvalue(19)/5;
lumpcal(24:29,4)=molvalue(18)/6;
lumpcal(30:33,4)=molvalue(17)/4;
lumpcal(34:37,4)=molvalue(16)/5;
lumpcal(38:42,4)=molvalue(15)/5;
lumpcal(43:46,4)=molvalue(14)/4;
lumpcal(47:50,4)=molvalue(13)/4;
lumpcal(51:54,4)=molvalue(12)/4;
lumpcal(55:57,4)=molvalue(11)/3;
lumpcal(58:62,4)=molvalue(10)/5;
lumpcal(63:65,4)=molvalue(9)/3;
lumpcal(66:67,4)=molvalue(8)/2;
lumpcal(68:69,4)=molvalue(7)/2;
lumpcal(70:72,4)=molvalue(6)/3;
lumpcal(73:75,4)=molvalue(5)/3;
lumpcal(76:77,4)=molvalue(4)/2;
lumpcal(78:85,4)=molvalue(3)/8;
lumpcal(86:91,4)=molvalue(2)/6;
lumpcal(92:97,4)=molvalue(1)/6;
for ik=1:97
    if lumpcal(ik,2)<=50 %�����
        concal(1,1)=concal(1,1)+lumpcal(ik,3);
        concal(1,2)=concal(1,2)+lumpcal(ik,4);
    elseif lumpcal(ik,2)>50 && lumpcal(ik,2)<=120 %��ʯ����
        concal(2,1)=concal(2,1)+lumpcal(ik,3);
        concal(2,2)=concal(2,2)+lumpcal(ik,4);
    elseif lumpcal(ik,2)>120 && lumpcal(ik,2)<=204 %��ʯ����
        concal(3,1)=concal(3,1)+lumpcal(ik,3);
        concal(3,2)=concal(3,2)+lumpcal(ik,4);
    elseif lumpcal(ik,2)>204 && lumpcal(ik,2)<=310 %��ú
        concal(4,1)=concal(4,1)+lumpcal(ik,3);
        concal(4,2)=concal(4,2)+lumpcal(ik,4);
    elseif lumpcal(ik,2)>310 && lumpcal(ik,2)<=420 %����
        concal(5,1)=concal(5,1)+lumpcal(ik,3);
        concal(5,2)=concal(5,2)+lumpcal(ik,4);
    elseif lumpcal(ik,2)>420       %β��
        concal(6,1)=concal(6,1)+lumpcal(ik,3);
        concal(6,2)=concal(6,2)+lumpcal(ik,4);
    end
end
disp(['�������������Ϊ��',num2str(concal(1,1)),'%']);
disp(['��ʯ��������Ϊ��',num2str(concal(2,1)),'%']);
disp(['��ʯ��������Ϊ��',num2str(concal(3,1)),'%']);
disp(['��ú��������Ϊ��',num2str(concal(4,1)),'%']);
disp(['������������Ϊ��',num2str(concal(5,1)),'%']);
disp(['β����������Ϊ��',num2str(concal(6,1)),'%']);

disp(['�����Ħ������Ϊ��',num2str(concal(1,2)),'%']);
disp(['��ʯĦ������Ϊ��',num2str(concal(2,2)),'%']);
disp(['��ʯĦ������Ϊ��',num2str(concal(3,2)),'%']);
disp(['��úĦ������Ϊ��',num2str(concal(4,2)),'%']);
disp(['����Ħ������Ϊ��',num2str(concal(5,2)),'%']);
disp(['β��Ħ������Ϊ��',num2str(concal(6,2)),'%']);
        



% profile viewer;%�����������ʱ�䣩
%��Ҫ������ת��Ϊ����֡���ʯ���͡���ʯ���͡����͡���ú��β��