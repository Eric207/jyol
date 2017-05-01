------------------------------------------------------------------------------------
-----------------------------------�Զ�ս��---------------------------------------
function War_Auto()             --�Զ�ս��������

	WAR.ShowHead=1;
	WarDrawMap(0);
	ShowScreen();
	lib.Delay(CC.WarAutoDelay);

    if CC.AutoWarShowHead==0 then
	    WAR.ShowHead=0;
	end

    local autotype=War_Think();         --˼�����ս��
	
	if WAR.Person[WAR.CurID]["AI"]==4 then
		autotype=1 
	end
	
    if autotype==0 then  --��Ϣ
        War_AutoEscape();  --���ܿ�
        War_RestMenu();
    elseif autotype==1 then
        War_AutoFight();      --�Զ�ս��
    elseif autotype==2 then    --��ҩ������
        War_AutoEscape();
        War_AutoEatDrug(2);
    elseif autotype==3 then    --��ҩ������
        War_AutoEscape();
         War_AutoEatDrug(3);
    elseif autotype==4 then    --��ҩ������
        War_AutoEscape();
        War_AutoEatDrug(4);
    elseif autotype==5 then    --�Լ�ҽ�ƣ������ε�
        War_AutoEscape();
        --War_AutoDoctor();
    elseif autotype==6 then    --��ҩ�ⶾ
        War_AutoEscape();
        War_AutoEatDrug(6);
    end

    return 0;
end

--˼�����ս��
--���أ�0 ��Ϣ�� 1 ս����2 ʹ����Ʒ���������� 3 ʹ����Ʒ�������� 4 ��ҩ�������� 5 ҽ��
--     6 ʹ����Ʒ�ⶾ

function War_Think()           --˼�����ս��
    local pid=WAR.Person[WAR.CurID]["������"];
    local r=-1;         --���ǵĽ��

    if JY.Person[pid]["����"] <10 then         --��Ϣ
        r=War_ThinkDrug(4);
        if r>=0 then
            return r;
        end
        return 0;
    end

    if JY.Person[pid]["����"]<20 then--or JY.Person[pid]["���˳̶�"]>50 then
        r=War_ThinkDrug(2);       --������������
        if r>=0 then
            return r;
        end
    end

    local rate=-1;         --���������İٷֱ�
    if JY.Person[pid]["����"] <JY.Person[pid]["�������ֵ"] /5 then
        rate=90;
    elseif JY.Person[pid]["����"] <JY.Person[pid]["�������ֵ"] /4 then
        rate=70;
    elseif JY.Person[pid]["����"] <JY.Person[pid]["�������ֵ"] /3 then
        rate=50;
    elseif JY.Person[pid]["����"] <JY.Person[pid]["�������ֵ"] /2 then
        rate=25;
    end

    if Rnd(100)<rate then
        r=War_ThinkDrug(2);       --������������
        if r>=0 then
            return r;
        else             --û������������ҩ�������Ƿ��Լ�ҽ��
		    r=War_ThinkDoctor();
		    if r>=0 then
		       return r;
		    end
        end
    end

    rate=-1;         --���������İٷֱ�
    if JY.Person[pid]["����"] <JY.Person[pid]["�������ֵ"] /5 then
        rate=75;
    elseif JY.Person[pid]["����"] <JY.Person[pid]["�������ֵ"] /4 then
        rate=50;
    end

    if Rnd(100)<rate then
        r=War_ThinkDrug(3);       --������������
        if r>=0 then
            return r;
        end
    end

	--[[
    rate=-1;         --�ⶾ�İٷֱ�
    if JY.Person[pid]["�ж��̶�"] > CC.PersonAttribMax["�ж��̶�"] *3/4 then
        rate=60;
    elseif JY.Person[pid]["�ж��̶�"] >CC.PersonAttribMax["�ж��̶�"] /2 then
        rate=30;
    end

    if Rnd(100)<rate then
        r=War_ThinkDrug(6);       --���ǽⶾ
        if r>=0 then
            return r;
        end
    end
]]--
    local minNeili=War_GetMinNeiLi(pid);     --�����书����С����

    if JY.Person[pid]["����"]>=minNeili then
        r=1;
    else
        r=0;
    end
	if WAR.Person[WAR.CurID]["AI"]==3 or WAR.Person[WAR.CurID]["AI"]==5 then
		r=0
	end
    return r;
end

--�ܷ��ҩ���Ӳ���
--flag=2 ������3������4����  6 �ⶾ
function War_ThinkDrug(flag)             --�ܷ��ҩ���Ӳ���
    local pid=WAR.Person[WAR.CurID]["������"];
    local str;
    local r=-1;

    if flag==2 then
        str="������";
    elseif flag==3 then
        str="������";
    elseif flag==4 then
        str="������";
    elseif flag==6 then
        str="���ж��ⶾ";
    else
        return r;
    end

    local function Get_Add(thingid)    --����ֲ�������ȡ����Ʒthingid���ӵ�ֵ
		if flag==6 then
			return -JY.Thing[thingid][str];   --�ⶾΪ��ֵ
		else
			return JY.Thing[thingid][str];
		end
    end

    if WAR.Person[WAR.CurID]["�ҷ�"]==true then
        for i =1, CC.MyThingNum do
            local thingid=JY.Base["��Ʒ" ..i];
            if thingid>=0 then
                if JY.Thing[thingid]["����"]==3 and Get_Add(thingid)>0 then
                    r=flag;                     ---������������ҩ��������ʹ����Ʒ������
                    break;
                end
            end
        end
    else
        for i =1, 4 do
            local thingid=JY.Person[pid]["Я����Ʒ" ..i];
            if thingid>=0 then
                if JY.Thing[thingid]["����"]==3 and Get_Add(thingid)>0  then
                    r=flag;                     ---������������ҩ��������ʹ����Ʒ������
                    break;
                end
            end
        end
    end

    return r;

end


--�����Ƿ��Լ�ҽ��
function War_ThinkDoctor()          --�����Ƿ���Լ�ҽ��
    local pid=WAR.Person[WAR.CurID]["������"];

	if JY.Person[pid]["����"]<50 or JY.Person[pid]["ҽ��"]<20 then
	    return -1;
	end
