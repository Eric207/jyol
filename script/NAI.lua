--testing....AI
function War_Auto()
	--[[
	callmovestep
	���ƶ�������
	�� ����(����λ��) ��Ϣ ��ҩ�ȵ�����
	Ȼ��ѡ��ߵ�
	�ƶ����ָߵ�
	
	callmovestep�󣬼�¼��ȫ����
	�Ե����֣��������֣�Զ���ҷ�  �Լ�  �͵��˵ľ���  
	Ȼ�� �Գ�ҩ����...��Ϣ����...
	�Ը����书���֣�ѡ���书��������ߵ�
	Ȼ��ѡ��ߵ�
	]]--
	local pid=WAR.Person[WAR.CurID]["������"];
	WAR.ShowHead=1;
	WarDrawMap(0);
	ShowScreen();
	lib.Delay(CC.WarAutoDelay);
    if CC.AutoWarShowHead==0 then
	    WAR.ShowHead=0;
	end
	if WAR.Person[WAR.CurID]["��Ѩ"]>0 then
		War_RestMenu();
		return 9;
	end
	local movearray=War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0);
	WarDrawMap(1);
	ShowScreen();
	local starttime=lib.GetTime();
	local selectKF=War_AutoSelectWugong(pid);
	if selectKF<1 then
		starttime=lib.GetTime()-starttime;
		if starttime<200 then
			lib.Delay(200-starttime);
		end
		AutoMove();
		War_RestMenu();
		return 9;
	end
	local us={[0]=0,};
	local notus={[0]=0,};
	for i=0,WAR.PersonNum-1 do
		if WAR.Person[i]["����"]==false and i~=WAR.CurID then
			if WAR.Person[i]["�ҷ�"]==WAR.Person[WAR.CurID]["�ҷ�"] then
				us[0]=us[0]+1;
				us[us[0]]=i;
			else
				notus[0]=notus[0]+1;
				notus[notus[0]]=i;
			end
		end
	end
	for i=0,WAR.Person[WAR.CurID]["�ƶ�����"] do
		movearray[i].p={};
		for j=1,movearray[i].num do
			--�����ƶ�λ�õ�����
			local x=movearray[i].x[j];
			local y=movearray[i].y[j];
			local p=0;
			for k=1,us[0] do
				local wid=us[k];
				local dx=math.abs(WAR.Person[wid]["����X"]-x);
				local dy=math.abs(WAR.Person[wid]["����Y"]-y);
				if dx<5 and dy<5 then
					p=p+math.min(dx,dy);
				else
					p=p+5;
				end
				if dx+dy<7 then
					p=p+dx+dy;
				else
					p=p+7;
				end
				if math.min(dx,dy)<2 then
					p=p+math.min(math.max(dx,dy),10);
				else
					p=p+10;
				end
				if dx==dy then
					p=p+math.min(dx,7);
				else
					p=p+7;
				end
			end
			for k=1,notus[0] do
				local wid=notus[k];
				local eid=WAR.Person[wid]["������"];
				local dx=math.abs(WAR.Person[wid]["����X"]-x);
				local dy=math.abs(WAR.Person[wid]["����Y"]-y);
				if dx+dy>JY.Person[eid]["��"]/15+JY.Person[eid]["�ȼ�"]/15 then
					p=p+2;
				end
			end
			movearray[i].p[j]=p;
		end
	end
	local atk_kf,mov_x,mov_y,atk_x,atk_y,atk_p;
	atk_kf={};
	mov_x={};
	mov_y={};
	atk_x={};
	atk_y={};
	atk_p={};
	for ii=selectKF,selectKF do
		CleanWarMap(4,-1);
		local kfid=JY.Person[pid]["�⹦"..ii];
		local kflv=GetLv(pid,ii)--1+div100(JY.Person[pid]["�⹦����"..ii]);
			
		if kfid>0 and kflv>0 and JY.Person[pid]["����"]>=JY.Wugong[kfid]["������������"] then
			local movfw,atkfw;
			for lv=kflv,1,-1 do
				if JY.Kungfu[kfid]["������Χ"][lv]~=nil then
					movfw=JY.Kungfu[kfid]["������Χ"][lv];
					break;
				end
			end
			for lv=kflv,1,-1 do
				if JY.Kungfu[kfid]["�˺���Χ"][lv]~=nil then
					atkfw=JY.Kungfu[kfid]["�˺���Χ"][lv];
					break;
				end
			end
			--�书���书�ȼ���������ˣ�����������书����������ʱ��
			local hurt=GetAtk(pid,kfid,kflv);
			--movfw=JY.Kungfu[kfid]["������Χ"][math.modf((kflv+2)/3)];
			--atkfw=JY.Kungfu[kfid]["�˺���Χ"][math.modf((kflv+2)/3)];
			for i=0,WAR.Person[WAR.CurID]["�ƶ�����"] do
				for j=1,movearray[i].num do
					--�����书������
					local x=movearray[i].x[j];
					local y=movearray[i].y[j];
					local p,ax,ay=GetAtkNum(x,y,movfw,atkfw,hurt);
					if p>0 then
						--�������λ������,����Ӱ��Ҳ������
						p=p+movearray[i].p[j];
						local idx=ii;
						for index,k in pairs{1,2,3,4,5,6,7,8,9,10} do
							if atk_p[k]==nil then
								atk_kf[k],mov_x[k],mov_y[k],atk_x[k],atk_y[k],atk_p[k]=idx,x,y,ax,ay,p;
								break
							elseif p>=atk_p[k] then
								--lib.Debug(k..'--'..p)
								atk_kf[k],mov_x[k],mov_y[k],atk_x[k],atk_y[k],atk_p[k],idx,x,y,ax,ay,p=idx,x,y,ax,ay,p,atk_kf[k],mov_x[k],mov_y[k],atk_x[k],atk_y[k],atk_p[k];
								--break;
							end
						end
					end
				end
			end
		end
	end
	
	local drug_p=0;	--��ҩ����
	
	local rest_p=0;	--��Ϣ����
	
	local wait_p=0;	--�ȴ�����
	
	starttime=lib.GetTime()-starttime;
	--lib.Debug('time:'..starttime)
	if starttime<200 then
		lib.Delay(200-starttime);
	end
	local choose=math.random(5);
	if atk_p[choose]==nil then
		choose=0;
		for i=1,5 do
			if atk_p[i]~=nil then
				choose=i;
				break;
			end
		end
	end
	if choose~=0 then
		War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0);
		War_MovePerson(mov_x[choose],mov_y[choose]);
		War_Fight_Sub(WAR.CurID,atk_kf[choose],atk_x[choose],atk_y[choose]);
		return 2;
	else
		AutoMove();
		War_RestMenu();
		return 9;
	end
