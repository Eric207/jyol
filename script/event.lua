--------------------------------------------------------------------------------
--------------------------------------�¼�����-----------------------------------

--�¼����������
--id��d*�еı��
--flag 1 �ո񴥷���2����Ʒ������3��·������
function EventExecute(id,flag)               --�¼����������
    JY.CurrentD=id;
    if JY.SceneNewEventFunction[JY.SubScene]==nil then         --û�ж����µ��¼������������þɵ�
        oldEventExecute(flag)
	else
        JY.SceneNewEventFunction[JY.SubScene](flag)         --�����µ��¼�������
    end
    JY.CurrentD=-1;
	JY.Darkness=0;
end

--����ԭ�е�ָ��λ�õĺ���
--�ɵĺ������ָ�ʽΪ  oldevent_xxx();  xxxΪ�¼����
function oldEventExecute(flag)            --����ԭ�е�ָ��λ�õĺ���

	local eventnum;
	if flag==1 then
		eventnum=GetD(JY.SubScene,JY.CurrentD,2);
	elseif flag==2 then
		eventnum=GetD(JY.SubScene,JY.CurrentD,3);
	elseif flag==3 then
		eventnum=GetD(JY.SubScene,JY.CurrentD,4);
	end

	if eventnum>0 then
	    oldCallEvent(eventnum);
	end

end

function oldCallEvent(eventnum)     --ִ�оɵ��¼�����
	local eventfilename=string.format("oldevent_%d.lua",eventnum);
	lib.Debug(eventfilename);
	dofile(CONFIG.OldEventPath .. eventfilename);
end


--�ı���ͼ���꣬�ӳ�����ȥ���ƶ�����Ӧ����
function ChangeMMap(x,y,direct)          --�ı���ͼ����
	JY.Base["��X"]=x;
	JY.Base["��Y"]=y;
	JY.Base["�˷���"]=direct;
end

--�ı䵱ǰ����
function ChangeSMap(sceneid,x,y,direct)       --�ı䵱ǰ����
    JY.SubScene=sceneid;
	JY.Base["��X1"]=x;
	JY.Base["��Y1"]=y;
	JY.Base["�˷���"]=direct;
end




--�����Ի���ʾ��Ҫ���ַ�������ÿ��n�������ַ���һ���Ǻ�
function GenTalkString(str,n)              --�����Ի���ʾ��Ҫ���ַ���
    local tmpstr="";
	local num=0;
    for s in string.gmatch(str .. "*","(.-)%*") do           --ȥ���Ի��е�����*. �ַ���β����һ���Ǻţ������޷�ƥ��
        tmpstr=tmpstr .. s;
    end

    local newstr="";
    while #tmpstr>0 do
		num=num+1;
		local w=0;
		while w<#tmpstr do
		    local v=string.byte(tmpstr,w+1);          --��ǰ�ַ���ֵ
			if v>=128 then
			    w=w+2;
			else
			    w=w+1;
			end
			if w >= 2*n-1 then     --Ϊ�˱����������ַ�
			    break;
			end
		end

        if w<#tmpstr then
		    if w==2*n-1 and string.byte(tmpstr,w+1)<128 then
				newstr=newstr .. string.sub(tmpstr,1,w+1) .. "*";
				tmpstr=string.sub(tmpstr,w+2,-1);
			else
				newstr=newstr .. string.sub(tmpstr,1,w)  .. "*";
				tmpstr=string.sub(tmpstr,w+1,-1);
			end
		else
		    newstr=newstr .. tmpstr;
			break;
		end
	end
    return newstr,num;
end

--��򵥰汾�Ի�
function Talk(s,personid)            --��򵥰汾�Ի�
    local flag;
    if personid==0 then
        flag=1;
	else
	    flag=0;
	end
	TalkEx(s,JY.Person[personid]["ͷ�����"],flag);
end


--���Ӱ汾�Ի�
--s �ַ������������*��Ϊ���У��������û��*,����Զ�����
function TalkEx(s,headid,flag)          --���Ӱ汾�Ի�
    local picw=100;       --���ͷ��ͼƬ���
	local pich=100;
	local talkxnum=12;         --�Ի�һ������
	local talkynum=3;          --�Ի�����
	local dx=2;
	local dy=2;
    local boxpicw=picw+10;
	local boxpich=pich+10;
	local boxtalkw=12*CC.Fontbig+10;
	local boxtalkh=boxpich;

    local talkBorder=(pich-talkynum*CC.Fontbig)/(talkynum+1);

	--��ʾͷ��ͶԻ�������
    local xy={ [0]={headx=dx,heady=dy,
	                talkx=dx+boxpicw+2,talky=dy,
					showhead=1},
                   {headx=CC.ScreenW-1-dx-boxpicw,heady=CC.ScreenH-dy-boxpich,
				    talkx=CC.ScreenW-1-dx-boxpicw-boxtalkw-2,talky= CC.ScreenH-dy-boxpich,
					showhead=1},
                   {headx=dx,heady=dy,
				   talkx=dx+boxpicw+2,talky=dy,
				   showhead=0},
                   {headx=CC.ScreenW-1-dx-boxpicw,heady=CC.ScreenH-dy-boxpich,
				   talkx=CC.ScreenW-1-dx-boxpicw-boxtalkw-2,talky= CC.ScreenH-dy-boxpich,
					showhead=1},
                   {headx=CC.ScreenW-1-dx-boxpicw,heady=dy,
				    talkx=CC.ScreenW-1-dx-boxpicw-boxtalkw-2,talky=dy,showhead=1},
                   {headx=dx,heady=CC.ScreenH-dy-boxpich,talkx=dx+boxpicw+2,talky=CC.ScreenH-dy-boxpich,showhead=1}, }

    if flag<0 or flag>5 then
        flag=0;
    end

    if xy[flag].showhead==0 then
        headid=-1;
    end

	if string.find(s,"*") ==nil then
	    s=GenTalkString(s,12);
	end

    if CONFIG.KeyRepeat==0 then
	     lib.EnableKeyRepeat(0,CONFIG.KeyRepeatInterval);
	end
    lib.GetKey();

    local startp=1
    local endp;
    local dy=0;
    while true do
        if dy==0 then
		    Cls();
            if headid>=0 then
                DrawBox(xy[flag].headx, xy[flag].heady, xy[flag].headx + boxpicw, xy[flag].heady + boxpich,C_WHITE);
				local w,h=lib.PicGetXY(1,headid*2);
                local x=(picw-w)/2;
				local y=(pich-h)/2;
				lib.PicLoadCache(1,headid*2,xy[flag].headx+5+x,xy[flag].heady+5+y,1);
            end
            DrawBox(xy[flag].talkx, xy[flag].talky, xy[flag].talkx +boxtalkw, xy[flag].talky + boxtalkh,C_WHITE);
        end
        endp=string.find(s,"*",startp);
        if endp==nil then
            DrawString(xy[flag].talkx + 5, xy[flag].talky + 5+talkBorder + dy * (CC.Fontbig+talkBorder),string.sub(s,startp),C_WHITE,CC.Fontbig);
            ShowScreen();
            WaitKey();
            break;
        else
            DrawString(xy[flag].talkx + 5, xy[flag].talky + 5+talkBorder + dy * (CC.Fontbig+talkBorder),string.sub(s,startp,endp-1),C_WHITE,CC.Fontbig);
        end
        dy=dy+1;
        startp=endp+1;
        if dy>=talkynum then
            ShowScreen();
            WaitKey();
            dy=0;
        end
    end

    if CONFIG.KeyRepeat==0 then
	     lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay,CONFIG.KeyRepeatInterval);
	end

	Cls();
end

--����ָ�ռλ����
function instruct_test(s)
    DrawStrBoxWaitKey(s,C_ORANGE,24);
end

--����
function instruct_0()         --����
    Cls();
end

--�Ի�
--talkid: Ϊ���֣���Ϊ�Ի���ţ�Ϊ�ַ�������Ϊ�Ի�����
--headid: ͷ��id
--flag :�Ի���λ�ã�0 ��Ļ�Ϸ���ʾ, ���ͷ���ұ߶Ի�
--            1 ��Ļ�·���ʾ, ��߶Ի����ұ�ͷ��
--            2 ��Ļ�Ϸ���ʾ, ��߿գ��ұ߶Ի�
--            3 ��Ļ�·���ʾ, ��߶Ի����ұ߿�
--            4 ��Ļ�Ϸ���ʾ, ��߶Ի����ұ�ͷ��
--            5 ��Ļ�·���ʾ, ���ͷ���ұ߶Ի�

function instruct_1(talkid,headid,flag)        --�Ի�
    local s=ReadTalk(talkid);
	if s==nil then        --�Ի�id������
	    return ;
	end
    TalkEx(s,headid,flag);
end

function GetItem(tid,num)
	instruct_2(tid,num);
end
--�õ���Ʒ
function instruct_2(thingid,num)            --�õ���Ʒ
    if JY.Thing[thingid]==nil then   --�޴���Ʒid
        return ;
	end

    instruct_32(thingid,num);    --������Ʒ
    DrawStrBoxWaitKey(string.format("�õ���Ʒ:%s %d",JY.Thing[thingid]["����"],num),C_ORANGE,CC.Fontbig);
    --instruct_2_sub();         --�Ƿ�ɵ�������
end

--����>200�Լ�14�����õ�������
function instruct_2_sub()               --����>200�Լ�14�����õ�������

    if JY.Person[0]["����"] < 200 then
        return ;
    end

    if instruct_18(189) ==true then            --���������� 189 ������id
        return;
    end

    local booknum=0;
    for i=1,CC.BookNum do
        if instruct_18(CC.BookStart+i-1)==true then
            booknum=booknum+1;
        end
    end

    if booknum==CC.BookNum then        --�������Ǿ������ϵ��������¼�
        instruct_3(70,11,-1,1,932,-1,-1,7968,7968,7968,-2,-2,-2);
    end
end

--�޸�D*
-- sceneid ����id, -2��ʾ��ǰ����
-- id  D*��id�� -2��ʾ��ǰid
-- v0 - v10 D*������ -2��ʾ�˲�������
function ModifyD(sceneid,id,v0,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10)
	instruct_3(sceneid,id,v0,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10)
end
function instruct_3(sceneid,id,v0,v1,v2,v3,v4,v5,v6,v7,v8,v9,v10)     --�޸�D*
    if sceneid==-2 then
        sceneid=JY.SubScene;
    end
    if id==-2 then
        id=JY.CurrentD;
    end

    if v0~=-2 then
        SetD(sceneid,id,0,v0)
    end
    if v1~=-2 then
        SetD(sceneid,id,1,v1)
    end
    if v2~=-2 then
        SetD(sceneid,id,2,v2)
    end
    if v3~=-2 then
        SetD(sceneid,id,3,v3)
    end
    if v4~=-2 then
        SetD(sceneid,id,4,v4)
    end
    if v5~=-2 then
        SetD(sceneid,id,5,v5)
    end
    if v6~=-2 then
        SetD(sceneid,id,6,v6)
    end
    if v7~=-2 then
        SetD(sceneid,id,7,v7)
    end
    if v8~=-2 then
        SetD(sceneid,id,8,v8)
    end

    if v9~=-2 and v10 ~=-2 then
	    if v9>=0 and v10 >=0 then   --Ϊ�˺Ͳ������ݣ��޸ĵ����겻��Ϊ0
            SetS(sceneid,GetD(sceneid,id,9),GetD(sceneid,id,10),3,-1);   --���xy�����ƶ��ˣ���ôS����Ӧ����Ҫ�޸ġ�
            SetD(sceneid,id,9,v9)
            SetD(sceneid,id,10,v10)
            SetS(sceneid,GetD(sceneid,id,9),GetD(sceneid,id,10),3,id);
		end
	end
end

--�Ƿ�ʹ����Ʒ����
function instruct_4(thingid)         --�Ƿ�ʹ����Ʒ����
    if JY.CurrentThing==thingid then
        return true;
    else
        return false;
    end
end


function instruct_5()         --ѡ��ս��
    return DrawStrBoxYesNo(-1,-1,"�Ƿ���֮����(Y/N)?",C_ORANGE,CC.Fontbig);
end


function instruct_6(warid,tmp,tmp,flag)      --ս��
    return WarMain(warid,flag);
end


function instruct_7()                 --�Ѿ�����Ϊreturn��
    instruct_test("ָ��7����")
end


function instruct_8(musicid)            --�ı�����ͼ����
    JY.MmapMusic=musicid;
end


function instruct_9()                --�Ƿ�Ҫ��������
    Cls();
    return DrawStrBoxYesNo(-1,-1,"�Ƿ�Ҫ�����(Y/N)?",C_ORANGE,CC.Fontbig);
end

function addteam(pid)
    if JY.Person[pid]==nil then
        lib.Debug("instruct_10 error: person id not exist");
		return ;
    end
    local add=0;
    for i =2, CC.TeamNum do             --��һ��λ�������ǣ��ӵڶ�����ʼ
        if JY.Base["����"..i]<0 then
            JY.Base["����"..i]=pid;
            add=1;
			JY.Person[pid]["����"]=0;
            break;
        end
    end
    if add==0 then
        say("��Ķ������������޷����롣",JY.Da);
        return ;
    end
end
function instruct_10(personid)            --�����Ա
    if JY.Person[personid]==nil then
        lib.Debug("instruct_10 error: person id not exist");
		return ;
    end
    local add=0;
    for i =2, CC.TeamNum do             --��һ��λ�������ǣ��ӵڶ�����ʼ
        if JY.Base["����"..i]<0 then
            JY.Base["����"..i]=personid;
            add=1;
            break;
        end
    end
    if add==0 then
        lib.Debug("instruct_10 error: �����������");
        return ;
    end

    for i =1,4 do                --������Ʒ�鹫
        local id =JY.Person[personid]["Я����Ʒ" .. i];
        local n=JY.Person[personid]["Я����Ʒ����" .. i];
        if id>=0 and n>0 then
            instruct_2(id,n);
            JY.Person[personid]["Я����Ʒ" .. i]=-1;
            JY.Person[personid]["Я����Ʒ����" .. i]=0;
        end
    end
end


function instruct_11()              --�Ƿ�ס��
    Cls();
    return DrawStrBoxYesNo(-1,-1,"�Ƿ�ס��(Y/N)?",C_ORANGE,CC.Fontbig);
end


function instruct_12()             --ס�ޣ��ظ�����
    for i=1,CC.TeamNum do
        local id=JY.Base["����" .. i];
        if id>=0 then
            if JY.Person[id]["���˳̶�"]<33 and JY.Person[id]["�ж��̶�"]<=0 then
                JY.Person[id]["���˳̶�"]=0;
                AddPersonAttrib(id,"����",math.huge);     --��һ���ܴ��ֵ���Զ�����Ϊ���ֵ
                AddPersonAttrib(id,"����",math.huge);
                AddPersonAttrib(id,"����",math.huge);
            end
        end
    end
end

function rest_old()             --ס�ޣ��ظ�����
	Dark();
    for i=1,CC.TeamNum do
        local id=JY.Base["����" .. i];
        if id>=0 then
            if JY.Person[id]["����"]<=0 and JY.Person[id]["�ж�"]<=0 and JY.Person[id]["��Ѫ"]<=0 then
                AddPersonAttrib(id,"����",math.huge);     --��һ���ܴ��ֵ���Զ�����Ϊ���ֵ
                AddPersonAttrib(id,"����",math.huge);
                AddPersonAttrib(id,"����",math.huge);
            end
        end
    end
	lib.Delay(1000);
	WaitKey();
	Light();
end

function rest()
	lib.GetKey();
	local size=CC.Fontbig;
	local color=C_WHITE;
    local ll=12;
    local w=size*ll/2+2*CC.MenuBorderPixel;
	local h=size+2*CC.MenuBorderPixel;
    local x=(CC.ScreenW-size/2*ll-2*CC.MenuBorderPixel)/2;
    local y=(CC.ScreenH-size-2*CC.MenuBorderPixel)/2;

    DrawStrBox(x,y,"�Ƿ�Ҫ��Ϣ��",color,size);
    local menu=	{
							{"��Ϣһ��",nil,1},
							{"��Ϣ����",nil,1},
							{"�ָ�����",nil,0},
							{"�ָ�ȫ��",nil,0},
							{"��Ҫ��Ϣ",nil,2},
						};
	if JY.Person[0]["����"]<=0 and JY.Person[0]["�ж�"]<=0 and JY.Person[0]["��Ѫ"]<=0 then
		menu[3][3]=1;
		menu[4][3]=1;
	end
	local r=ShowMenu(menu,5,0,x+w-4*size-2*CC.MenuBorderPixel,y+h+CC.MenuBorderPixel,0,0,1,0,CC.Fontbig,C_ORANGE, C_WHITE)
	Cls();
    if r==1 then
		Dark();
		lib.Delay(500);
		--WaitKey();
	    if DayPass(1,8) then
			for i=1,CC.TeamNum do
				local id=JY.Base["����" .. i];
				if id>=0 then
					if JY.Person[id]["����"]<=0 and JY.Person[id]["�ж�"]<=0 and JY.Person[id]["��Ѫ"]<=0 then
						AddPersonAttrib(id,"����",180+Rnd(20));
						AddPersonAttrib(id,"����",160+Rnd(40));
						if id>0 then
							AddPersonAttrib(id,"����",8);
						end
					end
				end
			end
			Light();
		end
	elseif r==2 then
		Dark();
		lib.Delay(500);
		--WaitKey();
	    if DayPass(3,8) then
			for i=1,CC.TeamNum do
				local id=JY.Base["����" .. i];
				if id>=0 then
					if JY.Person[id]["����"]<=0 and JY.Person[id]["�ж�"]<=0 and JY.Person[id]["��Ѫ"]<=0 then
						AddPersonAttrib(id,"����",3*180+Rnd(20));
						AddPersonAttrib(id,"����",3*160+Rnd(40));
						if id>0 then
							AddPersonAttrib(id,"����",3*8);
						end
					end
				end
			end
			Light();
		end
	elseif r==3 then
		local n=math.modf((107-JY.Person[0]["����"])/8);
		if n<1 then
			return false;
		end
		Dark();
		lib.Delay(500);
		--WaitKey();
		if DayPass(n,8) then
			for i=1,CC.TeamNum do
				local id=JY.Base["����" .. i];
				if id>=0 then
					if JY.Person[id]["����"]<=0 and JY.Person[id]["�ж�"]<=0 and JY.Person[id]["��Ѫ"]<=0 then
						AddPersonAttrib(id,"����",n*180+Rnd(20));
						AddPersonAttrib(id,"����",n*160+Rnd(40));
						if id>0 then
							AddPersonAttrib(id,"����",n*8);
						end
					end
				end
			end
			Light();
		end
	elseif r==4 then
		Dark();
		lib.Delay(500);
		while JY.Person[0]["����"]<100 or JY.Person[0]["����"]<JY.Person[0]["�������ֵ"] or JY.Person[0]["����"]<JY.Person[0]["�������ֵ"] do
			if DayPass(1,8) then
				for i=1,CC.TeamNum do
					local id=JY.Base["����" .. i];
					if id>=0 then
						if JY.Person[id]["����"]<=0 and JY.Person[id]["�ж�"]<=0 and JY.Person[id]["��Ѫ"]<=0 then
							AddPersonAttrib(id,"����",180+Rnd(5));
							AddPersonAttrib(id,"����",160+Rnd(10));
							if id>0 then
								AddPersonAttrib(id,"����",8);
							end
						end
					end
				end
			end
		end
		Light();
	elseif r==5 then
	    return false;
	end
	return true;
end

function Light()            --��������
    Cls();
	if JY.Darkness==1 then
		lib.ShowSlow(50,0);
		JY.Darkness=0;
		lib.GetKey();
	end
end


function Dark()             --�������
	if JY.Darkness==0 then
		lib.ShowSlow(50,1);
		JY.Darkness=1;
		lib.GetKey();
	end
end


function instruct_15()          --game over
    JY.Status=GAME_DEAD;
    Cls();
    DrawString(CC.GameOverX,CC.GameOverY,JY.Person[0]["����"],RGB(0,0,0),CC.Fontbig);

	local x=CC.ScreenW-9*CC.Fontbig;
    DrawString(x,10,os.date("%Y-%m-%d %H:%M"),RGB(216, 20, 24) ,CC.Fontbig);
    DrawString(x,10+CC.Fontbig+CC.RowPixel,"�ڵ����ĳ��",RGB(216, 20, 24) ,CC.Fontbig);
    DrawString(x,10+(CC.Fontbig+CC.RowPixel)*2,"�����˿ڵ�ʧ����",RGB(216, 20, 24) ,CC.Fontbig);
    DrawString(x,10+(CC.Fontbig+CC.RowPixel)*3,"�ֶ���һ�ʡ�����",RGB(216, 20, 24) ,CC.Fontbig);

    local loadMenu={ {"�������һ",nil,1},
                     {"������ȶ�",nil,1},
                     {"���������",nil,1},
                     {"�ؼ�˯��ȥ",nil,1} };
    local y=CC.ScreenH-4*(CC.Fontbig+CC.RowPixel)-10;
    local r=ShowMenu(loadMenu,4,0,x,y,0,0,0,0,CC.Fontbig,C_ORANGE, C_WHITE)

    if r<4 then
        LoadRecord(r);
        JY.Status=GAME_FIRSTMMAP;
    else
        JY.Status=GAME_END;
    end

end


function instruct_16(personid)      --�������Ƿ���ĳ��
    local r=false;
    for i = 1, CC.TeamNum do
        if personid==JY.Base["����" .. i] then
            r=true;
            break;
        end
    end;
    return r;
end


function instruct_17(sceneid,level,x,y,v)     --�޸ĳ���ͼ��
    if sceneid==-2 then
        sceneid=JY.SubScene;
    end
    SetS(sceneid,x,y,level,v);
end


function instruct_18(thingid)           --�Ƿ���ĳ����Ʒ
    for i = 1,CC.MyThingNum do
        if JY.Base["��Ʒ" .. i]==thingid then
            return true;
        end
    end
    return false;
end


function instruct_19(x,y)             --�ı�����λ��
    JY.Base["��X1"]=x;
    JY.Base["��Y1"]=y;
	JY.SubSceneX=0;
	JY.SubSceneY=0;
end


function instruct_20()                 --�ж϶����Ƿ���
    if JY.Base["����" .. CC.TeamNum ] >=0 then
        return true;
    end
    return false;
end

function decteam(pid)
    if JY.Person[pid]==nil then
        lib.Debug("instruct_21 error: personid not exist");
        return ;
    end
    local j=0;
    for i = 1, CC.TeamNum do
        if pid==JY.Base["����" .. i] then
            j=i;
            break;
        end
    end;
    if j==0 then
       return;
    end
    for  i=j+1,CC.TeamNum do
        JY.Base["����" .. i-1]=JY.Base["����" .. i];
		JY.Person[pid]["����"]=JY.Shop[JY.Person[pid]["����"]]["�ݵ�"];
    end
    JY.Base["����" .. CC.TeamNum]=-1;
end
function instruct_21(personid)               --���
    if JY.Person[personid]==nil then
        lib.Debug("instruct_21 error: personid not exist");
        return ;
    end
    local j=0;
    for i = 1, CC.TeamNum do
        if personid==JY.Base["����" .. i] then
            j=i;
            break;
        end
    end;
    if j==0 then
       return;
    end

    for  i=j+1,CC.TeamNum do
        JY.Base["����" .. i-1]=JY.Base["����" .. i];
    end
    JY.Base["����" .. CC.TeamNum]=-1;

    if JY.Person[personid]["����"]>=0 then
        JY.Thing[JY.Person[personid]["����"]]["ʹ����"]=-1;
        JY.Person[personid]["����"]=-1
    end
    if JY.Person[personid]["����"]>=0 then
        JY.Thing[JY.Person[personid]["����"]]["ʹ����"]=-1;
        JY.Person[personid]["����"]=-1;
    end

    if JY.Person[personid]["������Ʒ"]>=0 then
        JY.Thing[JY.Person[personid]["������Ʒ"]]["ʹ����"]=-1;
        JY.Person[personid]["������Ʒ"]=-1;
    end

    JY.Person[personid]["��������"]=0;
    JY.Person[personid]["��Ʒ��������"]=0;
end


function instruct_22()            --������Ϊ0
    for i = 1, CC.TeamNum do
        if JY.Base["����" .. i] >=0 then
            JY.Person[JY.Base["����" .. i]]["����"]=0;
        end
    end
end


function instruct_23(personid,value)           --�����ö�
    JY.Person[personid]["�ö�����"]=value;
    AddPersonAttrib(personid,"�ö�����",0)
end

--��ָ��
function instruct_24()
    instruct_test("ָ��24����")
end

--�����ƶ�
function MoveScene(x,y)
	instruct_25(JY.SubSceneX,JY.SubSceneY,x,y)
end
--Ϊ�򻯣�ʵ�����ǳ����ƶ�(x2-x1)��(y2-y1)����y��x����ˣ�x1,y1����Ϊ0
function instruct_25(x1,y1,x2,y2)             --�����ƶ�
    local sign;
    if y1 ~= y2 then
        if y2<y1 then
            sign=-1;
        else
            sign=1;
        end
        for i=y1+sign,y2,sign do
            local t1=lib.GetTime();
            JY.SubSceneY=JY.SubSceneY+sign;
	        --JY.oldSMapX=-1;
		    --JY.oldSMapY=-1;
            DrawSMap();
            ShowScreen();
            local t2=lib.GetTime();
            if (t2-t1)<CC.SceneMoveFrame then
                lib.Delay(CC.SceneMoveFrame-(t2-t1));
            end
        end
    end

    if x1 ~= x2 then
        if x2<x1 then
            sign=-1;
        else
            sign=1;
        end
        for i=x1+sign,x2,sign do
            local t1=lib.GetTime();
            JY.SubSceneX=JY.SubSceneX+sign;
			--JY.oldSMapX=-1;
			--JY.oldSMapY=-1;

            DrawSMap();
            ShowScreen();
            local t2=lib.GetTime();
            if (t2-t1)<CC.SceneMoveFrame then
                lib.Delay(CC.SceneMoveFrame-(t2-t1));
            end
        end
    end
end


function instruct_26(sceneid,id,v1,v2,v3)           --����D*���
    if sceneid==-2 then
        sceneid=JY.SubScene;
    end

    local v=GetD(sceneid,id,2);
    SetD(sceneid,id,2,v+v1);
    v=GetD(sceneid,id,3);
    SetD(sceneid,id,3,v+v2);
    v=GetD(sceneid,id,4);
    SetD(sceneid,id,4,v+v3);
end

function PlayMovie(id,startpic,endpic)
	instruct_27(id,startpic,endpic)
end
--��ʾ���� id=-1 ����λ�ö���
function instruct_27(id,startpic,endpic)           --��ʾ����
    local old1,old2,old3;
	if id ~=-1 then
        old1=GetD(JY.SubScene,id,5);
        old2=GetD(JY.SubScene,id,6);
        old3=GetD(JY.SubScene,id,7);
    end

    --Cls();
	--ShowScreen();
    for i =startpic,endpic,2 do
        local t1=lib.GetTime();
        if id==-1 then
            JY.MyPic=i/2;
        else
            SetD(JY.SubScene,id,5,i);
            SetD(JY.SubScene,id,6,i);
            SetD(JY.SubScene,id,7,i);
        end
        DtoSMap();
        DrawSMap();
        ShowScreen();
        local t2=lib.GetTime();
    	if t2-t1<CC.AnimationFrame then
            lib.Delay(CC.AnimationFrame-(t2-t1));
	    end
    end
	if id ~=-1 then
        SetD(JY.SubScene,id,5,old1);
        SetD(JY.SubScene,id,6,old2);
        SetD(JY.SubScene,id,7,old3);
    end
