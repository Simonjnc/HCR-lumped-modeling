clc;
close all;
clear all;
%hsysy aro-test_hen 输入和取数 one sample
hyApp  = feval('actxserver', 'Hysys.Application'); 
FileRoute = strcat(cd , '\' , '1.hsc');
hyCase = invoke (hyApp.SimulationCases , 'Open', FileRoute);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hyCase.Visible = 1; % 可视化
hyDataTable = hyCase.DataTables;
b = hyDataTable.Item('hen_input');
%c = hyDataTable.Item('Feed');
a = hyDataTable.Item('hen_output');

%%%%%%%%%%%%   initialization   %%%%%%%%%%%%   
%N=11;% variable dimension
%Np=30;% population size

X0=[196812000.000000/3600
    248292000.000000/3600
    281844000.000000/3600
    1012166442.52347/3600
    1927980309.36160/3600
    40.0000000000000
    100.000000000000
    100.000000000000
    40.0000000000000
    ];%input_variables
%Feed=[210.638e3	348.5	17870	95175.24286	0.3357	0.0508	0.1594	0.4541]; %input_parameters
%r=[0.011479894	0.005032328	0.086783919	0.896703859]; %output

x=X0'

len=size(x,1);
col=size(x,2);


y=[];
f=[];
for i=1:len
  hyCase.Solver.CanSolve =0; % 停止Solver
  for m=1:col
      F=["F1",'F2','F3','F4','F5','F6','F7','F8','F9'];
      FF=cellstr(F)
% AR2RE，RE2AS，AR2SA，SA2GA，SA2NA，SA2DI，AR2GA，AR2NA，AR2DI，AR2VGO，SA2VGO
      F(m)=x(i,m);
      f(m)=str2num(F(m));
      FF(m)
      b.VarDefinitions.Item(FF(m)).Variable.SetValue(f(m));
      
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
    
    
    
    j=i
   
    hyCase.Solver.CanSolve =1; % 启动Solver    
    y(j,1)=a.VarDefinitions.Item('H1ST').Variable.GetValue();%获得产品数据
    y(j,2)=a.VarDefinitions.Item('H1TT').Variable.GetValue();
    y(j,3)=a.VarDefinitions.Item('H1F').Variable.GetValue()*3600;
    y(j,4)=a.VarDefinitions.Item('H1cp').Variable.GetValue();
    
    y(j,5)=a.VarDefinitions.Item('H2ST').Variable.GetValue();
    y(j,6)=a.VarDefinitions.Item('H2TT').Variable.GetValue();
    y(j,7)=a.VarDefinitions.Item('H2F').Variable.GetValue()*3600;
    y(j,8)=a.VarDefinitions.Item('H2cp').Variable.GetValue();
    
    y(j,9)=a.VarDefinitions.Item('H3ST').Variable.GetValue();
    y(j,10)=a.VarDefinitions.Item('H3TT').Variable.GetValue();
    y(j,11)=a.VarDefinitions.Item('H3F').Variable.GetValue()*3600;
    y(j,12)=a.VarDefinitions.Item('H3cp').Variable.GetValue();
    
    y(j,13)=a.VarDefinitions.Item('H4ST').Variable.GetValue();
    y(j,14)=a.VarDefinitions.Item('H4TT').Variable.GetValue();
    y(j,15)=a.VarDefinitions.Item('H4F').Variable.GetValue()*3600; 
    y(j,16)=a.VarDefinitions.Item('H4cp').Variable.GetValue(); 
    
    y(j,17)=a.VarDefinitions.Item('C1ST').Variable.GetValue();
    y(j,18)=a.VarDefinitions.Item('C1TT').Variable.GetValue();
    y(j,19)=a.VarDefinitions.Item('C1F').Variable.GetValue()*3600;
    y(j,20)=a.VarDefinitions.Item('C1cp').Variable.GetValue();
    
    y(j,21)=a.VarDefinitions.Item('C2ST').Variable.GetValue();
    y(j,22)=a.VarDefinitions.Item('C2TT').Variable.GetValue();
    y(j,23)=a.VarDefinitions.Item('C2F').Variable.GetValue()*3600;
    y(j,24)=a.VarDefinitions.Item('C2cp').Variable.GetValue();
    
    y(j,25)=a.VarDefinitions.Item('C3ST').Variable.GetValue();
    y(j,26)=a.VarDefinitions.Item('C3TT').Variable.GetValue();   
    y(j,27)=a.VarDefinitions.Item('C3F').Variable.GetValue()*3600;
    y(j,28)=a.VarDefinitions.Item('C3cp').Variable.GetValue();
    
    y(j,29)=a.VarDefinitions.Item('C4ST').Variable.GetValue();
    y(j,30)=a.VarDefinitions.Item('C4TT').Variable.GetValue();
    y(j,31)=a.VarDefinitions.Item('C4F').Variable.GetValue()*3600;
    y(j,32)=a.VarDefinitions.Item('C4cp').Variable.GetValue();
    
    y(j,33)=a.VarDefinitions.Item('C5ST').Variable.GetValue();
    y(j,34)=a.VarDefinitions.Item('C5TT').Variable.GetValue();
    y(j,35)=a.VarDefinitions.Item('C5F').Variable.GetValue()*3600;
    y(j,36)=a.VarDefinitions.Item('C5cp').Variable.GetValue();  
    
    y(j,37)=a.VarDefinitions.Item('C6ST').Variable.GetValue();
    y(j,38)=a.VarDefinitions.Item('C6TT').Variable.GetValue();
    y(j,39)=a.VarDefinitions.Item('C6F').Variable.GetValue()*3600;
    y(j,40)=a.VarDefinitions.Item('C6cp').Variable.GetValue();
    
    y(j,41)=a.VarDefinitions.Item('C7ST').Variable.GetValue();
    y(j,42)=a.VarDefinitions.Item('C7TT').Variable.GetValue();
    y(j,43)=a.VarDefinitions.Item('C7F').Variable.GetValue()*3600;
    y(j,44)=a.VarDefinitions.Item('C7cp').Variable.GetValue();
    
    y(j,45)=a.VarDefinitions.Item('C8ST').Variable.GetValue();
    y(j,46)=a.VarDefinitions.Item('C8TT').Variable.GetValue();   
    y(j,47)=a.VarDefinitions.Item('C8F').Variable.GetValue()*3600;
    y(j,48)=a.VarDefinitions.Item('C8cp').Variable.GetValue();


 
end

y