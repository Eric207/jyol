


---��ģ���Ŷ�JYMain.lua ���޸ĺ����䡣

--������������ģ�����������޸�ԭʼJYMain.Lua�ļ���
--����һ��������¼�������
--1. SetModify������   �ú�������Ϸ��ʼʱ���ã������ڴ��޸�ԭ�е����ݣ��Լ��ض���ԭ�еĺ�������ʵ�ֶ�ԭ�к������޸ġ�
--                    �����Ϳ��Ի�������ԭʼ�ĺ���
--2. ԭ�к��������غ����� SetModify�����صĺ������ڴ˴����������޸�JYMain.lua�ļ����������޸Ĳ����ض��庯������ʽ��
--3. �µ���Ʒʹ�ú�����
--4. �µĳ����¼�������





--��jymain���޸ģ��Լ������µ���Ʒ�����ͳ����¼�������
--ע��������Զ���ȫ�̱�����
function SetModify()
	Font_Qiti=".\\�����������.ttf";
	Font_Xihei=".\\����ϸ��.ttf";
   --����һ�����庯�������ӡ����������޸����˵��е�ϵͳ�˵�����������Ϸ�����п�����Ч�Ĺ��ܡ�
   --ԭ��ֻ����jyconst.lua��ͨ������������ǰ���ƣ���������ʵʱ���ơ�
   Menu_System_old=Menu_System;         --����ԭʼ����������µĺ�����Ҫ�������Ե���ԭʼ������
   Menu_System=Menu_System_new;

   --�ڴ˶���������Ʒ��û�ж���ľ�����ȱʡ��Ʒ����
    JY.ThingUseFunction[182]=Show_Position;     --���̺���
	JY.ThingUseFunction[0]=newThing_0;   --�ı�ԭ�������صĹ���Ϊ���������������书��
	JY.ThingUseFunction[2]=newThing_2;

  --�ڴ˿��Զ���ʹ�����¼������ĳ���
    JY.SceneNewEventFunction[1]=newSceneEvent_1;          --�µĺ����ջ�¼�������

end


--�µ�ϵͳ�Ӳ˵������ӿ������ֺ���Ч
function Menu_System_new()
	local menu={
	             {"��ȡ����",Menu_ReadRecord,1},
                 {"�������",Menu_SaveRecord,1},
				 {"�ر�����",Menu_SetMusic,1},
				 {"�ر���Ч",Menu_SetSound,1},
				 {"ȫ���л�",Menu_FullScreen,1},
                 {"�뿪��Ϸ",Menu_Exit,1},   };

    if JY.EnableMusic==0 then
	    menu[3][1]="������";
	end

	if JY.EnableSound==0 then
	    menu[4][1]="����Ч";
    end


    local r=ShowMenu(menu,6,0,CC.MainSubMenuX,CC.MainSubMenuY,0,0,1,1,CC.DefaultFont,C_ORANGE, C_WHITE);
    if r == 0 then
        return 0;
    elseif r<0 then   --Ҫ�˳�ȫ���˵���
        return 1;
 	end
end

function Menu_FullScreen()
    lib.FullScreen();
	lib.Debug("finish fullscreen");
end

function Menu_SetMusic()
    if JY.EnableMusic==0 then
	    JY.EnableMusic=1;
		PlayMIDI(JY.CurrentMIDI);
	else
	    JY.EnableMusic=0;
		lib.PlayMIDI("");
	end
	return 1;
end

function Menu_SetSound()
    if JY.EnableSound==0 then
	    JY.EnableSound=1;
	else
	    JY.EnableSound=0;
	end
	return 1;
end


----------------------------------------------------------------
---------------------------��Ʒʹ�ú���--------------------------


--���̺�������ʾ����ͼ����λ��
function Show_Position()
    if JY.Status ~=GAME_MMAP then
        return 0;
    end
    DrawStrBoxWaitKey(string.format("��ǰλ��(%d,%d)",JY.Base["��X"],JY.Base["��Y"]),C_ORANGE,CC.DefaultFont);
	return 1;
end


--���������ơ��Ⱥ��������һ���书
function newThing_0(id)
    if JY.Status ==GAME_WMAP then
	    return 0;
	end

    Cls();
    if DrawStrBoxYesNo(-1,-1,"�Ⱥ�������书�������������Ƿ����?",C_WHITE,CC.DefaultFont,1) == false then
        return 0;
    end
    Cls();
    DrawStrBox(CC.MainSubMenuX,CC.MainSubMenuY,string.format("˭Ҫ����%s?",JY.Thing[id]["����"]),C_WHITE,CC.DefaultFont,1);
	local nexty=CC.MainSubMenuY+CC.SingleLineHeight;
    local r=SelectTeamMenu(CC.MainSubMenuX,nexty);
    if r<=0 then
	    return 0;
	end

	local pid=JY.Base["����" .. r];

	if JY.Person[pid]["�������ֵ"]<=50 then
	    return 0;
	end

	Cls();
    local numwugong=0;
    local menu={};
    for i=1,10 do
        local tmp=JY.Person[pid]["�书" .. i];
        if tmp>0 then
            menu[i]={JY.Wugong[tmp]["����"],nil,1};
            numwugong=numwugong+1;
        end
    end

    if numwugong==0 then
        return 0;
    end

    DrawStrBox(CC.MainSubMenuX,CC.MainSubMenuY,string.format("��ѡ��Ҫ���ǵ��书"),C_WHITE,CC.DefaultFont,1);

	r=ShowMenu(menu,numwugong,0,CC.MainSubMenuX,nexty,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);

    if r<=0 then
	    return 0;
    else
        local s=string.format("%s �����书 %s",JY.Person[pid]["����"],JY.Wugong[JY.Person[pid]["�书" .. r]]["����"]);
		DrawStrBoxWaitKey(s,C_WHITE,24);

		for i=r+1,10 do
		    JY.Person[pid]["�书" .. i-1]=JY.Person[pid]["�书" .. i];
		    JY.Person[pid]["�书�ȼ�" .. i-1]=JY.Person[pid]["�书�ȼ�" .. i];
		end

		local v,str=AddPersonAttrib(pid,"�������ֵ",-50);

	    DrawStrBoxWaitKey(str,C_WHITE,CC.DefaultFont);
        AddPersonAttrib(pid,"����",0);

        instruct_32(id,-1);
	end
    Cls();
	return 1;
end