end

--��д�ƶ���������Ҫ�Ǽ���zoc�����������е���ʱ���ƶ��������1
function War_CalMoveStep(id,stepmax,flag)
	
  	CleanWarMap(3,255);           --�������������������ƶ����ȶ���Ϊ255��

    local x=WAR.Person[id]["����X"];
    local y=WAR.Person[id]["����Y"];

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
		War_FindNextStep(steparray,i,flag,id);
		if steparray[i+1].num==0 then
			break;
		end
	end
	return steparray;
end
--������ĺ�������
function War_FindNextStep(steparray,step,flag,id)      --������һ�����ƶ�������
	local num=0;
	local step1=step+1;
	for i=1,steparray[step].num do
		if steparray[step].canmove[i] then
			local x=steparray[step].x[i];
			local y=steparray[step].y[i];
			for direct=1,4 do
				local nx=x+CC.DirectX[direct];
				local ny=y+CC.DirectY[direct];
				if between(nx,1,62) and between(ny,1,62) then
					local v=GetWarMap(nx,ny,3);
					if v==255 and War_CanMoveXY(nx,ny,flag)==true then
						num=num+1;
						steparray[step1].x[num]=nx;
						steparray[step1].y[num]=ny;
						steparray[step1].canmove[num]=true;
						if flag==0 then
							for d=1,4 do
								local zx,zy=nx+CC.DirectX[d],ny+CC.DirectY[d];
								if between(zx,1,62) and between(zy,1,62) then
									local vv=GetWarMap(zx,zy,2);
									if vv>=0 then
										if WAR.Person[id]["�ҷ�"]~=WAR.Person[vv]["�ҷ�"] then
											steparray[step1].canmove[num]=false;
											break;
										end
									end
								end
							end
						end
						SetWarMap(nx,ny,3,step1);
					end
				end
			end
		end
	end
	steparray[step1].num=num;
end

function War_BeforeAction()
	local pid=WAR.Person[WAR.CurID]["������"];
	local tmp1,tmp2;
	for i,v in pairs{"��Ѩ","����","���","��ħ"} do
		if WAR.Person[WAR.CurID][v]>0 then
			local power=5+Rnd(5);
			WAR.Person[WAR.CurID][v]=limitX(WAR.Person[WAR.CurID][v]-power,0,100);
			if WAR.Person[WAR.CurID][v]==0 then
				AddShowString(WAR.CurID,v.."�����",M_DarkOrange);
			end
		end
	end
	if WAR.Person[WAR.CurID]["��Ѩ"]>0 then
		AddShowString(WAR.CurID,"��Ѩ�У��޷��ж�",M_Olive);
	elseif WAR.Person[WAR.CurID]["���"]>0 then
		AddShowString(WAR.CurID,"����У������ж�",M_Olive);
	end
	ShowWarString();
