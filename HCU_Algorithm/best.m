% 2.7 ���Ⱥ����������Ӧֵ�������
%�Ŵ��㷨�ӳ���
%Name: best.m
%����� t ��Ⱥ������Ӧֵ����ֵ
function [bestindividual,bestfit]=best(pop,fitvalue)
px = size(pop,1);
bestindividual=pop(1,:);
bestfit=fitvalue(1);
for i=2:px
        if fitvalue(i)>bestfit
                bestindividual=pop(i,:);
                bestfit=fitvalue(i);
        end
end