---------------------------------------------------------------------------
---------------------------------ս��-----------------------------------
--��ں���ΪWarMain����ս��ָ�����

--����ս��ȫ�̱���
function WarSetGlobal()            --����ս��ȫ�̱���
    --WAR={};

    --WAR.Data={};              --ս����Ϣ��war.sta�ļ�

    WAR.SelectPerson={}            --����ѡ���ս��  0 δѡ��1 ѡ������ȡ����2 ѡ����ȡ����ѡ���չ�˲˵�����ʹ��

    WAR.Person={};                 --ս��������Ϣ
    for i=0,49 do
        WAR.Person[i]={};
        WAR.Person[i]["������"]=-1;
        WAR.Person[i]["�ҷ�"]=true;            --true �ҷ���false����
        WAR.Person[i]["����X"]=-1;
        WAR.Person[i]["����Y"]=-1;
        WAR.Person[i]["����"]=true;
        WAR.Person[i]["�˷���"]=-1;
        WAR.Person[i]["��ͼ"]=-1;
        WAR.Person[i]["��ͼ����"]=0;        --0 wmap����ͼ��1 fight***����ͼ
        WAR.Person[i]["�Ṧ"]=0;
        WAR.Person[i]["�ƶ�����"]=0;
        WAR.Person[i]["����"]={[0]=0,};
        WAR.Person[i]["atk����"]={[0]=0,};
        WAR.Person[i]["����"]=0;
        WAR.Person[i]["�Զ�ѡ�����"]=-1;     --�Զ�ս����ÿ����ѡ���ս������
		WAR.Person[i]["Time"]=0;
		WAR.Person[i]["TimeAdd"]=0;
		WAR.Person[i]["�м�"]=-1;
		WAR.Person[i]["����"]=0;
		WAR.Person[i]["��Ѩ"]=0;
		WAR.Person[i]["����"]=0;
		WAR.Person[i]["���"]=0;
		WAR.Person[i]["��ħ"]=0;
		WAR.Person[i]["RP"]=0;
		WAR.Person[i]["AI"]={};
							--[[{	
								0,		--0�ֶ�,1�Զ�,2�Զ��Ҳ���ȡ��,3ԭ�ش���,4�ƶ���Ŀ��
								0,		-->0����,<0��,����ֵԽ��,�ж�Խ����
								0,		--0,Զ�����,>0,�����͵��˱��ֵľ���
								0,		--
								0,		--
							};]]--
		--AI:0�ֶ�1�Զ�2����ȡ�����Զ�3ֻ��Ϣ4ֻ����5ֻ����
		--AI:0�ֶ� 1�Զ�������(�ҷ���) 2�Զ����������� 3���Զ���Զ����� 4����ԭ�أ����� 5�ƶ���Ŀ��
		WAR.Person[i]["��Ч����"]=-1;
		WAR.Person[i]["�����书"]=-1;
		WAR.Person[i]["��Ч����1"]=-1;
		WAR.Person[i]["��Ч����2"]=-1;
		WAR.Person[i]["��Ч����3"]=-1;
   end

    WAR.PersonNum=0;               --ս���������
	WAR.Delay=0;					--��ʱʱ��
	WAR.LifeNum=0;					--�������

    WAR.CurID=-1;                  --��ǰ����ս����id

	WAR.ShowHead=0;                --�Ƿ���ʾͷ��

    WAR.Effect=0;              --Ч��������ȷ������ͷ�����ֵ���ɫ
	                           --2 ɱ���� , 3 ɱ����, 4 ҽ�� �� 5 �ö� �� 6 �ⶾ

    WAR.EffectColor={};      ---��������ͷ�����ֵ���ɫ
    WAR.EffectColor[2]=RGB(236, 200, 40);
    WAR.EffectColor[3]=RGB(112, 12, 112);
    WAR.EffectColor[4]=RGB(236, 200, 40);
    WAR.EffectColor[5]=RGB(96, 176, 64)
    WAR.EffectColor[6]=RGB(104, 192, 232);

	WAR.EffectXY=nil            --�����书Ч������������
	WAR.EffectXYNum=0;          --�������
	WAR["����"]=0;
	WAR["����"]=0;
	WAR["��"]=0;
	WAR.tmp={}
	WAR.Evade={[0]=0,}
--[[
		JY.Sight=200
		JY.Light=200
		setBright()]]--
end

--����ս������
function WarLoad(warid)              --����ս������
    WarSetGlobal();         --��ʼ��ս������
	--[[
    local data=Byte.create(CC.WarDataSize);      --��ȡս������
    Byte.loadfile(data,CC.WarFile,warid*CC.WarDataSize,CC.WarDataSize);
    LoadData(WAR.Data,CC.WarData_S,data);
	]]--
end

--ս��������
--warid  ս�����
--isexp  ����Ƿ��о��� 0 û���飬1 �о���
--����  true ս��ʤ����false ʧ��
function WarMain(warid,isexp)           --ս��������
	local tlbak=JY.Person[0]["����"];
    --lib.Debug(string.format("war start. warid=%d",warid));
    WarLoad(warid);
    WarSelectTeam();          --ѡ���ҷ�
    WarSelectEnemy();         --ѡ�����
    CleanMemory()
    --lib.PicInit();
 	lib.ShowSlow(50,1) ;      --�����䰵

    WarLoadMap(WAR.Data["��ͼ"]);       --����ս����ͼ

    JY.Status=GAME_WMAP;

	if warid==998 then
		warid=999;
		local x0,y0=WAR.Person[0]["����X"],WAR.Person[0]["����Y"];--=JY.Base["��X1"],JY.Base["��Y1"];
		local d=JY.Base["�˷���"];
		WAR.CurID=0;
		--WAR.Person[0]["����X"]=x0;
		--WAR.Person[0]["����Y"]=y0;
		local movestep=War_CalMoveStepOld(WAR.CurID,6,0);           --���ÿ��λ�õĲ���
		local m1={num=0,x={},y={}};
		local m2={num=0,x={},y={}};
		for i=0,6 do
			local step_num=movestep[i].num ;
			if step_num==nil or step_num==0 then
				break;
			end
			--lib.Debug("i="..i..',num='..step_num)
			for j=1,step_num do
				local xx=movestep[i].x[j];
				local yy=movestep[i].y[j];
				if (d==0 and yy<y0) or (d==1 and xx>x0) or (d==2 and xx<x0) or (d==3 and yy>y0) then
					m2.num=m2.num+1;
					m2.x[m2.num]=xx;
					m2.y[m2.num]=yy;
				else
					m1.num=m1.num+1;
					m1.x[m1.num]=xx;
					m1.y[m1.num]=yy;
				end
			end
		end
		for i=1,m1.num-1 do
			for j=i+1,m1.num do
				if Rnd(2)==1 then
					m1.x[i],m1.x[j]=m1.x[j],m1.x[i];
					m1.y[i],m1.y[j]=m1.y[j],m1.y[i];
				end
			end
		end
		for i=1,m2.num-1 do
			for j=i+1,m2.num do
				if Rnd(2)==1 then
					m2.x[i],m2.x[j]=m2.x[j],m2.x[i];
					m2.y[i],m2.y[j]=m2.y[j],m2.y[i];
				end
			end
		end
		local num1,num2=1,1;
		for i=0,WAR.PersonNum-1 do
			if WAR.Person[i]["�ҷ�"] then
				if num1<=m1.num then
					WAR.Person[i]["����X"]=m1.x[num1];
					WAR.Person[i]["����Y"]=m1.y[num1];
					num1=num1+1;
				else
					WAR.Person[i]["����X"]=m2.x[num2];
					WAR.Person[i]["����Y"]=m2.y[num2];
					num2=num2+1;
				end
			else
				if num2<=m2.num then
					WAR.Person[i]["����X"]=m2.x[num2];
					WAR.Person[i]["����Y"]=m2.y[num2];
					num2=num2+1;
				else
					WAR.Person[i]["����X"]=m1.x[num1];
					WAR.Person[i]["����Y"]=m1.y[num1];
					num1=num1+1;
				end
			end
		end
	end
	WarSetDirect();				--���÷���
	--������ͼ�ļ�
--	lib.PicLoadFile(CC.SMAPPicFile[1],CC.SMAPPicFile[2],0);
--	lib.PicLoadFile(CC.HeadPicFile[1],CC.HeadPicFile[2],1);
--	lib.PicLoadFile(CC.MMAPPicFile[1],CC.MMAPPicFile[2],2);
--	lib.PicLoadFile(CC.EffectFile[1],CC.EffectFile[2],3);

    PlayMIDI(WAR.Data["����"]);

    local warStatus;          --ս��״̬

	WarPersonSort();    --ս���˰��Ṧ����

	--ս����ѭ�����ĳɰ뼴ʱ�ƣ���д
	--��������������˵ĳ�ʼ����ֵ
	local max_jiqi=0;
	for i=0,WAR.PersonNum-1 do
        local pid=WAR.Person[i]["������"];
		lib.PicLoadFile(string.format(CC.FightPicFile[1],JY.Person[pid]["ս������"]),
		                string.format(CC.FightPicFile[2],JY.Person[pid]["ս������"]),
						4+i);
		WAR.Person[i]["Time"]=700-(i*1000/(WAR.PersonNum+2))+smagic(pid,42,1);
		WAR.Person[i]["��ͼ"]=WarCalPersonPic(i);
		if WAR.Person[i]["Time"]>max_jiqi then
			max_jiqi=WAR.Person[i]["Time"];
		end
	end
	if max_jiqi>1000 then
		max_jiqi=max_jiqi-1000;
		for i=0,WAR.PersonNum-1 do
			local pid=WAR.Person[i]["������"];
			WAR.Person[i]["Time"]=WAR.Person[i]["Time"]-max_jiqi;
		end
	end
	WarSetPerson();     --����ս������λ��
	WAR.CurID=0
	WarDrawMap(0);
	lib.ShowSlow(50,0)
	warStatus=0;
	WAR.Delay=GetJiqi();
	while true do
		WarDrawMap(0);
		WAR.ShowHead=0;
		DrawTimeBar();
		--lib.Delay(wardelay)

		--������ȴ���1000�����ж�
		for p=0,WAR.PersonNum-1 do
			if WAR.Person[p]["����"]==false then
				if WAR.Person[p]["Time"]>1000 then 
					WAR.ShowHead=0;
					WarDrawMap(0);
					ShowScreen();
					local surid=lib.SaveSur(CC.ScreenW-80,0,CC.ScreenW,200);
					for i=1,30 do
						local nowtime=lib.GetTime();
						lib.LoadSur(surid,CC.ScreenW-80,0);
						drawname(CC.ScreenW-40,0,JY.Person[WAR.Person[p]["������"]]["����"],16+i);
						ShowScreen();
						if i==30 then
							lib.Delay(200+nowtime-lib.GetTime());
						elseif i>20 then
							lib.Delay(i-5+nowtime-lib.GetTime());
						else
							lib.Delay(15+nowtime-lib.GetTime());
						end
						local eventtype,keypress=getkey();
						if WAR.Person[p]["AI"][1]==1 then
							if eventtype==1 then
								if keypress==VK_SPACE or keypress==VK_RETURN or keypress==VK_ESCAPE then
									WAR.Person[p]["AI"]={0,0,0};
								end
							elseif eventtype==3 then
								if keypress==3 then
									WAR.Person[p]["AI"]={0,0,0};
								end
							end
						end
					end
					lib.FreeSur(surid);
					WAR.CurID=p;
					WAR.Person[p]["�м�"]=-1;
					War_BeforeAction();
					--WAR.Person[p]["�ƶ�����"]=math.modf(WAR.Person[p]["�Ṧ"]/20)--JY.Person[WAR.Person[p]["������"]]["���˳̶�"]/40);
					local r;
					if WAR.Person[p]["������"]==0 then--WAR.Person[p]["�ҷ�"]==true and inteam(WAR.Person[p]["������"]) then
						if WAR.Person[p]["AI"][1]==0 then
							if WAR.Person[p]["���"]>0 then
								r=War_Auto();
							else
								r=War_Manual();                  --�ֶ�ս��
							end
						else
							r=War_Auto();                  --�Զ�ս��
						end
					else								--�����ε����ж�
						r=War_Auto();                  --�Զ�ս��
					end
					War_AfterAction(r);
					--WAR.Person[p]["TimeAdd"]=WAR.Person[p]["Time"]-1000;		
					WAR.Person[p]["Time"]=WAR.Person[p]["Time"]-1000;
					DrawTimeBar2()
		warStatus=WAR_CALLEVENT(warid);
		if warStatus~=0 then break end					--ս���¼����
		
					warStatus=War_isEnd();        --ս���Ƿ������   0������1Ӯ��2��
	
					if warStatus>0 then
						break;
					end
				end	
			end
		end	
		if warStatus>0 then
			break;
		end
		WAR.Delay=GetJiqi();
	end
    local r;

	WAR.ShowHead=0;
	if warStatus==1 then
        r=true;
    elseif warStatus==2 then
        r=false;
    end
	
	local meid=WE_getwarid(0);
	if meid==-1 then
		DrawStrBoxWaitKey("ս������",C_WHITE,CC.Fontbig);
	else
		if not WAR.Person[meid]["�ҷ�"] then
			warStatus=3-warStatus;
		end
		if warStatus==1 then
			DrawStrBoxWaitKey("ս��ʤ��",C_WHITE,CC.Fontbig);
		else
			DrawStrBoxWaitKey("ս��ʧ��",C_WHITE,CC.Fontbig);
		end
	end

    War_EndPersonData(isexp,warStatus);    --ս���������������

    CleanMemory();
    lib.ShowSlow(50,1);
--[[
    if JY.Scene[JY.SubScene]["��������"]>=0 then
        PlayMIDI(JY.Scene[JY.SubScene]["��������"]);
    else
        PlayMIDI(0);
    end

    CleanMemory();
    lib.PicInit();
    lib.PicLoadFile(CC.SMAPPicFile[1],CC.SMAPPicFile[2],0);
    lib.PicLoadFile(CC.HeadPicFile[1],CC.HeadPicFile[2],1);
	if CC.LoadThingPic==1 then
        lib.PicLoadFile(CC.ThingPicFile[1],CC.ThingPicFile[2],2);
	end
]]--
    JY.Status=GAME_SMAP;
	Init_SMap(2);
	if JY.Person[0]["����"]>tlbak then
		JY.Person[0]["����"]=tlbak;
	end
    return r;
end

function DrawTimeBar()
	local x1,x2,y=CC.ScreenW*5/8,CC.ScreenW*15/16,CC.FontSmall*5;
	local xunhuan=true;
	local surid=lib.SaveSur(00,0,x2+5,y*2+2);
	local xscal=limitX(WAR.Delay/10,1,5);
	local delay=WAR.Delay/xscal;
	for i=0,WAR.PersonNum-1 do
		if WAR.Person[i]["����"]==false then
			WAR.Person[i]["TimeAdd"]=WAR.Person[i]["TimeAdd"]/xscal;
		end
	end
	while xunhuan do
		local stime=lib.GetTime();
		lib.LoadSur(surid,0,0)
		for i=0,WAR.PersonNum-1 do
			if WAR.Person[i]["����"]==false then
				WAR.Person[i]["Time"]=WAR.Person[i]["Time"]+WAR.Person[i]["TimeAdd"];
				if WAR.Person[i]["Time"]>1000 then
					xunhuan=false;
				end
			end
		end
		DrawTimeBar_sub(x1,x2,y,0);
		getkey();
		ShowScreen();
		local passed_t=lib.GetTime()-stime;
		if passed_t<delay then
			lib.Delay(delay-passed_t);
		end
	end
	for i=0,WAR.PersonNum-1 do
		if WAR.Person[i]["����"]==false then
			WAR.Person[i]["TimeAdd"]=0;
		end
	end
	lib.Delay(100);
	lib.FreeSur(surid);
end

function DrawTimeBar2()
	local x1,x2,y=CC.ScreenW*5/8,CC.ScreenW*15/16,CC.FontSmall*5;
	local draw;
	local surid=lib.SaveSur(0,0,x2+5,y*2+2);
	while true do
		local stime=lib.GetTime();
		draw=false;
		for i=0,WAR.PersonNum-1 do
			if WAR.Person[i]["����"]==false then
				if WAR.Person[i]["TimeAdd"]<0 then
					WAR.Person[i]["Time"]=WAR.Person[i]["Time"]-5;
					WAR.Person[i]["TimeAdd"]=WAR.Person[i]["TimeAdd"]+5;
					draw=true;
				end
			end
		end
		if draw then
			lib.LoadSur(surid,0,0)
			DrawTimeBar_sub(x1,x2,y,1);
			getkey();
			ShowScreen();
			lib.Delay(12+stime-lib.GetTime());
		else
			break;
		end
	end
	lib.Delay(100);
	lib.FreeSur(surid);
end

function DrawTimeBar_sub_old(x1,x2,y,flag)
	x1=x1 or CC.ScreenW*5/8;
	x2=x2 or CC.ScreenW*15/16;
	y=y or CC.FontSmall*5;
	local least=WAR.LifeNum*15;
	if flag==1 then
		least=0;
	end
	DrawBox_1(x1-3,y,x2+3,y+2,C_ORANGE)
	for i=0,WAR.PersonNum-1 do
		if not WAR.Person[i]["����"]then
			if WAR.Person[i]["Time"]>least then
				local cx=x1+math.modf((WAR.Person[i]["Time"]-least)*(x2-x1)/(1000-least));
				local color=M_White;
				if WAR.Person[i]["TimeAdd"]<5 then
					--color=M_Silver;
				end
				if WAR.Person[i]["�ҷ�"] then
					lib.FillColor(cx-1,CC.FontSmall*4,cx+1,CC.FontSmall*5-2,C_WHITE);
					--lib.LoadPicZoom(1,JY.Person[WAR.Person[i]["������"]]["ͷ�����"],cx-18,CC.FontSmall*3,25,1);
					drawname(cx,0,JY.Person[WAR.Person[i]["������"]]["����"],CC.FontSmall,color)
				else
					lib.FillColor(cx-1,CC.FontSmall*5+2,cx+1,CC.FontSmall*6,C_WHITE);
					--lib.LoadPicZoom(1,JY.Person[WAR.Person[i]["������"]]["ͷ�����"],cx-18,CC.FontSmall*4+20,25,1);
					drawname(cx,CC.FontSmall*6,JY.Person[WAR.Person[i]["������"]]["����"],CC.FontSmall,color)					
				end
			end
		end
	end
end
function DrawTimeBar_sub(x1,x2,y,flag)
	x1=x1 or CC.ScreenW*5/8;
	x2=x2 or CC.ScreenW*15/16;
	y=y or CC.FontSmall*5;
	local least=0;
	if flag==1 then
		DrawBox_1(x1*2-x2,y,x1,y+2,M_Silver);
		least=-1000;
	end
	DrawBox_1(x1-3,y,x2+2,y+2,C_ORANGE)
	for i=0,WAR.PersonNum-1 do
		if not WAR.Person[i]["����"]then
			if WAR.Person[i]["Time"]>=least then
				local cx=x1+math.modf(WAR.Person[i]["Time"]*(x2-x1)/1000);
				if flag==2 and WAR.CurID==i then
					cx=x2;
				end
				local color=M_White;
				if WAR.Person[i]["TimeAdd"]<5 then
					--color=M_Silver;
				end
				if WAR.Person[i]["�ҷ�"] then
					lib.FillColor(cx-1,CC.FontSmall*4,cx+1,CC.FontSmall*5-2,C_WHITE);
					--lib.LoadPicZoom(1,JY.Person[WAR.Person[i]["������"]]["ͷ�����"],cx-18,CC.FontSmall*3,25,1);
					drawname(cx,0,JY.Person[WAR.Person[i]["������"]]["����"],CC.FontSmall,color)
				else
					lib.FillColor(cx-1,CC.FontSmall*5+2,cx+1,CC.FontSmall*6,C_WHITE);
					--lib.LoadPicZoom(1,JY.Person[WAR.Person[i]["������"]]["ͷ�����"],cx-18,CC.FontSmall*4+20,25,1);
					drawname(cx,CC.FontSmall*6,JY.Person[WAR.Person[i]["������"]]["����"],CC.FontSmall,color)					
				end
			end
		end
	end
end
--������ʱʱ�䣬���������Ｏ���ٶ�
function GetJiqi(id)
	local num,total=0,0
	local id1,id2;
	if id==nil then
		id1=0;
		id2=WAR.PersonNum-1;
	else
		id1=id;
		id2=id;
	end
	for i=0,WAR.PersonNum-1 do
		if not WAR.Person[i]['����'] then
			local id=WAR.Person[i]['������']
			--lib.Debug(id)
			WAR.Person[i]["�ƶ�����"]=math.modf(JY.Person[id]["��"]/15)+smagic(id,41,1);
			local v=1+JY.Person[id]["����"]/750+JY.Person[id]["�������ֵ"]/1500+WAR.Person[i]["�Ṧ"]/100;
			if v<1 then
				v=1;
			end
			--lib.Debug(v)
			WAR.Person[i]["TimeAdd"]=math.modf(math.log(v)/math.log(1.15)+JY.Person[id]["����"]/35-2)+smagic(id,43,1);--+JY.Person[id]["��"]/20
			local tmp=smagic(id,53,1);
			if tmp~=0 then
				WAR.Person[i]["TimeAdd"]=math.modf(WAR.Person[i]["TimeAdd"]*(100+tmp)/100);
			end
			if WAR.Person[i]["TimeAdd"]<5 then WAR.Person[i]["TimeAdd"]=5 end
			--lib.Debug(WAR.Person[i]["TimeAdd"])
			num=num+1
			total=total+WAR.Person[i]["TimeAdd"]
		end
	end
	return math.modf(1.6*(total/num+num/2));
end