end

function War_AfterAction(r)
	local pid=WAR.Person[WAR.CurID]["������"];
	local tmp1,tmp2;
	tmp1,tmp2=smagic(pid,56,1);
	if myRnd100()<tmp1 then
		local yc=false;
		for i,v in pairs{"�ж�","����","��Ѫ"} do
			if JY.Person[pid][v]>0 then
				JY.Person[pid][v]=0;
				yc=true;
			end
		end
		for i,v in pairs{"����","��Ѩ","����","���","��ħ"} do
			if WAR.Person[WAR.CurID][v]>0 then
				WAR.Person[WAR.CurID][v]=0;
				yc=true;
			end
		end
		if yc then
			AddShowString(WAR.CurID,"�쳣״̬ȫ�����",M_DarkOrange);
		end
	end
	for i,v in pairs{"�ж�","����","��Ѫ"} do
		if JY.Person[pid][v]>0 then
			local gl=30-math.modf(JY.Person[pid][v]/5);
			if r==9 then
				gl=gl+10;
			end
			local vv=myRnd100();
			local power=Rnd(6);
			if math.random(5)==1 then
				power=power+4;
			end
			if vv<gl then
				AddPersonAttrib(pid,v,-power);
				AddShowString(WAR.CurID,v.."������",M_DarkOrange);
			elseif vv<50 then
				AddPersonAttrib(pid,v,power);
				AddShowString(WAR.CurID,v.."������",M_Olive);
			end
		end
	end
	for i,v in pairs{"����"} do
		if WAR.Person[WAR.CurID][v]>0 then
			local gl=30-math.modf(WAR.Person[pid][v]/5);
			if r==9 then
				gl=gl+10;
			end
			local vv=myRnd100();
			local power=Rnd(6);
			if vv<gl then
				power=power+4;
				WAR.Person[WAR.CurID][v]=limitX(WAR.Person[WAR.CurID][v]-power,0,100);
				AddShowString(WAR.CurID,v.."������",M_DarkOrange);
			elseif vv<50 then
				WAR.Person[WAR.CurID][v]=limitX(WAR.Person[WAR.CurID][v]+power,0,100);
				AddShowString(WAR.CurID,v.."������",M_Olive);
			end
		end
	end
	ResetPersonAttrib(pid);
	tmp1,tmp2=smagic(pid,45,1);
	if tmp1>0 then
		local v=AddPersonAttrib(pid,"����",JY.Person[pid]["�������ֵ"]*tmp1/100);
		if v>0 then
			AddShowString(WAR.CurID,string.format("�����ָ� +%d",v),M_Pink);
		end
	end
	tmp1,tmp2=smagic(pid,46,1);
	if tmp1>0 then
		local v=AddPersonAttrib(pid,"����",JY.Person[pid]["�������ֵ"]*tmp1/100);
		if v>0 then
			AddShowString(WAR.CurID,string.format("�����ָ� +%d",v),M_RoyalBlue);
		end
	end
	tmp1,tmp2=smagic(pid,47,1);
	if tmp1>0 then
		local v=AddPersonAttrib(pid,"����",tmp1);
		if v>0 then
			AddShowString(WAR.CurID,string.format("�����ָ� +%d",v),M_Yellow);
		end
	end
	if JY.Person[pid]["��Ѫ"]>0 then
		local v=AddPersonAttrib(pid,"����",-math.modf(JY.Person[pid]["��Ѫ"]+JY.Person[pid]["����"]*JY.Person[pid]["��Ѫ"]/200));
		AddShowString(WAR.CurID,string.format("��Ѫ���� %d",v),M_Red);
	end
	ShowWarString();
end
function War_AutoSelectWugong(pid)           --�Զ�ѡ����ʵ��书
    local probability={};       --ÿ���书ѡ��ĸ���
    local wugongnum=0;         --��0��ʼ�����书����Ŀ
	for i =1,5 do             --����ÿ�ֿ�ѡ���书���ܹ�����
		local kfid=JY.Person[pid]["�⹦"..i];
		local kflv=GetLv(pid,i);
        if kfid>0 and JY.Wugong[kfid]["�书����"]<=6 then
				if JY.Wugong[kfid]["������������"]*kflv<=JY.Person[pid]["����"] then
					wugongnum=wugongnum+1
					probability[wugongnum]={i,GetAtk(pid,kfid,kflv)*JY.Wugong[kfid]["�Ƚ�"]}
				end
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
	for i =1, wugongnum do       --������������Ч��
        if probability[i][2]>0 then
		    if probability[i][2]<maxoffense/2 then       --ȥ��������С���书
			    probability[i][2]=0
			end
        end
    end

	local s={};           --���ո��������ۼ�
	local maxnum=0;
    for i=1,wugongnum do
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