--[[
	if JY.Person[pid]["���˳̶�"]>JY.Person[pid]["ҽ��"]+20 then
	    return -1;
	end
]]--
	local rate = -1;
	local v=JY.Person[pid]["�������ֵ"]-JY.Person[pid]["����"];
	if JY.Person[pid]["ҽ��"] < v/4 then
        rate=30;
	elseif JY.Person[pid]["ҽ��"] < v/3 then
	    rate=50;
	elseif JY.Person[pid]["ҽ��"] < v/2 then
	    rate=70;
	else
	    rate=90;
	end

	if Rnd(100) <rate then
	    return 5;
	end

	return -1;
end

---�Զ�ս��
function War_AutoFight()             ---ִ���Զ�ս��

	local wugongnum=War_AutoSelectWugong();    --ѡ���书

	if wugongnum <=0 then --û��ѡ���书����Ϣ
        War_AutoEscape();
        War_RestMenu();
		return
	end
	newAI(wugongnum)
	--[[
	local r=War_AutoMove(wugongnum);         -- �����˷����ƶ�
	if r==1 then   --����ڹ�����Χ
		War_AutoExecuteFight(wugongnum);     --����
	else
   	    War_RestMenu();           --��Ϣ
	end
	]]--
end


function War_AutoSelectWugong()           --�Զ�ѡ����ʵ��书
    local pid=WAR.Person[WAR.CurID]["������"];

    local probability={};       --ÿ���书ѡ��ĸ���

    local wugongnum=0;         --��0��ʼ�����书����Ŀ
	for i =1, CC.Kungfunum do             --����ÿ�ֿ�ѡ���书���ܹ�����
        local wugongid=JY.Person[pid]["�书" ][i];
		if wugongid~=nil then wugongid=wugongid[1]
		else wugongid=0 
		end
		--lib.Debug(JY.Wugong[wugongid]["����"])
        if wugongid>0 and JY.Wugong[wugongid]["�书����"]<=6 and JY.Wugong[wugongid]["�˺�����"]==0 then
		       --ѡ��ɱ�������书������������������������С��������Է���һ�����书��
            --if JY.Wugong[wugongid]["�˺�����"]==0 then
				if JY.Wugong[wugongid]["������������"]<=JY.Person[pid]["����"] then
					local level=math.modf(JY.Person[pid]["�书"][i][2]/100)+1;
					--�ܹ�������Ϊ����
					wugongnum=wugongnum+1
					probability[wugongnum]={i,GetAtk(pid,wugongid,level)}              --(JY.Person[pid]["������"]*3+JY.Wugong[wugongid]["������" .. level ])/2;
					--lib.Debug(probability[wugongnum][1].."|"..probability[wugongnum][2]..'|'..level)
				else
					--probability[i]=0;
				end
			--else            --ɱ�������书
            --   probability[i]=10;  --��С�ĸ���ѡ��ɱ����
			--end
		else
			--probability[i]=0;
		    --wugongnum=i-1;
			--break;
        end
    end

    local maxoffense=0;       --������󹥻���
	for i =1, wugongnum do
        if  probability[i][2]>maxoffense then
            maxoffense=probability[i][2];
        end
    end

    local mynum=0;             --�����ҷ��͵��˸���
	local enemynum=0;
	for i=0, WAR.PersonNum-1 do
	    if WAR.Person[i]["����"]==false then
		    if WAR.Person[i]["�ҷ�"]==WAR.Person[WAR.CurID]["�ҷ�"] then
			    mynum=mynum+1;
			else
			    enemynum=enemynum+1;
			end
		end
	end
--[[
    local factor=0;       --��������Ӱ�����ӣ����˶��������ȹ��������书��ѡ���������
	if enemynum>mynum then
	    factor=2;
	else
	    factor=1;
	end
]]--
	for i =1, wugongnum do       --������������Ч��
        local wugongid=JY.Person[pid]["�书"][i][1];
        if probability[i][2]>0 then
		    if probability[i][2]<maxoffense/2 then       --ȥ��������С���书
			    probability[i][2]=0
			end
			--[[
			local extranum=0;           --�书������ϵĹ�����
			for j,v in ipairs(CC.ExtraOffense) do
				if v[1]==JY.Person[pid]["����"] and v[2]==wugongid then
					extranum=v[3];
					break;
				end
			end
			]]--
    		--local level=math.modf(JY.Person[pid]["�书�ȼ�" .. i]/100)+1;
			--local mmove=JY.Wugong[wugongid]["��Χ"..math.modf((level+2)/3)]
			--mmove=mmove-100*div100(mmove)
			--probability[i]=probability[i]--+JY.Wugong[wugongid]["������Χ"]*factor*mmove*20;
        end
    end

	local s={};           --���ո��������ۼ�
	local maxnum=0;
    for i=1,wugongnum do
		--lib.Debug(probability[i][1]..'|'..probability[i][2])
        s[i]=maxnum;
		maxnum=maxnum+probability[i][2];
	end
	s[wugongnum+1]=maxnum;

	if maxnum==0 then    --û�п���ѡ����书
	    return -1;
	end

    local v=Rnd(maxnum);            --���������
	local selectid=0;
    for i=1,wugongnum do            --���ݲ������������Ѱ�������ĸ��书����
	    if v>=s[i] and v< s[i+1] then
		    selectid=probability[i][1];
			break;
		end
	end
    return selectid;
end


function War_AutoSelectEnemy()             --ѡ��ս������
    local enemyid=War_AutoSelectEnemy_near()
    WAR.Person[WAR.CurID]["�Զ�ѡ�����"]=enemyid;
    return enemyid;
end


function War_AutoSelectEnemy_near()              --ѡ���������

    War_CalMoveStep(WAR.CurID,100,1);           --���ÿ��λ�õĲ���

    local maxDest=math.huge;
    local nearid=-1;
    for i=0,WAR.PersonNum-1 do           --������������ĵ���
        if WAR.Person[WAR.CurID]["�ҷ�"] ~=WAR.Person[i]["�ҷ�"] then
            if WAR.Person[i]["����"]==false then
			   local step=GetWarMap(WAR.Person[i]["����X"],WAR.Person[i]["����Y"],3);
                if step<maxDest then
                    nearid=i;
                    maxDest=step;
                end
            end
        end
    end
    return nearid;
