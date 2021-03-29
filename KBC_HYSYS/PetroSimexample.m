clc;
close all;
clear all;
%hsysy aro-test_hen �����ȡ�� one sample
hyApp  = feval('actxserver', 'Hysys.Application'); 
FileRoute = strcat(cd , '\' , '1.hsc');
hyCase = invoke(hyApp.SimulationCases , 'Open', FileRoute);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hyCase.Visible = 1; % ���ӻ�
hyDataTable = hyCase.DataTables;
b = hyDataTable.Item('IN');
%c = hyDataTable.Item('Feed');
a = hyDataTable.Item('OUT');

%%%%%%%%%%%%   initialization   %%%%%%%%%%%%   
%N=11;% variable dimension
%Np=30;% population size

X0=[200
        0.5
        20
        .2
    ];%input_variables
%Feed=[210.638e3	348.5	17870	95175.24286	0.3357	0.0508	0.1594	0.4541]; %input_parameters
%r=[0.011479894	0.005032328	0.086783919	0.896703859]; %output

x=X0'

len=size(x,1);
col=size(x,2);


y=[];
f=[];
for i=1:len
  hyCase.Solver.CanSolve =0; % ֹͣSolver
  for m=1:col
      F=["2tem","2mass","4tem","4mass"];
      FF=cellstr(F);
      F(m)=x(i,m);
      f(m)=str2num(F(m));
      FF(m)
      b.VarDefinitions.Item(cell2mat(FF(m))).Variable.SetValue(f(m));
      
%     F1=x(i,1);%������ֵ
%     F2=x(i,2);
%     F3=x(i,3);
%     F4=x(i,4);
%     F5=x(i,5);
%     F6=x(i,6);
%     F7=x(i,7);
%     F8=x(i,8);
%     F9=x(i,9);
       
  end
      
%     b.VarDefinitions.Item('F1').Variable.SetValue(F1);%���������HYSYS
%     b.VarDefinitions.Item('F2').Variable.SetValue(F2);
%     b.VarDefinitions.Item('F3').Variable.SetValue(F3);
%     b.VarDefinitions.Item('F4').Variable.SetValue(F4);
%     b.VarDefinitions.Item('F5').Variable.SetValue(F5);
%     
%     b.VarDefinitions.Item('F6').Variable.SetValue(F6);
%     b.VarDefinitions.Item('F7').Variable.SetValue(F7);
%     b.VarDefinitions.Item('F8').Variable.SetValue(F8);
%     b.VarDefinitions.Item('F9').Variable.SetValue(F9);
   
    hyCase.Solver.CanSolve =1; % ����Solver   

    y(i,1)=a.VarDefinitions.Item('outfrac').Variable.GetValue();%��ò�Ʒ����
    y(i,2)=a.VarDefinitions.Item('outtem').Variable.GetValue();
    y(i,3)=a.VarDefinitions.Item('outmass').Variable.GetValue();
    
end

y