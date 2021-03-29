%�¶������ȷ���
clear
clc
load matlab.mat
%% ģ��Ԥ��
Test_day=1;%Ԥ��ĳһ��Ĳ��ʣ�����Ϊ��1��
for jjj = 1:100   %�����¶ȵı仯�Բ���Ӱ��
    opr_multi(Test_day).T_Input = [606.6500 629.9500 647.4500 654.0500 654.7500]-56+jjj;
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
%     for i=1:24
%         fprintf(' %s������������Ϊ��%.3f%% , Ħ������Ϊ��%.3f%%.\n',lump.name{i},massvalue(i),molvalue(i));
%     end
%     disp([' Light(�����)����������Ϊ��',num2str(Light_mass),'%, Ħ������Ϊ��',num2str(Light_mol),'%.']);
%     disp([' Naphtha(C6-221��)����������Ϊ��',num2str(Naphtha_mass),'%, Ħ������Ϊ��',num2str(Naphtha_mol),'%.']);
%     disp([' Distillate(221��-371��)����������Ϊ��',num2str(Distillate_mass),'%, Ħ������Ϊ��',num2str(Distillate_mol),'%.']);
%     disp([' Gas Oil(371��-538��)����������Ϊ��',num2str(Gasoil_mass),'%, Ħ������Ϊ��',num2str(Gasoil_mol),'%.']);
%     disp([' Residue(>538��)����������Ϊ��',num2str(Residue_mass),'%, ��Ħ������Ϊ��',num2str(Residue_mol),'%.']);
    
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
    num(jjj,1)=concal(1,1);
    num(jjj,2)=concal(2,1);
    num(jjj,3)=concal(3,1);
    num(jjj,4)=concal(4,1);
    num(jjj,5)=concal(5,1);
    num(jjj,6)=concal(6,1);
%     disp(['�������������Ϊ��',num2str(concal(1,1)),'%']);
%     disp(['��ʯ��������Ϊ��',num2str(concal(2,1)),'%']);
%     disp(['��ʯ��������Ϊ��',num2str(concal(3,1)),'%']);
%     disp(['��ú��������Ϊ��',num2str(concal(4,1)),'%']);
%     disp(['������������Ϊ��',num2str(concal(5,1)),'%']);
%     disp(['β����������Ϊ��',num2str(concal(6,1)),'%']);
%     
%     disp(['�����Ħ������Ϊ��',num2str(concal(1,2)),'%']);
%     disp(['��ʯĦ������Ϊ��',num2str(concal(2,2)),'%']);
%     disp(['��ʯĦ������Ϊ��',num2str(concal(3,2)),'%']);
%     disp(['��úĦ������Ϊ��',num2str(concal(4,2)),'%']);
%     disp(['����Ħ������Ϊ��',num2str(concal(5,2)),'%']);
%     disp(['β��Ħ������Ϊ��',num2str(concal(6,2)),'%']);
%     
     
    
end

pp = 100;
% title('��ͬ�¶��¸��������')
% plot(1:pp,num(1:pp,1),'-b','LineWidth',1.5);
% hold on
% plot(1:pp,num(1:pp,2),'og');
% hold on
% plot(1:pp,num(1:pp,3),'xr');
% hold on
plot(1:pp,num(1:pp,4),'m','LineWidth',1.5);
% hold on
% plot(1:pp,num(1:pp,5),':k');
% hold on
% plot(1:pp,num(1:pp,6),'.c');
% legend('�����','��ʯ','��ʯ','��ú','����','β��')
% xlabel('�¶Ȳ������');
% ylabel('��������(%)');


% profile viewer;%�����������ʱ�䣩
%��Ҫ������ת��Ϊ����֡���ʯ���͡���ʯ���͡����͡���ú��β��