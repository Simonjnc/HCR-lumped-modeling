%查看各馏程段（50℃为一段）集总数量
temp2=zeros(97,1);
temp2=lumpcal(:,2);
stor=zeros(15,2);
stor(:,1)=50:50:750;
for i=1:97
    if temp2(i)<=50
        stor(1,2)=stor(1,2)+1;
    elseif temp2(i)>50 && temp2(i)<=100
        stor(2,2)=stor(2,2)+1;
    elseif temp2(i)>100 && temp2(i)<=150
        stor(3,2)=stor(3,2)+1;
    elseif temp2(i)>150 && temp2(i)<=200
        stor(4,2)=stor(4,2)+1;
    elseif temp2(i)>200 && temp2(i)<=250
        stor(5,2)=stor(5,2)+1;
    elseif temp2(i)>250 && temp2(i)<=300
        stor(6,2)=stor(6,2)+1;
    elseif temp2(i)>300 && temp2(i)<=350
        stor(7,2)=stor(7,2)+1;
    elseif temp2(i)>350 && temp2(i)<=400
        stor(8,2)=stor(8,2)+1;
    elseif temp2(i)>400 && temp2(i)<=450
        stor(9,2)=stor(9,2)+1;
    elseif temp2(i)>450 && temp2(i)<=500
        stor(10,2)=stor(10,2)+1;
    elseif temp2(i)>500 && temp2(i)<=550
        stor(11,2)=stor(11,2)+1;
    elseif temp2(i)>550 && temp2(i)<=600
        stor(12,2)=stor(12,2)+1;
    elseif temp2(i)>600 && temp2(i)<=650
        stor(13,2)=stor(13,2)+1;
    elseif temp2(i)>650 && temp2(i)<=700
        stor(14,2)=stor(14,2)+1;
    elseif temp2(i)>700 && temp2(i)<=750
        stor(15,2)=stor(15,2)+1;
    end
end
 stor