function War_EndPersonData(isexp,warStatus)            --ս���Ժ������������
--�з���Ա�����ָ�
    for i=0,WAR.PersonNum-1 do
        local pid=WAR.Person[i]["������"]
        if WAR.Person[i]["�ҷ�"] and inteam(pid) then
            if JY.Person[pid]["����"]<JY.Person[pid]["�������ֵ"]/5 then
                JY.Person[pid]["����"]=math.modf(JY.Person[pid]["�������ֵ"]/5);
            end
            if JY.Person[pid]["����"]<10 then
                JY.Person[pid]["����"]=10 ;
            end
		else
            JY.Person[pid]["����"]=JY.Person[pid]["�������ֵ"];
            JY.Person[pid]["����"]=JY.Person[pid]["�������ֵ"];
            JY.Person[pid]["����"]=CC.PersonAttribMax["����"];
            JY.Person[pid]["����"]=0;
            JY.Person[pid]["�ж�"]=0;
            JY.Person[pid]["��Ѫ"]=0;
        end
    end

    --�ҷ���Ա�����ָ�����Ӯ����

    if isexp==-1 then  --�䣬û�о��飬�˳�
        return ;
    end

    local liveNum=0;          --�����ҷ����ŵ�����
    for i=0,WAR.PersonNum-1 do
        if WAR.Person[i]["�ҷ�"]==true and JY.Person[WAR.Person[i]["������"]]["����"]>0  then
            liveNum=liveNum+1;
        end
    end

    --����ս������---�������飬ս�������е�
    if warStatus~=1 then     --Ӯ�˲���
		if isexp==0 then
			WAR.Data["����"]=0;
		else
			WAR.Data["����"]=WAR.Data["����"]/2;
		end
    end
	if liveNum==0 then
		liveNum=5;
	end

    --ÿ���˾������ӣ��Լ�����
    for i=0,WAR.PersonNum-1 do
        local pid=WAR.Person[i]["������"];
        --AddPersonAttrib(pid,"��Ʒ��������",math.modf(WAR.Person[i]["����"]*8/10));

        if WAR.Person[i]["�ҷ�"]==true then
			local add1,str1=AddPersonAttrib(pid,"��������",math.modf((WAR.Person[i]["����"]/2+WAR.Data["����"]/liveNum)*(100+smagic(pid,58,1))/100));
			local add2,str2=AddPersonAttrib(pid,"����",math.modf((WAR.Person[i]["����"]+WAR.Data["����"]/liveNum)*(100+smagic(pid,58,1))/100));
			if inteam(pid) or JY.Person[pid]["����"]==JY.Person[0]["����"] then
				DrawStrBoxWaitKey(string.format("%s���*������� %d*�������� %d",JY.Person[pid]["����"],add2,add1),C_WHITE,CC.Fontbig);
			end
			local r=War_AddPersonLevel(pid);     --��������

			--if r==true then
			--	DrawStrBoxWaitKey( string.format("%s ������",JY.Person[pid]["����"]),C_WHITE,CC.Fontbig);
			--end
        end

        --War_PersonTrainBook(pid);            --�����ؼ�
    --    War_PersonTrainDrug(pid);            --����ҩƷ
    end
end

--�����Ƿ�����
--pid ��id
--���� true ������false������
function War_AddPersonLevel(pid,show)      --�����Ƿ�����
	if show==nil then
		show=inteam(pid) or JY.Person[pid]["����"]==JY.Person[0]["����"];
	end
	local p=JY.Person[pid];
	--�����书����
	local T={"һ","��","��","��","��","��","��","��","��","ʮ"}
	if pid~=0 then
		for i=1,5 do
			if p["�⹦"..i]>0 and p["�⹦����"..i]<900 then
				local point=GetSkillPoint(p["�⹦"..i],p["�⹦����"..i],pid);
				if JY.Person[pid]["����"]>=point and math.random(100)>85 then
					JY.Person[pid]["����"]=JY.Person[pid]["����"]-point;
					p["�⹦����"..i]=100*(1+math.modf(p["�⹦����"..i]/100));
					for j=1,CC.MaxKungfuNum do
						if p["�����书"..j]==p["�⹦"..i] then
							p["�����书����"..j]=p["�⹦����"..i];
						end
					end
					if show then
						DrawStrBoxWaitKey(string.format("%s����%s����%s��",p["����"],JY.Wugong[p["�⹦"..i]]["����"],T[1+math.modf(p["�⹦����"..i]/100)]),C_WHITE,CC.Fontbig,1);
					end
				end
			end
		end
		for i,v in pairs({"�ڹ�","�Ṧ","�ؼ�"}) do
			if p[v]>0 and p[v.."����"]<900 then
				local point=GetSkillPoint(p[v],p[v.."����"],pid);
				if JY.Person[pid]["����"]>=point and math.random(100)>85 then
					JY.Person[pid]["����"]=JY.Person[pid]["����"]-point;
					p[v.."����"]=100*(1+math.modf(p[v.."����"]/100));
					for j=1,CC.MaxKungfuNum do
						if p["�����书"..j]==p[v] then
							p["�����书����"..j]=p[v.."����"];
						end
					end
					if show then
						DrawStrBoxWaitKey(string.format("%s����%s����%s��",p["����"],JY.Wugong[p[v]]["����"],T[1+math.modf(p[v.."����"]/100)]),C_WHITE,CC.Fontbig,1);
					end
				end
			end
		end
	end
	local data={
						["�ȼ�"]={p["�ȼ�"],},
						["����"]={p["�������ֵ"],},
						["����"]={p["�������ֵ"],},
						["����"]={p["����"],},
						["����"]={p["����"],},
						["��"]={p["��"],},
					};
	--[[				
	for i,v in pairs({"����","����","��"}) do
		local dd=p[v];
		for mi,mv in pairs({"�ڹ�","�Ṧ","�ؼ�"}) do
			local mkfid,mkfexp=p[mv],p[mv..'����'];
			if mkfid>0 then
				dd=dd+JY.Wugong[mkfid][v]*(1+div100(mkfexp));
			end
		end
		for ni=1,5 do
			local nid,nexp=p["�⹦"..ni],p["�⹦����"..ni];
			if nid>0 then
				dd=dd+JY.Wugong[nid][v]*(1+div100(nexp));
			end
		end
		dd=math.modf(dd*100/(130-p[v]));
		data[v][1]=dd;
	end
	]]--
    local tmplevel=JY.Person[pid]["�ȼ�"];
    if tmplevel>=CC.Level then     --���𵽶�
        return false;
    end
	local leveladd=0;
	while true do
		local EXP=NextLvExp(tmplevel+leveladd);
		if JY.Person[pid]["����"]>=EXP then
			JY.Person[pid]["����"]=JY.Person[pid]["����"]-EXP;
			leveladd=leveladd+1;
		else
			break;
		end
	end
	if leveladd==0 then
		return false;
	end
	for i=1,leveladd do
		JY.Person[pid]["�ȼ�"]=JY.Person[pid]["�ȼ�"]+1;
		AddPersonAttrib(pid,"����Max", math.modf(JY.Person[pid]["����"]/4+10+Rnd(10)));
		AddPersonAttrib(pid,"����Max",  math.modf(JY.Person[pid]["����"]/4+10+Rnd(10)));
		if myRnd100()<JY.Person[pid]["����"]+(33+(JY.Person[pid]["����"]+smagic(pid,64,1))*JY.Person[pid]["�ȼ�"]/100-JY.Person[pid]["����"])*math.abs((33+(JY.Person[pid]["����"]+smagic(pid,64,1))*JY.Person[pid]["�ȼ�"]/100-JY.Person[pid]["����"])) then
			AddPersonAttrib(pid,"����",1);
		end
		if myRnd100()<JY.Person[pid]["����"]+(33+(JY.Person[pid]["����"]+smagic(pid,65,1))*JY.Person[pid]["�ȼ�"]/100-JY.Person[pid]["����"])*math.abs((33+(JY.Person[pid]["����"]+smagic(pid,65,1))*JY.Person[pid]["�ȼ�"]/100-JY.Person[pid]["����"])) then
			AddPersonAttrib(pid,"����",1);
		end
		if myRnd100()<JY.Person[pid]["����"]+(33+(JY.Person[pid]["����"]+smagic(pid,66,1))*JY.Person[pid]["�ȼ�"]/100-JY.Person[pid]["��"])*math.abs((33+(JY.Person[pid]["����"]+smagic(pid,66,1))*JY.Person[pid]["�ȼ�"]/100-JY.Person[pid]["��"])) then
			AddPersonAttrib(pid,"��",1);
		end
	end
    JY.Person[pid]["����"]=0;
    JY.Person[pid]["�ж�"]=0;
	JY.Person[pid]["��Ѫ"]=0;
	if pid>0 then
		JY.Person[pid]["����"]=CC.PersonAttribMax["����"];
	end
	ResetPersonAttrib(pid);
    JY.Person[pid]["����"]=JY.Person[pid]["�������ֵ"];
	JY.Person[pid]["����"]=JY.Person[pid]["�������ֵ"];
    --AddPersonAttrib(pid,"����",  math.modf(myRnd100()/20));
    --AddPersonAttrib(pid,"����",  math.modf(myRnd100()/20));
    --AddPersonAttrib(pid,"��",  math.modf(myRnd100()/20));
	if show then
		data["�ȼ�"][2]=p["�ȼ�"];
		data["����"][2]=p["�������ֵ"];
		data["����"][2]=p["�������ֵ"];
		data["����"][2]=p["����"];
		data["����"][2]=p["����"];
		data["��"][2]=p["��"];
		data["�ȼ�"][1]=data["�ȼ�"][1]+4;
		data["�ȼ�"][2]=data["�ȼ�"][2]+4;
		
		--[[
		for i,v in pairs({"����","����","��"}) do
			local dd=p[v];
			for mi,mv in pairs({"�ڹ�","�Ṧ","�ؼ�"}) do
				local mkfid,mkfexp=p[mv],p[mv..'����'];
				if mkfid>0 then
					dd=dd+JY.Wugong[mkfid][v]*(1+div100(mkfexp));
				end
			end
			for ni=1,5 do
				local nid,nexp=p["�⹦"..ni],p["�⹦����"..ni];
				if nid>0 then
					dd=dd+JY.Wugong[nid][v]*(1+div100(nexp));
				end
			end
			dd=math.modf(dd*100/(130-p[v]));
			data[v][2]=dd;
		end
		]]--
		local str="";
		for i,v in pairs({"�ȼ�","����","����"}) do--,"����","����","��"}) do
			if str~="" then
				str=str.."*";
			end
			if data[v][2]>data[v][1] then
				--str=str..string.format("%s:%4d �J%4d",v,data[v][1],data[v][2]);
				str=str..string.format("%s:%4d ��%4d",v,data[v][1],data[v][2]);
			elseif data[v][2]==data[v][1] then
				--str=str..string.format("%s:%4d ��%4d",v,data[v][1],data[v][2]);
			else
				--str=str..string.format("%s:%4d �K%4d",v,data[v][1],data[v][2]);
			end
		end
		for i,v in pairs({"����","����","��"}) do
			--if str~="" then
			--	str=str.."*";
			--end
			if data[v][2]>data[v][1] then
				--str=str..string.format("%s:%4d �J%4d",v,data[v][1],data[v][2]);
				str=str.."*"..v.."����"--string.format("%s:%4d ��%4d",v,data[v][1],data[v][2]);
			elseif data[v][2]==data[v][1] then
				--str=str..string.format("%s:%4d ��%4d",v,data[v][1],data[v][2]);
			else
				--str=str..string.format("%s:%4d �K%4d",v,data[v][1],data[v][2]);
			end
		end
		JYMsgBox(p["����"].."������",str,{"ȷ��"},1,p["ͷ�����"]);
	end
    return true;

end
function NextLvExp(lv)
	return 50*math.modf(lv^3/100+lv^2/40+lv*2)
end

--ս���Ƿ����
--���أ�0 ����   1 Ӯ    2 ��
function War_isEnd()           --ս���Ƿ����

    for i=0,WAR.PersonNum-1 do
        if JY.Person[WAR.Person[i]["������"]]["����"]<=0 then
            WAR.Person[i]["����"]=true;
        end
    end
    WarSetPerson();     --����ս������λ��

    Cls();
    ShowScreen();

    local myNum=0;
    local EmenyNum=0;
    for i=0,WAR.PersonNum-1 do
        if WAR.Person[i]["����"]==false then
            if WAR.Person[i]["�ҷ�"]==true then
                myNum=1;
            else
                EmenyNum=1;
            end
        end
    end

    if EmenyNum==0 then
        return 1;
    end
    if myNum==0 then
        return 2;
    end
    return 0;
end

--ѡ���ҷ���ս��
function WarSelectTeam()            --ѡ���ҷ���ս��
    WAR.PersonNum=0;

    for i=1,6 do
	    local id=WAR.Data["�Զ�ѡ���ս��" .. i] or -1;
		if id>=0 then
            WAR.Person[WAR.PersonNum]["������"]=id;
            WAR.Person[WAR.PersonNum]["�ҷ�"]=true;
            WAR.Person[WAR.PersonNum]["����X"]=WAR.Data["�ҷ�X"  .. i];
            WAR.Person[WAR.PersonNum]["����Y"]=WAR.Data["�ҷ�Y"  .. i];
            WAR.Person[WAR.PersonNum]["����"]=false;
            WAR.Person[WAR.PersonNum]["�˷���"]=2;
			WAR.Person[WAR.PersonNum]["RP"]=JY.Person[id]["��Ե"];
			WAR.Person[WAR.PersonNum]["AI"]={0,0,0};
            WAR.PersonNum=WAR.PersonNum+1;
			WAR.LifeNum=WAR.LifeNum+1;
		end
    end
	if WAR.PersonNum>0 then
	    return ;
    end

    for i=1,CC.TeamNum do                 --��������ȷ���Ĳ�ս��
        WAR.SelectPerson[i]=0;
        local id=JY.Base["����" .. i];
        if id>=0 then
            for j=1,6 do
                if WAR.Data["�ֶ�ѡ���ս��" .. j]==id then
                    WAR.SelectPerson[i]=1;
                end
            end
        end
    end

    local menu={};
    for i=1, CC.TeamNum do
        menu[i]={"",WarSelectMenu,0};
        local id=JY.Base["����" .. i];
        if id>=0 then
            menu[i][3]=1;
            local s=JY.Person[id]["����"];
            if WAR.SelectPerson[i]==1 then
                menu[i][1]="*" .. s;
            else
                menu[i][1]=" " .. s;
            end
        end
    end
    menu[CC.TeamNum+1]={" ����",nil,1}

	while true do
		Cls();
		local x=(CC.ScreenW-7*CC.Fontbig-2*CC.MenuBorderPixel)/2;
		DrawStrBox(x,10,"��ѡ���ս����",C_WHITE,CC.Fontbig);
		local r=ShowMenu(menu,CC.TeamNum+1,0,x,10+CC.SingleLineHeight,0,0,1,0,CC.Fontbig,C_ORANGE,C_WHITE);
		Cls();

		for i=1,6 do
			if WAR.SelectPerson[i]>0 then
				WAR.Person[WAR.PersonNum]["������"]=JY.Base["����" ..i];
				WAR.Person[WAR.PersonNum]["�ҷ�"]=true;
				WAR.Person[WAR.PersonNum]["����X"]=WAR.Data["�ҷ�X"  .. i];
				WAR.Person[WAR.PersonNum]["����Y"]=WAR.Data["�ҷ�Y"  .. i];
				WAR.Person[WAR.PersonNum]["����"]=false;
				WAR.Person[WAR.PersonNum]["�˷���"]=2;
				WAR.Person[WAR.PersonNum]["RP"]=JY.Person[JY.Base["����" ..i]]["��Ե"];
				WAR.Person[WAR.PersonNum]["AI"]={0,0,0};
				WAR.PersonNum=WAR.PersonNum+1;
				WAR.LifeNum=WAR.LifeNum+1;
			end
		end
		if WAR.PersonNum>0 then   --ѡ�����ҷ���ս��
		   break;
		end
    end
end


--ѡ��ս���˲˵����ú���
function WarSelectMenu(newmenu,newid)            --ѡ��ս���˲˵����ú���
    local id=newmenu[newid][4];

    if WAR.SelectPerson[id]==0 then
        WAR.SelectPerson[id]=2;
    elseif WAR.SelectPerson[id]==2 then
        WAR.SelectPerson[id]=0;
    end

    if WAR.SelectPerson[id]>0 then
        newmenu[newid][1]="*" .. string.sub(newmenu[newid][1],2);
    else
        newmenu[newid][1]=" " .. string.sub(newmenu[newid][1],2);
    end
    return 0;
end

--ѡ��з���ս��
function WarSelectEnemy()            --ѡ��з���ս��
    for i=1,20 do
		WAR.Data["����"  .. i]=WAR.Data["����"  .. i] or -1
        if WAR.Data["����"  .. i]>=0 then
            WAR.Person[WAR.PersonNum]["������"]=WAR.Data["����"  .. i];
            WAR.Person[WAR.PersonNum]["�ҷ�"]=false;
            WAR.Person[WAR.PersonNum]["����X"]=WAR.Data["�з�X"  .. i];
            WAR.Person[WAR.PersonNum]["����Y"]=WAR.Data["�з�Y"  .. i];
            WAR.Person[WAR.PersonNum]["����"]=false;
            WAR.Person[WAR.PersonNum]["�˷���"]=1;
			WAR.Person[WAR.PersonNum]["RP"]=JY.Person[WAR.Data["����"  .. i]]["��Ե"];
			if WAR.Person[WAR.PersonNum]["������"]==0 then
				WAR.Person[WAR.PersonNum]["AI"]={0,0,0};
			else
				WAR.Person[WAR.PersonNum]["AI"]={2,0,0};
            end
			WAR.PersonNum=WAR.PersonNum+1;
			WAR.LifeNum=WAR.LifeNum+1;
        end
    end
end

function ModifyWarMap()
	return;
end
--����ս����ͼ
--��6�㣬�����˹����õ�ͼ
--        0�� ��������
--        1�� ����
--����Ϊս����ͼ���ݣ���ս���ļ������롣����Ϊ�����õĵ�ͼ�ṹ
--        2�� ս����ս����ţ���WAR.Person�ı��
--        3�� �ƶ�ʱ��ʾ���ƶ���λ��
--        4�� ����Ч��
--        5�� ս���˶�Ӧ����ͼ

function WarLoadMap(mapid)      --����ս����ͼ
	mapid=mapid or JY.SubScene
	if mapid<0 then mapid=JY.SubScene end
	--lib.Debug(string.format("load war map %d",mapid));
	lib.LoadWarMap(CC.WarMapFile[1],CC.WarMapFile[2],mapid,6,CC.WarWidth,CC.WarHeight);
	--[[if mapid==0 then
		for i=0,63 do
			for j=0,63 do
				lib.SetWarMap(i,j,0,lib.GetS(JY.SubScene,i,j,0))
				lib.SetWarMap(i,j,1,lib.GetS(JY.SubScene,i,j,1))
			end
		end	
	end]]--
	--ModifyWarMap();
end

function GetWarMap(x,y,level)   --ȡս����ͼ����
     return lib.GetWarMap(x,y,level);
end

function SetWarMap(x,y,level,v)  --��ս����ͼ����
 	lib.SetWarMap(x,y,level,v);
end

--����ĳ��Ϊ����ֵ
function CleanWarMap(level,v)
	lib.CleanWarMap(level,v);
end


