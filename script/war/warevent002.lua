--�����ھ�����
if WAR.tmp[1]==nil then
	local num=0;
	for i=0,WAR.PersonNum-1 do
		if not WAR.Person[i]["�ҷ�"] then
			if not WAR.Person[i]["����"] then
				num=num+1;
			end
		end
	end
	if num<4 then
		lib.Delay(500);
		Dark();
		WE_addperson(27,26,27,2,900,false);
		WAR.CurID=WAR.PersonNum-1;
		WarDrawMap(0);
		Light();
		say("��ô���£�Ϊʲô��û����������",27);
		if WAR.Person[WE_getwarid(35)]["����"] then
			say("ʦ������֪����������ҰС�ӣ��������ڵ��ң�",45);
		else
			say("ʦ������֪����������ҰС�ӣ��������ڵ��ң�",35);
		end
		say("�������ļһ",27);
		WAR.tmp[1]=1;
	end
end