--����Һ��ս��ʱ����ʹһ�������Ķ��Ѹ��������ָܻ�50%
function newThing_2(thingid)
    if JY.Status ~=GAME_WMAP then
	    return 0;
	end

	local menu={};
    local menunum=0;
    for i=0,WAR.PersonNum-1 do
	    menu[i+1]={JY.Person[WAR.Person[i]["������"]]["����"],nil,0}
        if WAR.Person[i]["�ҷ�"]==true and WAR.Person[i]["����"]==true then
            menu[i+1][3]=1;
			menunum=menunum+1;
        end
    end

	if menunum==0 then
	    return 0;
	end

	Cls();
    DrawStrBox(CC.MainSubMenuX,CC.MainSubMenuY,string.format("��ѡ��Ҫ����Ķ���"),C_WHITE,CC.DefaultFont);
	local nexty=CC.MainSubMenuY+CC.SingleLineHeight;
    local r=ShowMenu(menu,WAR.PersonNum,0,CC.MainSubMenuX,nexty,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
    Cls();
    if r>0 then
	    r=r-1;           --�˵�����ֵ�Ǵ�1��ʼ��ŵġ�
		WAR.Person[r]["����"]=false;
        local pid=WAR.Person[r]["������"];
        JY.Person[pid]["����"]=JY.Person[pid]["�������ֵ"];
        SetRevivePosition(r);
        instruct_32(thingid,-1);
        WarSetPerson();        --�����趨ս��λ��
	    return 1;
	else
	    return 0;
	end
end

--���ø�����ѵ�λ��Ϊ���뵱ǰʹ����Ʒ��ս����������Ŀ�λ
function  SetRevivePosition(id)
	local minDest=math.huge;
	local x,y;
	War_CalMoveStep(WAR.CurID,100,0);   --�����ƶ����� �������100��
	for i=0,CC.WarWidth-1 do
		for j=0,CC.WarHeight-1 do
			local dest=Byte.get16(WAR.Map3,(j*CC.WarWidth+i)*2);
			if dest>0 and dest <128 then
				if minDest>dest then
					minDest=dest;
					x=i;
					y=j;
				 elseif minDest==dest  then
					 if Rnd(2)==0 then
						x=i;
						y=j;
					end
				end
			end
		end
	end

	if minDest<math.huge then
        WAR.Person[id]["����X"]=x;
        WAR.Person[id]["����Y"]=y;
	end

end


------------------------------------------------------------------------------------------
-------�µĳ����¼�����ʵ��

--��ÿ������ÿ��D*����Ӧһ��lua�ļ����ڴ��ļ��д���ͬ�Ĵ�����ʽ���¼��仯���
--��������һ��ȱ�㣬������D*��Ҫ����ͬ�����¼���ô�죿һ���취����һ��lua�ļ��м�����dofile������һ����
--��һ���취����һ���Զ���ĳ����¼����������������жϲ�ͬ��D���ò�ͬ�ĺ�����


-------�µĺ����ջ�����¼�������
--���������ھɵĴ�����������������D*����˲���Ҫ��������һ��������
--�����ȫ�µĴ�������ֱ��ʹ��newCallEvent���ɡ�
--flag 1 �ո񴥷���2����Ʒ������3��·������
function newSceneEvent_1(flag)
    if JY.CurrentD<=18 then     --����ǰ��ŵ�D*����Ȼ���þɵĴ�����
        oldEventExecute(flag);
    else
        newCallEvent(flag);
	end
end


--�µ�ͨ���¼�������
function newCallEvent(flag)

    JY.CurrentEventType=flag;

	local eventnum;
	if flag==1 then
		eventnum=GetD(JY.SubScene,JY.CurrentD,2);
	elseif flag==2 then
		eventnum=GetD(JY.SubScene,JY.CurrentD,3);
	elseif flag==3 then
		eventnum=GetD(JY.SubScene,JY.CurrentD,4);
	end

    if eventnum>=0 then           --ֻ�д��ڻ����0ʱ�ŵ���lua�ļ���
	--���ո�����ʽ����Ҫ���õ�D*�����ļ�����Ȼ���������
		local eventfilename=string.format(CONFIG.NewEventPath .. "scene_%d_event_%d.lua",JY.SubScene,JY.CurrentD);
		dofile(eventfilename);
    end

    JY.CurrentEventType=-1;
end

------------------------------�ض���һЩ���¼��õĺ���----------------
--[[
��������һЩ�Ѷ�����ĺ���
function GetTeamNum()            --�õ����Ѹ���
function WaitKey()       --�ȴ���������
function DrawBox(x1,y1,x2,y2,color)         --����һ���������İ�ɫ����
function DrawBox_1(x1,y1,x2,y2,color)       --�����Ľǰ����ķ���
function DrawString(x,y,str,color,size)         --��ʾ��Ӱ�ַ���
function DrawStrBox(x,y,str,color,size)         --��ʾ������ַ���
function DrawStrBoxYesNo(x,y,str,color,size)        --��ʾ�ַ�����ѯ��Y/N
function DrawStrBoxWaitKey(s,color,size)          --��ʾ�ַ������ȴ�����
function Rnd(i)           --�����
function AddPersonAttrib(id,str,value)            --������������
function PlayMIDI(id)             --����midi
function PlayWavAtk(id)             --������Чatk***
function PlayWavE(id)              --������Чe**
function ShowScreen(flag)              --ˢ����Ļ��ʾ
function ShowMenu(menuItem,numItem,numShow,x1,y1,x2,y2,isBox,isEsc,size,color,selectColor)     --ͨ�ò˵�����
function ShowMenu2(menuItem,numItem,numShow,x1,y1,x2,y2,isBox,isEsc,size,color,selectColor)     --ͨ�ò˵�����
function ChangeMMap(x,y,direct)          --�ı���ͼ����
function ChangeSMap(sceneid,x,y,direct)       --�ı䵱ǰ����
function Cls(x1,y1,x2,y2)                    --�����Ļ
function Talk(s,personid)            --��򵥰汾�Ի�
function TalkEx(s,headid,flag)          --���Ӱ汾�Ի�

lib.GetTime
    ���ؿ�������ǰ�ĺ�����
	
lib.Delay(t)
    ��ʱt����
	
lib.GetS(id,x,y,level)
    ��S*����
    id �������
    x,y ����
    level ����
 
lib.SetS(id,x,y,level,v)
    д��������v

lib.GetD(Sceneid,id,i)
   ��D*����
   sceneid �������
   id �ó���D���
   i �ڼ�������
  
lib.SetD(Sceneid,id,i,v)
   дD*����v
]]--


--�����Ƕ�ԭָ���ֱ�ӵ��ã���ʵ�ͻ��˸����׼ǵ�����
function GetItem(thingid,num)	--�õ���Ʒ����Ʒ��ţ�������
	instruct_2(thingid,num)  
end

function AskFight() 			--ѯ���Ƿ�ս��
	return instruct_5() 
end

function AskJoin() 				--ѯ���Ƿ����
	return instruct_9() 
end

function Join(personid)			--���루�����ţ�
	instruct_10(personid)
end

function AskRest() 				--ѯ���Ƿ�ס��
	return instruct_11() 
end

function Rest()					--ס�޻ָ�����
	instruct_12()
end

function LightScence()			--��������
	instruct_13()
end

function DarkScence()			--�����䰵
	instruct_14()
end

function GameOver()				
	instruct_15()
end

function InTeam(personid)		--ĳ���Ƿ��ڶ��飨�����ţ�
	return instruct_16(personid)
end

function HaveItem(thingid)		--�Ƿ���ĳ��Ʒ����Ʒ��ţ�
	return instruct_18(thingid)
end

function TeamIsFull()			--�����Ƿ���Ա
	return instruct_20()
end

function LeaveTeam(personid)	--��ӣ������ţ�
	instruct_21(personid)
end

function NoNeili()				--ȫԱ��������
	instruct_22()
end

function ScenceFromTo(x1,y1,x2,y2)		--�����ƶ���x1��y1����Ϊ0����ʱx2��y2Ϊ���ֵ(x2-x1)(y2-y1)
	instruct_25(x1,y1,x2,y2)
end

function PlayAnimation(id,startpic,endpic)	--���Ŷ���
	instruct_27(id,startpic,endpic)
end

function WalkFromTo(x1,y1,x2,y2) 		--�����߶���x1��y1����Ϊ0����ʱx2��y2Ϊ���ֵ(x2-x1)(y2-y1)
	instruct_30(x1,y1,x2,y2) 
end

function AddItem(thingid,num)			--������Ʒ����Ʒ��ţ�������������Ϊ��ʱ��������Ʒ
	instruct_32(thingid,num)
end

function LearnWugong(personid,wugongid,flag)	--ѧ���书�������ţ��书��ţ��书���飩
	instruct_33(personid,wugongid,flag) 
end

function SetWugong(personid,id,wugongid,wugonglevel)	--���������书�������ţ��ڼ����书���书��ţ��书���飩
	instruct_35(personid,id,wugongid,wugonglevel)
end

function OpenScence(sceneid)			--�򿪳�����������ţ�
	instruct_39(sceneid) 
end


--����������ӵļ�������
function GetBestMember(a,b,c)				--���ض�����ĳ��������߻���͵Ķ��ѱ�ţ�a=1������ߣ�a=0������ͣ�b=1����������=0������c,������
	local num=GetTeamNum()
	local d=b+1
	for i=b+2,num do
		if a==1 then 
			if JY.Person[JY.Base["����" ..i]][a]>JY.Person[JY.Base["����" ..d]][a] then d=i end;
		else
			if JY.Person[JY.Base["����" ..i]][a]<JY.Person[JY.Base["����" ..d]][a] then d=i end;
		end
	end

end





----------------------------------------------���ֺ���------------------------------------


function GetAtkKungfu(pid)							--�������﹥���õ��书ID���������书�б��е���ţ�
	--�ݲ���ɣ���������
	return JY.Person[pid]["����1"]
end

function KeepSafe(id)								--�������R���ݲ���ȷ����ɵĲ�������
	return
	--[[
	for i=1,8 do
		if JY.Person[id]["����"..i]>CC.Kungfunum or JY.Person[id]["����"..i]<1 then JY.Person[id]["����"..i]=0 end		--ֻ�����˳��������������һ����ԣ�����
	end
	]]--
end

--[[
function War_AutoSelectWugong()           --�Զ�ѡ����ʵ��书
	--�������Զ�ѡ���书�ĺ���
	--���ܼܺ�ª���������Ǹ��������ó�ʹ�õ��书��ʵ��Ҳ��һ���书����
	--�Ժ��ڴ����ݶ������ѡ���õ������Լ���ͬ���书
	--�����о�����ѡ��Ҳûʲô����
	local pid=WAR.Person[WAR.CurID]["������"];
	return GetAtkKungfu(pid)
	
end
]]--



--���㵱ǰλ���ܹ������ĵ�����Ŀ
function GetAtkNum(x,y,fanwei,atk)
	local point={}		--��¼���Թ����ĵ�
	local num=0			--��¼��ĸ���
	local len=	0			--��������
	local kind,len1,len2
	kind,len1,len2=fenjie(JY.Wugong[kfnum]["��Χ"..math.modf((lv+2)/3)])
	
	if kind <8 then len=kind
	elseif kind==8 then len=0
	elseif kind==9 or kind==10 then len=1 end
	
	--��Χ��ʽ{a,b,c,d,e}
	--a,������Χ���� 0����1ʮ��2����9����10����
	--b,������Χ�ľ���
	--c,�˺���Χ
	--d,e�˺���Χ�ľ������
	local kind=fanwei[1]
	local len=fanwei[2]
	if kind==9 then 
		kind=1
		len=1
	elseif kind==10 then
		kind=2
		len=1
	end
	
	if kind==0 then
	for i=x-len,x+len do			--������ģ�ȡ������Χ
		for j=y-len,y+len do
			if math.abs(i-x)+math.abs(j-y)>len and kind~=9 then
				
			else
				num=num+1
				point[num]={i,j}
			end
		end
	end
	elseif kind==1 then
		--����
		if len<1 then len=1 end
		num=len*4+1
		point[num]={x,y}
		for i=1,len do
			point[i*4-3]={x+i,y}
			point[i*4-2]={x-i,y}
			point[i*4-1]={x,y+i}
			point[i*4]={x,y-i}
		end	
	elseif kind==2 then
		--����(����)
		if len<1 then len=1 end
		for i=x-len,x+len do
			for j=y-len,y+len do
				num=num+1
				point[num]={i,j}
			end
		end
		num=num+1
		point[num]={x,y}
	end
	
	--�ӵ�һ���㿪ʼ���ֱ��ȡ�õ㹥�����˵���Ŀ����������������꣬������Ŀ
	local maxx,maxy,maxnum,atknum=0,0,0,0
	for i=1,num do
		atknum=GetWapMap(x,y,4)				--ȡ���Ĳ����ݣ���Ϊ-1,����ú�������
		if atknum==-1 or fanwei[1]~=0 then		--������Ƕ����࣬������ظ�����
			atknum=WarDrawAtt(point[i][1],point[i][2],fanwei,2,x,y,atk)
			SetWarMap(x,y,4,atknum)
		end
		if atknum>maxnum then
			maxnum,maxx,maxy=atknum,point[i][1],point[i][2]
		end
	end
	SetWarMap(x,y,4,maxnum);
	return maxnum,maxx,maxy;
	
end


--���ƹ�����Χ|f���ظõ�Ĺ���������Ŀ
--flag=1ʱ���Ʒ�Χ��flag=2ʱ���ص�����Ŀ
--�������ǹ�����Χ����
--������λ���Ӹߵ����������λ��ʾ�书�������루����Ȼ���Ǹ÷�Χ���͵�������������������ڵ��ñ�����֮ǰ����������ֻ�����Ѵ�����˵�����
----����0����Χ0x���㣬x��ʹ��
----����0����Χ1x������ʮ�֣�xΪʮ�ִ�С��0��ȻΪ�㣬1ΪСʮ�֣�����
----����0����Χ2x������бʮ�֣�xΪʮ�ִ�С��0��ȻΪ�㣬1Ϊ÷��������
----����0����Χ3x�����Σ�xΪ���δ�С��0��ȻΪ�㣬1ΪСʮ�֣�2�������ε������ˣ�����
----����0����Χ4x�����飬xΪ�����С��0��ȻΪ�㣬1ΪС���飬����
----����0��������Ϊ��
----����1����Χab���߹�����ͬԭ�棬b��ʾ�м乥������
----����1����Χab���߹�����b��ʾ�м乥�����ȣ�a��ʾ���๥�����ȣ����÷����ϣ�����������
----����1����Χab���߹������ر�ģ���aΪ9ʱ���������ǹ���
----�����У�����һ�Ĺ���������ã������ٱ�ʾ�������ȣ����������ù�����Χ��ʾ��������������ô���
----����2����Χab�����򹥻���a��ʾбʮ�ֹ������ȣ�b��ʾ��ʮ�ֹ�������
----�����У����Ͷ��Ĺ������뽫�����ӣ�ֻ���ǹ�����Χ
----����3����Χab��ԭ��
---------����--------
--[[
������λ����λ�ǹ�����������͸���
	0��ԭ�ع���
	1-7���㹥��
	8ԭ�ذ��򹥻�
	9���򹥻�,�˸�����
	10���򹥻����ĸ�����������
	�����ϣ�ֻ��ֱ��0-7��8��9��10�ֱ�����
]]--
function WarDrawAtt(x,y,fanwei,flag,cx,cy,atk)
	local x0,y0
	if cx==nil or cy==nil then
		x0=WAR.Person[WAR.CurID]["����X"];
		y0=WAR.Person[WAR.CurID]["����Y"];
	else
		x0,y0=cx,cy
	end
	local xy={}
	local num=0
	
	if kind>=0 and kind<8 then				--���㹥��
			if len1==0 or len2==0 then		--����
				num=1
				xy[1]={x,y}
			elseif len1==1 then					--����ʮ��
				num=1+len2*4
				xy[1]={x,y}
				for i=1,len2 do
					xy[4*i-2]={x-i,y}
					xy[4*i-1]={x+i,y}
					xy[4*i]={x,y-i}
					xy[4*i+1]={x,y+i}
				end
			elseif len1==2 then					--����бʮ��
				num=1+len2*4
				xy[1]={x,y}
				for i=1,len2 do
					xy[4*i-2]={x-i,y-i}
					xy[4*i-1]={x+i,y+i}
					xy[4*i]={x+i,y-i}
					xy[4*i+1]={x-i,y+i}
				end			
			elseif len1==3 then					--��������
				for tx=x-len2,x+len2 do			--��������о��е��˷ѣ�1/2�ĵ㶼�ǲ�����Ҫ���
					for ty=y-len2,y+len2 do
						if math.abs(tx-x)+math.abs(ty-y)>len2 then
							
						else
							num=num+1
							xy[num]={tx,ty}
						end
					end
				end			
			elseif len1==4 then					--���㷽��
				for tx=x-len2,x+len2 do
					for ty=y-len2,y+len2 do
						num=num+1
						xy[num]={tx,ty}
					end
				end					
			else
				num=1
				xy[1]={x,y}			
			end	
	elseif kind==8 then							--ԭ�ذ���
			num=1+(len1+len2)*4
			xy[1]={x,y}			
			if len1~=0 then
				for i=1,len1 do
					xy[i*4-2]={x-i,y-i}
					xy[i*4-1]={x+i,y+i}
					xy[i*4]={x-i,y+i}
					xy[i*4+1]={x+i,y-i}
				end
			end
			if len2~=0 then
				for i=1,len2 do
					xy[i*4-2+4*len1]={x-i,y}
					xy[i*4-1+4*len1]={x+i,y}
					xy[i*4+4*len1]={x,y-i}
					xy[i*4+1+4*len1]={x,y+i}
				end			
			end
	elseif kind==9 then							--ԭ�ط���
			if x==x0 and y==y0 then return 0 end
			if len1<=0 and len2<=0 then return 0 end
			local fx,fy=x-x0,y-y0
			local linenum=1
				--���Ȼ����м�һ��
			if len2~=0 then 
				for j=1,len2 do
					num=num+1
					xy[num]={x0+j*fx,y0+j*fy}
				end
			end
				--Ȼ��������
			if len2~=0 then 
				local xl,yl,xr,yr
				xl,yl=x0-fy,y0+fx
				xr,yr=x0+fy,y0-fx
				if fx~=0 and fy~=0 then
					xl,yl=x0,y0-fy
					xr,yr=x0-fx,y0
				end
				for j=1,len1 do
					num=num+1
					xy[num]={xl+j*fx,yl+j*fy}
					num=num+1
					xy[num]={xr+j*fx,yr+j*fy}
				end
			end
	elseif kind==10 then					--ԭ�ط�������
			if len2<=0 then return 0 end
			local fx,fy=x-x0,y-y0
			if fx==0 and fy==0 then return 0 end
			for i=1,len2 do
				num=num+1
				xy[num]={x0+fx*i,y0+fy*i}
				for j=1,i -1 do
					num=num+1
					xy[num]={x0+fx*i+fy*j,y0+fy*i-fx*j}
					num=num+1
					xy[num]={x0+fx*i-fy*j,y0+fy*i+fx*j}
				end
			end
	
	
	else
		return	0
	end
		
		
		
	if flag==1 then									--���ƹ�����Χ

		local function thexy(nx,ny,x,y)
			local dx,dy=nx-x,ny-y
			return CC.ScreenW/2+CC.XScale*(dx-dy),CC.ScreenH/2+CC.YScale*(dx+dy)			
		end
		
		for i=1,num do
			local tx,ty=thexy(xy[i][1],xy[i][2],x0,y0)
			lib.PicLoadCache(0,0,tx,ty,2,128)		
		end
	elseif flag==2 then													--���ع�����Ŀ
		local diwo=WAR.Person[WAR.CurID]["�ҷ�"]
		local atknum=0
		for i=1,num do
			local id=GetWarMap(xy[i][1],xy[i][2],2);
			if id>=0 then 
				if diwo~=WAR.Person[id]["�ҷ�"] then 
					if id==WAR.Person[WAR.CurID]["�Զ�ѡ�����"] then
						atknum=atknum+20
					else
						local hp=JY.Person[WAR.Person[WAR.CurID]["������"]]["����"]
						if hp<atk/2 then
							atknum=atknum+8
						elseif hp<atk then
							atknum=atknum+5
						else
							atknum=atknum+3
						end					
					end
				end;
			end
		end
		return atknum;
	elseif flag==3 then							--�����书Ч�����ò㣬���Ĳ�
		CleanWarMap(4,0)
		for i=1,num do
			SetWarMap(xy[i][1],xy[i][2],4,1);
		end
	
	end
		
		
end


function War_FightSelectType(kind,len1,len2,x,y)		--
    local x0=WAR.Person[WAR.CurID]["����X"];
    local y0=WAR.Person[WAR.CurID]["����Y"];
    if x==nil and y==nil then
        x,y=War_SelectMove(kind,len1,len2);              --δָ�������ص㣬ѡ�񹥻�����
		if x ==nil then
			lib.GetKey();
			Cls();
			return false;
		end
	else																	--�Զ�ս��ʱ����ָ�������ص㣬��Զ�ת���������������
		if kind==0 then
			x,y=x0,y0
		elseif kind==8 then
			x,y=x0,y0
		elseif kind==9 then
		    local dx=math.abs(x-x0);
			local dy=math.abs(y-y0);
			local dxy=math.abs(dx-dy)
			if dx+dy~=1 then 			--������ȷ�Ͳ�������
				if dxy==0 or dxy==1 then						--���ﰴ����˵Ӧ���� ==1����Ϊɶʵ��1���������⣿�ţ���ʵ������Զ�ת���ˣ������Ķ�����ȷ������,�޺���
					if x>x0 then
						dx=1
					else
						dx=-1
					end
					if y>y0 then
						dy=1
					else
						dy=-1
					end			
				--lib.Debug(x0..','..y0..'|'..x..','..y..'|'..dx..','..dy)
				else 			
					if dy>dx then
						if y>y0 then
							dx,dy=0,1;
						else
							dx,dy=0,-1;
						end
					else
						if x>x0 then
							dx,dy=1,0;
						else
							dx,dy=-1,0;
						end
					end
				end
				x,y=x0+dx,y0+dy
			end
		elseif kind==10 then
			local dx=x-x0;
			local dy=y-y0;
			--if math.abs(dx+dy)~=1 then
				if math.abs(dy)>math.abs(dx) then
					if y>y0 then
						dx,dy=0,1;
					else
						dx,dy=0,-1;
					end
				else
					if x>x0 then
						dx,dy=1,0;
					else
						dx,dy=-1,0;
					end
				end
				x,y=x0+dx,y0+dy
			--end
		end
		--WarSetPerson()		
		WarDrawAtt(x,y,kind,len1,len2,1)								--��ʾ������Χ����תʱ��ʾ����ȷ��Ӧ��������û���ƶ�����������-�޸���
		ShowScreen();
		lib.Delay(500);
    end

    WAR.Person[WAR.CurID]["�˷���"]=War_Direct(x0,y0,x,y) or WAR.Person[WAR.CurID]["�˷���"]

	SetWarMap(x,y,4,1);

    WAR.EffectXY={};
	WarDrawAtt(x,y,kind,len1,len2,3)


end


function War_SelectMove(kind,len1,len2)              ---ѡ���ƶ�λ��
    local x0=WAR.Person[WAR.CurID]["����X"];
    local y0=WAR.Person[WAR.CurID]["����Y"];
    local x=x0;
    local y=y0;
	if kind~=nil then
		if kind<8 then
			War_CalMoveStep(WAR.CurID,kind,1);
		elseif kind==8 then
			War_CalMoveStep(WAR.CurID,0,1);
		elseif kind==9 then
			War_CalMoveStep(WAR.CurID,2,1);
			SetWarMap(x0+2,y0,3,255)
			SetWarMap(x0-2,y0,3,255)
			SetWarMap(x0,y0+2,3,255)
			SetWarMap(x0,y0-2,3,255)
		elseif kind==10 then
			War_CalMoveStep(WAR.CurID,1,1);
		end
	end
    while true do
        local x2=x;
        local y2=y;

        WarDrawMap(1,x,y);
		if kind~=nil then
			WarDrawAtt(x,y,kind,len1,len2,1)
		end
        ShowScreen();
        local key=WaitKey();
        if key==VK_UP then
            y2=y-1;
        elseif key==VK_DOWN then
            y2=y+1;
        elseif key==VK_LEFT then
            x2=x-1;
        elseif key==VK_RIGHT then
            x2=x+1;
        elseif key==VK_SPACE or key==VK_RETURN then
			if kind==nil or kind<9 or x~=x0 or y~=y0 then
				return x,y;
			end
        elseif key==VK_ESCAPE then
            return nil;
        end

		if GetWarMap(x2,y2,3)<128 then
            x=x2;
            y=y2;
        end
    end

end


function War_PersonLostLife()             --����ս����ÿ�غ������ж������˶���Ѫ
	--�ĳɴ����ж���Ѫ
	--�Լ��书����Ч���ظ�״̬
end


function MyDrawString(x1,x2,y,str,color,size) 
	local len=math.modf(string.len(str)*size/4)
	local x=math.modf((x1+x2)/2)-len
    DrawString(x,y,str,color,size);
end

function ShowPersonStatus(teamid)---��ʾ����״̬
	local teamnum=GetTeamNum();

	while true do
	    Cls();
        local id=JY.Base["����" .. teamid];
        ShowPersonStatus_sub(id);

        ShowScreen();
	    local keypress=WaitKey();
        lib.Delay(100);
        if keypress==VK_ESCAPE then
            break;
        elseif keypress==VK_UP then
		    teamid=teamid-1;
        elseif keypress==VK_DOWN then
		    teamid=teamid+1;
        elseif keypress==VK_LEFT then
		    teamid=teamid-1;
        elseif keypress==VK_RIGHT then
		    teamid=teamid+1;
		elseif keypress==VK_RETURN then
			SetKungfu(id);	--װ���书����
        end
		teamid=limitX(teamid,1,teamnum);
	end
end

function ShowPersonStatus_sub(id)    --��ʾ����״̬ҳ��
    local size=CC.DefaultFont;    --�����С
    local p=JY.Person[id];
    local width=23*size+15;             --18�������ַ���
	local h=size+CC.PersonStateRowPixel;
	local height=13*h+10;                --12�������ַ���
	local dx=(CC.ScreenW-width)/2;
	local dy=(CC.ScreenH-height)/2;

    local x1,y1,x2;

    DrawBox(dx,dy,dx+width,dy+height,C_WHITE);

    x1=dx+5;
	y1=dy+5;
	x2=4*size;
	local headw,headh=lib.PicGetXY(1,p["ͷ�����"]*2);
    local headx=(width/3-headw)/2;
	local heady=(h*5-headh)/2;


    lib.PicLoadCache(1,p["ͷ�����"]*2,x1+headx-10,y1+heady,1);

	y1=y1+130
    MyDrawString(x1,x1+100,y1,p["����"],C_WHITE,size);
    DrawString(x1+8*size/2,y1,string.format("%3d",p["�ȼ�"]+7),C_GOLD,size);
    DrawString(x1+11*size/2,y1,"��",C_ORANGE,size);
	
	y1=y1+30
	local hp=math.modf(p["����"]*160/p["�������ֵ"])
	local mp=math.modf(p["����"]*160/p["�������ֵ"])
	local tp=math.modf(p["����"]*160/100)
	x1=x1+5
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
	x1=x1-5
	local function DrawAttrib1(str,x,y)    --�����ڲ�����
		 local bf=math.modf(p[str]*1.60)
         lib.PicLoadCache(1,163*2,x,y,1);
		 lib.SetClip(x,y,x+bf,y+24)
         lib.PicLoadCache(1,164*2,x,y,1);
		 lib.SetClip(0,0,0,0)
		 DrawString(x+5,y+5,str,C_WHITE,18)
    end
	local function DrawAttrib2(str,x,y)    --�����ڲ��������
		 local bf=math.modf((p[str]-10)/9)
		 local T={"��","��","���","���","����","����","�����","�����","������","������"}
		 DrawString(x,y+2,str,C_WHITE,21)
		 local xxstr=""
		 if bf>0 and bf<11 then xxstr=T[bf] end
		 DrawString(x+45,y+2,xxstr,C_GOLD,21)
    end
	local  function DrawAttrib3(kfnum,kflv,x,y)
		local T={"һ","��","��","��","��","��","��","��","��","ʮ"}
		DrawString(x,y,JY.Wugong[kfnum]["����"],C_WHITE,24)
		DrawString(x+136,y,T[kflv].."��",C_WHITE,24)
	end
    DrawString(x1+14,y1+5,"����",C_WHITE,16);
    DrawString(x1+14,y1+35,"����",C_WHITE,16);
    DrawString(x1+14,y1+65,"����",C_WHITE,16);
	y1=y1+90
	x1=x1+7
	local thezb
	thezb=p["����"] or -1
	DrawString(x1,y1,"����"..":",C_WHITE,21)
	if thezb~=-1 then
	DrawString(x1+56,y1,JY.Thing[thezb]["����"],C_ORANGE,21)
	else DrawString(x1+56,y1,"��",C_ORANGE,21)
	end
	y1=y1+28
	thezb=p["����"] or -1
	DrawString(x1,y1,"����"..":",C_WHITE,21)
	if thezb~=-1 then
	DrawString(x1+56,y1,JY.Thing[thezb]["����"],C_ORANGE,21)
	else DrawString(x1+56,y1,"��",C_ORANGE,21)
	end
	y1=y1+28
	thezb=p["������Ʒ"] or -1
	DrawString(x1,y1,"������Ʒ"..":",C_WHITE,21)
	if thezb~=-1 then
	y1=y1+26
	local skexp=math.modf(p["��������"]*160/TrainNeedExp(id))
	--lib.Debug(skexp..'.'..p["��������"]..','..TrainNeedExp(id))
    lib.PicLoadCache(1,163*2,x1,y1,1);
	lib.SetClip(x1,y1,x1+skexp,y1+21)
    lib.PicLoadCache(1,164*2,x1,y1,1);
	lib.SetClip(0,0,0,0)
	MyDrawString(x1,x1+160,y1,JY.Thing[thezb]["����"],C_ORANGE,21)
	else DrawString(x1+108,y1,"��",C_ORANGE,21)
	end
	y1=y1+28
--lib.Debug("11")
	--[[
    local color;              --��ʾ���������ֵ���������˺��ж���ʾ��ͬ��ɫ
    if p["���˳̶�"]<33 then
        color =RGB(236,200,40);
    elseif p["���˳̶�"]<66 then
        color=RGB(244,128,32);
    else
        color=RGB(232,32,44);
    end
	]]--
	x1=x1+180
	y1=dy+16
	DrawAttrib1("����",x1,y1)
	DrawAttrib1("����",x1,y1+28)
	DrawAttrib1("����",x1,y1+56)
	DrawAttrib1("����",x1,y1+84)
	y1=y1+108
	x1=x1+3
	DrawAttrib2("ȭ��",x1,y1)
	DrawAttrib2("����",x1,y1+24)
	DrawAttrib2("ˣ��",x1,y1+48)
	DrawAttrib2("ʹ��",x1,y1+72)
	DrawAttrib2("����",x1,y1+96)
	y1=y1+120
	DrawAttrib2("ҽ��",x1,y1)
	DrawAttrib2("�ö�",x1,y1+24)
	DrawAttrib2("�ⶾ",x1,y1+48)
	DrawAttrib2("����",x1,y1+72)
	DrawAttrib2("����",x1,y1+96)
	
--lib.Debug("12")
	x1=x1+177
	y1=dy+16;
	DrawString(x1,y1,"�⹦",C_ORANGE,24)
	DrawString(x1,y1+200,"�ڹ�",C_ORANGE,24)
	DrawString(x1,y1+250,"�Ṧ",C_ORANGE,24)
	DrawString(x1,y1+300,"�ؼ�",C_ORANGE,24)
	y1=y1+25
	local nei,qing,te=p["�ڹ�"],p["�Ṧ"],p["�ؼ�"]
	for i=1,CC.Kungfunum do
		if p["�书"][i]~=nil then
		local kfnum=p["�书"][i][1]
		local kflv=div100(p["�书"][i][2] or 0)+1
		local kfkind=JY.Wugong[kfnum]["�书����"]
			if kfkind<6 and kfnum~=0 then
				DrawAttrib3(kfnum,kflv,x1,y1)
				y1=y1+25
			elseif i==nei then
				DrawAttrib3(kfnum,kflv,x1,293)		
			elseif i==qing then
				DrawAttrib3(kfnum,kflv,x1,343)		
			elseif i==te then
				DrawAttrib3(kfnum,kflv,x1,393)		
			end
		end
	end
	
	
end


function WarDrawMap(flag,v1,v2,v3)
    local x=WAR.Person[WAR.CurID]["����X"];
    local y=WAR.Person[WAR.CurID]["����Y"];
    if flag==0 then
	    lib.DrawWarMap(0,x,y,0,0,-1);
    elseif flag==1 then
		if WAR.Data["��ͼ"]==0 then     --ѩ�ص�ͼ�ú�ɫ����
		    lib.DrawWarMap(1,x,y,v1,v2,-1);		
		else
		    lib.DrawWarMap(2,x,y,v1,v2,-1);			
		end
	elseif flag==2 then
	    lib.DrawWarMap(3,x,y,0,0,-1);
	elseif flag==4 then
		if v3>2972 then
			local function thexy(nx,ny,ox,oy)
				local dx,dy=nx-ox,ny-oy
				return CC.ScreenW/2+CC.XScale*(dx-dy),CC.ScreenH/2+CC.YScale*(dx+dy)	
			end
			lib.DrawWarMap(4,x,y,v1,v2,-1);
			for i=0,63 do
				for j=0,63 do
					if GetWarMap(i,j,4)>0 then
						local xx,xy=thexy(i,j,x,y)
						xy=fyxy(xy,v3)
						lib.PicLoadCache(3,v3,xx,xy,0,0)
					end
				end
			end		
		else
			lib.DrawWarMap(4,x,y,v1,v2,v3);
		end
	end
	if WAR.ShowHead==1 then
        WarShowHead();
	end
end


function fyxy(y,num)
--����eft��pngͼƬ��yƫ�ƣ�����ֵ���޸ĺ��
	if num>3218 then return y-75
	elseif num>3192 then return y-45
	elseif num>3166 then return y-45
	elseif num>3158 then return y-45
	elseif num>3130 then return y-45
	elseif num>3068 then return y-60
	elseif num>3042 then return y-70
	elseif num>3030 then return y-35
	elseif num>2972 then return y-45
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
		steparray[i].bushu={};
        steparray[i].x={};
        steparray[i].y={};
	end

	SetWarMap(x,y,3,0);
    steparray[0].num=1;
	steparray[0].bushu[1]=stepmax;					--�����ƶ��Ĳ���
	steparray[0].x[1]=x;
	steparray[0].y[1]=y;
	War_FindNextStep(steparray,0,id,flag);

	return steparray;

end

--������ĺ�������
function War_FindNextStep(steparray,step,id,flag)      --������һ�����ƶ�������
    local num=0;
	local step1=step+1;
	
	local function fujinnum(tx,ty)
		local tnum=0
		local wofang=WAR.Person[id]["�ҷ�"]
		local tv;
		tv=GetWarMap(tx+1,ty,2);
		if tv~=-1 then
			if WAR.Person[tv]["�ҷ�"]~=wofang then
				tnum=tnum+1
			end
		end
		tv=GetWarMap(tx-1,ty,2);
		if tv~=-1 then
			if WAR.Person[tv]["�ҷ�"]~=wofang then
				tnum=tnum+1
			end
		end
		tv=GetWarMap(tx,ty+1,2);
		if tv~=-1 then
			if WAR.Person[tv]["�ҷ�"]~=wofang then
				tnum=tnum+1
			end
		end
		tv=GetWarMap(tx,ty-1,2);
		if tv~=-1 then
			if WAR.Person[tv]["�ҷ�"]~=wofang then
				tnum=tnum+1
			end
		end
		return tnum
	end
	
	
	
	for i=1,steparray[step].num do
		if steparray[step].bushu[i]>0 then
		steparray[step].bushu[i]=steparray[step].bushu[i]-1;
	    local x=steparray[step].x[i];
	    local y=steparray[step].y[i];
	    if x+1<CC.WarWidth-1 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x+1,y,3);
			if v ==255 and War_CanMoveXY(x+1,y,flag)==true then
                num= num+1;
                steparray[step1].x[num]=x+1;
                steparray[step1].y[num]=y;
				SetWarMap(x+1,y,3,step1);
				steparray[step1].bushu[num]=steparray[step].bushu[i]-fujinnum(x+1,y);
			end
		end

	    if x-1>0 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x-1,y,3);
			if v ==255 and War_CanMoveXY(x-1,y,flag)==true then
                 num=num+1;
                steparray[step1].x[num]=x-1;
                steparray[step1].y[num]=y;
				SetWarMap(x-1,y,3,step1);
				steparray[step1].bushu[num]=steparray[step].bushu[i]-fujinnum(x-1,y);
			end
		end

	    if y+1<CC.WarHeight-1 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x,y+1,3);
			if v ==255 and War_CanMoveXY(x,y+1,flag)==true then
                 num= num+1;
                steparray[step1].x[num]=x;
                steparray[step1].y[num]=y+1;
				SetWarMap(x,y+1,3,step1);
				steparray[step1].bushu[num]=steparray[step].bushu[i]-fujinnum(x,y+1);
			end
		end

	    if y-1>0 then                        --��ǰ���������ڸ�
		    local v=GetWarMap(x ,y-1,3);
			if v ==255 and War_CanMoveXY(x,y-1,flag)==true then
                num= num+1;
                steparray[step1].x[num]=x ;
                steparray[step1].y[num]=y-1;
				SetWarMap(x ,y-1,3,step1);
				steparray[step1].bushu[num]=steparray[step].bushu[i]-fujinnum(x,y-1);
			end
		end
		end
	end
	if num==0 then return end;
    steparray[step1].num=num;
	--���Լ���һ�����򣬰Ѳ����͵ķź���
	--��������������Ļ���zoc��Ч���ͺܼ���������...
	for i=1,num-1 do
		for j=i+1,num do
			if steparray[step1].bushu[i]<steparray[step1].bushu[j] then
				steparray[step1].bushu[i],steparray[step1].bushu[j]=steparray[step1].bushu[j],steparray[step1].bushu[i]
				steparray[step1].x[i],steparray[step1].x[j]=steparray[step1].x[j],steparray[step1].x[i]
				steparray[step1].y[i],steparray[step1].y[j]=steparray[step1].y[j],steparray[step1].y[i]
			end
		end
	end
	
	
	War_FindNextStep(steparray,step1,id,flag)