--��ս����ͼ
--flag==0 ����
--      1 ��ʾ�ƶ�·�� (v1,v2) ��ǰ�ƶ�λ��
--      2 ��������书��ҽ�Ƶȣ���һ����ɫ��ʾ
--      4 ս������, v1 ս������pic, v2ս��������ͼ����(0 ʹ��ս��������ͼ��4��fight***��ͼ��� v3 �书Ч����ͼ -1û��Ч��

function WarDrawMap(flag,v1,v2,v3)
    local x=WAR.Person[WAR.CurID]["����X"];
    local y=WAR.Person[WAR.CurID]["����Y"];
	getkey();
    if flag==0 then
	    lib.DrawWarMap(0,x,y,0,0,-1,JY.SubScene);
    elseif flag==1 then
		if WAR.Data["��ͼ"]==0 then     --ѩ�ص�ͼ�ú�ɫ����
		    lib.DrawWarMap(1,x,y,v1,v2,-1,JY.SubScene);
        else
		    lib.DrawWarMap(2,x,y,v1,v2,-1,JY.SubScene);
			
		end
	elseif flag==2 then
	    lib.DrawWarMap(3,x,y,0,0,-1,JY.SubScene);
	elseif flag==4 then
	    lib.DrawWarMap(4,x,y,v1,v2,v3,JY.SubScene);
	end
	if WAR.ShowHead==1 then
        WarShowHead();
	end
	--[[
	if JY.Light>0 or JY.Sight>0 then
		lib.Background(0,0,CC.ScreenW,CC.ScreenH/2-JY.Sight,0)
		lib.Background(0,CC.ScreenH/2+JY.Sight,CC.ScreenW,CC.ScreenH,0)
		lib.Background(0,CC.ScreenH/2-JY.Sight,CC.ScreenW/2-JY.Sight,CC.ScreenH/2+JY.Sight,0)
		lib.Background(CC.ScreenW/2+JY.Sight,CC.ScreenH/-JY.Sight,CC.ScreenW,CC.ScreenH/2+JY.Sight,0)
		local step=math.modf(JY.Sight/30)+2;
		--for i=199,440,step do
		--	for j=119,360,step do
		for i=CC.ScreenW/2-JY.Sight,CC.ScreenW/2+JY.Sight,step do
			for j=CC.ScreenH/2-JY.Sight,CC.ScreenH/2+JY.Sight,step do
				lib.Background(i,j,i+step,j+step,Bright[i][j]);
			end
		end
	end]]--
end


function WarPersonSort(flag)               --ս�����ﰴ�Ṧ����
    for i=0,WAR.PersonNum-1 do                ---������˵��Ṧ������װ���ӳ�
        local id=WAR.Person[i]["������"];
        local add=0;
		WAR.Person[WAR.PersonNum]["RP"]=JY.Person[id]["��Ե"];
        if JY.Person[id]["����"]>-1 then
            add=add+JY.Thing[JY.Person[id]["����"]]["���Ṧ"];
        end
        if JY.Person[id]["����"]>-1 then
            add=add+JY.Thing[JY.Person[id]["����"]]["���Ṧ"];
        end
        WAR.Person[i]["�Ṧ"]=GetSpeed(id)+add;
    end
	if flag then return end
    --���Ṧ�����ñȽϱ��ķ���
    for i=0,WAR.PersonNum-2 do
        local maxid=i;
        for j=i,WAR.PersonNum-1 do
            if WAR.Person[j]["�Ṧ"]>WAR.Person[maxid]["�Ṧ"] then
                maxid=j;
            end
        end
        WAR.Person[maxid],WAR.Person[i]=WAR.Person[i],WAR.Person[maxid];
    end
end



--����ս������λ�ú���ͼ
function WarSetPerson()            --����ս������λ��
 	CleanWarMap(2,-1);
 	CleanWarMap(5,-1);

	for i=0,WAR.PersonNum-1 do
        if WAR.Person[i]["����"]==false then
            SetWarMap(WAR.Person[i]["����X"],WAR.Person[i]["����Y"],2,i);
            SetWarMap(WAR.Person[i]["����X"],WAR.Person[i]["����Y"],5,WAR.Person[i]["��ͼ"]);
        end
    end
end


function WarCalPersonPic(id)       --����ս��������ͼ
    local n=12002;            --ս��������ͼ��ʼλ��
	WAR.Person[id]["�˷���"]=WAR.Person[id]["�˷���"] or 0
    n=n+JY.Person[WAR.Person[id]["������"]]["ս������"]*8+WAR.Person[id]["�˷���"]*2;
    return n;
end

-------------------------------------------------------------------------------------------
---------------------------------����Ϊ�ֶ�ս������-------------------------------------------
-------------------------------------------------------------------------------------------

--�ֶ�ս��
--id ս��������
--���أ�ѡ�в˵���ţ�ѡ��"�ȴ�"ʱ��Ч��
function War_Manual()        --�ֶ�ս��
    local r;
	local flag=false;
	local x,y,move,pic=	WAR.Person[WAR.CurID]['����X'],
						WAR.Person[WAR.CurID]['����Y'],
						WAR.Person[WAR.CurID]["�ƶ�����"],
						WAR.Person[WAR.CurID]["��ͼ"];
	while true do
	    WAR.ShowHead=1;          --��ʾͷ��
	    r=War_Manual_Sub(flag);  --�ֶ�ս���˵�
		--lib.Debug('R:'..r)
		if r==1 or r==-1 then
			WAR.Person[WAR.CurID]["�ƶ�����"]=0
			flag=true;
		elseif r==0 then
			SetWarMap(WAR.Person[WAR.CurID]["����X"],WAR.Person[WAR.CurID]["����Y"],2,-1);
			SetWarMap(WAR.Person[WAR.CurID]["����X"],WAR.Person[WAR.CurID]["����Y"],5,-1);
			WAR.Person[WAR.CurID]['����X'],WAR.Person[WAR.CurID]['����Y'],WAR.Person[WAR.CurID]["�ƶ�����"]=x,y,move
			SetWarMap(WAR.Person[WAR.CurID]["����X"],WAR.Person[WAR.CurID]["����Y"],2,WAR.CurID);
			SetWarMap(WAR.Person[WAR.CurID]["����X"],WAR.Person[WAR.CurID]["����Y"],5,pic);
			flag=false;
        else        --�ƶ���Ϻ��������ɲ˵�
		    break;
		end
	end
	WAR.ShowHead=0;
	return r;
end


function War_Manual_Sub(flag)                --�ֶ�ս���˵�
    local pid=WAR.Person[WAR.CurID]["������"];
    local menu={ {"�ƶ�",War_MoveMenu,1},
                 {"����",War_FightMenu,1},
                 {"�ö�",War_PoisonMenu,0},
                 {"�ⶾ",War_DecPoisonMenu,0},
                 {"ҽ��",War_DoctorMenu,0},
                 {"��Ʒ",War_ThingMenu,1},
                 {"�ȴ�",War_WaitMenu,1},
                 {"״̬",War_StatusMenu,1},
                 {"��Ϣ",War_RestMenu,1},
                 {"�Զ�",War_AutoMenu,1},   };

    if flag or JY.Person[pid]["����"]<=5 or WAR.Person[WAR.CurID]["�ƶ�����"]<=0 then  --�����ƶ�
        menu[1][3]=0;
    end

    local minv=War_GetMinNeiLi(pid);

    if JY.Person[pid]["����"] < minv or JY.Person[pid]["����"] <10 then  --����ս��
        menu[2][3]=0;
    end
--[[
    if JY.Person[pid]["����"]<10 or JY.Person[pid]["�ö�"]<20 then  --�����ö�
        menu[3][3]=0;
    end

    if JY.Person[pid]["����"]<10 or JY.Person[pid]["�ⶾ"]<20 then  --���ܽⶾ
        menu[4][3]=0;
    end

    if JY.Person[pid]["����"]<50 or JY.Person[pid]["ҽ��"]<20 then  --����ҽ��
        menu[5][3]=0;
    end
]]--
    getkey();
    Cls();
	DrawTimeBar_sub(CC.ScreenW*5/8,CC.ScreenW*15/16,CC.FontSmall*5,2);
    return ShowMenu(menu,10,0,CC.MainMenuX,CC.MainMenuY,0,0,1,1,CC.Fontbig,C_ORANGE,C_WHITE);

end


function War_GetMinNeiLi(pid)       --���������书����Ҫ�������ٵ�
    local minv=math.huge;
    for i=1,CC.Kungfunum do
        local tmpid=JY.Person[pid]["�⹦"..i];
        if tmpid >0 then
            if JY.Wugong[tmpid]["������������"]< minv then
                minv=JY.Wugong[tmpid]["������������"];
            end
        end
    end
	return minv;
end

function WarShowHead1()               --��ʾս����ͷ��
    local pid=WAR.Person[WAR.CurID]["������"];
	local p=JY.Person[pid];

	local h=16+2;
    local width=160+2*CC.MenuBorderPixel;
	local height=160+2*CC.MenuBorderPixel+4*h;
	local x1,y1;
	local i=1;
    if WAR.Person[WAR.CurID]["�ҷ�"]==true then
	    x1=CC.ScreenW-width-10;
        y1=CC.ScreenH-height-10;
    else
	    x1=10;
        y1=10;
    end

    DrawBox(x1,y1,x1+width,y1+height,C_WHITE);
	local headw,headh=lib.PicGetXY(1,p["ͷ�����"]*2);
    local headx=(160-headw)/2;
	local heady=(100-headh)/2;

	lib.PicLoadCache(1,p["ͷ�����"]*2,x1+5+headx,y1+5+heady,1);
	x1=x1+5
	y1=y1+5+100;
    MyDrawString(x1,x1+160,y1+5,p["����"],C_WHITE,32);
	y1=y1+42
	
local hp=math.modf(JY.Person[pid]["����"]*160/JY.Person[pid]["�������ֵ"])
local mp=math.modf(JY.Person[pid]["����"]*160/JY.Person[pid]["�������ֵ"])
local tp=math.modf(JY.Person[pid]["����"]*160/100)
	lib.PicLoadCache(1,118*2,x1,y1,1);
	lib.PicLoadCache(1,118*2,x1,y1+30,1);
	lib.PicLoadCache(1,118*2,x1,y1+60,1);
lib.SetClip(x1,y1,x1+hp,y1+24)
	lib.PicLoadCache(1,115*2,x1,y1,1);
lib.SetClip(x1,y1+30,x1+mp,y1+54)
	lib.PicLoadCache(1,116*2,x1,y1+30,1);
lib.SetClip(x1,y1+30,x1+tp,y1+84)
	lib.PicLoadCache(1,117*2,x1,y1+60,1);
lib.SetClip(0,0,0,0)

    DrawString(x1+10,y1+5,"����",C_WHITE,16);
    DrawString(x1+10,y1+35,"����",C_WHITE,16);
    DrawString(x1+10,y1+65,"����",C_WHITE,16);
	
		--��ʼ���ƽ����������
		DrawBox_1(397,64,603,66,C_ORANGE)
		local least=0
		for i=0,WAR.PersonNum-1 do
			if WAR.Person[i]["����"]==false then
				least=least+20
			end
		end
		for i=0,WAR.PersonNum-1 do
			if WAR.Person[i]["����"]==false then
				if WAR.Person[i]["Time"]>least then
					local cx=400+math.modf((WAR.Person[i]["Time"]-least)*200/(1000-least))
					--DrawBox_1(cx,50,cx,60,C_WHITE)
					if WAR.Person[i]["�ҷ�"] then
						lib.FillColor(cx-1,50,cx+1,60,C_WHITE)
						drawname(cx,0,JY.Person[WAR.Person[i]["������"]]["����"],16)
					else
						lib.FillColor(cx-1,68,cx+1,78,C_WHITE)
						drawname(cx,82,JY.Person[WAR.Person[i]["������"]]["����"],16)					
					end
				end
			end
		end
end
function WarShowHead(id)               --��ʾս����ͷ��
	id=id or WAR.CurID
	if id<0 then return end
    local pid=WAR.Person[id]["������"];
	local p=JY.Person[pid];

	local h=16+2;
    local width=160+2*CC.MenuBorderPixel;
	local height=160+2*CC.MenuBorderPixel+4*h;
	local x1,y1;
	local i=1;
    if WAR.Person[id]["�ҷ�"]==true then
	    x1=CC.ScreenW-width-10;
        y1=CC.ScreenH-height-10;
    else
	    x1=10;
        y1=10;
    end
    DrawBox(x1,y1,x1+width,y1+height,C_WHITE);
	local headw,headh=lib.PicGetXY(1,p["ͷ�����"]*2);
    local headx=(160-headw)/2;
	local heady=(100-headh)/2;

	lib.PicLoadCache(1,p["ͷ�����"]*2,x1+5+headx,y1+5+heady,1);
	x1=x1+5
	y1=y1+5+100;
	local color=C_WHITE;
    MyDrawString(x1,x1+160,y1+5,p["����"],color,32);
	y1=y1+42
	
local hp=math.modf(JY.Person[pid]["����"]*160/JY.Person[pid]["�������ֵ"])
local mp=math.modf(JY.Person[pid]["����"]*160/JY.Person[pid]["�������ֵ"])
local tp=math.modf(JY.Person[pid]["����"]*160/100)
	lib.PicLoadCache(1,275*2,x1,y1,1);
	lib.PicLoadCache(1,275*2,x1,y1+30,1);
	lib.PicLoadCache(1,275*2,x1,y1+60,1);
lib.SetClip(x1,y1,x1+hp,y1+24)
	lib.PicLoadCache(1,274*2,x1,y1,1);
lib.SetClip(x1,y1+30,x1+mp,y1+54)
	lib.PicLoadCache(1,273*2,x1,y1+30,1);
lib.SetClip(x1,y1+30,x1+tp,y1+84)
	lib.PicLoadCache(1,276*2,x1,y1+60,1);
lib.SetClip(0,0,0,0)
    DrawString(x1+10,y1+5,string.format("����:%5d/%5d",p["����"],p["�������ֵ"]),C_WHITE,16);
    DrawString(x1+10,y1+35,string.format("����:%5d/%5d",p["����"],p["�������ֵ"]),C_WHITE,16);
    DrawString(x1+10,y1+65,string.format("����:%6d",p["����"]),C_WHITE,16);
	
	--RP
	--[[
	DrawString(10,CC.ScreenH-48,"RP:"..math.modf(WAR.Person[id]["RP"]),C_WHITE,16);
	DrawBox(64,CC.ScreenH-48,64+300,CC.ScreenH-32,C_WHITE);
	DrawBox(64,CC.ScreenH-48,64+limitX(WAR.Person[id]["RP"],0,100)*3,CC.ScreenH-32,C_WHITE,C_ORANGE);
	]]--
		--��ʼ���ƽ����������
	--DrawStrBox(CC.FontSmall,CC.ScreenH-CC.FontSmall*5,string.format("�ж�:%3d ����:%3d ��Ѫ:%3d*��Ѩ:%3d ���:%3d*����:%3d ����:%3d",
	 --                                                  p["�ж�"],p["����"],p["��Ѫ"],WAR.Person[WAR.CurID]["��Ѩ"],
	--												   WAR.Person[WAR.CurID]["���"],WAR.Person[WAR.CurID]["����"],
	--												   WAR.Person[WAR.CurID]["����"]),M_White,CC.FontSmall);
end


--����1���Ѿ��ƶ�    0 û���ƶ�
function War_MoveMenu()           --ִ���ƶ��˵�
    WAR.ShowHead=0;   --����ʾͷ��
    if WAR.Person[WAR.CurID]["�ƶ�����"]<=0 then
        return 0;
    end

    War_CalMoveStep(WAR.CurID,WAR.Person[WAR.CurID]["�ƶ�����"],0);   --�����ƶ�����

    local r;
    local x,y=War_SelectMove()             --ѡ���ƶ�λ��
    if x ~=nil then            --��ֵ��ʾû��ѡ��esc�����ˣ��ǿ����ʾѡ����λ��
        War_MovePerson(x,y);    --�ƶ�����Ӧ��λ��
        r=1;
	else
	    r=0
		WAR.ShowHead=1;
		Cls();
    end
    getkey();
    return r;
end

--������ƶ�����
--id ս����id��
--stepmax �������
--flag=0  �ƶ�����Ʒ�����ƹ���1 �书���ö�ҽ�Ƶȣ������ǵ�·��
function War_CalMoveStepOld(id,stepmax,flag)
	
  	CleanWarMap(3,255);           --�������������������ƶ����ȶ���Ϊ255��

    local x=WAR.Person[id]["����X"];
    local y=WAR.Person[id]["����Y"];

	local steparray={};     --�����鱣���n�������ꡣ
	for i=0,stepmax do
	    steparray[i]={};
        steparray[i].x={};
        steparray[i].y={};
	end

	SetWarMap(x,y,3,0);
    steparray[0].num=1;
	steparray[0].x[1]=x;
	steparray[0].y[1]=y;
	War_FindNextStepOld(steparray,0,flag,id);

	return steparray;

end

--������ĺ�������
function War_FindNextStepOld(steparray,step,flag,id)      --������һ�����ƶ�������
    local num=0;
	local step1=step+1;
	if steparray[step1]==nil then
		return;
	end
	for i=1,steparray[step].num do
	    local x=steparray[step].x[i];
	    local y=steparray[step].y[i];
	    if x+1<CC.WarWidth-1 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x+1,y,3);
			if v ==255 and War_CanMoveXYOld(x+1,y,flag)==true then
                num= num+1;
                steparray[step1].x[num]=x+1;
                steparray[step1].y[num]=y;
				SetWarMap(x+1,y,3,step1);
			end
		end

	    if x-1>0 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x-1,y,3);
			if v ==255 and War_CanMoveXYOld(x-1,y,flag)==true then
                 num=num+1;
                steparray[step1].x[num]=x-1;
                steparray[step1].y[num]=y;
				SetWarMap(x-1,y,3,step1);
			end
		end

	    if y+1<CC.WarHeight-1 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x,y+1,3);
			if v ==255 and War_CanMoveXYOld(x,y+1,flag)==true then
                 num= num+1;
                steparray[step1].x[num]=x;
                steparray[step1].y[num]=y+1;
				SetWarMap(x,y+1,3,step1);
			end
		end

	    if y-1>0 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x ,y-1,3);
			if v ==255 and War_CanMoveXYOld(x,y-1,flag)==true then
                num= num+1;
                steparray[step1].x[num]=x ;
                steparray[step1].y[num]=y-1;
				SetWarMap(x ,y-1,3,step1);
			end
		end
	end
	if num==0 then return end;
    steparray[step1].num=num;	
	War_FindNextStepOld(steparray,step1,flag,id)

end
--��������֮���ʵ�ʾ���
function War_realjl(ida,idb)
	if ida==nil then
		ida=WAR.CurID
	end
	
  	CleanWarMap(3,255);           --�������������������ƶ����ȶ���Ϊ255��

    local x=WAR.Person[ida]["����X"];
    local y=WAR.Person[ida]["����Y"];

	local steparray={};     --�����鱣���n�������ꡣ
	    steparray[0]={};
		steparray[0].bushu={};
        steparray[0].x={};
        steparray[0].y={};

	SetWarMap(x,y,3,0);
    steparray[0].num=1;
	steparray[0].bushu[1]=0;					--�����ƶ��Ĳ���
	steparray[0].x[1]=x;
	steparray[0].y[1]=y;
	return War_FindNextStep1(steparray,0,ida,idb);
	--return steparray;

end

--������ĺ�������
function War_FindNextStep1(steparray,step,id,idb)      --������һ�����ƶ�������
    local num=0;
	local step1=step+1;
	
	    steparray[step1]={};
		steparray[step1].bushu={};
        steparray[step1].x={};
        steparray[step1].y={};
	
	local function fujinnum(tx,ty)
		local tnum=0
		local wofang=WAR.Person[id]["�ҷ�"]
		local tv;
		tv=GetWarMap(tx+1,ty,2);
		if idb==nil then
			if tv~=-1 then
				if WAR.Person[tv]["�ҷ�"]~=wofang then
					return -1
				end
			end
		elseif tv==idb then
			return -1
		end
		if tv~=-1 then
			if WAR.Person[tv]["�ҷ�"]~=wofang then
				tnum=tnum+1
			end
		end
		tv=GetWarMap(tx-1,ty,2);
		if idb==nil then
			if tv~=-1 then
				if WAR.Person[tv]["�ҷ�"]~=wofang then
					return -1
				end
			end
		elseif tv==idb then
			return -1
		end
		if tv~=-1 then
			if WAR.Person[tv]["�ҷ�"]~=wofang then
				tnum=tnum+1
			end
		end
		tv=GetWarMap(tx,ty+1,2);
		if idb==nil then
			if tv~=-1 then
				if WAR.Person[tv]["�ҷ�"]~=wofang then
					return -1
				end
			end
		elseif tv==idb then
			return -1
		end
		if tv~=-1 then
			if WAR.Person[tv]["�ҷ�"]~=wofang then
				tnum=tnum+1
			end
		end
		tv=GetWarMap(tx,ty-1,2);
		if idb==nil then
			if tv~=-1 then
				if WAR.Person[tv]["�ҷ�"]~=wofang then
					return -1
				end
			end
		elseif tv==idb then
			return -1
		end
		if tv~=-1 then
			if WAR.Person[tv]["�ҷ�"]~=wofang then
				tnum=tnum+1
			end
		end
		return tnum
	end
	
	
	
	for i=1,steparray[step].num do
		--if steparray[step].bushu[i]<128 then
		steparray[step].bushu[i]=steparray[step].bushu[i]+1;
	    local x=steparray[step].x[i];
	    local y=steparray[step].y[i];
	    if x+1<CC.WarWidth-1 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x+1,y,3);
			if v ==255 and War_CanMoveXY(x+1,y,0)==true then
                num= num+1;
                steparray[step1].x[num]=x+1;
                steparray[step1].y[num]=y;
				SetWarMap(x+1,y,3,step1);
				local mnum=fujinnum(x+1,y);
				if mnum==-1 then 
					return steparray[step].bushu[i],x+1,y
				else
					steparray[step1].bushu[num]=steparray[step].bushu[i]+mnum;
				end
			end
		end

	    if x-1>0 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x-1,y,3);
			if v ==255 and War_CanMoveXY(x-1,y,0)==true then
                 num=num+1;
                steparray[step1].x[num]=x-1;
                steparray[step1].y[num]=y;
				SetWarMap(x-1,y,3,step1);
				local mnum=fujinnum(x-1,y);
				if mnum==-1 then 
					return steparray[step].bushu[i],x-1,y
				else
					steparray[step1].bushu[num]=steparray[step].bushu[i]+mnum;
				end
			end
		end

	    if y+1<CC.WarHeight-1 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x,y+1,3);
			if v ==255 and War_CanMoveXY(x,y+1,0)==true then
                 num= num+1;
                steparray[step1].x[num]=x;
                steparray[step1].y[num]=y+1;
				SetWarMap(x,y+1,3,step1);
				local mnum=fujinnum(x,y+1);
				if mnum==-1 then 
					return steparray[step].bushu[i],x,y+1
				else
					steparray[step1].bushu[num]=steparray[step].bushu[i]+mnum;
				end
			end
		end

	    if y-1>0 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x ,y-1,3);
			if v ==255 and War_CanMoveXY(x,y-1,0)==true then
                num= num+1;
                steparray[step1].x[num]=x ;
                steparray[step1].y[num]=y-1;
				SetWarMap(x ,y-1,3,step1);
				local mnum=fujinnum(x,y-1);
				if mnum==-1 then 
					return steparray[step].bushu[i],x,y-1
				else
					steparray[step1].bushu[num]=steparray[step].bushu[i]+mnum;
				end
			end
		end
		--end
	end
	if num==0 then return -1 end;
    steparray[step1].num=num;
	for i=1,num-1 do
		for j=i+1,num do
			if steparray[step1].bushu[i]>steparray[step1].bushu[j] then
				steparray[step1].bushu[i],steparray[step1].bushu[j]=steparray[step1].bushu[j],steparray[step1].bushu[i]
				steparray[step1].x[i],steparray[step1].x[j]=steparray[step1].x[j],steparray[step1].x[i]
				steparray[step1].y[i],steparray[step1].y[j]=steparray[step1].y[j],steparray[step1].y[i]
			end
		end
	end
	
	
	return War_FindNextStep1(steparray,step1,id,idb)

end

function War_CanMoveXY(x,y,flag)  --�����Ƿ����ͨ�����ж��ƶ�ʱʹ��
	if GetWarMap(x,y,1)>0 then    --��1��������
		return false
	end
	if flag==0 then		
		if CC.WarWater[GetWarMap(x,y,0)]~=nil then          --ˮ�棬������
			local id=WAR.Person[WAR.CurID]["������"]
			local kfnum=JY.Person[id]["�Ṧ"] or 0
			if kfnum<=0 or kfnum>CC.Kungfunum then return false end
			local kf,kflv=JY.Person[id]["�书"][kfnum][1],div100(JY.Person[id]["�书"][kfnum][2])+1
			if smagic(id,kf,kflv,07)<1 then
				return false
			end
		end
		if GetWarMap(x,y,2)>=0 then    --����
			return false
		end
	end
	return true;
end
function War_CanMoveXYOld(x,y,flag)  --�����Ƿ����ͨ�����ж��ƶ�ʱʹ��
	if GetWarMap(x,y,1)>0 then    --��1��������
		return false
	end
	if flag==0 then		
		if CC.WarWater[GetWarMap(x,y,0)]~=nil then          --ˮ�棬������
			return false
		end
	end
	return true;
end




function War_SelectMove()              ---ѡ���ƶ�λ��
    local x0=WAR.Person[WAR.CurID]["����X"];
    local y0=WAR.Person[WAR.CurID]["����Y"];
    local x=x0;
    local y=y0;
	local t=0;
    while true do
        local x2=x;
        local y2=y;

		if t==0 then
			WAR.Data["��ͼ"]=0;
		elseif t==10 then
			WAR.Data["��ͼ"]=1;
		end
        WarDrawMap(1,x,y);
		t=t+1;
		if t>20 then
			t=0;
		end
        ShowScreen();
		lib.Delay(30);
        local eventtype,key,mx,my=getkey();--WaitKey(1);
		if eventtype==1 then
			if key==VK_UP then
				y2=y-1;
			elseif key==VK_DOWN then
				y2=y+1;
			elseif key==VK_LEFT then
				x2=x-1;
			elseif key==VK_RIGHT then
				x2=x+1;
			elseif key==VK_SPACE or key==VK_RETURN then
				return x,y;
			elseif key==VK_ESCAPE then
				return nil;
			end
			if GetWarMap(x2,y2,3)<128 then
				x=x2;
				y=y2;
			end
		elseif eventtype==2 or eventtype==3 then
			mx=mx-CC.ScreenW/2
			my=my-CC.ScreenH/2+GetS(JY.SubScene,x0,y0,4)
			mx=mx/CC.XScale
			my=my/CC.YScale
			mx,my=(mx+my)/2,(my-mx)/2
			if mx>0 then mx=mx+0.99 else mx=mx-0.01 end
			if my>0 then my=my+0.99 else mx=mx-0.01 end
			mx=math.modf(mx)
			my=math.modf(my)
			for i=-10,10 do
				if between(x0+mx+i,0,63) and between(y0+my+i,0,63) then
					if math.abs(GetS(JY.SubScene,x0+mx+i,y0+my+i,4)-CC.YScale*i*2-GetS(JY.SubScene,x0,y0,4))<4 then
						mx=mx+i;
						my=my+i;
						break;
					end
				end
			end
			if GetWarMap(x0+mx,y0+my,3)<128 then
				x,y=x0+mx,y0+my
				if eventtype==3 then
					if key==1 then
						return x,y;
					elseif key==3 then
						return nil;
					end
				end
			end
		end

    end

end


