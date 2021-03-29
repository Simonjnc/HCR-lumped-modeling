clc;
close all;
clear all;


%!start C:\HYSYS C:\matlab\KBC_HYSYS\1.hsc
psApp  = feval('actxserver', 'Excel.Application'); 
FileRoute = strcat(cd , '\' , '1.hsc');
hyCase = invoke(psApp.SimulationCases , 'Open', FileRoute);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hyCase.Visible = 1; % 可视化
hyDataTable = hyCase.DataTables;
b = hyDataTable.Item('IN');
%c = hyDataTable.Item('Feed');
a = hyDataTable.Item('OUT');
NP = 50;
%%%%%%%%%%%%   initialization   %%%%%%%%%%%%   
%N=11;% variable dimension
%Np=30;% population size

for num = 1:NP
    x(num,:) = rand*[200,1,200,1];
end

%input_variables
%Feed=[210.638e3	348.5	17870	95175.24286	0.3357	0.0508	0.1594	0.4541]; %input_parameters
%r=[0.011479894	0.005032328	0.086783919	0.896703859]; %output

len=size(x,1);
col=size(x,2);


y=[];
f=[];
for i=1:len
  
  hyCase.Solver.CanSolve =0; % 停止Solver
  for m=1:col
      F=["2tem","2mass","4tem","4mass"];
      FF=cellstr(F);
      F(m)=x(i,m);
      f(m)=str2num(F(m));
      b.VarDefinitions.Item(cell2mat(FF(m))).Variable.SetValue(f(m));
      
%     F1=x(i,1);%变量赋值
%     F2=x(i,2);
%     F3=x(i,3);
%     F4=x(i,4);
%     F5=x(i,5);
%     F6=x(i,6);
%     F7=x(i,7);
%     F8=x(i,8);
%     F9=x(i,9);
       
  end
      
%     b.VarDefinitions.Item('F1').Variable.SetValue(F1);%输入变量到HYSYS
%     b.VarDefinitions.Item('F2').Variable.SetValue(F2);
%     b.VarDefinitions.Item('F3').Variable.SetValue(F3);
%     b.VarDefinitions.Item('F4').Variable.SetValue(F4);
%     b.VarDefinitions.Item('F5').Variable.SetValue(F5);
%     
%     b.VarDefinitions.Item('F6').Variable.SetValue(F6);
%     b.VarDefinitions.Item('F7').Variable.SetValue(F7);
%     b.VarDefinitions.Item('F8').Variable.SetValue(F8);
%     b.VarDefinitions.Item('F9').Variable.SetValue(F9);
   
    hyCase.Solver.CanSolve =1; % 启动Solver   

    y(i,1)=a.VarDefinitions.Item('outfrac').Variable.GetValue();%获得产品数据
    y(i,2)=a.VarDefinitions.Item('outtem').Variable.GetValue();
    y(i,3)=a.VarDefinitions.Item('outmass').Variable.GetValue();
    
end

y = [y,zeros(num,1),x];
disp(["产率","温度","流量"," ","流股1温度","流股1流量","流股2温度","流股2流量"]);
y