end

--�Զ������˷����ƶ�
--�����书��ţ������书id
--���� 1=���Թ������ˣ� 0 ���ܹ���
function War_AutoMove(wugongnum)              --�Զ������˷����ƶ�
    local pid=WAR.Person[WAR.CurID]["������"];
    local wugongid=JY.Person[pid]["�书"][wugongnum][1];
    local level=math.modf(JY.Person[pid]["�书"][wugongnum][2]/100)+1;
	--local kind,len1,len2

    local wugongtype=JY.Wugong[wugongid]["������Χ"];
	local move=JY.Wugong[wugongid]["������Χ"][math.modf((level+2)/3)][2];
	local movescope=div100(move);
	--kind=movescope
	if movescope>7 then movescope=0 end
	local fightscope=math.fmod(move,10);
	--len2=fightscope
    local scope=movescope+fightscope;
	--len1=math.modf(math.fmod(move,100)/10)


    local x,y;
	local move=128;
    local maxenemy=0;

	local movestep=War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0);   --�����ƶ�����

	--War_AutoCalMaxEnemyMap(wugongid,level);  --������书����������Թ��������˵ĸ���

	for i=0,WAR.Person[WAR.CurID]["�ƶ�����"] do
	    local step_num=movestep[i].num ;
		if step_num==nil or step_num==0 then
		    break;
		end
		for j=1,step_num do
		    local xx=movestep[i].x[j];
			local yy=movestep[i].y[j]

			local num=0;
			--[[
			if wugongtype==0 or wugongtype==2 or wugongtype==3 then
				num=GetWarMap(xx,yy,4)      --�������λ�ÿ��Թ������������˸���
			elseif wugongtype==1  then
				local v=GetWarMap(xx,yy,4)      --�������λ�ÿ��Թ������������˸���
				if v>0 then
					num=War_AutoCalMaxEnemy(xx,yy,wugongid,level);
				end
			end
			]]--
			--���ϸо������ȸ��������ƶ�����ѭ������ȡ�ߵ���xy
			--Ȼ�󣬸��ݸ�xy���Ĳ����Ϣ������ȡ�ĵ��ܹ������ĵ�����Ŀ
			--War_AutoCalMaxEnemyMap�о����岻�󣬿��Կ��Ǹ���War_AutoCalMaxEnemy
			--ʹ�䷵�ع������˵������Ŀ
			num=GetAtkNum(xx,yy,wugongid,level)
			if num>maxenemy then
				maxenemy=num
				x=xx;
				y=yy;
				move=i;
			elseif num==maxenemy and num>0 then
			    if Rnd(3)==0 then
					maxenemy=num
					x=xx;
					y=yy;
					move=i;
				end
			end
		end
	end


    if maxenemy>0 then
	    War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0);   --���¼����ƶ�����
        War_MovePerson(x,y);    --�ƶ�����Ӧ��λ��
		return 1;
	else   --�κ��ƶ���ֱ�ӹ����������ˣ�Ѱ��һ�������ƶ�������������λ�õ�·��
		x,y=War_GetCanFightEnemyXY(scope);       --������Թ��������˵����λ��

		local minDest=math.huge;
        if x==nil then   --�޷��ߵ����Թ������˵ĵط������ܵ��˱�Χס�����߱�����Χס��
             local enemyid=War_AutoSelectEnemy()   --ѡ���������

			 War_CalMoveStep(WAR.CurID,100,0);   --�����ƶ����� �������100��

			 for i=0,CC.WarWidth-1 do
                for j=0,CC.WarHeight-1 do
					local dest=GetWarMap(i,j,3);
                    if dest <128 then
                        local dx=math.abs(i-WAR.Person[enemyid]["����X"])
                        local dy=math.abs(j-WAR.Person[enemyid]["����Y"])
                        if minDest>(dx+dy) then        --��ʱx,y�Ǿ�����˵����·������Ȼ���ܱ�Χס
                            minDest=dx+dy;
                            x=i;
                            y=j;
                        elseif minDest==(dx+dy) then
                            if Rnd(2)==0 then
                                x=i;
                                y=j;
                            end
                        end
                    end
                end
            end
		else
            minDest=0;        --�����ߵ�
		end


		if minDest<math.huge then   --��·����
		    while true do    --��Ŀ��λ�÷����ҵ������ƶ���λ�ã���Ϊ�ƶ��Ĵ���
				local i=GetWarMap(x,y,3);
                if i<=WAR.Person[WAR.CurID]["�ƶ�����"] then
                    break;
                end

                if GetWarMap(x-1,y,3)==i-1 then
                    x=x-1;
                elseif GetWarMap(x+1,y,3)==i-1 then
                    x=x+1;
                elseif GetWarMap(x,y-1,3)==i-1 then
                    y=y-1;
                elseif GetWarMap(x,y+1,3)==i-1 then
                    y=y+1;
                end
            end
            War_MovePerson(x,y);    --�ƶ�����Ӧ��λ��
        end
    end

    return 0;
end

--�õ������ߵ����������˵����λ�á�
--scope���Թ����ķ�Χ
--���� x,y������޷��ߵ�����λ�ã����ؿ�
function War_GetCanFightEnemyXY()
	local num,x,y
	num,x,y=War_realjl(WAR.CurID)
	--lib.Debug(num..'|'..x..','..y)
	if num==-1 then 
		return --WAR.Person[WAR.CurID]["����X"],WAR.Person[WAR.CurID]["����Y"]
	else
		return x,y
	end
end
--[[
function War_GetCanFightEnemyXY(scope)             --�õ������ߵ����������˵����λ��

    local minStep=math.huge;
	local newx,newy;

	War_CalMoveStep(WAR.CurID,100,0);   --�����ƶ����� �������100��
	for x=0,CC.WarWidth-1 do
		for y=0,CC.WarHeight-1 do
			if GetWarMap(x,y,4)>0 then    --���λ�ÿ��Թ���������
				local step=GetWarMap(x,y,3);
				if step<128 then
					if minStep>step then
						minStep=step;
						newx=x;
						newy=y;
					elseif minStep==step then
						if Rnd(2)==0 then
							newx=x;
							newy=y;
						end
					end
				end
			end
		end
	end

	if minStep<math.huge then
	    return newx,newy;
    end
end
]]--