function War_MovePerson(x,y)            --�ƶ����ﵽλ��x,y

    local movenum=GetWarMap(x,y,3);
    --WAR.Person[WAR.CurID]["�ƶ�����"]=WAR.Person[WAR.CurID]["�ƶ�����"]-movenum;    --���ƶ�������С

    local movetable={};  --   ��¼ÿ���ƶ�
    for i=movenum,1,-1 do    --��Ŀ��λ�÷����ҵ���ʼλ�ã���Ϊ�ƶ��Ĵ���
        movetable[i]={};
        movetable[i].x=x;
        movetable[i].y=y;
        if GetWarMap(x-1,y,3)==i-1 then
            x=x-1;
            movetable[i].direct=1;
        elseif GetWarMap(x+1,y,3)==i-1 then
            x=x+1;
            movetable[i].direct=2;
        elseif GetWarMap(x,y-1,3)==i-1 then
            y=y-1;
            movetable[i].direct=3;
        elseif GetWarMap(x,y+1,3)==i-1 then
            y=y+1;
            movetable[i].direct=0;
        end
    end
	
	if movenum>WAR.Person[WAR.CurID]["�ƶ�����"] then 
		movenum=WAR.Person[WAR.CurID]["�ƶ�����"]
		WAR.Person[WAR.CurID]["�ƶ�����"]=0
	else
		WAR.Person[WAR.CurID]["�ƶ�����"]=WAR.Person[WAR.CurID]["�ƶ�����"]-movenum
	end
    for i=1,movenum do
        local t1=lib.GetTime();

		SetWarMap(WAR.Person[WAR.CurID]["����X"],WAR.Person[WAR.CurID]["����Y"],2,-1);
		SetWarMap(WAR.Person[WAR.CurID]["����X"],WAR.Person[WAR.CurID]["����Y"],5,-1);

        WAR.Person[WAR.CurID]["����X"]=movetable[i].x;
        WAR.Person[WAR.CurID]["����Y"]=movetable[i].y;
        WAR.Person[WAR.CurID]["�˷���"]=movetable[i].direct;
        WAR.Person[WAR.CurID]["��ͼ"]=WarCalPersonPic(WAR.CurID);

		SetWarMap(WAR.Person[WAR.CurID]["����X"],WAR.Person[WAR.CurID]["����Y"],2,WAR.CurID);
		SetWarMap(WAR.Person[WAR.CurID]["����X"],WAR.Person[WAR.CurID]["����Y"],5,WAR.Person[WAR.CurID]["��ͼ"]);
		WarDrawMap(0);
		ShowScreen();
        local t2=lib.GetTime();
		if i<movenum then
			if (t2-t1)< 2*CC.Frame then
				lib.Delay(2*CC.Frame-(t2-t1));
			end
		end
    end

end


function War_FightMenu()              --ִ�й����˵�

    local pid=WAR.Person[WAR.CurID]["������"];

    local numwugong=0;
    local menu={};
    for i=1,5 do
        local tmp=JY.Person[pid]["�⹦"..i];
        if tmp>0 then
			menu[i]={JY.Wugong[tmp]["����"],nil,1};
			if JY.Wugong[tmp]["�书����"]>5 or JY.Wugong[tmp]["������������"] > JY.Person[pid]["����"] then
				menu[i][3]=0;
			end
        else
			menu[i]={"ERROR",nil,0};
		end
		numwugong=numwugong+1;
    end

    if numwugong==0 then
        return 0;
    end
    local r;
    if numwugong==1 then
        r=1;
    else
        r=ShowMenu(menu,numwugong,0,CC.MainSubMenuX,CC.MainSubMenuY,0,0,1,1,CC.Fontbig,C_ORANGE,C_WHITE);
    end
    if r==0 then
        return 0;
    end

    WAR.ShowHead=0;
    local r2=War_Fight_Sub(WAR.CurID,r);
    WAR.ShowHead=1;
	Cls();
	return r2;
	
end

--ִ��ս�����Զ����ֶ�ս��������
function War_Fight_Sub(id,wugongnum,x,y)          --ִ��ս��
	WAR.ShowHead=0
	WarDrawMap(0)
	lib.Delay(250)
    local pid=WAR.Person[id]["������"];
	--PUSH(JY.Person[pid]["�ڹ�����"]);

