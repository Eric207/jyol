function Query(pid)
	say("������ʲô��",pid);
	local str="";
	str=Shurufa();
	if str=="" then
		say("ûʲô���ʵĻ����Ǿ����˰ɡ�",pid);
	else
		if JY.Name[str]==nil then
			say("��û����˵��"..str.."���������ʱ��˰ɡ�",pid);
		else
			local id=JY.Name[str];
			if id==pid then
				say("����û��ʲô�ر���˵�ġ�",pid);
				DayPass(1);
				return;
			end
			local n=JY.Person[pid]["�Ѻ�"]/30;
			n=n+JY.Person[pid]["����"];
			if JY.Person[pid]["����"]==JY.Person[id]["����"] then
				n=n+2;
			end
			n= math.modf(n);
			if n>1 then
				n=Rnd(n);
			end
			local talk="";
			if n>4 and JY.Person[id]["����"]>=0 and JY.Person[id]["�⹦1"]>0 and JY.Person[id]["����"]>=0 then
				talk=string.format("%sʦ��%s���ó�%s������Ӧ����%s�ɣ�������Ҫ������",JY.Person[id]["����"],JY.Shop[JY.Person[id]["����"]]["����"],JY.Wugong[JY.Person[id]["�⹦1"]]["����"],JY.Scene[JY.Person[id]["����"]]["����"]);
			elseif n>3 and JY.Person[id]["�⹦1"]>0 and JY.Person[id]["����"]>=0 then
				talk=string.format("%sʦ��%s���ó�%s��",JY.Person[id]["����"],JY.Shop[JY.Person[id]["����"]]["����"],JY.Wugong[JY.Person[id]["�⹦1"]]["����"]);
			
			elseif n>2 and JY.Person[id]["����"]>=0 then
				talk=string.format("%sʦ��%s���������ʶ��",JY.Person[id]["����"],JY.Shop[JY.Person[id]["����"]]["����"]);
			
			elseif n>1 then
				talk=string.format("��Ҳ��ʶ%s�𣿡�",JY.Person[id]["����"]);
			
			elseif n>0 then
				talk=string.format("%s������֪����",JY.Person[id]["����"]);
			
			else
				talk="û��˵��";
			end
			say(talk,pid);
		end
	end
end
function RandomEvent(pid)
	local notalk=false;
	DayPass(1);
	if JY.Person[pid]["�Ѻ�"]<40 and math.random(100)>50+JY.Person[pid]["�Ѻ�"] then
		local T=	{
							"�ҽ����е��£�ûʱ�����졣",
							"��ȥ�ұ����İɡ�",
							"�ú����������������¡�",
							"�����е㲻���㣬�����",
							"�Һ���ûʲô���ĵġ�",
						};
		say(T[math.random(5)],pid);
		notalk=true;
	else
		local flag=true;
		if flag and (type(PersonEvent[pid])=="function") then
			flag=PersonEvent[pid](pid);
		end
		if flag and (JY.Person[0]["����"]==JY.Person[pid]["����"] and type(ForceEvent[JY.Person[pid]["����"]])=="function") then
			flag=ForceEvent[JY.Person[pid]["����"]](pid);
		end
		if flag and (JY.Person[0]["����"]<0 or JY.Person[0]["����"]~=JY.Person[pid]["����"]) then
			flag=CommenEvent(pid);
		end
		if flag then
			for ci,cv in pairs(PE.talk) do
				if cv.trigger()==1 then
					cv.go();
					flag=false;
					break;
				end
			end
		end
		if flag and (type(PersonTalk[pid])=="function" and Rnd(10)<18) then
			flag=PersonTalk[pid](pid);
		end
		if flag and (JY.Person[0]["����"]==JY.Person[pid]["����"] and type(ForceTalk[JY.Person[pid]["����"]])=="function" and Rnd(10)<17) then
			flag=ForceTalk[JY.Person[pid]["����"]](pid);
		end
		if flag then--and (JY.Person[0]["����"]<0 or JY.Person[0]["����"]~=JY.Person[pid]["����"]) then
			flag=CommenTalk(pid);
		end
		if flag then
			say("���ã�",pid);
		end
	end
	if not notalk then
		if JY.Person[pid]["�Ѻ�"]<40 and math.random(100)<100-JY.Person[pid]["�Ѻ�"] then
			JY.Person[pid]["�Ѻ�"]=JY.Person[pid]["�Ѻ�"]+1+Rnd(2);
		end
	end
end
function RandomTalk(talk)
	local num=math.random(talk[0]);
	local str=talk[num];
	for i=1,999,2 do
		if str[i]<0 then
			break;
		end
		say(str[i+1],str[i]);
	end
	return false;
end
function CommenEvent(pid)
	if GetFlag(1)-GetFlag(5000+pid)>30 then
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
function CommenTalk(pid)
	--���˵��
	local talk={
						[0]=100,
						{pid,"�������书����Ȼ�������������Ӳ����������ھ������������ࡣ",-1},
						{pid,"�츳������Ȼû��ֱ���ô�������ȴ��������һ������߳ɾ͡�",-1},
						{pid,"�츳�ٺã���Ŭ��Ҳһ���ǰ׷ѡ�",-1},
						{pid,"�����ߵ�������ʮ�㡣",-1},
						{pid,"���Ǹߵ�������ǿ����",-1},
						{pid,"�����ߵ��˷�Ӧ����",-1},
						{pid,"�����ߵ����ʺ�������ҹ���һ����ʮ�ᡣ",-1},
						{pid,"���Ǹߵ���Ӧ�������ڼҹ���������ǧ�",-1},
						{pid,"�����ߵ���Ӧ��ѧ���ɵĹ�����֪�����书��Ψ�첻�ơ�",-1},
						{pid,"���ʸߵ��˾��Ǻð���ѧʲô���졣",-1},
						
						{pid,"��Ե�ߵ��ˣ��������Ǻð�����������������",-1},
						{pid,"�ڹ�����ʽҲ������ϵģ���������ʵĻ���������±������ء�",-1},
						{pid,"�е��˺þƣ��е��˺öģ��е��˺ô�ܡ�",-1},
						{pid,"�е��˺��٣��е��˺��壬�е��˺��飬�е��˺û���",-1},
						{pid,"�����ھֿ��ǽ�������һ�����Ĵ��ھְ���ֻ��......",-1},
						{pid,"�����黭ʫ�ƻ�������������������",-1},
						{pid,"��ɽ�ɾ��ӽ������ŵ�����ǫǫ���ӡ�",-1},
						{pid,"��Ѫ���ģ���֪������û����˵����",-1},
						{pid,"�ഫ��˳�ڴ���Ѿ����������ˡ�",-1},
						{pid,"�����������ĸ��ֵĹ�����",-1},
						
						{pid,"�ഫ������������һ���ж�����ܵ��ˣ����ǿ��������ְ���",-1},
						{pid,"Ϊʲô������֪����ȭ��������ô�࣬����ȴ��ô���أ�",-1},
						{pid,"��˵����Ƥ�������ͷ�Ͽ��Ա任��Ŀ����װ���ˡ�",-1},
						{pid,"��ν�⹦�ߣ���ר���վ��������۲��ȡ����ֹ����������࣬���������ˡ�",-1},
						{pid,"�ڹ���ר���ᾢ��������Ĥ���Գ�ȫ���䲻�������ˣ���������¯�����ʱ�򣬲���ȭ�Ų���������������õ�����������ʹ����������õ�����������ʹ������",-1},
						{pid,"����һ�������������Ƥ��",-1},
						{pid,"�ڹ�Ϊ����֮�壬�⹦Ϊ����֮�á�",-1},
						{pid,"���֪Ԧ��������ᡢ�顢���������֡�",-1},
						{pid,"���֪�����ļɣ���ɮ�����������档�����������ò�����ˣ�ȴ���������������ɲ⡣",-1},
						{pid,"���������ǽ����ڻ�������֮�⡣",-1},
						
						{pid,"����ϴ����������������ʱ���е�һ����ʽ��ϴ����˫�ֲ���ʢ����ˮ�Ľ��裬���Ĵӽ��Ժ���Ҳ����ȭ�������������������е��ǷǶ�Թ����ʽ��������ͬ����Ħ��֤��ϴ�����е�����Ϊһ��ɱ�����飬���������������������е��ǿ��������е����ַ������ʸ־�˳����У������Ժã�����ȫ����",-1},
						{pid,"̩ɽ�ɴ�ʼ��ʦ����������������̽�һ�����Ǻ��������˵����",-1},
						{pid,"��˵������ڳ��������ĦԢֹ����ɽ�����£����������������ĬȻ���޾��ꡣ",-1},
						{pid,"�������֡�������һ���⹦���ˣ������ܻ���һ���������������ĵط�����������š�",-1},
						{pid,"�����ֵȹ����ɣ�ȫ����Ե�ǹ���룻��ֻ���������⣬����������˷��֣������ַ�һ�����书���ϡ�",-1},
						{pid,"�������������߽������ᣬ����ǰ�뽫���ߵ���������һ˿���ҡ�",-1},
						{pid,"��ɽ������֮һ���ų�������������ʡ�����������ϣ��б���ǧ��֮�ơ�",-1},
						{pid,"��ɽ������֮һ��λ�ں���ʡ��������ʱ�ơ��ⷽ��������ʱ�ơ��Ըߡ���������������ɽ����̫��ɽ������ɽ��ɡ�",-1},
						{pid,"��ɽ������֮һ���ų�������λ�ں���ʡ��������ï������������̣��滨��ݣ���ʱƮ�㣬������С��������㡹�����ơ�",-1},
						{pid,"��ɽ������֮һ���ųƱ�����λ��ɽ��ʡ��ɽ��������ɽ��������⣬����̫�У��������ţ���������������ƴ���������������",-1},
						
						{pid,"̩ɽ������֮�ף��ųƶ�������ɽ��ʡ�в����С����µ�һɽ��֮��������ǧ�������Ⱥ���ʮ��λ�ʵ���̩ɽ�������� ��",-1},
						{pid,"��˵���������������ʥҩ��",-1},
						{pid,"������Ͻ���ʦ������������ʦ����������Ŷ��",-1},
						{pid,"�������������......��",-1},
						{pid,"��ɽ��������������ҩ������������������ڷ��İ����ܵ��衣",-1},
						{pid,"ؤ��ɳ����µ�һ�����˵��ӱ鼰���¡�",-1},
						{pid,"���������Ĵ���������֪������˵��û�С�",-1},
						{pid,"�ഫ��ɽ֮��������֮�أ�����Ϊ��ɽѩ�����滨��",-1},
						{pid,"����˭ѽ��",0,"......",pid,"�������ҿ���Ц��~",-1},
						{pid,"�����书һ��Ҫѭ�򽥽������ǿ���������������߻���ħ�ġ�",-1},
						
						{pid,"�����������ĸ��ֵĸ�����",-1},
						{pid,"�������ɹ���һ����죬��Ϊ����ɫ���졹�����������������������",-1},
						{pid,"�ഫ�ô�ѩɽ�ϵ��ڲϲ�˿������֯��һ�������£����Ϻ�ǹ���롣",-1},
						{pid,"����ָ�����Ƕ�ü�����ŵ��ŷ����˸�����ʦ�����ָ���ڿ��С�������Ů�����֡�",-1},
						{pid,"������������һ����˿�ף����Ƿ�������������������ǹ���롢ˮ���ˣ�Ϊ�����˿�ף��Ա���ɱ÷����������������ʿΪ֮�Ѫ��",-1},
						{pid,"��˵�����þ�������һ���޺����Ǹ�֮��װ�л�����Ť������֮���ܶԲ�һ������ȭ����",-1},
						{pid,"�����ຮ֮�أ������ɼ��֮���ڳ��ĺ����������ڹ��ļ��ù��ߡ�",-1},
						{pid,"�п쵽�����Ʒ�������ֵ�ʱ���ˡ�",-1},
						{pid,"�ݴ�˵�����������һ���������ϳ���ʱ�����Ѫ��в���ᣬ����ǧ�",-1},
						{pid,"����ѩɽ֮�����������ѩ�룬�����о��ѱ��ڴ�С��ȫ�����ƺ�����䣬ɫ�����ޣ�������������֮һ��",-1},
						
						{pid,"�������м�����˹���ߣ���������������⣬ͷ����������ǣ�������磬���Ѳ�׽��",-1},
						{pid,"���ش�ѩɽ��һ�ֹ������״�������ƣ��������࣬�������д糤��ë����ǹ���롣",-1},
						{pid,"�ٽ�������һ���������̵Ļ�ɽ����������һ�����ɽ��ʱ���緢��",-1},
						{pid,"���ɽ���Ĵ�ʡ���س����ϣ�ɽ����ǣ������������ɽ�����岻���������Ϊ��һ�߷塣ɽ���а˴󶴣���ʮ��С�����羰������",-1},
						{pid,"���������Ƕ������ԣ���Ϊ�����ݡ���",-1},
						{pid,"éɽλ�ڽ��վ����ض��ϣ���������ɽ������éӯ���������ܵ�é�̡�é�Եõ������ڴˣ�������é�������ɽ��Իéɽ�������éɽ��",-1},
						{pid,"ն������λ�����ϴ���������һ���ĵ�����Լһ����а��ɡ�",-1},
						{pid,"���͵�λ���Ϻ������½������ĺ��̣���ʮ�������������ָ���ǰ�����͵�������һ�˻ػ���",-1},
						{pid,"����ɽ´��һ���ȵ�����Ϊ���˹ȣ����ڶ����缯��������",-1},
						{pid,"��üɽ���Ĵ�ʡ��ü�����ϡ�ɽ����ΰ����ɽ��������ü��������",-1},
						
						{pid,"Ұ����������һ�������Ļ���֮�ء�",-1},
						{pid,"�ɶ������϶˲�����һ���죬���϶��߱�أ�ǧ��������һֱ��������ǰ��̽�գ������Ϊ���ء�",-1},
						{pid,"¥���˺�ʱ������ǹ�֮һ����ʱ���з������վ���ɳʯ����",-1},
						{pid,"�Ż�ɽλ�ڰ���ʡ�ϲ��������������ϣ�����ʱ���ء��������ء�",-1},
						{pid,"�Ż����ɵĵ��Ӽ��٣����ٸ��ٳ��ֽ��������ǹ������λ����ʫ�Ʒ�������ף���˵��λ������ʿ������ʫ�ɣ�Ҳ�ǽ��ɣ��Ż����ɵĽ�����������һ���ഫ�ġ�",-1},
						{pid,"����ɽ�����������ɵĸ��ݵأ��ڴ�ɽ����֮�Ͻ��н�������Ϊ�������ӵĴ�Ӫ��",-1},
						{pid,"���յ�Ϳ�в�ʯ���ǳ������������ķ羰�ż�������ʮ����߰������Ӵ󽭣����������Ϫ������ʷ�������Ǳ��ұ���֮�ء�",-1},
						{pid,"�㽭������Ǯ����������ɽ����������Ϊ����������۰˽�ʮ���㣬��Ϊ�߲㣬��Լ60�ס�",-1},
						{pid,"��Ĺ����ʦ�ֳ�Ӣ��ס��Ĺ���Ȳ�͸�����������µ��书��Ǳ��˼���������ġ���Ů�ľ���һ��һʽ��Ϊȫ�����书�Ŀ��ǡ�",-1},
						{pid,"�����ۻ롢�����������ͻ��ķ���������",-1},
						
						{pid,"������Ҳ����ն�������˻�֮Ҳ��",-1},
						{pid,"���Ǿ������壬����������ʹ��",-1},
						{pid,"������ǹ�Ĺ�ɵĶ��Ű���������ϸ��ë���Ľ��룬���ɻƽ��ĳɾ��֣������β���϶�Һ��������ȻϸС������ƽ���أ�����ʱ�Կɼ�Զ��",-1},
						{pid,"�򹷰�ϵؤ�������������ഫ֮��ʵ����ͣ�������Ө���ȵ���Լ��һ�ߡ����ִ˰�֮�ˣ���Ϊ������������д���֮�ˣ������˵ȱ�����Է��ӡ����Դ򹷰���ʹ�����У��������",-1},
						{pid,"���������ǡ��������ӡ���Ī����ʹ�����������ο̻��ƣ����쾫�¡�����綾�ޱȣ�һ�����ж���Ƥ��ȫ�ɺ�ɫ����������Ƥ������̱�Ҫɥ����",-1},
						{pid,"���������������˿��ȡ���ߵ������ز�ɺ�����Ƴ�ɺ������ȣ��������ж�������ʯ�����޻���",-1},
						{pid,"���佣�����䵱�ɴ�ʼ֮����彣������ʱ����ɨ��Ⱥа�����𽭺�����������ʹ�á�",-1},
						{pid,"������ɢ��֮һ��������˵��Ǭ��һ���������Դ��ܵС��˴��ܲ�ͨ�磬���������˿�ǸѰ������������ơ�",-1},
						{pid,"�ഫԽ��ռ�����԰����ţ������֮�񣬴�����ɽ�������������ϣ��ɾ�����ұ�˽��������ա���ˮ��ת�ǡ����塢������ꡢȴа����հ˴�������",-1},
						{pid,"���Ǻ�����Ѱ���������죬�������֦�ɶ�������֦���������������߸�СС�ĻƵ㡣",-1},
						
						{pid,"�ഫ����Χ��������ٸ�����ɽ��һ������������һ�ٶ�ʮ�ţ���ɱ�ô�ܣ���ʱŻѪ�������˳���λ��̫��Ϊ��ɽ���ѡ�������ž�����ʵ�ǳ������ܵ����׳�Ż�ס�",-1},
						{pid,"���Ὣ��ʫ����Ϊ�ƴ����������顣���������С��������飬�鷨��С�����̡����ݡ�б���仯��ˣ���������ʷ�����������",-1},
						{pid,"���������䣬�������֮�����Ƴ�¶���󻨰꣬������ͷ����ң��д�������",-1},
						{pid,"Ϫɽ����ͼ�Ǳ����������ҷ���Ĵ���֮����",-1},
						{pid,"���������Ĵ���֣���а�����ϵ۱�ؤ��",-1},
						{pid,"��а���ǻ�ҩʦ����ʹ���｣����",-1},
						{pid,"����ŷ���棬��󡹦����һ����",-1},
						{pid,"�ϵۼҴ���ѧһ��ָ�������ˡ�",-1},
						{pid,"��ؤ���߹�����ʮ���Ƹ�����˫��",-1},
						{pid,"������ͨ������������ɽ�۽�������ѹ��а�����ϵ۱�ؤ���������µ�һ",-1},
						
						{pid,"�����������ĸ��ֵĸ�����",-1},
						{pid,"�����������ĸ��ֵĸ�����",-1},
						{pid,"�����������ĸ��ֵĸ�����",-1},
						{pid,"�����������ĸ��ֵĸ�����",-1},
						{pid,"�����������ĸ��ֵĸ�����",-1},
						{pid,"�����������ĸ��ֵĸ�����",-1},
						{pid,"�����������ĸ��ֵĸ�����",-1},
						{pid,"�����������ĸ��ֵĸ�����",-1},
						{pid,"�����������ĸ��ֵĸ�����",-1},
						{pid,"�����������ĸ��ֵĸ�����",-1},
					};
	RandomTalk(talk);
	say("......ԭ����˰�");
	return false;
