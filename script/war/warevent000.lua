if WAR.tmp[1]==nil then
--return
--WE_move(1,5,5)
--WAR.Person[1]["����"]=true

WE_addperson(4,25,25,3,false)
WE_addperson(3,25,25,1,true)
--WE_sort()
WarDrawMap(0);
ShowScreen();
--WAR.Person[0]["�ҷ�"]=false
WE_atk(3,1,-1,55)
lib.Delay(200)
WE_atk(0,-1,1,55,10)
WAR.tmp[1]=1
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