end

--�ж�Ʒ��
function instruct_28(personid,vmin,vmax)          --�ж�Ʒ��
    local v=JY.Person[personid]["Ʒ��"];
    if v >=vmin and v<=vmax then
        return true;
    else
        return false;
    end
end

--�жϹ�����
function instruct_29(personid,vmin,vmax)           --�жϹ�����
    local v=JY.Person[personid]["������"];
    if v >=vmin and v<=vmax then
        return true;
    else
        return false
    end
end

--�����߶�
--Ϊ�򻯣��߶�ʹ�����ֵ(x2-x1)(y2-y1),���x1,y1����Ϊ0������һ��ҪΪ��ǰ���ꡣ
function instruct_30(x1,y1,x2,y2)                --�����߶�
    --Cls();
    --ShowScreen();

    if x1<x2 then
        for i=x1+1,x2 do
            local t1=lib.GetTime();
            instruct_30_sub(1);
            local t2=lib.GetTime();
            if (t2-t1)<CC.PersonMoveFrame then
                lib.Delay(CC.PersonMoveFrame-(t2-t1));
            end
        end
    elseif x1>x2 then
        for i=x2+1,x1 do
            local t1=lib.GetTime();
            instruct_30_sub(2);
            local t2=lib.GetTime();
            if (t2-t1)<CC.PersonMoveFrame then
                lib.Delay(CC.PersonMoveFrame-(t2-t1));
            end
        end
    end

    if y1<y2 then
        for i=y1+1,y2 do
            local t1=lib.GetTime();
            instruct_30_sub(3);
            local t2=lib.GetTime();
            if (t2-t1)<CC.PersonMoveFrame then
                lib.Delay(CC.PersonMoveFrame-(t2-t1));
            end
        end
    elseif y1>y2 then
        for i=y2+1,y1 do
            local t1=lib.GetTime();
            instruct_30_sub(0);
            local t2=lib.GetTime();
            if (t2-t1)<CC.PersonMoveFrame then
                lib.Delay(CC.PersonMoveFrame-(t2-t1));
            end
        end
    end
end

function walkto_old(x,y)
	instruct_30(0,0,x,y)
end

function walk(direct)
	while AutoMoveTab[0]>0 do
		local t1=lib.GetTime();
		if JY.Status==GAME_SMAP then
			instruct_30_sub(AutoMoveTab[AutoMoveTab[0]]);
		elseif JY.Status==GAME_MMAP then
			instruct_30_sub2(AutoMoveTab[AutoMoveTab[0]]);
		end
		AutoMoveTab[AutoMoveTab[0]]=nil;
		AutoMoveTab[0]=AutoMoveTab[0]-1;
		local t2=lib.GetTime();
		if (t2-t1)<CC.PersonMoveFrame then
			lib.Delay(CC.PersonMoveFrame-(t2-t1));
		end
	end
	JY.Base["�˷���"]=direct;
	JY.MyPic=GetMyPic();
    --DrawSMap();
	Cls();
    ShowScreen();
end
--�����߶�sub
function instruct_30_sub(direct)            --�����߶�sub
    local x,y;
    AddMyCurrentPic();
    x=JY.Base["��X1"]+CC.DirectX[direct+1];
    y=JY.Base["��Y1"]+CC.DirectY[direct+1];
    JY.Base["�˷���"]=direct;
    JY.MyPic=GetMyPic();
    DtoSMap();

    if  SceneCanPass(x,y)==true then
        JY.Base["��X1"]=x;
        JY.Base["��Y1"]=y;
		if JY.SubSceneX~=0 or JY.SubSceneY~=0 then
			JY.SubSceneX=JY.SubSceneX-CC.DirectX[direct+1]
			JY.SubSceneY=JY.SubSceneY-CC.DirectY[direct+1]
		end
    end
    JY.Base["��X1"]=limitX(JY.Base["��X1"],1,CC.SWidth-2);
    JY.Base["��Y1"]=limitX(JY.Base["��Y1"],1,CC.SHeight-2);
	getkey();
    --DrawSMap();
    Cls();
    ShowScreen();
end
function instruct_30_sub2(direct)            --�����߶�sub
    local x,y;
    AddMyCurrentPic();
    x=JY.Base["��X"]+CC.DirectX[direct+1];
    y=JY.Base["��Y"]+CC.DirectY[direct+1];
    JY.Base["�˷���"]=direct;
    JY.MyPic=GetMyPic();
    JY.Base["��X"]=limitX(x,1,CC.MWidth-2);
    JY.Base["��Y"]=limitX(y,1,CC.MHeight-2);
	getkey();
    --DrawSMap();
    Cls();
    ShowScreen();
end
--�ж��Ƿ�Ǯ
function instruct_31(num)             --�ж��Ƿ�Ǯ
    local r=false;
    for i =1,CC.MyThingNum do
        if JY.Base["��Ʒ" .. i]==CC.MoneyID then
            if JY.Base["��Ʒ����" .. i]>=num then
                r=true;
            end
            break;
        end
    end
    return r;
end

--������Ʒ
--num ��Ʒ������������Ϊ������Ʒ
function instruct_32(thingid,num)           --������Ʒ
    local p=1;
    for i=1,CC.MyThingNum do
        if JY.Base["��Ʒ" .. i]==thingid then
            JY.Base["��Ʒ����" .. i]=JY.Base["��Ʒ����" .. i]+num
            p=i;
            break;
        elseif JY.Base["��Ʒ" .. i]==-1 then
            JY.Base["��Ʒ" .. i]=thingid;
            JY.Base["��Ʒ����" .. i]=num;
            p=1;
            break;
        end
    end

    if JY.Base["��Ʒ����" .. p] <=0 then
        for i=p+1,CC.MyThingNum do
            JY.Base["��Ʒ" .. i-1]=JY.Base["��Ʒ" .. i];
            JY.Base["��Ʒ����" .. i-1]=JY.Base["��Ʒ����" .. i];
        end
        JY.Base["��Ʒ" .. CC.MyThingNum]=-1;
        JY.Base["��Ʒ����" .. CC.MyThingNum]=0;
    end
end

--ѧ���书
function instruct_33(personid,wugongid,flag)           --ѧ���书
    local add=0;
    for i=1,10 do
        if JY.Person[personid]["�书" .. i]==0 then
            JY.Person[personid]["�书" .. i]=wugongid;
            JY.Person[personid]["�书�ȼ�" .. i]=0;
            add=1
            break;
        end
    end

    if add==0 then      --���书�������������һ���书
        JY.Person[personid]["�书10" ]=wugongid;
        JY.Person[personid]["�书�ȼ�10"]=0;
    end

    if flag==0 then
        DrawStrBoxWaitKey(string.format("%s ѧ���书 %s",JY.Person[personid]["����"],JY.Wugong[wugongid]["����"]),C_ORANGE,CC.Fontbig);
    end
end

--��������
function instruct_34(id,value)              --��������
    local add,str=AddPersonAttrib(id,"����",value);
    DrawStrBoxWaitKey(JY.Person[id]["����"] .. str,C_ORANGE,CC.Fontbig);
end

--�����书
function instruct_35(personid,id,wugongid,wugonglevel)         --�����书
    if id>=0 then
        JY.Person[personid]["�书" .. id+1]=wugongid;
        JY.Person[personid]["�书�ȼ�" .. id+1]=wugonglevel;
    else
        local flag=0;
        for i =1,10 do
            if JY.Person[personid]["�书" .. i]==0 then
                flag=1;
                JY.Person[personid]["�书" .. i]=wugongid;
                JY.Person[personid]["�书�ȼ�" .. i]=wugonglevel;
                return;
            end
        end
        if flag==0 then
            JY.Person[personid]["�书" .. 1]=wugongid;
            JY.Person[personid]["�书�ȼ�" .. 1]=wugonglevel;
        end
    end
end
function SetKF(pid,kfid,kflv)
	if kfid<=0 then
		return;
	end
	for i =1,80 do
		if JY.Person[pid]["�����书" .. i]<=0 then
			JY.Person[pid]["�����书" .. i]=kfid;
			JY.Person[pid]["�����书����" .. i]=kflv;
			return;
		elseif JY.Person[pid]["�����书" .. i]==kfid then
			JY.Person[pid]["�����书����" .. i]=kflv;
			return;
		end
	end
end
--�ж������Ա�
function instruct_36(sex)               --�ж������Ա�
    if JY.Person[0]["�Ա�"]==sex then
        return true;
    else
        return false;
    end
end


function instruct_37(v)              --����Ʒ��
    AddPersonAttrib(0,"Ʒ��",v);
end

--�޸ĳ���ĳ����ͼ
function instruct_38(sceneid,level,oldpic,newpic)         --�޸ĳ���ĳ����ͼ
    if sceneid==-2 then
        sceneid=JY.SubScene;
    end

    for i=0,CC.SWidth-1 do
        for j=1, CC.SHeight-1 do
            if GetS(sceneid,i,j,level)==oldpic then
                SetS(sceneid,i,j,level,newpic)
            end
        end
    end
end


function instruct_39(sceneid)             --�򿪳���
    JY.Scene[sceneid]["��������"]=0;
end


function instruct_40(v)                --�ı����Ƿ���
    JY.Base["�˷���"]=v;
    JY.MyPic=GetMyPic();
end


function instruct_41(personid,thingid,num)        --������Ա������Ʒ
    local k=0;
    for i =1, 4 do        --������Ʒ
        if JY.Person[personid]["Я����Ʒ" .. i]==thingid then
            JY.Person[personid]["Я����Ʒ����" .. i]=JY.Person[personid]["Я����Ʒ����" .. i]+num;
            k=i;
            break
        end
    end

    --��Ʒ���ٵ�0���������Ʒ��ǰ�ƶ�
    if k>0 and JY.Person[personid]["Я����Ʒ����" .. k] <=0 then
        for i=k+1,4 do
            JY.Person[personid]["Я����Ʒ" .. i-1]=JY.Person[personid]["Я����Ʒ" .. i];
            JY.Person[personid]["Я����Ʒ����" .. i-1]=JY.Person[personid]["Я����Ʒ����" .. i];
        end
        JY.Person[personid]["Я����Ʒ" .. 4]=-1;
        JY.Person[personid]["Я����Ʒ����" .. 4]=0;
    end


    if k==0 then    --û����Ʒ��ע��˴������ǳ���4����Ʒ�������������������޷����롣
        for i =1, 4 do        --������Ʒ
            if JY.Person[personid]["Я����Ʒ" .. i]==-1 then
                JY.Person[personid]["Я����Ʒ" .. i]=thingid;
                JY.Person[personid]["Я����Ʒ����" .. i]=num;
                break
            end
        end
    end
end


function instruct_42()          --�������Ƿ���Ů��
    local r=false;
    for i =1,CC.TeamNum do
        if JY.Base["����" .. i] >=0 then
            if JY.Person[JY.Base["����" .. i]]["�Ա�"]==1 then
                r=true;
            end
        end
    end
    return r;
end


function instruct_43(thingid)        --�Ƿ���ĳ����Ʒ
    return instruct_18(thingid);
end


function instruct_44(id1,startpic1,endpic1,id2,startpic2,endpic2)     --ͬʱ��ʾ��������
    local old1=GetD(JY.SubScene,id1,5);
    local old2=GetD(JY.SubScene,id1,6);
    local old3=GetD(JY.SubScene,id1,7);
    local old4=GetD(JY.SubScene,id2,5);
    local old5=GetD(JY.SubScene,id2,6);
    local old6=GetD(JY.SubScene,id2,7);

    --Cls();
    --ShowScreen();
    for i =startpic1,endpic1,2 do
        local t1=lib.GetTime();
        if id1==-1 then
            JY.MyPic=i/2;
        else
            SetD(JY.SubScene,id1,5,i);
            SetD(JY.SubScene,id1,6,i);
            SetD(JY.SubScene,id1,7,i);
        end
        if id2==-1 then
            JY.MyPic=i/2;
        else
            SetD(JY.SubScene,id2,5,i-startpic1+startpic2);
            SetD(JY.SubScene,id2,6,i-startpic1+startpic2);
            SetD(JY.SubScene,id2,7,i-startpic1+startpic2);
        end
        DtoSMap();
        DrawSMap();
        ShowScreen();
        local t2=lib.GetTime();
    	if t2-t1<CC.AnimationFrame then
            lib.Delay(CC.AnimationFrame-(t2-t1));
	    end
    end
    SetD(JY.SubScene,id1,5,old1);
    SetD(JY.SubScene,id1,6,old2);
    SetD(JY.SubScene,id1,7,old3);
    SetD(JY.SubScene,id2,5,old4);
    SetD(JY.SubScene,id2,6,old5);
    SetD(JY.SubScene,id2,7,old6);

end


function instruct_45(id,value)        --�����Ṧ
    local add,str=AddPersonAttrib(id,"�Ṧ",value);
    DrawStrBoxWaitKey(JY.Person[id]["����"] .. str,C_ORANGE,CC.Fontbig);
end


function instruct_46(id,value)            --��������
    local add,str=AddPersonAttrib(id,"�������ֵ",value);
    AddPersonAttrib(id,"����",0);
    DrawStrBoxWaitKey(JY.Person[id]["����"] .. str,C_ORANGE,CC.Fontbig);
end


function instruct_47(id,value)
    local add,str=AddPersonAttrib(id,"������",value);           --���ӹ�����
    DrawStrBoxWaitKey(JY.Person[id]["����"] .. str,C_ORANGE,CC.Fontbig);
end


function instruct_48(id,value)         --��������
    local add,str=AddPersonAttrib(id,"�������ֵ",value);
    AddPersonAttrib(id,"����",0);
    if instruct_16(id)==true then             --�ҷ���Ա����ʾ����
        DrawStrBoxWaitKey(JY.Person[id]["����"] .. str,C_ORANGE,CC.Fontbig);
    end
end


function instruct_49(personid,value)       --������������
    JY.Person[personid]["��������"]=value;
end

--�ж��Ƿ���5����Ʒ
function instruct_50(id1,id2,id3,id4,id5)       --�ж��Ƿ���5����Ʒ
    local num=0;
    if instruct_18(id1)==true then
        num=num+1;
    end
    if instruct_18(id2)==true then
        num=num+1;
    end
    if instruct_18(id3)==true then
        num=num+1;
    end
    if instruct_18(id4)==true then
        num=num+1;
    end
    if instruct_18(id5)==true then
        num=num+1;
    end
    if num==5 then
        return true;
    else
        return false;
    end
end


function instruct_51()     --����������
    instruct_1(2547+Rnd(18),114,0);
end


function instruct_52()       --��Ʒ��
    DrawStrBoxWaitKey(string.format("�����ڵ�Ʒ��ָ��Ϊ: %d",JY.Person[0]["Ʒ��"]),C_ORANGE,CC.Fontbig);
end


function instruct_53()        --������
    DrawStrBoxWaitKey(string.format("�����ڵ�����ָ��Ϊ: %d",JY.Person[0]["����"]),C_ORANGE,CC.Fontbig);
end


function instruct_54()        --������������
    for i = 0, JY.SceneNum-1 do
        JY.Scene[i]["��������"]=0;
    end
    JY.Scene[2]["��������"]=2;    --�ƺ���
    JY.Scene[38]["��������"]=2;   --Ħ����
    JY.Scene[75]["��������"]=1;   --�һ���
    JY.Scene[80]["��������"]=1;   --����ȵ�
end


function instruct_55(id,num)      --�ж�D*��ŵĴ����¼�
    if GetD(JY.SubScene,id,2)==num then
        return true;
    else
        return false;
    end
end


function instruct_56(v)             --��������
    JY.Person[0]["����"]=JY.Person[0]["����"]+v;
    instruct_2_sub();     --�Ƿ��������������
end

--�߲��Թ�����
function instruct_57()       --�߲��Թ�����
    instruct_27(-1,7664,7674);
    --Cls();
	--ShowScreen();
    for i=0,56,2 do
	    local t1=lib.GetTime();
        if JY.MyPic< 7688/2 then
            JY.MyPic=(7676+i)/2;
        end
        SetD(JY.SubScene,2,5,i+7690);
        SetD(JY.SubScene,2,6,i+7690);
        SetD(JY.SubScene,2,7,i+7690);
        SetD(JY.SubScene,3,5,i+7748);
        SetD(JY.SubScene,3,6,i+7748);
        SetD(JY.SubScene,3,7,i+7748);
        SetD(JY.SubScene,4,5,i+7806);
        SetD(JY.SubScene,4,6,i+7806);
        SetD(JY.SubScene,4,7,i+7806);

        DtoSMap();
        DrawSMap();
        ShowScreen();
        local t2=lib.GetTime();
    	if t2-t1<CC.AnimationFrame then
            lib.Delay(CC.AnimationFrame-(t2-t1));
	    end
    end
end

--���������
function instruct_58()           --���������
    local group=5           --���������
    local num1 = 6          --ÿ���м���ս��
    local num2 = 3          --ѡ���ս����
    local startwar=102      --��ʼս�����
    local flag={};

    for i = 0,group-1 do
        for j=0,num1-1 do
            flag[j]=0;
        end

        for j = 1,num2 do
            local r;
            while true do          --ѡ��һ��ս��
                r=Rnd(num1);
                if flag[r]==0 then
                    flag[r]=1;
                    break;
                end
            end
            local warnum =r+i*num1;      --������ս�����
            WarLoad(warnum + startwar);
            instruct_1(2854+warnum, JY.Person[WAR.Data["����1"]]["ͷ�����"], 0);
            instruct_0();
            if WarMain(warnum + startwar, 0) ==true  then     --Ӯ
                instruct_0();
                instruct_13();
                TalkEx("������λǰ���ϴͽ̣�", 0, 1)
                instruct_0();
            else
                instruct_15();
                return;
            end
        end

        if i < group - 1 then
            TalkEx("��������ս������*������Ϣ��ս��", 70, 0);
            instruct_0();
            instruct_14();
            lib.Delay(300);
            if JY.Person[0]["���˳̶�"] < 50 and JY.Person[0]["�ж��̶�"] <= 0 then
               JY.Person[0]["���˳̶�"] = 0
               AddPersonAttrib(0,"����",math.huge);
               AddPersonAttrib(0,"����",math.huge);
               AddPersonAttrib(0,"����",math.huge);
            end
            instruct_13();
            TalkEx("���Ѿ���Ϣ���ˣ�*��˭Ҫ���ϣ�",0,1);
            instruct_0();
        end
    end

    TalkEx("��������˭��**��������*��������***û��������",0,1);
    instruct_0();
    TalkEx("�����û����Ҫ��������λ*������ս���������书����*��һ֮������������֮λ��*������λ������ã�***������������*������������*������������*�ã���ϲ����������������*֮λ����������ã������*���������ȡ�Ҳ���㱣�ܣ�",70,0);
    instruct_0();
    TalkEx("��ϲ������",12,0);
    instruct_0();
    TalkEx("С�ֵܣ���ϲ�㣡",64,4);
    instruct_0();
    TalkEx("�ã���������ִ�ᵽ����*Բ��������ϣ�������λ��*��ͬ�����ٵ��һ�ɽһ�Σ�",19,0);
    instruct_0();
    instruct_14();
    for i = 24,72 do
        instruct_3(-2, i, 0, 0, -1, -1, -1, -1, -1, -1, -2, -2, -2)
    end
    instruct_0();
    instruct_13();
    TalkEx("����ǧ����࣬����춴��*Ⱥ�ۣ��õ�����������֮λ*�����ȣ�*���ǡ�ʥ�á������أ�*Ϊʲ��û�˸����ң��ѵ���*�Ҷ���֪����*�������е����ˣ�", 0, 1)
    instruct_0();
    instruct_2(143, 1)           --�õ�����

end

--ȫ���Ա���
function instruct_59()           --ȫ���Ա���
    for i=CC.TeamNum,2,-1 do
	    if JY.Base["����" .. i]>=0 then
            instruct_21(JY.Base["����" .. i]);
	    end
    end

    for i,v in ipairs(CC.AllPersonExit) do
        instruct_3(v[1],v[2],0,0,-1,-1,-1,-1,-1,-1,0,-2,-2);
    end
end

--�ж�D*ͼƬ
function instruct_60(sceneid,id,num)          --�ж�D*ͼƬ
    if sceneid==-2 then
         sceneid=JY.SubScene;
    end

    if id==-2 then
         id=JY.CurrentD;
    end

    if GetD(sceneid,id,5)==num then
        return true;
    else
        return false;
    end
end

--�ж��Ƿ����14����
function instruct_61()               --�ж��Ƿ����14����
    for i=11,24 do
        if GetD(JY.SubScene,i,5) ~= 4664 then
            return false;
        end
    end
    return true;
end

--����ʱ�ջ�����������
function instruct_62(id1,startnum1,endnum1,id2,startnum2,endnum2)      --����ʱ�ջ�����������
      JY.MyPic=-1;
      instruct_44(id1,startnum1,endnum1,id2,startnum2,endnum2);

      --�˴�Ӧ�ò��������Ƭβ������������ʱ��ͼƬ����

	  lib.LoadPicture(CONFIG.PicturePath .."end.png",-1,-1);
	  ShowScreen();
	  PlayMIDI(24);
	  lib.Delay(5000);
	  lib.GetKey();
	  WaitKey();
	  JY.Status=GAME_END;
end

--�����Ա�
function instruct_63(personid,sex)          --�����Ա�
    JY.Person[personid]["�Ա�"]=sex
end

--С��������
function instruct_64()                 --С��������
    local headid=111;           --С��ͷ��


    local id=-1;
    for i=0,JY.ShopNum-1 do                --�ҵ���ǰ�̵�id
        if CC.ShopScene[i].sceneid==JY.SubScene then
            id=i;
            break;
        end
    end
    if id<0 then
        return ;
    end

    TalkEx("��λС�磬������ʲ����Ҫ*�ģ�С�������Ķ�����Ǯ��*�Թ�����",headid,0);

    local menu={};
    for i=1,5 do
        menu[i]={};
        local thingid=JY.Shop[id]["��Ʒ" ..i];
        menu[i][1]=string.format("%-12s %5d",JY.Thing[thingid]["����"],JY.Shop[id]["��Ʒ�۸�" ..i]);
        menu[i][2]=nil;
        if JY.Shop[id]["��Ʒ����" ..i] >0 then
            menu[i][3]=1;
        else
            menu[i][3]=0;
        end
    end

    local x1=(CC.ScreenW-9*CC.Fontbig-2*CC.MenuBorderPixel)/2;
    local y1=(CC.ScreenH-5*CC.Fontbig-4*CC.RowPixel-2*CC.MenuBorderPixel)/2;



    local r=ShowMenu(menu,5,0,x1,y1,0,0,1,1,CC.Fontbig,C_ORANGE, C_WHITE);

    if r>0 then
        if instruct_31(JY.Shop[id]["��Ʒ�۸�" ..r])==false then
            TalkEx("�ǳ���Ǹ��*�����ϵ�Ǯ�ƺ�������",headid,0);
        else
            JY.Shop[id]["��Ʒ����" ..r]=JY.Shop[id]["��Ʒ����" ..r]-1;
            instruct_32(CC.MoneyID,-JY.Shop[id]["��Ʒ�۸�" ..r]);
            instruct_32(JY.Shop[id]["��Ʒ" ..r],1);
            TalkEx("��ү������С���Ķ�����*��֤������ڣ�",headid,0);
        end
    end

    for i,v in ipairs(CC.ShopScene[id].d_leave) do
        instruct_3(-2,v,0,-2,-1,-1,939,-1,-1,-1,-2,-2,-2);      --�����뿪����ʱ����С���뿪�¼���
    end
end