end
ForceEvent[0]=function(pid)	--��ɽ
	--ÿ�˵��¼���һ�����һ��
	if GetFlag(1)-GetFlag(5000+pid)>30 and JY.Person[0]["����"]==0 then
		if math.random(100)<10 then
			NPCQiecuo(pid);
			return false;
		end
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
		if GetFlag(1)-JY.Shop[0]["����ʱ��"]>30 and GetFlag(10001)==0 then	--Ѱ������ɺ
			say("Сʦ����ô��û��������",pid);
			say("Сʦ�ã�����ô��û������");
			say("Сʦ�úͶ�ʦ��ȥ�����ˣ���ʱ���㻹û������ɽ������û������",pid)
			say("ԭ����ˡ�")
			say("ʦ��������书Ҳ�������������������£�����ȥ���ݴ�̽��Сʦ������ɺ�Ͷ�ʦ���͵�ŵ����Ϣ",pid);
			say("�ã��Ҽ�����̡�")
			SetFlag(10001,1);
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
ForceTalk[0]=function(pid)	--��ɽ
	--���˵��
	local talk={
						[0]=14,
						{pid,"ʦ�����Ź�����ˣ��������챻��ץסʹ�",-1},
						{pid,"��˵�һ�ɽ�ɼ�ʮ��ǰҲ�������������Ĵ��ɣ���ϧ�������ھ�Ȼ���䵽ֻ������֮һ�ˡ�",
							0,"Ϊʲô�أ�",
							pid,"��˵���꣬�һ�ɽ��ʷ�Ϊ������֧������Ů��ǰһ����ս�������ǣȰ�ѽ������ɲ�����˵�ˣ�Ҫ�Ǳ�ʦ�������ˣ��ҿɳԲ�����",-1},
						{pid,"ʦ���������������в�ϰ�ߵ���",0,"һ�ж��á�",-1},
						{pid,"�ڻ�ɽһ�ж��ã�����ʦ��̫�����ˡ�",-1},
						{pid,"ʦ�������ĺܺá�",-1},
						{pid,"��ʦ���Ⱦ���������Ҫ�ǵ���ʲô�þƣ��ǵý��ϴ�ʦ�ְ���",-1},
						{pid,"���ǻ�ɽ�Ź���ϵģ�����ò�Ҫ����",-1},
						{pid,"Ҫ�Ƿ��˴����п���ȥ��ɽ˼������ڣ�����������ˡ�",-1},
						{pid,"�����ǻ�ɽ�����˶�ϡ�٣��뵱�����ǿ��������䵱�����Ĵ��ɰ���",-1},
						{pid,"��Ů���ʯ����Ư������֪�����Ժ��˵�ģ���ܵġ�",-1},
						{pid,"Ī��Ϊʦ��Ů��֮��㽿��������ʵ���������书����ʦ��֮��Ŷ��",-1},
						{pid,"Сʦ�ò�����Ư��������ҲƯ������˵�������ʹ�ʦ�ֺϴ���һ�Ž�����",-1},
						{pid,"��˵�⡰�����á�����ǰ�ǽб�����֣���֪����ʲô��",-1},
						{pid,"���ǻ�ɽ���˶�������ʲôʦ��ʦ���Ķ�û�У�����֡�",-1},
					};
	RandomTalk(talk);
	return false;
end
ForceEvent[1]=function(pid)	--���
	--ÿ�˵��¼���һ�����һ��
	if GetFlag(1)-GetFlag(5000+pid)>30 and JY.Person[0]["����"]==1 then
		if math.random(100)<10 then
			NPCQiecuo(pid);
			return false;
		end
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
ForceTalk[1]=function(pid)	--���
	--���˵��
	local talk={
						[0]=7,
						{pid,"�����ӵģ�����ʦ�ֹ�Ҥ���ֲ������ǡ���",-1},
						{pid,"��˵�����������һ�ž�ѧ�д����ƣ���һ�������ϴ�������������й�ϵ��",-1},
						{pid,"�����������Ȼ�ǵ�ʿ��ȴ�ǻ�ӵ�ʿ�����������ŵģ��벻���ɣ�������",-1},
						{pid,"��˵��������ɺ�ȫ��̵��𴦻��е��ϵ����֪�����Ǽ١�",-1},
						{pid,"����������ڽ����ϴ���������ܶ��ھֶ�Ҫ�������Ϲ��ء�",-1},
						{pid,"��ʦ��ƽʱ���ף���������ʦ�ֵ�ʱ��Ƣ���ܺ��ˡ�",-1},
						{pid,"����Ǯû���Ƚ����Ұɡ�",-1},
					};
	RandomTalk(talk);
	return false;
end
ForceEvent[2]=function(pid)	--��ɽ
	--ÿ�˵��¼���һ�����һ��
	if GetFlag(1)-GetFlag(5000+pid)>30 and JY.Person[0]["����"]==2 then
		if math.random(100)<10 then
			NPCQiecuo(pid);
			return false;
		end
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
ForceTalk[2]=function(pid)	--��ɽ
	--���˵��
	local talk={
						[0]=8,
						{pid,"���Ǻ�ɽ�ɺܶ��˶�ϲ�����֣�����ѡ��ʲô������",-1},
						{pid,"���Ǻ�ɽ������һ�ŷǳ������Ľ�������������ɽ���񽣡�����ϧʧ���ˡ�",-1},
						{pid,"���ŵĺ������÷ǳ��ã���ϧ�����������޳�������ʵ�����ˡ�",-1},
						{pid,"�����ħ��һ����ս�����Ǻ�ɽ����ʧ�ܴ󡣵���ʦ����ͻ��ᣬ����ܶ��书��ʧ���ˡ�",-1},
						{pid,"��ʦ���������ϵ�����ǳ����Ҫ���пգ����Զ�������",-1},
						{pid,"��ʦ���Ů���ǳ�Ư���أ������û��",-1},
						{pid,"��˵��ʦ�徭����ȥ�����������֣����ȥ��û��",-1},
						{pid,"��˵�ϴ��и���Ư����С��������ʦ�帮�����ͣ������û��",-1},
					};
	RandomTalk(talk);
	return false;
end
ForceEvent[3]=function(pid)	--̩ɽ
	--ÿ�˵��¼���һ�����һ��
	if GetFlag(1)-GetFlag(5000+pid)>30 and JY.Person[0]["����"]==3 then
		if math.random(100)<10 then
			NPCQiecuo(pid);
			return false;
		end
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
ForceTalk[3]=function(pid)	--̩ɽ
	--���˵��
	local talk={
						[0]=8,
						{pid,"���������ֵ�����������ʶ����ô���ˣ��㻹û������ء�",-1},
						{pid,"�㲻֪���ɣ����ǻ�������ʦ�����أ�����ƽʱ���������ˡ�",-1},
						{pid,"��˵����ʦ���������ţ�����ʦ���治������ء�",-1},
						{pid,"������λʦ������ʲô�Ը�����û�����ʦ������һ��Ϊ���",-1},
						{pid,"ʦ����Ƣ���Ƚϡ����Ǹ��������ң�ǧ�����ʦ����������",-1},
						{pid,"��Ҫ��û�£�ȥɽ��Ϫ�������ң�Ҳ�����ҵ���ζ�ĳ����㡣",-1},
						{pid,"����̩ɽ�����������ײˡ�������ˮ��",-1},
						{pid,"ʦ����ϲ���Էʳ����ˣ���Ҫ�ǳ��ţ����Դ��������˳����Ҵ��㶫ƽ����ʲô�ġ���",-1},
						{pid,"��˵����̩ɽ�ɵ�����һ�н����ھ����֣���ϧʧ���ˡ���",-1},
					};
	RandomTalk(talk);
	return false;
end
ForceEvent[5]=function(pid)	--��ɽ
	--ÿ�˵��¼���һ�����һ��
	if GetFlag(1)-GetFlag(5000+pid)>30 and JY.Person[0]["����"]==5 then
		if math.random(100)<10 then
			NPCQiecuo(pid);
			return false;
		end
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
ForceTalk[5]=function(pid)	--��ɽ
	--���˵��
	local talk={
						[0]=11,
						{pid,"���ֺ�����ʮ���޺����䵱�����������߽أ�ȴ��ֻ�ǿ��󷨣���������ɽ�ɵ�ʮ��̫��ȴ�������ܶ���һ�档",-1},
						{pid,"����Ҫ�ú���������ȡ�ܰ���ʦ����",-1},
						{pid,"���ǵ�ʦ���������ֵ�һ�ˡ�",-1},
						{pid,"��˭��ʤ���������ţ��������ʣ���Ȼ��ʦ����",-1},
						{pid,"��˵���ֺõ�ʦ�ֵܣ��л�����ʦ����ʶ���ô�ʦ��������ѧ�أ�",-1},
						{pid,"��˵���ֺõ�ʦ�ֵܣ��л����ü�λʦ�����ʶ���ô����ǵĶ�����ѧ�أ�",-1},
						{pid,"��ɽ�������һ��Ϊ��������Ϊ�塣",-1},
						{pid,"̩ɽ���ű��ֲ��ߣ��л��ɳˡ�",-1},
						{pid,"��ɽ������ɥ־��������͡�",-1},
						{pid,"��ɽŮ�ᣬҲ������ƹŷ�",-1},
						{pid,"������ɽ����Ϊ��������������Ϊ�������������ֵ����ġ�",-1},
					};
	RandomTalk(talk);
	return false;
end
ForceTalk[9]=function(pid)	--ؤ��
	--���˵��
	local talk={
						[0]=6,
						{pid,"����ؤ��������µ�һ��",-1},
						{pid,"�书������ǿ���壬���Ǿ�����������ɱ°�ӣ������治Ӧ�á�",-1},
						{pid,"ؤ�����˸�����Ǵ�Ӣ�ۣ���Ҳ��ʧӢ�����š�",-1},
						{pid,"ÿ�ξۻ�������ͣ�������������������",-1},
						{pid,"�����ǰ���ֻҪ�������������л���ѧ���õ��书��",-1},
						{pid,"�Ұ����˱����������壬��Ҫ��Ϊ���˶����ǵı��Ӷ��Ա�����",-1},
					};
	RandomTalk(talk);
	return false;
end
--�㲻��ؤ����ˣ���������������������
--��������Ӻ�������Ͷ�����ˣ�Ҫ��������ؤ����������ȥ����Ҳ�и���Ӧ�����˲Ų����۸��㡣 �������������ؤ�ϣ�������������ҡ�  ������˵أ��������֡�
--���뱾�ﲻ�ѣ����������ذ�棬�����������
--���Ͽ��Խ��ҵ��书�����𣿲�Ȼ��ȥ���������һ����¡� �ã�����ͽ����书������Ժúüǵá�
--����ո�ѧ������ӣ��������˵�ʲô���Ұ��㰲���д�Ķ��󣬻�����԰��������Щȱ��
ForceTalk[14]=function(pid)	--ȫ���
	--���˵��
	local talk={
						[0]=17,
						{pid,"ȫ����������ֵ��ϵ��������ڣ���֮��Դ���������Ǳ������Լ�ά��������֮�ϣ�����ʱ�ᱻ���ʦ�ŵġ�",-1},
						{pid,"��˵������Ĺ�ﳣ�а���Ů�����ϱ�����ץ�����������ÿ���ѽ��",-1},
						{pid,"���ϵ�ʱ���ɽ���������ǲ���ȥ�ˣ������Ӱ��......��Ҫ���ĲŻ���ȥ�أ�",-1},
						{pid,"��˵����ɽ֮ǰ��һλ�����Ϊ�������������������������ϵ��Ծ��������Ǹ�����ʱ���ĳ��ֹ��......",-1},
						{pid,"�ƽ�����˵�ˣ��ô�������Ĺ���صĵ���һ�������سͷ������������",-1},
						{pid,"̫ʦ���ֳ�ȥ�����ˣ����²�֪����һ�����Ż������",-1},
						{pid,"�ľ����������ԣ�δ������ȴ�������Ը����޴�ҩ�������޸������ˡ�",-1},
						{pid,"����֮�࣬��Ҫ���˶����������֮����",-1},
						{pid,"�������š���������������֪�����������ǲ�����������أ�",-1},
						{pid,"����ɽ������ģ�����Ʒ��̫�����������ǲ���ӭ�ġ�",-1},
						{pid,"���̵Ļ����������˱����壬��Ϊ���������ϵı��־��ǡ��������õ��߱��ܳ��������Բ�Ҫʵ����������һ����",-1},
						{pid,"ȫ��̻���һ�����������š�����ͯ������̫ʦ���棬���������˼Ҳ�֪������������ȥ�ˡ�",-1},
						{pid,"��������Ϊ���ɳ�������������һЩ����֮�󣬿���ȥ�����ǵ�ʦ��ʦ���ǡ�",-1},
						{pid,"�����۶��Ʒ�����ʦү���������Ѫ����֮�Ʒ����������ˣ���Ҫ�ú�����ѧ��",-1},
						{pid,"�������Ϊ��ʦү�߾���������֮�󷨣������Ҫ�󷨷������Ч����������������飬�Ŷ�Ĭ�����Ǻ���Ҫ�ģ�",-1},
						{pid,"��ȫ������������ɣ����Ե��Ӷ�Ҫ�����Ժã�����Ϊ��������",-1},
						{pid,"�ǵΣ�ȫ���֮�书��һ��һϦ�Ϳ����ɣ���ɵö��õ��ģ���Ḭ̄�졣�����򲻴�ĵ�����ö��ɣ�",-1},
					};
	RandomTalk(talk);
	return false;
end
--¹���� ���ң��ҿ���æ�ú��أ�  �Һ÷��գ��������ң�  �ֻ�û��ʱ��Է������Ҹ�ʲô��
ForceEvent[99]=function(pid)	--BAK
	--ÿ�˵��¼���һ�����һ��
	if GetFlag(1)-GetFlag(5000+pid)>30 and JY.Person[0]["����"]==99 then
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
ForceTalk[99]=function(pid)	--BAK
	--���˵��
	local talk={
						[0]=5,
						{pid,"ʦ�������ĺܺá�",-1},
						{pid,"ʦ��ʹ�����ֽ����ƺ�������û�м����ء�",-1},
						{pid,"ʦ�����ֺ��书�ָߣ�����ʦ������ٳ���",-1},
						{pid,"ʦ���ƺ���ϲ�����˳���Ϊ����Ů������",-1},
						{pid,"ʦ���������һ���չ����ǣ����Լ�סǧ��Ҫ�����������ĵ��°���",-1},
					};
	RandomTalk(talk);
	return false;
end

PersonEvent[1]=function(pid)	--����Ⱥ
	local hasQuest=false;
	for i,v in pairs(MyQuest) do
		if pid==7000+10*(i-1) then
			hasQuest=true;
		end
	end
	--ÿ�˵��¼���һ�����һ��
	if hasQuest==false and GetFlag(1)-GetFlag(5000+pid)>30 then
		if MyQuest[1]==nil and math.random(100)<10 then
			QuestEvent[1](pid);
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
		if MyQuest[2]==nil and math.random(90)<10 then
			QuestEvent[2](pid);
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
		if math.random(80)<10 then
			KaochaKungfu(pid);
			return false;
		end
		if JY.Person[0]["�ȼ�"]>5 and GetFlag(10017)==0 then
			say("�һ�ɽ���������ʶ�Ķ��֣�������Ͼ����ȥ����ʦ����̣���ض����Ժ�ϰ��Ҳ���������档",pid);
			SetFlag(10017,1);
			SetFlag(5000+pid,GetFlag(1));
			if GetFlag(10003)==0 then
				SetFlag(10003,1);
			end
			return false;
		end
		if false then	--����¼���ʽ
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
PersonTalk[1]=function(pid)	--����Ⱥ
	--���˵��
	local talk={
						[0]=5,
						{pid,"�һ�ɽ����������ּ�ǡ��˲����ң��Ҳ����ˡ������˸�ħ��������ͷ֮�⣬�������и��Ÿ��ɾ�������϶��",-1},
						{pid,"�����׽���ʦ���棬�����𳤡�������ǿ�����������޹������������ɫ����Ϸ��Ů���Ľ�ͬ�ż��ʣ������ɱ�����������壬͵�Բ�����佾���Դ󣬵���ͬ�����߽��Ľ����࣬������а��",-1},
						{pid,"���ɲ�������������������������ɡ���ֻ��ú������߽䣬ʱʱ�ǵ�����Ϊ�ȣ��������˾��ӣ�ʦ��ʦ��ͻ�ϲ�ú��ˡ�",-1},
						{pid,"����֮�У�����նࡣ�Һ���ʦ��������Ĵ��������ۼ�������̥�������⣬���ձ��д��ѣ�����ʵ�ǲ�����",-1},
						{pid,"��ɽһ�ɹ���Ҫ������һ���������֣�����һ�ɣ�����ʹȭ��Ҳ�ã�������Ҳ�ã��㶼���������������Ǳ���������;��",-1},
					};
	RandomTalk(talk);
	return false;
end
PersonEvent[2]=function(pid)	--������
	local hasQuest=false;
	for i,v in pairs(MyQuest) do
		if pid==7000+10*(i-1) then
			hasQuest=true;
		end
	end
	--ÿ�˵��¼���һ�����һ��
	if hasQuest==false and GetFlag(1)-GetFlag(5000+pid)>30 then
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
PersonTalk[2]=function(pid)	--������
	--���˵��
	local talk={
						[0]=3,
						{pid,"��ʦ��ƽ�չ���Ͻ���Ҳ��������������;��",-1},
						{pid,"��ʦ����ʲô����",-1},
						{pid,"�ָ��˴�������ˣ�������ɫ�����ѿ����˵��ز��أ�",-1},
					};
	RandomTalk(talk);
	return false;
end
PersonEvent[14]=function(pid)	--����ɺ
	local hasQuest=false;
	for i,v in pairs(MyQuest) do
		if pid==7000+10*(i-1) then
			hasQuest=true;
		end
	end
	--ÿ�˵��¼���һ�����һ��
	if hasQuest==false and GetFlag(1)-GetFlag(5000+pid)>30 then
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
		if JY.Person[pid]["�Ѻ�"]>50 and GetFlag(10002)==0 then	--����������Ů����
			say("Сʦ�ã�Ϊʲô���õ��书�Ҵ���ûѧ���أ�");
			say("����������������ҵ���Ů����Ŷ��ֻ���Һ�����ᣬ������ûѧ���ء�",pid);
			say("��ѧ�𣿿����ʦ����������",pid);
			local menu={
									{"ʦ��",nil,1},
									{"ʦ��",nil,2},
								};
			local r=ShowMenu(menu,2,0,0,0,0,0,1,0);
			if r==1 then
				say("ʦ��....");
				say("�Ǻǣ���ԡ�����̫���ˣ�����������������ѧ�ɡ�",pid);
				SetFlag(10002,1);
				SetFlag(5000+pid,GetFlag(1)-20);
			elseif r==2 then
				say("Сʦ�ã�����Ц��");
				say("˭���㿪��Ц�ˣ���ѧ������",pid);
				SetFlag(5000+pid,GetFlag(1));
			end
			return false;
		end
		if GetFlag(10002)==1 and Getkflv(0,3)>5 then	--����������
			say("ʦ�㣬��Ů�����ﻹ�м����Ҳ�̫�ᣬ�ٽ̽��Ұ�");
			say("�Ǹ�����Ҳ����....",pid);
			say("Ҫ����ȥ������ɡ�",pid);
			SetFlag(5000+pid,GetFlag(1));
			SetFlag(10002,2);
			if GetFlag(10003)==0 then
				SetFlag(10003,1);
			end
			return false;
		end
		if GetFlag(10002)==1 and math.random(100)<30 then	--������Ů����
			say("ʦ�㣬�����ܽ��ҽ�����");
			say("�ð�",pid);
			local kflist={
								{2,10},
								{3,6},
							};
			LearnKF(0,pid,kflist);
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
PersonTalk[14]=function(pid)	--����ɺ
	--���˵��
	local talk={
						[0]=3,
						{pid,"Сʦ�ܣ������ʦ����������",-1},
						{pid,"Сʦ�ܣ�����ʦ�����ὣ�ɡ�",-1},
						{pid,"Сʦ�ܣ����п�����ʦ����",-1},
					};
	RandomTalk(talk);
	return false;