function War_AutoCalMaxEnemyMap(wugongid,level)       --�����ͼ��ÿ��λ�ÿ��Թ����ĵ�����Ŀ

    local wugongtype=JY.Wugong[wugongid]["������Χ"];
	local move=JY.Wugong[wugongid]["��Χ"..math.modf((level+2)/3)];
	local movescope=div100(move);
	local fightscope=move-100*movescope;

	local x0=WAR.Person[WAR.CurID]["����X"];
	local y0=WAR.Person[WAR.CurID]["����Y"];

 	CleanWarMap(4,0);    --��level 4��ͼ��ʾ��Щλ�ÿ��Թ���������

----�㹥�����湥��, ÿ��������Թ����ĵ��˸�������Ȼֻ��Ϊ0��1��
---�����湥���͵㹥��һ�������ᵼ���湥�����ܲ��ܹ��������ĵ��ˣ����������ٶȿ�
	if wugongtype==0 or wugongtype==3 then
		for n=0,WAR.PersonNum-1 do
			if n~=WAR.CurID and WAR.Person[n]["����"]==false and
				WAR.Person[n]["�ҷ�"] ~=WAR.Person[WAR.CurID]["�ҷ�"] then   --����
				local xx=WAR.Person[n]["����X"];
				local yy=WAR.Person[n]["����Y"];
				local movestep=War_CalMoveStep(n,movescope,1);   --�����书�ƶ�����
				for i=1,movescope do
					local step_num=movestep[i].num ;
					if step_num==0 then
						break;
					end
					for j=1,step_num do
						SetWarMap(movestep[i].x[j],movestep[i].y[j],4,1);  --����书�ƶ��ĵط�����Ϊ�ɹ���������֮��
					end
				end
		end
		end
--�߹�����ʮ�� ��¼ÿ���ĵ���Թ��������˵ĸ��������߹��������鲢��׼ȷ����Ҫ��һ����ʵ��
	elseif wugongtype==1 or wugongtype==2  then
		for n=0,WAR.PersonNum-1 do
			if n~=WAR.CurID and WAR.Person[n]["����"]==false and
				WAR.Person[n]["�ҷ�"] ~=WAR.Person[WAR.CurID]["�ҷ�"] then   --����
				local xx=WAR.Person[n]["����X"];
				local yy=WAR.Person[n]["����Y"];
				for direct=0,3 do
					for i=1,movescope do
						local xnew=xx+CC.DirectX[direct+1]*i;
						local ynew=yy+CC.DirectY[direct+1]*i;
						if xnew>=0 and xnew<CC.WarWidth and ynew>=0 and ynew<CC.WarHeight then
							local v=GetWarMap(xnew,ynew,4);
							SetWarMap(xnew,ynew,4,v+1);
						end
					end
				end
			end
		end

	end

end

function War_AutoCalMaxEnemy(x,y,wugongid,level)       --�����(x,y)��ʼ��������ܹ����м�������

    local wugongtype=JY.Wugong[wugongid]["������Χ"];
	local move=JY.Wugong[wugongid]["��Χ"..math.modf((level+2)/3)];
	local movescope=div100(move);
	local fightscope=move-100*movescope;

	local maxnum=0;
	local xmax,ymax;

	if wugongtype==0 or wugongtype==3 then

		local movestep=War_CalMoveStep(WAR.CurID,movescope,1);   --�����书�ƶ�����
		for i=1,movescope do
			local step_num=movestep[i].num ;
			if step_num==0 then
				break;
			end
			for j=1,step_num do
				local xx=movestep[i].x[j];
				local yy=movestep[i].y[j];
				local enemynum=0;

				for n=0,WAR.PersonNum-1 do   --�����书������Χ�ڵĵ��˸���
					 if n~=WAR.CurID and WAR.Person[n]["����"]==false and
					    WAR.Person[n]["�ҷ�"] ~=WAR.Person[WAR.CurID]["�ҷ�"] then
						 local x=math.abs(WAR.Person[n]["����X"]-xx);
						 local y=math.abs(WAR.Person[n]["����Y"]-yy);
						 if x<=fightscope and y <=fightscope then
							  enemynum=enemynum+1;
						 end
					 end
				end

				if enemynum>maxnum then        --��¼�����˺�λ��
					maxnum=enemynum;
					xmax=xx;
					ymax=yy;
				end
			end
		end

	elseif wugongtype==1 then    --�߹���
		for direct=0,3 do           -- ��ÿ������ѭ�����ҳ���������
			local enemynum=0;
			for i=1,movescope do
				local xnew=x+CC.DirectX[direct+1]*i;
				local ynew=y+CC.DirectY[direct+1]*i;

				if xnew>=0 and xnew<CC.WarWidth and ynew>=0 and ynew<CC.WarHeight then
					local id=GetWarMap(xnew,ynew,2);
					if id>=0 then
						if WAR.Person[WAR.CurID]["�ҷ�"] ~= WAR.Person[id]["�ҷ�"] then
							enemynum=enemynum+1;                  --�书������Χ�ڵĵ��˸���
						end
					end
				end
			end
			if enemynum>maxnum then        --��¼�����˺�λ��
				maxnum=enemynum;
				xmax=x+CC.DirectX[direct+1];       --�߹�����¼һ�������������
				ymax=y+CC.DirectY[direct+1];
			end
		end

	elseif wugongtype==2 then --ʮ�ֹ���
		local enemynum=0;
		for direct=0,3 do           -- ��ÿ������ѭ��
			for i=1,movescope do
				local xnew=x+CC.DirectX[direct+1]*i;
				local ynew=y+CC.DirectY[direct+1]*i;
				if xnew>=0 and xnew<CC.WarWidth and ynew>=0 and ynew<CC.WarHeight then
					local id=GetWarMap(xnew,ynew,2);
					if id>=0 then
						if WAR.Person[WAR.CurID]["�ҷ�"] ~= WAR.Person[id]["�ҷ�"] then
							enemynum=enemynum+1;                  --�书������Χ�ڵĵ��˸���
						end
					end
				end
			end
		end
		if enemynum>0 then
			maxnum=enemynum;
			xmax=x;
			ymax=y;
		end
	end
	return maxnum,xmax,ymax;