--	if JY.Person[pid]["�ڹ�"]>0 then
--		local dxx=math.abs(JY.Person[pid]["��������"]-JY.Wugong[JY.Person[pid]["�ڹ�"]]["˼��"]);
--		if dxx>1 then
--			JY.Person[pid]["�ڹ�����"]=JY.Person[pid]["�ڹ�����"]*(24-dxx)/24;
--		end
--	end
	
    local wugong=0;
	--DrawString(320,240,tostring(wugongnum)..'|'..tostring(x)..","..tostring(y),C_RED,42)
	--ShowScreen()
	--lib.Delay(1500)
	local level;
	if wugongnum<6 then 
		wugong=JY.Person[pid]["�⹦"..wugongnum];
		level=math.modf(JY.Person[pid]["�⹦����"..wugongnum]/100)+1;
		WAR.Person[id]["�м�"]=wugongnum;
	else 
		x=WAR.Person[WAR.CurID]["����X"]-x;
		y=WAR.Person[WAR.CurID]["����Y"]-y;
		wugong=wugongnum-100;
		wugongnum=WAR.Person[id]["�����书"];
		if wugongnum==6 then
			wugongnum=JY.Person[pid]["�ڹ�"];
			level=math.modf(JY.Person[pid]["�ڹ�����"]/100)+1;
		elseif wugongnum==7 then
			wugongnum=JY.Person[pid]["�Ṧ"];
			level=math.modf(JY.Person[pid]["�Ṧ����"]/100)+1;
		else
			wugongnum=JY.Person[pid]["�ؼ�"];
			level=math.modf(JY.Person[pid]["�ؼ�����"]/100)+1;
		end										
		WarDrawMap(0);
		DrawStrNewBox(CC.ScreenW/2-CC.Fontbig*(#JY.Wugong[wugongnum]["����"]+4)/4,CC.Fontbig,JY.Wugong[wugongnum]["����"].."����",C_ORANGE,CC.Fontbig);
		ShowScreen()
		lib.Delay(350)
	end;
	WAR.Person[id]["�����书"]=9999;								--��ֹ��ת�����󷴻�
	if WAR.Person[id]["TimeAdd"]>0 then
		WAR.Person[id]["TimeAdd"]=0;
	end
   	CleanWarMap(4,0);

    local fightscope;--=JY.Kungfu[wugong]["������Χ"][math.modf((level+2)/3)];
	local hurtscope;--=JY.Kungfu[wugong]["�˺���Χ"][math.modf((level+2)/3)];
	
	local hurt,atk,level=GetAtk(pid,wugong,level);
			for lv=level,1,-1 do
				if JY.Kungfu[wugong]["������Χ"][lv]~=nil then
					fightscope=JY.Kungfu[wugong]["������Χ"][lv];
					break;
				end
			end
			for lv=level,1,-1 do
				if JY.Kungfu[wugong]["�˺���Χ"][lv]~=nil then
					hurtscope=JY.Kungfu[wugong]["�˺���Χ"][lv];
					break;
				end
			end
	local r,x,y=War_FightSelectType(fightscope,hurtscope,x,y)
	if r==false then
		--JY.Person[pid]["�ڹ�����"]=POP();
		return 0;
    end
	
	
	WAR["����"]=0;
	WAR["����"]=0;
	WAR["��"]=0;
	
    local fightnum=1;
	local tmp1,tmp2=smagic(pid,20);
	if tmp1~=-1 then
		fightnum=2;
		WAR.Person[id]["RP"]=limitX(WAR.Person[id]["RP"]-20,-100,200);
	end
for k=1,fightnum  do         --������һ������򹥻�����

	--Ԥ�ȶ�ȡ���б����������������ֵ
	WAR["����"]=0;
	WAR["����"]=0;
	WAR["��"]=0;
    for i=0,CC.WarWidth-1 do
        for j=0,CC.WarHeight-1 do
			local effect=GetWarMap(i,j,4);
            if effect>0 then              --����Ч���ط�
  				local emeny=GetWarMap(i,j,2);
                 if emeny>=0 then          --����
					local eid=WAR.Person[emeny]["������"];
                    if WAR.Person[id]["�ҷ�"] ~= WAR.Person[emeny]["�ҷ�"]  then       --�ǵ���
						for ii,vv in pairs({"����","����","��"}) do
							if JY.Person[eid][vv]>WAR[vv] then
								WAR[vv]=JY.Person[eid][vv];
							end
						end
					end
				end
			end
		end
	end

	WAR.Person[id]["TimeAdd"]=WAR.Person[id]["TimeAdd"]+JY.Wugong[wugong]["����"];
    
	while true do
        if math.modf((level+1)/2)*JY.Wugong[wugong]["������������"] > JY.Person[pid]["����"] then
            level=level-1;
        else
            break;
        end
    end

    if level<=0 then     --��ֹ�������һ���ʱ��һ�ι�����ϣ��ڶ��ι���û�������������
	    level=1;
    end
	
	if k==2 then
		DrawStrBox(-1,24,KfName(tmp2).."����",C_ORANGE,24)
	end
	local magic={}
	--smagic(pid,wugongnum,magic)		--���㹥���ؼ��������//�����������wugongnum��������ĵڼ����书����ת�Ļ���������Ƕ�ת���Ƶı�ţ����Բ������书��Ч���֣���Ȼ���ԼӼ����� ���綷ת���Ʒ���֮��ģ�Ҳ�������������ɣ���ʵ�Ǹ�bug�����ڿ���Ҳ�������ء����и�bug�������б��������ڶ��ι���λ�ô������ҿ�
	atkmagic(pid,wugong,level,magic);
	
	
	WAR["����"]=JY.Person[pid]["����"];
	WAR["����"]=JY.Person[pid]["����"];
	WAR["��"]=JY.Person[pid]["��"];
	
	if fightnum==2 then 
		magic[0]={1,tmp1} 
	end
	--���мӿ�
	for i,v in pairs(magic) do
		if v[1]==11 then
			WAR.Person[id]["Time"]=WAR.Person[id]["Time"]+math.modf(1000*v[2]/100);
		end
	end
	--����Χ
	for i,v in pairs(magic) do
		if v[1]==14 then
			hurtscope=JY.Kungfu[wugong]["�˺���Χ"][v[2]];
			War_FightSelectType(fightscope,hurtscope,x,y);
		end
	end
    for i=0,CC.WarWidth-1 do
        for j=0,CC.WarHeight-1 do
			local effect=GetWarMap(i,j,4);
            if effect>0 then              --����Ч���ط�
  				local emeny=GetWarMap(i,j,2);
                 if emeny>=0 then          --����
					local eid=WAR.Person[emeny]["������"];
					--PUSH(JY.Person[eid]["�ڹ�����"]);
					
--					if JY.Person[eid]["�ڹ�"]>0 then
--						local dxx=math.abs(JY.Person[eid]["��������"]-JY.Wugong[JY.Person[eid]["�ڹ�"]]["˼��"]);
--						if dxx>1 then
--							JY.Person[eid]["�ڹ�����"]=JY.Person[eid]["�ڹ�����"]*(24-dxx)/24;
--						end
--					end
					
                    if WAR.Person[id]["�ҷ�"] ~= WAR.Person[emeny]["�ҷ�"]  then       --�ǵ���
					     --ֻ�е���湥������ɱ��������ʱ�˺�������Ч
						 --[[
					     if JY.Wugong[wugong]["�˺�����"]==1 and (fightscope==0 or fightscope==3) then
                             WAR.Person[emeny]["����"]=-War_WugongHurtNeili(emeny,wugong,level)
							 SetWarMap(i,j,4,3);
							 WAR.Effect=3;
                         else
                             WAR.Person[emeny]["����"]=-War_WugongHurtLife(emeny,wugong,level)
							 WAR.Effect=2;
							 SetWarMap(i,j,4,2);
                         end
						 --]]
						 War_WugongHurt(id,emeny,magic,hurt,atk,wugong)
						 --lib.Debug(WAR.Person[WAR.CurID]["����"])
						 WAR.Effect=2;
						 --if WAR.Person[emeny]["����"]==0 then 
						--	SetWarMap(i,j,4,0)
						--else
							SetWarMap(i,j,4,2)
						--end
                     end
					 --[[
					if WAR.Person[id]["�ҷ�"] == WAR.Person[emeny]["�ҷ�"] and JY.Wugong[wugong]["�˺�����"]~=0 then
						War_WugongCure(id,emeny,magic,wugong,level)
						SetWarMap(i,j,4,2)
					end
					]]--
					-- end
					--JY.Person[eid]["�ڹ�����"]=POP();
                 end
             end
         end
    end

    War_ShowFight(pid,wugong,JY.Wugong[wugong]["�书����"],level,x,y,JY.Wugong[wugong]["�书����&��Ч"]);



    WAR.Person[WAR.CurID]["����"]=WAR.Person[WAR.CurID]["����"]+math.random(10)+1;

    --if JY.Person[pid]["�书�ȼ�" .. wugongnum]<900 then
    --   JY.Person[pid]["�书�ȼ�" .. wugongnum]=JY.Person[pid]["�书�ȼ�" .. wugongnum]+Rnd(2)+1;
    --end

    --if math.modf(JY.Person[pid]["�书�ȼ�" .. wugongnum]/100)+1 ~= level then    --�书������
    --    level=math.modf(JY.Person[pid]["�书�ȼ�" .. wugongnum]/100)+1;
    --    DrawStrBox(-1,-1,string.format("%s ��Ϊ %d ��",JY.Wugong[wugong]["����"],level),C_ORANGE,CC.Fontbig)
    --    ShowScreen();
    --    lib.Delay(500);
    --    Cls();
    --    ShowScreen();
    --end
	AddPersonAttrib(pid,"����",-math.modf(JY.Wugong[wugong]["������������"]*level*(1+WAR.Person[id]["����"]/25)));
    AddPersonAttrib(pid,"����",-3);
	--�ջ���߻�������ֵ
	local dengjie=JY.Wugong[wugong]["�Ƚ�"];
	local bq_str;
	if JY.Wugong[wugong]["�书����"]==1 then
		bq_str="ȭ��";
	elseif JY.Wugong[wugong]["�书����"]==2 then
		bq_str="����";
	elseif JY.Wugong[wugong]["�书����"]==3 then
		bq_str="ˣ��";
	elseif JY.Wugong[wugong]["�书����"]==4 then
		bq_str="ǹ��";
	end
	if bq_str~=nil then
		local now_bq=JY.Person[pid][bq_str];
		if now_bq<100 then
			local diff=dengjie*20+10-now_bq;
				if diff>0 then
					if math.random(dengjie+2)==1 then
						AddPersonAttrib(pid,bq_str,1);
						if JY.Person[pid][bq_str]%10==0 then
							DrawStrBoxWaitKey(string.format("%s��%s������",JY.Person[pid]["����"],bq_str),C_WHITE,CC.Fontbig);
						end
					end
				end
		end
	end
	if JY.Person[pid]["����"]<=0 then break end
end


	local dz={}
	local dznum=0
	for i=0,WAR.PersonNum-1 do
		if WAR.Person[i]["�����书"]~=-1 and WAR.Person[i]["�����书"]~=9999 then  			--
			dznum=dznum+1;
			dz[dznum]={i,wugong,x-WAR.Person[WAR.CurID]["����X"],y-WAR.Person[WAR.CurID]["����Y"]}
		end
	end	
	--DrawTimeBar2();
	for i = 1, dznum do
		local tmp=WAR.CurID
		WAR.CurID=dz[i][1]
		--lib.Delay(100)
		War_Fight_Sub(dz[i][1],dz[i][2]+100,dz[i][3],dz[1][4])--dz[i][3],dz[i][4])          --ִ��ս��
		WAR.CurID=tmp		
		WAR.Person[WAR.CurID]["�����书"]=-1
	end
	
	WAR.Person[id]["�����书"]=-1										--�����ֹ��ת�����󷴻�
		
	--JY.Person[pid]["�ڹ�����"]=POP();
    return 1;
end

function QuickWar(warid)
	WarLoad(warid);	
	--JY.Status=GAME_WMAP;
	WarSelectTeam();          --ѡ���ҷ�
	WarSelectEnemy();         --ѡ�����
	CleanMemory()
	WarLoadMap(WAR.Data["��ͼ"]);       --����ս����ͼ
	WarPersonSort();    --ս���˰��Ṧ����
	local warStatus=0;
	for i=0,WAR.PersonNum-1 do
        local pid=WAR.Person[i]["������"];
		WAR.Person[i]["Time"]=800-(i*1000/(WAR.PersonNum+2))+smagic(pid,42,1);
	end
	GetJiqi();
	
	while true do
		
		for i=0,WAR.PersonNum-1 do
			if WAR.Person[i]["����"]==false then
				WAR.Person[i]["Time"]=WAR.Person[i]["Time"]+WAR.Person[i]["TimeAdd"];
			end
		end
		--������ȴ���1000�����ж�
		for p=0,WAR.PersonNum-1 do
			if WAR.Person[p]["����"]==false then
				if WAR.Person[p]["Time"]>1000 then 
					WAR.CurID=p;
					local pid=WAR.Person[p]["������"];
					local kfnum=0;
					for i=1,5 do
						if JY.Person[pid]["�⹦"..i]>0 then
							kfnum=i;
						else
							break;
						end
					end
					if kfnum>1 then
						kfnum=math.random(kfnum);
					end
					--lib.Debug(">>"..kfnum)
					if kfnum>0 then
						local hurt,atk,level=GetAtk(pid,JY.Person[pid]["�⹦"..kfnum],math.modf(JY.Person[pid]["�⹦����"..kfnum]/100)+1);
						local magic={};
						atkmagic(pid,JY.Person[pid]["�⹦"..kfnum],level,magic);
						for emeny=0,WAR.PersonNum-1 do
							if emeny~=p then
								War_WugongHurt(p,emeny,magic,hurt,atk,JY.Person[pid]["�⹦"..kfnum]);
							end
						end
					end
					WAR.Person[p]["Time"]=WAR.Person[p]["Time"]-1000;
					WAR.Person[p]["Time"]=WAR.Person[p]["Time"]+WAR.Person[p]["TimeAdd"]
					warStatus=War_isEnd();        --ս���Ƿ������   0������1Ӯ��2��
					if warStatus>0 then
						break;
					end
				end	
			end
		end	
		if warStatus>0 then
			break;
		end
		GetJiqi();
	end
	for i=0,WAR.PersonNum-1 do
        local pid=WAR.Person[i]["������"];
		AddPersonAttrib(pid,"����",math.huge);
	end
	if warStatus==1 then
			return true;
    elseif warStatus==2 then
			return false;
    end
end

--�����˷���
--(x1,y1) ��λ��     -(x2,y2) Ŀ��λ��
--���أ� ����
function War_Direct(x1,y1,x2,y2)             --�����˷���
    local x=x2-x1;
    local y=y2-y1;
	if x==0 and y==0 then return nil end
    if math.abs(y)>math.abs(x) then
        if y>0 then
            return 3;
        else
            return 0
        end
    else
        if x>0 then
            return 1;
        else
            return 2;
        end
    end
end


--��ʾս������
--pid ��id
--wugong  �书��ţ� 0 ��ʾ�ö��ⶾ�ȣ�ʹ����ͨ����Ч��
--wogongtype =0 ҽ���ö��ⶾ��1,2,3,4 �书����  -1 ����
--level �书�ȼ�
--x,y ��������
--eft  �书����Ч��id  eft.idx/grp�е�Ч��
function War_ShowFight(pid,wugong,wugongtype,level,x,y,eft)              --��ʾս������
	local x0=WAR.Person[WAR.CurID]["����X"];
	local y0=WAR.Person[WAR.CurID]["����Y"];
	
	--����ǰ��ʾ�书����
	local kfname=JY.Wugong[wugong]["����"]
	local kfx=CC.ScreenW/2-string.len(kfname)*CC.Fontbig/4-4
	DrawStrNewBox(kfx,CC.FontBig*2,kfname,C_WHITE,CC.Fontbig);
	ShowScreen()
	lib.Delay(800)
	
    local fightdelay,fightframe,sounddelay;
	fightdelay=8;
	sounddelay=8;
    if wugongtype>=0 and wugongtype<5 then
		--lib.Debug(JY.Person[pid]["ս������"]..'<:>'..(wugongtype+1))
		fightframe=JY.fmp[JY.Person[pid]["ս������"]][wugongtype+1]
    else            ---��������Щ����ʲô��˼����
        fightframe=0;
    end
	
	--����Щû�ж���֡���ģ�ʹ��Ĭ�ϵ�֡��
	if fightframe==0 then
		for i=5,1,-1 do
			if JY.fmp[JY.Person[pid]["ս������"]][i]~=0 then
				fightframe=JY.fmp[JY.Person[pid]["ս������"]][i]
				wugongtype=i-1
			end
		end		
	end
	
    local framenum=fightdelay+CC.Effect[eft];            --��֡��

    local startframe=0;               --����fignt***�е�ǰ������ʼ֡
    if wugongtype>=0 then
        for i=0,wugongtype-1 do
            startframe=startframe+4*JY.fmp[JY.Person[pid]["ս������"]][i+1];
        end
    end

    local starteft=0;          --������ʼ�书Ч��֡
    for i=0,eft-1 do
        starteft=starteft+CC.Effect[i];
    end

	WAR.Person[WAR.CurID]["��ͼ����"]=0;
	WAR.Person[WAR.CurID]["��ͼ"]=WarCalPersonPic(WAR.CurID);

    WarSetPerson();

	WarDrawMap(0);
	ShowScreen();

    local fastdraw;
    if CONFIG.FastShowScreen==0 or CC.AutoWarShowHead==1 then    --��ʾͷ����ȫ���ػ�
        fastdraw=0;
	else
	    fastdraw=1;
	end

    --����ʾ����ǰ�ȼ�����ͼ
    local oldpic=WAR.Person[WAR.CurID]["��ͼ"]/2;
	local oldpic_type=0;

    local oldeft=-1;

    for i=0,framenum-1 do
        local tstart=lib.GetTime();
		local mytype;
        if fightframe>0 then
            WAR.Person[WAR.CurID]["��ͼ����"]=1;
		    mytype=4+WAR.CurID;
            if i<fightframe then
                WAR.Person[WAR.CurID]["��ͼ"]=(startframe+WAR.Person[WAR.CurID]["�˷���"]*fightframe+i)*2;
            end
        else       --��������ʹ��fight��ͼ��
            WAR.Person[WAR.CurID]["��ͼ����"]=0;
            WAR.Person[WAR.CurID]["��ͼ"]=WarCalPersonPic(WAR.CurID);
			mytype=0;
        end

        if i==sounddelay then
            PlayWavAtk(JY.Wugong[wugong]["������Ч"]);
        end
        if i==fightdelay then
            PlayWavE(eft);
        end
		local pic=WAR.Person[WAR.CurID]["��ͼ"]/2;
		if fastdraw==1 then
			local rr=ClipRect(Cal_PicClip(0,0,oldpic,oldpic_type,0,0,pic,mytype));
			if rr ~=nil then
				lib.SetClip(rr.x1,rr.y1,rr.x2,rr.y2);
			end
		else
			lib.SetClip(0,0,0,0);
		end
		oldpic=pic;
		oldpic_type=mytype;

		local atkdelay=0;
		if i<fightdelay then   --ֻ��ʾ����
		
			atkdelay=0;
		    WarDrawMap(4,pic*2,mytype,-1);
			
			local hb=GetS(JY.SubScene,x0,y0,4);
			if CONFIG.Zoom==1 then
				hb=hb*2;
			end
			if i==1 then
				local myeft=WAR.Person[WAR.CurID]["��Ч����"]
				local sf=0
				for ii=0,myeft do
					sf=sf+CC.Effect[ii];
				end
				--lib.FreeSur(ssid);
				-----------------
				local sssid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
				--
				local fontsize=CC.Fontbig;
				local starty=fontsize;
				local endy;
				if CONFIG.Zoom==0 then
					starty=starty-18;
					endy=starty+fontsize*2;
				else
					starty=starty+20;
					endy=starty+fontsize*3;
				end
				local showtime=endy-starty+fontsize*(WAR.Person[WAR.CurID]["atk����"][0]-1);
				for ii=1,showtime do
					local yanshi=false
					if WAR.Person[WAR.CurID]["��Ч����"]~=-1 then--and  ii<CC.Effect[myeft] then
						lib.PicLoadCache(3,(sf-1-math.modf(CC.Effect[myeft]*(ii-1)/showtime))*2,CC.ScreenW/2,CC.ScreenH/2-hb,2,192);
						
							local stime=lib.GetTime();
							for j=1,WAR.Person[WAR.CurID]["atk����"][0] do
								local stry=starty+ii-(j-1)*fontsize;
								local strx;
								if between(stry,starty,endy) then
									stry=CC.ScreenH/2-stry;
									strx=CC.ScreenW/2-fontsize*string.len(WAR.Person[WAR.CurID]["atk����"][j][1])/4;
									DrawString(strx,stry,WAR.Person[WAR.CurID]["atk����"][j][1],WAR.Person[WAR.CurID]["atk����"][j][2],fontsize);
								end
							end
						--[[
						for iii=1,3 do
							local spstr=WAR.Person[WAR.CurID]["��Ч����"..iii];
							if type(spstr)=="string" then
								KungfuString(spstr,CC.ScreenW/2,CC.ScreenH/2,C_WHITE,CC.Fontbig,Font_Qiti,iii);
							end
						end
						]]--
						yanshi=true
					end
					for j = 1, WAR.Evade[0] do
						local wid=WAR.Evade[j];
						local theeft=WAR.Person[wid]["��Ч����"]
						if theeft~=-1 then--and ii<CC.Effect[theeft] then
							local dx=WAR.Person[wid]["����X"]-WAR.Person[WAR.CurID]["����X"]
							local dy=WAR.Person[wid]["����Y"]-WAR.Person[WAR.CurID]["����Y"]
							local rx=CC.XScale*(dx-dy)+CC.ScreenW/2;
							local ry=CC.YScale*(dx+dy)+CC.ScreenH/2;
							local seft=1+math.modf(CC.Effect[theeft]*(ii-1)/showtime);
							for k=0,WAR.Person[wid]["��Ч����"]-1 do
								seft=seft+CC.Effect[k];
							end
							local ehb=GetS(JY.SubScene,dx+x0,dy+y0,4)
							if CONFIG.Zoom==1 then
								ehb=ehb*2;
							end
							ry=ry-ehb
							lib.PicLoadCache(3,seft*2,rx,ry,2,192)
							for iii=1,3 do
								local spstr=WAR.Person[wid]["��Ч����"..iii];
								if type(spstr)=="string" then
									KungfuString(spstr,rx,ry,C_GOLD,CC.Fontbig,Font_Qiti,iii);
								end
							end	
							yanshi=true
						end	
					end
					if yanshi then
						getkey();
						lib.ShowSurface(0)
						lib.Delay(10)
						lib.LoadSur(sssid,0,0)
					end
				end
				WAR.Person[WAR.CurID]["��Ч����"]=-1;
				WAR.Person[WAR.CurID]["atk����"]={[0]=0,};
				for i=1,WAR.Evade[0] do
					local wwid=WAR.Evade[i];
					WAR.Person[wwid]["��ͼ"]=-1;
					WAR.Person[wwid]["��Ч����"]=-1;
					SetWarMap(WAR.Person[wwid]["����X"],WAR.Person[wwid]["����Y"],5,-1)
				end
				lib.FreeSur(sssid);
				------------------
			else
				--[[
				for ii=1,3 do
					local spstr=WAR.Person[WAR.CurID]["��Ч����"..ii];
					if type(spstr)=="string" then
						KungfuString(spstr,CC.ScreenW/2,CC.ScreenH/2,C_WHITE,CC.Fontbig,Font_Qiti,ii);
						atkdelay=30;
					end
				end
				]]--
			end
			ShowScreen();
			--lib.Delay(atkdelay);
		else		--ͬʱ��ʾ�书Ч��
            --starteft=starteft+1;            --�˴��ƺ���eft��һ�����������⣬Ӧ����10����Ϊ9����˼�1
			--
			
			--
			if fastdraw==1 then
				local clip1={};
				clip1=Cal_PicClip(WAR.EffectXY[1][1]-x0,WAR.EffectXY[1][2]-y0,oldeft,3,
										WAR.EffectXY[1][1]-x0,WAR.EffectXY[1][2]-y0,starteft,3);
				local clip2={};
				clip2=Cal_PicClip(WAR.EffectXY[2][1]-x0,WAR.EffectXY[2][2]-y0,oldeft,3,
										WAR.EffectXY[2][1]-x0,WAR.EffectXY[2][2]-y0,starteft,3);
				local clip=ClipRect(MergeRect(clip1,clip2));

				if clip ~=nil then
					local area=(clip.x2-clip.x1)*(clip.y2-clip.y1);          --������������
					if area <CC.ScreenW*CC.ScreenH/2 then        --����㹻С�����������Ρ�
						WarDrawMap(4,pic*2,mytype,starteft*2);
						lib.SetClip(clip.x1,clip.y1,clip.x2,clip.y2);
						WarDrawMap(4,pic*2,mytype,starteft*2);
					else    --���̫��ֱ���ػ�
						lib.SetClip(0,0,CC.ScreenW,CC.ScreenH);
						WarDrawMap(4,pic*2,mytype,starteft*2);
					end
				else
				    WarDrawMap(4,pic*2,mytype,starteft*2);
				end
			else
				lib.SetClip(0,0,0,0);
				WarDrawMap(4,pic*2,mytype,starteft*2);
			end
			starteft=starteft+1;
			oldeft=starteft;
		end
		--DrawStrBox(kfx,CC.Fontbig*3,kfname,C_WHITE,CC.Fontbig);
		ShowScreen(fastdraw);
        lib.SetClip(0,0,0,0);

		local tend=lib.GetTime();
    	if tend-tstart<atkdelay+CC.Frame then
            lib.Delay(atkdelay+CC.Frame-(tend-tstart));
			atkdelay=0;
	    end

    end

	lib.SetClip(0,0,0,0);
    WAR.Person[WAR.CurID]["��ͼ����"]=0;
    WAR.Person[WAR.CurID]["��ͼ"]=WarCalPersonPic(WAR.CurID);
    WarSetPerson();
    WarDrawMap(0);

    ShowScreen();
    lib.Delay(200);

    WarDrawMap(2);          --ȫ����ʾ��������
    ShowScreen();
    lib.Delay(200);

    WarDrawMap(0);
    ShowScreen();
	for ii=1,3 do
		WAR.Person[WAR.CurID]["��Ч����"..ii]=-1;
	end

	
	--��ʾ�ط���Ч
	--for x=0,63 do			--������Ĳ㣬�ͺ������Щ��ͻ����ʱ�Ȳ�����--���ˣ�����Ӧ�ò���ͻ��
	--	for y=0,63 do SetWarMap(x,y,4,0) end
	--end
	--local fanji=false
	--for i = 0, WAR.PersonNum-1 do
	--	if WAR.Person[i]["��Ч����"]>100 then fanji=true break end;
	--	if WAR.Person[i]["��Ч����"]~=-1 then SetWarMap(WAR.Person[i]["����X"],WAR.Person[i]["����Y"],4,1) end
	--end
	--if not fanji then
	local sssid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	for ii=1,40 do
		local yanshi=false
		for i = 0, WAR.PersonNum-1 do		
			local theeft=WAR.Person[i]["��Ч����"]
			if theeft~=-1 and ii<CC.Effect[theeft] then
				local dx=WAR.Person[i]["����X"]-WAR.Person[WAR.CurID]["����X"]
				local dy=WAR.Person[i]["����Y"]-WAR.Person[WAR.CurID]["����Y"]
				local rx=CC.XScale*(dx-dy)+CC.ScreenW/2;
				local ry=CC.YScale*(dx+dy)+CC.ScreenH/2;
				starteft=ii
				for i=0,WAR.Person[i]["��Ч����"]-1 do
					starteft=starteft+CC.Effect[i];
				end
				lib.LoadSur(sssid,0,0)
				local hb=GetS(JY.SubScene,dx+x0,dy+y0,4)
				if CONFIG.Zoom==1 then
					hb=hb*2;
				end
				ry=ry-hb
				lib.PicLoadCache(3,starteft*2,rx,ry,2,192)
				for iii=1,3 do
					local spstr=WAR.Person[i]["��Ч����"..iii];
					if type(spstr)=="string" then
						KungfuString(spstr,rx,ry,C_GOLD,CC.Fontbig,Font_Qiti,iii);
					end
				end
				--DrawString(0,0,tostring(WAR.Person[i]["��Ч����1"]).."|"..tostring(WAR.Person[i]["��Ч����2"]).."|"..tostring(WAR.Person[i]["��Ч����3"]),C_WHITE,16)
				--lib.ShowSurface(0)
				--lib.Delay(10)		
				yanshi=true
			end	
		end
		if yanshi then
			getkey();
			lib.ShowSurface(0)
			lib.Delay(70)
		end
	end
	lib.FreeSur(sssid);
	--end
	ShowWarString();
	for i=1,WAR.Evade[0] do
		WAR.Person[WAR.Evade[i]]["��ͼ"]=WarCalPersonPic(WAR.Evade[i]);
	end
	WAR.Evade={[0]=0,}
	for i = 0, WAR.PersonNum-1 do
		WAR.Person[i]["��Ч����"]=-1
		WAR.Person[i]["��Ч����1"]=-1
		WAR.Person[i]["��Ч����2"]=-1
		WAR.Person[i]["��Ч����3"]=-1
	end
	
    lib.SetClip(0,0,0,0);
    WarDrawMap(0);
    ShowScreen();
end

function ShowWarString()
    WarDrawMap(0);
    ShowScreen();
	lib.Delay(100);
	local x0=WAR.Person[WAR.CurID]["����X"];
	local y0=WAR.Person[WAR.CurID]["����Y"];
    local HitXY={};               --��¼���е���������
	local HitXYNum=0;
    for i = 0, WAR.PersonNum-1 do
	    local x1=WAR.Person[i]["����X"];
	    local y1=WAR.Person[i]["����Y"];
		if WAR.Person[i]["����"]==false then
 		    --if GetWarMap(x1,y1,4)>1 then
			if WAR.Person[i]["����"][0]>0 then
				SetWarMap(x1,y1,4,1);
				HitXY[HitXYNum]={
									x=x1,
									y=y1,
									str=WAR.Person[i]["����"],
								}
				HitXYNum=HitXYNum+1;
 		    end
		end
	end
	if HitXYNum>0 then
		local fontsize=CC.Fontsmall;
		local starty=fontsize;
		local endy;
		if CONFIG.Zoom==0 then
			starty=starty+12;
			endy=starty+fontsize*3;
		else
			starty=starty+50;
			endy=starty+fontsize*4;
		end
		for i=0,HitXYNum-1 do
			local dx=HitXY[i].x-x0;
			local dy=HitXY[i].y-y0;
			HitXY[i].x=CC.XScale*(dx-dy)+CC.ScreenW/2;
			HitXY[i].y=CC.YScale*(dx+dy)+CC.ScreenH/2;
		end
		local surid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
		for hight=starty,480 do
			local stime=lib.GetTime();
			lib.LoadSur(surid,0,0);
			local drawed=false;
			for i=0,HitXYNum-1 do
				for j=1,HitXY[i].str[0] do
					local stry=hight-(j-1)*fontsize;
					local strx;
					if between(stry,starty,endy) then
						drawed=true;
						stry=HitXY[i].y-stry;
						strx=HitXY[i].x-fontsize*string.len(HitXY[i].str[j][1])/4;
						DrawString(strx,stry,HitXY[i].str[j][1],HitXY[i].str[j][2],fontsize);
					end
				end
			end
			if drawed then
				getkey();
				ShowScreen();
				stime=200/fontsize-(lib.GetTime()-stime);
				if stime>0 then
					lib.Delay(stime);
				end
			else
				break;
			end
		end
		lib.FreeSur(surid);
	end
    for i=0,WAR.PersonNum-1 do
        WAR.Person[i]["����"]={[0]=0,};
    end
end


---�ö��˵�
function War_PoisonMenu()              ---�ö��˵�
    WAR.ShowHead=0;
    local r=War_ExecuteMenu(1);
	WAR.ShowHead=1;
	Cls();
	return r;
end

--��������ж�����
--pid ʹ���ˣ�
--emenyid  �ж���
function War_PoisonHurt(pid,emenyid)     --��������ж�����
    local v=math.modf((JY.Person[pid]["�ö�����"]-JY.Person[emenyid]["��������"])/4);
    if v<0 then
        v=0;
    end
    return AddPersonAttrib(emenyid,"�ж��̶�",v);
end

---�ⶾ�˵�
function War_DecPoisonMenu()          ---�ⶾ�˵�
    WAR.ShowHead=0;
    local r=War_ExecuteMenu(2);
	WAR.ShowHead=1;
	Cls();
	return r;
end

---ҽ�Ʋ˵�
function War_DoctorMenu()            ---ҽ�Ʋ˵�
    WAR.ShowHead=0;
    local r=War_ExecuteMenu(3);
	WAR.ShowHead=1;
	Cls();
	return r;
end

---ִ��ҽ�ƣ��ⶾ�ö�
---flag=1 �ö��� 2 �ⶾ��3 ҽ�� 4 ����
---thingid ������Ʒid
function War_ExecuteMenu(flag,thingid)            ---ִ��ҽ�ƣ��ⶾ�ö�����
    local pid=WAR.Person[WAR.CurID]["������"];
    local step;

    if flag==1 then
        step=math.modf(JY.Person[pid]["�ö�����"]/15)+1;         --�ö�����
    elseif flag==2 then
        step=math.modf(JY.Person[pid]["�ⶾ����"]/15)+1;         --�ⶾ����
    elseif flag==3 then
        step=math.modf(JY.Person[pid]["ҽ������"]/15)+1;         --ҽ�Ʋ���
    elseif flag==4 then
        step=math.modf(JY.Person[pid]["��������"]/15)+1;         --��������
    end

    War_CalMoveStep(WAR.CurID,step,1);

    local x1,y1=War_SelectMove();              --ѡ�񹥻�����

    if x1 ==nil then
        getkey();
		Cls();
        return 0;
    else
        return War_ExecuteMenu_Sub(x1,y1,flag,thingid);
    end
end


function War_ExecuteMenu_Sub(x1,y1,flag,thingid)     ---ִ��ҽ�ƣ��ⶾ�ö��������Ӻ������Զ�ҽ��Ҳ�ɵ���
    local pid=WAR.Person[WAR.CurID]["������"];
    local x0=WAR.Person[WAR.CurID]["����X"];
    local y0=WAR.Person[WAR.CurID]["����Y"];

    CleanWarMap(4,0);

	WAR.Person[WAR.CurID]["�˷���"]=War_Direct(x0,y0,x1,y1) or WAR.Person[WAR.CurID]["�˷���"]

	SetWarMap(x1,y1,4,1);

    local emeny=GetWarMap(x1,y1,2);
	if emeny>=0 then          --����
		 if flag==1 then
			 if WAR.Person[WAR.CurID]["�ҷ�"] ~= WAR.Person[emeny]["�ҷ�"] then       --�ǵ���
				 WAR.Person[emeny]["����"]=War_PoisonHurt(pid,WAR.Person[emeny]["������"])
				 SetWarMap(x1,y1,4,5);
  			     WAR.Effect=5;
			 end
		 elseif flag==2 then
			 if WAR.Person[WAR.CurID]["�ҷ�"] == WAR.Person[emeny]["�ҷ�"] then       --���ǵ���
				 WAR.Person[emeny]["����"]=ExecDecPoison(pid,WAR.Person[emeny]["������"])
				 SetWarMap(x1,y1,4,6);
  			     WAR.Effect=6;
			 end
		 elseif flag==3 then
			 if WAR.Person[WAR.CurID]["�ҷ�"] == WAR.Person[emeny]["�ҷ�"] then       --���ǵ���
				 WAR.Person[emeny]["����"]=ExecDoctor(pid,WAR.Person[emeny]["������"])
				 SetWarMap(x1,y1,4,4);
  			     WAR.Effect=4;
			 end
		 elseif flag==4 then
			 if WAR.Person[WAR.CurID]["�ҷ�"] ~= WAR.Person[emeny]["�ҷ�"] then       --�ǵ���
				 WAR.Person[emeny]["����"]=War_AnqiHurt(pid,WAR.Person[emeny]["������"],thingid)
				 SetWarMap(x1,y1,4,2);
  			     WAR.Effect=2;
			 end
		 end

	end

    WAR.EffectXY={};
	WAR.EffectXY[1]={x1,y1};
	WAR.EffectXY[2]={x1,y1};

	if flag==1 then
		War_ShowFight(pid,0,0,0,x1,y1,30);
	elseif flag==2 then
		War_ShowFight(pid,0,0,0,x1,y1,36);
	elseif flag==3 then
		War_ShowFight(pid,0,0,0,x1,y1,0);
	elseif flag==4 then
		if emeny>=0 then
			War_ShowFight(pid,0,-1,0,x1,y1,JY.Thing[thingid]["�����������"]);
		end
	end

	for i=0,WAR.PersonNum-1 do
		WAR.Person[i]["����"]=0;
	end
	if flag==4 then
		if emeny>=0 then
			instruct_32(thingid,-1);            --��Ʒ��������
			return 1;
		else
			return 0;                   --������գ������û�д�
		end
	else
		WAR.Person[WAR.CurID]["����"]=WAR.Person[WAR.CurID]["����"]+1;
		AddPersonAttrib(pid,"����",-2);
	end

	return 1;

end


--��Ʒ�˵�
function War_ThingMenu()            --ս����Ʒ�˵�
	if true then
		return;
	end
    WAR.ShowHead=0;
    local thing={};
    local thingnum={};

    for i = 0,CC.MyThingNum-1 do
        thing[i]=-1;
        thingnum[i]=0;
    end

    local num=0;
    for i = 0,CC.MyThingNum-1 do
        local id = JY.Base["��Ʒ" .. i+1];
        if id>=0 then
            if JY.Thing[id]["����"]==3 or JY.Thing[id]["����"]==4 then
                thing[num]=id;
                thingnum[num]=JY.Base["��Ʒ����" ..i+1];
                num=num+1;
            end
        end
    end

    local r=SelectThing(thing,thingnum);
	Cls();
	local rr=0;
    if r>=0 then
        if UseThing(r)==1 then
		    rr=1;
		end
    end
	WAR.ShowHead=1;
	Cls();
    return rr;
end

---ʹ�ð���
function War_UseAnqi(id)          ---ս��ʹ�ð���
    return War_ExecuteMenu(4,id);
end


function War_AnqiHurt(pid,emenyid,thingid)         --���㰵���˺�
    local num;
    if JY.Person[emenyid]["���˳̶�"]==0 then
        num=JY.Thing[thingid]["������"]/4-Rnd(5);
    elseif JY.Person[emenyid]["���˳̶�"]<=33 then
        num=JY.Thing[thingid]["������"]/3-Rnd(5);
    elseif JY.Person[emenyid]["���˳̶�"]<=66 then
        num=JY.Thing[thingid]["������"]/2-Rnd(5);
    else
        num=JY.Thing[thingid]["������"]/2-Rnd(5);
    end

    num=math.modf((num-JY.Person[pid]["��������"]*2)/3);
    AddPersonAttrib(emenyid,"���˳̶�",math.modf(-num/4));      --�˴���numΪ��ֵ

    local r=AddPersonAttrib(emenyid,"����",math.modf(num));

    if JY.Thing[thingid]["���ж��ⶾ"]>0 then
        num=math.modf((JY.Thing[thingid]["���ж��ⶾ"]+JY.Person[pid]["��������"])/2);
        num=num-JY.Person[emenyid]["��������"];
        num=limitX(num,0,CC.PersonAttribMax["�ö�����"]);
        AddPersonAttrib(emenyid,"�ж��̶�",num);
    end
    return r;
end

--��Ϣ
function War_RestMenu()           --��Ϣ
    local pid=WAR.Person[WAR.CurID]["������"];
	--AddShowString(WAR.CurID,"��Ϣ",C_WHITE);
    local v=3+Rnd(3);
    AddPersonAttrib(pid,"����",v);
	--AddShowString(WAR.CurID,string.format("���� +%d",v),M_Yellow);
    if JY.Person[pid]["����"]>30 then
        v=3+JY.Person[pid]["�������ֵ"]*(1+math.random()+Rnd(math.modf(JY.Person[pid]["����"]/10)-1))/100;
        AddPersonAttrib(pid,"����",v);
		--AddShowString(WAR.CurID,string.format("���� +%d",v),M_Pink);
        v=3+JY.Person[pid]["�������ֵ"]*(1+math.random()+Rnd(math.modf(JY.Person[pid]["����"]/10)-1))/100;
        AddPersonAttrib(pid,"����",v);
		--AddShowString(WAR.CurID,string.format("���� +%d",v),M_Blue);
    end
    return 1;
end


--�ȴ����ѵ�ǰս���˵�����β
function War_WaitMenu()            --�ȴ����ѵ�ǰս���˵�����β
	
	WAR.Person[WAR.CurID]["Time"]=WAR.Person[WAR.CurID]["Time"]+350
	return 1
end

function War_StatusMenu()          --ս������ʾ״̬
    WAR.ShowHead=0;
	PersonStatus(WAR.Person[WAR.CurID]["������"]);
	WAR.ShowHead=1;
end

function War_AutoMenu()           --�����Զ�ս��
    WAR.Person[WAR.CurID]["AI"]={1,0,0};
	WAR.ShowHead=0;
	Cls();
    War_Auto();
    return 1;
end
-------------------------------------------------------
-------------------��д���ֺ���---------------------
-------------------------------------------------------
function KfName(num)
	return JY.Wugong[num]["����"];
end

function KungfuString(str,x,y,color,size,font,place)					--������ʾ�书����Ч����
	local w,h=size,size+5;
	local len=string.len(str)/2
	x=x-len*w/2
	y=y-h*place
	lib.DrawStr(x,y,str,color,size,font,0,0)
	--lib.SetClip(x,y,x+len*w,y+h)
	--lib.ShowSurface(1)
	--lib.Delay(50)
end

--��Ч�ж�
--�������¼������
--#����ʱ�ж�
--#����ʱ���ж�
--[[
1 ��������˺�
2 ����˺��ٷֱ�
3 ����ʱ����״̬
4 ����ʱ����
5 ����ʱ��ȥ����
6 ����ʱ��Ѫ
7 ����ʱɱ����
8 ����ʱɱ����
9 ]]--
function atkmagic(pid,kfid,kflv,sp)
	--���ع���ʱ����Ч�������ֱ�Ϊ ����id,�����书id,�����书lv,���ڱ������ı�
	local p=JY.Person[pid];
	local id=WE_getwarid(pid);
	local wugong={
					{kfid,kflv},
					{p['�ڹ�'],1+div100(p['�ڹ�����'])},
					{p['�Ṧ'],1+div100(p['�Ṧ����'])},
					{p['�ؼ�'],1+div100(p['�ؼ�����'])},
				}
	for i=1,4 do
		if wugong[i][1]>0 then
			sp[i]=smagic_sub(pid,wugong[i][1],wugong[i][2],1,20);
			sp[i][5]=wugong[i][1]
		else
			sp[i]={-1,-1,-1};
		end
	end
	for i,v in pairs{4,2,3,1} do
		if sp[v][1]>0 then
			AddAtkString(WE_getwarid(pid),sp[v][3],sp[v][4] or C_WHITE);
			for ii,vv in pairs{2,3,1} do
				if WAR.Person[WAR.CurID]['��Ч����']==-1 then
					WAR.Person[WAR.CurID]['��Ч����']=JY.Wugong[sp[v][5]]["�书����&��Ч"];
				end
			
			--	if type(WAR.Person[WAR.CurID]['��Ч����'..vv])~='string' then
			--		WAR.Person[WAR.CurID]['��Ч����'..vv]=sp[v][3];
			--		WAR.Person[WAR.CurID]['��Ч����']=JY.Wugong[sp[v][4]]["�书����&��Ч"];
			--		break;
			--	end
			end
		end
	end
	local num=5;
	for i=1,4 do
		if sp[i][1]>0 then
			WAR.Person[id]["RP"]=limitX(WAR.Person[id]["RP"]-JY.Wugong[wugong[i][1]]["�Ƚ�"]*5,-100,200);
			local tsp=JY.Kungfu[wugong[i][1]]['����Ч��'];
			for ii=1,tsp[0] do
				local cv;
				if type(tsp[ii][3])=="function" then
					cv=tsp[ii][3](p,wugong[i][2]);
				else
					cv=tsp[ii][3];
				end
				if cv<0 then
					if tsp[ii][2]<=wugong[i][2] then
						if tsp[ii][5]==sp[i][3] then
							if type(tsp[ii][4])=="function" then
								sp[num]={tsp[ii][1],tsp[ii][4](p,wugong[i][2])};
							else
								sp[num]={tsp[ii][1],tsp[ii][4]};
							end
							num=num+1;
						end
					end
				end
			end
		end
	end
	--[[
	if sp[1][1]>0 then
		WAR.Person[WAR.CurID]['��Ч����1']=sp[1][3];
	end
	if sp[2][1]>0 then
		WAR.Person[WAR.CurID]['��Ч����2']=sp[2][3];
	end
	if sp[4][1]>0 then
		WAR.Person[WAR.CurID]['��Ч����3']=sp[4][3];
	end]]--
end
function smagic(pid,magicid,flag)
	flag=flag or 0;
	local p=JY.Person[pid];
	local power;
	local str;
	local wugong={
					{p['�ڹ�'],p['�ڹ�����']},
					{p['�Ṧ'],p['�Ṧ����']},
					{p['�ؼ�'],p['�ؼ�����']},
				}
	if p['�ڹ�']>0 then
		local dxx=math.abs(JY.Person[pid]["��������"]-JY.Wugong[p['�ڹ�']]["˼��"]);
		if dxx>1 and flag==0 then
			--wugong[1][2]=p['�ڹ�����']*(24-dxx)/24;
		end
	end
	if flag==1 then
		power=0;
	end
	for i=1,3 do
		if wugong[i][1]>0 then
			local tmp1,tmp2=smagic_sub(pid,wugong[i][1],1+math.modf(wugong[i][2]/100),magicid);
			if tmp1~=-1 and tmp2~=-1 then
				if flag==1 then
					power=power+tmp1;
					str=tmp2;
				else
					if power==nil or tmp1>power then
						power,str=tmp1,tmp2;
					end
				end
			end
		end
	end
	power=power or -1;
	return power,str;
end
function myRandom(k,luck_a,luck_b,luck_c)
	local t=1;
	local luck=0;
	if luck_b<luck_c then
		--luck=luck_a+luck_b-luck_c;
		luck_a=luck_a+luck_b-luck_c;
		luck_b=0;
	end
	if Rnd(100)<=luck_a then
		t=t+1;
	end
	if Rnd(100)<=luck_b then
		t=t+1;
	end
	for i=1,t do
		if Rnd(100)<=k then
			return true;
		end
	end
	return false;
end
function smagic_sub(pid,kf,kflv,magicid,magicid2)
	--magicid,�ж��ض���Ч,Ϊ�������ѡ��(1-10)
	--�����书id,lv,��Чid,���ط���Ч�����ͷ�������(-1��ʾ��)
	--���Ⱦ����Ƿ񷢶�,Ȼ���ڴ�ѡ��Χ�����
	local sp=JY.Kungfu[kf]['����Ч��'];
	local luck_a,luck_b,luck_c=0,0,0;
	local jl_add=0;
	local wid=WE_getwarid(pid);
	local RPMAX,RPMIN=false,false;
	if wid>=0 then
		if WAR.Person[wid]["RP"]>=100 then
			RPMAX=true;
		--elseif WAR.Person[wid]["RP"]<0 then
			--RPMIN=true;
		end
	end
	luck_a=JY.Person[pid]["��Ե"];
	if magicid<=40 then
		jl_add=smagic(pid,57,1);
		luck_a=luck_a+smagic(pid,68,1);
		if JY.Wugong[kf]["�书����"]<=5 then
			if JY.Wugong[kf]["����"]==1 then
				luck_b=JY.Person[pid]["����"];
				luck_c=WAR["����"];
			elseif JY.Wugong[kf]["����"]==2 then
				luck_b=JY.Person[pid]["����"];
				luck_c=WAR["����"];
			elseif JY.Wugong[kf]["����"]==3 then
				luck_b=JY.Person[pid]["��"];
				luck_c=WAR["��"];
			else
				luck_b=(JY.Person[pid]["����"]+JY.Person[pid]["����"]+JY.Person[pid]["��"])/3;
				luck_c=(WAR["����"]+WAR["����"]+WAR["��"])/3;
			end
		elseif JY.Wugong[kf]["�书����"]==7 then
			luck_b=JY.Person[pid]["����"];
			luck_c=WAR["����"];
		elseif JY.Wugong[kf]["�书����"]==8 then
			luck_b=JY.Person[pid]["��"];
			luck_c=WAR["��"];
		else
			luck_b=JY.Person[pid]["����"]/2;
		end
	end
	local spkind,sppower,spword=-1,-1,-1;
	local spcolor;
	if magicid2==nil then	--�ض�Ч���Ƿ񷢶���ȫ���ж�һ�Σ�����Ч���ߵ�
		for i=1,sp[0] do
			if sp[i][1]==magicid then
				if (sp[i][2]>=0 and kflv>=sp[i][2]) or (sp[i][2]<0 and kflv<-sp[i][2]) then
					local cv,cp;
					if type(sp[i][3])=="function" then
						cv=sp[i][3](JY.Person[pid],kflv);
					else
						cv=sp[i][3];
					end
					if type(sp[i][4])=="function" then
						cp=sp[i][4](JY.Person[pid],kflv);
					else
						cp=sp[i][4];
					end
					if magicid>80 then
						cp=cv*1000+cp;
					end
					if cp>sppower then
						if magicid>40 then
							spkind,sppower,spword,spcolor=sp[i][1],cp,sp[i][5],sp[i][6];
						else
							if RPMAX or ( (not RPMIN) and myRandom(cv+jl_add,luck_a,luck_b,luck_c)) then
								spkind,sppower,spword,spcolor=sp[i][1],cp,sp[i][5],sp[i][6];
							end
						end
					end
				end
			end
		end
		return sppower,spword,spcolor;
	else	--����Ч�������ж��Ƿ񷢶���Ȼ����ȫ���ɷ���Ч��(1-10)�����
		local gl={[0]=0};
		local glh=1;
		for i=1,sp[0] do
			gl[i]=gl[i-1];
			if between(sp[i][1],magicid,magicid2) then
				if (sp[i][2]>=0 and kflv>=sp[i][2]) or (sp[i][2]<0 and kflv<sp[i][2]) then
					local cv;
					if type(sp[i][3])=="function" then
						cv=sp[i][3](JY.Person[pid],kflv);
					else
						cv=sp[i][3];
					end
					cv=cv+jl_add;
					gl[i]=gl[i-1]+cv;
					glh=glh*(1-cv/100);
				end
			end
		end
		glh=100-100*glh;
		if RPMAX or ( (not RPMIN) and myRandom(glh,luck_a,luck_b,luck_c)) then	--����
			--�������巢����һ��
			local sel=gl[sp[0]]*Rnd(100)/100;
			for i=1,sp[0] do
				if sel>=gl[i-1] and sel<gl[i] then
					local cp;
					if type(sp[i][4])=="function" then
						cp=sp[i][4](JY.Person[pid],kflv);
					else
						cp=sp[i][4];
					end
					spkind,sppower,spword,spcolor=sp[i][1],cp,sp[i][5],sp[i][6];
					break;
				end
			end
		end
		return {spkind,sppower,spword,spcolor};
	end
end
	
function War_WugongHurt(id,emeny,magic,hurt,atk,kungfu)             --��д�����书�˺�����,pid����������,eid�ط�������
	local pid=WAR.Person[id]["������"]
	local eid=WAR.Person[emeny]["������"]
	
	local def=JY.Person[eid]["����"];
	local vaule;
	local defmagic={};
	local spkf={"�ڹ�","�ؼ�","�Ṧ"};
	
	--�ط���Ч�����ʽ���
	local sf_fdl=100;
	for i,v in pairs(magic) do
		if v[1]==12 then
			sf_fdl=sf_fdl-v[2];
		end
	end
	for i,v in pairs(spkf) do
		local kf={JY.Person[eid][v],JY.Person[eid][v..'����']};
		defmagic[i]={-1,-1,-1};
		if kf[1]>0 then
			if math.random(100)<=sf_fdl then
				--������Ч
				defmagic[i]=smagic_sub(eid,kf[1],1+div100(kf[2]),21,40);
			end
		end
	end
	WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]+600/(100-limitX(JY.Person[eid]["��Ե"]*JY.Person[eid]["�ȼ�"]/100,0,80)),-100,200);
	local num=4;
	for i=1,3 do
		if defmagic[i][1]>0 then
			--WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]-JY.Wugong[JY.Person[eid][spkf[i]]]["�Ƚ�"]*4,-100,200);
			local kf={JY.Person[eid][spkf[i]],1+math.modf(JY.Person[eid][spkf[i]..'����']/100)};
			if kf[1]>0 then
				local tsp=JY.Kungfu[kf[1]]['����Ч��'];
				for ii=1,tsp[0] do
					if type(tsp[ii][3])=="function" then
						tsp[ii][3]=tsp[ii][3](JY.Person[pid],kf[2]);
					end
					if type(tsp[ii][4])=="function" then
						tsp[ii][4]=tsp[ii][4](JY.Person[pid],kf[2]);
					end
					if tsp[ii][3]<0 then
						if tsp[ii][2]<=kf[2] then
							if tsp[ii][5]==defmagic[i][3] then
								defmagic[num]={tsp[ii][1],tsp[ii][4]};
								num=num+1;
							end
						end
					end
				end
			end
		end
	end
	local def_add1,def_dec1=0,0;
	for i=0,WAR.PersonNum-1 do
		if not WAR.Person[i]["����"] then
			if WAR.Person[i]["�ҷ�"]==WAR.Person[emeny]["�ҷ�"] then
				local cid=WAR.Person[i]["������"];
				local v=smagic(cid,92,1);
				local len=math.modf(v/1000);
				local power=v-len*1000;
				if math.abs(WAR.Person[i]["����X"]-WAR.Person[emeny]["����X"])+math.abs(WAR.Person[i]["����Y"]-WAR.Person[emeny]["����Y"])<=len then
					if power>def_add1 then
						def_add1=power;
					end
				end
			else
				local cid=WAR.Person[i]["������"];
				local v=smagic(cid,82,1);
				local len=math.modf(v/1000);
				local power=v-len*1000;
				if math.abs(WAR.Person[i]["����X"]-WAR.Person[emeny]["����X"])+math.abs(WAR.Person[i]["����Y"]-WAR.Person[emeny]["����Y"])<=len then
					if power>def_dec1 then
						def_dec1=power;
					end
				end
			end
		end
	end
	def=GetAttrib(eid,"����")
	def=math.modf(def*(100+def_add1-def_dec1)/100);
	if def<0 then
		def=0;
	end
	--lib.Debug(string.format("hurt=%d,atk=%d,def=%d",hurt,atk,def))
	--def=def+100;
	--lib.Debug(JY.Person[pid]["����"]..':'..hurt..'|'..atk..','..def)
	
	--��ת
	for i,v in pairs(defmagic) do
		if v[1]==24 then
			if WAR.Person[emeny]["�����书"]~=9999 then					
				WAR.Person[emeny]["��Ч����"]=JY.Wugong[JY.Person[eid][spkf[i]]]["�书����&��Ч"];
				WAR.Person[emeny]["��Ч����"..i]=v[3];
				WAR.Person[emeny]["�����书"]=v[2];
				if i<4 then
					WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]-25,-100,200);
				end
			end
		end
	end
	--������������ܣ���ת�������Чȫ����Ч
	for i,v in pairs(defmagic) do
		if v[1]==27 then
			if i<=3 then
				WAR.Person[emeny]["��Ч����"]=JY.Wugong[JY.Person[eid][spkf[i]]]["�书����&��Ч"];
				WAR.Person[emeny]["��Ч����"..i]=v[3];
			end
			WAR.Evade[0]=WAR.Evade[0]+1;
			WAR.Evade[WAR.Evade[0]]=emeny;
			if i<4 then
				WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]-20,-100,200);
			end
			return 0;
		end
	end
	--��������˵ֿ���Ч���򹥷���Ч��Ч
	for i,v in pairs(defmagic) do
		if v[1]==23 then
			if i<=3 then
				WAR.Person[emeny]["��Ч����"]=JY.Wugong[JY.Person[eid][spkf[i]]]["�书����&��Ч"];
				WAR.Person[emeny]["��Ч����"..i]=v[3];
			end
			if i<4 then
				WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]-15,-100,200);
			end
			--[[
			magic={
					{-1,-1,-1},
					{-1,-1,-1},
					{-1,-1,-1},
					{-1,-1,-1},
				}
				]]--
			for ii,vv in pairs(magic) do
				if vv[2]>0 then
					vv[2]=0;
				end
			end
		end
	end
	--����
	for i,v in pairs(magic) do
		if v[1]==3 then
			def=def*(100-v[2])/100;
		end
	end
	--������Ч�ӷ�
	for i,v in pairs(defmagic) do
		if v[1]==29 then
			if i<=3 then
				WAR.Person[emeny]["��Ч����"]=JY.Wugong[JY.Person[eid][spkf[i]]]["�书����&��Ч"];
				WAR.Person[emeny]["��Ч����"..i]=v[3];
			end
			def=def+v[2];
			if i<4 then
				WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]-8,-100,200);
			end
		end
	end
	for i,v in pairs(defmagic) do
		if v[1]==30 then
			if i<=3 then
				WAR.Person[emeny]["��Ч����"]=JY.Wugong[JY.Person[eid][spkf[i]]]["�书����&��Ч"];
				WAR.Person[emeny]["��Ч����"..i]=v[3];
			end
			def=def*(100+v[2])/100;
			if i<4 then
				WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]-8,-100,200);
			end
		end
	end
	
	--����
	for i,v in pairs(defmagic) do
		if v[1]==26 then
			if i<=3 then
				WAR.Person[emeny]["��Ч����"]=JY.Wugong[JY.Person[eid][spkf[i]]]["�书����&��Ч"];
				WAR.Person[emeny]["��Ч����"..i]=v[3];
			end
			SetWarMap(WAR.Person[id]["����X"],WAR.Person[id]["����Y"],4,2);
			vaule=AddPersonAttrib(pid,"����",-v[2])
			if vaule~=0 then
				AddShowString(id,string.format("���� %d",vaule),M_Wheat);
			end
			if i<4 then
				WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]-15,-100,200);
			end
		end
	end
	
	
	--����-����
	local dmg=0;
	for i,v in pairs(magic) do
		if v[1]==1 then
			dmg=dmg+v[2];
		end
	end
	for i,v in pairs(defmagic) do
		if v[1]==21 then
			if i<=3 then
				WAR.Person[emeny]["��Ч����"]=JY.Wugong[JY.Person[eid][spkf[i]]]["�书����&��Ч"];
				WAR.Person[emeny]["��Ч����"..i]=v[3];
			end
			dmg=dmg-v[2];
			if i<4 then
				WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]-10,-100,200);
			end
		end
	end
	--�ش�-ж��
	local per=100;
	for i,v in pairs(magic) do
		if v[1]==2 then
			per=per+v[2];
		end
	end
	for i,v in pairs(defmagic) do
		if v[1]==22 then
			if i<=3 then
				WAR.Person[emeny]["��Ч����"]=JY.Wugong[JY.Person[eid][spkf[i]]]["�书����&��Ч"];
				WAR.Person[emeny]["��Ч����"..i]=v[3];
			end
			if i<4 then
				WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]-12,-100,200);
			end
			per=per-v[2];
		end
	end
	--�������Բ���
	local sxc=0
	if JY.Wugong[kungfu]["����"]==1 then
		sxc=(JY.Person[pid]["����"]-JY.Person[eid]["����"])
	elseif JY.Wugong[kungfu]["����"]==2 then
		sxc=(JY.Person[pid]["����"]-JY.Person[eid]["����"])
	elseif JY.Wugong[kungfu]["����"]==3 then
		sxc=(JY.Person[pid]["��"]-JY.Person[eid]["��"])
	elseif JY.Wugong[kungfu]["����"]==4 then
		sxc=(JY.Person[pid]["����"]-JY.Person[eid]["����"]+JY.Person[pid]["����"]-JY.Person[eid]["����"]+JY.Person[pid]["��"]-JY.Person[eid]["��"])/3
	end
	if sxc>0 then
		per=per+sxc*3/4;
	elseif sxc<0 then
		per=per+sxc/2;
	end
	if per<10 then
		per=10;
	end
	--��������hurt
	if WAR.Person[emeny]["�м�"]>0 and WAR.Person[emeny]["�м�"]<6 then
		local zj=JY.Person[eid]["�⹦"..WAR.Person[emeny]["�м�"]];
		local zjlv=math.modf(JY.Person[eid]["�⹦����"..WAR.Person[emeny]["�м�"]]/100)+1;
		if zj>0 then
			hurt=hurt-JY.Wugong[zj]["��"]*zjlv;
		end
	end
	if hurt<10 then
		hurt=10;
	end
	--lib.Debug(string.format("HURT:%d,per:%d,atk:%d,def:%d",hurt,per,atk,def));
	hurt=hurt*per/100+dmg+limitX((atk-def)*0.7,-def/5,atk/4);
	hurt=hurt*atk/(atk+def);
	--lib.Debug("F:"..hurt)
	--[[
	if atk-def>0 then
		hurt=hurt*(0.5+limitX((atk-def)/(200+def/2),0,0.4));
	else
		hurt=hurt*(0.5-limitX((def-atk)/(400+atk),0,0.3));
	end
	]]--
	--���Ǿ�������
	
	local offset=math.abs(WAR.Person[WAR.CurID]["����X"]-WAR.Person[emeny]["����X"])+
                 math.abs(WAR.Person[WAR.CurID]["����Y"]-WAR.Person[emeny]["����Y"]);

    if offset <10 then
        hurt=hurt*(100-(offset-1)*3)/100;
    else
        hurt=hurt*2/3;
    end
	
	hurt=hurt*(1000+Rnd(100)-Rnd(100))/1000+(Rnd(10)-Rnd(10));
	hurt=math.modf(hurt);
	--[[
	local adf=JY.Person[pid]["����"]-JY.Person[eid]["����"];
	if adf>0 then
		hurt=hurt+JY.Person[pid]["����"]*limitX(adf/12,0,1)+Rnd(10);
	elseif adf<0 then
		hurt=hurt-JY.Person[pid]["����"]*limitX(-adf/12,0,1)-Rnd(10);
	end
	]]--
	--����
	for i,v in pairs(defmagic) do
		if v[1]==25 then
			if i<=3 then
				WAR.Person[emeny]["��Ч����"]=JY.Wugong[JY.Person[eid][spkf[i]][1]]["�书����&��Ч"];
				WAR.Person[emeny]["��Ч����"..i]=v[3];
			end
			SetWarMap(WAR.Person[id]["����X"],WAR.Person[id]["����Y"],4,2);
			local selfhurt=AddPersonAttrib(pid,"����",-math.modf(hurt*v[2]/100));
			hurt=hurt+selfhurt;
			AddShowString(id,string.format("���� %d",selfhurt),M_Wheat);
			if i<4 then
				WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]-15,-100,200);
			end
		end
	end
    if hurt<10 then
        hurt=Rnd(10)+10;
    end
    hurt=-AddPersonAttrib(eid,"����",-hurt);
	
	--����
	for i,v in pairs(magic) do
		if v[1]==4 then
			local xinei=math.modf(hurt*v[2]/100);
			vaule=AddPersonAttrib(eid,"����",-xinei);
			if vaule~=0 then
				AddShowString(emeny,string.format("���� %d",vaule),M_Indigo);
			end
		end
	end
	--����
	for i,v in pairs(magic) do
		if v[1]==5 then
			local xinei=math.modf(hurt*v[2]/100);
			xinei=-AddPersonAttrib(eid,"����",-xinei);
			AddShowString(emeny,string.format("���� -%d",xinei),M_Indigo);
			vaule=AddPersonAttrib(pid,"����",xinei);
			if vaule~=0 then
				AddShowString(id,string.format("���� +%d",vaule),M_Blue);
			end
		end
	end
	--��Ѫ
	for i,v in pairs(magic) do
		if v[1]==6 then
			local xixue=math.modf(hurt*v[2]/100);
			vaule=AddPersonAttrib(pid,"����",xixue);
			if vaule~=0 then
				AddShowString(id,string.format("��Ѫ +%d",vaule),M_Pink);
			end
		end
	end
	--й��
	WAR.Person[emeny]["TimeAdd"]=0;
	for i,v in pairs(magic) do
		if v[1]==7 then
			WAR.Person[emeny]["TimeAdd"]=WAR.Person[emeny]["TimeAdd"]-v[2];
			AddShowString(emeny,string.format("���� -%d",v[2]),M_Gray);
		end
	end
	for i,v in pairs(magic) do
		if v[1]==10 then
			WAR.Person[emeny]["TimeAdd"]=WAR.Person[emeny]["TimeAdd"]-math.modf(hurt*v[2]/100);
			AddShowString(emeny,string.format("���� -%d",math.modf(hurt*v[2]/100)),M_Gray);
		end
	end
	--����
	for i,v in pairs(magic) do
		if v[1]==8 then
			vaule=AddPersonAttrib(eid,"����",-v[2]);
			if vaule~=0 then
				AddShowString(emeny,string.format("���� %d",vaule),M_Yellow);
			end
		end
	end
	--�쳣״̬
	local kangmo=smagic(eid,57,1);
	for i,v in pairs(magic) do
		if v[1]==9 then
			local kind,power;
			kind=math.modf(v[2]/100);
			power=v[2]%100;
			power=math.modf(power*(100-kangmo)/100);
			if power==0 then
				power=100;
			end
			if kind==1 and smagic(eid,71)<0 then
				if JY.Person[eid]["�ж�"]<power*2 then
					power=math.modf(power*(120-JY.Person[eid]["�ж�"])/200);
				else
					power=0;
				end
				vaule=AddPersonAttrib(eid,"�ж�",power);
				if vaule~=0 then
					AddShowString(emeny,string.format("�ж� +%d",vaule),M_Green);
				end
			elseif kind==2 and smagic(eid,72)<0 then
				if JY.Person[eid]["����"]<power*2 then
					power=math.modf(power*(120-JY.Person[eid]["����"])/200);
				else
					power=0;
				end
				vaule=AddPersonAttrib(eid,"����",power);
				if vaule~=0 then
					AddShowString(emeny,string.format("���� +%d",vaule),M_DarkRed);
				end
			elseif kind==3 and smagic(eid,73)<0 then
				if JY.Person[eid]["��Ѫ"]<power*2 then
					power=math.modf(power*(120-JY.Person[eid]["��Ѫ"])/200);
				else
					power=0;
				end
				vaule=AddPersonAttrib(eid,"��Ѫ",power);
				if vaule~=0 then
					AddShowString(emeny,string.format("��Ѫ +%d",vaule),M_Red);
				end
			elseif kind==11 and smagic(eid,81)<0 then
				if WAR.Person[emeny]["����"]<power*2 then
					power=math.modf(power*(120-WAR.Person[emeny]["����"])/200);
				else
					power=0;
				end
				vaule=WAR.Person[emeny]["����"];
				WAR.Person[emeny]["����"]=limitX(vaule+power,0,100);
				vaule=WAR.Person[emeny]["����"]-vaule;
				if vaule~=0 then
					AddShowString(emeny,string.format("���� +%d",vaule),M_Sienna);
				end
			elseif kind==12 and smagic(eid,82)<0 then
				if WAR.Person[emeny]["��Ѩ"]<power*2 then
					power=math.modf(power*(120-WAR.Person[emeny]["��Ѩ"])/200);
				else
					power=0;
				end
				vaule=WAR.Person[emeny]["��Ѩ"];
				WAR.Person[emeny]["��Ѩ"]=limitX(vaule+power,0,100);
				vaule=WAR.Person[emeny]["��Ѩ"]-vaule;
				if vaule~=0 then
					AddShowString(emeny,string.format("��Ѩ +%d",vaule),M_DimGray);
				end
			elseif kind==13 and smagic(eid,83)<0 then
				if WAR.Person[emeny]["����"]<power*2 then
					power=math.modf(power*(120-WAR.Person[emeny]["����"])/200);
				else
					power=0;
				end
				vaule=WAR.Person[emeny]["����"];
				WAR.Person[emeny]["����"]=limitX(vaule+power,0,100);
				vaule=WAR.Person[emeny]["����"]-vaule;
				if vaule~=0 then
					AddShowString(emeny,string.format("���� +%d",vaule),M_SlateGray);
				end
			elseif kind==14 and smagic(eid,84)<0 then
				if WAR.Person[emeny]["���"]<power*2 then
					power=math.modf(power*(120-WAR.Person[emeny]["���"])/200);
				else
					power=0;
				end
				vaule=WAR.Person[emeny]["���"];
				WAR.Person[emeny]["���"]=limitX(vaule+power,0,100);
				vaule=WAR.Person[emeny]["���"]-vaule;
				if vaule~=0 then
					AddShowString(emeny,string.format("��� +%d",vaule),M_MediumTurquoise);
				end
			end
		end
	end
    WAR.Person[WAR.CurID]["����"]=WAR.Person[WAR.CurID]["����"]+math.modf(hurt/5)+JY.Person[eid]["�ȼ�"];

	WAR.Person[emeny]["RP"]=limitX(WAR.Person[emeny]["RP"]+hurt/20,-100,200);
    if JY.Person[eid]["����"]<=0 then                 --�������˻�ö��⾭��
		--tmp1,tmp2=smagic(eid,defnei,defneilv,8)
		--if tmp1==0 then									
			JY.Person[eid]["����"]=0;
			local addexp=JY.Person[eid]["�ȼ�"]^2/3+JY.Person[eid]["�ȼ�"]*5;
			local lvdiff=JY.Person[pid]["�ȼ�"]-JY.Person[eid]["�ȼ�"]
			lvdiff=limitX(lvdiff,-12,6);
			if lvdiff>0 then
				addexp=addexp*(7-lvdiff)/7;
			else
				addexp=addexp*(12-lvdiff)/12;
			end
			addexp=math.modf(addexp+JY.Person[eid]["�ȼ�"]+50)+Rnd(10);
			WAR.Person[WAR.CurID]["����"]=WAR.Person[WAR.CurID]["����"]+addexp;
			WAR.Person[emeny]["��Ч����"]=-1
			WAR.Person[emeny]["��Ч����1"]=-1
			WAR.Person[emeny]["��Ч����2"]=-1
			WAR.Person[emeny]["��Ч����3"]=-1
			WAR.Person[emeny]["�����书"]=-1;
		--[[else														--���ָ���
			JY.Person[eid]["����"]=math.modf(JY.Person[eid]["�������ֵ"]*tmp2/100);
			WAR.Person[emeny]["��Ч����"]=JY.Wugong[defnei]["�书����&��Ч"]
			WAR.Person[emeny]["�����书"]=-1;
			WAR.Person[emeny]["��Ч����1"]=-1
			WAR.Person[emeny]["��Ч����2"]=-1
			WAR.Person[emeny]["��Ч����3"]=tmp2
			
		end]]--
    end
	AddShowString(emeny,string.format("���� -%d",hurt),C_WHITE);
    --[[
	��Ѫ�Ķ��ǳ�ɫ
	�������Ķ�����ɫ
	�������Ķ�����ɫ
	�ж� ī��
	��Ѫ ���
	���� ��ɫ
	��� ��ɫ
	���� ��ɫ
	��Ѩ ��ɫ
	
	]]--
