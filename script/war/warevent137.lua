local function f1()	--ս��ǰ�Ի�
	local dfbb=WE_getwarid(27)
	local zj=WE_getwarid(0)
	local ylt=WE_getwarid(270)
	say("���ܣ����˭һ�����ˣ�",27,0)
	say("������ˣ��Ҳ�������������Ҫɱ�ҡ������ܲ�����һ�������",270,4)
	say("��˭�����󵨣��������㣿������������� ",27,0)
	say("�������ܣ�����װ���𣿡�",0,1)
	say("���������ˣ����ܣ��㡭���㡭����ô�ˣ��Ǹ�����������",27,0)
	WE_follow(27,270)
	say("�۵�������ֻ�Ƕ����ȹǣ���Ҫ���ģ�����ĺ����������̸���Ӻá�",27,0)
	say("��е�ǰ�������������������ʲô�����ܴ򷢵��˵��ˣ��ٸ������Ȳ��٣�",270,4)
	say("�ǣ��ǣ��������������ʹ������ǡ�",27,0)
	WE_xiaoshi(27)
	WE_xiaoshi(270)
	WE_chuxian(27,22,19)
	WE_chuxian(270,17,18)
	WAR.Person[ylt]["AI"]=3
	say("�ÿ��������",0,1)
	WAR.tmp[1]=1
	return
end

local function f2()
	if WE_close(0,270,2) and JY.Person[270]["����"]>0 then
		say("�㡭������쵰����������Զ�㣡",27,0)
		WAR.Person[WE_getwarid(27)]["Time"]=0
		WAR.tmp[2]=1
		return
	end
end

local function f3()
	if JY.Person[270]["����"]<JY.Person[270]["����"]/2 and JY.Person[270]["����"]>0 then
		say("���˺�����",27,0)
		WAR.Person[WE_getwarid[27]]["Time"]=0
		WAR.tmp[3]=1
		return
	end
end

local function f4()
	if JY.Person[270]["����"]<JY.Person[270]["����"]/4 and JY.Person[270]["����"]>0 then
		say("���ܣ�",27,0)
		WAR.Person[WE_getwarid[27]]["Time"]=0
		WAR.tmp[4]=1
		return
	end
end

local function f5()
	if WE_close(0,27,1) then
		say("�������ܣ���ϲ�������ˡ��������䡷�ϵ��书��",0,1)
		say("����˭��������˶���˵�������ӵ��治С��",27,0)
		say("����ü�ж���Ҳ�ã���ǧ�����ĵĹ���Ҳ�ã���������ģ����а�Ůװ���ϵ�����",0,1)
		say("�����㣬����˭��",27,0)
		local name=JY.Person[0]["����"]
		say("�ҽ�"..name.."��",0,1)
		say("���������"..name.."�����������һ�������������������ɣ�",27,0)
		WAR.Person[WE_getwarid(27)]["Time"]=1000		
		WAR.tmp[5]=1
		return
	end
end


local function f6()
	if JY.Person[270]["����"]<=0 then
		say("�㡭����úݶ������Һ�����ƴ�ˣ�",27,0)
		local dfbb=WE_getwarid(27)
		WAR.Person[dfbb]["Time"]=1000
		WAR.Person[dfbb]["AI"]=4
		WAR.tmp[6]=1
		return
	end
end


local function f7()
	if WAR.tmp[6]==1 and WAR.Person[WE_getwarid(27)]["Time"]>600 then
		say("���ܣ������Ͼ�������ȥ���㣡",27,0)
		WAR.Person[WE_getwarid(27)]["Time"]=1000
		return
	end
end


if WAR.tmp[1]==nil then
	f1()
end
if WAR.tmp[6]==nil then
	f6()
end
if WAR.tmp[4]==nil then
	f4()
end
if WAR.tmp[3]==nil then
	f3()
end
if WAR.tmp[2]==nil then
	f2()
end
if WAR.tmp[5]==nil then
	f5()
end
if WAR.tmp[7]==nil then
	f7()
end













