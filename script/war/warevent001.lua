--ƽ֮ɱ������
if JY.Person[0]["����"]<50 then
	if WAR.tmp[1]==nil then
		lib.Delay(500);
		Dark();
		WE_addperson(9,32,21,2,500,true);
		WE_addperson(14,32,22,2,700,true);
		WAR.CurID=WAR.PersonNum-1;
		WarDrawMap(0);
		Light();
		say("��ʦ�磬����ȥ������ǰɡ�",14);
		say("Ҳ�ã��������书·���������һ�ɽ�ɵģ�Ī��ʦ�����յ����ˣ�",9);
		say("�Ȱ���Ⱥ���˴�����˵�ɡ�",14);
		JY.Person[14]["�Ѻ�"]=25;
		WAR.tmp[1]=1;
	end
end

if WAR.tmp[2]==nil then
	if WE_close(0,36,1) then
		Cls();
		say("������ҰС�ӣ��ҹܱ���ү�����£�",36);
		say("�������İ��࣬���˵ö���֮");
		WAR.tmp[2]=1;
	end
end

if WAR.tmp[3]==nil then
	if WE_close(0,136,1) then
		Cls();
		say("����ͷ����û�°ɡ�");
		say("�ţ���л�����������⼸�������书ȴ���˵á�",136);
		say("������С��ӭս��");
		WAR.tmp[3]=1;
	end
end

if WAR.tmp[4]==nil then
	if WE_close(36,136,1) then
		Cls();
		say("�����ӵģ������ĸ��ǹ���ӣ�",36);
		say("˭��������˭��",136);
		WAR.tmp[4]=1;
	end
end

if WAR.tmp[5]==nil then
	if WE_close(0,14,2) then
		Cls();
		say("Сʦ��ͦס����ʦ����ָ��ָ����Ľ�����",14);
		WAR.tmp[5]=1;
	end
end

if WAR.tmp[6]==nil then
	if WE_close(136,14,2) then
		Cls();
		say("�벻�����书���������������Ϊ��ֻ�Ǹ���Ů���ء�",136);
		WAR.tmp[6]=1;
	end
end















--[[
local hu
for i=0,WAR.PersonNum-1 do
	if WAR.Person[i]["������"]==1 then hu=i end
end

local cx,cy=WAR.Person[WAR.CurID]["����X"],WAR.Person[WAR.CurID]["����Y"]
WAR.CurID=hu
cx,cy=36,36
say("�����ã������ڿ�ʼ����ս���¼������������������ƶ�һ��",1,0)
say("�ҵģ�Ŀ��"..cx.."|"..cy.."|",1,0)
--	WarDrawMap(0);
--	ShowScreen();
--	lib.Delay(CC.WarAutoDelay);
--while true do
--WAR.Person[WAR.CurID]["�ƶ�����"]=100
--local x,y=War_SelectMove() 
--War_SelectMove() 
cx,cy=WE_xy(cx,cy,hu)
say("���ģ�Ŀ��"..cx.."|"..cy.."|",1,0)
--War_CalMoveStep(WAR.CurID,100,0); 
War_MovePerson(cx,cy)
say("���ҹ�ϲ��",1,0)
say("�㹦�������ˣ����ҽа�����",1,0)

				WAR.Person[WAR.PersonNum]["������"]=3;
				WAR.Person[WAR.PersonNum]["�ҷ�"]=false;
				WAR.Person[WAR.PersonNum]["����X"]=cx;
				WAR.Person[WAR.PersonNum]["����Y"]=cy;
				WAR.Person[WAR.PersonNum]["����"]=false;
				WAR.Person[WAR.PersonNum]["�˷���"]=2;
				WAR.PersonNum=WAR.PersonNum+1
				WarPersonSort()
	for i=0,WAR.PersonNum-1 do
		lib.PicLoadFile(string.format(CC.FightPicFile[1],JY.Person[3]["ͷ�����"]),
		                string.format(CC.FightPicFile[2],JY.Person[3]["ͷ�����"]),
						4+i);
						end
        for i=0,WAR.PersonNum-1 do
            WAR.Person[i]["��ͼ"]=WarCalPersonPic(i);
        end
		SetWarMap(cx,cy,2,WAR.CurID);
		SetWarMap(cx,cy,5,WAR.Person[WAR.CurID]["��ͼ"]);
	WarDrawMap(0);
	ShowScreen();
--end
--]]





--[[
���������Ҫ�������ţ����ڵط��ҷ������꣬�Ƿ�����������
Ȼ���ս���������1
��ȡ���﹥��������ͼ���Լ�վ��ͼ
���������꣬д���ͼ�ڶ���(ս��������)�������Ϣ����ͼ��
���а��Ṧ����
���drawwarmap����ʾ����

�ƶ��Ļ������ǲ�ͬ��Ҫ��Ӧ���� move��moveto
�ؼ�������callmovestep����move
����Ŀ���Ӧ���ǿ��Ե����
����ڳ�����Ӧע�⣬�����������ܵ�����������Ŀ��
������¾͵ô��Ǹ��������￴���ˣ���Ū����˵

]]--