end

--�Զ�ִ��ս������ʱ��λ��һ�����Դ򵽵���
function War_AutoExecuteFight(wugongnum)            --�Զ�ִ��ս������ʾ��������
    local pid=WAR.Person[WAR.CurID]["������"];
    local x0=WAR.Person[WAR.CurID]["����X"];
    local y0=WAR.Person[WAR.CurID]["����Y"];
    local wugongid=JY.Person[pid]["�书"][wugongnum][1];
    local level=math.modf(JY.Person[pid]["�书"][wugongnum][2]/100)+1;

    local maxnum,x,y=GetAtkNum(x0,y0,wugongid,level);

    if x ~= nil then
        War_Fight_Sub(WAR.CurID,wugongnum,x,y);
	end

end

--����
function War_AutoEscape()                --����
    local pid=WAR.Person[WAR.CurID]["������"];
    if JY.Person[pid]["����"]<=5  then
	    return
	end

    local x,y;

    War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0);   --�����ƶ�����
	WarDrawMap(1)
	ShowScreen()
	local starttime=lib.GetTime();
	local array={}
	local num=0
    for i=0,CC.WarWidth-1 do
        for j=0,CC.WarHeight-1 do
			if GetWarMap(i,j,3)<128 then
                local minDest=math.huge;
                for k=0,WAR.PersonNum-1 do
                    if WAR.Person[WAR.CurID]["�ҷ�"]~=WAR.Person[k]["�ҷ�"] and WAR.Person[k]["����"]==false then
                        local dx=math.abs(i-WAR.Person[k]["����X"])
                        local dy=math.abs(j-WAR.Person[k]["����Y"])
                        if minDest>(dx+dy) then        --���㵱ǰ������������λ��
                            minDest=dx+dy;
                        end
                    end
                end
				num=num+1
				array[num]={}
				array[num].x=i
				array[num].y=j
				array[num].p=minDest
            end
        end
    end
	for i=1,num-1 do
		for j=i,num do
			if array[i].p<array[j].p then
				array[i],array[j]=array[j],array[i]
			end
		end
	end
	for i=2,num do
		if array[i].p<array[1].p/2 then
			num=i-1
			break
		end
	end
	for i=1,num do
		array[i].p=array[i].p*5+GetMovePoint(array[i].x,array[i].y,1)
	end
	for i=1,num-1 do
		for j=i,num do
			if array[i].p<array[j].p then
				array[i],array[j]=array[j],array[i]
			end
		end
	end
	x=array[1].x
	y=array[1].y
	
	local endtime=starttime+200-lib.GetTime()
	if endtime>0 then
		lib.Delay(endtime)
	end
	War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0); 
    War_MovePerson(x,y);    --�ƶ�����Ӧ��λ��

end


---��ҩ
----flag=2 ������3������4����  6 �ⶾ
function War_AutoEatDrug(flag)          ---��ҩ�Ӳ���
    local pid=WAR.Person[WAR.CurID]["������"];
    local life=JY.Person[pid]["����"];
    local maxlife=JY.Person[pid]["�������ֵ"];
    local selectid;
    local minvalue=math.huge;

    local shouldadd;
    local maxattrib;
    local str;
    if flag==2 then
        maxattrib=JY.Person[pid]["�������ֵ"];
        shouldadd=maxattrib-JY.Person[pid]["����"];
        str="������";
    elseif flag==3 then
        maxattrib=JY.Person[pid]["�������ֵ"];
        shouldadd=maxattrib-JY.Person[pid]["����"];
        str="������";
    elseif flag==4 then
        maxattrib=CC.PersonAttribMax["����"];
        shouldadd=maxattrib-JY.Person[pid]["����"];
        str="������";
    elseif flag==6 then
        maxattrib=CC.PersonAttribMax["�ж��̶�"];
        shouldadd=JY.Person[pid]["�ж��̶�"];
        str="���ж��ⶾ";
    else
        return ;
    end

    local function Get_Add(thingid)     --������Ʒ���ӵ�ֵ
	    if flag==6 then
		    return -JY.Thing[thingid][str]/2;   --�ⶾΪ��ֵ
		else
            return JY.Thing[thingid][str];
		end
	end

    if WAR.Person[WAR.CurID]["�ҷ�"]==true then
        local extra=0;
        for i =1, CC.MyThingNum do
            local thingid=JY.Base["��Ʒ" ..i];
            if thingid>=0 then
                local add=Get_Add(thingid);
                if JY.Thing[thingid]["����"]==3 and add>0 then
                    local v=shouldadd-add;
                    if v<0 then               --���Լ���, �����������Һ���ҩƷ
                        extra=1;
                        break;
                    else
                        if v<minvalue then        --Ѱ�Ҽ���������������
                            minvalue=v;
                            selectid=thingid;
                        end
                    end
                end
            end
        end
        if extra==1 then
            minvalue=math.huge;
            for i =1, CC.MyThingNum do
                local thingid=JY.Base["��Ʒ" ..i];
                if thingid>=0 then
                    local add=Get_Add(thingid);
                    if JY.Thing[thingid]["����"]==3 and add>0 then
                        local v=add-shouldadd;
                        if v>=0 then               --���Լ�������
                            if v<minvalue then
                                minvalue=v;
                                selectid=thingid;
                            end
                        end
                    end
                end
            end
        end
        if UseThingEffect(selectid,pid)==1 then       --ʹ����Ч��
            instruct_32(selectid,-1);            --��Ʒ��������
        end
    else
        local extra=0;
        for i =1, 4 do
            local thingid=JY.Person[pid]["Я����Ʒ" ..i];
            if thingid>=0 then
                local add=Get_Add(thingid);
                if JY.Thing[thingid]["����"]==3 and add>0 then
                    local v=shouldadd-add;
                    if v<0 then               --���Լ�������, �����������Һ���ҩƷ
                        extra=1;
                        break;
                    else
                        if v<minvalue then        --Ѱ�Ҽ���������������
                            minvalue=v;
                            selectid=thingid;
                        end
                    end
                end
            end
        end
        if extra==1 then
            minvalue=math.huge;
            for i =1, 4 do
                local thingid=JY.Person[pid]["Я����Ʒ" ..i];
                if thingid>=0 then
                    local add=Get_Add(thingid);
                    if JY.Thing[thingid]["����"]==3 and add>0 then
                        local v=add-shouldadd;
                        if v>=0 then               --���Լ�������
                            if v<minvalue then
                                minvalue=v;
                                selectid=thingid;
                            end
                        end
                    end
                end
            end
        end

        if UseThingEffect(selectid,pid)==1 then       --ʹ����Ч��
            instruct_41(pid,selectid,-1);            --��Ʒ��������
        end
    end

    lib.Delay(500);