end
PersonEvent[27]=function(pid)	--��׺�
	local hasQuest=false;
	for i,v in pairs(MyQuest) do
		if pid==7000+10*(i-1) then
			hasQuest=true;
		end
	end
	--ÿ�˵��¼���һ�����һ��
	if hasQuest==false and GetFlag(1)-GetFlag(5000+pid)>30 then
		if GetFlag(1)-JY.Shop[1]["����ʱ��"]+GetFlag(11001)>30 and GetFlag(11002)==0 then	--����¼���ʽ
			say("������ʦ�泤����һ���˽ܣ���ϧ......",pid);
			say("ʦ��������ʦ������ô���ģ�");
			say("������ʦ������Ӣ�ۣ��������������һ�������������ȴ��������Զͼ�ı�а����֮��",pid);
			say("����Զͼ��ʲô���������������");
			say("������Զͼ����ʮ��·��а�����������˸����ھ֣������Ǵ��ڵ��޵��֣��׵��ϵ�Ӣ�ۼ���̫�����磬Ҳ��ȥ�������Եģ���ʦ�浱����Ƕ����������������ա�",pid);
			say("��Զͼ�������ھ֣�Ī�������Զͼ�������ڸ����ھ�����ͷ�����ϵĸ��ף�");
			say("������Զͼ�������ϵ��游��",pid);
			say("�������㣬�����Ϲ�����Σ�",pid);
			say("�����ϵ��˶�˵�����ϳ��ֺ���������������˶���ȥ�������ڡ����������ǵĹ�����Σ��򲻵ö�֪��");
			say("�������ڸ����ھ��������һ���Ǽɵ����ҵ���ʮ��·��а������һ��ȴ�Ǻڰ������������ӡ��ߣ��������ϳ��ֺ���ȷʵ���٣���Щ�꣬���궼�����������������",pid);
			say("������ʦ����������ھֵ���Զͼ����������������ô���գ�");
			say("������Щ�꣬�����궼�ǽ������֮���⡣���ǣ������������ȴ���ˣ����֪��Ϊ��ʲô��",pid);
			say("���......������³����ʦ����ʾ��");
			say("��Ϊ......��Ҫ�������ھ���������ɱ����Ȯ������",pid);
			say("������");
			say("���ȼ�����������԰����ģ�Ȼ�����Ի���Ϊ���������ʦ��ȥ���ݡ���Ϊ����ʵ��Ҫ�������š�",pid);
			say("�������ھֱ�а�����������������ʦ�涼���Ƕ��֣����������......");
			say("�ߣ��ող����ʹ����������书�����",pid);
			say("���......");
			say("�������п������������ӱ�а���������ҿ������⽣��ƽƽ���棡",pid);
			say("ƽƽ���棿Ȼ���Ǽٵģ�");
			say("��Ȼ�����ҿ��������⽣�����а��ֻ�����������ʴ������޷���͸��",pid);
			say("ʦ������μ�ȻҪ���������ھ����ţ��β�ϸ��Ѱ�ң������ҵ���ǰ�����µĽ��ף���������񲻾������������ˣ�");
			say("���ǣ�����͸Ͻ�����ȥ���ݰɣ��úú���ʦ����Ѱ�ҽ��׵����䣡",pid);
			say("�ǣ�");
			say("�����������ھֱϾ��˶����ڣ��㵥��һ��̫��Σ�ա����ҽ�����������֮��а�����������㣬�պ�ս֮ʱҲ������׼��",pid);
			say("лʦ����");
			SetFlag(11002,1);
			SetFlag(11003,1);
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
		if math.random(80)<10 then
			KaochaKungfu(pid);
			return false;
		end
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
PersonTalk[27]=function(pid)	--��׺�
	--���˵��
	local talk={
						[0]=4,
						{pid,"������ʦ�泤����һ���˽ܣ���ϧ......",-1},
						{pid,"��а�������ߣ�",-1},
						{pid,"�����ھ֣��ߣ�",-1},
						{pid,"�����ϰ������ϡ�",-1},
					};
	RandomTalk(talk);
	return false;
end
PersonEvent[49]=function(pid)	--Ī��
	local hasQuest=false;
	for i,v in pairs(MyQuest) do
		if pid==7000+10*(i-1) then
			hasQuest=true;
		end
	end
	--ÿ�˵��¼���һ�����һ��
	if hasQuest==false and GetFlag(1)-GetFlag(5000+pid)>30 then
		if MyQuest[1]==nil and math.random(100)<10 then
			QuestEvent[1](pid);
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
		if MyQuest[2]==nil and math.random(90)<10 then
			QuestEvent[2](pid);
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
		if math.random(80)<10 then
			KaochaKungfu(pid);
			return false;
		end
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
PersonTalk[49]=function(pid)	--Ī��
	--���˵��
	local talk={
						[0]=6,
						{pid,"�������ϸǣ�ܽ�أ�ʯ����ף��......",-1},
						{pid,"����ϰ�֣�",-1},
						{pid,"����δ��ֻɱ�ˡ��֣�δ��ֻ������",-1},
						{pid,"����δ�ز�а��а��δ�ز�����",-1},
						{pid,"��ɽ��ߣ�ȴ�������",-1},
						{pid,"���������ʦ����",-1},
					};
	RandomTalk(talk);
	return false;
end
PersonEvent[66]=function(pid)	--����
	local hasQuest=false;
	for i,v in pairs(MyQuest) do
		if pid==7000+10*(i-1) then
			hasQuest=true;
		end
	end
	--ÿ�˵��¼���һ�����һ��
	if hasQuest==false and GetFlag(1)-GetFlag(5000+pid)>30 then
		if MyQuest[1]==nil and math.random(100)<10 then
			QuestEvent[1](pid);
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
		if MyQuest[2]==nil and math.random(90)<10 then
			QuestEvent[2](pid);
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
		if math.random(80)<10 then
			KaochaKungfu(pid);
			return false;
		end
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
PersonTalk[66]=function(pid)	--����
	--���˵��
	local talk={
						[0]=5,
						{pid,"��̩ɽ������Դ�ڵ�ɽ֮·��",-1},
						{pid,"�ε���ǧ�ɣ�����ʮ���̡�",-1},
						{pid,"ȥ��ʦ�����㡣",-1},
						{pid,"����ʦ��Ϊ�δ�λ���ң�ȴ�ֲ�......���ǳ�������𰡡�",-1},
						{pid,"�Ǽ�����ƥ��......",-1},
					};
	RandomTalk(talk);
	return false;
end
PersonEvent[110]=function(pid)	--������
	local hasQuest=false;
	for i,v in pairs(MyQuest) do
		if pid==7000+10*(i-1) then
			hasQuest=true;
		end
	end
	--ÿ�˵��¼���һ�����һ��
	if hasQuest==false and GetFlag(1)-GetFlag(5000+pid)>30 then
		if MyQuest[1]==nil and math.random(100)<10 then
			QuestEvent[1](pid);
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
		if MyQuest[2]==nil and math.random(90)<10 then
			QuestEvent[2](pid);
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
		if math.random(80)<10 then
			KaochaKungfu(pid);
			return false;
		end
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
PersonTalk[110]=function(pid)	--������
	--���˵��
	local talk={
						[0]=5,
						{pid,"��������......������......�ߣ�",-1},
						{pid,"�����������ֱ�������Ҳֻ����ɽһ����ѡ�",-1},
						{pid,"�䵱�������˶������£�������ӣ�ͽ���������ѡ�",-1},
						{pid,"���Ƕ������ܿ��������޵У�����ħ��ȴ�ս�ʽ΢���ɼ����վ�ֻ�Ǹ������ѡ�",-1},
						{pid,"���������Ṳ����ʤ�۷�֮����",-1},
					};
	RandomTalk(talk);
	return false;
end
PersonEvent[131]=function(pid)	--��Ӣ��
	local hasQuest=false;
	for i,v in pairs(MyQuest) do
		if pid==7000+10*(i-1) then
			hasQuest=true;
		end
	end
	--ÿ�˵��¼���һ�����һ��
	if hasQuest==false and GetFlag(1)-GetFlag(5000+pid)>30 then
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
PersonTalk[131]=function(pid)	--��Ӣ��
	local talk={
						[0]=5,
						{pid,"����ʦ���۲�ΰ�ԣ���Ҳ��ú�Ŭ�������ɸ���ʦ��֮����",-1},
						{pid,"��������֮�գ��������ִ�ϴ��֮ʱ��",-1},
						{pid,"�������ˣ������ɧ��������ɮ���¸����ء�ȴ���Ƿ���֮�ˣ����������������ĺ���ѡ��",-1},
						{pid,"��֪��λʦ��֮�У��ɻ�˳����",-1},
						{pid,"���������������£�����������ʦ�ֵ�������",-1},
					};
	RandomTalk(talk);
	return false;
end
PersonEvent[196]=function(pid)	--����
	local hasQuest=false;
	for i,v in pairs(MyQuest) do
		if pid==7000+10*(i-1) then
			hasQuest=true;
		end
	end
	--ÿ�˵��¼���һ�����һ��
	if hasQuest==false and GetFlag(1)-GetFlag(5000+pid)>30 then
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
PersonTalk[196]=function(pid)	--����
	--���˵��
	local talk={
						[0]=10,
						{pid,"ӳ�Ż�ˮ�̣����������ġ�����������������ҹҹ�",-1},
						{pid,"�����죬���������´巼��Զ��б���ӻ��ɡ�",-1},
						{pid,"�³���⣬ٮ�����⣻���Ծ��⣬�������⣡",-1},
						{pid,"���������뾡����Īʹ���׿ն��¡������Ҳű����ã�ǧ��ɢ����������",-1},
						{pid,"����ݳ�ͤ·��������������ȥ��",-1},
						{pid,"���ȼ��Ϣ����ս����ʱ��Ұս����������������챯��������˳�������Ϲҿ���֦��ʿ��Ϳ��ç�������ն�Ϊ����֪������������ʥ�˲����Ѷ���֮��",-1},
						{pid,"����ˮ���軨�ף��Ĺ�������֦�죬��ȹ��������ʶ�����²軨��·����",-1},
						{pid,"��֪�Ӷ�֮���ߣ���Ŀ��Ҳ����ʶ���֮���ߣ�������Ҳ������֮�ģ��˽���֮��",-1},
						{pid,"���Ե�������Ե���ҷ��ɳ�ţ���������˵��",-1},
						{pid,"��ʧ��Ե������������",-1},
					};
	RandomTalk(talk);
	return false;
end
PersonEvent[9999]=function(pid)	--BAK
	local hasQuest=false;
	for i,v in pairs(MyQuest) do
		if pid==7000+10*(i-1) then
			hasQuest=true;
		end
	end
	--ÿ�˵��¼���һ�����һ��
	if hasQuest==false and GetFlag(1)-GetFlag(5000+pid)>30 then
		if false then	--����¼���ʽ
			
			SetFlag(5000+pid,GetFlag(1));
			return false;
		end
	end
	return true;
end
PersonTalk[9999]=function(pid)	--BAK
	--���˵��
	local talk={
						[0]=5,
						{pid,"ʦ�������ĺܺá�",-1},
						{pid,"ʦ�������ĺܺá�",-1},
						{pid,"ʦ�������ĺܺá�",-1},
						{pid,"ʦ�������ĺܺá�",-1},
						{pid,"ʦ�������ĺܺá�",-1},
					};
	RandomTalk(talk);
	return false;
end

function DayPass(n,d)
	if n<1 then
		return;
	end
	d=d or 0;
	local now=GetFlag(1);
	local num=DelayEvent.num;
	for i=1,n do
		if d<0 and JY.SubScene>=0 and JY.Person[0]["����"]<20 then
			say("��������ܣ����ܼ����ȥ�ˡ�");
			return false;
		end
		if d>0 then
			for c=1,d do
				AddPersonAttrib(0,"����",1);
				getkey();
				DrawState();
				ShowScreen();
				lib.Delay(CC.Frame);
			end
		elseif d<0 then
			for c=1,-d do
				AddPersonAttrib(0,"����",-1);
				getkey();
				DrawState();
				ShowScreen();
				lib.Delay(CC.Frame);
			end
		end
		SetFlag(1,now+i);
		--AddPersonAttrib(0,"����",d);
		for ii,v in pairs(TimeEvent) do
			if v.triggrt() then
				if v.kind==0 then
					v.kind=-1;
					num=num+1;
					DelayEvent[num]=v;
				elseif v.kind==1 then
					v.go();
					return false;
				elseif v.kind==2 then
					v.go();
				end
			end
		end
	end
		--Cls(0,0,400,100);
	DelayEvent.num=num;
	return true;
end

TimeEvent[1]={--NPC������Ȼ����
							kind=2,	-- -1,��ʱ�ر�,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											local t=GetFlag(1);
											if t%30==0 then
												return true;
											end
											return false;
										end,
							go=	function()
										--DrawStrBoxWaitKey("NPC������Ȼ����",C_WHITE,CC.Fontbig);
										for i=1,CC.ToalPersonNum do
											if not inteam(i) then
												local p=JY.Person[i];
												AddPersonAttrib(i,"����",math.modf(p["�ȼ�"]*5000/(120-p["����"])*(100+smagic(i,58,1))/100));
												War_AddPersonLevel(i,false); 
											end
										end
										return;
									end,
							
						};
TimeEvent[2]=	{--���ɱ���
							kind=0,
							triggrt=	function()
											local t=GetFlag(1);
											if t%360==0 then
												return true;
											end
											return false;
										end,
							go=	function()
										if JY.Person[0]["����"]<0 then
											return;
										end
										if JY.SubScene==JY.Shop[JY.Person[0]["����"]]["�ݵ�"] then
											Dark();
											Light();
											say("����պ������ɱ���������أ�Ҫȥ�μ���");
											if DrawStrBoxYesNo(-1,-1,"�Ƿ�μ����ɱ��䣿",C_WHITE,CC.Fontbig) then
												say("�������ʤһ�����ң�");
												Dark();
												local pid=1;
												if JY.SubScene==27 then
													JY.Base["��X1"],JY.Base["��Y1"]=16,26;
													JY.Base["�˷���"]=2;
													pid=110;
												elseif JY.SubScene==29 then
													JY.Base["��X1"],JY.Base["��Y1"]=22,27;
													JY.Base["�˷���"]=2;
													pid=66;
												elseif JY.SubScene==36 then
													JY.Base["��X1"],JY.Base["��Y1"]=28,21;
													JY.Base["�˷���"]=0;
													pid=27;
												elseif JY.SubScene==57 then
													JY.Base["��X1"],JY.Base["��Y1"]=23,28;
													JY.Base["�˷���"]=2;
													pid=1;
												elseif JY.SubScene==58 then
													JY.Base["��X1"],JY.Base["��Y1"]=28,16;
													JY.Base["�˷���"]=0;
													pid=49;
												else
												
												end
												JY.MyPic=GetMyPic();
												Light();
												say("������һ��һ�ȵ�"..JY.Shop[JY.Person[0]["����"]]["����"].."�����ᣬ���Ҫ�ú�Ŭ����",pid);
												E_kungfugame(JY.Person[0]["����"],pid);
												return;
											end
										end
										StrTalk=function()
											DrawStrCenter("��"..JY.Shop[JY.Person[0]["����"]]["����"].."�׾��������ɱ���",CC.Fontbig);
											ShowScreen();
											WaitKey();
											say_2("û�ܲμ����ϧ�������´�Ӧ�û��л���ġ�");
										end
										ShowStrTalk();
										--
										--Dark();
										--lib.Delay(200);
										--DrawStrCenter("��"..JY.Shop[JY.Person[0]["����"]]["����"].."�׾��������ɱ���",CC.Fontbig);
										--ShowScreen();
										--WaitKey();
										--say("û�ܲμ����ϧ�������´�Ӧ�û��л���ġ�");
										--Cls();
										--Light();
									end,
						}
