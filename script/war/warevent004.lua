--����ϴ��
if WAR.tmp[1]==nil then
	if JY.Person[113]["����"]/JY.Person[113]["�������ֵ"]<1 then
		say("ʦ�壬ʦ�ֵ���Ӧ�����������ǣ����Ҫ���˶�þͻ���Ԯ��");
		--AddPersonAttrib(113,"����",500000);
		--War_AddPersonLevel(113,true)--false); 
		WAR.tmp[1]=1;
	end
end
if WAR.tmp[2]==nil then
	WAR.tmp[2]=1;
elseif WAR.tmp[2]==-1 then
	
elseif WAR.tmp[2]<10 then
	WAR.tmp[2]=WAR.tmp[2]+1;
elseif JY.Person[113]["����"]<=0 then
		lib.Delay(500);
		Dark();
		WE_addperson(120,46,30,2,900,true);
		WE_addperson(121,48,31,2,800,true);
		WE_addperson(122,46,32,2,700,true);
		WE_addperson(123,48,33,2,600,true);
		WE_addperson(124,46,34,2,500,true);
		WE_addperson(125,48,29,2,400,true);
		WE_addperson(126,46,28,2,300,true);
		WE_addperson(127,48,27,2,200,true);
		WAR.CurID=WAR.PersonNum-1;
		WarDrawMap(0);
		Light();
		say("ʦ�壬�����ҵ����ˣ�",120);
	WAR.tmp[2]=-1;
end