end

function AddShowString(id,str,color)
	local tid=WAR.Person[id]["����"][0];
	tid=tid+1;
	WAR.Person[id]["����"][0]=tid;
	WAR.Person[id]["����"][tid]={str,color};
end
function AddAtkString(id,str,color)
	local tid=WAR.Person[id]["atk����"][0];
	tid=tid+1;
	WAR.Person[id]["atk����"][0]=tid;
	WAR.Person[id]["atk����"][tid]={str,color};
end

--�����Ṧ
function GetSpeed(pid)
	local speed=JY.Person[pid]["��"];
	speed=GetAttrib(pid,"��");
	return speed;
end

function GetLv(pid,id)
	local kfnum=JY.Person[pid]["�⹦"..id];
	if kfnum<=0 then
		return 0;
	end
	local lv=1+math.modf(JY.Person[pid]["�⹦����"..id]/100);
	for i=1,5 do
		local kfid,kfexp=JY.Person[pid]["�⹦"..i],JY.Person[pid]["�⹦����"..i];
		if kfid>0 then
			for j=1,JY.Kungfu[kfid]["����书"][0] do
				if kfnum==JY.Kungfu[kfid]["����书"][j][1] then
					lv=lv+JY.Kungfu[kfid]["����书"][j][2]*(1+math.modf(kfexp/100))/10;
					break;
				end
			end
		end
	end
	for i,v in pairs({"�ڹ�","�Ṧ","�ؼ�"}) do
		local kfid,kfexp=JY.Person[pid][v],JY.Person[pid][v.."����"];
		if kfid>0 then
			for j=1,JY.Kungfu[kfid]["����书"][0] do
				if kfnum==JY.Kungfu[kfid]["����书"][j][1] then
					lv=lv+JY.Kungfu[kfid]["����书"][j][2]*(1+math.modf(kfexp/100))/10;
					break;
				end
			end
		end
	end
	lv=math.modf(lv);
	return lv;