TimeEvent[3]={--Ѱ������ɺ
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(10001)==2 then
												TimeEvent[3]=nil;
												return false;
											end
											if GetFlag(1)-GetFlag(2)>90 then
												return true;
											end
											return false;
										end,
							go=	function()
										ModifyD(1,20,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
										ModifyD(1,22,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
										ModifyD(1,2,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
										ModifyD(1,11,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
										ModifyD(1,12,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
										ModifyD(1,13,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
										ModifyD(1,14,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
										--����ɺ,�͵�ŵ�ػ�ɽ
										JY.Person[9]["����"]=0;
										JY.Person[14]["����"]=0;
										ModifyD(57,28,1,-2,5,14,-1,4259*2,4259*2,4259*2,-2,-2,-2);
										ModifyD(57,29,1,-2,5,9,-1,5180,5180,5180,-2,-2,-2);
										SetFlag(10001,2);	--Ѱ������ɺOK
										SetFlag(11002,2);
										SetFlag(16001,1);	--���������ھ�����
										SetFlag(16002,GetFlag(1));
										StrTalk=function()
											DrawStrCenter("���ݣ�����ɵ����������Ϸ��ɽ����Ⱥ֮Ů����ɺ��Ϊ�����ھ�����ͷ��ƽ֮��ɱ��",CC.Fontbig);
											ShowScreen();
											WaitKey();
											if JY.Person[0]["����"]==0 then
												say_2("��˵Сʦ���Ѿ��ػ�ɽ�ˣ�ȥ����һ�°ɡ�");
												say_2("����������������๼���Ǹ����ھֵ�С�ӵ��ǲ���ֻ��������ƴ󣬴��¿��²�����ô�򵥾ͽ����ɡ�");
											elseif JY.Person[0]["����"]==1 then
												say_2("�����ھ֣��ҿ������ǻ�Ĳ��ͷ��ˣ�");
											else
												say_2("����������������๼���Ǹ����ھֵ�С�ӵ��ǲ���ֻ��������ƴ󣬴��¿��²�����ô�򵥾ͽ����ɡ�");
											end
										end
										ShowStrTalk();
										return;
									end
							
						};
TimeEvent[4]={--�����ھ�����
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(16001)==2 then
												TimeEvent[4]=nil;
												return false;
											end
											if GetFlag(16001)==1 and GetFlag(1)-GetFlag(16002)>30 then
												return true;
											end
											return false;
										end,
							go=	function()
										ModifyD(56,0,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
										ModifyD(56,1,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
										ModifyD(56,2,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
										ModifyD(56,3,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
										ModifyD(56,6,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
										ModifyD(56,7,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
										ModifyD(56,8,0,0,0,0,0,0,0,0,0,-2,-2);
										ModifyD(56,9,0,0,0,0,0,0,0,0,0,-2,-2);
										SetFlag(16001,2);
										StrTalk=function()
											DrawStrCenter("���ݣ������������׺�Ϊ����ƽ֮ɱͽ֮�𣬴������˽������ھ����š�",CC.Fontbig);
											ShowScreen();
											WaitKey();
											if JY.Person[0]["����"]==1 then
												say_2("����Ǻ�����������Ե��³�����ϧ������Ҫ�£�δ�����Ա���");
											else
												say_2("����ɵ��ֶΣ�Ҳδ��̫������һЩ�ɡ�");
											end
										end
										ShowStrTalk();
										return;
									end
							
						};
TimeEvent[5]={--����¥
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(10004)~=0 then
												TimeEvent[5]=nil;
												return false;
											end
											if GetFlag(1)-GetFlag(2)>180 then
												return true;
											end
											return false;
										end,
							go=	function()
										ModifyD(38,10,0,-2,0,0,-2,0,0,0,0,-2,-2);
										SetFlag(10004,2);
										StrTalk=function()
											DrawStrCenter("����������¥����ɽ���������������ﲮ��ͬ��������̩ɽ�ɳٰٳǼ����ɵ���ɱ�ﲮ�ⲻ�ɣ���Ϊ����������ɵ������˽ܵ�ҲΪ�������ɱ����˵��ɽ�������պ��������һ��",CC.Fontbig);
											ShowScreen();
											WaitKey();
											if JY.Person[0]["����"]==0 then
												say_2("��������һ�ɽ��ͽ����ô����ﲮ�����һ���ˣ����±������顣");
											elseif JY.Person[0]["����"]==1 then
												say_2("����壡��ύ�����ﲮ�⣬��ɱ��ʦ�֣��ҵ�Ҫ�������ܲ��񵽼�ʱ��");
											elseif JY.Person[0]["����"]==3 then
												say_2("�ø�����壬ͬΪ�������ɣ���Ȼ�����ﲮ���Ƕ�������ʦ���䲻����������ɱ��ȴҲ���㲻�ã�");
											elseif JY.Person[0]["����"]==4 then
												say_2("����ʦ�㣬ϣ����û�²źá�");
											end
										end
										ShowStrTalk();
										return;
									end
							
						};
TimeEvent[6]={--ϴ��
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(12005)>1 then
												TimeEvent[6]=nil;
												return false;
											end
											if GetFlag(1)-GetFlag(2)>360 then
												return true;
											end
											return false;
										end,
							go=	function()
										ModifyD(58,12,-2,-2,-2,-2,-2,-2,-2,-2,-2,26,3);
										SetFlag(12005,2);
										SetFlag(12006,2);
										StrTalk=function()
											DrawStrCenter("��ɽ�����������ϴ�ִ�ᡣ��ɽ�ɷѱ���˴��������������¶�������繴��ħ�������������ı��������������ɹ��ؽ���һ���򾡡�������ֵ��ǣ��º�ѱ�ȴ����ر���ɱ����",CC.Fontbig);
											ShowScreen();
											WaitKey();
											if JY.Person[0]["����"]==2 then
												say_2("�벻��ʦ������Ȼ��ύħ������......");
											elseif JY.Person[0]["����"]==5 then
												say_2("������������㣬��ʶ������ȴ���ı��ֻ�Ƿ�ʦ��֮����ȴʵ����֣�Ī���Ǳ���ɽ���ְ����˲��ɣ�");
											else
												say_2("��������һ���ӣ�ȴ������ø�������������ħ��ʵ�ں��˲�ǳ����");
											end
										end
										ShowStrTalk();
										return;
									end
							
						};
TimeEvent[7]={--Ī��ɱ�ѱ�
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(12006)>0 then
												TimeEvent[7]=nil;
												return false;
											end
											if GetFlag(12005)==2 then
												return true;
											end
											return false;
										end,
							go=	function()
										SetFlag(12006,2);
										StrTalk=function()
											DrawStrCenter("��ɽ����ɽ���ַѱ�����ر���ɱ����",CC.Fontbig);
											ShowScreen();
											WaitKey();
											if JY.Person[0]["����"]==5 then
												say_2("��ʦ��֮����ʵ����֣�Ī���Ǳ���ɽ���ְ����˲��ɣ�");
											else
												say_2("�ѱ��书��ǿ��˭��ɱ�������أ�");
											end
										end
										ShowStrTalk();
										return;
									end
							
						};
TimeEvent[8]={--�����Ͻ��
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(16003)>0 then
												TimeEvent[8]=nil;
												return false;
											end
											if GetFlag(12006)==2 and Rnd(5)==1 then
												return true;
											end
											return false;
										end,
							go=	function()
										SetFlag(16003,5);
										SetFlag(16004,GetFlag(1));	--��¼����������ʱ��
										--SetS(57,27,29,3,201);	--������ɽ��ƽ֮��ʦ���������¼�
										StrTalk=function()
											DrawStrCenter("��ɽ���⣬�����Ϸ򸾱���ɱ����������ƽ֮���뻪ɽ������Ⱥ����Ϊͽ��",CC.Fontbig);
											ShowScreen();
											WaitKey();
											if JY.Person[0]["����"]==0 then
												say_2("ʦ��������һ�����Ӱ���");
											elseif JY.Person[0]["����"]==1 then
												say_2("�����ϣ����úã�ʦ�ֵĳ����Ǳ���һ���ˡ����и���ƽ֮���ߣ������㻪ɽ�ɣ�");
											else
												say_2("��ƽ֮Ҳ�ֿ����ġ�");
											end
										end
										ShowStrTalk();
										return;
									end
							
						};
TimeEvent[9]={--��������
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(10005)>0 then
												TimeEvent[9]=nil;
												return false;
											end
											if GetFlag(16003)>0 and GetFlag(1)-GetFlag(16004)>50 then
												return true;
											end
											return false;
										end,
							go=	function()
										SetFlag(10005,1)
										--SetS(57,27,29,3,-1);	--�رջ�ɽ��ƽ֮��ʦ���������¼�
										StrTalk=function()
											DrawStrCenter("��ɽ�������ã�����Ⱥ���컪ɽ�ȱ�����ʽ����ƽ֮Ϊͽ��ͬʱ�����������Υ����ɽ�Ź棬����˼�������һ�ꡣ",CC.Fontbig);
											ShowScreen();
											WaitKey();
											if JY.Person[0]["����"]==0 then
												say_2("ʦ��Ҳ̫�����˵㣬��ʦ����ȻΥ����һЩ�Ź飬�����ǳ��ں��ĵ�Ȩ��֮�ư���");
											elseif JY.Person[0]["����"]==1 then
												say_2("�������С�����ǻ�ã�ֻ������ƽ֮���Ѱ��뻪ɽ�����¾����Ѷ�������ˡ�");
											else
												say_2("��ɽ�������������ɣ��Ź���ϡ�");
											end
										end
										ShowStrTalk();
										return;
									end
							
						};
TimeEvent[10]={--��ɽ������ɽ
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(10007)>0 then
												TimeEvent[10]=nil;
												return false;
											end
											if GetFlag(16003)>0 and GetFlag(1)-GetFlag(16004)>150 then
												return true;
											end
											return false;
										end,
							go=	function()
										SetFlag(10007,1)
										SetFlag(10010,GetFlag(1));
										if JY.Person[0]["����"]==0 then
											StrTalk=function()
												DrawStrCenter("��ɽ������Ⱥ�����ڵ�����ɽ��Χ�˲ɻ��������ﲮ��",CC.Fontbig);
												ShowScreen();
												WaitKey();
												say_2("ʦ�֣������ҵ����ˡ�ʦ��������㲻�ػ�ɽ�����Ĵ���Ѱ�ﲮ������䡣",24);
												say_2("�ã�");
											end
											ShowStrTalk();
										end
										--������ʧ
										ModifyD(57,0,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,1);
										ModifyD(57,1,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,2);
										ModifyD(57,17,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,3);
										ModifyD(57,22,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,4);
										ModifyD(57,26,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,5);
										ModifyD(57,6,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,6);
										ModifyD(57,5,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,7);
										ModifyD(57,23,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,8);
										ModifyD(57,24,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,9);
										ModifyD(57,15,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,10);
										ModifyD(57,16,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,11);
										ModifyD(57,27,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,12);
										ModifyD(57,28,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,13);
										ModifyD(57,30,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,14);
										ModifyD(57,2,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,15);
										ModifyD(57,29,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,16);
										ModifyD(57,3,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,17);
										ModifyD(57,4,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,18);
										ModifyD(57,18,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,19);
										ModifyD(57,19,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,20);
										ModifyD(57,20,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,21);
										ModifyD(57,21,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,22);
										SetS(57,52,29,3,201);
										SetS(57,52,30,3,201);
										SetS(57,30,13,3,202);
										SetS(57,31,13,3,202);
										SetS(62,50,25,3,201);
										SetS(62,50,26,3,201);
										return;
									end
							
						};
TimeEvent[11]={--Χ���ﲮ��&��ɽ���ӻ�ɽ&Ԭ��־��ɽ
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(10011)>0 then
												TimeEvent[11]=nil;
												return false;
											end
											if GetFlag(10010)>0 and GetFlag(1)-GetFlag(10010)>42 then
												return true;
											end
											return false;
										end,
							go=	function()
										SetFlag(10011,1);
										SetFlag(10009,GetFlag(1));
										ModifyD(81,0,-2,-2,3,-2,-2,-2,-2,-2,-2,-2,-2);	--�޸��������
										StrTalk=function()
											DrawStrCenter("����Ⱥ�����ڵ��ӽ��������ﲮ��ϳ��˳����ؽ硣��ɽ������֮����һʱ��Ϊ���ޡ�",CC.Fontbig);
											ShowScreen();
											WaitKey();
											if JY.Person[0]["����"]==0 then
												say_2("�ﲮ���Ѿ����ˣ�ʦ�����Ҳ��ɽ�˰�");
											else
												say_2("�ﲮ�ⲻ���ǡ�������С�����Ȼ�ܴ�����Ⱥ�������ˡ�");
											end
										end
										ShowStrTalk();
										--���˳���
										ModifyD(57,0,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,29);
										ModifyD(57,1,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,28);
										ModifyD(57,17,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,27);
										ModifyD(57,22,-2,-2,-2,-2,-2,-2,-2,-2,-2,21,25);
										ModifyD(57,26,-2,-2,-2,-2,-2,-2,-2,-2,-2,21,13);
										ModifyD(57,6,-2,-2,-2,-2,-2,-2,-2,-2,-2,24,40);
										ModifyD(57,5,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,44);
										ModifyD(57,23,-2,-2,-2,-2,-2,-2,-2,-2,-2,27,28);
										ModifyD(57,24,-2,-2,-2,-2,-2,-2,-2,-2,-2,27,30);
										ModifyD(57,15,-2,-2,-2,-2,-2,-2,-2,-2,-2,30,37);
										ModifyD(57,16,-2,-2,-2,-2,-2,-2,-2,-2,-2,30,14);
										ModifyD(57,27,-2,-2,-2,-2,-2,-2,-2,-2,-2,40,36);
										ModifyD(57,28,-2,-2,-2,-2,-2,-2,-2,-2,-2,29,24);
										ModifyD(57,30,-2,-2,-2,-2,-2,-2,-2,-2,-2,30,25);
										ModifyD(57,2,-2,-2,-2,-2,-2,-2,-2,-2,-2,39,22);
										ModifyD(57,29,-2,-2,-2,-2,-2,-2,-2,-2,-2,38,13);
										ModifyD(57,3,-2,-2,-2,-2,-2,-2,-2,-2,-2,46,29);
										ModifyD(57,4,-2,-2,-2,-2,-2,-2,-2,-2,-2,46,30);
										ModifyD(57,18,-2,-2,-2,-2,-2,-2,-2,-2,-2,50,32);
										ModifyD(57,19,-2,-2,-2,-2,-2,-2,-2,-2,-2,50,27);
										ModifyD(57,20,-2,-2,-2,-2,-2,-2,-2,-2,-2,51,27);
										ModifyD(57,21,-2,-2,-2,-2,-2,-2,-2,-2,-2,51,32);
										SetS(57,52,29,3,-1);
										SetS(57,52,30,3,-1);
										SetS(57,30,13,3,-1);
										SetS(57,31,13,3,-1);
										SetS(62,50,25,3,-1);
										SetS(62,50,26,3,-1);
										return;
									end
							
						};
TimeEvent[12]={--���Vs��־
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(10013)>0 then
												TimeEvent[12]=nil;
												return false;
											end
											if GetFlag(10009)>0 and GetFlag(1)-GetFlag(10009)>120 then
												return true;
											end
											return false;
										end,
							go=	function()
										SetFlag(10013,2);
										ModifyD(81,0,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,1);	--�޸����
										SetFlag(10014,GetFlag(1)+20);
										if GetFlag(10012)==1 then
											StrTalk=function()
												say_2("��ѽ���ҰѴ�ʦ�ֺ�Ԭ��־�ıȽ��������ˣ�");
											end
											ShowStrTalk();
										end
										return;
									end
						};
TimeEvent[13]={--������ɽ
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(10015)>0 then
												TimeEvent[13]=nil;
												return false;
											end
											if GetFlag(10015)==0 and GetFlag(10014)>0 and GetFlag(1)-GetFlag(10014)>0 then
												return true;
											end
											return false;
										end,
							go=	function()
										SetFlag(10015,2);
										SetFlag(10016,2);
										TimeEvent[14]=nil;
										SetS(57,43,13,1,4323*2);
										SetS(62,9,21,1,4707*2);
										SetS(62,9,21,3,1);
										StrTalk=function()
											DrawStrCenter("��ɽ�����ڵ��ӡ��ⲻƽ����ɽ�ɵ�Э���£���������Ⱥ��������֮λ����Ц����ȴ������Ⱥ֮ͽ���������ܡ������ͬʱҲ�������ˣ�����ȫʧ��",CC.Fontbig);
											ShowScreen();
											WaitKey();
											if JY.Person[0]["����"]==0 then
												say_2("��ʦ�ֵ��书��ô��ô�����ˣ�");
											else
												say_2("��ô���ڵ��书��˲�������һ���������Ӷ����磿");
											end
										end
										ShowStrTalk();
										return;
									end
						};
TimeEvent[14]={--�������
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(10016)>0 then
												TimeEvent[14]=nil;
												return false;
											end
											if GetFlag(10016)==0 and GetFlag(10015)>0 then
												return true;
											end
											return false;
										end,
							go=	function()
										SetFlag(10016,1);
										SetS(57,43,13,1,4323*2);
										StrTalk=function()
											SetS(81,49,36,3,-1);
											DrawStrCenter("��ɽ������屻�����������ˣ�����ȫʧ��",CC.Fontbig);
											ShowScreen();
											WaitKey();
											if JY.Person[0]["����"]==0 then
												say_2("��ʦ�ֵ����Ʋ�֪������ˡ�");
											elseif JY.Person[0]["����"]==1 then
												say_2("�����������Ͳ���Ϊ���ˣ��´��������ϣ�����һ��ɱ�ˣ�");
											else
												say_2("�������ˣ���֪���Ǻε����");
											end
										end
										ShowStrTalk();
										return;
									end
						};
						
TimeEvent[15]={--���Ԫ֮��
							kind=0,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if GetFlag(19001)~=0 then
												TimeEvent[15]=nil;
												return false;
											end
											if GetFlag(1)-GetFlag(2)>380 and Rnd(10)==1 then
												return true;
											end
											return false;
										end,
							go=	function()
										SetFlag(19001,3);
										StrTalk=function()
											DrawStrCenter("�������ԣ�ؤ�����������������ѧ��ɱ�����ײ�����",CC.Fontbig);
											ShowScreen();
											WaitKey();
											if JY.Person[0]["����"]==9 then
												script_say("���ǣ���ʲô�����������Ȼ���������������ѧ��ɱ�����У���Ҫ����������������")
											else
												script_say("���ǣ���ؤ��������������������ɱ�����½�����Ҫ���˰�������")
											end
										end
										ShowStrTalk();
										return;
									end
							
						};
TimeEvent[35]={--NPC�����ƶ�
							kind=2,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											local t=GetFlag(1);
											if t%30==0 then
												return true;
											end
											return false;
										end,
							go=	function()
										PersonMove();
										return;
									end
							
						};
--��ʱ,�ȴ�daypass��һ�𴥷�
--����,����ֹͣdaypass,����
--��̨,daypassͬʱ����
TimeEvent[999]={--BAK
							kind=2,	--,0,��ʱ,1,����,2,��̨
							triggrt=	function()
											if false then
												return true;
											end
											return false;
										end,
							go=	function()
										
										return;
									end
							
						};

						
						
--MyQuest:nil/0δ����,1����						
QuestEvent[1]=function(pid)
	local oid=GetFlag(7000);
	if oid==0 then
		say("����˵������ħ������Ǳ�볤���ǡ�����һ����ħ���Ʋ����������Ը����ȥ��������һ�ˣ�",pid);
		if DrawStrBoxYesNo(-1,-1,"�Ƿ���ܣ�",C_WHITE,CC.Fontbig) then
			say("����ͳ�����");
			SetFlag(7000,pid);
			ModifyD(134,18,1,-2,100,147,-2,5888,5888,5888,0,-2,-2);
			MyQuest[1]=1;
		else
			say("�����õļһ",pid);
			AddPersonAttrib(pid,"�Ѻ�",-5);
			AddPerformance(-5);
		end
	elseif oid==pid then
		if MyQuest[1]==2 then
			say("���������ħ�������Ѿ����Ҹ����ˡ�");
			say("�ܺã������������˴�һ������",pid);
			local add,str=AddPersonAttrib(0,"��������",(4+JY.Person[0]["�ȼ�"])*5+200+math.random(50));
			DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
			AddPersonAttrib(pid,"�Ѻ�",1);
			AddPerformance(10);
			SetFlag(7000,0);
			MyQuest[1]=nil;
			return true;
		end
	end
	return false;
end
QuestEvent[2]=function(pid)
	local oid=GetFlag(7010);
	local p=	{
						{1,"��ɽ�ɵ�������","������"},
						{27,"�ɷ�۵������","��׺�"},
						{49,"��ɽ�ɵ�Ī������","Ī����"},
						{66,"̩ɽ�ɵ����ŵ���","���ŵ���"},
						{110,"��ɽ�ɵ���ʦ��","������"},
					}
	if oid==0 then
		local n;
		for i,v in pairs(p) do
			if pid==v[1] then
				n=i;
			end
		end
		while p[n][1]==pid do
			n=math.random(5);
		end
		say("���������ã�����һ�����ţ�Ҫ�͸�"..p[n][2].."�����ܰ�����һ����",pid);
		if DrawStrBoxYesNo(-1,-1,"�Ƿ���ܣ�",C_WHITE,CC.Fontbig) then
			say("����ͳ�����");
			SetFlag(7010,pid);
			SetFlag(7011,n);
			MyQuest[2]=1;
		else
			say("���ˣ����������˰ɡ�",pid);
			AddPersonAttrib(pid,"�Ѻ�",-3);
			AddPerformance(-2);
		end
	elseif pid==oid then
		if MyQuest[2]==2 then
			say("���Ѿ������ͳ�ȥ�ˡ�");
			say("�ܺã�һ·�����ˣ��ú���Ϣ�ɡ�",pid);
			local add,str=AddPersonAttrib(0,"����",(4+JY.Person[0]["�ȼ�"])*10+300+math.random(50));
			DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
			AddPersonAttrib(pid,"�Ѻ�",1);
			AddPerformance(5);
			MyQuest[2]=nil;
			return true;
		end
	elseif pid==p[GetFlag(7011)][1] then
		if MyQuest[2]==1 then
			say("���Ǹ������ţ�"..p[GetFlag(7011)][3].."��");
			say("�ţ����Ѿ��յ��ˣ����ȥ�����ɡ�",pid);
			MyQuest[2]=2;
			return true;
		end
	end
	return false;
end

function EventInitialize()
	local SE={};
	SE[1]={
				kind="����",
				trigger=function()
							if GetFlag(17001)==0 and JY.SubScene==115 and JY.Person[JY.Da]["����"]=="����" and GetFlag(1)-GetFlag(2)>30 and JY.Person[0]["����"]==7 and Rnd(10)==1 then
								return 1;
							end
							return 0;
						end,
				go=	function()
						Dark();
						Light();
						script_say("���ǣ��������ӡ��ף����������ǡ���")
						script_say("�������ոյ���������ϰ�䣬�Ҳ�Ը�⣬��������һ��ָ������Ѩ�������ҽ⿪����վ������춼�������ˡ�")
						script_say("���ǣ��⡭���ҵ��������㣬û�������ӽ�Ѩ��")
						script_say("����������������Ҳ���ǵģ������װ����𾭣���ԭ��Ҳ��֪���ġ���˵����ƽ�ȣ���Ӧɱ����������ȴƫƫҪ��ȥ��ʲôɱ�˵���ѧ��������Ҫѧ������ſϰ��ҽ�Ѩ��������Ըһ���Ӿ�վ��������")
						script_say("���ǣ���������Ҫ��Ҫ���������أ���")
						if DrawStrBoxYesNo(-1,-1,"Ҫ��Ҫ��������") then
							SetFlag(17001,1);
							script_say("���ǣ�����Ī����������үҲֻ��һʱ֮������������ǰȥȰȰ��ү����ү�������ˣ�Ӧ�þͻ��������ӽ�Ѩ�ˡ�")
							script_say("������̫���ˣ��Ǿ��鷳���ˡ�")
						else
							SetFlag(17001,2);
							script_say("���ǣ����ӣ���ү˵�Ķԣ�������������֮�У������书���ս��粽���С����Ӹ��ǹ�Ϊ�Ҵ������ӣ����䲻�ɲ�ѧ�����ӻ��Ǵ�Ӧ��ү�ɣ���ү�����ˣ���Ȼ�ǻ�����ӽ�Ѩ�ġ�")
							script_say("��������ѧ����ѧ����ɱ�˵Ķ����ҲŲ�Ҫѧ������������վ�����ˣ�")
						end
					end,
				
			};
	SE[2]={
				kind="����",
				trigger=function()
							if GetFlag(17001)==2 and GetFlag(17002)==0 and JY.SubScene==115 and JY.Person[JY.Da]["����"]=="����" and JY.Person[0]["����"]==7 then
								return 1;
							end
							return 0;
						end,
				go=	function()
						script_say("��������ѧ����ѧ����ɱ�˵Ķ����ҲŲ�Ҫѧ������������վ�����ˣ�")
						script_say("���ǣ���������ȥȰȰ��ү�ɡ�")
					end,
				
			};
	SE[3]={
				kind="����",
				trigger=function()
							if GetFlag(17001)==1 and GetFlag(17002)==0 and JY.SubScene==115 and JY.Person[JY.Da]["����"]=="����" and JY.Person[0]["����"]==7 then
								return 1;
							end
							return 0;
						end,
				go=	function()
						script_say("���������ǵ��������ˣ�")
						script_say("���ǣ�����Ī������ү����æ��һʱδ��������������ȥ���ơ�")
						script_say("�������������ˡ�")
					end,
				
			};
	SE[4]={
				kind="����",
				trigger=function()
							if GetFlag(17001)~=0 and GetFlag(17002)==0 and JY.SubScene==115 and JY.Person[JY.Da]["����"]=="������" and JY.Person[0]["����"]==7 then
								return 1;
							end
							return 0;
						end,
				go=	function()
						SetFlag(17002,1);
						script_say("���ǣ��μ���ү��")
						script_say("��������Ŷ�����ұ������£�")
						script_say("���ǣ���ү����������Ϊ���Ӷ����ġ���������ϲ���𾭣������������ĳ���Ӳ����ѧ�䣬���¾��ã�ʵ����Щǿ�����ѡ�")
						script_say("���������ߣ�")
						script_say("���ǣ���ү����ʵ�����һλլ���ʺ�����ӣ����Ҵ���֮�������������ƣ������ʰ������£����Ӽ氮����������ʱ�գ������ʾ���")
						script_say("���������ߣ��Ҵ�����ϴ��ˣ������书�����������³�Ц�����ο����һ�����Ҷ���һ����ѧһ��ָҲ���ɾ�ѧ�����ö�ĳ�������Ҵ�����ϵ��������ڣ�")
						script_say("���ǣ���ү�������ǡ�ֻ�����Ӵ�ʱ�������ף�һʱ�����뵽��һ�㣬���ϰ��һ�����������ǿ������ѧ��ֻ�����ʵ��䷴����ү�����Ӿþ�����������֮�У��������뽭�������ǲ�֪�������գ����䲻�С����룬�����Ӽ�ʶ��������֮���Ժ󣬱������")
						script_say("�������������ţ�����֮�����ǡ�������������Σ�")
						script_say("���ǣ���ү�����Ӵ�δϰ�䣬�����ҵȣ���ү����һ��ָ����Ѩ������վ�㼸��ʱ�������ӿ������������ͣ���ˣ����Ǹ����������ѧ��")
						script_say("�������������ߣ�")
						Dark();
							--����
							JY.Base["��X1"],JY.Base["��Y1"]=41,34;
							JY.Base["�˷���"]=0;
							JY.MyPic=GetMyPic();
							--��ү
							ModifyD(115,12,-2,-2,-2,-2,-2,-2,-2,-2,-2,41,32);
							--����
							ModifyD(115,28,-2,-2,-2,-2,-2,-2,-2,-2,-2,0,0);
						Light();
						script_say("���������ţ��������أ�")
						script_say("���ǣ��⡭������֮ǰ�뿪֮ʱ�����ӻ��ڵİ���Ī����ʱ���ѵ������ӵ�Ѩ�������н⿪��")
						script_say("�������������ܡ��ҵ�������Ѩ��û��һ���ǲ��������н⿪�ˡ����������˽���������Ѩ������������")
						script_say("���ǣ���ү�������ڸ�����Ǻã�")
						script_say("������������û���书����ƾ˫�ţ��������ߵ�̫Զ������������ȥ����Ѱ�顣���Ƿ������������Ͱ������Ҵ�������")
						script_say("���ǣ��ǣ�")
						Dark();
							ModifyD(115,12,-2,-2,-2,-2,-2,-2,-2,-2,-2,28,12);
						Light();
					end,
				
			};
	SE[5]={
				kind="����",
				trigger=function()
							if GetFlag(17002)==1 and JY.SubScene==115 and JY.Person[JY.Da]["����"]=="����" and JY.Person[0]["����"]==7 then
								return 1;
							end
							return 0;
						end,
				go=	function()
						SetFlag(17003,1);
						script_say("���ǣ��������ӣ�")
						script_say("�������ף�������")
						script_say("���ǣ���ү���ˣ�")
						script_say("������������")
						Dark();
								SetD(JY.SubScene,JY.CurrentD,0,0);
								SetD(JY.SubScene,JY.CurrentD,3,-1);
								SetD(JY.SubScene,JY.CurrentD,5,0);
								SetD(JY.SubScene,JY.CurrentD,6,0);
								SetD(JY.SubScene,JY.CurrentD,7,0);
						Light();
						script_say("���ǣ���үû�������ף���ôһ˲�����ӾͲ����ˣ�")
					end,
				
			};
	SE[6]={
				kind="����",
				trigger=function()
							if GetFlag(17003)==1 and JY.SubScene==115 and GetFlag(17004)==0 and JY.Person[JY.Da]["����"]=="������" and JY.Person[0]["����"]==7 then
								return 1;
							end
							return 0;
						end,
				go=	function()
						SetFlag(17004,1);
						script_say("���ǣ���ү���������ܣ���Ȼ���������ӣ�����һʱ���⣬ȴ�����������ˡ�")
						script_say("���������š��޷���ֻҪȷ����ƽ�����±�ã���Ҳ�ü�ʶ��ʶ�����ˡ���Ȼ���ܴ�����Ƥ�����ܵ���֤���������е�С�����ġ���ε��������Ĳ����ұ㴫����[Ǭ��������]�ɡ�")
						script_say("���ǣ�л��ү��")
						local kflist=	{
											{110,10},
										};
						LearnKF(0,JY.Da,kflist);
					end,
				
			};
	SE[51]={
				kind="����",
				trigger=function()
							if GetFlag(19001)==0 and GetFlag(1)-GetFlag(2)>180 and Rnd(15)==1 and (JY.SubScene==38 or JY.SubScene==40 or JY.SubScene==109 or JY.SubScene==112 or JY.SubScene==133 or JY.SubScene==134) then
								return 1;
							end
							return 0;
						end,
				go=	function()
						JY.Person[263]["ͷ�����"]=319*4+1001;
						JY.Person[263]["ս������"]=319;
						JY.Person[263]["����"]='������';
						JY.Person[263]["���"]='������';
						JY.Person[263]["����"]=JY.Person[263]["����"]+30;
						JY.Person[263]["����"]=JY.Person[263]["����"]+30;
						JY.Person[263]["��"]=JY.Person[263]["��"]+30;
						ModifyD(51,12,-2,-2,-2,-2,-2,-2,-2,-2,-2,0,0);
						local x0,y0=JY.Base["��X1"],JY.Base["��Y1"];
						local d=JY.Base["�˷���"];
						local x1,y1=x0+3*CC.DirectX[d+1],y0+3*CC.DirectY[d+1];
						local x2,y2=x1,y1+1;
						Dark();
							SetS(JY.SubScene,x1,y1,1,10552*2);
							SetS(JY.SubScene,x2,y2,1,11277*2);
						Light();
						if JY.Person[0]["����"]==9 then
							script_say("���ǣ����ף��ǲ�����ؤ��������ô������ô������ս�������ã��������Ų�ס�ˣ���")
							script_say("���ǣ���������������㣡")
							if FIGHT(2,1,{262,x1,y1,0,1,1},{263,x2,y2},100,-1,998,false) then
								SetFlag(19001,1)
								script_say("�����ˣ��ߣ�")
								Dark()
									SetS(JY.SubScene,x2,y2,1,0);
								Light()
								DrawStrBoxWaitKey("��������ʧ");
								script_say("���ǣ������ܵÿ죡�����������ˡ���")
								script_say("���Ԫ�����˵�̫�أ����ǡ���")
								script_say("���ǣ������������������̫����")
								script_say("���Ԫ������������������������������ɥ��Ȫ�����㲻��̫���𡭡�")
								script_say("���ǣ�������������Ǻ������´˶��֣�")
								script_say("���Ԫ����Ҳ��֪�����������ʲ������˽����������ޡ������ң��������书������ʹ�г�Ҳ���صȵ����Ŷ��ְ�����")
								script_say("���ǣ��书�����ˣ��ҹ����˲������������ҡ�������ʹ������������ġ����Ѳ��������Ա�֮����ʩ����Ĺ���Ľ�ݣ�")
								script_say("���Ԫ�����������˵������ҿ������졭������Ҳ����ʶ��֮�ˡ�����Ȼ������Ҳ���ء�������˴�硭��")
								script_say("���ǣ��ѵ����ǰ���ĳ����Ϊ��")
								script_say("���Ԫ���Ҳ����ˡ���һ����Ϊ�ʹ����Ҷ�ȥδ���ϧ����������ж������ұ�������ǰ������黹�ˡ���Ҳ���ߵ�����ǣ�ҡ���")
								DrawStrBoxWaitKey("���Ԫ����������"..JY.Person[0]["����"]);
								local add,str=AddPersonAttrib(0,"����",8000);
								DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
								War_AddPersonLevel(0);
								local add,str=AddPersonAttrib(0,"��������",8000);
								DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
								local kflist=	{
													{169,10},
												};
								LearnKF(0,262,kflist);
								script_say("���Ԫ������")
								script_say("���ǣ����������������ɶ�������ˣ�")
								Dark()
									SetS(JY.SubScene,x1,y1,1,0);
								Light()
								DrawStrBoxWaitKey("���Ԫ����");
							else
								SetFlag(19001,2)
								script_say("���Ԫ��������")
								script_say("�����ˣ��ߣ�")
								Dark()
									SetS(JY.SubScene,x2,y2,1,0);
								Light()
								DrawStrBoxWaitKey("��������ʧ");
								script_say("���ǣ����������������ɶ�������ˣ�")
								Dark()
									SetS(JY.SubScene,x1,y1,1,0);
								Light()
								DrawStrBoxWaitKey("���Ԫ����");
							end
						else
							SetFlag(19001,2)
							script_say("���ǣ����ף��ǲ���ؤ���������ô����ô���������˽��֣���")
							script_say("���Ԫ��������")
							Dark()
								SetS(JY.SubScene,x1,y1,1,0);
							Light()
							script_say("�����ˣ��ߣ�")
							Dark()
								SetS(JY.SubScene,x2,y2,1,0);
							Light()
							script_say("���ǣ���ؤ�����������������������ѧ��ɱ�����½�����Ҫ���˰�������")
						end
						JY.Person[262]["�ǳ�"]=0;
						JY.Person[262]["����"]=-1;
						JY.Person[263]["����"]='������';
						JY.Person[263]["���"]='ִ������';
						JY.Person[263]["ͷ�����"]=1549;
						JY.Person[263]["ս������"]=137;
						JY.Person[263]["����"]=JY.Person[263]["����"]-30;
						JY.Person[263]["����"]=JY.Person[263]["����"]-30;
						JY.Person[263]["��"]=JY.Person[263]["��"]-30;
					end,
				
			};
	SE[52]={
				kind="����",
				trigger=function()
							if GetFlag(19001)~=0 and GetFlag(19002)==0 and JY.Da==261 and JY.Person[0]["����"]==9 then
								return 1;
							end
							return 0;
						end,
				go=	function()
						SetFlag(19002,1);
						local i=GetFlag(19001);
						if i==1 then
							script_say("���ǣ�������������һ��ҪΪ��������𰡣�")
							script_say("���壺��������ˣ�����˵����")
							script_say("���ǣ��ǣ���������ǰ��ż���������ȴ����������һ��������򶷡���������У��ұ���ǰ��������ԵУ������ǽ�����ܣ����������������������̫�ء����ڴ�����[��������]֮�󡭡��㡭���㡭��")
							script_say("���壺�������磡��˭��������˭ɱ�����磡��˵��")
							script_say("���ǣ����������������棬ʹ��ȴ��������ľ�ѧ���޷����Ͼ����Ǻ��ˡ������²����Ա�֮����ʩ����Ĺ���Ľ�ݣ��������������ǰȴ������˵���˱�Ӱ�������죬��������ʶ֮�ˡ�")
							script_say("���壺���磡���Ƿ巢�ģ�����������ף����д��ˣ���ο������֮�飡")
							script_say("���ǣ���������������Ҳ����һͬ��Ϊ���������")
							script_say("���壺���д��ģ����ٺò����ˡ�������Ŀǰ�������㣬�����Ȼ�Ѵ���[��������]������ڼ���������ʲô�����ģ����������ҡ�")
							script_say("���ǣ���л����ָ�㣡")
						elseif i==2 then
							script_say("���ǣ�������������һ��ҪΪ��������𰡣�")
							script_say("���壺��������ˣ�����˵����")
							script_say("���ǣ�����û�á�����ǰ��ż���������ȴ������������һ��������򶷡���������У��ұ���ǰ��������ԵС��������书̫�ߣ�������������������������")
							script_say("���壺�������磡��˭��������˭ɱ�����磡��˵��")
							script_say("���ǣ����������棬���޷����Ͼ����Ǻ��ˣ����ǡ�����������ʹ�ģ�ȴ��������ľ�ѧ����Ī���������Ա�֮����ʩ����ġ���")
							script_say("���壺����Ľ�ݣ�����ؤ��������ԩ�޳���Ҳ������˵�������������������������´˶��ְ������¿�����Щ���Σ���С�Ĳ�֤�������������ұ���������ο����������֮�顣")
							script_say("���ǣ���������ʱ��������Ҳ����һͬ��Ϊ���������")
							script_say("���壺���д��ģ����ٺò����ˡ�������Ŀǰ�������㣬�����ڼ��������ǡ�")
							script_say("���ǣ��ǣ�������")
						elseif i==3 then
							script_say("���ǣ������������ˣ�������")
							script_say("���壺��ʲô�£�")
							script_say("���ǣ��������ţ�����������������˺��ˣ�")
							script_say("���壺�����⾿������ô���£���˵��")
							script_say("���ǣ��������Ի�˵��˵����������������Լ��ľ�ѧ��ɱ����������һ��ҪΪ��������𰡰�����")
							script_say("���壺���磡��˭��������˭��")
							script_say("���ǣ�������������������������Լ��ľ�ѧ֮�£��������д����֣����д������ģ�����˼��ֻ���Ա�֮����ʩ����Ĺ���Ľ�ݷ���������")
							script_say("���壺Ľ�ݸ�����ؤ��������ԩ�޳���Ҳ������˵�������������������������´˶��ְ������¿�����Щ���Σ���С�Ĳ�֤������ڽ��������ߵ�ʱ��϶࣬���������Ľ�ݸ����ˣ������������ұ���������Ϊ����������֮�顣")
							script_say("���ǣ��ǣ�������")
						else
							say("ò�Ƴ��֣£����ˣ�����ʱ�����ܼ������Ի���");
						end
					end,
			};
	SE[53]={
				kind="����",
				trigger=function()
							if GetFlag(19002)~=0 and GetFlag(19003)==0 and JY.Da==261 and JY.Person[0]["����"]==9 and GetD(JY.SubScene,JY.CurrentD,2)==1002 then
								return 1;
							end
							return 0;
						end,
				go=	function()
						SetFlag(19003,1);
						local x,y=GetD(JY.SubScene,JY.CurrentD,9),GetD(JY.SubScene,JY.CurrentD,10);
						local d;
						for i=-1,1,2 do
							for j=-1,1,2 do
								d=GetS(JY.SubScene,x+i,y+i,3);
								if d>=0 then
									if GetD(JY.SubScene,d,2)==1002 then
										SetD(JY.SubScene,d,0,0);
										SetD(JY.SubScene,d,3,-1);
										SetD(JY.SubScene,d,5,0);
										SetD(JY.SubScene,d,6,0);
										SetD(JY.SubScene,d,7,0);
										break;
									end
									d=-1;
								end
							end
						end
						script_say("���ǣ����²μ�������")
						script_say("���壺Ŷ���ѵ����������㣬�������ҺȾơ�")
						script_say("���ǣ������¾͹�����������ˡ�")
						Dark();
						Light();
						DrawStrBoxWaitKey("�����干��")
						script_say("���壺���������ã�ʹ�죡��������ؤ���ֵܣ�")
						script_say("���ǣ����ǱȲ�������������")
						Dark();
							for i=1,199 do
								if GetD(JY.SubScene,i,3)==196 then
									SetD(JY.SubScene,i,0,0);
									SetD(JY.SubScene,i,3,-1);
									SetD(JY.SubScene,i,5,0);
									SetD(JY.SubScene,i,6,0);
									SetD(JY.SubScene,i,7,0);
									break;
								end
							end
							if d>=0 then
								local id=196;
								SetD(JY.SubScene,d,0,1);
								SetD(JY.SubScene,d,3,id);
								SetD(JY.SubScene,d,5,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
								SetD(JY.SubScene,d,6,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
								SetD(JY.SubScene,d,7,2*(10000+JY.Person[id]["ս������"]*4+GetD(JY.SubScene,v,8)));
							end
						Light();
						script_say("��������λ���Ƕ��������ġ����Ƿ塱�����ǰ�����")
						script_say("���壺�������ǣ���֪��λС�ֵ��ǡ���")
						script_say("���������´�������������ǰ������������յü�����ȻӢ�ۺ������������ͣ��ʺ���ǰ����һ��ˮ�ơ�")
						script_say("���壺�����������кβ��ɣ�С��������λС�ֵ��ø�������")
						script_say("��������л�ǰ�����")
						DrawStrBoxWaitKey("���˶���һ��")
						script_say("���ǣ����������Ҳ����ˡ���")
						script_say("���壺����������ɲ���Ŷ����û����λС�ֵ��ܺȡ�")
						script_say("���ǣ���λС�ֵܾ�Ȼ�������������˶��룬���������������簡��")
						script_say("�������ý���λ����Ц������ʵС��������������׵����ġ�")
						script_say("���壺Ŷ����ĳ���߽������꣬ȴ��֪�����Ҳ�����ף�")
						script_say("������˵��������С�ܳ��������ϣ�����һ��ָ���ոպȾ�֮ʱ��������һ��ָ����ˮ�Ƴ�����˲������ǰ���������ô�á�")
						script_say("���壺�����������Ŵ���һ��ָ������һ����û�뵽��Ȼ����������á�С�ֵ�����̹����棬����֤������һƬ����֮�İ���")
						script_say("�������ǰ����ܲ�����С�ܣ�������ؽ󣬲���������һ��һ�Ĵ�Ӣ�ۡ�")
						script_say("���壺С�ֵܣ�����һ����ʣ�������վͽ�Ϊ�����ֵ���Σ�")
						script_say("�������ѵ��ǰ�����������Ī�Ҳ��ӡ�")
						script_say("���壺���������ã�")
						DrawStrBoxWaitKey("��������")
						script_say("���壺���Ƿ壬�����������Ϊ�����ֵܣ�����и�ͬ������ͬ����")
						script_say("�������Ҷ������������Ƿ��Ϊ�����ֵܣ�����и�ͬ������ͬ����")
						script_say("���壺�����������ܣ�")
						script_say("��������磡")
						script_say("���ǣ���ϲ��������ϲ���ֵܡ�")
						Dark();
						Light();
						script_say("ؤ����ӣ�������ʱ���Ѿ����ˡ�")
						script_say("���壺�š����ܣ���ؤ�ﻹ�а�����Ҫ�����Ͳ������ˡ�")
						script_say("��������磬��֪���Ƿ񷽱�һͬǰȥ�أ�")
						script_say("���壺�����������кβ��ɡ���˵�Ҳ��Զ�����ڸ����������֡������߰ɡ�")
					end,
			};
	SE[54]={
				kind="����",
				trigger=function()
							if GetFlag(19003)==0 and GetFlag(19004)==0 and JY.SubScene==131 then
								return 1;
							end
							return 0;
						end,
				go=	function()
						SetFlag(19004,1);
						local cx,cy=22,22;
						local function set(t)
							local x,y=t[1],t[2];
							if GetS(JY.SubScene,x,y,1)>0 then
								SetS(JY.SubScene,x,y,1,0);
							else
								SetS(JY.SubScene,x,y,1,2*(GetNPCPic(JY.Name[t[3]])+t[4]));
							end
						end
						local function clean(t)
							local x,y=t[1],t[2];
							if GetS(JY.SubScene,x,y,1)>0 then
								SetS(JY.SubScene,x,y,1,0);
							end
						end
						local s1=	{
										{22,22,"����",1},
									};	--����
						local s2=	{
										{25,21,"ؤ�����",2},
										{25,22,"ؤ�����",2},
										{25,23,"ؤ�����",2},
										{25,19,"����",2},--����
									};	--ؤ�����
						local s3=	{
										{21,19,"����ͬ",3},
										{22,19,"������",3},
										{23,18,"����",3},
										{21,18,"����",3},
										{20,19,"�粨��",3},
									};
						local s4=	{
										{22,25,"ȫ����",0},
										{20,26,"����Ϫ",0},
										{21,26,"��ɽ��",0},
										{23,26,"�¹���",0},
										{24,26,"�ⳤ��",0},
										{18,27,"ؤ�����",0},
										{19,28,"ؤ�����",0},
										{20,28,"ؤ�����",0},
										{21,28,"ؤ�����",0},
										{22,28,"ؤ�����",0},
										{23,28,"ؤ�����",0},
										{24,28,"ؤ�����",0},
										{25,28,"ؤ�����",0},
										{18,29,"ؤ�����",0},
										{20,29,"ؤ�����",0},
										{22,29,"ؤ�����",0},
										{24,29,"ؤ�����",0},
										{19,30,"ؤ�����",0},
										{21,30,"ؤ�����",0},
										{23,30,"ؤ�����",0},
									};
										--
						local s5=	{
										{23,24,"������",3},
										{26,19,"������",2},
										{27,20,"ؤ�����",2},
										{27,21,"ؤ�����",2},
										{27,22,"ؤ�����",2},
										{27,23,"ؤ�����",2},
										{27,24,"ؤ�����",2},
										{27,25,"ؤ�����",2},
										{27,26,"ؤ�����",2},
										{28,22,"ؤ�����",2},
										{28,24,"ؤ�����",2},
										{28,26,"ؤ�����",2},
										{29,21,"ؤ�����",2},
										{29,23,"ؤ�����",2},
										{29,25,"ؤ�����",2},
									};
						local s6=	{
										{21,25,"�쳤��",0},
										{19,23,"�����",1},
										{19,22,"̷��",1},
										{19,21,"̷��",1},
										{19,20,"��Ǯ��",1},
										{18,25,"����ɽ",1},
										{18,23,"����ɽ",1},
										{17,26,"����ɽ",1},
										{17,24,"����ɽ",1},
										{17,22,"��Сɽ",1},
										{19,24,"����",1},
										{20,24,"�ǹ�",0},
									};
						Dark();
							set(s1[1]);
							for i,v in pairs(s2) do
								set(v);
							end
						Light();
						script_say("���ǣ��ǰ����ÿ�Ľų̣�");
						SmartWalk(cx+3,cx+2,2);
						script_say("ؤ������ڣ��μ�������")
						script_say("���壺�����Ǻã�")
						Dark();
							for i=1,4 do
								set(s3[i])
							end
						Light();
						script_say("����ͬ�������ؤ�������")
						script_say("���壺�������ǡ�����һ�п��ǹ���Ľ���ϣ���")
						script_say("����ͬ����Ҳ��Ҳ������ֻͬ�ǹ��Ӽ��ͣ��ֲ���Ľ�ݣ���û�м��ˣ���Ȼ���ǹ���Ľ���ϡ�")
						script_say("���壺ԭ���ǰ�������������Ӣ����")
						script_say("����ͬ����Ҳ��Ҳ���������˽�֪������ͬû��ʲôӢ����ֻ��һ�ų��죬���ڱ����ˡ��ǰ��������������������ϣ�������Ĳ����ˡ�")
						script_say("���壺Ŷ����Ҫ�����������µĲ����ˡ�")
						script_say("����ͬ���Ҽҹ��������ǰ����Ǹ����ؤ��Ҳ�в��ٲſ�����ǰ�������ݻ���£��ǰ���ȴ�Ե����ֵ������˽��ϡ��ٺ٣����д������д�����")
						script_say("���壺Ľ�ݹ��Ӽ��������ְ��ĳ�������ȵ�֪���ص���ӭ��ݡ�ʧӭ֮�����л�ˡ�")
						script_say("����ͬ������ʧӭ֮�ȷʵҪл������Ȼ���Ե��úã���֪�߲�����ǵ���Ҫ��Ҫ��ȫ�ڱ��˰�")
						DrawStrBoxWaitKey("Զ������������Ц");
						script_say("�¹��㣺���Ű���ͬ˵�����繷ƨ����Ȼ�����鴫��")
						Dark();
							for i,v in pairs(s4) do
								set(v);
							end
							set(s4[1]);
						Light();
						script_say("����ͬ���׻�˵����ƨ��������ƨ���죬���ֳ�����ģ�Ī����ؤ�����������ţ�")
						script_say("�¹��㣺��Ȼ֪����ؤ������������������ͬΪ�λ�������������أ�")
						script_say("����ͬ���ĸ��϶�����Ҫ������ͬ����һ�������������϶���ô�����ˣ��Ѳ�����׼���������ͬô���ð����ܺá�����ͬ�����ˡ�")
						script_say("�粨���������ܵ���˭���ǰ��������𣿴��˴��ˣ��ǽ���һ���粨��")
						Dark();
							set(s3[5]);
						Light();
						script_say("���̣����ĸ磬�����й��ӵ���Ϣ�ˣ�")
						script_say("�粨�񣺹��ӵ���Ϣ������˵���粨��Ҫ�ȴ���һ�ܣ�����")
						script_say("�¹��㣺�����㲻�ɣ�")
						script_say("���壺ͳͳס�֣�")
						script_say("�粨�񣺡�����Ȼһ�оͷֿ��������ˡ������˰��ˣ��򲻹��������ⶪ���ˡ�")
						Dark();
							set(s3[5]);
						Light();
						script_say("����ͬ���߰��߰ɣ����������⣬�����޹⣡����ʮ���⣬���侫�⣡��������⣬�Ծ����⣡")
						Dark();
							set(s3[1]);
						Light();
						script_say("���壺��λ�����ˡ�")
						script_say("ȫ���壺������")
						Dark();
							set(s4[1]);
						Light();
						script_say("ȫ���壺���������������������Ĵ����δ�ñ�������������������ߵ��ˣ�")
						script_say("��������������ƴ������������������ͱ��ˣ��������񡣣�")
						script_say("���壺���ǵ���������ԭ��Ϊ������Ĵ����������⼸�����Ҷ෽��죬����ɱ����������֣�δ�ر���Ľ�ݹ��ӡ�")
						script_say("ȫ���壺��������������Ȼ��")
						script_say("���壺�����������������Լ��ľ�ѧ�����������֡����㼴�����˹���Ľ���ϵ��Ա�֮����ʩ��������ġ����������֡�������˫�޶ԣ�����Ľ���ϣ������������Դ˼�������")
						script_say("ȫ���壺����")
						script_say("���壺������������Խ��Խ���ã�������ǰ���뷨ֻ��δ�ؾ�Ȼ��")
						script_say("ȫ���壺���ֵܶ�Ը�����꣬�����������")
						script_say("���壺�����˴��ⲻ�ƣ����ֵ��������ƽ�������ǰ��������ش��ʡ���")
						script_say("���壺������ִ����λ�����أ�")
						script_say("ȫ���壺���½��ղ�û������λ���ϡ�")
						script_say("���壺���ʡ����š����¡������Ķ�Ķ������ںδ�����λ���ϣ��������˺��£�")
						Dark();
							set(s1[1]);
							s1[1][1],s1[1][2],s1[1][4]=22,24,3;
							set(s1[1]);
						Light();
						DrawStrBoxWaitKey("˵���䣬�����ѽ�ȫ��������");
						script_say("���壺�����֪��Ǳ�����ܷ��ɡ����ˣ�ȥ�Ѵ�����ִ���Լ���λ�������롱����")
						script_say("ؤ����ӣ��ǣ�")
						DrawStrBoxWaitKey("Զ������һ��ŭ��");
						script_say("����������λ���ϣ����ǽ��ҵȹ��ڴ��Ͼ�����Ϊ�Σ�")
						Dark();
							for i,v in pairs(s5) do
								set(v);
							end
						Light();
						script_say("�ⳤ�磺����������Ϊؤ����ӣ��뵱���������ŷ������ɷ����£��Ծ��Ƕԣ�����Ǵ�������Ϊ��Ҳ�ҵ������ǰ��������Ǵ��������ˣ�Ҫ��ȥ��İ���֮λ��������£����ɳ����ĳ��϶��ǲ���ġ������´���ִ����λ���ϲ��ʣ������跨��������������������Ϊ�˱���Ĵ�ҵ���룬���ò�ð�ն�Ϊ��������ͷ����������ռ���Ϸ磬�������㴦�ñ��ǡ��ⳤ����ؤ����ʮ�꣬˭��֪���Ҳ���̰��������С�ˡ�")
						script_say("�����������ɳ����ĳ��ϱ��Ѱ�����Υ������һ�����Ҽ�Ϊִ�����ϣ��Ե�����ִ����ִ�����ӣ����ĳ��ϰ����ˡ�")
						script_say("ִ�����ӣ��ǣ�")
						script_say("����������λ�ֵܣ��ǰ��������ϴ�������Ϊ���������������ȡ���ᣬ��ʲô�������ֶζ��ô�λ�������������������������⣬����Ϊ�������ߴ��ͣ�����Դ򹷰����ڡ���һ��̩ɽ��ᣬ��������Χ��������ʮ�����գ�ȫ���ǰ�����������ǿ�У�ؤ�����תΣΪ������������ֵܶ������۵ü��������������������¡�����˾�֪���ǰ�������֮�����ǰ����������壬����ô�ʣ����Ǵ���ӵ�����Բ�����Ϊʲô��Ȼ�������������ģ�����������ң�ȫ���壬�㵱��˵������")
						script_say("���壺ȫ���������Ƿ�����ʲô�Բ������ֵ����£��㾡�ܵ���ָ֤�����غ��£����ù˼ɡ�")
						DrawStrBoxWaitKey("����⿪ȫ����Ѩ��");
						script_say("ȫ���壺�Բ������ֵܵĴ��£����ֽ���Ȼ��û�����������þ�Ҫ���ˡ�")
						script_say("����������˵�˵����ǰ���Ϊ�˴��£��������䣬����ǰ��û�������£��������Ӳ���������ֻƾһЩȫ����֤���޻�֮�ԣ���ɿ�����ģ���ͼ���Ѱ�������ʵ˵����Щҥ��Ҳ�������ҵĶ����ֻ�����Ǵ�Ź�ƨ������һȭͷ�㽫��ƨ֮�˴���������߹ǡ�ƫ����ôЩ��Ϳ͸���ļһ��������ĺ�˵�˵�����˵��˵ȥ��Ҳ��������ô���仰����������˶ϰɡ�")
						script_say("���壺�׳��ϣ��㲻���Լ�����ȫ������ͷ��β������ϸϸ˵�����ס����γ��ϡ��ɳ�������Ҳ�������ң�������Ƿ嶨�в���֮����")
						script_say("��ɽ�ӣ��ҷ����㣬���Ҳ��ԣ��㲻�����ᡣ��ͷ����֮�������аѰ������ϵĴ�ͷ������������ǡ�")
						script_say("�������������Ը����ǡ�ȫ���壬��˵�ɡ�")
						script_say("ȫ���壺������Ϊ���������������ǳ����Ƿ��ָʹ��")
						script_say("���壺���ǡ��Һ������������䲻�����̸�䲻��Ͷ����������û�����������ͷ�����������ʵ���������Ƿ����мӺ����Ԫ֮�⣬����������ѣ���ǧ��֮����Ϊ���ºú���Ц��")
						script_say("ȫ���壺Ȼ�����Ǵ�ﵽ��������Ľ�ݸ�����Ϊʲô��һ���١��ٶ���������˹��᣿��������Ľ�ݸ��ļ��˾�������ȴ���Աӻ���")
						script_say("���壺��ؤ�￪�������꣬�ڽ�����������磬���������˶����ڡ��书��ǿ�����������������塢���ֹ���֮�ʡ�ȫ�����������ұӻ�����λ������������ȷ�Ǳӻ����ǣ�������Ϊ�Ұ�ϧ������������������������������Ӣ��˵һ�䡮ؤ���ڳ��Ϻ���������������Ů�ӡ������ɳ����ĳ��ϣ���һλ�����������ֵ�ǰ����ؤ�����λ���ϵ��������㲻��ϧ���������ֵܿɶ���ϧ��")
						script_say("��������ȫ���壬�㻹��ʲô��˵����������Ȳ�ʶ�������ͽ�����ظ�����Ѵ��࣬�������淸�ϵİ�洦�̱��ˡ�")
						script_say("���壺ȫ������˵�ö����������ı���ң����м��ش��ԭ�򡣴��ɷ����£��Ծ��Ƕԣ�����Ǵ���λ�ֵܣ��Ƿ��������Ϊ���кβ��ԣ��������Ա��ǡ�")
						script_say("�ⳤ�磺������������Ǹ�װǻ���ƵĴ���ۣ������Ǹ�ֱ��ֱ�ǵĺú��ӣ����ⳤ��û���·ֱ棬�㻹�Ǽ��罫��ɱ�˰ɡ�")
						script_say("���壺�ⳤ�ϣ���Ϊʲô˵���Ǹ����˵�ƭ�ӣ��㡭���㡭��ʲô�ط������ң�")
						script_say("�ⳤ�磺�����˵����ǣ��̫�࣬���˳�ȥ��ؤ���ڽ�������Ҳ̧����ͷ��������Ҫ�����ǲ������Ǳ����뽫��һ��ɱ�����Ǿ����ˡ�")
						script_say("���壺Ϊʲô��Ϊʲô���Ҿ���Ľ�ݸ����µ���Ա�󽫣����Ǿ������Һ����������ᣬ�ǲ��ǣ���������ı�����ȣ��Ҿ����ں��������������ϸ�ϵ����˵�������Ƕ��Ǵ���ʱ�����¶�������ܾ�������������Ľ�ݸ�������")
						script_say("ȫ���壺���Լ��ã�")
						script_say("���壺�����������������ϱ����ĸ�����ʵ���٣��������ڸ��˱���ĳ�������֮�¡����˽Ե��ǹ���Ľ�������¶��֡��������˿�������������µ�ʱ����Ľ�ݸ�һ�ˣ��Ṧ�ٸߣ�Ҳ����������ô�ദ֮��������������")
						script_say("�ⳤ�磺�⡭�������������������㣬�����������ԣ�ֻ���������������ͣ����ﹴ�����Ľ�������ֺ���������С�´���һ�𣬾����ɵ��˲��š�����һ�룬����ʵ��̫����Ϳ���׳��ϣ����뷨���������հ�棬���������˶ϱ��ǡ�")
						script_say("��������ִ�����ӣ��뱾�﷨����")
						script_say("ִ�����ӣ��ǣ�")
						script_say("ִ�����ӣ������뼯����������")
						script_say("���������������ɳ����ĳ����������ԣ�ͼı���ң�Σ�������ҵ���ﵱһ�����������Ƿֶ����ȫ���壬��ң���ڣ��Ķ����ң��ﵱ�ŵ��������������ҵĸ�����ӣ����������պ���Ӳ龿���ֱ𴦷���")
						script_say("�ⳤ�磺�������ⳤ����㲻�������˶ϡ�����֪�Һ�Ϳ������֮����ԭ�����ⳤ�硣�ⳤ�������˶ϣ�ִ�������ɰ�")
						script_say("ִ�����ӣ��ǣ�")
						script_say("���壺������")
						script_say("�ⳤ�磺������������̫���㲻���������˶ϣ�")
						Dark();
							set(s1[1]);
							s1[1][1],s1[1][2],s1[1][4]=20,25,3;
							set(s1[1]);
						Light();
						script_say("���壺ʮ����ǰ���������������Źأ��γ��ϵ�֪ѶϢ�����ղ�������˯����ҹ�ϻأ���֪�������飬;�����о�ƥ������Ҳ�۵��������ˣ�������Ѫ�������Ҵ����ؾ��б����������ﲻ�Ѷ��ˡ������й��ڹ��Ĵ��£�������Ӣ����Ȼ��֪�������飬����ؤ��ȴ��֪���ġ�ִ�����ϣ��γ��Ϲ�������������죬�����������")
						script_say("���������������γ������飬��˵��Ҳ���������������ƣ����Ѱ������������⣬���д󹦣��಻���ꡣ���������й��߽������£�Σ������ٴ���ҵ������������������ڰ�治�ϣ����ǲ��ܻ������������������Ĺ�ء�")
						script_say("����Ϫ��ִ�����ϵĻ����Ҳ�������Ǽ�Ȼ��ӳ���֮λ����һ�������й����ٺ����ͣ���������׷�۾ɹ�����ôʲô���ж��ɷ��ˡ�������������������������˶ϡ�")
						DrawStrBoxWaitKey("�����������������Լ����");
						script_say("��������磡")
						script_say("ؤ����ӣ�������")
						script_say("���壺�׳��ϣ�������֮�У�����ôһ������������ӷ��棬�������⣬����ȴ�ӿ��ݣ�����������Ѫ����ϴ���������Ҳ���ǣ�")
						script_say("�����������������ôһ����������������Ѫ��ϴ��֮����������Ƿ�ֵ�á�")
						script_say("���壺ֻҪ���������ŷ����Ǿͺ��ˡ�");
						Dark();
							set(s1[1]);
							s1[1][1],s1[1][2],s1[1][4]=21,25,3;
							set(s1[1]);
						Light();
						script_say("���壺�ɳ��ϵ���ָ���ҵ��书������ʦ��֮����ȴ��ʦ��֮ʵ��������˽�˵Ķ��¡��뵱��������Ϊ����������������ܻ񣬰�������ɽ�ڷ綴�У�������ؤ����������������������İ��֣��ɳ�����֮���������ƣ�����װ��������ģ������Ը������ʹ�������������ա������й��ڹ��Һͱ���Ĵ��£����˷��������������ɡ�")
						DrawStrBoxWaitKey("������ȡһ���������Լ����");
						Dark();
							set(s1[1]);
							s1[1][1],s1[1][2],s1[1][4]=23,25,3;
							set(s1[1]);
						Light();
						script_say("�¹��㣺�ǰ������Ҹ���ûʲô���飬ƽʱ������ĵط�̫�࣬����Ҫ����Ѫ������")
						script_say("���壺�³��ϣ����Ƿ��Ǹ���³���ӣ������ύΪ�˽��������°�ϸ�����ѣ�Ҳ��ϲ�������Ⱦơ����϶�˵�໰����Ц��֮�ˣ��������������Ը���ǿ�������Һ������鲻Ͷ��ƽʱ�ѵ��к��Ժ����Ҳ��ϲ�����Ϊ�ˣ����������������ܿ�������ȥ��һ�������ĵͱ����Ӻ��Ҿơ��Թ��⡣����Ƣ������Ҷ�֪���ġ���������Ϊ�����ȥ������磬�ǿɾʹ����ش��ˡ���������ϳɳ��أ��Ӳ���ƣ��������ǵĺô������Ƿ弰���ǲ��ϡ���ɱ��ͮ����·��Ԫ˧Ү�ɲ�³�Ĵ��ͣ����˲�֪���ѵ���Ҳ��֪ô��")
						DrawStrBoxWaitKey("������ȡһ���������Լ����");
						script_say("ؤ����ӣ�������¾��ǳ³�����Ϊ��")
						script_say("ؤ����ӣ���������Ĺ��Ͱ����³��Ͼ�Ȼֱ�����춼��������")
						script_say("�¹��㣺�ҳ¹����������£���а��������¡�")
						Dark();
							set(s1[1]);
							s1[1][1],s1[1][2],s1[1][4]=24,25,3;
							set(s1[1]);
						Light();
						script_say("���壺�ⳤ�ϣ����������ӥ��Ͽ���������ġ�һƷ�á��ĸ��֣�ʹ���д���ҽ�����ı�޷��óѡ���ƾ��Ԫ˧����������桮�ǹ����ơ���������������֮���ȡ������������ưɣ�")
						script_say("�ⳤ�磺������ǹ��������������˵���ǡ�����������Ǹ�������һ���Ҿ��󷢣�ûǮ��ƣ��ѽ������˸�����������")
						script_say("���壺ˬ�죬ˬ�죬ֻ��δ��Բ�����Ԫ˧�ˡ�")
						DrawStrBoxWaitKey("������ȡһ���������Լ����");
						script_say("�ⳤ�磺����������ʴ��壬�ⳤ�������������Ӵ˽��˸��㡣�˼�˵������Ǹ�������Ҳ�����ˡ�")
						Dark();
							set(s1[1]);
							s1[1][1],s1[1][2],s1[1][4]=22,24,3;
							set(s1[1]);
						Light();
						script_say("���壺ȫ����������ʲô��˵��")
						script_say("ȫ���壺�����Է��㣬��Ϊ�˴��εĽ�ɽ��Ϊ��ؤ��ٴ��Ļ�ҵ����ϧ����˵������������֮�ˣ�η�����������������㽫��һ��ɱ�����ǡ����ǵģ�ʹʹ��죬һ������ɱ�ˡ�����һ������ϣ��ۿ����ؤ������������У��Ҵ��εĽ��彭ɽ�������������ĵҡ�����ʱ˵�ˣ����ֵ�˭Ҳ���ţ�������ȫ����̰���������ҽ����������������һ�����α���������������")
						script_say("���壺ȫ��������˵֪�����������࣬��˵�����뱾�ﰲΣ�йأ�����ֱ����Σ�ȴ�ֲ�����ʵ����ɿ�����ң�һ�����⣬ֻ�ǽ������Ҽ��£���������֮����������ɱ�㡣�Ƿ岢��һζ������������ʾ��֮�����Ⱦ���ɱ�㣬����Ҳ�Ӳ����ҵ����ơ���ȥ�ɣ����±��ϲ������Խ����ؤ����û����������")
						script_say("ȫ���壺����")
						DrawStrBoxWaitKey("ͻȻ·�ڳ���һؤ�����");
						script_say("ؤ����ӣ����ġ��������������顭��")
						DrawStrBoxWaitKey("ؤ���������");
						Dark();
							set(s6[1]);
						Light();
						script_say("�쳤�ϣ��Ƿ壬������£��㲻�ܿ���")
						script_say("���������쳤�ϣ����´�ݹ��٣�")
						script_say("���壺�쳤�ϰ��á�")
						script_say("�쳤�ϣ�������Ԫ���ֵܵ���������˼�������������λ�����˵�����������Ƭ����Σ�")
						script_say("���壺�������¹����ش󣬴����Ⱥ���ǡ�")
						script_say("�쳤�ϣ����¹����ش�")
						DrawStrBoxWaitKey("�������");
						Dark();
							set(s6[2]);
							set(s6[3]);
							set(s6[4]);
							
							set(s1[1]);
							s1[1][1],s1[1][2],s1[1][4]=22,22,2;
							set(s1[1]);
						Light();
						script_say("���壺̫��ɽ������̷����̷������ٳ�ݵ�����ʧԶӭ���Ƿ�����л����")
						Dark();
							set(s6[5]);
						Light();
						script_say("̷�ţ�ʦ�֣���������ʲô���Ҵ����ƨ�ɣ�")
						script_say("̷�����ҵ���˭��ԭ�����㡣")
						script_say("��Ǯ�С�꣬�������ÿ��ô��")
						Dark();
							set(s6[6]);
							set(s6[7]);
							set(s6[8]);
							set(s6[9]);
							set(s6[10]);
						Light();
						script_say("�ⳤ�磺̩ɽ���۵��ˣ��ü����ü���ʲô������Ǹ������������ˣ�")
						script_say("����ɽ�������壬����Ҳ���ˡ�")
						Dark();
							set(s6[11]);
						Light();
						script_say("�������ǰ������������������������ˡ�")
						script_say("���壺��֪����ǰ����ݹ��٣����Զӭ���ǡ�")
						script_say("��Ǯ����ۣ������йٵ������͸�Զӭ���ҡ���ƨ���й١���������Ͳ���Զӭ�ˡ�")
						script_say("������������˳����𻰡�")
						script_say("����ˣ�δ�����������ϣ��μ�������")
						script_say("���壺ɩɩ������")
						script_say("����ˣ��ȷ������ʣ���а�������λ������������ɥ�£�δ�����������С�")
						script_say("���壺һ��֮�䣬�ܻ����λǰ�����ˣ��ǲ�ʤ����֮������֪��λ�ݵ����кμ��̣�")
						script_say("�������ǰ���������ǽ����ϵ�һ���������������������£�����������ؤ����֣�˭��ʮ�־��أ��ҵ�ĳ����Ҳ�Ǽ�Ϊ���ǵġ�")
						script_say("���壺���ң�")
						script_say("�쳤�ϣ�̩ɽ���ָ��ӣ�̫��ɽ̷�Ϸ򸾣��Լ���λ��̨�����ջ�Ȼ���٣��ְ�ȫ�����¾��й�衣����ˣ�������ͷ˵��ա�")
						script_say("����ˣ��ȷ�����ʣ�СŮ��ֻ����Թ���࣬�����ȷ�δ����һ�а�Ů�������������̡���СŮ�������ȷ�֮�󣬼����������ղ�ȭ��֮��������һ���û������ܷ�̵����š���Ƥ��д�����������������ޣ����������ٻ��������߼�Ϊ�������壬�����Ȫ�������������ڷ���������������������ϻ�ͬ���ģ��¹��ش󣬲������󡣡��Ҽ��ȷ�д��֣�أ�֪���¹��ش󣬵�����Ҫȥ����������������飬�Һð�����ͬ��λ���ϣ�������Ϊ�ȷ򱨳����ˣ�������ˣ����û�ܼ������š���֪�����漰���д��£���������ϼ�Ȼ���������������µ���ʱ����������֣������쳤�ϣ��������ţ��������˼��������Ժ�����飬���쳤�ϸ�֪��λ��")
						script_say("�쳤�ϣ�����˵������ԹԹ���Ͻл������Ϊ�ѡ����������Ԫ�����顣��Ԫ�����桢�游�����ף���������ؤ�����ˣ����ǳ��ϣ����ǰ˴����ӡ����ۼ���Ԫ���׳������ıʼ������ϵú�����ġ����ŷ��ϵ��֣�ȷ�Ǵ�Ԫ��д������˽��Ž���������֮ʱ�����ϵĻ�����Ȼ�����ã����˶�������Ҳ�������˴��£����Ȼ�ͬ��λ���ϣ��㼴�������ˡ�����֮ʱ��̫��ɽ�����йٵ���Ҳ��������������֤��")
						script_say("������������ʱ��������֣�����ϸ������ͣ����ۼ���������������š�")
						script_say("�쳤�ϣ���һ�������ż㣬�������ּ������پ��������Ǵ�Ԫ��д��΢�о��棬���Ͽ�д���ǡ��������֡����֣�������֡���λ��֪���������ס����֣��Ǳ���ǰ���������ı�ţ������Ǹ����������֮�ˣ�������˳ƺ����������������Ѿã���ô����д���������Ҳ���������д���֣��ȿ���β����֮�ˣ�һ��֮�£����ǲ��졣��ʱ�Ҳ������ס���һ����˵������ԭ�������������ֺ�������̽ͷ����һ����Ҳ��������ף�ԭ������������λ�ֵܣ�����д����ŵ�����˭���Ҵ˿̲�����������ĳ��ؤ����ʮ���꣬����ʮ��������ɽ�֣����ٴ�����������������������Թ������������Ϊ���޶࣬�����������ͽ�ܣ����ʾ��ް��˽�ġ���˵���仰����λ���ǲ��ţ�")
						script_say("ؤ����ӣ��쳤�ϵĻ�����˭���ţ�")
						script_say("�쳤�ϣ�����������Σ�")
						script_say("���壺��ĳ���쳤���������أ�ǰ����֪��")
						script_say("�쳤�ϣ��ҿ��˴���֮��˼�����ã������ɻ�������Ψ������������������Ž��ڵ��ֹ�Ŀ�����ֺ�д��֮���������ã��ϵ����ıʼ������¹���̫����Ҫ�����������ŵ���α�����֣����������˵˵������������α��")
						script_say("���������º�д��֮�˶����ཻ�����²����д������Ŷ�⣬�������쳤�ϡ������һͬ�ϵ����£�������ŶԱȣ��ּ���Ȼ��ͬ�����ż��ŷ�Ҳ��һ�㣬�������漣���ɡ�")
						script_say("�쳤�ϣ��������˼��꣬����������ϸ���ο�����ǣ�汾����˥���ˣ��й�һλӢ�ۺ��ܵ�������������ο���ð�����£������֪̫��ɽ̷����ٳ��д��֮������ԨԴ������ȥ��������̷����ٳ��̡�̷����̷�Ž����м��һ��ԭί���ۣ�һһ������˵������������ʵ�ǲ������ԣ�������ϧ���ɱ���̾��̷��˵��������һλʦ�֣��ڴ���������Ŀ�����������׿���˵���������ײ���������λʦ�֣�������Ǯ�������ˡ���λ������Ƣ���ͱ������в�ͬ��������������������̷�ŵ����Ӽ���Ƭ���ȥ����λ������Ӧ�ٶ�������")
						script_say("̷������ô������ȥ��������ô���������Ȳ�����˵��������͵͵������")
						script_say("̷�ţ�ô������͵͵��������д���ţ�Ҫ�쳤��ǲ����ȥ�����ǹ�������֮�¡������㰮�ȸɴף���������߶���������ɲ�����˵��")
						script_say("̷�����������£����ظ������ǾͲ��ã�")
						DrawStrBoxWaitKey("̷�Ŵ���̷��һ������");
						script_say("�쳤�ϣ���Ǯ�����������㵱��˵һ�䣬��������д֮�£��Ƿ񲻼١�")
						script_say("̷�ţ�ʦ�磬�쳤�����㣬���������Ź��⣬��ʯ��ǰ��һ��Ѫս�����������Ԥ�ģ���ʱ�������Σ��������˵˵��")
						script_say("��Ǯ����Źء������Źء�����������")
						script_say("�ǹ⣺�����ӷ�")
						Dark();
							set(s6[12]);
							
							set(s1[1]);
							s1[1][1],s1[1][2],s1[1][4]=22,22,3;
							set(s1[1]);
						Light();
						script_say("�쳤�ϣ�̨ɽ֪���ʦ���ˣ���ʮ���겻������ʦ��Ȼ����彡���ǹ��ʦ�����������˲���������ʮ���������Ѳ��ʽ��������񡣽��շ�ݹ⽵��ʵ��ؤ��֮�������¸м�������")
						script_say("�ǹ⣺ؤ���쳤�Ϻ�̫��ɽ���й������ۼ����٣��������Ҳ�������̨ɽ��������಻Զ����λ�����ֵ��������й����²������ˣ��Ե����١�")
						script_say("��Ǯ����Ź�����ʯ��ǰ�Ĵ�ս���ǹ����Ҳ���зݵģ�����˵�ɡ�")
						script_say("�ǹ⣺�ã����Ĵ�ǰ�����˵��£�Ҳ���������������ˣ��ֺα��������ˣ���ʮ��ǰ����ԭ���ܽӵ�ѶϢ��˵�������д�����ʿҪ��͵Ϯ�����£��뽫�����ز���������书ͼ�ף�һ�ٶ�ȥ������µ����ͬС�ɣ�Ҫ�������˾ٳɹ������α�������֮�����һƵ�����˵�����ʹ����֣����������ɱ��ĳ�ì����֮�£����������ڽ�����������Ӽ��飬��˵��Щ������ʿҪ�������ţ�һ������֪ͨ�������ϼӽ䱸������������̸�ȥ��Ҫ�����Ź���ӭ�����ݲ��ܾ�����֮����ҲҪ�����ǵļ�ı���Եóѡ��ǰ������������֪������ѶϢ���Ǳ���Σ�")
						script_say("���壺�ǹ��ʦ����ĳ��ʶǳª���ŵ²����Է��ڣ���������ֵܼ��ɣ�˵����������������ĳ��Ȼ���ܣ�ȴҲ�Ǹ��иε����й������ж����������ڴ�����Ͼ����²����Ƿǡ��Ҵ������ɹ����裬�ҹ�֮��˭��˼����������֪������ѶϢ���Ե���ͬ������֣���ҹ��ȥ��ء�")
						script_say("�ǹ⣺���˵��������ǰ�����Ź����������֮�٣����ǰ����������ǲ���ģ�")
						script_say("���壺��λǰ��Ӣ�����ң���ĳ�����ý����޲�������ʮ�꣬����׷�����ͣ�����������к�²��")
						script_say("�ǹ⣺�������Ź�ʱ���ѽ����ƻ衣���ǳ�������ʮ���һ·С�Ľ䱸��ͻȻ֮�䣬�������ϴ�����ƥ����֮��������������Ҳ��ʮ�����ͷ���߾����֣�������ͣ�������������������ǻ�ϲ�����ǵ��ţ�ûһ��˵һ�仰����ϲ���ǣ���Ϣ��ȻΪ�٣��Һ����Ǻ�������ĸϵ��������ܼ�ʱ���衣�����˾�֪��Ϯ��������ʿ����ʮ������֮�������߲��������߲��ƣ��ȸ���������ѧ��̩ɽ�������������ƣ���Ȼ����������ǧ����������ѡ����ʿ�����κ��������̣������ܶ�ʤ�٣�����֮ս�ܷ��ʤ��ʵ����˵֮�����ǰ��������³ɰܣ����������ι��ˣ�����ǧǧ������յ�������������ȴ��ȷ����ʤ���ա�Ψһ�ı��ˣ�ֻ�����ǵ������������ڰ���������Ǹõ���β��ǣ�")
						script_say("���壺����������թ������������������ܽ�ʲô�������塢���ֹ�ء��ɹ�ɱ¾�Ҵ��ΰ���֮ʱ���ֺγ����������ˣ�������֮�������ð���������֮�ϣ���ι�綾��")
						script_say("�ǹ⣺���ǡ��ǰ���֮����ǡ�����ǵ�ʱ����һģһ����������ι���İ���ɱ������ʮ���ˣ�����������ǵķ������֮��ʱ��Զ�����������ˡ�������Ϊ��ǰ��ʮ���������ն������������˷������������Ǳ�һӵ���ϡ�������Ϊһ����Ů���е��书֮�ߣ������ס���������߰���֮�ࡣ������Ů��ȴ��ȫȻ������ѧ����һ��ֻһ���㽫����ն�£���ʱ�����ǲŷ����������б���һ��Ӥ��Ҳ������һ�µ�����ϡ����Ǿ���������Щ���ԣ���ȫ��ɱ�����ۣ���Ů�ӱ㱻ɱ�ˡ����еļ�Ů�Ӳ�����ʹ��һ����ȴ��һ���ݽ�����һһ���˵㵹������ֻ����Ҫ������һһ��ĥ������ȴû�뵽�����������Ź�һ��ʯ�Ͽ���Щ�����֣��㱧��Ů�ӵ�ʬ�����Ӥ��ת�����������¡���ʱ�����˱��������Ʒ���Ϯ��ˤ��һ�ԣ�ȴ���˰�����ӣ�ȴҲ���û�����Ѩ��������������֮���ұ���������Ҫ��ȥ�鿴����֪һ����죬ȴ���Ǹ�Ӥ�������������������������������������ϣ����ں�����ޡ��ҽ⿪�����˵�Ѩ������Ҿ����ô��¹��죬�������ǵ������룬�����뿴�����ӵ����ԣ�ȴ������ʶ�������֣�ֻ����Ѫˮ���Ǳ��������������˼���ʶ�������ĵ�С�����룬���յ�֪����������ࡣ������������ȷʵ��ˣ���������ѳ�ѵ��ֵ�����ԩ������Щ������Ҳ���޹����ۣ��ǶԷ����Ǹ�����ֵĶ����ǲ��𰡡�")
						script_say("���壺�����྿���ǺΣ�")
						script_say("�ǹ⣺�����������������ӡ���������ʯ������дȷ��ʵ�飬��ô��ͷ��硢���������ҵȵ�������Ϊ��ȴ�Ǵ���ش����ǹ���������С�䣬�㲻��ʲô�����Ǵ�ͷ�����������ε���ݵ�λ���ο���������Ȼ���������ٲ�����������λ������")
						script_say("���壺�⡭����Ȼ��ˣ������±㲻�ٹ����ˡ�")
						script_say("�ǹ⣺�������˲�Ը������ʵ��ˣ����ֲ��ò��š����¾���������Ӥ�������������е�����ȥ�鿴����������������ʿ��Ȼ�����Ϯ����ն�ݳ���Ҳ���١��Ǵ����־ۻᣬ��·��Ԯ��Ӣ��Խ��Խ�࣬Ȼ�������¹�ȥ�ˣ������Ǳ�ȴ���ް�㾯�ģ���������Ѷ֮��ȴҲ��ʧ���١���������϶���ѶϢ�Ǽ٣��������������ɡ����Ƕ������������������ǲ������������������վ������������ݻ������ǣ���������ɽ��Ѱ��һ��ũ�ң�������������Ӥ����ֻ�Ǵ���ɳ����в��������֪����֮�¡���ũ�˷򸾱�����Ϣ�����ǻ�ϲ�Ĵ�Ӧ�ˡ�")
						script_say("���壺�ǹ��ʦ�����ǡ�����ũ�ˡ�������������������ʲô��")
						script_say("�ǹ⣺�����µ�����Ҳ������������ũ�����ǣ����ֽ���������")
						script_say("���壺�����������˵�˵��������ú��ˣ������������������������˵��")
						Dark();
							set(s1[1]);
							s1[1][1],s1[1][2],s1[1][4]=20,23,3;
							set(s1[1]);
						Light();
						DrawStrBoxWaitKey("����һ��ץס�ǹ�");
						script_say("�쳤�ϣ��ǰ������ǹ��ʦ���������˾������㲻���˺���������")
						script_say("���壺���Ƿ��������ԩ�޳����ǡ�������Ҫ��ȥ�Ұ���֮λ����Ҳ���ˣ��ҹ������˱��ǡ�Ϊ�Ρ���Ϊ��Ҫ������˻������������ң��ҡ�����ĳ��������ʲô���£�������˿����ң�")
						Dark();
							set(s1[1]);
							s1[1][1],s1[1][2],s1[1][4]=22,22,2;
							set(s1[1]);
						Light();
						script_say("��Ǯ���Ц��Ц������δ�ظ���һ�ȣ�������Ҳδ�������磡�����������ˣ�ȴӲҪð�人�ˣ�����ʲô��ζ�����Լ���������ĸҲ�����ϣ����Գ�ʲô���Ӻ����ɷ�")
						script_say("���壺��Ҳ˵���������ˣ�")
						script_say("��Ǯ��Ҳ�֪������֪���������Ź�һ�ۣ���������ʿ����ɱ���˵��ӣ���Ϊ�Ҷ����ج�Σ������˵���ò�������оų����ơ�")
						script_say("�ǹ⣺�����������ʦ������Ѱ����ɽ��������ѧ��ͬʱ����𷨣�������ĥȥ������Ѫ��֮�е�����������������������ؤ������������Խ̵�����������������㻹�Ƿ����������������Ϊ�˿��������������ʺ�Ϊؤ�����²��ٺ����ͣ�����ؤ������һ�ġ�����������Ϊ��������������������֮�ʣ��������������⣬���ߴ���֮�����Ž��򹷰������ڡ������ؤ�����֮�����Խ����е�֪�����������壬�츣���񣬴��¹��ʣ���ؤ�����ٵĺ�����������֮�������µ�һ����������Ȼ��������˵ļ�ı��֮ǰ�����ݻ����뷨������������졣���±������������𡣽���ȴ�����˳��������ؤ����ǰ�������������ʲô���°���")
						script_say("�쳤�ϣ��ǰ��������������������飬�㵱�ϵó����ıʼ���")
						script_say("���ţ�����ؤ�����������������ϡ�ִ�����ϡ�����ϣ��Ƿ����������Ѻ����������������֮���ߣ�ȫ�Ｔ�к�����ɱ�����������¶��д̣����޲��ɣ��������й��������ͨ�ױʡ���������Ԫ���������³�����")
						script_say("�쳤�ϣ��ǰ����ݹ���������ԭ�������ͱ�ֻ��������һ��֪�����������������¹������䣬����û��˿��ͨ�����ε����飬����������ò��ŵġ�ֱ������������������˲�Ѱ����������š��������������������ǹ���Ľ����������������Ϊ��Ԫ�ֵܱ��˴˳𣬰���������������ԭ�޽��Ʊ�Ҫ������˼֮������Ϊ������룬�������������ţ����ǡ���һ�������ʹ�з�𡣶����ǰ���̻�����ˣ�������Ϊ��ʵ��Σ�������")
						script_say("���壺��̻�����ˣ����´Ӻ�˵��")
						script_say("�쳤�ϣ���Ľ�ݡ����֣����Ǻ��ա�Ľ�������ʱ����ᣬ������һ�㣬ͬΪ��²�ĵҡ�")
						script_say("���壺����֮���Է��ң�����Ϊ֪�������������ᣬ��Ҳ���ǣ�")
						script_say("ȫ���壺û��")
						script_say("����ˣ���ʵ������һ�¡����ҽӵ��ȷ�ج��֮ǰ��һ����䣬��Ȼ���������Ҽ���͵�����������������ĵ�Ѭ�㣬���Ҽ������ūѬ�������䵹�����ȥ��ʮ�������ӡ������ұ�ӵ�ج�ģ����ﻹ����˼ȥ�����£�ֻ�Ǻ�������������ţ����ڴ���ǽ��֮��ʰ����������֮����¾��ţ���֪���·�ͬС�ɡ�����λ��������������")
						DrawStrBoxWaitKey("������ó�һ������");
						script_say("�쳤�ϣ��⡭�����ǡ���")
						script_say("���壺�쳤�ϣ�����������ҵġ�")
						script_say("�쳤�ϣ������������������������������ı��찡����")
						script_say("���壺��ĳ���������������ý������Լ�δ��ȷ֪�������������ǰ��ָ������ĳ�뵱�����������ࡣ��ؤ�������ְλ���Ե���λ���͡�")
						DrawStrBoxWaitKey("���彻���򹷰�");
						script_say("����Ϫ���ǰ������������㣡�Ҳ�֪��ʲô������ʲô���ˣ������ǰ�����ô����������������Ϊ��Ҷ���������ǰ�����������ô�����ˣ��Լ�������������Ҫ����С�˵�������")
						script_say("ؤ����ӣ��ԣ��������Ű�����")
						script_say("ȫ���壺��λ�ֵܣ����Ƕ��Ǵ��ΰ��գ���������һ�������˵ĺ���Ƿ�ı���Խ�󣬴��Խ��Σ�հ���")
						script_say("��ɽ�ӣ����ƨ��")
						script_say("ؤ����ӣ��ҿ�����������߹���һ����Ҫ���߰�����")
						script_say("���壺���ֵ�ͣ�֣�����һ�ԡ���ؤ����������Ǿ��Ʋ����ˡ���ʦ�������ıʼ�����������١����ǣ�ؤ���������µ�һ�����������ɱ��������Ц������ĳ��ȥʱ��һ�Է�棬����˭��һȭһ�ż��ڱ����ֵ����ϣ����Ǳ���Ī������ˡ�")
						script_say("����ˣ�������ɱ�˱��︱�����ֵ���Σ�")
						script_say("���壺ɱ���ߵ�����������������˭����������˭�ݺ���ĳ���վ�����ˮ��ʯ��������ˣ�����ĳ�����֣���Ҫ���㸮��ȡʲô�������������ֶ��飬������ʧ��ʲô���������˵ֻ����������Ů��֮�������ǻʹ���Ժ��ǧ������֮�У���ĳҪȡʲô���Ҳδ�ز��ܰ쵽����ɽ���ģ���ˮ��������λ�ֵܣ������ټ��ˡ���ĳ�Ǻ���Ҳ�ã���������Ҳ�ã�����֮�꣬������һ�����˵���������Υ���ģ�����˵���")
						DrawStrBoxWaitKey("������������������������");

						if true then--JY.Person[0]["����"]==9 and JY.Person[261]["�Ѻ�"]>=40 then
							script_say("���ǣ��ǰ���......");
							if DrawStrBoxYesNo(-1,-1,"�Ƿ���������뿪ؤ��") then
								SetFlag(19005,1);
							end
						end
						script_say("���壺�Ƿ�ȥҲ��")
						JY.Person[261]["����"]=0;
						script_say("ؤ����ӣ��������ߣ�")
						script_say("ؤ����ӣ�ؤ��ȫ�������ִ�֣�")
						script_say("ؤ����ӣ������������")
						if GetFlag(19005)==1 then--������Ϊؤ����ӣ�������ø��㹻��ѡ��������塿
							script_say("���ǣ��ǰ������������Ǻ��˻��������ˣ��Ҷ�ֻ����һ�������ƽ����ؤ�ֻ��Ϊһ����û��Ū��Ļ��ɣ��㽫���հ�������Ϊȫ��Ĩȥ������Ⱥ�����֮������һƥ��ȴҲ֪�ܡ��ҳ��������ǳ��ֵ��ܡ��Խ������ұ㲻����ؤ������ˣ��ǰ��������ĺ��ǣ���Ҫ�ߣ��ұ�����ߣ���Ҫ���������ұ����顣")
							script_say("���壺�ã�û�뵽��ʱ���գ������ֵ�����˿�������ĳ�����Ժ�������Ƿ���ֵ��ˡ������ߡ�")
							JY.MyPic=0;
						end
						Dark();
							set(s1[1]);
						Light();
						script_say("�����棺ʲô��ƨ��һ������Ϊһ�����˵����ţ��Ͱ������ǰ���Ϊؤ�����µĺ�����ȫ��Ĩɱ�ˡ���λ���ϣ��ǰ����ոջ����Լ���Ѫ��ϴ�������ǵ�������������ڵ����ӣ�������ô���ޣ���ʲô��ؤ����ӣ��һ���ϡ���ˣ��Խ���������������Ҳ����ؤ�����ˣ�һȺ���Ĺ��εĶ������ޣ�")
						JY.Person[289]["����"]=0;
						script_say("�쳤�ϣ��������վ���ôɢ�˰ɡ�����������ѡ����֮�¡�")
						script_say("��������硭��")
						Dark();
							for i,v in pairs(s2) do
								clean(v);
							end
							for i,v in pairs(s3) do
								clean(v);
							end
							for i,v in pairs(s4) do
								clean(v);
							end
							for i,v in pairs(s5) do
								clean(v);
							end
							for i,v in pairs(s6) do
								clean(v);
							end
						Light();
						if GetFlag(19005)==1 then--��������������뿪��ĳ����
							Dark();
								JY.Base["��X1"],JY.Base["��Y1"]=59,59;
								JY.MyPic=GetMyPic();
								s1[1][1],s1[1][2],s1[1][4]=58,59,1;
								set(s1[1]);
							Light();
							script_say("���壺�ֵܣ���ĳҪȥ̽���������ٲ���Ҫ���ｭ����������ѡ�ֻ���ֵܡ���")
							script_say("���ǣ���������֪���Լ��书��΢������ĵ�ȥ�ɣ��һ�һ�߿����书��һ�����о�֮�д�����Ϣ�ġ�")
							script_say("���壺�Ǿ������ֵ��ˡ������ɣ������ȴ������з���ɡ�");
							local kflist={
											{162,10},
											{169,10},
											{171,10},
											{172,10},
										};
							LearnKF(0,261,kflist);
							script_say("���壺�պ���������Ե�پۣ����ٽ��㡣���У���ĳ�Ѿ����ǰ����ˣ����������������һ�����ɡ�")
							script_say("���ǣ��ţ���磡")
							script_say("���壺���������벻��������ĳ���������������ʹ�޵������ˣ�ȴ���ܽ�����ôһλ���ֵܣ���������������Ҳ��������ֵܣ���������䣬���ȥ�ˡ�")
							--��������ʧ��
							Dark();
								set(s1[1]);
							Light();
							script_say("���ǣ�����磬��һ��������������ģ���")
							JY.Person[0]["����"]=0;
							--�����ǳ�Ϊؤ����ͽ��
							--���¼�������
						end
					end,
				
			};
	SE[55]={
				kind="����",
				trigger=function()
							if GetFlag(19005)==1 and JY.Da==261 then
								if DrawStrBoxYesNo(-1,-1,"�Ƿ�����������书") then
									return 1;
								else
									return 0;
								end
							end
							return 0;
						end,
				go=	function()
						script_say("���ǣ���磡�����ҵ����ˡ�")
						script_say("���壺�������벻�������������ˣ�")
						script_say("���壺�������ѧ�Ͽ���ʲô������")
						local kflist={
											{162,10},
											{169,10},
											{171,10},
											{172,10},
										};
						LearnKF(0,261,kflist);
						script_say("���壺С�ֵܣ���Ե�ټ���")
					end,
			};
	SE[101]={
				kind="�Ի�",
				trigger=function()
							if 	GetFlag(20001)==0 and
								JY.Person[0]["����"]==-1 and
								JY.Person[JY.Da]["����"]==10 and
								JY.Person[JY.Da]["�Ѻ�"]>30 and 
								Rnd(4)==1 and 
								(JY.Person[JY.Da]["����"]=="Ľ�ݸ�" or
								JY.Person[JY.Da]["����"]=="����ͬ" or
								JY.Person[JY.Da]["����"]=="��ұǬ" or
								JY.Person[JY.Da]["����"]=="�粨��" or
								JY.Person[JY.Da]["����"]=="�˰ٴ�") then
								return 1;
							end
							return 0;
						end,
				go=	function()
						SetFlag(20001,1)
						local name=JY.Person[JY.Da]["����"];
						script_say(name.."��С�ֵܣ�����һ����ʣ��ཻ��������β���������Ľ�ݼң��պ����Ҳ������Щ��")
						script_say("���ǣ����д��⣬ֻ�ǲ�֪��β��ܼ���Ľ�ݼ��أ�")
						script_say(name.."��С�ֵܺβ���˵����ȥ���ճǣ�����һĽ�ݼҽ�����˵�����⣬���Ի����ǰȥ������ġ�")
						script_say("���ǣ��á������ھ�ȥ��")
					end,
				
			};
	SE[102]={
				kind="����",
				trigger=function()
							if 	GetFlag(20003)==0 and
								GetFlag(20002)==1 and
								JY.Person[0]["����"]==10 and
								JY.Person[JY.Da]["����"]=="������" then
								return 1;
							end
							return 0;
						end,
				go=	function()
						SetFlag(20003,1)
						script_say("���ǣ��μ���С�㡣")
						script_say("�����̣���ʲô����")
						script_say("���ǣ��������ġ�С�������Լ���ʩˮ���в�û�и����ķ�������˵��С����֪������ѧ���������С����̡�")
						script_say("�����̣���Ȼ�Ǳ���Ҫ�����ұ㴫��һ��[��Ԫ��]�ɡ�")
						script_say("���ǣ�л��С�㣡")
						script_say("�����̣��Ҳ����������Ļ���Ҫл��Ҫȥл��硣")
					end,
			};
	SE[801]={
				kind="�Ի�",
				trigger=function()
							if 	GetFlag(65001)==0 and
								Rnd(50)==1 and
								JY.Person[0]["�ȼ�"]>JY.Person[JY.Da]["�ȼ�"]+10 and
								JY.Person[JY.Da]["����"]=="���" then
								return 1;
							end
							return 0;
						end,
				go=	function()
						SetFlag(65001,1);
						script_say("��쳣�������Ҫ�����ҼҴ�����ȱ����ҳ����")
						script_say("���ǣ��ף�����磬������ô�£�")
						script_say("��쳣�����˵��������������������ѣ��������ף�����������ֻ��ƴ����ס�Ҵ��ĵ��ף������պ��������书���Ա��ҳ���֪����һ����ҽ�����ڻ���֮�У�ȴ�ǽ������е���ҳ˺�´��ߡ����������������ģ����ǲ�ȱ�ĵ�����Ҫ���ҵ��ꡭ������������Ҳ�ա���")
						script_say("���ǣ���һ������ҽ�������պ������⣬�����ܲ��ܰ�����Ѱ�ص��ס���")
					end,
			};
	SE[802]={
				kind="Ϯ��",
				trigger=function(flag)
							if flag and GetFlag(65001)~=0 and GetFlag(65002)==0 and JY.Person[JY.Da]["����"]=="�ֻ�" and Rnd(2)==1 then
								return 1;
							end
							return 0;
						end,
				go=	function(flag)
						SetFlag(65002,1);
						script_say("���ǣ����ף�������ֽ�ǡ������ף���");
						DrawStrBoxWaitKey("�õ���ҳ����")
					end,
			};
	SE[803]={
				kind="����",
				trigger=function()
							if 	GetFlag(65002)~=0 and
								GetFlag(65003)==0 and
								JY.Person[JY.Da]["����"]=="���" then
								return 1;
							end
							return 0;
						end,
				go=	function()
						SetFlag(65003,1);
						script_say("���ǣ�����磡�������ڽ�����������żȻ��������ҳ���ף��㿴����")
						script_say("��쳣��ף��ҿ������������������Һ��ҵ�������ʧ������ҳ���ף��ֵ������ǴӺζ������ģ�")
						script_say("���ǣ�������һ�˴򶷣����˲��ж��ӣ���������������ҳ���ס�Ī�����˱��ǵ���ĵ���ҽ����")
						script_say("��쳣����������벻�ǣ��⵶��˵�������뵱��֮�±�����ϵ���ߣ����ҽ�����ҳ����������������ѧ֮�У��Ҷ�Ҫ�����ʸ�ˮ��ʯ����")
						script_say("���ǣ�����������ղ������ࡣ")
						script_say("���ǣ��ֵܣ��������л��")
						JY.Person[JY.Da]["���"]=6;
						for i=1,60 do
							AddPersonAttrib(JY.Da,"����",math.modf(JY.Person[JY.Da]["�ȼ�"]*5000/(120-JY.Person[JY.Da]["����"])));
							War_AddPersonLevel(JY.Da,false); 
						end
						
					end,
			};
	SE[804]={
				kind="����",
				trigger=function()
							if 	GetFlag(65003)~=0 and
								JY.Person[JY.Da]["����"]=="�ֻ�" then
								return 1;
							end
							return 0;
						end,
				go=	function()
						script_say("���ǣ��ֻ�����Ϊʲô�����Һ����ļҴ����ף����ǲ��Ǿ��ǵ�����Ǹ�����ҽ����")
						script_say("�ֻ������ã��������������ˣ�������")
						Dark();
								SetD(JY.SubScene,JY.CurrentD,0,0);
								SetD(JY.SubScene,JY.CurrentD,3,-1);
								SetD(JY.SubScene,JY.CurrentD,5,0);
								SetD(JY.SubScene,JY.CurrentD,6,0);
								SetD(JY.SubScene,JY.CurrentD,7,0);
						Light();
						script_say("���ǣ�ʲô���ɶ񣬾�Ȼ���������ˣ�")
					end,
			};

	SE[901]={
				kind="Ϯ��",
				trigger=function(flag)
							if flag and (	JY.Person[JY.Da]["����"]=="���" or
											JY.Person[JY.Da]["����"]=="С��Ů" or
											JY.Person[JY.Da]["����"]=="��Ī��" or
											JY.Person[JY.Da]["����"]=="����Ⱥ" or
											JY.Person[JY.Da]["����"]=="Ľ�ݸ�" or
											JY.Person[JY.Da]["����"]=="�����" or
											JY.Person[JY.Da]["����"]=="����" or
											JY.Person[JY.Da]["����"]=="���ʦ̫" or
											JY.Person[JY.Da]["����"]=="������ʦ" or
											JY.Person[JY.Da]["����"]=="һ��" or
											JY.Person[JY.Da]["����"]=="����") then
								return 1;
							end
							return 0;
						end,
				go=	function(flag)
						local n=0;
						local kflist={};
						for i=1,10 do
							if JY.Person[JY.Da]["�����书"..i]>0 then
								n=n+1;
								table.insert(kflist,{JY.Person[JY.Da]["�����书"..i],limitX(1+math.modf(JY.Person[JY.Da]["�����书����"..i]/100),1,100)})
							end
						end
						if n>0 then
							say("�����յ�һս���ո���ʹ���书�����������ҸϽ���������");
							LearnKF(0,JY.Da,kflist);
						end
					end,
				
			};
	SE[902]={
				kind="����",
				trigger=function()
							if JY.SubScene==99 then
								return 1;
							end
							return 0;
						end,
				go=	function()
					Dark();
					migong(14,28);
					if Rnd(2)==0 then
						SetS(JY.SubScene,14,5,1,0)
						SetS(JY.SubScene,15,5,1,0)
						SetS(JY.SubScene,16,5,1,0)
						SetS(JY.SubScene,17,5,1,0)
						SetS(JY.SubScene,18,5,1,0)
						SetS(JY.SubScene,19,5,1,0)
					else
						SetS(JY.SubScene,14,56,1,0)
						SetS(JY.SubScene,15,56,1,0)
						SetS(JY.SubScene,16,56,1,0)
						SetS(JY.SubScene,17,56,1,0)
						SetS(JY.SubScene,18,56,1,0)
						SetS(JY.SubScene,19,56,1,0)
					end
					SetS(JY.SubScene,45,36,1,0)
					SetS(JY.SubScene,46,36,1,0)
					SetS(JY.SubScene,47,36,1,0)
					SetS(JY.SubScene,48,36,1,0)
					SetS(JY.SubScene,49,36,1,0)
					--JY.Base["��X1"]=JY.Base["��X1"]-1
					Light();
				end,
			};
	SE[999]={
				kind="",
				trigger=function()
							return 0;
						end,
				go=	function()
					end,
				
			};
	
	
	
	
	
	
	
	for i,v in pairs(SE) do
		if v.kind=='����' then
			table.insert(PE.meet,v);
		elseif v.kind=='�Ի�' then
			table.insert(PE.talk,v);
		elseif v.kind=='Ϯ��' then
			table.insert(PE.fight,v);
		elseif v.kind=='����' then
			table.insert(PE.entrance,v);
		else
		
		end
	end
end