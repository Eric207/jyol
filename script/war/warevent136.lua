say("��ʦ����������ʲôʱ��Ž�ͽ�����հ������ÿ�춼�Ǵ�����������",0,1)
say("���ҽ���ÿ����������������������ҵ��������ڹ����ȶ����Ժ�ѧ�佫��������棡",68,0)
say("������Ҫ����ʲô�̶ȣ������ܽ���ȫ�潣���أ�",0,1)
say("��Ҳ�գ�����ͼ򵥵Ľ������С�����ܿ�ͻ�֪��������ÿ�������ڹ����ô���",68,0)
say("��лʦ��",0,1)
say("��������Ҫѧ���ƶ������������ƶ������������",68,0)
local firstmove=0
local cid=WE_getwarid(0)
WAR.CurID=cid
while firstmove==0 do
	WAR.Person[cid]["�ƶ�����"]=3
	 
    local menu={ {"�ƶ�",War_MoveMenu,1},
                 {"����",War_FightMenu,0},
                 {"�ö�",War_PoisonMenu,0},
                 {"�ⶾ",War_DecPoisonMenu,0},
                 {"ҽ��",War_DoctorMenu,0},
                 {"��Ʒ",War_ThingMenu,1},
                 {"�ȴ�",War_WaitMenu,0},
                 {"״̬",War_StatusMenu,1},
                 {"��Ϣ",War_RestMenu,1},
                 {"�Զ�",War_AutoMenu,0},   };

    

    lib.GetKey();
    Cls();
    ShowMenu(menu,10,0,CC.MainMenuX,CC.MainMenuY,0,0,1,0,CC.DefaultFont,C_ORANGE,C_WHITE);
	
	if WE_close(0,68) then
		say("���ܺã��������Ѿ�ѧ�����ƶ��������ҽ���ȫ�潣����������ʽ",68,0)
		firstmove=1
	elseif Rnd(10)>7 then
		say("����û���𣿲�Ҫ�ż��������ƶ������������Ժ��Ṧ�����ˣ��ƶ��ٶȾ��ܱ�졣",68,0)	
	end
	
end
		say("���������㿴��ϸ�ˣ�",68,0)
		WE_atk(68,1,0,39,10)
		say("��ʦ�������Ľ���̫���ˣ�ͽ��û����",0,1)
		say("���ã����ٶ���ʾ���飡",68,0)
		WE_atk(68,1,0,39,10)
		lib.Delay(100)
		WE_atk(68,1,1,39,10)
		lib.Delay(100)
		WE_atk(68,0,1,39,10)
		lib.Delay(100)
		WE_atk(68,-1,1,39,10)
		lib.Delay(100)
		WE_atk(68,-1,0,39,10)
		lib.Delay(100)
		WE_atk(68,-1,-1,39,10)
		lib.Delay(100)
		WE_atk(68,0,-1,39,10)
		lib.Delay(100)
		WE_atk(68,1,-1,39,10)
		lib.Delay(100)
		say("���������������ԡ�",68,0)
		say("����",0,1)
		WE_atk(0,1,0,39)
		say("���ף����",0,1)
		WE_atk(0,1,0,39)
		WE_atk(0,1,0,39)
		say("��ʦ����Ϊʲô������ʹ���ã�",0,1)
		say("���������ϳ��书����Ҫ�����������������������Ϊ����������Ȼ�޷�ʹ���⾫��Ľ���",68,0)
		say("��Ŷ���ѹ�ʦ��һֱ���Ҵ���������",0,1)
		say("�����ǣ���֪�书�ڹ�Ϊ�壬��ʽΪ�á�������������ң�ʲô������ʽ�������ô����к��ˣ�����͵���ɡ�",68,0)
		local qcj=WE_getwarid(68)
		WAR.Person[qcj]["����"]=true
		return 1