--С��ȥ������ջ
function instruct_65()           --С��ȥ������ջ
    local id=-1;
    for i=0,JY.ShopNum-1 do                --�ҵ���ǰ�̵�id
        if CC.ShopScene[i].sceneid==JY.SubScene then
            id=i;
            break;
        end
    end
    if id<0 then
        return ;
    end

    ---�����ǰ�̵�����С��D��
    instruct_3(-2,CC.ShopScene[id].d_shop,0,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
    for i,v in ipairs(CC.ShopScene[id].d_leave) do
        instruct_3(-2,v,0,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
    end

    local newid=id+1;              --��ʱ��˳��ȡ�������
    if newid>=5 then
        newid=0;
    end

    --�����µ�С���̵�λ��
    instruct_3(CC.ShopScene[newid].sceneid,CC.ShopScene[newid].d_shop,1,-2,938,-1,-1,8256,8256,8256,-2,-2,-2);
end

--��������
function instruct_66(id)       --��������
    PlayMIDI(id);
end

--������Ч
function instruct_67(id)      --������Ч
     PlayWavAtk(id);
end


function SmartWalk(x,y,d)
								JY.EnableKeyboard=false;
								JY.EnableMouse=false;
								walkto(x,y);
								walk(d);
								JY.EnableKeyboard=true;
								JY.EnableMouse=true;
end
--say,say_1,say_sub

function script_say(s)
	local num=string.find(s,"��");
	local name=string.sub(s,1,num-1);
	local str=string.sub(s,num+2,-1);
	say(str,JY.Name[name]);
end
--�¶Ի���ʽ
--��������ַ�
--��ͣ����������������
--������ɫ ��=red��=gold��=black��=white��=orange
--�����ַ���ʾ�ٶȣ�����
--����������ӣģ�
--���ƻ��Уȷ�ҳ��
--�δ����Լ����������
function say(s,pid,flag,name)          --�����¶Ի�
	pid=pid or 0;
	if type(pid)=="string" then
		pid=JY.Name[pid];
	end
	if flag==nil then
		if pid==0 then
			flag=1;
		elseif pid==JY.LastSayPid then
			flag=JY.LastSayPosition;
		else
			if inteam(pid) then
				flag=5;	--LD
			else
				if JY.LastSayPosition==0 then
					flag=4;
					JY.LastSayPosition=flag;
				else
					flag=0;
					JY.LastSayPosition=flag;
				end
				JY.LastSayPid=pid;
			end
		end
	end
	name=name or JY.Person[pid]['����'];
	local headid=JY.Person[pid]['ͷ�����'];
	Cls();
	say_sub(s,headid,name,flag);
	--Cls();
end
function say_2(s,pid,flag,name)          --�����¶Ի�
	pid=pid or 0;
	if type(pid)=="string" then
		pid=JY.Name[pid];
	end
	if flag==nil then
		if pid==0 then
			flag=1;
		elseif pid==JY.LastSayPid then
			flag=JY.LastSayPosition;
		else
			if inteam(pid) then
				flag=5;	--LD
			else
				if JY.LastSayPosition==0 then
					flag=4;
					JY.LastSayPosition=flag;
				else
					flag=0;
					JY.LastSayPosition=flag;
				end
				JY.LastSayPid=pid;
			end
		end
	end
	name=name or JY.Person[pid]['����'];
	local headid=JY.Person[pid]['ͷ�����'];
	say_sub(s,headid,name,flag);
	--Cls();
end
function say_1(s,headid,name,flag)
	name=name or '';
	flag=flag or 0;
	say_sub(s,headid,name,flag);
	Cls();
end
function say_sub(s,headid,name,flag)          --�����¶Ի�
    local picw=150;       --���ͷ��ͼƬ���
	local pich=150;
	local talkxnum=18;         --�Ի�һ������
	local talkynum=3;          --�Ի�����
	local boxw=picw+talkxnum*24+20;
	local boxh=96;
    local boxpicw=picw+10;
	local boxpich=pich+10;
	local boxtalkw=talkxnum*24+10;
	local boxtalkh=96;
	local dx=(CC.ScreenW-boxtalkw-boxpicw)/2;
	local dy=10;
    local talkBorder=24/4--(pich-talkynum*24)/(talkynum+1);

	--��ʾͷ��ͶԻ�������
    local xy={ [0]={headx=dx+5,heady=dy-2,
	                talkx=dx+boxpicw,talky=dy+54,
					bx1=dx,by1=dy+54,bx2=dx+boxw,by2=dy+54+boxh,
					showhead=1},--����
                   {headx=CC.ScreenW-dx-boxpicw+5,heady=CC.ScreenH-dy-boxpich+8,
					talkx=CC.ScreenW-dx-boxw,talky=CC.ScreenH-dy-boxh,
					bx1=CC.ScreenW-dx-boxw,by1=CC.ScreenH-dy-boxh,bx2=CC.ScreenW-dx,by2=CC.ScreenH-dy,
				    --talkx=CC.ScreenW-dx-boxpicw-boxtalkw-2,talky= CC.ScreenH-dy-boxpich+27,
					showhead=1},--����
                   {headx=dx,heady=dy,
				   talkx=dx+boxpicw-43,talky=dy+27,
				   showhead=0},--����
                   {headx=CC.ScreenW-1-dx-boxpicw,heady=CC.ScreenH-dy-boxpich,
				   talkx=CC.ScreenW-1-dx-boxpicw-boxtalkw-2,talky= CC.ScreenH-dy-boxpich+27,
					showhead=1},
                   {headx=CC.ScreenW-dx-boxpicw+5,heady=dy-2,
	                talkx=CC.ScreenW-dx-boxw,talky=dy+54,
					bx1=CC.ScreenW-dx-boxw,by1=dy+54,bx2=CC.ScreenW-dx,by2=dy+54+boxh,
					showhead=1},--����
                   {headx=dx+5,heady=CC.ScreenH-dy-boxpich+8,
				   talkx=dx+boxpicw,talky=CC.ScreenH-dy-boxh,
				   bx1=dx,by1=CC.ScreenH-dy-boxh,bx2=dx+boxw,by2=CC.ScreenH-dy,
				   showhead=1}, --����
			}

    if flag<0 or flag>5 then
        flag=0;
    end
    if xy[flag].showhead==0 then
        --headid=-1;
    end

    if CONFIG.KeyRepeat==0 then
	     lib.EnableKeyRepeat(0,CONFIG.KeyRepeatInterval);
	end
    lib.GetKey();
	--s=string.sub(s,2,-1);
	
	local function readstr(str)
		local T1={"��","��","��","��","��","��","��","��","��","��"}
		local T2={{"��",C_RED},{"��",C_GOLD},{"��",C_BLACK},{"��",C_WHITE},{"��",C_ORANGE}}
		local T3={{"��",CC.FontNameSong},{"��",CC.FontNameHei},{"��",CC.FontName}}
		--�����������Բ�ͬ����ͬһ����ʾ����Ҫ΢�������꣬�Լ��ֺ�
		--��Ĭ�ϵ�����Ϊ��׼�����������ƣ�ϸ��������
		for i=0,9 do
			if T1[i+1]==str then return 1,i*20 end
		end
		for i=1,5 do
			if T2[i][1]==str then return 2,T2[i][2] end
		end
		for i=1,3 do
			if T3[i][1]==str then return 3,T3[i][2] end
		end
		return 0
	end
	
	local function mydelay(t)
		lib.GetKey()
		if t<=0 then return end
		lib.ShowSurface(0)
		lib.Delay(t)
	end
	
	local page,cy,cx=0,0,0
	local color,t,font=C_WHITE,0,CC.FontName
	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	while string.len(s)>=1 do
		if page==0 then				--�µ�һҳ����������ʾͷ��
			--Cls()
			lib.LoadSur(sid,0,0);
			DrawNewBox(xy[flag].bx1,xy[flag].by1,xy[flag].bx2,xy[flag].by2,C_WHITE);
			if headid>=0 then
				local w,h=lib.PicGetXY(1,headid*2);
				local x=(picw-w)/2;
				local y=(pich-h)/2;
				if flag==1 or flag==4 then
					lib.PicLoadCache(1,headid*2,xy[flag].headx+x,xy[flag].heady+y,17);
				else
					lib.PicLoadCache(1,headid*2,xy[flag].headx+x,xy[flag].heady+y,1);
				end
				for i=xy[flag].headx,xy[flag].headx+150 do
					lib.Background(i,xy[flag].heady+129,i+1,xy[flag].heady+129+21,64+128*math.abs(xy[flag].headx+75-i)/75)
				end
				MyDrawString(xy[flag].headx,xy[flag].headx+150,xy[flag].heady+129,name,C_ORANGE,21);
			end
			page=1
		end
		local str;
		str=string.sub(s,1,1);
		if string.byte(str)>127 then
			str=string.sub(s,1,2);
			s=string.sub(s,3,-1);
			--��ʼ�����߼�
			if str=="��" then
				if cx~=0 then
					cx=0
					cy=cy+1
					if cy==3 then
						cy=0
						page=0
					end
				end
			elseif str=="��" then
				cx=0
				cy=0
				page=0
			elseif str=="��" then
				ShowScreen();
				WaitKey();	
				lib.Delay(100)	
			elseif str=="��" then
				s=name..s
			elseif str=="��" then
				s=JY.Person[0]["����"]..s
			else 
				local kz1,kz2=readstr(str)
				if kz1==1 then
					t=kz2
				elseif kz1==2 then
					color=kz2
				elseif kz1==3 then
					font=kz2
				else
					getkey();
					lib.DrawStr(xy[flag].talkx+24*cx+5,
								xy[flag].talky+(24+talkBorder)*cy+talkBorder,
								str,color,24,font,0,0)
					mydelay(t)
					cx=cx+1
					--[[
					if cx==talkxnum then
						cx=0
						cy=cy+1
						if cy==talkynum then
							cy=0
							page=0
						end
					end]]--
				end
			end
		else
			str=string.sub(s,1,1);
			s=string.sub(s,2,-1);
			getkey();
			lib.DrawStr(xy[flag].talkx+24*cx+5,
						xy[flag].talky+(24+talkBorder)*cy+talkBorder,
						str,color,24,font,0,0)
			mydelay(t)
			cx=cx+0.5
		end
			if cx>talkxnum-1 then
				cx=0
				cy=cy+1
				if cy==talkynum then
					cy=0
					page=0
				end
			end
		--�����ҳ������ʾ���ȴ�����
		if page==0 or string.len(s)<1 then
			ShowScreen();
			WaitKey();
			lib.Delay(100)
		end
	end
	--lib.LoadSur(sid,0,0);
	lib.FreeSur(sid);

    if CONFIG.KeyRepeat==0 then
	     lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay,CONFIG.KeyRepeatInterval);
	end

end

function say_sub1(s,headid,name,flag)          --�����¶Ի�
    local picw=150;       --���ͷ��ͼƬ���
	local pich=150;
	local talkxnum=18;         --�Ի�һ������
	local talkynum=3;          --�Ի�����
	local dx=2;
	local dy=2;
    local boxpicw=picw+10;
	local boxpich=pich+10;
	local boxtalkw=talkxnum*CC.Fontbig+10;
	local boxtalkh=boxpich-27;
    local talkBorder=(pich-talkynum*CC.Fontbig)/(talkynum+1);

	--��ʾͷ��ͶԻ�������
    local xy={ [0]={headx=dx,heady=dy,
	                talkx=dx+boxpicw+2,talky=dy+27,
					namex=dx+boxpicw+2,namey=dy,
					showhead=1},--����
                   {headx=CC.ScreenW-1-dx-boxpicw,heady=CC.ScreenH-dy-boxpich,
				    talkx=CC.ScreenW-1-dx-boxpicw-boxtalkw-2,talky= CC.ScreenH-dy-boxpich+27,
					namex=CC.ScreenW-1-dx-boxpicw-96,namey=CC.ScreenH-dy-boxpich,
					showhead=1},--����
                   {headx=dx,heady=dy,
				   talkx=dx+boxpicw-43,talky=dy+27,
					namex=dx+boxpicw+2,namey=dy,
				   showhead=0},--����
                   {headx=CC.ScreenW-1-dx-boxpicw,heady=CC.ScreenH-dy-boxpich,
				   talkx=CC.ScreenW-1-dx-boxpicw-boxtalkw-2,talky= CC.ScreenH-dy-boxpich+27,
					namex=CC.ScreenW-1-dx-boxpicw-96,namey=CC.ScreenH-dy-boxpich,
					showhead=1},
                   {headx=CC.ScreenW-1-dx-boxpicw,heady=dy,
				    talkx=CC.ScreenW-1-dx-boxpicw-boxtalkw-2,talky=dy+27,
					namex=CC.ScreenW-1-dx-boxpicw-96,namey=dy,
					showhead=1},--����
                   {headx=dx,heady=CC.ScreenH-dy-boxpich,
				   talkx=dx+boxpicw+2,talky=CC.ScreenH-dy-boxpich+27,
					namex=dx+boxpicw+2,namey=CC.ScreenH-dy-boxpich,
				   showhead=1}, --����
			}

    if flag<0 or flag>5 then
        flag=0;
    end
    if xy[flag].showhead==0 then
        headid=-1;
    end
	s=string.sub(s,2,-1);

    if CONFIG.KeyRepeat==0 then
	     lib.EnableKeyRepeat(0,CONFIG.KeyRepeatInterval);
	end
    lib.GetKey();
	
	local function readstr(str)
		local T1={"��","��","��","��","��","��","��","��","��","��"}
		local T2={{"��",C_RED},{"��",C_GOLD},{"��",C_BLACK},{"��",C_WHITE},{"��",C_ORANGE}}
		local T3={{"��",CC.FontNameSong},{"��",CC.FontNameHei},{"��",CC.FontName}}
		--�����������Բ�ͬ����ͬһ����ʾ����Ҫ΢�������꣬�Լ��ֺ�
		--��Ĭ�ϵ�����Ϊ��׼�����������ƣ�ϸ��������
		for i=0,9 do
			if T1[i+1]==str then return 1,i*20 end
		end
		for i=1,5 do
			if T2[i][1]==str then return 2,T2[i][2] end
		end
		for i=1,3 do
			if T3[i][1]==str then return 3,T3[i][2] end
		end
		return 0
	end
	
	local function mydelay(t)
		lib.GetKey()
		if t<=0 then return end
		lib.ShowSurface(0)
		lib.Delay(t)
	end
	
	local page,cy,cx=0,0,0
	local color,t,font=C_WHITE,0,CC.FontName
	while string.len(s)>1 do
		if page==0 then				--�µ�һҳ����������ʾͷ��
			Cls()
            if headid>=0 then
                DrawBox(xy[flag].headx, xy[flag].heady, xy[flag].headx + boxpicw, xy[flag].heady + boxpich,C_WHITE);
				DrawBox(xy[flag].namex,xy[flag].namey,xy[flag].namex+96,xy[flag].namey+24,C_WHITE)
				MyDrawString(xy[flag].namex,xy[flag].namex+96,xy[flag].namey+1,name,C_ORANGE,21)
				local w,h=lib.PicGetXY(1,headid*2);
                local x=(picw-w)/2;
				local y=(pich-h)/2;
				lib.PicLoadCache(1,headid*2,xy[flag].headx+5+x,xy[flag].heady+5+y,1);
            end
            DrawBox(xy[flag].talkx, xy[flag].talky, xy[flag].talkx +boxtalkw, xy[flag].talky + boxtalkh,C_WHITE);			
			page=1
		end
		local str=string.sub(s,1,2)
		s=string.sub(s,3,-1)
		--��ʼ�����߼�
		if str=="��" then
			cx=0
			cy=cy+1
			if cy==3 then
				cy=0
				page=0
			end
		elseif str=="��" then
			cx=0
			cy=0
			page=0
		elseif str=="��" then
			ShowScreen();
			WaitKey();	
			lib.Delay(100)	
		elseif str=="��" then
			s=JY.Person[pid]["����"]..s
		elseif str=="��" then
			s=JY.Person[0]["����"]..s
		else 
			local kz1,kz2=readstr(str)
			if kz1==1 then
				t=kz2
			elseif kz1==2 then
				color=kz2
			elseif kz1==3 then
				font=kz2
			else
				lib.DrawStr(xy[flag].talkx+CC.Fontbig*cx+5,
							xy[flag].talky+(CC.Fontbig+talkBorder)*cy+talkBorder-8,
							str,color,CC.Fontbig,font,0,0)
				mydelay(t)
				cx=cx+1
				if cx==talkxnum then
					cx=0
					cy=cy+1
					if cy==talkynum then
						cy=0
						page=0
					end
				end
			end
		end
		--�����ҳ������ʾ���ȴ�����
		if page==0 or string.len(s)<2 then
			ShowScreen();
			WaitKey();
			lib.Delay(100)
		end
	end


    if CONFIG.KeyRepeat==0 then
	     lib.EnableKeyRepeat(CONFIG.KeyRepeatDelay,CONFIG.KeyRepeatInterval);
	end

end

function inteam(pid)
	return instruct_16(pid)
end

--�����ڳ��������Ƿ��ڷ�Χ��
function inrect(v1,v2,v3,v4)
	if v3==nil then
		if JY.Base["��X1"]==v1 and JY.Base["��Y1"]==v2 then
			return true
		end
	else
		if JY.Base["��X1"]>=v1 and JY.Base["��Y1"]>=v2 and JY.Base["��X1"]<=v3 and JY.Base["��Y1"]<=v4 then
			return true
		end
	end
	return false
end

function MoveSceneTo(x,y)
	if y~=nil then
		instruct_25(0,0,x-JY.Base["��X1"]-JY.SubSceneX,y-JY.Base["��Y1"]-JY.SubSceneY)
	else
		instruct_25(0,0,-JY.SubSceneX,-JY.SubSceneY)
	end
end

function walkto11(x,y)
	instruct_30(JY.Base["��X1"],JY.Base["��Y1"],x,y)
end

function fenjie(a,b)
	local aa,bb
	aa=math.modf(a/b)
	bb=math.fmod(a,b)
	return aa,bb
end

function ScreenFlash(color,flag)
	Cls();
	lib.FillColor(0,0,CC.ScreenW,CC.ScreenH,color,128);
	ShowScreen();
	lib.Delay(80);
	lib.ShowSlow(50,1);
	if flag~=nil then
		Light();
	end
end
--���ñ��
function SetFlag(id,value)
	if between(id,0,49151) then
		local n,x,y,level
		id,n=fenjie(id,2)
		id,y=fenjie(id,64)
		id,level=fenjie(id,6)
		x=math.fmod(id,64)
		--print(string.format('%d,%d,%d,%d',b,x,y,level))
		return SetS(90+n,x,y,level,value)
	end
	return false
end

function GetFlag(id)
	if between(id,0,49151) then
		local n,x,y,level
		id,n=fenjie(id,2)
		id,y=fenjie(id,64)
		id,level=fenjie(id,6)
		x=math.fmod(id,64)
		return GetS(90+n,x,y,level)
	end
	return 0
end

--�����ڼ�ʱ������,����ʱ�䴥�����¼�
function NextDay(n)
	n=n or 1;
	local day=GetFlag(1);
	for i=1,n do
		day=day+1;
		if TimeEvent[day]~=nil then
			TimeEvent[day]();
		end
	end
	SetFlag(1,day);
end

function vs(id1,x1,y1,id2,x2,y2,EXP,isexp)
	--local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	isexp=isexp or 0;
	WAR={};
	WAR.Data={};
	WAR.Data["����"]=0;
	WAR.Data["����"]="�д�";
	WAR.Data["��ͼ"]=JY.SubScene;
	if JY.Person[id2]["�ȼ�"]<16 then
		WAR.Data["����"]=307;
	elseif JY.Person[id2]["�ȼ�"]<31 then
		WAR.Data["����"]=305;
	elseif JY.Person[id2]["�ȼ�"]<46 then
		WAR.Data["����"]=304;
	elseif JY.Person[id2]["�ȼ�"]<51 then
		WAR.Data["����"]=303;
	end
	WAR.Data["����"]=50--EXP;
	
	WAR.Data["�Զ�ѡ���ս��"  .. 1]=id1;
	WAR.Data["�ҷ�X"  .. 1]=x1;
	WAR.Data["�ҷ�Y"  .. 1]=y1;
	WAR.Data["����"  .. 1]=id2;
	WAR.Data["�з�X"  .. 1]=x2;
	WAR.Data["�з�Y"  .. 1]=y2;
	local result;
	if x1<0 then
		WAR.Data["�ҷ�X"  .. 1]=JY.Base["��X1"];
		WAR.Data["�ҷ�Y"  .. 1]=JY.Base["��Y1"];
		result=WarMain(998,isexp);
	else
		result=WarMain(999,isexp);
	end
	local add;
	--lib.LoadSur(sid,0,0);
	--ShowScreen();
	--WaitKey()
	if result then
		add=(JY.Person[id2]["�ȼ�"]^2)/3+JY.Person[id2]["�ȼ�"]*5;
		local lvdiff=JY.Person[id2]["�ȼ�"]-JY.Person[id1]["�ȼ�"]
			lvdiff=limitX(lvdiff,-12,6);
			if lvdiff>0 then
				add=add*(7-lvdiff)/7;
			else
				add=add*(12-lvdiff)/12;
			end
		add=math.modf(add+JY.Person[id2]["�ȼ�"]+50);
		add=AddPersonAttrib(id2,"����",math.modf(add*(100+smagic(id2,58,1))/100))+Rnd(10);
		DrawStrBoxWaitKey(string.format("%s���*������� %d",JY.Person[id2]["����"],add),C_WHITE,CC.Fontbig,1);
		--lib.LoadSur(sid,0,0);
		if War_AddPersonLevel(id2) then
			JY.Person[id2]["�Ѻ�"]=JY.Person[id2]["�Ѻ�"]+1+Rnd(3);
		elseif JY.Person[id2]["�Ѻ�"]<80 and math.random(100)<50 then
			JY.Person[id2]["�Ѻ�"]=JY.Person[id2]["�Ѻ�"]+1+Rnd(2);
		end
	else
		--add=AddPersonAttrib(id2,"����",math.modf((EXP+JY.Person[0]["�ȼ�"])*(100+smagic(id2,58,1))/100));
	end
	--lib.FreeSur(sid);
	return result;
end

function FIGHT(meNUM,enemyNUM,p,q,EXP,isexp,wid,quick)
	wid=wid or 999;
	WAR={};
	WAR.Data={};
	WAR.Data["����"]=0;
	WAR.Data["����"]="����ս��";
	WAR.Data["��ͼ"]=JY.SubScene;
	WAR.Data["����"]=EXP;
	WAR.Data["����"]=302;
	
	local force=q;
	local fnum=enemyNUM;
	for i=1,meNUM do
		if p[3*i-2]==0 then
			force=p;
			fnum=meNUM;
			break;
		end
	end
	local pp={};
	local ni=0;
	for i=1,fnum do
		if force[3*i-2]>=0 then
			ni=ni+1;
			pp[ni]={force[3*i-2],2};
		end
	end
	if ni<fnum then
		for i,v in pairs(JY.Person) do
			if inteam(i) then
				local alreadyin=false;
				for ii,vv in pairs(pp) do
					if i==vv[1] then
						alreadyin=true;
						break;
					end
				end
				if not alreadyin then
					ni=ni+1;
					pp[ni]={i,0};
				end
			end
		end
		ShowAllPerson(pp,fnum);
		local ni=0;
		for i=1,fnum do
			if type(pp[i])=="table" and pp[i][2]>0 then
				ni=ni+1;
				force[3*ni-2]=pp[i][1];
			end
		end
	end
	
	
	for i=1,meNUM do
		if p[3*i-2]>=0 then
			WAR.Data["�Զ�ѡ���ս��"  .. i]=p[3*i-2];
			WAR.Data["�ҷ�X"  .. i]=p[3*i-1];
			WAR.Data["�ҷ�Y"  .. i]=p[3*i];
		else
			meNUM=i-1;
			break;
		end
	end
	for i=1,enemyNUM do
		if q[3*i-2]>=0 then
			WAR.Data["����"  .. i]=q[3*i-2];
			WAR.Data["�з�X"  .. i]=q[3*i-1];
			WAR.Data["�з�Y"  .. i]=q[3*i];
		else
			meNUM=i-1;
			break;
		end
	end
	if quick then
		return QuickWar(wid)
	else
		return WarMain(wid,isexp);
	end
end

function Getkflv(pid,kfid)
	if kfid<=0 then
		return 0;
	end
	for i=1,CC.MaxKungfuNum do
		if JY.Person[pid]["�����书"..i]==kfid then
			return 1+math.modf(JY.Person[pid]["�����书����"..i]/100)
		end
	end
	return 0;
end

--�¼���غ���
function E_kungfugame(fid,pid)
	--ѡ���ս������
	local id={0,};
	local id1={};
	local id2={};
	local id3={};
	local id4={};
	local num=1;
	for i=1,CC.ToalPersonNum do
		if fid==-99 or (fid>=0 and JY.Person[i]["����"]==fid and JY.Person[0]["���"]>=JY.Person[i]["���"]) or (fid<0 and JY.Person[i]["����"]~=-fid) then
				num=num+1;
				id[num]=i;
		end
	end
	--����
	for i=2,num-1 do
		for j=i+1,num do
			if JY.Person[id[i]]["���"]<JY.Person[id[j]]["���"] then
				id[i],id[j]=id[j],id[i];
			else
			if JY.Person[id[i]]["���"]==JY.Person[id[j]]["���"] and math.random(100)<20 then
				id[i],id[j]=id[j],id[i];
			end
			end
		end
	end
	--����
	id=TableRandom(id);
	--[[
	for i=2,math.min(16,num)-1 do
		for j=2,math.min(16,num) do
			if i~=j then
				if math.random(100)>50 then
					id[i],id[j]=id[j],id[i];
				end
			end
		end
	end]]--
	--local n=math.random(math.min(16,num));
	--id[1],id[n]=id[n],id[1];
	
	local size=math.modf(CC.ScreenW/28);
	local x=(CC.ScreenW-size*23.5-4)/2;
	local linelength=math.modf((CC.ScreenH-size*8)/6);
	local y=CC.ScreenH-(CC.ScreenH-linelength*5-size*5)/2-size*4;
	local function redrow()
		DrawBoxTitle(size*25,linelength*5+size*8,"���ɱ���",C_GOLD);
		local color;
		for i=1,16 do
			if id[i]~=nil then
				local s=GenTalkString(JY.Person[id[i]]["����"],1);
				DrawStrBox(x+(i-1)*size*1.5,y,s,C_WHITE,size);
				local win=id1[math.modf((i+1)/2)];
				if win~=nil and win==id[i] then
					color=C_RED;
				else
					color=C_WHITE;
				end
				DrawLine(	x+size/2+2+(i-1)*size*1.5,y-linelength,
									x+size/2+2+(i-1)*size*1.5,y,color);
				DrawLine(	x+size/2+2+(i-1)*size*1.5,y-linelength,
									x+size/2+2+(i-1)*size*1.5+size*0.75*(-1)^(1+i%2),y-linelength,color);
			else
				break;
			end
		end
		for i=1,8 do
			local win=id2[math.modf((i+1)/2)];
			if win~=nil and win==id1[i] then
				color=C_RED;
			else
				color=C_WHITE;
			end
			DrawLine(	x+size*5/4+2+(i-1)*size*3,y-linelength*2,
								x+size*5/4+2+(i-1)*size*3,y-linelength*1,color);
			DrawLine(	x+size*5/4+2+(i-1)*size*3,y-linelength*2,
								x+size*5/4+2+(i-1)*size*3+size*1.5*(-1)^(1+i%2),y-linelength*2,color);
		end
		for i=1,4 do
			local win=id3[math.modf((i+1)/2)];
			if win~=nil and win==id2[i] then
				color=C_RED;
			else
				color=C_WHITE;
			end
			DrawLine(	x+size*11/4+2+(i-1)*size*6,y-linelength*3,
								x+size*11/4+2+(i-1)*size*6,y-linelength*2,color);
			DrawLine(	x+size*11/4+2+(i-1)*size*6,y-linelength*3,
								x+size*11/4+2+(i-1)*size*6+size*3*(-1)^(1+i%2),y-linelength*3,color);
		end
		for i=1,2 do
			local win=id4[math.modf((i+1)/2)];
			if win~=nil and win==id3[i] then
				color=C_RED;
			else
				color=C_WHITE;
			end
			DrawLine(	x+size*23/4+2+(i-1)*size*12,y-linelength*4,
								x+size*23/4+2+(i-1)*size*12,y-linelength*3,color);
			DrawLine(	x+size*23/4+2+(i-1)*size*12,y-linelength*4,
								x+size*23/4+2+(i-1)*size*12+size*6*(-1)^(1+i%2),y-linelength*4,color);
		end
		if id4[1]~=nil then
			color=C_RED;
		else
			color=C_WHITE;
		end
		DrawLine(	CC.ScreenW/2,y-linelength*5,
							CC.ScreenW/2,y-linelength*4,color);
		DrawStrBox(CC.ScreenW/2-size-4,y-linelength*5-size-7,"��ʤ",color,size);
		
	end
	
	local function vvss(iid1,iid2)
		if iid1~=0 and iid2~=0 then
			redrow();
			if not DrawStrBoxYesNo(-1,-1,string.format("��%s��Vs��%s�ף��Ƿ��ս��",JY.Person[iid1]["����"],JY.Person[iid2]["����"]),C_WHITE,CC.Fontbig) then
				return FIGHT(1,1,{iid1,21,27},{iid2,13,26},100,-1,999,true);
			end
		end
		return VVS(iid1,iid2);
	end
	redrow();
	ShowScreen();
	WaitKey();
	Cls();
	for i=1,8 do
		local ida,idb=id[i*2-1],id[i*2];
		if ida==nil then
			id1[i]=nil;
			break;
		end
		if idb==nil then
			id1[i]=ida;
			break
		end
		if idb==0 then
			ida,idb=idb,ida;
		end
		if vvss(ida,idb) then
			id1[i]=ida;
		else
			id1[i]=idb;
		end
		redrow();
		--ShowScreen();
		DrawStrBoxWaitKey(string.format("%s��ʤ��",JY.Person[id1[i]]["����"]),C_WHITE,CC.Fontbig,1);
		--WaitKey();
	end
	for i=1,4 do
		local ida,idb=id1[i*2-1],id1[i*2];
		if ida==nil then
			id2[i]=nil;
			break;
		end
		if idb==nil then
			id2[i]=ida;
			break
		end
		if idb==0 then
			ida,idb=idb,ida;
		end
		if vvss(ida,idb) then
			id2[i]=ida;
		else
			id2[i]=idb;
		end
		redrow();
		--ShowScreen();
		DrawStrBoxWaitKey(string.format("%s��ʤ��",JY.Person[id2[i]]["����"]),C_WHITE,CC.Fontbig,1);
		--WaitKey();
	end
	for i=1,2 do
		local ida,idb=id2[i*2-1],id2[i*2];
		if ida==nil then
			id3[i]=nil;
			break;
		end
		if idb==nil then
			id3[i]=ida;
			break
		end
		if idb==0 then
			ida,idb=idb,ida;
		end
		if vvss(ida,idb) then
			id3[i]=ida;
		else
			id3[i]=idb;
		end
		redrow();
		--ShowScreen();
		DrawStrBoxWaitKey(string.format("%s��ʤ��",JY.Person[id3[i]]["����"]),C_WHITE,CC.Fontbig,1);
		--WaitKey();
	end
	for i=1,1 do
		local ida,idb=id3[i*2-1],id3[i*2];
		if ida==nil then
			id4[i]=nil;
			break;
		end
		if idb==nil then
			id4[i]=ida;
			break
		end
		if idb==0 then
			ida,idb=idb,ida;
		end
		if vvss(ida,idb) then
			id4[i]=ida;
		else
			id4[i]=idb;
		end
		redrow();
		--ShowScreen();
		DrawStrBoxWaitKey(string.format("%s��ʤ��",JY.Person[id4[i]]["����"]),C_WHITE,CC.Fontbig,1);
		--WaitKey();
	end
	if id4[1]==0 then
		say("���������ǵ�һ�أ�");
		if JY.Person[0]["���"]==1 then
			JY.Person[0]["���"]=2;
			JY.Person[0]["���"]=string.sub(JY.Person[0]["���"],1,4).."����";
			say("��ʵ����"..JY.Person[0]["���"].."�������������ѧϰ����һ�����书�ˡ�",pid);
		elseif JY.Person[0]["���"]==2 then
			JY.Person[0]["���"]=3;
			JY.Person[0]["���"]=string.sub(JY.Person[0]["���"],1,4).."����";
			say("��ʵ����"..JY.Person[0]["���"].."�������������ѧϰ���ŵĸ����书�ˡ�",pid);
		end
	else
		say("û��ȡʤʵ���Ǻ��ź����´�һ��Ҫȡ�õ�һ��");
	end
end

function VVS(iid1,iid2)

		if JY.SubScene==27 then
			ModifyWarMap=function()
								SetWarMap(25,26,1,851*2);
								SetWarMap(25,27,1,851*2);
								SetWarMap(25,28,1,851*2);
								SetWarMap(25,29,1,851*2);
			end
								local r=FIGHT(1,1,{iid1,21,27},{iid2,13,26},100,-1);
			--[[
								SetS(JY.SubScene,25,26,1,921*2);
								SetS(JY.SubScene,25,27,1,0);
								SetS(JY.SubScene,25,28,1,0);
								SetS(JY.SubScene,25,29,1,919*2);
			]]--
								Cls();
								--ShowScreen();
								return r;
		elseif JY.SubScene==29 then
			ModifyWarMap=function()
								SetWarMap(26,27,1,1137*2);
								SetWarMap(26,28,1,1137*2);
								SetWarMap(26,29,1,1137*2);
								SetWarMap(23,24,1,854*2);
								SetWarMap(23,33,1,854*2);
			end
								local r=FIGHT(1,1,{iid1,23,28},{iid2,18,27},100,-1);
			--[[
								SetS(JY.SubScene,26,27,1,1138*2);
								SetS(JY.SubScene,26,28,1,0);
								SetS(JY.SubScene,26,29,1,1136*2);
								SetS(JY.SubScene,23,24,1,0);
								SetS(JY.SubScene,23,33,1,0);
			]]--
								Cls();
								--ShowScreen();
								return r;
		elseif JY.SubScene==36 then
			ModifyWarMap=function()
								SetWarMap(29,24,1,854*2);
								SetWarMap(23,18,1,903*2);
								SetWarMap(34,18,1,903*2);
			end
								local r=FIGHT(1,1,{iid1,29,21},{iid2,28,14},100,-1);
			--[[
								SetS(JY.SubScene,29,24,1,0);
								SetS(JY.SubScene,23,18,1,0);
								SetS(JY.SubScene,34,18,1,0);
			]]--
								Cls();
								--ShowScreen();
								return r;
		elseif JY.SubScene==57 then
			ModifyWarMap=function()
								SetWarMap(21,24,1,2268);
								SetWarMap(22,24,1,2268);
								SetWarMap(23,24,1,2268);
			end
								local r=FIGHT(1,1,{iid1,21,22},{iid2,21,13},100,-1);
			--[[
								SetS(JY.SubScene,21,24,1,2266);
								SetS(JY.SubScene,22,24,1,0);
								SetS(JY.SubScene,23,24,1,2270);
			]]--
								Cls();
								--ShowScreen();
								return r;
		elseif JY.SubScene==58 then
			ModifyWarMap=function()
								SetWarMap(28,28,1,1429*2);
								SetWarMap(29,28,1,1429*2);
								SetWarMap(30,28,1,1429*2);
								SetWarMap(23,23,1,903*2);
								SetWarMap(35,25,1,903*2);
			end
								local r=FIGHT(1,1,{iid1,17,22},{iid2,16,13},100,-1);
			--[[
								SetS(JY.SubScene,28,28,1,0);
								SetS(JY.SubScene,29,28,1,0);
								SetS(JY.SubScene,30,28,1,0);
								SetS(JY.SubScene,23,23,1,0);
								SetS(JY.SubScene,35,25,1,0);
			]]--
								Cls();
								--ShowScreen();
								return r;
		else
		
		end
end
function VVVS()
	local iid1=0;
	local iid2=161;
		if JY.SubScene==27 then
			ModifyWarMap=function()
								SetWarMap(48,29,1,1492*2);
								SetWarMap(57,42,1,1492*2);
								SetWarMap(57,43,1,1492*2);
			end
								local r=FIGHT(1,1,{iid1,50,29},{iid2,54,30},100,-1);
								Cls();
								--ShowScreen();
								return r;
		elseif JY.SubScene==29 then
			ModifyWarMap=function()
								SetWarMap(26,27,1,1137*2);
								SetWarMap(26,28,1,1137*2);
								SetWarMap(26,29,1,1137*2);
									SetWarMap(43,26,1,2243*2);
									SetWarMap(43,27,1,2242*2);
									SetWarMap(43,28,1,2242*2);
									SetWarMap(43,29,1,2241*2);
			end
								local r=FIGHT(1,1,{iid1,27,28},{iid2,31,27},100,-1);
								Cls();
								--ShowScreen();
								return r;
		elseif JY.SubScene==36 then
			ModifyWarMap=function()
								SetWarMap(29,24,1,854*2);
								SetWarMap(28,44,1,1021*2);
								SetWarMap(29,44,1,1022*2);
								SetWarMap(30,44,1,1023*2);
								SetWarMap(28,43,1,0);
								SetWarMap(30,43,1,0);
			end
								local r=FIGHT(1,1,{iid1,29,25},{iid2,28,32},100,-1);
								Cls();
								--ShowScreen();
								return r;
		elseif JY.SubScene==57 then
			ModifyWarMap=function()
									SetWarMap(47,28,1,1840);
									SetWarMap(47,29,1,1840);
									SetWarMap(47,30,1,1840);
									SetWarMap(47,31,1,1840);
									
									SetWarMap(50,27,1,1491*2);
									SetWarMap(51,27,1,1491*2);
									SetWarMap(50,32,1,1491*2);
									SetWarMap(51,32,1,1491*2);
									SetWarMap(57,29,1,1491*2);
									SetWarMap(57,30,1,1491*2);
			end
								local r=FIGHT(1,1,{iid1,47,30},{iid2,54,29},100,-1);
								Cls();
								--ShowScreen();
								return r;
		elseif JY.SubScene==58 then
			ModifyWarMap=function()
									SetWarMap(27,47,1,1021*2);
									SetWarMap(28,47,1,1022*2);
									SetWarMap(29,47,1,1022*2);
									SetWarMap(30,47,1,1023*2);
									SetWarMap(27,46,1,0);
									SetWarMap(30,46,1,0);
									SetWarMap(48,55,1,1144*2);
									SetWarMap(49,55,1,1144*2);
									SetWarMap(25,53,1,1144*2);
			end
								local r=FIGHT(1,1,{iid1,28,48},{iid2,36,53},100,-1);
			--[[
								SetS(JY.SubScene,28,28,1,0);
								SetS(JY.SubScene,29,28,1,0);
								SetS(JY.SubScene,30,28,1,0);
								SetS(JY.SubScene,23,23,1,0);
								SetS(JY.SubScene,35,25,1,0);
			]]--
								Cls();
								--ShowScreen();
								return r;
		else
		
		end
end
--��������
function E_guarding(id)
	say("�ð�������������Ҫ��ȥ���졣����Ҷ������",id);
	if DrawStrBoxYesNo(-1,-1,"�Ƿ�Ҫվ�����죿",C_WHITE,CC.Fontbig) then
		if JY.Person[0]["����"]<50 then
			say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",id);
			return;
		end
		Dark();
		lib.Delay(1200);
		if DayPass(7,-3) then
			Light();
			if Rnd(10)<-6 then
				say("�����ģ����������һΡ�");
				say("����ү����ȥ�ľ�ȥ�ģ�",161);
				if VVVS() then
					--say("�Ͻ����ɡ�");
					say("�ţ��ո���ô�д򶷵���������ʲô����",id);
					say("û�£����˸�С�����Ѿ��򷢵��ˡ�");
					AddPerformance(10);
				else
					say("�ߣ��������ű���ү��",161);
					Dark();
					say("���������ӣ��������ﵷ�ң�",id);
					Light();
					say("�У�����",161);
					say("�Һ��㼴ʱ�ϻ����ˡ�");
				end
			else
				say("�һ����ˣ���ȥ��Ϣ�ɡ�",id);
				AddPerformance(5);
			end
		else
			--say("�����ˣ�˭�����Ҽ��죿",id);
			script_say("��ɽ���ӣ�����ô����������ְ���أ�");
			AddPerformance(-5);
		end
	else
		say("���������ȥ�����ء�",id);
	end
end
--��ܶ���
function E_readbook()
						if DrawStrBoxYesNo(-1,-1,"�Ƿ�����ʱ����������ѧ�ĵã�",C_WHITE,CC.Fontbig) then
								if JY.Person[0]["����"]<30 then
									say("���У�ʵ��̫���ˡ���������Ϣ���������о��ɡ�");
									return;
								end
							say("ʱ���ѵã��úÿ����ɡ�");
							Dark();
							lib.Delay(1500);
							if DayPass(3,-3) then
								Light();
								local add,str;
								if myRnd100()/100-JY.Person[0]["��Ե"]/200<(JY.Person[0]["�ȼ�"]+5)/(JY.Person[0]["�ȼ�"]/2+GetFlag(1000)/3) then
									say("ԭ����ˣ�ǰ�����ĵù�Ȼʹ��é���ٿ���");
									add,str=AddPersonAttrib(0,"��������",math.modf(80-Rnd(40)+(4+JY.Person[0]["�ȼ�"])*800/(140-JY.Person[0]["����"])*(100+smagic(0,58,1))/100));
									SetFlag(1000,GetFlag(1000)+1);
								else
									say("ʲôǰ�����ĵã�һ���м�ֵ�Ķ�����û�У�");
									add,str=AddPersonAttrib(0,"��������",math.random(10)+10);
									SetFlag(1000,GetFlag(1000)-2);
								end
								DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
							end
						else
							say("�´������ɡ�");
						end
end
--�չ�����
function E_training(id)

						if DrawStrBoxYesNo(-1,-1,"�Ƿ�Ҫ�������죿",C_WHITE,CC.Fontbig) then
							say("�á�");
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",id);
									return;
								end
							Dark();
							lib.Delay(1000);
							--SetFlag(1,GetFlag(1)+3);
							if DayPass(5,-3) then
								Light();
								if myRnd100()/4<GetFlag(1)-GetFlag(1001)+JY.Person[0]["��Ե"]/4+JY.Person[0]["����"]/4-5 then
									say("������Ҳ��������ѧ���˲��ٶ���������ֵͦ�õġ�");
									local add,str=AddPersonAttrib(0,"����",math.modf(100-Rnd(50)+(4+JY.Person[0]["�ȼ�"])*2000/(200-JY.Person[0]["����"])*(100+smagic(0,58,1))/100));
									DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
									War_AddPersonLevel(0);
								else
									say("��ѽ����Ť�ˣ�");
									say("��û�°ɣ�",JY.Da);
									say("Ӧ��ûʲô�󰭰ɣ���Ϣ����ͺ���");
									JY.Person[0]["����"]=10;
									DrawStrBoxWaitKey(JY.Person[0]["����"] .. "����ʱ����С��������",C_ORANGE,CC.Fontbig);
								end
								SetFlag(1001,GetFlag(1));
							end
						else
							say("�����һ����£��´ΰ�");
						end
end
--��������
function E_learning(id)
	local p1=JY.Person[0];
	local p2=JY.Person[id];
	if p2["�Ѻ�"]<10 then
		say("�Һ����ֲ��Ǻ��죬ΪʲôҪ���㡣",id);
		return;
	elseif p2["�Ѻ�"]<=20 then
		if Rnd(p2["�Ѻ�"])<=10 then
			say("�����е��£�����ɡ�",id);
			return;
		end
	end
	local menu=	{
							{"ȭ��",nil,0},
							{"����",nil,0},
							{"ˣ��",nil,0},
							{"ǹ��",nil,0},
							--{"",nil,1},
						};
	local flag=false;
	for i,v in pairs(menu) do
		if math.modf(p2[v[1]]/10)>math.modf(p1[v[1]]/10) then
			v[3]=1;
			flag=true;
		end
	end
	menu[5]={"ȡ��",nil,2};
	if flag then
		say("�����ʲô�أ�",id);
		local i=EasyMenu(menu);
		if i==5 then
			say("�ǽ�������˰ɡ�",id);
		else
			local str=menu[i][1];
			local lv=math.modf(p1[str]/10);
			if p1["����"]<20+lv*5 then
				say("����"..str.."�Ǻ�������£��㻹������Ϣ�������ɡ�",id);
			else
				say(string.format("����%s��Ҫ����%d��ʱ�䣬��Ҫ������",str,10+lv*5),id);
				if DrawStrBoxYesNo(-1,-1,"�Ƿ������",C_WHITE,CC.Fontbig) then
					Dark();
					lib.Delay(700);
					if DayPass(10+lv*5,-1) then
						Light();
						local e=math.modf(40/(lv+4))+Rnd(3);
						AddPersonAttrib(0,str,e);
						if p1[str]>(lv+1)*10 then
							p1[str]=(lv+1)*10;
							DrawStrBoxWaitKey( str.."������",C_ORANGE,CC.Fontbig);
						else
							DrawStrBoxWaitKey(str.."����������",C_ORANGE,CC.Fontbig);
						end
						say("лл���ָ����");
					end
				else
					say("�ǽ�������˰ɡ�",id);
				end
			end
		end
	else
		say("�ƺ���ûʲô���Խ���İ���",id);
	end
end
--���ɹ���
function AddPerformance(n)
	local v=GetFlag(1002);
	local function glv(vv)
		if vv>=1500 then
			return 3;
		elseif vv>=300 then
			return 2;
		elseif vv>=50 then
			return 1;
		else
			return 0;
		end
	end
	local lv=JY.Person[0]["���"];
	v=v+n;
	if v<0 then
		v=0;
	end
	SetFlag(1002,v);
	if n>0 then
		DrawStrBoxWaitKey(JY.Person[0]["����"].."���ɹ�������",C_WHITE,CC.Fontbig);
	else
		DrawStrBoxWaitKey(JY.Person[0]["����"].."���ɹ��׽���",C_RED,CC.Fontbig);
	end
	if glv(v)>lv then
		DrawStrBoxWaitKey(JY.Person[0]["����"].."���ɵ�λ����",C_GOLD,CC.Fontbig);
		JY.Person[0]["���"]=lv+1;
	elseif false and glv(v)<lv then
		DrawStrBoxWaitKey(JY.Person[0]["����"].."���ɵ�λ����",C_WHITE,CC.Fontbig);
		JY.Person[0]["���"]=lv-1;
	end
end
--�����书
function KaochaKungfu(pid)
	say("�����뿼��һ������书��",pid);
	if DrawStrBoxYesNo(-1,-1,"�Ƿ���ܣ�",C_WHITE,CC.Fontbig) then
		say("�ǣ�");
		local eid={};
		local num=0;
		for i=1,CC.ToalPersonNum do
			local p=JY.Person[i];
			if p["����"]==JY.Person[0]["����"] then
				if p["���"]<=JY.Person[0]["���"] then
					num=num+1;
					eid[num]=i;
				end
			end
		end
		for i=1,num-1 do
			for j=i+1,num do
				if JY.Person[eid[i]]["�ȼ�"]>JY.Person[eid[j]]["�ȼ�"] then
					eid[i],eid[j]=eid[j],eid[i];
				end
			end
		end
		for i=1,num do
			if JY.Person[eid[i]]["�ȼ�"]>JY.Person[0]["�ȼ�"] then
				num=i;
				break;
			end
		end
		say(string.format("%s�����书��࣬���Ǳ���һ�°ɡ�",JY.Person[eid[num]]["����"]),pid);
		if VVS(0,eid[num]) then
			say("�������������Ŭ������",pid);
			say("ָ��һ������书��.",pid);
			local add,str=AddPersonAttrib(0,"����",(4+JY.Person[0]["�ȼ�"])*15+500+math.random(50));
			DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
			War_AddPersonLevel(0);
			AddPersonAttrib(pid,"�Ѻ�",2);
		else
			say("��Ҫ���ģ��ú�Ŭ���ɡ�",pid);
			say("��΢ָ��һ������书��.",pid);
			local add,str=AddPersonAttrib(0,"����",(4+JY.Person[0]["�ȼ�"])*5+200+math.random(50));
			DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
			War_AddPersonLevel(0);
		end
	else
		say("�����Ǹ��������е㲻�����");
		say("û�õļһ���°ɡ�",pid);
		AddPersonAttrib(pid,"�Ѻ�",-5);
	end
end
--NPC����д�
function NPCQiecuo(pid)
	say("�����п����ܲ���������������",pid);
	if DrawStrBoxYesNo(-1,-1,"�Ƿ���ܣ�",C_WHITE,CC.Fontbig) then
		say("�ð������ǵ㵽��ֹ��");
		if VVS(0,pid) then
			say("��Ȼ������лл���ָ�㡣",pid);
			AddPersonAttrib(pid,"�Ѻ�",2);
		else
			say("��Ҫ���ģ��ú�Ŭ���ɡ�",pid);
		end
	else
		say("�����Ǹ��������е㲻�����");
		say("�Ǿ����˰ɡ�",pid);
		AddPersonAttrib(pid,"�Ѻ�",-2);
	end
end
--����+����
function AddZIZHI(pid)
	if DrawStrBoxYesNo(-1,-1,"�Ƿ�Ҫ�������죿",C_WHITE,CC.Fontbig) then
		if JY.Person[0]["����"]<50 then
			say("���У�ʵ��̫���ˡ���������Ϣ��������ѧϰ�ɡ�");
			return;
		end
		say("ʱ���ѵã��úÿ����ɡ�");
		Dark();
		local p1,p2,p3,p4,p5=dofile(".\\script\\qs.lua");
		--����ȷ���������ԣ���������ʱ�䣬���������
		local ZZexp=GetFlag(803);
		local lv=math.modf(ZZexp/100);
		ZZexp=ZZexp-lv*100;
		if lv<5 then
			ZZexp=ZZexp+p1*limitX(100-p4/40,1,100)/50;
		else
			ZZexp=ZZexp+p2*limitX(100-p4/20,1,100)/70;
		end
		if DayPass(7,-2) then
			say("ÿ��Ļ��ۣ��վ����лر��ġ�");
			if ZZexp>100 then
				if lv<10 then
					SetFlag(803,lv*100+ZZexp);
					AddPersonAttrib(0,"����",1);
					DrawStrBoxWaitKey(JY.Person[0]["����"].."������",C_WHITE,CC.Fontbig,1);
				end
			end
		end
	else
		say("����ɡ�");
	end
end

function visit(fid)	--���ɰݷ�
	DrawStrBoxWaitKey("�˹��ܸĽ��У���ʱ����");
	if true then
		return;
	end
	local pp={};
	local ni=0;
	for i,v in pairs(JY.Person) do
		if v["����"]==fid and v["����"]==JY.Shop[fid]["�ݵ�"] and (not inteam(i)) then
			ni=ni+1;
			pp[ni]={i,0};
		end
	end
	if ni==0 then
		say("û�пɰݷõ��˰���");
		return;
	end
	local pid=ShowAllPerson(pp);
	if pid<0 then
		say("��������˰ɡ�");
		return;
	end
	Dark();
	Light();
	--�Ѻõ͵�,������ڼ�
	if JY.Person[pid]["�Ѻ�"]<40 then
		local r=Rnd(JY.Person[pid]["�Ѻ�"]+60);
		if r<13 then
			say("û�˰���"..JY.Person[pid]["����"].."�ƺ����ڼң��´������ɡ�");
			DayPass(1);
			Dark();
			Light();
			return;
		elseif r<20 then
			say("��ѽ����ӭ���٣�ֻ������������Ҫ��ȥ����������˰ɣ��������ٵ��Űݷá�",pid);
			say("������̫�ź��ˣ�����ȥæ�ɡ�");
			DayPass(1);
			Dark();
			Light();
			return;
		end
	end
	say("���ٺ��ᣬ��ʲô����",pid);
	JY.Da=pid;
	local menu={
							{"����",nil,1},
							{"�д�",nil,1},
							{"����",nil,1},
							{"����",nil,0},
							{"״̬",nil,1},
							{"�뿪",nil,1},
						};
	if JY.Person[pid]["���"]>0 then
		if JY.Person[0]["����"]>=0 and JY.Person[0]["����"]==JY.Person[pid]["����"] then
			menu[4][3]=1;
		end
	end
	while true do
		local r=ShowMenu(menu,6,0,0,0,0,0,1,0);
		if r==1 then
			RandomEvent(JY.Da);
			menu[1][3]=0;
		elseif r==2 then
			if JY.Person[0]["����"]<30 then
				say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
				return;
			end
			say("�ð������������档",JY.Da);
			local result=VVS(0,pid)
			Cls();
			ShowScreen();
			if result then
				say("��Ȼ������",JY.Da);
			else
				say("�㻹�ö����ģ������´����д�ɡ�",JY.Da);
			end
			DayPass(1);
			menu[2][3]=0;
		elseif r==3 then
			E_learning(JY.Da);
			menu[3][3]=0;
		elseif r==4 then
			local yh=JY.Person[pid]["�Ѻ�"];
			local yy=Rnd(10+yh);
			if Rnd(100)<JY.Person[0]["��Ե"] then
				local hh=Rnd(10+yh);
				if hh<yy then
					yy=hh;
				end
			end
			yh=yh*1.5+yy+Rnd(300);
			if yh>150 then
				say("�ð�����������һ�˰ɡ�",JY.Da);
				addteam(pid);
			elseif yh>80 then
				say("�ţ�Ҳ�á�������������������书��",JY.Da);
				local result=VVS(0,pid)
				Cls();
				ShowScreen();
				if result then
					say("��Ȼ��������������ͳ����ɡ�",JY.Da);
					addteam(pid);
				else
					say("�㻹�ö����ġ�",JY.Da);
				end
			else
				say("�������ж��£�������Ͼ��������ˡ�",JY.Da);
			end
			DayPass(1);
			break;
		elseif r==5 then
			PersonStatus(JY.Da);
		elseif r==6 then
			say("��ô���´��ټ���",JY.Da);
			DayPass(1);
			break;
		end
	end
	Dark();
	Light();
end
function PersonSelection(pp,fnum)
	
	ShowAllPerson(pp,fnum);
		
end
function E_kungfugamefree()
	--ѡ���ս������
	local pp={};
	local id={};
	local id1={};
	local id2={};
	local id3={};
	local id4={};
	local num=0;
	local menu=	{
					{"ʮ������",nil,1},
					{"��ʮ������",nil,1},
					{"��ʮ������",nil,1},
					{"������",nil,1},
				}
	local sel=GenSelection(menu);
	if sel==4 then
		sel=0;
	end
	for i=1,CC.ToalPersonNum do
		if JY.Person[i]["���"]>0 and JY.Person[i]["�⹦1"]>0 then
			if JY.Person[i]["�ȼ�"]>sel*10-4 then
				table.insert(pp,{i,0});
				num=num+1;
			end
		end
	end
	PersonSelection(pp,16);
	for i,v in pairs(pp) do
		if v[2]==1 then
			table.insert(id,v[1]);
		end
	end
	for i=table.maxn(id)+1,16 do
		local n;
		while true do
			n=math.random(num);
			if pp[n][2]==0 then
				pp[n][2]=1;
				table.insert(id,pp[n][1]);
				break;
			end
		end
	end
	--����
	id=TableRandom(id,16)
	--[[
	for i=1,math.min(16,num)-1 do
		for j=i+1,math.min(16,num) do
			if math.random(100)>50 then
				id[i],id[j]=id[j],id[i];
			end
		end
	end]]--
	
	local size=math.modf(CC.ScreenW/28);
	local x=(CC.ScreenW-size*23.5-4)/2;
	local linelength=math.modf((CC.ScreenH-size*8)/6);
	local y=CC.ScreenH-(CC.ScreenH-linelength*5-size*5)/2-size*4;
	local function redrow()
		DrawBoxTitle(size*25,linelength*5+size*8,"ģ�����",C_GOLD);
		local color;
		for i=1,16 do
			if id[i]~=nil then
				local s=GenTalkString(JY.Person[id[i]]["����"],1);
				DrawStrBox(x+(i-1)*size*1.5,y,s,C_WHITE,size);
				local win=id1[math.modf((i+1)/2)];
				if win~=nil and win==id[i] then
					color=C_RED;
				else
					color=C_WHITE;
				end
				DrawLine(	x+size/2+2+(i-1)*size*1.5,y-linelength,
									x+size/2+2+(i-1)*size*1.5,y,color);
				DrawLine(	x+size/2+2+(i-1)*size*1.5,y-linelength,
									x+size/2+2+(i-1)*size*1.5+size*0.75*(-1)^(1+i%2),y-linelength,color);
			else
				break;
			end
		end
		for i=1,8 do
			local win=id2[math.modf((i+1)/2)];
			if win~=nil and win==id1[i] then
				color=C_RED;
			else
				color=C_WHITE;
			end
			DrawLine(	x+size*5/4+2+(i-1)*size*3,y-linelength*2,
								x+size*5/4+2+(i-1)*size*3,y-linelength*1,color);
			DrawLine(	x+size*5/4+2+(i-1)*size*3,y-linelength*2,
								x+size*5/4+2+(i-1)*size*3+size*1.5*(-1)^(1+i%2),y-linelength*2,color);
		end
		for i=1,4 do
			local win=id3[math.modf((i+1)/2)];
			if win~=nil and win==id2[i] then
				color=C_RED;
			else
				color=C_WHITE;
			end
			DrawLine(	x+size*11/4+2+(i-1)*size*6,y-linelength*3,
								x+size*11/4+2+(i-1)*size*6,y-linelength*2,color);
			DrawLine(	x+size*11/4+2+(i-1)*size*6,y-linelength*3,
								x+size*11/4+2+(i-1)*size*6+size*3*(-1)^(1+i%2),y-linelength*3,color);
		end
		for i=1,2 do
			local win=id4[math.modf((i+1)/2)];
			if win~=nil and win==id3[i] then
				color=C_RED;
			else
				color=C_WHITE;
			end
			DrawLine(	x+size*23/4+2+(i-1)*size*12,y-linelength*4,
								x+size*23/4+2+(i-1)*size*12,y-linelength*3,color);
			DrawLine(	x+size*23/4+2+(i-1)*size*12,y-linelength*4,
								x+size*23/4+2+(i-1)*size*12+size*6*(-1)^(1+i%2),y-linelength*4,color);
		end
		if id4[1]~=nil then
			color=C_RED;
		else
			color=C_WHITE;
		end
		DrawLine(	CC.ScreenW/2,y-linelength*5,
							CC.ScreenW/2,y-linelength*4,color);
		DrawStrBox(CC.ScreenW/2-size-4,y-linelength*5-size-7,"��ʤ",color,size);
		
	end
	
	local function vvss(iid1,iid2)
		if iid1~=0 and iid2~=0 then
			redrow();
			if not DrawStrBoxYesNo(-1,-1,string.format("��%s��Vs��%s�ף��Ƿ��ս��",JY.Person[iid1]["����"],JY.Person[iid2]["����"]),C_WHITE,CC.Fontbig) then
				return FIGHT(1,1,{iid1,21,27},{iid2,13,26},100,-1,999,true);
			end
		end
		return VVS(iid1,iid2);
	end
	redrow();
	ShowScreen();
	WaitKey();
	Cls();
	for i=1,8 do
		local ida,idb=id[i*2-1],id[i*2];
		if ida==nil then
			id1[i]=nil;
			break;
		end
		if idb==nil then
			id1[i]=ida;
			break
		end
		if idb==0 then
			ida,idb=idb,ida;
		end
		if vvss(ida,idb) then
			id1[i]=ida;
		else
			id1[i]=idb;
		end
		redrow();
		--ShowScreen();
		DrawStrBoxWaitKey(string.format("%s��ʤ��",JY.Person[id1[i]]["����"]),C_WHITE,CC.Fontbig,1);
		--WaitKey();
	end
	for i=1,4 do
		local ida,idb=id1[i*2-1],id1[i*2];
		if ida==nil then
			id2[i]=nil;
			break;
		end
		if idb==nil then
			id2[i]=ida;
			break
		end
		if idb==0 then
			ida,idb=idb,ida;
		end
		if vvss(ida,idb) then
			id2[i]=ida;
		else
			id2[i]=idb;
		end
		redrow();
		--ShowScreen();
		DrawStrBoxWaitKey(string.format("%s��ʤ��",JY.Person[id2[i]]["����"]),C_WHITE,CC.Fontbig,1);
		--WaitKey();
	end
	for i=1,2 do
		local ida,idb=id2[i*2-1],id2[i*2];
		if ida==nil then
			id3[i]=nil;
			break;
		end
		if idb==nil then
			id3[i]=ida;
			break
		end
		if idb==0 then
			ida,idb=idb,ida;
		end
		if vvss(ida,idb) then
			id3[i]=ida;
		else
			id3[i]=idb;
		end
		redrow();
		--ShowScreen();
		DrawStrBoxWaitKey(string.format("%s��ʤ��",JY.Person[id3[i]]["����"]),C_WHITE,CC.Fontbig,1);
		--WaitKey();
	end
	for i=1,1 do
		local ida,idb=id3[i*2-1],id3[i*2];
		if ida==nil then
			id4[i]=nil;
			break;
		end
		if idb==nil then
			id4[i]=ida;
			break
		end
		if idb==0 then
			ida,idb=idb,ida;
		end
		if vvss(ida,idb) then
			id4[i]=ida;
		else
			id4[i]=idb;
		end
		redrow();
		--ShowScreen();
		DrawStrBoxWaitKey(string.format("%s��ʤ��",JY.Person[id4[i]]["����"]),C_WHITE,CC.Fontbig,1);
		--WaitKey();
	end
	say("����û�и������ģ�������",id4[1]);
end

function FirstTalk(pid)
	local xg=0;
	local mp=0;
	local mp1=JY.Person[0]["����"];
	local mp2=JY.Person[pid]["����"];
	local name1=JY.Person[0]["����"];
	local name2=JY.Person[pid]["����"];
	local name3="";
	local name4="";
	if mp1>=0 then
		name3=JY.Shop[mp1]["����"];
	end
	if mp2>=0 then
		name4=JY.Shop[mp2]["����"];
	end
	local msg=	{
					[0]=	{
								[0]=function()
									say("��λ��̨Ī�Ǳ���"..name4.."��"..name2.."��");
									say("�������£���֪�����ǡ���",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("�Ǻǣ��һ��һᡣ",pid);
								end,
								[1]=function()
									say("��λ��̨Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("�������£���֪�����ǡ���",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("�Ǻǣ��һ��һᡣ",pid);
								end,
								[2]=function()
									say("��λ��̨Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("�������£���֪�����ǡ���",pid);
									say("��������"..name3.."�ɵ��ӣ�������̨���������һ����ʵ�˴��ҡ�");
									say("�Ǻǣ��һ��һᡣ",pid);
								end,
								[3]=function()
									say("����ʦ�֡�");
									say("�ף����ǡ���",pid);
									say("����������������ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("�Ǻǣ�ʦ�ܲ�����˶���",pid);
								end,
								[4]=function()
									say("������λ"..name4.."��ʦ�֡�");
									say("�ף����ǡ���",pid);
									say("��������"..name3.."�����ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("�Ǻǣ����������������ã�������ͬ��ȴ������֮�飬ʦ�ܲ�����˶���",pid);
								end,
								[5]=function()
									say("���ʸ��¿���"..name4.."���£�");
									say("�ף����ǡ���",pid);
									say("��������"..name3.."�����ŵĵ��ӡ�");
									say("���������������ϣ���ν����ͬ����Ϊı���Ժ����Ҳ���������׽�������ƾ������ѡ�",pid);
								end,
							},
					[1]=	{
								[0]=function()
									say("��λ��̨Ī�Ǳ���"..name4.."��"..name2.."��");
									say("Ŷ���˴�Ҳ����֪��?",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("�Ǻǣ��������ڽ��������ǲ�����֪��ʱ����һλ������������ſ���",pid);
								end,
								[1]=function()
									say("��λ��̨Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("Ŷ���˴�Ҳ����֪��?",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("�Ǻǣ��������ڽ��������ǲ�����֪��ʱ����һλ������������ſ���",pid);
								end,
								[2]=function()
									say("��λ��̨Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("Ŷ���˴�Ҳ����֪��?",pid);
									say("��������"..name3.."�ɵ��ӣ�������̨���������һ����ʵ�˴��ҡ�");
									say("�Ǻǣ��������ڽ��������ǲ�����֪��ʱ����һλ������������ſ���",pid);
								end,
								[3]=function()
									say("����ʦ�֡�");
									say("�ף������֪�ң�",pid);
									say("����������������ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("�Ǻǣ��ҳ��������ڽ������ѵû�����һ�Σ����ǲ�֪�����ֵ���һλ��������ʦ�ܡ�",pid);
								end,
								[4]=function()
									say("������λ"..name4.."��ʦ�֡�");
									say("�ף������֪�ң�",pid);
									say("��������"..name3.."�������ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("�Ǻǣ��ҳ��������ڽ��������ǲ�֪X���ֵ���һλ��������ʦ�ܡ�",pid);
								end,
								[5]=function()
									say("���ʸ��¿���"..name4.."���£�");
									say("�ף������֪�ң�",pid);
									say("��������"..name3.."�������ŵĵ��ӡ�");
									say("�ҳ��������ڽ��������ǲ�֪X���ֶ���һ�����ӡ����������������ϣ��պ���꣬��ɲ�����ˡ�",pid);
								end,
							},
					[2]=	{
								[0]=function()
									say("��λ��̨Ī�Ǳ���"..name4.."��"..name2.."��");
									say("����ʲô�ˣ�",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("ʲô�Ҳ��ҵģ�үү��������������һ���ˣ����վ����ǰݹ�ɽͷ�ˡ�",pid);
								end,
								[1]=function()
									say("��λ��̨Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("����ʲô�ˣ�",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("ʲô�Ҳ��ҵģ�үү��������������һ���ˣ����վ����ǰݹ�ɽͷ�ˡ�",pid);
								end,
								[2]=function()
									say("��λ��̨Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("����ʲô�ˣ�",pid);
									say("��������"..name3.."�ɵ��ӣ�������̨���������һ����ʵ�˴��ҡ�");
									say("ʲô�Ҳ��ҵģ�үү��������������һ���ˣ����վ����ǰݹ�ɽͷ�ˡ�",pid);
								end,
								[3]=function()
									say("����ʦ�֡�");
									say("����ʲô�ˣ�",pid);
									say("����������������ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("����������һ�ף�үү�Ҿ���һ���ˡ��������ǰݹ�ɽͷ�ˣ��Ժ������۸��㣬���ܱ�үү�ҵ����ž��ǡ�",pid);
								end,
								[4]=function()
									say("������λ"..name4.."��ʦ�֡�");
									say("����ʲô�ˣ�",pid);
									say("��������"..name3.."�����ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("����������һ�ף�үү�Ҿ���һ���ˡ���������֮����Щ���顣�������ǰݹ�ɽͷ�ˣ��Ժ������۸��㣬���ܱ�үү�ҵ����ž��ǡ�",pid);
								end,
								[5]=function()
									say("���ʸ��¿���"..name4.."���£�");
									say("����ʲô�ˣ�",pid);
									say("��������"..name3.."�����ŵĵ��ӡ�");
									say("����������һ�ף�үү�Ҿ���һ���ˡ���������֮����Щ���Ը������ձ����ˣ��պ�����ٲ���Ҫ��ѵ��ѵ�㡣",pid);
								end,
							},
					[3]=	{
								[0]=function()
									say("��λ��̨Ī�Ǳ���"..name4.."��"..name2.."��");
									say("�������ˣ�",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("��������",pid);
								end,
								[1]=function()
									say("��λ��̨Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("�������ˣ�",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("��������",pid);
								end,
								[2]=function()
									say("��λ��̨Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("�������ˣ�",pid);
									say("��������"..name3.."�ɵ��ӣ�������̨���������һ����ʵ�˴��ҡ�");
									say("��������",pid);
								end,
								[3]=function()
									say("����ʦ�֡�");
									say("�������ˣ�",pid);
									say("����������������ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("�������ض���",pid);
								end,
								[4]=function()
									say("������λ"..name4.."��ʦ�֡�");
									say("�������ˣ�",pid);
									say("��������"..name3.."�����ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("�������ض���",pid);
								end,
								[5]=function()
									say("���ʸ��¿���"..name4.."���£�");
									say("�������ˣ�",pid);
									say("��������"..name3.."�����ŵĵ��ӡ�");
									say("�����ߣ�",pid);
								end,
							},
					[4]=	{
								[0]=function()
									say("��λ��̨Ī�Ǳ���"..name4.."��"..name2.."��");
									say("Ŷ����֪��̨���ǡ���",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("�Ǻǣ�ĳ����ܵ���̨��ˣ�����ڳ��һᣬ��������һ�롣",pid);
								end,
								[1]=function()
									say("��λ��̨Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("Ŷ����֪��̨���ǡ���",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("�Ǻǣ�ĳ����ܵ���̨��ˣ�����ڳ��һᣬ��������һ�롣",pid);
								end,
								[2]=function()
									say("��λ��̨Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("Ŷ����֪��̨���ǡ���",pid);
									say("��������"..name3.."�ɵ��ӣ�������̨���������һ����ʵ�˴��ҡ�");
									say("�Ǻǣ�ĳ����ܵ���̨��ˣ�����ڳ��һᣬ��������һ�롣",pid);
								end,
								[3]=function()
									say("����ʦ�֡�");
									say("Ŷ����֪��̨���ǡ���",pid);
									say("����������������ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("ԭ����ˡ�ʦ�ܲ��ض������Ҽ���ͬ�ţ��պ��л��ᵱ����һ�롣",pid);
								end,
								[4]=function()
									say("������λ"..name4.."��ʦ�֡�");
									say("Ŷ����֪��̨���ǡ���",pid);
									say("��������"..name2.."�����ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("ԭ����ˡ�ʦ�ܲ��ض������������������ã��պ��л��ᵱ����һ�롣",pid);
								end,
								[5]=function()
									say("���ʸ��¿���"..name4.."���£�");
									say("Ŷ����֪��̨���ǡ���",pid);
									say("��������"..name2.."�����ŵĵ��ӡ�");
									say("�����������ɲ��ϣ�ĳ�Ͳ�����Ⱦ��ˡ���ɡ�",pid);
								end,
							},
					[5]=	{
								[0]=function()
									say("��λ����Ī�Ǳ���"..name4.."��"..name2.."��");
									say("Ŷ����֪�������ǡ���",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("����������С�������ˡ�",pid);
								end,
								[1]=function()
									say("��λ����Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("Ŷ����֪�������ǡ���",pid);
									say("������������һ����С�䣬������̨���������һ����ʵ�˴��ҡ�");
									say("����������С�������ˡ�",pid);
								end,
								[2]=function()
									say("��λ����Ī�Ǳ��ǽ����϶���������"..name2.."��");
									say("Ŷ����֪�������ǡ���",pid);
									say("��������"..name3.."�ɵ��ӣ�������̨���������һ����ʵ�˴��ҡ�");
									say("����������С�������ˡ�",pid);
								end,
								[3]=function()
									say("����ʦ�֡�");
									say("Ŷ����֪�������ǡ���",pid);
									say("����������������ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("ԭ����ˡ����ҷ���ͬ�ţ�ʦ�ܲ�����˶���",pid);
								end,
								[4]=function()
									say("������λ"..name4.."��ʦ�֡�");
									say("Ŷ����֪�������ǡ���",pid);
									say("��������"..name3.."�����ŵĵ��ӣ�����ʦ���ڴˣ��������粻����");
									say("ԭ����ˡ����������������ã�ʦ�ܲ�����˶���",pid);
								end,
								[5]=function()
									say("���ʸ��¿���"..name4.."���£�");
									say("Ŷ����֪�������ǡ���",pid);
									say("��������"..name3.."�����ŵĵ��ӡ�");
									say("�������������������ϣ����������Գ���ݡ�",pid);
								end,
							},
					[6]=	{
								[0]=function()
									say("������λ��ʦ����");
									say("�����ӷ�",pid);
								end,
								[1]=function()
									say("������λ��ʦ����");
									say("�����ӷ�",pid);
								end,
								[2]=function()
									say("������λ��ʦ����");
									say("�����ӷ�",pid);
								end,
								[3]=function()
									say("������λ��ʦ����");
									say("�����ӷ�",pid);
								end,
								[4]=function()
									say("������λ��ʦ����");
									say("�����ӷ�",pid);
								end,
								[5]=function()
									say("������λ��ʦ����");
									say("�����ӷ�",pid);
								end,
							},
					[7]=	{
								[0]=function()
									say("����������");
									say("���ض���",pid);
								end,
								[1]=function()
									say("����������");
									say("���ض���",pid);
								end,
								[2]=function()
									say("����������");
									say("���ض���",pid);
								end,
								[3]=function()
									say("����������");
									say("���ض���",pid);
								end,
								[4]=function()
									say("����������");
									say("���ض���",pid);
								end,
								[5]=function()
									say("����������");
									say("���ض���",pid);
								end,
							},
					[8]=	{
								[0]=function()
									say("������λ"..name4.."�Ľ�㡣");
									say("�Ǻǣ�����˭�ҵ�С�磬�������ϲ����",pid);
									say("С��������������һ����С�ӣ���Ľ�����ˣ�ð�����ţ�������㲻Ҫ���ҡ�");
									say("�Ǻǣ������˵���������������ù����ء�",pid);
								end,
								[1]=function()
									say("������λ��㡣");
									say("�Ǻǣ�����˭�ҵ�С�磬�������ϲ����",pid);
									say("С��������������һ����С�ӣ���Ľ�����ˣ�ð�����ţ�������㲻Ҫ���ҡ�");
									say("�Ǻǣ������˵���������������ù����ء�",pid);
								end,
								[2]=function()
									say("������λ��㡣");
									say("�Ǻǣ�����˭�ҵ�С�磬�������ϲ����",pid);
									say("С������"..name3.."���ӣ���Ľ�����ˣ�ð�����ţ�������㲻Ҫ���ҡ�");
									say("�Ǻǣ������˵���������������ù����ء�",pid);
								end,
								[3]=function()
									say("����ʦ�㡣");
									say("�Ǻǣ�����˭�ҵ�С�磬�������ϲ����",pid);
									say("����������������ŵĵ��ӣ����ʦ����ˣ�ð�����ţ�����ʦ����֡�");
									say("�Ǻǣ������˵���������������ù����ء�",pid);
								end,
								[4]=function()
									say("������λ"..name4.."��ʦ�㡣");
									say("�Ǻǣ�����˭�ҵ�С�磬�������ϲ����",pid);
									say("С������"..name3.."���ӣ���Ľ�����ˣ�ð�����ţ�������㲻Ҫ���ҡ�");
									say("�Ǻǣ������˵���������������ù����ء�",pid);
								end,
								[5]=function()
									say("��λ������"..name4.."���£�");
									say("�Ǻǣ�����˭�ҵ�С�磬�������ϲ����",pid);
									say("С������"..name3.."���ӡ�");
									say("�Ǻǣ������˵�������㵹�ǲ�֪��"..name3.."��Ҳ������������~�´��л��ᶨ��ú���������~",pid);
								end,
							},
					[9]=	{
								[0]=function()
									say("������λ"..name4.."�Ĺ��");
									say("�������ǡ���",pid);
									say("����������������һ����С�ӣ�����������ʣ���ͻð��������ˡ�");
									say("�����ҡ����������ˡ�",pid);
								end,
								[1]=function()
									say("������λ���");
									say("�������ǡ���",pid);
									say("����������������һ����С�ӣ�����������ʣ���ͻð��������ˡ�");
									say("�����ҡ����������ˡ�",pid);
								end,
								[2]=function()
									say("������λ���");
									say("�������ǡ���",pid);
									say("��������"..name3.."���ӣ�����������ʣ���ͻð��������ˡ�");
									say("�����ҡ����������ˡ�",pid);
								end,
								[3]=function()
									say("����ʦ�㡣");
									say("�������ǡ���",pid);
									say("����������������ŵĵ��ӣ����ʦ�����ʣ���ͻð��������ˡ�");
									say("ʦ�ܲ�����˶���",pid);
								end,
								[4]=function()
									say("������λ"..name4.."��ʦ�㡣");
									say("�������ǡ���",pid);
									say("��������"..name3.."���ӣ����ʦ�����ʣ���ͻð��������ˡ�");
									say("ʦ�ܲ�����˶���",pid);
								end,
								[5]=function()
									say("��λ������"..name4.."���£�");
									say("�������ǡ���",pid);
									say("��������"..name3.."���ӡ�");
									say("���Ӳ�����ˡ����������������ϣ�����������ʹСŮ��������",pid);
								end,
							},
					[10]=	{
								[0]=function()
									say("������λ"..name4.."��Ů����");
									say("Ŷ���������ǡ���",pid);
									say("����������������һ����С�ӣ���������Ů��Ӣ�ˣ����ðζ�����е��������¡�");
									say("�������ޣ���ɵ��档",pid);
								end,
								[1]=function()
									say("������λŮ����");
									say("Ŷ���������ǡ���",pid);
									say("����������������һ����С�ӣ���������Ů��Ӣ�ˣ����ðζ�����е��������¡�");
									say("�������ޣ���ɵ��档",pid);
								end,
								[2]=function()
									say("������λŮ����");
									say("Ŷ���������ǡ���",pid);
									say("��������"..name3.."���ӣ���������Ů��Ӣ�ˣ����ðζ�����е��������¡�");
									say("�������ޣ���ɵ��档",pid);
								end,
								[3]=function()
									say("����ʦ�㡣");
									say("Ŷ���������ǡ���",pid);
									say("����������������ŵĵ��ӣ���������Ů��Ӣ�ˣ����ðζ�����е��������¡�");
									say("�������ޣ���ɵ��档������ţ����ڼӿ������պ󽭺�����������",pid);
								end,
								[4]=function()
									say("������λ"..name4.."��ʦ�㡣");
									say("Ŷ���������ǡ���",pid);
									say("��������"..name3.."���ӣ���������Ů��Ӣ�ˣ����ðζ�����е��������¡�");
									say("�������ޣ���ɵ��档",pid);
								end,
								[5]=function()
									say("��λ������"..name4.."���£�");
									say("Ŷ���������ǡ���",pid);
									say("��������"..name3.."���ӡ�");
									say("����֮�䲢�޽�������Ҳ���ؼ���",pid);
								end,
							},
				};
	xg=JY.Person[pid]["����"];
	if mp1<0 then
		if mp2<0 then
			mp=1;
			AddPersonAttrib(pid,"�Ѻ�",5);
		else
			mp=0;
			AddPersonAttrib(pid,"�Ѻ�",10);
		end
	else
		if mp2<0 then
			mp=2;
			AddPersonAttrib(pid,"�Ѻ�",5);
		else
			if mp1==mp2 then
				mp=3;
				AddPersonAttrib(pid,"�Ѻ�",20);
			elseif true then
				mp=4;
				AddPersonAttrib(pid,"�Ѻ�",10);
			elseif true then
				mp=5;
				AddPersonAttrib(pid,"�Ѻ�",1);
			end
		end
	end
	msg[xg][mp]();
end
function CommonDrink(pid)
	local xg=0;
	local mp=0;
	local mp1=JY.Person[0]["����"];
	local mp2=JY.Person[pid]["����"];
	local name1=JY.Person[0]["����"];
	local name2=JY.Person[pid]["����"];
	local name3="";
	local name4="";
	if mp1>=0 then
		name3=JY.Shop[mp1]["����"];
	end
	if mp2>=0 then
		name4=JY.Shop[mp2]["����"];
	end
	local msg=	{
					[0]=	{
								[0]=function()
									say("�ף�"..name2.."�֣�Ϊ���ڴ������������������ˣ�");
									say("����"..name1.."�֡�˵������"..name1.."��Ц�������ճ��Ŵ�æ�������̲������ˮ��Ǯ����ʱ����֪������Ǻð������ˣ�"..name1.."�֣���֪�ɷ񡭡�",pid);
									local money=JY.Person[0]["�ȼ�"]+JY.Person[pid]["�ȼ�"]*2+20+Rnd(20)-Rnd(20);
									if instruct_31(money) and DrawStrBoxYesNo(-1,-1,string.format("�Ƿ�֧����ˮǮ%d����",money)) then
										instruct_32(CC.ModifyD,-money);
										say("�Ǻǣ����߽�����˭�������д�ʱ�̣�"..name2.."���𼱣���Ƶ�������"..name2.."�ֱ��ǡ�");
										say("��л"..name1.."������������",pid);
										AddPersonAttrib(pid,"�Ѻ�",10);
									else
										say("ʵ�ڱ�Ǹ��������������������ɬ����������������ˡ�");
										say("���Ҳ��ҡ����������Ҹ�����Ǻá���",pid);
									end
								end,
								[1]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�⡭��������£����½�����Ҫ�������������ơ�",pid);
								end,
								[2]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("���оƲ������ȣ�С�������ϼ������ֺòˣ��ҽ���Ҫ��"..name1.."�ֺȸ�ʹ�죡",pid);
									AddPersonAttrib(pid,"�Ѻ�",5);
								end,
								[3]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�ǵ�����һ��װ�����������ʰ��֮��",pid);
									if CommonFight(pid) then
										say("������������Ǿ��Ʋ��Ⱥȷ����ˣ�");
									else
										say("����֮�ܣ����ձر���");
									end
									AddPersonAttrib(pid,"�Ѻ�",-5);
								end,
								[4]=function(r)
									if r==1 then
										if true then
											say("�Ǻǣ�"..name1.."�ָ��壬�����������������һ����",pid);
											AddPersonAttrib(pid,"�Ѻ�",2);
										else
											say("�ߣ�"..name1.."�֣�����Ǻ��ˣ�����������ֲ������ĵ��˻���һ������������������",pid);
										end
									elseif r==2 then
										if true then
											say(name1.."�֣���Ҳ�����Ǻȶ��˶��ѣ�����������أ�",pid);
											AddPersonAttrib(pid,"�Ѻ�",-2);
										else
											say("�͵�����������������"..name1.."�֣����źȾƣ����ǵ�����ɨ�����¡�",pid);
										end
									end
								end,
								[5]=function(eid)
									say("С����С�����þ�����",eid);
									say("��λү��С��ҵײ��㣬�Ѿ�û���ˡ�",164);
									say("����С������������ûǮ�����þ�������Ȼ���Ҳ��������Ƶ꣡",eid);
									local menu=	{
													{"�Ӷ�����",1},
													{"��ǰ��ֹ",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("���²��ؼ����һ��ǲ�Ҫ���һ���ˡ���");
										say("�����������Ǻ����ǵġ�");
										say("�⡭���ðɣ��ȡ�",pid);
									else
										say("ס�֣��۸�һ����С������ʲôӢ�ۣ�");
										say("����˭���;�����ô��",eid);
										say("�Ǹ����Ѿ����ģ�");
										if CommonFight(eid) then
										
										else
										
										end
										say("ZZZ����",eid);
										DrawStrBoxWaitKey(JY.Person[eid]["����"].."��Ȼ���ڵ�");
										say("�⡭������������������֮�ְ�");
										say("�Ǻǡ�",pid);
										AddPersonAttrib(pid,"�Ѻ�",2);
									end
								end,
							},
					[1]=	{
								[0]=function()
									say("�ף�"..name2.."�֣�Ϊ���ڴ������������������ˣ�");
									say("����"..name1.."�֡�˵������"..name1.."��Ц����ĳ�������ߣ��������̲��þ������ˮ��Ǯ����ʱ����֪������Ǻð������ˣ�"..name1.."�֣���֪�ɷ񡭡�",pid);
									local money=JY.Person[0]["�ȼ�"]*2+JY.Person[pid]["�ȼ�"]*2+20+Rnd(20)-Rnd(20);
									if instruct_31(money) and DrawStrBoxYesNo(-1,-1,string.format("�Ƿ�֧����ˮǮ%d����",money)) then
										instruct_32(CC.ModifyD,-money);
										say("�Ǻǣ����߽�����˭�������д�ʱ�̣�"..name2.."���𼱣���Ƶ�������"..name2.."�ֱ��ǡ�");
										say("��л"..name1.."�֡�",pid);
										AddPersonAttrib(pid,"�Ѻ�",10);
									else
										say("ʵ�ڱ�Ǹ��������������������ɬ����������������ˡ�");
										say("������ˣ�ĳ������������",pid);
									end
								end,
								[1]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("��Ǹ�����»�Ҫ��·��",pid);
								end,
								[2]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("Ŷ����֪�˼��к����ƣ�����ĳ����һ����",pid);
									AddPersonAttrib(pid,"�Ѻ�",5);
								end,
								[3]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("����ͬ����ĳʳ֮��ζ���Ɑ�ƣ����ǵȵ�������֮��ĳ�ٺȰɣ�",pid);
									if CommonFight(pid) then
										say("������������Ǿ��Ʋ��Ⱥȷ����ˣ�");
									else
										say("����֮�ܣ����ձر���");
									end
									AddPersonAttrib(pid,"�Ѻ�",-5);
								end,
								[4]=function(r)
									if r==1 then
										if true then
											say("ĳ�α����£��ټ�"..name1.."�ִ˵ȸ���֮�ˣ�����ĳ����һ����",pid);
											AddPersonAttrib(pid,"�Ѻ�",2);
										else
											say("�ߣ�"..name1.."���˴���֮�ˣ�ĳ�ɲ��Ҹ��ʰ���",pid);
										end
									elseif r==2 then
										if true then
											say(name1.."�֣������Ϊ����Щ���˰ɣ�",pid);
											AddPersonAttrib(pid,"�Ѻ�",-2);
										else
											say("�ã�ĳ�α����£��������Щ���ʼ���ļһ��ˣ�"..name1.."�֣����ǽ��źȾơ�",pid);
										end
									end
								end,
								[5]=function(eid)
									say("С����С�����þ�����",eid);
									say("��λү��С��ҵײ��㣬�Ѿ�û���ˡ�",164);
									say("����Ǿ���ĳûǮ���ˣ�ĳ�����㣬���þ�������Ȼ������ĳ���������Ƶ꣡",eid);
									local menu=	{
													{"�Ӷ�����",1},
													{"��ǰ��ֹ",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("���²��ؼ����һ��ǲ�Ҫ���һ���ˡ���");
										say("�����������Ǻ����ǵġ�");
										say("�⡭���ðɣ��ȡ�",pid);
									else
										say("ס�֣��۸�һ����С������ʲôӢ�ۣ�");
										say("����˭����ĳ�;�����ô��",eid);
										say("�Ǹ����Ѿ����ģ�");
										if CommonFight(eid) then
										
										else
										
										end
										say("ZZZ����",eid);
										DrawStrBoxWaitKey(JY.Person[eid]["����"].."��Ȼ���ڵ�");
										say("�⡭������������������֮�ְ�");
										say("�Ǻǡ�",pid);
										AddPersonAttrib(pid,"�Ѻ�",2);
									end
								end,
							},
					[2]=	{
								[0]=function()
									say("�ף�"..name2.."�֣�Ϊ���ڴ������������������ˣ�");
									say("����˵����������Ц����үү�������Ǵ����ӣ����Ǯ��û�취���ˣ����������Խ��ء����ˣ���֪���ǲ��ǡ���",pid);
									local money=JY.Person[0]["�ȼ�"]+JY.Person[pid]["�ȼ�"]*2+100+Rnd(20)-Rnd(20);
									if instruct_31(money) and DrawStrBoxYesNo(-1,-1,string.format("�Ƿ�֧����ˮǮ%d����",money)) then
										instruct_32(CC.ModifyD,-money);
										say("�Ǻǣ����߽�����˭�������д�ʱ�̣�"..name2.."���𼱣���Ƶ�������"..name2.."�ֱ��ǡ�");
										say("�ã���С�ӹ����壡",pid);
										AddPersonAttrib(pid,"�Ѻ�",10);
									else
										say("ʵ�ڱ�Ǹ��������������������ɬ����������������ˡ�");
										say("���̵ģ�ûǮ��������үү��ɶ��",pid);
									end
								end,
								[1]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("ͻ��С��,����үү�Ⱦƣ�үүΪɶҪ��Ӧ�㣿",pid);
								end,
								[2]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("ֻ��һ̳������ô���أ�С���������������еľƶ���үү��������",pid);
									AddPersonAttrib(pid,"�Ѻ�",5);
								end,
								[3]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�ޣ���ƾ��Ҳ���үү�Ⱦƣ���",pid);
									if CommonFight(pid) then
										say("������������Ǿ��Ʋ��Ⱥȷ����ˣ�");
									else
										say("����֮�ܣ����ձر���");
									end
									AddPersonAttrib(pid,"�Ѻ�",-5);
								end,
								[4]=function(r)
									if r==1 then
										if true then
											say("�����̵ģ���С���Ǹ����ˣ�үү���㡣",pid);
											AddPersonAttrib(pid,"�Ѻ�",2);
										else
											say("�����̵ģ�үү�ɿ�������С���⸱��ס�",pid);
										end
									elseif r==2 then
										if true then
											say("�����̵ģ��۸�ЩС�ϰ��գ���ʲôӢ�ۣ�",pid);
											AddPersonAttrib(pid,"�Ѻ�",-2);
										else
											say("�����̵ģ�С���������үүθ�ڣ������Ⱦƣ�",pid);
										end
									end
								end,
								[5]=function(eid)
									say("�����̵ģ�С����С�������үү�þ�����",eid);
									say("��λү��С��ҵײ��㣬�Ѿ�û���ˡ�",164);
									say("����С����үү�����㣬үү�е���Ǯ�����þ�������Ȼ��үү�Ҳ��������Ƶ꣡�����̵ģ�",eid);
									local menu=	{
													{"�Ӷ�����",1},
													{"��ǰ��ֹ",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("���²��ؼ����һ��ǲ�Ҫ���һ���ˡ���");
										say("�����������Ǻ����ǵġ�");
										say("�⡭���ðɣ��ȡ�",pid);
									else
										say("ס�֣��۸�һ����С������ʲôӢ�ۣ�");
										say("�����̵ģ�����ʲô��������үү�;�����ô��",eid);
										say("�Ǹ����Ѿ����ģ�");
										if CommonFight(eid) then
										
										else
										
										end
										say("ZZZ����",eid);
										DrawStrBoxWaitKey(JY.Person[eid]["����"].."��Ȼ���ڵ�");
										say("�⡭������������������֮�ְ�");
										say("�Ǻǡ�",pid);
										AddPersonAttrib(pid,"�Ѻ�",2);
									end
								end,
							},
					[3]=	{
								[0]=function()
									say("�ף�"..name2.."�֣�Ϊ���ڴ������������������ˣ�");
									say("����һʱ���飬��Ǯ���ˡ�",pid);
									local money=JY.Person[0]["�ȼ�"]*2+JY.Person[pid]["�ȼ�"]+50+Rnd(20)-Rnd(20);
									if instruct_31(money) and DrawStrBoxYesNo(-1,-1,string.format("�Ƿ�֧����ˮǮ%d����",money)) then
										instruct_32(CC.ModifyD,-money);
										say("�Ǻǣ����߽�����˭�������д�ʱ�̣�"..name2.."���𼱣���Ƶ�������"..name2.."�ֱ��ǡ�");
										say("�������顣",pid);
										AddPersonAttrib(pid,"�Ѻ�",10);
									else
										say("ʵ�ڱ�Ǹ��������������������ɬ����������������ˡ�");
										say("�����š�",pid);
									end
								end,
								[1]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�������ء�",pid);
								end,
								[2]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("���������顣",pid);
									AddPersonAttrib(pid,"�Ѻ�",5);
								end,
								[3]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�����ߣ�",pid);
									if CommonFight(pid) then
										say("������������Ǿ��Ʋ��Ⱥȷ����ˣ�");
									else
										say("����֮�ܣ����ձر���");
									end
									AddPersonAttrib(pid,"�Ѻ�",-5);
								end,
								[4]=function(r)
									if r==1 then
										if true then
											say("�������㡣",pid);
											AddPersonAttrib(pid,"�Ѻ�",2);
										else
											say("����",pid);
										end
									elseif r==2 then
										if true then
											say("����",pid);
											AddPersonAttrib(pid,"�Ѻ�",-2);
										else
											say("�����Ⱦơ�",pid);
										end
									end
								end,
								[5]=function(eid)
									say("�����ƣ�",eid);
									say("��λү��С��ҵײ��㣬�Ѿ�û���ˡ�",164);
									say("����������",eid);
									local menu=	{
													{"�Ӷ�����",1},
													{"��ǰ��ֹ",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("���²��ؼ����һ��ǲ�Ҫ���һ���ˡ���");
										say("�����������Ǻ����ǵġ�");
										say("�⡭���ðɣ��ȡ�",pid);
									else
										say("ס�֣��۸�һ����С������ʲôӢ�ۣ�");
										say("���������ˣ�",eid);
										say("�Ѿ����ˣ�");
										if CommonFight(eid) then
										
										else
										
										end
										say("ZZZ����",eid);
										DrawStrBoxWaitKey(JY.Person[eid]["����"].."��Ȼ���ڵ�");
										say("�⡭������������������֮�ְ�");
										say("�Ǻǡ�",pid);
										AddPersonAttrib(pid,"�Ѻ�",2);
									end
								end,
							},
					[4]=	{
								[0]=function()
									say("�ף�"..name2.."�֣�Ϊ���ڴ������������������ˣ�");
									say("����"..name1.."�֡�˵������"..name1.."��Ц�������½��վƳ����֣�û�뵽��������ȴ���㸶���ˮ��Ǯ����ʱ����֪������Ǻð������ˣ�"..name1.."�֣���֪�ɷ񡭡�",pid);
									local money=JY.Person[0]["�ȼ�"]*3+JY.Person[pid]["�ȼ�"]*3+20+Rnd(20)-Rnd(20);
									if instruct_31(money) and DrawStrBoxYesNo(-1,-1,string.format("�Ƿ�֧����ˮǮ%d����",money)) then
										instruct_32(CC.ModifyD,-money);
										say("�Ǻǣ����߽�����˭�������д�ʱ�̣�"..name2.."���𼱣���Ƶ�������"..name2.."�ֱ��ǡ�");
										say("�ã����ն������"..name1.."�֣�",pid);
										AddPersonAttrib(pid,"�Ѻ�",10);
									else
										say("ʵ�ڱ�Ǹ��������������������ɬ����������������ˡ�");
										say("�����ˡ����������������ǡ�",pid);
									end
								end,
								[1]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("��̨���⣬���������ˡ����л��ᣬ�´ζ���������",pid);
								end,
								[2]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�ã�����ͬ�����գ����գ�",pid);
									AddPersonAttrib(pid,"�Ѻ�",5);
								end,
								[3]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�����ˣ��������¼����°ɣ�",pid);
									if CommonFight(pid) then
										say("������������Ǿ��Ʋ��Ⱥȷ����ˣ�");
									else
										say("����֮�ܣ����ձر���");
									end
									AddPersonAttrib(pid,"�Ѻ�",-5);
								end,
								[4]=function(r)
									if r==1 then
										if true then
											say(name1.."�ָ��壬���¾���һ�����ȸ�Ϊ����",pid);
											AddPersonAttrib(pid,"�Ѻ�",2);
										else
											say(name1.."�֣����ɷ򵱿��������ȷ��ˣ�����������������",pid);
										end
									elseif r==2 then
										if true then
											say(name1.."�֣�������˰ɡ�",pid);
											AddPersonAttrib(pid,"�Ѻ�",-2);
										else
											say("������𣬵����ұ�������Ϊ���������������Ⱦƣ�",pid);
										end
									end
								end,
								[5]=function(eid)
									say("С����С�������þ�����",eid);
									say("��λү��С��ҵײ��㣬�Ѿ�û���ˡ�",164);
									say("����С������������ûǮ�����ģ����������Ǯ�ġ���ȥ�þ�������Ȼ������Ҳ�������",eid);
									local menu=	{
													{"�Ӷ�����",1},
													{"��ǰ��ֹ",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("���²��ؼ����һ��ǲ�Ҫ���һ���ˡ���");
										say("�����������Ǻ����ǵġ�");
										say("�⡭���ðɣ��ȡ�",pid);
									else
										say("ס�֣��۸�һ����С������ʲôӢ�ۣ�");
										say("����˭�������;����ģ�",eid);
										say("�Ǹ����Ѿ����ģ�");
										if CommonFight(eid) then
										
										else
										
										end
										say("ZZZ����",eid);
										DrawStrBoxWaitKey(JY.Person[eid]["����"].."��Ȼ���ڵ�");
										say("�⡭������������������֮�ְ�");
										say("�Ǻǡ�",pid);
										AddPersonAttrib(pid,"�Ѻ�",2);
									end
								end,
							},
					[5]=	{
								[0]=function()
									say("�ף�"..name2.."�֣�Ϊ���ڴ������������������ˣ�");
									say("����"..name1.."�֡�˵�����������½���һʱ����ȴ�����ϵ��������㣬���ˮ��Ǯ����ʱ����֪������Ǻð���",pid);
									local money=JY.Person[0]["�ȼ�"]+JY.Person[pid]["�ȼ�"]+40+Rnd(20)-Rnd(20);
									if instruct_31(money) and DrawStrBoxYesNo(-1,-1,string.format("�Ƿ�֧����ˮǮ%d����",money)) then
										instruct_32(CC.ModifyD,-money);
										say("�Ǻǣ����߽�����˭�������д�ʱ�̣�"..name2.."���𼱣���Ƶ�������"..name2.."�ֱ��ǡ�");
										say("��л"..name1.."�֣��պ�ص��سꡣ",pid);
										AddPersonAttrib(pid,"�Ѻ�",10);
									else
										say("ʵ�ڱ�Ǹ��������������������ɬ����������������ˡ�");
										say("�޷�������������һ��Ǯ�ѵ�Ӣ�ۺ�������",pid);
									end
								end,
								[1]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("��л���º񰮡�ֻ������ν�޹�����»���Ɑ�ƣ����¾Ͳ����ˡ�",pid);
								end,
								[2]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say(""..name1.."��������������Ҳ��ӣ��Ե���������Ӷ���",pid);
									AddPersonAttrib(pid,"�Ѻ�",5);
								end,
								[3]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("����֮��ȴ���м���֮�ƣ����²�м��֮��",pid);
									if CommonFight(pid) then
										say("������������Ǿ��Ʋ��Ⱥȷ����ˣ�");
									else
										say("����֮�ܣ����ձر���");
									end
									AddPersonAttrib(pid,"�Ѻ�",-5);
								end,
								[4]=function(r)
									if r==1 then
										if true then
											say("����Ϊ�����٣�ֻ������һ�ǣ�������յü�"..name1.."�ָ��壬���������",pid);
											AddPersonAttrib(pid,"�Ѻ�",2);
										else
											say(name1.."����˸��壬���¶�����д�����飬�������˴��̡�",pid);
										end
									elseif r==2 then
										if true then
											say(name1.."�֣�ʥ�����Ƽ������ף��˾٣���̫�׵��ɡ�",pid);
											AddPersonAttrib(pid,"�Ѻ�",-2);
										else
											say("�ã�"..name1.."�ֿ�����������ͷ緶�����¾���һ����",pid);
										end
									end
								end,
								[5]=function(eid)
									say("С����С�����Ͼƣ�",eid);
									say("��λ���ӣ�С��ҵײ��㣬�Ѿ�û���ˡ�",164);
									say("����С���������ӿ�����ûǮ֮��ô���������˵�Ǿ�ʡ�˰ɣ���ȥ�þ�������Ȼ��С�ı�����������ĵ꣡",eid);
									local menu=	{
													{"�Ӷ�����",1},
													{"��ǰ��ֹ",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("���²��ؼ����һ��ǲ�Ҫ���һ���ˡ���");
										say("�����������Ǻ����ǵġ�");
										say("�⡭���ðɣ��ȡ�",pid);
									else
										say("ס�֣��۸�һ����С������ʲôӢ�ۣ�");
										say("����˭�����������;�����ô��",eid);
										say("�Ǹ����Ѿ����ģ�");
										if CommonFight(eid) then
										
										else
										
										end
										say("ZZZ����",eid);
										DrawStrBoxWaitKey(JY.Person[eid]["����"].."��Ȼ���ڵ�");
										say("�⡭������������������֮�ְ�");
										say("�Ǻǡ�",pid);
										AddPersonAttrib(pid,"�Ѻ�",2);
									end
								end,
							},
					[6]=	{
								[0]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�����˲������ơ�",pid);
								end,
								[1]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�����˲������ơ�",pid);
								end,
								[2]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�����˲������ơ�",pid);
								end,
								[3]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�����˲������ơ�",pid);
								end,
								[4]=function()
								end,
								[5]=function(eid)
								end,
							},
					[7]=	{
								[0]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�����˲������ơ�",pid);
								end,
								[1]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�����˲������ơ�",pid);
								end,
								[2]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�����˲������ơ�",pid);
								end,
								[3]=function()
									say("���������δ�����갡��"..name2.."�֣�����֮��������������ϣ����ܲ���һ��ף�");
									say("�����˲������ơ�",pid);
								end,
								[4]=function()
								end,
								[5]=function(eid)
								end,
							},
					[8]=	{
								[0]=function()
									say("�ף�"..name2.."��㣿Ϊ���ڴ������������������ˣ�");
									say("�õܵܣ���������С�������������������վ������˴������������ˮ��Ǯ��ȴ��֪������Ǻð������ˣ��õܵܣ�Ҫ������",pid);
									local money=JY.Person[0]["�ȼ�"]*4+JY.Person[pid]["�ȼ�"]+200+Rnd(20)-Rnd(20);
									if instruct_31(money) and DrawStrBoxYesNo(-1,-1,string.format("�Ƿ�֧����ˮǮ%d����",money)) then
										instruct_32(CC.ModifyD,-money);
										say("�Ǻǣ�"..name2.."��㣬����Ե�����С�����롣");
										say("����~���ǵܵ�֪���۽��~",pid);
										AddPersonAttrib(pid,"�Ѻ�",10);
									else
										say(name2.."��㣬ʵ�ڱ�Ǹ������С������������ɬ����������������ˡ�");
										say("�����������¾���һ��ϧ��������",pid);
									end
								end,
								[1]=function()
									say("���������δ�����갡��"..name2.."��㣬����֮��������������ϣ����ܲ���һ��ף�");
									say("�ܵ����˵��~ֻ�ǽ��������£��´��������氡~",pid);
								end,
								[2]=function()
									say("���������δ�����갡��"..name2.."��㣬����֮��������������ϣ����ܲ���һ��ף�");
									say("�ܵ�������ϲ��~���ľ������ɲ���һ�����ܱȵ�Ŷ~",pid);
									AddPersonAttrib(pid,"�Ѻ�",5);
								end,
								[3]=function()
									say("���������δ�����갡��"..name2.."��㣬����֮��������������ϣ����ܲ���һ��ף�");
									say("�ܵ����˵��~ֻ�ǽ�㲻ʤ������������������İ�~",pid);
									if CommonFight(pid) then
										say("������������Ǿ��Ʋ��Ⱥȷ����ˣ�");
									else
										say("����֮�ܣ����ձر���");
									end
									AddPersonAttrib(pid,"�Ѻ�",-5);
								end,
								[4]=function(r)
									if r==1 then
										if true then
											say("�õܵ�~�������Ŀɲ�С��~����~",pid);
											AddPersonAttrib(pid,"�Ѻ�",2);
										else
											say("�õܵ�~�������Ŀɲ�С��~��ʱ����ʩ��һ��������~",pid);
										end
									elseif r==2 then
										if true then
											say("�õܵ�~�α���˶�ŭ��~��������Ⱦ�~",pid);
											AddPersonAttrib(pid,"�Ѻ�",-2);
										else
											say("�õܵ�~����Խ��θ��~",pid);
										end
									end
								end,
								[5]=function(eid)
									say("����~С����~���Ͼư�~",eid);
									say("��λ��㣬С��ҵײ��㣬�Ѿ�û���ˡ�",164);
									say("����~�����㿪��Ц��~���û�оƺȣ����ǻᷢƢ����Ŷ~",eid);
									local menu=	{
													{"�Ӷ�����",1},
													{"��ǰ��ֹ",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("���²��ؼ����һ��ǲ�Ҫ���һ���ˡ���");
										say("�����������Ǻ����ǵġ�");
										say("�⡭���ðɣ��ȡ�",pid);
									else
										say("ס�֣��۸�һ����С������ʲôӢ�ۣ�");
										say("����~��������ȾƵ�ô~",eid);
										say("�Ǹ����Ѿ����ģ�");
										if CommonFight(eid) then
										
										else
										
										end
										say("ZZZ����",eid);
										DrawStrBoxWaitKey(JY.Person[eid]["����"].."��Ȼ���ڵ�");
										say("�⡭������������������֮�ְ�");
										say("�Ǻǡ�",pid);
										AddPersonAttrib(pid,"�Ѻ�",2);
									end
								end,
							},
					[9]=	{
								[0]=function()
									say("�ף�"..name2.."���Ϊ���ڴ������������������ˣ�");
									say("����"..name1.."���ӡ����ˣ����ӣ�СŮ��³ç�����������ݽ�СŮ�Ӽ�Ǯ������������Ǯ���պ�ؼӱ����",pid);
									local money=JY.Person[pid]["�ȼ�"]+50+Rnd(20)-Rnd(20);
									if instruct_31(money) and DrawStrBoxYesNo(-1,-1,string.format("�Ƿ�֧����ˮǮ%d����",money)) then
										instruct_32(CC.ModifyD,-money);
										say("�Ǻǣ����������Ե��������Ϊ���︶��֮�˺���࣬�������ҵô�������������Ī���ỹǮ֮�¡�");
										say("����˵Ц�ˣ���л�������塣",pid);
										AddPersonAttrib(pid,"�Ѻ�",10);
									else
										say(name2.."���ʵ�ڱ�Ǹ��������������������ɬ��������������㣬����ˡ�");
										say("���������ˡ�������",pid);
									end
								end,
								[1]=function()
									say("���������δ�����갡��"..name2.."�������֮��������������ϣ����ܲ���һ��ף�");
									say("����������СŮ�ӱ����ò��ӡ�ֻ��СŮ�����м��£��������Ӽ��¡�",pid);
								end,
								[2]=function()
									say("���������δ�����갡��"..name2.."�������֮��������������ϣ����ܲ���һ��ף�");
									say("����������СŮ�Ӳ��Ҳ��ӡ�",pid);
									AddPersonAttrib(pid,"�Ѻ�",5);
								end,
								[3]=function()
									say("���������δ�����갡��"..name2.."�������֮��������������ϣ����ܲ���һ��ף�");
									say("���ӵ��Գ���ݣ��˵�ͽ���о�ʵ������̫����",pid);
									if CommonFight(pid) then
										say("������������Ǿ��Ʋ��Ⱥȷ����ˣ�");
									else
										say("����֮�ܣ����ձر���");
									end
									AddPersonAttrib(pid,"�Ѻ�",-5);
								end,
								[4]=function(r)
									if r==1 then
										if true then
											say("���Ӹ��壬СŮ����������",pid);
											AddPersonAttrib(pid,"�Ѻ�",2);
										else
											say("���Ӵ���֮�⣬��СŮ���Բ��λࡣ",pid);
										end
									elseif r==2 then
										if true then
											say("���ӵ��Գ���ݣ�������ˡ�",pid);
											AddPersonAttrib(pid,"�Ѻ�",-2);
										else
											say("�����������ͣ�СŮ�Ӿ����ӡ�",pid);
										end
									end
								end,
								[5]=function(eid)
									say("С���磬������һ���ƣ�",eid);
									say("��λС�㣬С��ҵײ��㣬�Ѿ�û���ˡ�",164);
									say("С���磬���ģ�СŮ�ӻ������мҵף�����ֻ����������С������Ҫ���������������Ҷ��á�",eid);
									local menu=	{
													{"�Ӷ�����",1},
													{"��ǰ��ֹ",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("���²��ؼ����һ��ǲ�Ҫ���һ���ˡ���");
										say("�����������Ǻ����ǵġ�");
										say("�⡭���ðɣ��ȡ�",pid);
									else
										say("ס�֣��۸�һ����С������ʲôӢ�ۣ�");
										say("���ӿ����;����ģ�",eid);
										say("�Ǹ����Ѿ����ģ�");
										if CommonFight(eid) then
										
										else
										
										end
										say("ZZZ����",eid);
										DrawStrBoxWaitKey(JY.Person[eid]["����"].."��Ȼ���ڵ�");
										say("�⡭������������������֮�ְ�");
										say("�Ǻǡ�",pid);
										AddPersonAttrib(pid,"�Ѻ�",2);
									end
								end,
							},
					[10]=	{
								[0]=function()
									say("�ף�"..name2.."Ů����Ϊ���ڴ������������������ˣ�");
									say(name1.."�֣�˵����������������������̲����ֲ���������֮�ƣ��治֪����Ǻá����ˣ�"..name1.."���Ƿ���ԡ���",pid);
									local money=JY.Person[0]["�ȼ�"]+JY.Person[pid]["�ȼ�"]+60+Rnd(20)-Rnd(20);
									if instruct_31(money) and DrawStrBoxYesNo(-1,-1,string.format("�Ƿ�֧����ˮǮ%d����",money)) then
										instruct_32(CC.ModifyD,-money);
										say("�Ǻǣ����߽�����˭�������д�ʱ�̣�"..name2.."Ů���𼱣����Ǯ���»��Ǹ�����ġ�");
										say("��л"..name1.."�ֽ���ȼü֮����",pid);
										AddPersonAttrib(pid,"�Ѻ�",10);
									else
										say(name2.."Ů����ʵ�ڱ�Ǹ��������������������ɬ��������������㣬����ˡ�");
										say("���˰��ˣ��㲻Ը���Ҳ���ˣ�������������",pid);
									end
								end,
								[1]=function()
									say("���������δ�����갡��"..name2.."Ů��������֮��������������ϣ����ܲ���һ��ף�");
									say("�����ˡ������ﻹ��Ҫ����������߶�š������ˡ�",pid);
								end,
								[2]=function()
									say("���������δ�����갡��"..name2.."Ů��������֮��������������ϣ����ܲ���һ��ף�");
									say("Ŷ������Ǿ��ñ�����������У�ֻ������һ�ס���",pid);
									AddPersonAttrib(pid,"�Ѻ�",5);
								end,
								[3]=function()
									say("���������δ�����갡��"..name2.."Ů��������֮��������������ϣ����ܲ���һ��ף�");
									say("�ߣ���ȷ�������δ�����갡��̤�Ƶ�Ь���ٴ�����Ⱦƣ�ȥ������ү�Ȱɣ�",pid);
									if CommonFight(pid) then
										say("������������Ǿ��Ʋ��Ⱥȷ����ˣ�");
									else
										say("����֮�ܣ����ձر���");
									end
									AddPersonAttrib(pid,"�Ѻ�",-5);
								end,
								[4]=function(r)
									if r==1 then
										if true then
											say("�ã�"..name1.."�ִ˾٣����������������������㡣",pid);
											AddPersonAttrib(pid,"�Ѻ�",2);
										else
											say(name1.."���Ծ��䲻����ֻ�����������Ӷ��䡣",pid);
										end
									elseif r==2 then
										if true then
											say(name1.."���Ծ�δ��̫�����ˡ�",pid);
											AddPersonAttrib(pid,"�Ѻ�",-2);
										else
											say("����������������������"..name1.."�֣������ﾴ��һ����",pid);
										end
									end
								end,
								[5]=function(eid)
									say("С����С�����þ�����",eid);
									say("��λŮ����С��ҵײ��㣬�Ѿ�û���ˡ�",164);
									say("����С���������±�����ûǮ�������㣬����������þ�������Ȼ�������ﶨ�������Ƶ꿪����ȥ��",eid);
									local menu=	{
													{"�Ӷ�����",1},
													{"��ǰ��ֹ",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("���²��ؼ����һ��ǲ�Ҫ���һ���ˡ���");
										say("�����������Ǻ����ǵġ�");
										say("�⡭���ðɣ��ȡ�",pid);
									else
										say("ס�֣��۸�һ����С������ʲôӢ�ۣ�");
										say("����˭�����������;����ģ�",eid);
										say("�Ǹ����Ѿ����ģ�");
										if CommonFight(eid) then
										
										else
										
										end
										say("ZZZ����",eid);
										DrawStrBoxWaitKey(JY.Person[eid]["����"].."��Ȼ���ڵ�");
										say("�⡭������������������֮�ְ�");
										say("�Ǻǡ�",pid);
										AddPersonAttrib(pid,"�Ѻ�",2);
									end
								end,
							},
				};
	xg=JY.Person[pid]["����"];
	if mp1<0 then
		if mp2<0 then
			mp=1;
		else
			mp=0;
		end
	else
		if mp2<0 then
			mp=2;
		else
			if mp1==mp2 then
				mp=3;
			elseif true then
				mp=4;
			elseif true then
				mp=5;
			end
		end
	end
	if xg==6 or xg==7 then
		msg[xg][0]();
	elseif Rnd(5)==1 then
		msg[xg][0]();
	else
		local n=JY.Person[pid]["�Ѻ�"]+Rnd(100);
		if n<10 then
			msg[xg][3]();
		elseif n<50 then
			msg[xg][1]();
		else
			msg[xg][2]();
			Dark();
			if Rnd(5)>=1 then
				DrawStrBoxWaitKey("�ƺ�����֮��",C_WHITE,CC.Fontbig,1);
				Light();
				say("���ĵĴ�ү�����������һ�ھƺȰɡ�",163);
				local menu={{"������Ȱ",nil,1},{"��������",nil,1},};
				local r=EasyMenu(menu);
				if r==1 then
					say("��λ���壬���Ѿ����ˣ��ٺ�����������Щ�ؼ�ЪϢ�������ٺȰɡ�");
					say("��λү�����¹�������������ˣ���һ��û�������ͻ��Լ���ȥ�ˡ�",164);
					say("�������̫ƽ��С��������������ؼң������ҳ���");
					say("���ϣ���λү���������Ǻ��˰���",164);
				elseif r==2 then
					say("������������������������Сү�ȾƵ����£�Сү�����㣡");
					say("��λ��ү��������������������ˣ���һ��û�������ͻ��Լ���ȥ�ˡ�",164);
					say("С��������˰���Ū�ߡ���ȻСү�Ҳ��������Ƶꡣ");
					say("�����ǣ�С����ͽ��ˣ���ͽ��ˡ�",164);
				end
				msg[xg][4](r);
			else
				DrawStrBoxWaitKey("���˾�����ɢ",C_WHITE,CC.Fontbig,1);
				--Light();
			end
		end
	end
end
function CommonFight_Shell(pid)
	
	local msg=	{
					[0]=	{
								[0]=function()
									say("��λ��̨������ɫ���ƣ��������º�ʱ����ð����",pid);
								end,
								[1]=function()
									say("�����������ˣ������ķ��ڷ���ֻ�ǲ�֪��̨Ϊ�Ρ���",pid);
									say("���������㲻˳����");
									say("������л��󣬸�ǣ�",pid);
								end,
								[2]=function()
									say("��̨�������ˣ����������д�ֱ�Ա�ɡ�",pid);
									say("�������ˣ��޻���˵��");
									say("�⡭��",pid);
								end,
								[3]=function()
									say("��̨����ˣ���ֻ���뵽����֮�£�һʱ��Щ�鲻�Խ����ѡ�");
									say("ԭ����ˣ�������Σ�",pid);
									say("������û���ˣ���л����л����");
								end,
							},
					[1]=	{
								[0]=function()
									say("��λ�ֵܣ���Ŀ¶�׹⣬����ĳ������ʲô��",pid);
								end,
								[1]=function()
									say("�����������ˣ�ĳ�޻���˵������������Ҫĳ����Ҳ����ĳ�������ס�",pid);
									say("���������㲻˳����");
									say("������л��棬������ڣ�",pid);
								end,
								[2]=function()
									say("��̨Ϊ����ˣ�����ĳ�д����ֱ˵��",pid);
									say("�������ˣ��޻���˵��");
									say("�⡭��",pid);
								end,
								[3]=function()
									say("��̨����ˣ���ֻ���뵽����֮�£�һʱ��Щ�鲻�Խ����ѡ�");
									say("ԭ����ˣ�����ĳ�Ĵ���",pid);
									say("ˡ�ˡ���");
								end,
							},
					[2]=	{
								[0]=function()
									say("ͻ��С�ӣ�����ɶ��ݺݵĶ���үү��үү�ɲ��ǵ����ǹ��㡣",pid);
								end,
								[1]=function()
									say("����үү�򲻹��㣬�����ˣ���ٴ򰤵�Ī������ġ���",pid);
									say("���������㲻˳����");
									say("������С�ӣ��´�үүһ��Ҫ����һ�٣�",pid);
								end,
								[2]=function()
									say("ͻ��С�ӣ�үү�ֲ�����ɱ�����ˣ�����ɶ��ôƴ����",pid);
									say("�������ˣ��޻���˵��");
									say("��үү�����Ϳ�ˡ���",pid);
								end,
								[3]=function()
									say("��̨����ˣ���ֻ���뵽����֮�£�һʱ��Щ�鲻�Խ����ѡ�");
									say("��˵���С�ӣ������˵ġ�",pid);
									say("������˼��������˼����");
								end,
							},
					[3]=	{
								[0]=function()
									say("����ɱ������Ϊ�Σ�",pid);
								end,
								[1]=function()
									say("�����������ˣ����ˡ�����Ϊ�Ρ���",pid);
									say("���������㲻˳����");
									say("������л����ǣ�",pid);
								end,
								[2]=function()
									say("����Ϊ����ˣ�",pid);
									say("�������ˣ��޻���˵��");
									say("����",pid);
								end,
								[3]=function()
									say("��̨����ˣ���ֻ���뵽����֮�£�һʱ��Щ�鲻�Խ����ѡ�");
									say("�����š�",pid);
									say("��Ǹ����Ǹ����");
								end,
							},
					[4]=	{
								[0]=function()
									say("��λ��̨���������ɷ������������Թ��",pid);
								end,
								[1]=function()
									say("������̨�书��ǿ�����������ֻ���������ʲ����кζԲ�����̨֮�£���֪��̨���ǡ���",pid);
									say("���������㲻˳����");
									say("����ԭ����ˣ���л��֮����ǣ�",pid);
								end,
								[2]=function()
									say("��̨Ϊ����ˣ����������кζԲ���֮�������ֱ�ԣ����¶������",pid);
									say("�������ˣ��޻���˵��");
									say("�⡭��",pid);
								end,
								[3]=function()
									say("��̨����ˣ���ֻ���뵽����֮�£�һʱ��Щ�鲻�Խ����ѡ�");
									say("ԭ����ˣ���֪��̨�����к��Ѵ�������˵������˵�������»�������̨һ��֮����",pid);
									say("ûʲô��ûʲô����");
								end,
							},
					[5]=	{
								[0]=function()
									say("��λ��̨����֪���¿����кβ���֮�٣��ǵ���̨���ã�",pid);
								end,
								[1]=function()
									say("������̨���ֲ������������������ֻ����һ�²�����������̨���Ϊ����̨�����¡���",pid);
									say("���������㲻˳����");
									say("������̨��Ȼ����ֱˬ��������ˣ����¸�ǣ�",pid);
								end,
								[2]=function()
									say("��̨���ֲ���������һʱ���ң�ֻ����һ�²�����������̨���Ϊ����̨�����¡���",pid);
									say("�������ˣ��޻���˵��");
									say("�⡭��",pid);
								end,
								[3]=function()
									say("��������ˣ���ֻ���뵽����֮�£�һʱ��Щ�鲻�Խ����ѡ�");
									say("ԭ����ˣ�����������ͻ�ˡ�",pid);
									say("���ң����ҡ���");
								end,
							},
					[6]=	{
								[0]=function()
									say("��λ��̨������ɫ���ƣ��������º�ʱ����ð����",pid);
								end,
								[1]=function()
									say("�����������ˣ������ķ��ڷ���ֻ�ǲ�֪��̨Ϊ�Ρ���",pid);
									say("���������㲻˳����");
									say("������л��󣬸�ǣ�",pid);
								end,
								[2]=function()
									say("��̨�������ˣ����������д�ֱ�Ա�ɡ�",pid);
									say("�������ˣ��޻���˵��");
									say("�⡭��",pid);
								end,
								[3]=function()
									say("��̨����ˣ���ֻ���뵽����֮�£�һʱ��Щ�鲻�Խ����ѡ�");
									say("ԭ����ˣ�������Σ�",pid);
									say("������û���ˣ���л����л����");
								end,
							},
					[7]=	{
								[0]=function()
									say("��λ��̨������ɫ���ƣ��������º�ʱ����ð����",pid);
								end,
								[1]=function()
									say("�����������ˣ������ķ��ڷ���ֻ�ǲ�֪��̨Ϊ�Ρ���",pid);
									say("���������㲻˳����");
									say("������л��󣬸�ǣ�",pid);
								end,
								[2]=function()
									say("��̨�������ˣ����������д�ֱ�Ա�ɡ�",pid);
									say("�������ˣ��޻���˵��");
									say("�⡭��",pid);
								end,
								[3]=function()
									say("��̨����ˣ���ֻ���뵽����֮�£�һʱ��Щ�鲻�Խ����ѡ�");
									say("ԭ����ˣ�������Σ�",pid);
									say("������û���ˣ���л����л����");
								end,
							},
					[8]=	{
								[0]=function()
									say("�õܵ�~����ô���Ž��~����ͽ����ô~",pid);
								end,
								[1]=function()
									say("�õܵ�~�������~��֪�ܵ�Ϊɶ�����Ͻ����~",pid);
									say("���������㲻˳����");
									say("���������´������ҽ��������~",pid);
								end,
								[2]=function()
									say("�õܵ�~����ô~",pid);
									say("�������ˣ��޻���˵��");
									say("����~",pid);
								end,
								[3]=function()
									say("�������ˣ�С��ֻ���뵽������֮�£�һʱ��Щ�鲻�Խ����ѡ�");
									say("������~���´μǵ��ҽ���氡~",pid);
									say("һ����һ������");
								end,
							},
					[9]=	{
								[0]=function()
									say("��λ���ӣ�СŮ�ӿ����кι����ڴ����������ˡ�",pid);
								end,
								[1]=function()
									say("���������书��ǿ��СŮ���������硣ֻ�ǻ���������ʾ��СŮ���кι���",pid);
									say("���������㲻˳����");
									say("����ԭ����ˣ���л���Ӹ�֮��СŮ�Ӹ��ˣ�",pid);
								end,
								[2]=function()
									say("���ӣ���֪СŮ�Ӿ����кδ��������������ʾ��",pid);
									say("�������ˣ��޻���˵��");
									say("�⡭��",pid);
								end,
								[3]=function()
									say("��������ˣ�����ֻ���뵽����֮�£�һʱ��Щ�鲻�Խ����ѡ�");
									say("ԭ����ˣ��������ӱ��ء�",pid);
									say("�����ˣ������ˡ���");
								end,
							},
					[10]=	{
								[0]=function()
									say("��λ��̨����������������ǹ��㣿",pid);
								end,
								[1]=function()
									say("�����㹦��������������򲻹��㡣�������ܸø��߱����������Ϊʲô����İɡ���",pid);
									say("���������㲻˳����");
									say("���������ˣ���ǣ��ߣ�",pid);
								end,
								[2]=function()
									say("��򲻹�������ģ�������ΪɶҪ���������",pid);
									say("�������ˣ��޻���˵��");
									say("�⡭��",pid);
								end,
								[3]=function()
									say("Ů������ˣ���ֻ���뵽����֮�£�һʱ��Щ�鲻�Խ����ѡ�");
									say("ԭ����ˣ������к��Ѵ�����Ҫ��������㲻��",pid);
									say("��л̧���������ͷ�Ů�������¿������д���");
								end,
							},
				}
	local xg=JY.Person[pid]["����"];
	msg[xg][0]();
	if DrawStrBoxYesNo(-1,-1,"�Ƿ�ȷ��ҪϮ��"..JY.Person[pid]["����"]) then
		say("���طϻ�������");
		if CommonFight(pid) then
			JY.Person[pid]["�Ѻ�"]=-1;
			local skip=false;
			for ci,cv in pairs(PE.fight) do
				if cv.trigger(true)==1 then
					cv.go(true);
					skip=true;
					break;
				end
			end
			if not skip then
				msg[xg][1]();
			end
		else
			AddPersonAttrib(pid,"�Ѻ�",-30);
			local skip=false;
			for ci,cv in pairs(PE.fight) do
				if cv.trigger(false)==1 then
					cv.go(false);
					skip=true;
					break;
				end
			end
			if not skip then
				msg[xg][2]();
			end
		end
	else
		msg[xg][3]();
	end
end
function CommonFight(pid)
	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	WAR={};
	WAR.Data={};
	WAR.Data["����"]=0;
	WAR.Data["����"]="ս��";
	WAR.Data["��ͼ"]=JY.SubScene;
	if JY.Person[pid]["�ȼ�"]<16 then
		WAR.Data["����"]=307;
	elseif JY.Person[pid]["�ȼ�"]<31 then
		WAR.Data["����"]=305;
	elseif JY.Person[pid]["�ȼ�"]<46 then
		WAR.Data["����"]=304;
	elseif JY.Person[pid]["�ȼ�"]<51 then
		WAR.Data["����"]=303;
	end
	WAR.Data["����"]=50--EXP;
	
	WAR.Data["�Զ�ѡ���ս��"  .. 1]=0;
	WAR.Data["�ҷ�X"  .. 1]=JY.Base["��X1"];
	WAR.Data["�ҷ�Y"  .. 1]=JY.Base["��Y1"];
	WAR.Data["����"  .. 1]=pid;
	WAR.Data["�з�X"  .. 1]=2;
	WAR.Data["�з�Y"  .. 1]=2;
	local result=WarMain(998,1);
	lib.LoadSur(sid,0,0);
	return result;
end
function CommonEvent(eventid,pid)
	if pid<=0 then
		return true;
	end
	local msg=	{
					[0]=	{
								[0]=function()
									say("��ʲô����",pid);
								end,
								[1]=function()
									say("�ʹ˱�����պ���Ե�ټ���",pid);
								end,
							},
					[1]=	{
								[0]=function()
									say("��ʲôҪ�Ұ�æ��",pid);
								end,
								[1]=function()
									say("ɽ��ˮ����������ڣ�",pid);
								end,
							},
					[2]=	{
								[0]=function()
									say("��Ҫ���",pid);
								end,
								[1]=function()
									say("���Ҫ���˰���",pid);
								end,
							},
					[3]=	{
								[0]=function()
									say("���£�",pid);
								end,
								[1]=function()
									say("�ټ���",pid);
								end,
							},
					[4]=	{
								[0]=function()
									say("�˴�������������Ե����",pid);
								end,
								[1]=function()
									say("��ɽ���ģ���ˮ���������������������ڣ�",pid);
								end,
							},
					[5]=	{
								[0]=function()
									say("��֪��ʲô����Ҫָ�����£�",pid);
								end,
								[1]=function()
									say("�ٻᣬ�����ߡ�",pid);
								end,
							},
					[6]=	{
								[0]=function()
									say("�����ӷ�",pid);
								end,
								[1]=function()
									say("�����ӷ�",pid);
								end,
							},
					[7]=	{
								[0]=function()
									say("ƶ��������",pid);
								end,
								[1]=function()
									say("����Ե���ڴˣ���ȥ�ɣ���",pid);
								end,
							},
					[8]=	{
								[0]=function()
									say("�ҽ����ȥ��ʲô��",pid);
								end,
								[1]=function()
									say("��ô���Ҫ���˰�",pid);
								end,
							},
					[9]=	{
								[0]=function()
									say("��ʲô����",pid);
								end,
								[1]=function()
									say("�ʹ˱�����պ���Ե�ټ���",pid);
								end,
							},
					[10]=	{
								[0]=function()
									say("��ʲô����",pid);
								end,
								[1]=function()
									say("�ʹ˱�����պ���Ե�ټ���",pid);
								end,
							},
				}
	if JY.Person[pid]["�Ѻ�"]==0 then
		FirstTalk(pid);
		--[[
		DayPass(1);
		SetD(JY.SubScene,JY.CurrentD,0,0);
		SetD(JY.SubScene,JY.CurrentD,3,-1);
		SetD(JY.SubScene,JY.CurrentD,5,0);
		SetD(JY.SubScene,JY.CurrentD,6,0);
		SetD(JY.SubScene,JY.CurrentD,7,0);
		--return;
		]]--
	elseif JY.Person[pid]["�Ѻ�"]<0 then
		say("�Ҳ�������㡣",pid);
		DayPass(1);
		Dark();
			SetD(JY.SubScene,JY.CurrentD,0,0);
			SetD(JY.SubScene,JY.CurrentD,3,-1);
			SetD(JY.SubScene,JY.CurrentD,5,0);
			SetD(JY.SubScene,JY.CurrentD,6,0);
			SetD(JY.SubScene,JY.CurrentD,7,0);
		Light();
		return;
	end
	local xg=JY.Person[pid]["����"];
	local menu={
					{"����",nil,1},
					{"�Ⱦ�",nil,0},
					{"�Ĳ�",nil,0},
					{"����",nil,1},
					{"Ϯ��",nil,1},
					{"״̬",nil,1},
					{"û��",nil,1},
				};
	if eventid==1 then
		--·��
	elseif eventid==2 then
		--�ƹ�
		menu[2][3]=1;
	elseif eventid==3 then
		--�ĳ�
		menu[3][3]=1;
	elseif eventid==4 then
		--��ջ
	elseif eventid==5 then
		--����
	else
	end
	if JY.Person[0]["����"]>=0 and JY.Person[0]["����"]==JY.Person[pid]["����"] then
		menu[5][3]=0;
	end
while true do
	msg[xg][0]();
	local r=ShowMenu(menu,7,0,0,0,0,0,1,0);
	if r==1 then
		RandomEvent(pid);
		break;
	elseif r==2 then
		CommonDrink(pid);
		break;
	elseif r==3 then
		CommonGamble(pid);
		break;
	elseif r==4 then
		Query(pid);
		DayPass(1);
	elseif r==5 then
		CommonFight_Shell(pid);
		break;
	elseif r==6 then
		PersonStatus(pid);
	elseif r==7 then
		msg[xg][1]();
		break;
	end
end
	Dark();
			SetD(JY.SubScene,JY.CurrentD,0,0);
			SetD(JY.SubScene,JY.CurrentD,3,-1);
			SetD(JY.SubScene,JY.CurrentD,5,0);
			SetD(JY.SubScene,JY.CurrentD,6,0);
			SetD(JY.SubScene,JY.CurrentD,7,0);
			local fid=JY.Person[pid]["����"];
			if fid>=0 then
				JY.Person[pid]["����"]=JY.Shop[fid]["�ݵ�"];
			end
	Light();
end

function PersonRePosition(sid)
	CityNPCUpdate[sid]=GetFlag(1);
	local sidtable={1,38,40,109,112,130,131,132,133,134};
	local flag=true;
	for i,v in pairs(sidtable) do
		if sid==v then
			flag=false;
			break;
		end
	end
	if flag then
		return;
	end
	local p={};
	local d={};
	local num=0;
	for i=1,CC.ToalPersonNum do
		if JY.Person[i]["����"]==sid then
			table.insert(p,i);
			num=num+1;
		end
	end
	--����
	if num>1 then
		p=TableRandom(p);
	end
	--ͳ��
	local dnum1,dnum2=0,0;
	for i=0,199 do
		if GetD(JY.SubScene,i,2)>1000 then
			dnum1=dnum1+1;
			local id=GetD(JY.SubScene,i,3);
			if id>0 and JY.Person[id]["����"]==sid then
				for ii,v in pairs(p) do
					if v==id then
						table.remove(p,ii);
						break;
					end
				end
			else
				dnum2=dnum2+1;
				table.insert(d,i);
				SetD(JY.SubScene,i,0,0);
				SetD(JY.SubScene,i,3,-1);
				SetD(JY.SubScene,i,5,0);
				SetD(JY.SubScene,i,6,0);
				SetD(JY.SubScene,i,7,0);
			end
		end
	end
	--���ݳ���D����������npc���ּ���
	local blgl=0;
	if dnum2<10 then
		blgl=4;
	elseif dnum2<20 then
		blgl=3;
	elseif dnum2<30 then
		blgl=2;
	elseif dnum2<40 then
		blgl=1;
	end
	--����
	if dnum2>1 then
		d=TableRandom(d);
	end
	--����
	--�ĳ���������
	for i,v in pairs(d) do
		if GetD(JY.SubScene,v,2)==1003 and Rnd(10)<blgl+6 then
			for ii,id in pairs(p) do
				local gl=JY.Person[id]["�Ĳ�"]*10;
				if Rnd(100)<gl then
					table.remove(p,ii);
					SetD(JY.SubScene,v,0,1);
					SetD(JY.SubScene,v,3,id);
					SetD(JY.SubScene,v,5,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
					SetD(JY.SubScene,v,6,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
					SetD(JY.SubScene,v,7,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
					break;
				end
			end
			
		end
	end
	--�ƹݵ�������
	for i,v in pairs(d) do
		if GetD(JY.SubScene,v,2)==1002 and Rnd(10)<blgl+7 then
			for ii,id in pairs(p) do
				local gl=JY.Person[id]["����"]*10;
				if Rnd(100)<gl then
					table.remove(p,ii);
					SetD(JY.SubScene,v,0,1);
					SetD(JY.SubScene,v,3,id);
					SetD(JY.SubScene,v,5,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
					SetD(JY.SubScene,v,6,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
					SetD(JY.SubScene,v,7,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
					break;
				end
			end
			
		end
	end
	--����
	for i,v in pairs(d) do
		if GetD(JY.SubScene,v,2)==1001 and Rnd(10)<blgl+5 then
			if p[1]==nil then
				break;
			else
				local id=p[1] or 0;
				table.remove(p,1);
				SetD(JY.SubScene,v,0,1);
				SetD(JY.SubScene,v,3,id);
				SetD(JY.SubScene,v,5,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
				SetD(JY.SubScene,v,6,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
				SetD(JY.SubScene,v,7,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
			end
		end
	end
end

function PersonMove()
	local sid={	1,38,40,109,112,
				130,131,132,133,134};
	local snum=10;
	for i=1,CC.ToalPersonNum do
		if JY.Person[i]["���"]>0 and JY.Person[i]["�ǳ�"]==1 then
			if JY.Person[i]["����"]~=-1 then
				local gl=JY.Person[i]["���"];
				if Rnd(10)<gl then
					JY.Person[i]["����"]=sid[math.random(snum)];
				else
					local fid=JY.Person[i]["����"];
					if fid>=0 then
						JY.Person[i]["����"]=JY.Shop[fid]["�ݵ�"];
					end
				end
			end
		end
	end
	CityNPCUpdate={};
end

function CommonGamble(pid)
	local xg=JY.Person[pid]["����"];
	local name1=JY.Person[0]["����"];
	local name2=JY.Person[pid]["����"];
	local msg=	{
					[0]=	{
								[0]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say(name1.."�������������ǡ�",pid);
								end,
								[1]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("��л"..name1.."�֣������������ˣ������л��ᣬ������ӡ�",pid);
								end,
								[2]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����������������²���ʤ���ʰ��·簡��");
									say("����������ĳ����Ҳ�Ǻ��е���˳��",pid);
								end,
								[3]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����й������������²���ʤ�ӡ�");
									say("�ţ�����ǻ����Ҵ�ͨ�ĳ����ף�",pid);
									say("����ô�һ���"..name2.."���أ���˵�Ĺ��ˣ���Ȼָ�����Ƕķ�֮��");
									say("�����ֵ����Ҵ�",pid);
									if CommonFight(pid) then
										say(name2.."��������߳�ŭ�����Ǳ���˵���ˣ�",pid);
										say("�ߣ�");
									else
										say("�벻��������䲻�����������ˣ��ߣ�");
										say("�ɶ񡭡�",pid);
									end
								end,
								[4]=function()
									say("�����˲����ˣ�"..name1.."������������������ȫʤ���˰���",pid);
									local menu=	{
													{"������������������ѡ�",1},
													{"����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("������������������ѡ�");
									else
										say("����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������");
										say(name1.."�ֺα���˿̱���",pid);
										say("˵�ҿ̱����Ҵ�");
										if CommonFight(pid) then
											say("��Ҳ�Ĳ�������Ҳ�򲻹��������㱨����������");
											say("�ߣ�",pid);
										else
											say("��ô���Ĳ�����������ѹ�ˣ�");
											say("�����˺������񣡺ߣ�",pid);
										end
									end
								end,
							},
					[1]=	{
								[0]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("ĳ������Щ�������������аɡ�",pid);
								end,
								[1]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("���վ����ˣ�ĳ��һ����ߡ�",pid);
								end,
								[2]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����������������²���ʤ���ʰ��·簡��");
									say("���������������̵ģ�����үү��������а�����ˡ�",pid);
								end,
								[3]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����й������������²���ʤ�ӡ�");
									say("�ţ�����ǻ����Ҵ�ͨ�ĳ����ף�",pid);
									say("����ô�һ���"..name2.."���أ���˵�Ĺ��ˣ���Ȼָ�����Ƕķ�֮��");
									say("�����������Ҵ�",pid);
									if CommonFight(pid) then
										say(name2.."��������߳�ŭ�����Ǳ���˵���ˣ�",pid);
										say("�ߣ�");
									else
										say("�벻��������䲻��ĳ��Ϲ�����ˣ��ߣ�");
										say("�ɶ񡭡�",pid);
									end
								end,
								[4]=function()
									say("�����˲����ˣ�"..name1.."������������ĳ��ȫʤ���˰���",pid);
									local menu=	{
													{"������������������ѡ�",1},
													{"����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("������������������ѡ�");
									else
										say("����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������");
										say(name1.."�ֺα���˿̱���",pid);
										say("˵�ҿ̱����Ҵ�");
										if CommonFight(pid) then
											say("��Ҳ�Ĳ�������Ҳ�򲻹��������㱨����������");
											say("�ߣ�",pid);
										else
											say("��ô���Ĳ�����������ѹ�ˣ�");
											say("�����˺������񣡺ߣ�",pid);
										end
									end
								end,
							},
					[2]=	{
								[0]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("�����̵ģ���үү����δ�ɱ�ķ���",pid);
								end,
								[1]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("�����̵ģ�үүΪɶҪ����С�Ӷģ�",pid);
								end,
								[2]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����������������²���ʤ���ʰ��·簡��");
									say("����������һʱ�������ѡ�",pid);
								end,
								[3]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����й������������²���ʤ�ӡ�");
									say("�ţ�����ǻ���үү���ף�",pid);
									say("����ô�һ���"..name2.."���أ���˵�Ĺ��ˣ���Ȼָ�����Ƕķ�֮��");
									say("�۰��������Ҵ�",pid);
									if CommonFight(pid) then
										say(name2.."��������߳�ŭ�����Ǳ���˵���ˣ�",pid);
										say("�ߣ�");
									else
										say("�벻��������䲻��үү�Ͳ��ø����棡");
										say("�ɶ񡭡�",pid);
									end
								end,
								[4]=function()
									say("�����˲����ˣ������̵ģ���С������������үү��ȫʤ���˰���",pid);
									local menu=	{
													{"������������������ѡ�",1},
													{"����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("������������������ѡ�");
									else
										say("����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������");
										say("��С����ȻӮ�ˣ�����˵��Ҳ����ô��������",pid);
										say("˵�ң��Ҵ�");
										if CommonFight(pid) then
											say("��Ҳ�Ĳ�������Ҳ�򲻹��������㱨����������");
											say("�ߣ������̵ģ�",pid);
										else
											say("��ô���Ĳ�����������ѹ�ˣ�");
											say("�����С�Ӹ�үү���ţ��ߣ�",pid);
										end
									end
								end,
							},
					[3]=	{
								[0]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("��������",pid);
								end,
								[1]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("�������ˡ�",pid);
								end,
								[2]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����������������²���ʤ���ʰ��·簡��");
									say("����������",pid);
								end,
								[3]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����й������������²���ʤ�ӡ�");
									say("���������ף�",pid);
									say("����ô�һ���"..name2.."���أ���˵�Ĺ��ˣ���Ȼָ�����Ƕķ�֮��");
									say("�������У�",pid);
									if CommonFight(pid) then
										say(name2.."��������߳�ŭ�����Ǳ���˵���ˣ�",pid);
										say("�����ߣ�");
									else
										say("�����ޣ�");
										say("�ɶ񡭡�",pid);
									end
								end,
								[4]=function()
									say("���������ˣ�ʤ���ˡ�",pid);
									local menu=	{
													{"������������������ѡ�",1},
													{"����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("������������������ѡ�");
									else
										say("����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������");
										say("�����ѿ���",pid);
										say("˵�ң��Ҵ�");
										if CommonFight(pid) then
											say("��Ҳ�Ĳ�������Ҳ�򲻹��������㱨����������");
											say("�����ߣ�",pid);
										else
											say("��ô���Ĳ�����������ѹ�ˣ�");
											say("�����ߣ�",pid);
										end
									end
								end,
							},
					[4]=	{
								[0]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("�����������ã����ձ��"..name1.."���������ѡ�",pid);
								end,
								[1]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("������Щ���㣬���ն�����"..name1.."�ֶĸ�ʹ�죡",pid);
								end,
								[2]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����������������²���ʤ���ʰ��·簡��");
									say("�������������ַ粻��"..name1.."�֣������ˡ�",pid);
								end,
								[3]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����й������������²���ʤ�ӡ�");
									say("�ţ�����ǻ����Ҵ�ͨ�ĳ����ף�",pid);
									say("����ô�һ���"..name2.."���أ���˵�Ĺ��ˣ���Ȼָ�����Ƕķ�֮��");
									say("���ɷ��л�ֱ˵���α��������������",pid);
									if CommonFight(pid) then
										say(name2.."��������߳�ŭ�����Ǳ���˵���ˣ�",pid);
										say("�ߣ�");
									else
										say("�벻��������䲻������ʶ�˲������ߣ�");
										say("�ɶ񡭡�",pid);
									end
								end,
								[4]=function()
									say("�����˲����ˣ�"..name1.."������������������ȫʤ���˰���",pid);
									local menu=	{
													{"������������������ѡ�",1},
													{"����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("������������������ѡ�");
									else
										say("����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������");
										say(name1.."�ִ˻�������δ���˼�������",pid);
										say("˵�ҿ̱����Ҵ�");
										if CommonFight(pid) then
											say("��Ҳ�Ĳ�������Ҳ�򲻹��������㱨����������");
											say("�ߣ�",pid);
										else
											say("��ô���Ĳ�����������ѹ�ˣ�");
											say("�����˺������񣡺ߣ�",pid);
										end
									end
								end,
							},
					[5]=	{
								[0]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say(name1.."���������������ǲ��Ҳ��ӡ�",pid);
								end,
								[1]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say(name1.."�ּ��£����������ַ粻˳���Ͳ��³��ˡ�",pid);
								end,
								[2]=function()
									say("�����˲����ˣ�"..name2.."���ӽ����������������²���ʤ���ʰ��·簡��");
									say("���Ҳ��ң����ö�л"..name1.."���������顣",pid);
								end,
								[3]=function()
									say("�����˲����ˣ�"..name2.."���ӽ����й������������²���ʤ�ӡ�");
									say("�ţ�����ǻ����Ҵ�ͨ�ĳ����ף�",pid);
									say("����ô�һ���"..name2.."�����أ���˵�Ĺ��ˣ���Ȼָ�����Ƕķ�֮��");
									say("�Ӳ�����������㲻�ؽ�˼���",pid);
									if CommonFight(pid) then
										say(name2.."����������߳�ŭ�����Ǳ���˵���ˣ�",pid);
										say("�ߣ�");
									else
										say("�벻��������䲻��������˫Ŀ�ɳ�����ʶ���ģ��ߣ�");
										say("�ɶ񡭡�",pid);
									end
								end,
								[4]=function()
									say("�����˲����ˣ�"..name1.."������������������ȫʤ���˰���",pid);
									local menu=	{
													{"������������������ѡ�",1},
													{"����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("������������������ѡ�");
									else
										say("����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������");
										say(name1.."�ִ��ԣ�δ����Щ̫����",pid);
										say("˵�ҿ̱����Ҵ�");
										if CommonFight(pid) then
											say("��Ҳ�Ĳ�������Ҳ�򲻹��������㱨����������");
											say("�ߣ�",pid);
										else
											say("��ô���Ĳ�����������ѹ�ˣ�");
											say("�����˺������񣡺ߣ�",pid);
										end
									end
								end,
							},
					[6]=	{
								[0]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say(name1.."�������������ǡ�",pid);
								end,
								[1]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("��л"..name1.."�֣������������ˣ������л��ᣬ������ӡ�",pid);
								end,
								[2]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����������������²���ʤ���ʰ��·簡��");
									say("����������һʱ�������ѡ�",pid);
								end,
								[3]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����й������������²���ʤ�ӡ�");
									say("�ţ�����ǻ����Ҵ�ͨ�ĳ����ף�",pid);
									say("����ô�һ���"..name2.."���أ���˵�Ĺ��ˣ���Ȼָ�����Ƕķ�֮��");
									say("�����ֵ����Ҵ�",pid);
									if CommonFight(pid) then
										say(name2.."��������߳�ŭ�����Ǳ���˵���ˣ�",pid);
										say("�ߣ�");
									else
										say("�벻��������䲻�����������ˣ��ߣ�");
										say("�ɶ񡭡�",pid);
									end
								end,
								[4]=function()
									say("�����˲����ˣ�"..name1.."������������������ȫʤ���˰���",pid);
									local menu=	{
													{"������������������ѡ�",1},
													{"����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("������������������ѡ�");
									else
										say("����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������");
										say(name1.."�ֺα���˿̱���",pid);
										say("˵�ҿ̱����Ҵ�");
										if CommonFight(pid) then
											say("��Ҳ�Ĳ�������Ҳ�򲻹��������㱨����������");
											say("�ߣ�",pid);
										else
											say("��ô���Ĳ�����������ѹ�ˣ�");
											say("�����˺������񣡺ߣ�",pid);
										end
									end
								end,
							},
					[7]=	{
								[0]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say(name1.."�������������ǡ�",pid);
								end,
								[1]=function()
									say(name2.."�֡���֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("��л"..name1.."�֣������������ˣ������л��ᣬ������ӡ�",pid);
								end,
								[2]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����������������²���ʤ���ʰ��·簡��");
									say("����������һʱ�������ѡ�",pid);
								end,
								[3]=function()
									say("�����˲����ˣ�"..name2.."�ֽ����й������������²���ʤ�ӡ�");
									say("�ţ�����ǻ����Ҵ�ͨ�ĳ����ף�",pid);
									say("����ô�һ���"..name2.."���أ���˵�Ĺ��ˣ���Ȼָ�����Ƕķ�֮��");
									say("�����ֵ����Ҵ�",pid);
									if CommonFight(pid) then
										say(name2.."��������߳�ŭ�����Ǳ���˵���ˣ�",pid);
										say("�ߣ�");
									else
										say("�벻��������䲻�����������ˣ��ߣ�");
										say("�ɶ񡭡�",pid);
									end
								end,
								[4]=function()
									say("�����˲����ˣ�"..name1.."������������������ȫʤ���˰���",pid);
									local menu=	{
													{"������������������ѡ�",1},
													{"����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("������������������ѡ�");
									else
										say("����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������");
										say(name1.."�ֺα���˿̱���",pid);
										say("˵�ҿ̱����Ҵ�");
										if CommonFight(pid) then
											say("��Ҳ�Ĳ�������Ҳ�򲻹��������㱨����������");
											say("�ߣ�",pid);
										else
											say("��ô���Ĳ�����������ѹ�ˣ�");
											say("�����˺������񣡺ߣ�",pid);
										end
									end
								end,
							},
					[8]=	{
								[0]=function()
									say(name2.."��㡣��֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say(name1.."�õܵ�~��������������~",pid);
								end,
								[1]=function()
									say(name2.."��㡣��֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("�õܵ�~�������е�����~�´ΰ�~",pid);
								end,
								[2]=function()
									say("�����˲����ˣ�"..name2.."�������������������²���ʤ���ʰ��·簡��");
									say("�õܵ�~��������ĺܿ��İ�~",pid);
								end,
								[3]=function()
									say("�����˲����ˣ�"..name2.."�������й������������²���ʤ�ӡ�");
									say("�õܵ�~����ǻ��ɽ�㴮ͨ�ĳ����ף�",pid);
									say("����ô�һ���"..name2.."����أ���˵�Ĺ��ˣ���Ȼָ�����Ƕķ�֮��");
									say("���컬��~�ִ�~",pid);
									if CommonFight(pid) then
										say(name2.."X���α����գ����Ǳ���˵���ˣ�",pid);
										say("����~�˼Ҳ�����~");
									else
										say("ԭ���ܵ�����䲻��~�´ν����������~");
										say("�ɶ񡭡�",pid);
									end
								end,
								[4]=function()
									say("����~�ܵ������������˼Ҳ�����~",pid);
									local menu=	{
													{"������������������ѡ�",1},
													{"����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("������������������ѡ�");
									else
										say("����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������");
										say("�ף���㻹�����ʶ��ʶ�ܵ��ж�������~",pid);
										say("�Ҵ�");
										if CommonFight(pid) then
											say("��Ҳ�Ĳ�������Ҳ�򲻹��������㱨����������");
											say("������~����������~",pid);
										else
											say("��ô���Ĳ�����������ѹ�ˣ�");
											say("�����ô����ô����~����~����������~",pid);
										end
									end
								end,
							},
					[9]=	{
								[0]=function()
									say(name2.."�����֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say(name1.."���������������顣",pid);
								end,
								[1]=function()
									say(name2.."�����֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("СŮ�ӽ��ղ��㣬�����³����빫��ˡ�",pid);
								end,
								[2]=function()
									say("�����˲����ˣ�"..name2.."��������������������²���ʤ���ʰ��·簡��");
									say("�ǹ�������ǫ�ö��ѡ�",pid);
								end,
								[3]=function()
									say("�����˲����ˣ�"..name2.."��������й������������²���ʤ�ӡ�");
									say("�ף����Ӵ��Կ��ǻ���СŮ�Ӵ�ͨ�ĳ����ף�",pid);
									say("����ô�һ���"..name2.."�����أ���˵�Ĺ��ˣ���Ȼָ�����Ƕķ�֮��");
									say("����Ī����̫����",pid);
									if CommonFight(pid) then
										say(name2.."����α����գ����Ǳ���˵���ˣ�",pid);
										say("����˵�Ǳ��ǰɣ�СŮ��ˡ�����㡣");
									else
										say("�����빫�Ӿ������֮�ˣ�СŮ�Ӻ���ʧ�������и��ˡ�");
										say("�ɶ񡭡�",pid);
									end
								end,
								[4]=function()
									say("��������������СŮ��ʤ֮���ܡ�",pid);
									local menu=	{
													{"������������������ѡ�",1},
													{"����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("������������������ѡ�");
									else
										say("����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������");
										say("�������Գ���ݡ�",pid);
										say("˵�̣��Ҵ�");
										if CommonFight(pid) then
											say("��Ҳ�Ĳ�������Ҳ�򲻹��������㱨����������");
											say("СŮ�Ӽ������ˣ��޻���˵��",pid);
										else
											say("��ô���Ĳ�����������ѹ�ˣ�");
											say("���Ӵ������ģ��������ء�",pid);
										end
									end
								end,
							},
					[10]=	{
								[0]=function()
									say(name2.."Ů������֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say(name1.."�������������ﲻ���㡣",pid);
								end,
								[1]=function()
									say(name2.."Ů������֮�к�Ȥζ������֮���β��³�һ�ģ�");
									say("�㣿��ȥ���������ұ�����ɡ�",pid);
								end,
								[2]=function()
									say("�����˲����ˣ�"..name2.."Ů�������������������²���ʤ���ʰ��·簡��");
									say("���ǣ���������˭��",pid);
								end,
								[3]=function()
									say("�����˲����ˣ�"..name2.."Ů�������й������������²���ʤ�ӡ�");
									say("�ף�����˵�����ﴮͨ�ĳ����ף�",pid);
									say("����ô�һ���"..name2.."Ů���أ���˵�Ĺ��ˣ���Ȼָ�����Ƕķ�֮��");
									say("���۸������Ҵ�",pid);
									if CommonFight(pid) then
										say(name2.."Ů���α����գ����Ǳ���˵���ˣ�",pid);
										say("�ߣ�");
									else
										say("�������벻�����Ȼ�������ˣ�");
										say("�ɶ񡭡�",pid);
									end
								end,
								[4]=function()
									say("�����˲����ˣ�"..name1.."������������������ȫʤ���˰���",pid);
									local menu=	{
													{"������������������ѡ�",1},
													{"����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������",1},
												};
									local sel=GenSelection(menu);
									if sel==1 then
										say("������������������ѡ�");
									else
										say("����֮�٣���Ȼ�ؽ����ʶ��ʶ�ҵ�������");
										say("����˵��������ϰɣ�",pid);
										say("˵�̣��Ҵ�");
										if CommonFight(pid) then
											say("��Ҳ�Ĳ�������Ҳ�򲻹��������㱨����������");
											say("�ߣ�",pid);
										else
											say("��ô���Ĳ�����������ѹ�ˣ�");
											say("�����ﻹ��м��ô����",pid);
										end
									end
								end,
							},
				}
	if Rnd(10)<8 then
		msg[xg][0]();
		local m1,m2=Gamble1(pid);
		if m1>200 and m2<200 and m1-m2>=100 then
			msg[xg][4]();
		elseif m1<200 and m2>200 then--and m2-m1>=100 then
			if m2-m1>=100 then
				msg[xg][3]();
			else
				msg[xg][2]();
				AddPersonAttrib(pid,"�Ѻ�",10);
			end
		end
		--[[
		if r==1 then
			msg[xg][2]();
		elseif r==2 then
			msg[xg][3]();
		elseif r==3 then
			msg[xg][4]();
		elseif r==4 then
		
		else
		
		end]]--
	else
		msg[xg][1]();
	end
end
function Gamble1(pid)
	local player={};
	player.name={"ׯ��",JY.Person[pid]["����"],JY.Person[0]["����"],"��ͽ"};--{"JY027","��ͽ","����","KA",}--JY.Person[pid]["����"],JY.Person[0]["����"]
	player.money={1000,200,200,200};
	player.dz={0,0,0,0};
	player.talk={"","","",""}--{"��Һ�*�����ް�棬follow��̳�漴��*��Ϸ�����У�������ʱֻ������֮��","�����÷�����̫�޳��ˣ�","��ϲ���棡","��ʲô�ư�棡*���������ڣ�"};
	player.talkx={CC.ScreenW/2+CC.Fontbig*3,CC.Fontbig,CC.ScreenW/2+CC.Fontbig*3,-CC.Fontbig};
	player.talky={CC.Fontbig,CC.ScreenH/2-CC.Fontbig-CC.Fontsmall-CC.MenuBorderPixel*4,CC.ScreenH-CC.Fontbig*3-CC.MenuBorderPixel*2,CC.ScreenH/2-CC.Fontbig-CC.Fontsmall-CC.MenuBorderPixel*4};
	local function redraw()
		if JY.WindowReSizeFlag then
			JY.WindowReSizeFlag=false;
			player.talkx={CC.ScreenW/2+CC.Fontbig*3,CC.Fontbig,CC.ScreenW/2+CC.Fontbig*3,-CC.Fontbig};
			player.talky={CC.Fontbig,CC.ScreenH/2-CC.Fontbig-CC.Fontsmall-CC.MenuBorderPixel*4,CC.ScreenH-CC.Fontbig*3-CC.MenuBorderPixel*2,CC.ScreenH/2-CC.Fontbig-CC.Fontsmall-CC.MenuBorderPixel*4};
		end
		lib.FillColor(0,0,0,0,0);
		lib.PicLoadCache(1,901*2,CC.ScreenW/2,CC.ScreenH/2);
		DrawStrBox_1(-1,CC.Fontbig,string.format("%s*����:%4d��",player.name[1],player.money[1]),C_WHITE,CC.Fontbig);
		DrawStrBox_1(CC.Fontbig,-1,string.format("%s*����:%4d��",player.name[2],player.money[2]),C_WHITE,CC.Fontbig);
		DrawStrBox_1(-1,-CC.Fontbig,string.format("%s*����:%4d��",player.name[3],player.money[3]),C_WHITE,CC.Fontbig);
		DrawStrBox_1(-CC.Fontbig,-1,string.format("%s*����:%4d��",player.name[4],player.money[4]),C_WHITE,CC.Fontbig);
		for i=1,4 do
			if player.talk[i]~="" then
				DrawStrCircleBox(player.talkx[i],player.talky[i],player.talk[i],C_WHITE,CC.Fontsmall);
			end
		end
	end
	local function touzi()
		--local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
		for i=3,14 do
			--lib.LoadSur(sid,0,0);
			redraw();
			lib.PicLoadCache(1,(900+i)*2,CC.ScreenW/2,CC.ScreenH/2-120);
			ShowScreen();
			Delay(1);
			getkey();
		end
		local num1,num2=math.random(6),math.random(6);
		if Rnd(100)<80-60 then--JY.Person[0]["��Ե"] then
			if (num1+num2>6 and player.dz[3]<0) or (num1+num2<7 and player.dz[3]>0) then
				num1,num2=math.random(6),math.random(6);
			end
		elseif Rnd(100)>30*2 then
			if (num1+num2>6 and player.dz[3]>0) or (num1+num2<7 and player.dz[3]<0) then
				num1,num2=math.random(6),math.random(6);
			end
		end
		--lib.LoadSur(sid,0,0);
		redraw();
		lib.PicLoadCache(1,(914+num1)*2,CC.ScreenW/2-15+Rnd(5)-Rnd(5),CC.ScreenH/2-43+Rnd(5)-Rnd(5));
		lib.PicLoadCache(1,(914+num2)*2,CC.ScreenW/2+35+Rnd(5)-Rnd(5),CC.ScreenH/2-35+Rnd(5)-Rnd(5));
		ShowScreen();
		Delay(9);
		getkey();
		--lib.FreeSur(sid);
		return num1+num2;
	end
	local function ShowResult(s)
		DrawStrNewBox(-1,CC.ScreenH/2+CC.Fontbig,s,C_WHITE,CC.FontBig);
		ShowScreen();
		Delay(2);
		WaitKey();
	end
	local T={"һ","��","��","��","��","��","��","��","��","ʮ","ʮһ","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","��ʮ","��ʮһ",};
	local T2={"ʮ","��ʮ","��ʮ","��ʮ","��ʮ","��ʮ","��ʮ","��ʮ","��ʮ","һ��","Error","Error","Error","Error","Error","Error","Error","Error","Error","Error","Error",};
	local winmsg={"��������","��֪���Ͷ��µ㣡","ׯ�ҿ���Ǯ��","���������Ҵ�ɱ�ķ���","�ǲ��Ǹü��þ����أ�",
				"��Ӯһ�Ѿ����֡�","�Ǻǣ�������˼��Ӯ�ˣ�","��л����ү���ӣ�","�����ˣ������ˣ�","��һ�Ѽ���Ӯ��"};
	local losemsg={"�������","�Һ�û���¡�","ׯ���㲻�������װɡ�","����Ͳ����ˣ�","�´�һ��ҪӮ��",
				"��ô�������أ�","�����Ҫ�������ˣ�","Ǯ�Ʊ��������","Ӧ�ÿ��������ٳ����ĵģ�","���ǰɣ��ϱ���Ҫ��û�ˣ�"};
	local times=0;
	while true do
		times=times+1;
		for i=1,4 do
			player.talk[i]="";
		end
		redraw();
		ShowScreen();
		Delay(5);
		getkey();
		player.talk[1]="��ע��ע��";
		redraw();
		ShowScreen();
		Delay(10);
		getkey();
		for i=2,4 do
			if i==3 then
				local m1={{"ʮ��",nil,1},{"��ʮ��",nil,1},{"��ʮ��",nil,1},{"��ʮ��",nil,1},{"��ʮ��",nil,1},};
				local m2={{"��",nil,1},{"С",nil,1}};
				player.talk[1]="�͹٣�Ѻ���٣�";
				redraw();
				ShowScreen();
				Delay(5);
				getkey();
				player.dz[i]=ShowMenu(m1,5,0,-1,-1,0,0,1,0,CC.Fontbig,C_ORANGE,C_WHITE);
				player.talk[1]="Ѻ����ѺС��";
				redraw();
				ShowScreen();
				Delay(5);
				getkey();
				if ShowMenu(m2,2,0,-1,-1,0,0,1,0,CC.Fontbig,C_ORANGE,C_WHITE)==1 then
					player.talk[i]=T2[player.dz[i]].."������";
					player.dz[i]=player.dz[i]*10;
				else
					player.talk[i]=T2[player.dz[i]].."����С��";
					player.dz[i]=-player.dz[i]*10;
				end
			else
				player.dz[i]=(1+math.max(Rnd(6)-Rnd(3),0));
				if Rnd(2)==1 then
					player.talk[i]=T2[player.dz[i]].."������";
					player.dz[i]=player.dz[i]*10;
				else
					player.talk[i]=T2[player.dz[i]].."����С��";
					player.dz[i]=-player.dz[i]*10;
				end
			end
			redraw();
			ShowScreen();
			Delay(7);
			getkey();
		end
		player.talk[1]="�������ˣ�";
		redraw();
		ShowScreen();
		for i=2,4 do
			player.talk[i]="";
		end
		Delay(10);
		getkey();
		local num=touzi();
		if num>=12 then
			ShowResult(T[num].."�㣬ׯ��ͨɱ");
			redraw();
			player.talk[1]="������ͨɱͨɱ��";
			redraw();
			ShowScreen();
			Delay(5);
			getkey();
			for i=2,4 do
				player.money[i]=player.money[i]-math.abs(player.dz[i]);
				player.money[1]=player.money[1]+math.abs(player.dz[i]);
				player.dz[i]=0;
				DrawStrBox(player.talkx[i],player.talky[i],losemsg[math.random(10)],C_WHITE,CC.Fontsmall);
				ShowScreen();
				Delay(5);
				getkey();
			end
		elseif num>6 then
			ShowResult(T[num].."���");
			redraw();
			player.talk[1]=T[num].."���";
			redraw();
			ShowScreen();
			Delay(5);
			getkey();
			for i=2,4 do
				player.money[i]=player.money[i]+player.dz[i];
				player.money[1]=player.money[1]-player.dz[i];
				if player.dz[i]>0 then
					player.talk[i]=winmsg[math.random(10)];
				else
					player.talk[i]=losemsg[math.random(10)];
				end
				player.dz[i]=0;
				redraw();
				ShowScreen();
				Delay(5);
				getkey();
			end
		else
			ShowResult(T[num].."��С");
			redraw();
			player.talk[1]=T[num].."��С";
			redraw();
			ShowScreen();
			Delay(5);
			getkey();
			for i=2,4 do
				player.money[i]=player.money[i]-player.dz[i];
				player.money[1]=player.money[1]+player.dz[i];
				if player.dz[i]<0 then
					player.talk[i]=winmsg[math.random(10)];
				else
					player.talk[i]=losemsg[math.random(10)];
				end
				player.dz[i]=0;
				redraw();
				ShowScreen();
				Delay(5);
				getkey();
			end
		end
		DayPass(1);
		local overflag=false;
		for i=1,4 do
			if player.money[i]<=10 then
				for j=1,4 do
					player.talk[j]="";
				end
				player.talk[i]="ûǮ��......";
				overflag=true;
				break;
			end
		end
		--
		redraw();
		ShowScreen();
		Delay(5);
		if overflag then
			if times<3 then
				player.talk[2]="��ô��ô��Ͳ����ˣ�*��ɨ�ˣ�";
				redraw();
				ShowScreen();
				Delay(8);
			end
			break;
		end
		--
		if not DrawStrBoxYesNo(-1,-1,"����������") then
			for i=1,4 do
				player.talk[i]="";
			end
			if player.money[3]>300 then
				player.talk[3]="������Ӯ��Ӯ�ˣ�*�һ����£���������";
			elseif player.money[3]<150 then
				player.talk[3]="�����ˣ���������̫�";
			else
				player.talk[3]="�һ����£������ˡ�";
			end
			redraw();
			ShowScreen();
			Delay(8);
			if times<3 then
				player.talk[2]="��ô��ô��Ͳ����ˣ�*��ɨ�ˣ�";
				redraw();
				ShowScreen();
				Delay(8);
			end
			break;
		end
	end
	for i,v in pairs({4,3,2}) do
		if player.money[v]<50 then
			player.talk[v]="�ײı�����û�ˣ�*�����˲����ˣ�";
		elseif player.money[v]<160 then
			player.talk[v]="��ô��Ͳ����ˣ�*�һ�Ҫ����������";
		elseif player.money[v]<200 then
			player.talk[v]="����û����١�";
		elseif player.money[v]==200 then
			player.talk[v]="û��ûӮ������ɶ��";
		elseif player.money[v]>400 then
			player.talk[v]="���ˣ����ˣ�����";
		elseif player.money[v]>300 then
			player.talk[v]="������СӮ��һ��㡣";
		elseif player.money[v]>240 then
			player.talk[v]="�����������С�";
		else
			player.talk[v]="����������������";
		end
		redraw();
		ShowScreen();
		Delay(8);
	end
	if player.money[1]<300 then
		player.talk[1]="Ҫ�����ˣ�*�������´�ȥ��Ұɣ�";
	elseif player.money[1]>1000 then
		player.talk[1]="�缸���´���������";
	else
		player.talk[1]="��λ�����ߡ�";
	end
	redraw();
	ShowScreen();
	Delay(8);
	Delay(10);
	WaitKey();
	return player.money[3],player.money[2],player.money[4],player.money[1];--���ǣ�NPC����ͽ��ׯ��
	--dubo1(pid);
end



