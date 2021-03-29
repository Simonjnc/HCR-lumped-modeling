clc
clear 
close all

%% ��ʼ��ACO����
% ָǰ����
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

E=0.001;
maxnum=5;%����������
narvs=21;%Ŀ�꺯�����Ա�������
particlesize=20;%����Ⱥ��ģ
c1=2;%ÿ�����ӵĸ���ѧϰ���ӣ����ٶȳ���
c2=2;%ÿ�����ӵ����ѧϰ���ӣ����ٶȳ���
w=0.6;%��������
vmax=5;%���ӵ��������ٶ�
v=2*rand(particlesize,narvs);%���ӷ����ٶ�
x=(rand(particlesize,1).*0.2 + 0.9 )*k0E;%��������λ��
%������Ӧ�Ⱥ���
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

%% PSO�Ż�

% fitness=inline('(x(1)^2+x(2)^2)/10000','x');
for i=1:particlesize
	f(i)=object_fun_multiCase( (x(i,:)), pro, opr_multi, OBJparameter );
end
personalbest_x=x; %
personalbest_faval=f; %
[globalbest_faval,i]=min(personalbest_faval);
globalbest_x=personalbest_x(i,:); 
k=1;
while (k<=maxnum)
	for i=1:particlesize
			f(i)=object_fun_multiCase( (x(i,:)), pro, opr_multi, OBJparameter );
		if f(i)<personalbest_faval(i)
			personalbest_faval(i)=f(i);
			personalbest_x(i,:)=x(i,:);
		end
	end
	[globalbest_faval,i]=min(personalbest_faval);
	globalbest_x=personalbest_x(i,:);
	for i=1:particlesize
		v(i,:)=w*v(i,:)+c1*rand*(personalbest_x(i,:)-x(i,:))...
			+c2*rand*(globalbest_x-x(i,:));
		for j=1:narvs
			if v(i,j)>vmax
				v(i,j)=vmax;
			elseif v(i,j)<-vmax
				v(i,j)=-vmax;
            end
		end
		x(i,:)=x(i,:)+v(i,:);
    end
    ff(k)=globalbest_faval;
    if globalbest_faval<E
        break
    end
%       figure(1)
%       for i= 1:particlesize
%       plot(x(i,1),x(i,2),'*')
%       end
	k=k+1
end
xbest=globalbest_x;
figure(2)
set(gcf,'color','white');
plot(1:length(ff),ff)

% save('HCR6_PSO_DATA');