end
function GetAtk(pid,kfnum,lv)							--���ع���
	--local num=GetAtkKungfu(pid)
	--�����˺�
	lv=limitX(lv,1,10);
	--�书֮����ϼ��˺�
	--ֻ��Ҫ�书�����и��书����
	for i=1,5 do
		local kfid,kfexp=JY.Person[pid]["�⹦"..i],JY.Person[pid]["�⹦����"..i];
		if kfid>0 then
			for j=1,JY.Kungfu[kfid]["����书"][0] do
				if kfnum==JY.Kungfu[kfid]["����书"][j][1] then
					lv=lv+JY.Kungfu[kfid]["����书"][j][2]*(1+math.modf(kfexp/100))/10;
					break;
				end
			end
		end
	end
	for i,v in pairs({"�ڹ�","�Ṧ","�ؼ�"}) do
		local kfid,kfexp=JY.Person[pid][v],JY.Person[pid][v.."����"];
		if kfid>0 then
			for j=1,JY.Kungfu[kfid]["����书"][0] do
				if kfnum==JY.Kungfu[kfid]["����书"][j][1] then
					lv=lv+JY.Kungfu[kfid]["����书"][j][2]*(1+math.modf(kfexp/100))/10;
					break;
				end
			end
		end
	end
	lv=math.modf(lv);
	PUSH(lv);
			for i=lv,0,-1 do
				if JY.Person[pid]["����"]>=JY.Wugong[kfnum]["������������"]*i then
					lv=i;
					break;
				end
			end
	if lv<1 then
		lv=1;
	end
	local hurt=JY.Wugong[kfnum]["�˺�"]*math.min(10,lv)+JY.Wugong[kfnum]["�˺�����"]*math.max(lv-10,0);
	hurt=math.modf(hurt);
	--�ڹ��书���
	local ng,nglv=JY.Person[pid]["�ڹ�"],1+div100(JY.Person[pid]["�ڹ�����"]);
	if ng>0 then
		local dxx=math.abs(JY.Wugong[kfnum]["˼��"]-JY.Wugong[ng]["˼��"]);
		dxx=JY.Wugong[ng]["�˺�"]--*(1-(dxx/JY.Wugong[ng]["�˺�����"])^2);
		if dxx>0 then
			hurt=hurt+math.modf(dxx*math.min(lv,nglv));
		end
	end
	local atk=JY.Person[pid]["����"];
	
	--�书������ϼ��˺�
	
	--�����ӹ���
	
	
	
	--���㹥����
	atk=GetAttrib(pid,"����");
	local atk_add,atk_dec=0,0;
	for i=0,WAR.PersonNum-1 do
		if not WAR.Person[i]["����"] then
			if WAR.Person[i]["�ҷ�"]==WAR.Person[WAR.CurID]["�ҷ�"] then
				local cid=WAR.Person[i]["������"];
				local v=smagic(cid,81,1);
				local len=math.modf(v/1000);
				local power=v-len*1000;
				if math.abs(WAR.Person[i]["����X"]-WAR.Person[WAR.CurID]["����X"])+math.abs(WAR.Person[i]["����Y"]-WAR.Person[WAR.CurID]["����Y"])<=len then
					if power>atk_add then
						atk_add=power;
					end
				end
			else
				local cid=WAR.Person[i]["������"];
				local v=smagic(cid,91,1);
				local len=math.modf(v/1000);
				local power=v-len*1000;
				if math.abs(WAR.Person[i]["����X"]-WAR.Person[WAR.CurID]["����X"])+math.abs(WAR.Person[i]["����Y"]-WAR.Person[WAR.CurID]["����Y"])<=len then
					if power>atk_dec then
						atk_dec=power;
					end
				end
			end
		end
	end
	atk=math.modf(atk*(100+atk_add-atk_dec)/100);
	lv=POP();
	return hurt,atk,lv;
end

function GetDef(pid)							--���ط���
	--local num=GetAtkKungfu(pid)
	--����������
	--local def=JY.Wugong[JY.Person[pid]["�书"..num]]["����"]*(div100(JY.Person[pid]["�书"..num])+1)
	local def=0
	for i=6,8 do
		local num=0
		if i==6 then
			num=JY.Person[pid]["�ڹ�"] or 0
		elseif i==7 then
			num=JY.Person[pid]["�Ṧ"] or 0
		elseif i==8 then
			num=JY.Person[pid]["�ؼ�"] or 0
		end
		if num>0 and num<=CC.Kungfunum then
			def=def+JY.Wugong[JY.Person[pid]["�书"][num][1]]["����"]*(div100(JY.Person[pid]["�书"][num][2])+1)
		end
	end
	--���·�����ʽ����ʡ�ԣ���Ϊ�����ǻ��ڹ������书װ���˶��Ե�
	--û�������ΰ��������
	--���߿��Կ������һ�����书...
	
	--�书֮����ϼӷ���
	
	--�书�ڹ���ϼӷ���
	
	--���߼ӷ���
	
	--�������Զ�����߷�����
	
	return def;
	
end

function WarDrawAtt(x,y,fanwei,flag,x0,y0,atk)
	x0=x0 or WAR.Person[WAR.CurID]["����X"];
	y0=y0 or WAR.Person[WAR.CurID]["����Y"];
	local kind=fanwei[1]
	local len1=fanwei[2]
	local len2=fanwei[3]
	local len3=fanwei[4]
	local len4=fanwei[5]
	local xy={}
	local num=0
	
	if kind==0 then		--����
		num=1
		xy[1]={x,y}				
	elseif kind==1 then					--������
		len1=len1 or 0
		len2=len2 or 0
		num=num+1
		xy[num]={x,y}
		for i=1,len1 do
			xy[num+1]={x+i,y}
			xy[num+2]={x-i,y}
			xy[num+3]={x,y+i}
			xy[num+4]={x,y-i}
			num=num+4
		end
		for i=1,len2 do
			xy[num+1]={x+i,y+i}
			xy[num+2]={x-i,y-i}
			xy[num+3]={x-i,y+i}
			xy[num+4]={x+i,y-i}
			num=num+4		
		end			
	elseif kind==2 then					--��������
		for tx=x-len1,x+len1 do			--��������о��е��˷ѣ�1/2�ĵ㶼�ǲ�����Ҫ���
			for ty=y-len1,y+len1 do
				if math.abs(tx-x)+math.abs(ty-y)>len1 then
				
				else
					num=num+1
					xy[num]={tx,ty}
				end
			end
		end			
	elseif kind==3 then					--���㷽��
		len2=len2 or len1
		local dx,dy=math.abs(x-x0),math.abs(y-y0)
		if dx>dy then len1,len2=len2,len1 end
		for tx=x-len1,x+len1 do
			for ty=y-len2,y+len2 do
				num=num+1
				xy[num]={tx,ty}
			end
		end	
	elseif kind==5 then					--��ʮ��
		len1=len1 or 0
		len2=len2 or 0
		num=num+1
		xy[num]={x,y}
		for i=1,len1 do
			xy[num+1]={x+i,y}
			xy[num+2]={x-i,y}
			xy[num+3]={x,y+i}
			xy[num+4]={x,y-i}
			num=num+4
		end
		if len2>0 then
			xy[num+1]={x+1,y+1}
			xy[num+2]={x+1,y-1}
			xy[num+3]={x-1,y+1}
			xy[num+4]={x-1,y-1}
			num=num+4
		end
		for i=2,len2 do
			xy[num+1]={x+i,y+1}
			xy[num+2]={x-i,y-1}
			xy[num+3]={x-i,y+1}
			xy[num+4]={x+i,y-1}
			xy[num+5]={x+1,y+i}
			xy[num+6]={x-1,y-i}
			xy[num+7]={x-1,y+i}
			xy[num+8]={x+1,y-i}
			num=num+8		
		end	
	elseif kind==6 then					--���㾮
		len2=len2 or len1
		xy[1]={x+1,y}
		xy[2]={x-1,y}
		xy[3]={x,y+1}
		xy[4]={x,y-1}
		num=num+4
		if len1>0 or len2>0 then
			xy[5]={x+1,y+1}
			xy[6]={x+1,y-1}
			xy[7]={x-1,y+1}
			xy[8]={x-1,y-1}
			num=num+4
			for i=2,len1 do
				xy[num+1]={x+i,y+1}
				xy[num+2]={x-i,y+1}
				xy[num+3]={x+i,y-1}
				xy[num+4]={x-i,y-1}
				num=num+4
			end
			for i=2,len2 do
				xy[num+1]={x+1,y+i}
				xy[num+2]={x+1,y-i}
				xy[num+3]={x-1,y+i}
				xy[num+4]={x-1,y-i}
				num=num+4
			end
		end
	elseif kind==7 then					--������
		len2=len2 or len1
		if len1==0 then
			for i=y-len2,y+len2 do
				num=num+1
				xy[num]={x,i}
			end
		elseif len2==0 then
			for i=x-len1,x+len1 do
				num=num+1
				xy[num]={i,y}
			end
		else
			for i=x-len1,x+len1 do
				num=num+1
				xy[num]={i,y}
				num=num+1
				xy[num]={i,y+len2}
				num=num+1
				xy[num]={i,y-len2}
			end
			for i=1,len2-1 do
				xy[num+1]={x,y+i}
				xy[num+2]={x,y-i}
				xy[num+3]={x-len1,y+i}
				xy[num+4]={x-len1,y-i}
				xy[num+5]={x+len1,y+i}
				xy[num+6]={x+len1,y-i}
				num=num+6
			end
		end
	elseif kind==8 then					--����d
		xy[1]={x,y}
		num=1
		for i=1,len1 do
			xy[num+1]={x+i,y}
			xy[num+2]={x-i,y}
			xy[num+3]={x,y+i}
			xy[num+4]={x,y-i}
			xy[num+5]={x+i,y+len1}
			xy[num+6]={x-i,y-len1}
			xy[num+7]={x+len1,y-i}
			xy[num+8]={x-len1,y+i}
			num=num+8
		end
	elseif kind==9 then					--����e
		xy[1]={x,y}
		num=1
		for i=1,len1 do
			xy[num+1]={x+i,y}
			xy[num+2]={x-i,y}
			xy[num+3]={x,y+i}
			xy[num+4]={x,y-i}
			xy[num+5]={x-i,y+len1}
			xy[num+6]={x+i,y-len1}
			xy[num+7]={x+len1,y+i}
			xy[num+8]={x-len1,y-i}
			num=num+8
		end
	elseif x==x0 and y==y0 then
		return 0
	elseif kind==10 then				--������
		len2=len2 or 0
		len3=len3 or 0
		len4=len4 or 0
		local fx,fy=x-x0,y-y0
		if fx>0 then fx=1
		elseif fx<0 then fx=-1 end
		if fy>0 then fy=1
		elseif fy<0 then fy=-1 end
		local dx1,dy1,dx2,dy2=-fy,fx,fy,-fx
	--	if fx~=0 and fy~=0 then
			dx1=-(dx1+fx)/2
			dx2=-(dx2+fx)/2
			dy1=-(dy1+fy)/2
			dy2=-(dy2+fy)/2
		if dx1>0 then dx1=1
		elseif dx1<0 then dx1=-1 end
		if dx2>0 then dx2=1
		elseif dx2<0 then dx2=-1 end
		if dy1>0 then dy1=1
		elseif dy1<0 then dy1=-1 end
		if dy2>0 then dy2=1
		elseif dy2<0 then dy2=-1 end
		--end
		--���Ȼ����м�һ��
		for i=0,len1-1 do
			num=num+1
			xy[num]={x+i*fx,y+i*fy}
		end
			--Ȼ��������
		for i=0,len2-1 do
			num=num+1
			xy[num]={x+dx1+i*fx,y+dy1+i*fy}
			num=num+1
			xy[num]={x+dx2+i*fx,y+dy2+i*fy}
		end	
		for i=0,len3-1 do
			num=num+1
			xy[num]={x+2*dx1+i*fx,y+2*dy1+i*fy}
			num=num+1
			xy[num]={x+2*dx2+i*fx,y+2*dy2+i*fy}
		end	
		for i=0,len4-1 do
			num=num+1
			xy[num]={x+3*dx1+i*fx,y+3*dy1+i*fy}
			num=num+1
			xy[num]={x+3*dx2+i*fx,y+3*dy2+i*fy}
		end	
	elseif kind==11 then				--������
		local fx,fy=x-x0,y-y0
		if fx>1 then fx=1
		elseif fx<-1 then fx=-1 end
		if fy>1 then fy=1
		elseif fy<-1 then fy=-1 end
		local dx1,dy1,dx2,dy2=-fy,fx,fy,-fx
		if fx~=0 and fy~=0 then
			dx1=-(dx1+fx)/2
			dx2=-(dx2+fx)/2
			dy1=-(dy1+fy)/2
			dy2=-(dy2+fy)/2
			len1=math.modf(len1*0.7071)
			for i=0,len1 do
				num=num+1
				xy[num]={x+i*fx,y+i*fy}
				for j=1,2*i+1 do
					num=num+1
					xy[num]={x+i*fx+j*dx1,y+i*fy+j*dy1}
					num=num+1
					xy[num]={x+i*fx+j*dx2,y+i*fy+j*dy2}
				end
			end
		else
			for i=0,len1 do
				num=num+1
				xy[num]={x+i*fx,y+i*fy}
				for j=1,len1-i do
					num=num+1
					xy[num]={x+i*fx+j*dx1,y+i*fy+j*dy1}
					num=num+1
					xy[num]={x+i*fx+j*dx2,y+i*fy+j*dy2}
				end
			end
		end
	elseif kind==12 then				--������
		local fx,fy=x-x0,y-y0
		if fx>1 then fx=1
		elseif fx<-1 then fx=-1 end
		if fy>1 then fy=1
		elseif fy<-1 then fy=-1 end
		local dx1,dy1,dx2,dy2=-fy,fx,fy,-fx
		if fx~=0 and fy~=0 then
			dx1=(dx1+fx)/2
			dx2=(dx2+fx)/2
			dy1=(dy1+fy)/2
			dy2=(dy2+fy)/2
			len1=math.modf(len1*1.41421)
			for i=0,len1 do
				if i<=len1/2 then
					num=num+1
					xy[num]={x+i*fx,y+i*fy}
				end
				for j=1,len1-i*2 do
					num=num+1
					xy[num]={x+i*fx+j*dx1,y+i*fy+j*dy1}
					num=num+1
					xy[num]={x+i*fx+j*dx2,y+i*fy+j*dy2}
				end
			end
		else
			for i=0,len1 do
				num=num+1
				xy[num]={x+i*fx,y+i*fy}
				for j=1,i do
					num=num+1
					xy[num]={x+i*fx+j*dx1,y+i*fy+j*dy1}
					num=num+1
					xy[num]={x+i*fx+j*dx2,y+i*fy+j*dy2}
				end
			end
		end
	elseif kind==13 then			--��������
		local fx,fy=x-x0,y-y0;
		if fx>1 then fx=1
		elseif fx<-1 then fx=-1 end
		if fy>1 then fy=1
		elseif fy<-1 then fy=-1 end
		local xx=x+fx*len1;
		local yy=y+fy*len1;
		for tx=xx-len1,xx+len1 do			--��������о��е��˷ѣ�1/2�ĵ㶼�ǲ�����Ҫ���
			for ty=yy-len1,yy+len1 do
				if math.abs(tx-xx)+math.abs(ty-yy)>len1 then
				
				else
					num=num+1
					xy[num]={tx,ty}
				end
			end
		end	
	elseif kind==14 then			--��ɽ����
		local fx,fy=x-x0,y-y0;
		if fx>1 then fx=1
		elseif fx<-1 then fx=-1 end
		if fy>1 then fy=1
		elseif fy<-1 then fy=-1 end
		for i=0,len2-1 do
			for j=-len1,len1 do
				num=num+1;
				xy[num]={x+fx*i+fy*j,y+fy*i+fx*j};
			end
		end
	else
		return 0
	end	
		
		
		
	if flag==0 then
		return num,xy;
	elseif flag==1 then									--���ƹ�����Χ
		local function thexy(nx,ny)
			local dx,dy=nx-x0,ny-y0
			return CC.ScreenW/2+CC.XScale*(dx-dy),CC.ScreenH/2+CC.YScale*(dx+dy)-lib.GetS(JY.SubScene,nx,ny,4)
		end
		
		for i=1,num do
			local tx,ty=thexy(xy[i][1],xy[i][2],x0,y0)
			lib.PicLoadCache(0,0,tx,ty,2,128);
			--SetWarMap(xy[i][1],xy[i][2],4,1);
		end
	elseif flag==2 then													--���ع�����Ŀ
		if WAR.Person[WAR.CurID]["���"]>0 then
			return math.random(100);
		end
		local diwo=WAR.Person[WAR.CurID]["�ҷ�"]
		local atknum=0
		for i=1,num do
			if xy[i][1]>=0 and xy[i][1]<CC.WarWidth and xy[i][2]>=0 and xy[i][2]<CC.WarHeight then
				local id=GetWarMap(xy[i][1],xy[i][2],2);
				if id~=-1 and WAR.Person[id]["�ҷ�"]~=WAR.Person[WAR.CurID]["�ҷ�"] then--and id~=WAR.CurID then
					local hp=JY.Person[WAR.Person[id]["������"]]["����"]
					local xb;
					--local catk,cdef=JY.Person[WAR.Person[WAR.CurID]["������"]]["����"],JY.Person[WAR.Person[id]["������"]]["����"];
					local tatk=atk--*JY.Person[WAR.Person[WAR.CurID]["������"]]["����"]/(JY.Person[WAR.Person[WAR.CurID]["������"]]["����"]+JY.Person[WAR.Person[id]["������"]]["����"]);
					local offset=	math.abs(WAR.Person[WAR.CurID]["����X"]-WAR.Person[id]["����X"])+
										math.abs(WAR.Person[WAR.CurID]["����Y"]-WAR.Person[id]["����Y"]);
					if offset <10 then
						tatk=tatk*(100-(offset-1)*5)/100;
					else
						tatk=tatk/2;
					end
					if hp<tatk/5 then
						xb=23;
					elseif hp<tatk/4 then
						xb=18;
					elseif hp<tatk/3 then
						xb=14;
					elseif hp<tatk/2 then
						xb=11;
					elseif hp<tatk/1.5 then
						xb=9;
					elseif hp<tatk then
						xb=7;
					elseif hp<tatk*1.5 then
						xb=6;
					elseif hp<tatk*2 then
						xb=5;
					else
						xb=3;
					end
					atknum=atknum+xb;
				end;
			end
		end--[[
		if atknum>0 then
			atknum=atknum+math.modf(atk/10);
		end]]--
		return atknum;
	elseif flag==3 then							--�����书Ч�����ò㣬���Ĳ�
		CleanWarMap(4,0)
		for i=1,num do
			SetWarMap(xy[i][1],xy[i][2],4,1);
		end
	
	end
		
		