end


--��дAI

--AI�е��Զ�����
	--��Ҫ������ƶ�����,�书�Ĺ�����Χ,
	--�����书��Χ�ĸ�ʽ {a,b,c,d,e,...},��Ҫ��a,�����Ƕ���(0)���Ƿ���(1,2)
	--���ǳ���,������һ�ι���ɱ������
	--һ�����:1--��ɱ����:5--����:50

function unnamed(kungfuid,kungfulv)
	local pid=WAR.Person[WAR.CurID]["������"]
	local kungfuatk=GetAtk(pid,kungfuid,kungfulv)										--�书������
	local fanwei=JY.Wugong[kungfuid]["��Χ"][math.modf(kungfulv/3)+1]		--ʵ���书��Χ
	local atkarray={}
	local num=0
	
 	CleanWarMap(4,-1);    --��level 4��ͼ��ʾ��λ�ÿ��Թ�������Ŀ
									-- -1��ʾ�˵㻹û����
	local movearray=War_CalMoveStep(pid,WAR.Person[WAR.CurID]["�ƶ�����"],0)		--�ƶ���
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
			atkarray[num].p,atkarray[num].ax,atkarray[num].ay=GetAtkNum(xx,yy,fanwei,kungfuatk)
		end
		
	end
	
	--ȥ���õ���͵�
	for i=1,num-1 do
		for j=i+1,num do
			if atkarray[i].p<atkarray[j].p then
				atkarray[i],atkarray[j]=atkarray[j],atkarray[i]
			end
		end
	end
	for i=1,num do
		if atkarray[i].p<atkarray[1].p/2 then
			num=i-1
			break;
		end
	end
	--��������ƶ�Ŀ�ĵأ����Ǻû�
	--����ǰ������,������ҷ���-2,�������·-2,����ǵ���:
	--��һ������,������,���Ϊ1,��-10,���Ϊ2,��-5
	--���Ǹ�������,���������Ϊ1,��+10,��Ϊ2,��+5
	local wofang=WAR.Person[WAR.CurID]["�ҷ�"]
	local function getqi(nx,ny)
		local qi=4
		local nv
		
		nv=GetWarMap(nx+1,ny,2)
		if nv~=-1 and nv~=WAR.CurID then
			qi=qi-1
		elseif not War_CanMoveXY(nx+1,ny,0) then
			qi=qi-1
		end
		
		nv=GetWarMap(nx-1,ny,2)
		if nv~=-1 and nv~=WAR.CurID then
			qi=qi-1
		elseif not War_CanMoveXY(nx-1,ny,0) then
			qi=qi-1
		end
		
		nv=GetWarMap(nx,ny+1,2)
		if nv~=-1 and nv~=WAR.CurID then
			qi=qi-1
		elseif not War_CanMoveXY(nx,ny+1,0) then
			qi=qi-1
		end
		
		nv=GetWarMap(nx,ny-1,2)
		if nv~=-1 and nv~=WAR.CurID then
			qi=qi-1
		elseif not War_CanMoveXY(nx,ny-1,0) then
			qi=qi-1
		end
		return qi
	end
	for i=1,num do
		local v
		local theqi=getqi(atkarray[i].x,atkarray[i].y)
		if theqi==1 then 
			atkarray[i].p=atkarray[i].p-5
		elseif theqi==2 then
			atkarray[i].p=atkarray[i].p-2
		end
		v=GetWarMap(atkarray[i].x-1,atkarray[i].y,2);
		if v~=-1 and v~=WAR.CurID then
			if WAR.Person[v]["�ҷ�"]~=wofang then
				theqi=getqi(atkarray[i].x-1,atkarray[i].y)
				if theqi==1 then 
					atkarray[i].p=atkarray[i].p+10 
				elseif theqi==2 then
					atkarray[i].p=atkarray[i].p+5
				end
			else
				atkarray[i].p=atkarray[i].p-2
			end			
		elseif not War_CanMoveXY(atkarray[i].x-1,atkarray[i].y) then
			atkarray[i].p=atkarray[i].p-2			
		end
		
		v=GetWarMap(atkarray[i].x+1,atkarray[i].y,2);
		if v~=-1 and v~=WAR.CurID then
			if WAR.Person[v]["�ҷ�"]~=wofang then
				theqi=getqi(atkarray[i].x+1,atkarray[i].y)
				if theqi==1 then 
					atkarray[i].p=atkarray[i].p+10 
				elseif theqi==2 then
					atkarray[i].p=atkarray[i].p+5
				end
			else
				atkarray[i].p=atkarray[i].p-2
			end			
		elseif not War_CanMoveXY(atkarray[i].x+1,atkarray[i].y) then
			atkarray[i].p=atkarray[i].p-2			
		end
		
		v=GetWarMap(atkarray[i].x,atkarray[i].y-1,2);
		if v~=-1 and v~=WAR.CurID then
			if WAR.Person[v]["�ҷ�"]~=wofang then
				theqi=getqi(atkarray[i].x,atkarray[i].y-1)
				if theqi==1 then 
					atkarray[i].p=atkarray[i].p+10 
				elseif theqi==2 then
					atkarray[i].p=atkarray[i].p+5
				end
			else
				atkarray[i].p=atkarray[i].p-2
			end			
		elseif not War_CanMoveXY(atkarray[i].x,atkarray[i].y-1) then
			atkarray[i].p=atkarray[i].p-2			
		end
		
		v=GetWarMap(atkarray[i].x,atkarray[i].y+1,2);
		if v~=-1 and v~=WAR.CurID then
			if WAR.Person[v]["�ҷ�"]~=wofang then
				theqi=getqi(atkarray[i].x,atkarray[i].y+1)
				if theqi==1 then 
					atkarray[i].p=atkarray[i].p+10 
				elseif theqi==2 then
					atkarray[i].p=atkarray[i].p+5
				end
			else
				atkarray[i].p=atkarray[i].p-2
			end			
		elseif not War_CanMoveXY(atkarray[i].x,atkarray[i].y+1) then
			atkarray[i].p=atkarray[i].p-2			
		end
		
		if atkarray[i].p<1 then atkarray[i].p=1 end
		
	end

	for i=1,1 do
		for j=i+1,num do
			if atkarray[i].p<atkarray[j].p then
				atkarray[i],atkarray[j]=atkarray[j],atkarray[i]
			end
		end
	end
	
	return 

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
	--[[for i=0,128 do
	    steparray[i]={};
		steparray[i].bushu={};
        steparray[i].x={};
        steparray[i].y={};
	end--]]
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