end


--�Զ�ҽ��
function War_AutoDoctor()            --�Զ�ҽ��
    local x1=WAR.Person[WAR.CurID]["����X"];
    local y1=WAR.Person[WAR.CurID]["����Y"];

    War_ExecuteMenu_Sub(x1,y1,3,-1);
end

function newAI(kfid)
	local pid=WAR.Person[WAR.CurID]["������"]
	local kungfuid=JY.Person[pid]["�书"][kfid][1]
    local kungfulv=JY.Person[pid]["�书"][kfid][2];
	if kungfulv==999 then 
		kungfulv=11
	else
		kungfulv=math.modf(kungfulv/100)+1
	end
	--local kungfulv=math.modf(JY.Person[pid]["�书�ȼ�"..kfid]/100)+1
	--local m1,m2,a1,a2,a3,a4,a5= refw(kungfuid,kungfulv)
	--local mfw={m1,m2}
	--local atkfw={a1,a2,a3,a4,a5}
	local mfw=JY.Wugong[kungfuid]["������Χ"][math.modf((kungfulv+2)/3)]
	local atkfw=JY.Wugong[kungfuid]["�˺���Χ"][math.modf((kungfulv+2)/3)]
	if kungfulv==11 then kungfulv=10 end
	local kungfuatk=JY.Wugong[kungfuid]["����"]*kungfulv--GetAtk(pid,kungfuid,kungfulv)										--�书������
	--local fanwei=JY.Wugong[kungfuid]["��Χ"][math.modf(kungfulv/3)+1]		--ʵ���书��Χ
	local atkarray={}
	local num=0
	
 	CleanWarMap(4,-1);    --��level 4��ͼ��ʾ��λ�ÿ��Թ�������Ŀ
									-- -1��ʾ�˵㻹û����
	local movearray=War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0)		--�ƶ���
	WarDrawMap(1)
	ShowScreen()
	local starttime=lib.GetTime();
	--lib.Delay(400)
	for i=0,WAR.Person[WAR.CurID]["�ƶ�����"] do
		local step_num=movearray[i].num ;
		if step_num==nil or step_num==0 then
			break;
		end
		
		for j=1,step_num do
			local xx=movearray[i].x[j]
			local yy=movearray[i].y[j]
			num=num+1
			atkarray[num]={}
			atkarray[num].x,atkarray[num].y=xx,yy
			atkarray[num].p,atkarray[num].ax,atkarray[num].ay=GetAtkNum(xx,yy,mfw,atkfw,kungfuatk)
		end
		
	end
	
	--����
	for i=1,num-1 do
		for j=i+1,num do
			if atkarray[i].p<atkarray[j].p then
				atkarray[i],atkarray[j]=atkarray[j],atkarray[i]
			end
		end
	end
	--[[
	for i=1,num do
			lib.Debug(JY.Person[pid]["����"]..'|'..JY.Wugong[kungfuid]["����"]..'|'..atkarray[i].x..','..atkarray[i].y..'|'..atkarray[i].ax..','..atkarray[i].ay..'|'..atkarray[i].p)
	end
	]]--
	if atkarray[1].p>0 then
		for i=1,num do
			if atkarray[i].p==0 or atkarray[i].p<atkarray[1].p/2 then
				num=i-1
				break;
			end
		end
		for i=1,num do
			atkarray[i].p=atkarray[i].p+GetMovePoint(atkarray[i].x,atkarray[i].y)--string.format("%s,mxy:%d,%d|axy:%d,%d|point:%d")
		end
		for i=1,num-1 do
			for j=i+1,num do
				if atkarray[i].p<atkarray[j].p then
					atkarray[i],atkarray[j]=atkarray[j],atkarray[i]
				elseif atkarray[i].p==atkarray[j].p then
					if math.random(2)==1 then
						atkarray[i],atkarray[j]=atkarray[j],atkarray[i]
					end
				end
			end
		end
		for i=2,num do
			if atkarray[i].p<atkarray[1].p-15 then
				num=i-1
				break;
			end
		end
		if num>6 then
			for i=num,6 do
				if atkarray[i].p<atkarray[1].p-50 then
					num=i-1
					break
				end
			end
		end
		local endtime=starttime+300-lib.GetTime()
		if endtime>0 then
			lib.Delay(endtime)
		end
		local select
		--if num>3 then num=3 end
		select=1--math.random(num) 
		War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0)
		War_MovePerson(atkarray[select].x,atkarray[select].y)
		War_Fight_Sub(WAR.CurID,kfid,atkarray[select].ax,atkarray[select].ay)
	else
		local endtime=starttime+300-lib.GetTime()
		if endtime>0 then
			lib.Delay(endtime)
		end
		local jl,nx,ny=War_realjl()
		if jl==-1 then
			AutoMove()
		else
			local vv
			vv=GetWarMap(nx+1,ny,2)
			if vv>-1 and WAR.Person[vv]["�ҷ�"]~=WAR.Person[WAR.CurID]["�ҷ�"] then
		
			else
				vv=GetWarMap(nx-1,ny,2)
				if vv>-1 and WAR.Person[vv]["�ҷ�"]~=WAR.Person[WAR.CurID]["�ҷ�"] then
			
				else
					vv=GetWarMap(nx,ny+1,2)
					if vv>-1 and WAR.Person[vv]["�ҷ�"]~=WAR.Person[WAR.CurID]["�ҷ�"] then
				
					else
						vv=GetWarMap(nx,ny-1,2)
					end
				end
			end
			local array={}
			local an=0
			local movearray=War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0)
			--MY_CalMoveStep(nx,ny,jl,0)
			War_CalMoveStep(vv,jl,0)
			for i=1,WAR.Person[WAR.CurID]["�ƶ�����"] do
				local step_num=movearray[i].num ;
				if step_num==nil or step_num==0 then
					break;
				end		
				for j=1,step_num do
					local xx=movearray[i].x[j]
					local yy=movearray[i].y[j]
					local Dest=GetWarMap(xx,yy,3)
					if Dest<255 then
						an=an+1
						array[an]={}
						array[an].x=xx
						array[an].y=yy
						array[an].p=jl-Dest
						--lib.Debug(an..','..array[an].p)
					end
				end
			end
			for i=1,an-1 do
				for j=i+1,an do
					if array[i].p<array[j].p then
						array[i],array[j]=array[j],array[i]
					end
				end
			end
			for i=2,an do
				if array[i].p<array[1].p/2 then
					an=i-1
					break
				end
			end
			for i=1,an do
				array[i].p=array[i].p+GetMovePoint(array[i].x,array[i].y)
			end
			for i=1,an-1 do
				for j=i+1,an do
					if array[i].p<array[j].p then
						array[i],array[j]=array[j],array[i]
					end
				end
			end
			--if jl==-1 then
			--	AutoMove()
			--else
			if an>0 then
				War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0)
				War_MovePerson(array[1].x,array[1].y)
			end
			--end
			--AutoMove()
		end
		War_RestMenu(); 
	end
	return