end

function War_FightSelectType(movefanwei,atkfanwei,x,y)		--
    local x0=WAR.Person[WAR.CurID]["����X"];
    local y0=WAR.Person[WAR.CurID]["����Y"];
    if x==nil and y==nil then
        x,y=War_KfMove(movefanwei,atkfanwei);              --δָ�������ص㣬ѡ�񹥻�����
		if x ==nil then
			getkey();
			Cls();
			return false;
		end
	else																	--�Զ�ս��ʱ����ָ�������ص㣬��Զ�ת���������������	
		WarDrawAtt(x,y,atkfanwei,1)								--��ʾ������Χ����תʱ��ʾ����ȷ��Ӧ��������û���ƶ�����������-�޸���
		getkey();
		ShowScreen();
		lib.Delay(500);
    end

    WAR.Person[WAR.CurID]["�˷���"]=War_Direct(x0,y0,x,y) or WAR.Person[WAR.CurID]["�˷���"]

	SetWarMap(x,y,4,1);

    WAR.EffectXY={};
	WarDrawAtt(x,y,atkfanwei,3)
	return true,x,y;
end

function War_KfMove(movefanwei,atkfanwei)              ---ѡ���ƶ�λ��,�书ר��
--kind 0����1���� 2���� 3����
	local kind=movefanwei[1] or 0
	local len=movefanwei[2] or 0
    local x0=WAR.Person[WAR.CurID]["����X"];
    local y0=WAR.Person[WAR.CurID]["����Y"];
    local x=x0;
    local y=y0;
	local t=0;
	if kind~=nil then
		if kind==0 then
			War_CalMoveStep(WAR.CurID,len,1);
		elseif kind==1 then
			War_CalMoveStep(WAR.CurID,len*2,1);
			for r=1,len*2 do
				for i=0,r do
					local j=r-i
					if i>len or j>len then
						SetWarMap(x0+i,y0+j,3,255)
						SetWarMap(x0+i,y0-j,3,255)
						SetWarMap(x0-i,y0+j,3,255)
						SetWarMap(x0-i,y0-j,3,255)
					end
				end
			end
		elseif kind==2 then
			War_CalMoveStep(WAR.CurID,len,1);
			for i=1,len-1 do
				for j=1,len-1 do
					SetWarMap(x0+i,y0+j,3,255)
					SetWarMap(x0-i,y0+j,3,255)
					SetWarMap(x0+i,y0-j,3,255)
					SetWarMap(x0-i,y0-j,3,255)
				end
			end
		elseif kind==3 then
			War_CalMoveStep(WAR.CurID,2,1);
			SetWarMap(x0+2,y0,3,255)
			SetWarMap(x0-2,y0,3,255)
			SetWarMap(x0,y0+2,3,255)
			SetWarMap(x0,y0-2,3,255)
		else
			War_CalMoveStep(WAR.CurID,0,1);
		end
	end
    while true do
        local x2=x;
        local y2=y;
		if t==0 then
			WAR.Data["��ͼ"]=0;
		elseif t==10 then
			WAR.Data["��ͼ"]=1;
		end
		t=t+1;
		if t>=20 then
			t=0;
		end
        WarDrawMap(1,x,y);
		if kind<2 or x~=x0 or y~=y0 then
			WarDrawAtt(x,y,atkfanwei,1)
		end
		WarShowHead(GetWarMap(x,y,2))
        ShowScreen();
		lib.Delay(30);
        local eventtype,key,mx,my=getkey();--WaitKey(1);
		if eventtype==1 then
			if key==VK_UP then
				y2=y-1;
			elseif key==VK_DOWN then
				y2=y+1;
			elseif key==VK_LEFT then
				x2=x-1;
			elseif key==VK_RIGHT then
				x2=x+1;
			elseif key==VK_SPACE or key==VK_RETURN then
				if kind<2 or x~=x0 or y~=y0 then
					return x,y;
				end
			elseif key==VK_ESCAPE then
				return nil;
			end
			if GetWarMap(x2,y2,3)<128 then
				x=x2;
				y=y2;
			end
		elseif eventtype==2 or eventtype==3 then
			mx=mx-CC.ScreenW/2
			my=my-CC.ScreenH/2+GetS(JY.SubScene,x0,y0,4)
			mx=mx/CC.XScale
			my=my/CC.YScale
			mx,my=(mx+my)/2,(my-mx)/2
			if mx>0 then mx=mx+0.99 else mx=mx-0.01 end
			if my>0 then my=my+0.99 else mx=mx-0.01 end
			mx=math.modf(mx)
			my=math.modf(my)
			for i=-10,10 do
				if between(x0+mx+i,0,63) and between(y0+my+i,0,63) then
					if math.abs(GetS(JY.SubScene,x0+mx+i,y0+my+i,4)-CC.YScale*i*2-GetS(JY.SubScene,x0,y0,4))<4 then
						mx=mx+i;
						my=my+i;
						break;
					end
				end
			end
			if GetWarMap(x0+mx,y0+my,3)<128 then
				x,y=x0+mx,y0+my
				if eventtype==3 then
					if key==1 then
						if kind<2 or x~=x0 or y~=y0 then
							return x,y;
						end
					elseif key==3 then
						return nil;
					end
				end
			end
		end
    end
end

function drawname(x,y,name,size,color)
	x=x-math.modf(size/2)
	color=color or M_White;
	local namelen=string.len(name)/2
	--local zi={}		
	for i=1,namelen do
		local s=string.sub(name,i*2-1,i*2)
		DrawString(x,y,s,color,size)
		y=y+size
	end
end

function WarSetDirect()
	for i=0,49 do
		if not WAR.Person[i]["����"] then
			local x,y,cx,cy,min_x,min_y,len,min_len;
			min_len=10000;
			cx,cy=WAR.Person[i]["����X"],WAR.Person[i]["����Y"];
			for j=0,49 do
				if not WAR.Person[j]["����"] then
					if WAR.Person[i]["�ҷ�"]~=WAR.Person[j]["�ҷ�"] then
						x,y=WAR.Person[j]["����X"],WAR.Person[j]["����Y"];
						len=(cx-x)^2+(cy-y)^2;
						if len<min_len then
							min_len=len;
							min_x,min_y=x,y;
						end
					end
				end
			end
			if min_len<10000 then
				WAR.Person[i]["�˷���"]=War_Direct(cx,cy,min_x,min_y);
			end
		end
	end
end













------------WE------------------

function WAR_CALLEVENT(num)
	local war={}
	war[999]=true
	
	if num==999 then 
		return 0
	else	
		local eventfilename=string.format("warevent%03d.lua",num);
		--lib.Debug(eventfilename);
		return dofile(CONFIG.ScriptPath.."war\\" .. eventfilename) or 0;
	end
end


------ս���¼���ʹ�õĲ��ֺ���----ȫ����WE_��ͷ
function WE_xy(x,y,id)			--��ȡ��Ŀ��xy��ӽ��Ŀ�������
--����idʱ���������ƶ�
--������ʱ�������ڳ���
	if id~=nil then
		War_CalMoveStep(id,128,0)
		--MY_CalMoveStep(x,y,128,0)
	else
		CleanWarMap(3,0)
	end
	if GetWarMap(x,y,3)~=255 and War_CanMoveXY(x,y,0) then
		return x,y
	else
		for s=1,128 do
			for i=1,s do
				local j=s-i
				if x+i<63 and y+j<63 then
					if GetWarMap(x+i,y+j,3)~=255 and War_CanMoveXY(x+i,y+j,0) then
						return x+i,y+j
					end
				end
				if x+j<63 and y-i>0 then
					if GetWarMap(x+j,y-i,3)~=255 and War_CanMoveXY(x+j,y-i,0) then
						return x+j,y-i	
					end
				end
				if x-i>0 and y-j>0 then
					if GetWarMap(x-i,y-j,3)~=255 and War_CanMoveXY(x-i,y-j,0) then
						return x-i,y-j	
					end
				end
				if x-j>0 and y+i<63 then
					if GetWarMap(x-j,y+i,3)~=255 and War_CanMoveXY(x-j,y+i,0) then
						return x-j,y+i
					end
				end
			end
		end		
	end
	
	for s=1,128 do
		for i=1,s do
			local j=s-i
			if x+i<63 and y+j<63 then
				if War_CanMoveXY(x+i,y+j,0) then
					return x+i,y+j
				end
			end
			if x+j<63 and y-i>0 then
				if War_CanMoveXY(x+j,y-i,0) then
					return x+j,y-i	
				end
			end
			if x-i>0 and y-j>0 then
				if War_CanMoveXY(x-i,y-j,0) then
					return x-i,y-j	
				end
			end
			if x-j>0 and y+i<63 then
				if War_CanMoveXY(x-j,y+i,0) then
					return x-j,y+i
				end
			end
		end
	end	
	return x,y
end	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	--[[
	
	if GetWarMap(x,y,3)~=255 and War_CanMoveXY(x,y,0) then
		return x,y
	else
		CleanWarMap(4,0)
		local steparray={};     --�����鱣���n�������ꡣ
		
			steparray.num=1;
			steparray.x={};
			steparray.y={};
		
		steparray.x[1]=x;
		steparray.y[1]=y;
		SetWarMap(x,y,4,1) 
		x,y=WE_FindNextxy(steparray)
		CleanWarMap(4,0)
		return x,y
	end
end


function WE_FindNextxy(steparray)
	local num=0
	for i=1,steparray.num do
	    local x=steparray.x[i];
	    local y=steparray.y[i];
	--lib.Debug("a"..(x)..','..y..','..GetWarMap(x,y,4))
	    if x+1<CC.WarWidth-1 and GetWarMap(x+1,y,4)==0 then                        --��ǰ���������ڸ�
			if GetWarMap(x+1,y,3)==255 or War_CanMoveXY(x+1,y,0)==false then
                num=num+1;
                steparray.x[num]=x+1;
                steparray.y[num]=y;
				SetWarMap(x+1,y,4,1) 
	--lib.Debug((x)..','..y..','..GetWarMap(x,y,4))
			else return x+1,y
			end
		end
	    if x-1>=0 and GetWarMap(x-1,y,4)==0 then                        --��ǰ���������ڸ�
			if GetWarMap(x-1,y,3)==255 or War_CanMoveXY(x-1,y,0)==false then
                num=num+1;
                steparray.x[num]=x-1;
                steparray.y[num]=y;
				SetWarMap(x-1,y,4,1) 
			else return x-1,y
			end
		end
	    if y+1<CC.WarWidth-1 and GetWarMap(x,y+1,4)==0 then                        --��ǰ���������ڸ�
			if GetWarMap(x,y+1,3)==255 or War_CanMoveXY(x,y+1,0)==false then
                num=num+1;
                steparray.x[num]=x;
                steparray.y[num]=y+1;
				SetWarMap(x,y+1,4,1) 
			else return x,y+1
			end
		end
	    if y-1>=0 and GetWarMap(x,y-1,4)==0 then                        --��ǰ���������ڸ�
			if GetWarMap(x,y-1,3)==255 or War_CanMoveXY(x,y-1,0)==false then
                num=num+1;
                steparray.x[num]=x;
                steparray.y[num]=y-1;
				SetWarMap(x,y-1,4,1) 
			else return x,y-1
			end
		end	
	--lib.Debug("b"..(x)..','..y..','..GetWarMap(x,y,4))
	end
	steparray.num=num
	return WE_FindNextxy(steparray)
	--local nx,ny=WE_FindNextxy(steparray)
	--return nx,ny
end

--]]
function WE_getwarid(pid)
	if WAR.PersonNum==nil then
		return -1;
	end
	for i=0,WAR.PersonNum-1 do
		if WAR.Person[i]["������"]==pid then return i end
	end
	return -1;
end

function WE_move(pid,x,y)
--pid,������
--x,y,Ŀ����������������ֵ
	local id=WE_getwarid(pid)
	if id==-1 then return end
	WAR.CurID=id
	local cx,cy=WAR.Person[id]["����X"],WAR.Person[id]["����Y"]
	local nx,ny=WE_xy(cx+x,cy+y,id)
	--lib.Debug(x..','..y..','..nx..','..ny)
	War_MovePerson(nx,ny)
	lib.Delay(100)
end

function WE_moveto(pid,x,y)
--pid,������
--x,y,Ŀ������
	local id=WE_getwarid(pid)
	if id==-1 then return end
	WAR.CurID=id
	local nx,ny=WE_xy(x,y,id)
	--lib.Debug(x..','..y..','..nx..','..ny)
	War_MovePerson(nx,ny)
	lib.Delay(100)
end

function WE_follow(pid,eid)
--pid,������
--id,Ŀ������ƶ�����Ŀ�����������λ��
	local a=WE_getwarid(pid)
	local b=WE_getwarid(eid)
	--lib.Debug(a..','..b)
	if a==-1 or b==-1 then return end
	WAR.CurID=a
	local x,y=WAR.Person[b]["����X"],WAR.Person[b]["����Y"]
	local nx,ny=WE_xy(x,y,a)
	--lib.Debug(pid..','..eid..','..a..','..b..','..x..','..y..','..nx..','..ny)
	War_MovePerson(nx,ny)
	lib.Delay(100)
end

function WE_addperson(id,x,y,faseto,jq,flag)
--id,ս�����¼ӵ������������
--x,y,����λ��
--flag,���ұ�ʶ
--faceto���﷽��0����1����2����3����
	faseto=faseto or 0
	if flag==nil then
		flag=true;
	end
	jq=jq or 200;
	local cx,cy=WE_xy(x,y)
	WAR.Person[WAR.PersonNum]["������"]=id;
	WAR.Person[WAR.PersonNum]["�ҷ�"]=flag;
	WAR.Person[WAR.PersonNum]["����X"]=cx;
	WAR.Person[WAR.PersonNum]["����Y"]=cy;
	WAR.Person[WAR.PersonNum]["����"]=false;
	WAR.Person[WAR.PersonNum]["�˷���"]=faseto;
	WAR.Person[WAR.PersonNum]["AI"]={2,0,0};
	if id==0 then
		WAR.Person[WAR.PersonNum]["AI"]={0,0,0};
	end
	WAR.Person[WAR.PersonNum]["��ͼ"]=WarCalPersonPic(WAR.PersonNum);
		--WAR.Person[i]["��ͼ"]=WarCalPersonPic(i);
	--WAR.Person[WAR.PersonNum]["AI"]=2;
	SetWarMap(cx,cy,2,WAR.PersonNum);
	SetWarMap(cx,cy,5,WAR.Person[WAR.PersonNum]["��ͼ"]);
	lib.PicLoadFile(string.format(CC.FightPicFile[1],JY.Person[id]["ս������"]),string.format(CC.FightPicFile[2],JY.Person[id]["ս������"]),4+WAR.PersonNum);
	WAR.Person[WAR.PersonNum]["�Ṧ"]=GetSpeed(id);
	WAR.Person[WAR.PersonNum]["Time"]=jq;
	GetJiqi(WAR.PersonNum);
	WAR.PersonNum=WAR.PersonNum+1
	--WAR.CurID=WAR.PersonNum-1
end

function WE_sort()
--���д��������¼�����
--��������ͼ���Ṧ�����
--δ������ȫ	
--���������������û���ˣ����ұ�����
	WarPersonSort(1)
	for i=0,WAR.PersonNum-1 do
		local pid=WAR.Person[i]["������"]
		lib.PicLoadFile(string.format(CC.FightPicFile[1],JY.Person[pid]["ͷ�����"]),string.format(CC.FightPicFile[2],JY.Person[pid]["ͷ�����"]),4+i);
		end
end

function WE_atk(id,cx,cy,kfid,lv,flag)
--�����书����
--���lvΪ�գ���ֻ�������﹥������
	CleanWarMap(4,0)
	local cid=WE_getwarid(id)
	local x0=WAR.Person[cid]["����X"];
	local y0=WAR.Person[cid]["����Y"];
	WAR.Person[cid]["�˷���"]=War_Direct(0,0,cx,cy) or WAR.Person[cid]["�˷���"]
	if lv~=nil then
		local kind,len1,len2=fenjie(JY.Wugong[kfid]["��Χ"..math.modf((lv+2)/3)])
		WarDrawAtt(x0+cx,y0+cy,kind,len1,len2,3,x0,y0)
	end
	local tmp=WAR.CurID
	WAR.CurID=cid
	War_ShowFight(id,kfid,JY.Wugong[kfid]["�书����"],lv,x0+cx,y0+cy,JY.Wugong[kfid]["�书����&��Ч"],0,0,0);
	WAR.CurID=tmp
	CleanWarMap(4,0)
end

function WE_close(id1,id2,len)
--�ж�����id֮��ľ��룬���С�ڵ���len�򷵻���
--���lenΪ���򷵻����˵ľ���
	--len=len or 1
	local cid1=WE_getwarid(id1);
	local cid2=WE_getwarid(id2);
	if cid1==-1 or cid2==-1 then
		if len==nil then
			return -1;
		else
			return false;
		end
	end
	local x1,y1=WAR.Person[cid1]["����X"],WAR.Person[cid1]["����Y"]
	local x2,y2=WAR.Person[cid2]["����X"],WAR.Person[cid2]["����Y"]
	local s;
	if WAR.Person[cid1]["����"] or WAR.Person[cid2]["����"] then
		s=math.huge;
	else
		s=math.abs(x1-x2)+math.abs(y1-y2);
	end
	if len==nil then return s
	elseif s<=len then return true
	else return false
	end
end

function WE_chuxian(id,x,y)
	local pid=WE_getwarid(id)
	local cx,cy=WE_xy(x,y)
	SetWarMap(cx,cy,2,pid);
	SetWarMap(cx,cy,5,WAR.Person[pid]["��ͼ"]);
	WAR.Person[pid]["����X"]=cx
	WAR.Person[pid]["����Y"]=cy
end

function WE_xiaoshi(id)
	local pid=WE_getwarid(id)
	local cx,cy=WAR.Person[pid]["����X"],WAR.Person[pid]["����Y"]
	SetWarMap(cx,cy,2,-1);
	SetWarMap(cx,cy,5,-1);
end