end

function GetAtkNum(x,y,movfw,atkfw,atk)
	local point={}		--��¼���Թ����ĵ�
	local num=0			--��¼��ĸ���
	local kind,len=movfw[1],movfw[2]
	--kind,len1,len2=fenjie(JY.Wugong[kfnum]["��Χ"..math.modf((lv+2)/3)])
	

	--������Χ���� 0����1����2ʮ��3����
	
	if kind==0 then
		local array=MY_CalMoveStep(x,y,len,1);
		for i=0,len do
			local step_num=array[i].num ;
			if step_num==nil or step_num==0 then
				break;
			end		
			for j=1,step_num do
				num=num+1
				point[num]={array[i].x[j],array[i].y[j]}
			end
		end
	elseif kind==1 then
		local array=MY_CalMoveStep(x,y,len*2,1);
			for r=1,len*2 do
				for i=0,r do
					local j=r-i
					if i>len or j>len then
						SetWarMap(x+i,y+j,3,255)
						SetWarMap(x+i,y-j,3,255)
						SetWarMap(x-i,y+j,3,255)
						SetWarMap(x-i,y-j,3,255)
					end
				end
			end
		for i=0,len do
			local step_num=array[i].num ;
			if step_num==nil or step_num==0 then
				break;
			end		
			for j=1,step_num do
				if GetWarMap(array[i].x[j],array[i].y[j],3)<128 then
					num=num+1
					point[num]={array[i].x[j],array[i].y[j]}
				end
			end
		end
	elseif kind==2 then
		--����
		len=len or 1
		for i=1,len do
			if x+i<CC.WarWidth-1 and GetWarMap(x+i,y,1)>0 and CC.WarWater[GetWarMap(x+i,y,0)]==nil then break end
			num=num+1
			point[num]={x+i,y}
		end
		for i=1,len do
			if x-i>0 and GetWarMap(x-i,y,1)>0 and CC.WarWater[GetWarMap(x-i,y,0)]==nil then break end
			num=num+1
			point[num]={x-i,y}
		end
		for i=1,len do
			if y+i<CC.WarHeight-1 and GetWarMap(x,y+i,1)>0 and CC.WarWater[GetWarMap(x,y+i,0)]==nil then break end
			num=num+1
			point[num]={x,y+i}
		end
		for i=1,len do
			if y-i>0 and GetWarMap(x,y-i,1)>0 and CC.WarWater[GetWarMap(x,y-i,0)]==nil then break end
			num=num+1
			point[num]={x,y-i}
		end
	elseif kind==3 then
		--����(����)
		if x+1<CC.WarWidth-1 and GetWarMap(x+1,y,1)==0 and CC.WarWater[GetWarMap(x+1,y,0)]==nil then
			num=num+1
			point[num]={x+1,y}
		end
		if x-1>0 and GetWarMap(x-1,y,1)==0 and CC.WarWater[GetWarMap(x-1,y,0)]==nil then
			num=num+1
			point[num]={x-1,y}
		end
		if y+1<CC.WarHeight-1 and GetWarMap(x,y+1,1)==0 and CC.WarWater[GetWarMap(x,y+1,0)]==nil then
			num=num+1
			point[num]={x,y+1}
		end
		if y-1>0 and GetWarMap(x,y-1,1)==0 and CC.WarWater[GetWarMap(x,y-1,0)]==nil then
			num=num+1
			point[num]={x,y-1}
		end
		if x+1<CC.WarWidth-1 and y+1<CC.WarHeight-1 and GetWarMap(x+1,y+1,1)==0 and CC.WarWater[GetWarMap(x+1,y+1,0)]==nil then
			num=num+1
			point[num]={x+1,y+1}
		end
		if  x-1>0 and y+1<CC.WarHeight-1 and GetWarMap(x-1,y+1,1)==0 and CC.WarWater[GetWarMap(x-1,y+1,0)]==nil then
			num=num+1
			point[num]={x-1,y+1}
		end
		if x+1<CC.WarWidth-1 and y-1>0 and GetWarMap(x+1,y-1,1)==0 and CC.WarWater[GetWarMap(x+1,y-1,0)]==nil then
			num=num+1
			point[num]={x+1,y-1}
		end
		if  x-1>0 and  y-1>0 and GetWarMap(x-1,y-1,1)==0 and CC.WarWater[GetWarMap(x-1,y-1,0)]==nil then
			num=num+1
			point[num]={x-1,y-1}
		end
	end
	--�ӵ�һ���㿪ʼ���ֱ��ȡ�õ㹥�����˵���Ŀ����������������꣬������Ŀ
	local maxx,maxy,maxnum,atknum=0,0,0,0
	for i=1,num do
		atknum=GetWarMap(point[i][1],point[i][2],4)				--ȡ���Ĳ����ݣ���Ϊ-1,����ú�������
		if atknum==-1 or atkfw[1]>9 or (atkfw[1]==3 and atkfw[3]~=nil and atkfw[3]~=atkfw[2])then		--������Ƕ����࣬������ظ�����
			atknum=WarDrawAtt(point[i][1],point[i][2],atkfw,2,x,y,atk)
			SetWarMap(point[i][1],point[i][2],4,atknum)
		end
		if atknum>maxnum then
			maxnum,maxx,maxy=atknum,point[i][1],point[i][2]
		end
	end
	--SetWarMap(x,y,4,maxnum);
	return maxnum,maxx,maxy;
	
end

function AutoMove()
    local x,y;
	local minDest=math.huge;
	local enemyid=War_AutoSelectEnemy()   --ѡ���������
	War_CalMoveStep(WAR.CurID,100,0);   --�����ƶ����� �������100��
	for i=0,CC.WarWidth-1 do
		for j=0,CC.WarHeight-1 do
			local dest=GetWarMap(i,j,3);
			if dest <128 then
				local dx=math.abs(i-WAR.Person[enemyid]["����X"])
                local dy=math.abs(j-WAR.Person[enemyid]["����Y"])
                if minDest>(dx+dy) then        --��ʱx,y�Ǿ�����˵����·������Ȼ���ܱ�Χס
					minDest=dx+dy;
                    x=i;
                    y=j;
                elseif minDest==(dx+dy) then
                    if Rnd(2)==0 then
                        x=i;
                        y=j;
                    end
                end
            end
        end
    end
	if minDest<math.huge then   --��·����
	    while true do    --��Ŀ��λ�÷����ҵ������ƶ���λ�ã���Ϊ�ƶ��Ĵ���
			local i=GetWarMap(x,y,3);
            if i<=WAR.Person[WAR.CurID]["�ƶ�����"] then
                break;
            end

            if GetWarMap(x-1,y,3)==i-1 then
                x=x-1;
            elseif GetWarMap(x+1,y,3)==i-1 then
                x=x+1;
            elseif GetWarMap(x,y-1,3)==i-1 then
                y=y-1;
            elseif GetWarMap(x,y+1,3)==i-1 then
                y=y+1;
            end
        end
        War_MovePerson(x,y);    --�ƶ�����Ӧ��λ��
    end
end

function AutoMove11()
	local movearray=War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0)
	local p,tx,ty=-999,0,0
	for i=1,WAR.Person[WAR.CurID]["�ƶ�����"] do
		local step_num=movearray[i].num ;
		if step_num==nil or step_num==0 then
			break;
		end		
		for j=1,step_num do
			local xx=movearray[i].x[j]
			local yy=movearray[i].y[j]
			local len=-2*War_realjl()+GetMovePoint(xx,yy)
			if len>p then
				p=len
				tx=xx
				ty=yy
			end
		end
	end
	War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0)
	War_MovePerson(tx,ty);    --�ƶ�����Ӧ��λ��
end

function GetMovePoint(x,y,flag)
	local point=0
	local wofang=WAR.Person[WAR.CurID]["�ҷ�"]
	local movearray=MY_CalMoveStep(x,y,9,1)
	for i=1,9 do
		local step_num=movearray[i].num;
		if step_num==nil or step_num==0 then
			break;
		end		
		for j=1,step_num do
			local xx=movearray[i].x[j]
			local yy=movearray[i].y[j]
			local v=GetWarMap(xx,yy,2)
			if v==-1 or v==WAR.CurID then
				--point=point+10
			elseif WAR.Person[v]["�ҷ�"]==wofang then
				point=point+i*2-17
			elseif WAR.Person[v]["�ҷ�"]~=wofang then
				--local qg=math.modf(WAR.PersonNum/2)-WAR.CurID
				if flag~=nil then
					point=point+i*-20
				else
					if not inteam(WAR.Person[WAR.CurID]["������"]) then--WAR.Person[WAR.CudID]["�ҷ�"] then
						point=point+i-10
					else 
						point=point+10-i
					end
					--point=point+8
				end
			end
		end		
	end
	return point
end
 function MY_CalMoveStep(x,y,stepmax,flag)
	CleanWarMap(3,255);           --�������������������ƶ����ȶ���Ϊ255��
	local steparray={};     --�����鱣���n�������ꡣ
	for i=0,stepmax do
	    steparray[i]={};
		steparray[i].num=0;
		steparray[i].canmove={};
        steparray[i].x={};
        steparray[i].y={};
	end

	SetWarMap(x,y,3,0);
    steparray[0].num=1;
	steparray[0].canmove[1]=true;					--�����ƶ��Ĳ���
	steparray[0].x[1]=x;
	steparray[0].y[1]=y;
	for i=0,stepmax-1 do
		War_FindNextStep(steparray,i,flag);
		if steparray[i+1].num==0 then
			break;
		end
	end
	return steparray;
end
--[[
function MY_realjl(ida,idb)
	if ida==nil then
		ida=WAR.CurID
	end
	local num
	local movearray=War_CalMoveStep(ida,255,0)
	for i=1,255 do
		num=i
		local step_num=movearray[i].num ;
		if step_num==nil or step_num==0 then
			break;
		end		
		for j=1,step_num do
			local xx=movearray[i].x[j]
			local yy=movearray[i].y[j]
			local v=GetWarMap(xx,yy,2)
			if idb==nil then
				if v~=-1 then
					if WAR.Person[v]["�ҷ�"]~=WAR.Person[ida]["�ҷ�"] then
						return v,num--,xx,yy
					end
				end
			else
				if v==idb then
					return v,num--,xx,yy
				end
			end
		end
	end
end
]]--