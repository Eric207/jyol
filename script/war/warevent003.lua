--����ϴ��
if WAR.tmp[2]==nil then
	if JY.Person[0]["����"]==5 then
		if JY.Person[113]["����"]/JY.Person[113]["�������ֵ"]<1 then
			lib.Delay(500);
			Dark();
			WE_addperson(0,29,16,0,200,false);
			WAR.CurID=WAR.PersonNum-1;
			WarDrawMap(0);
			Light();
			say("ʦ�壬��ս��ս�پ���");
			WAR.tmp[2]=1;
		end
	else
		WAR.tmp[2]=1;
	end
end
if WAR.tmp[1]==nil then
	if JY.Person[50]["����"]/JY.Person[50]["�������ֵ"]<0.95 then
		lib.Delay(500);
		Dark();
		WE_addperson(52,24,13,3,900,true);
		WE_addperson(53,33,13,3,800,true);
		--WE_addperson(65,25,13,3,700,true);
		--WE_addperson(63,32,13,3,600,true);
		WE_addperson(64,26,13,3,500,true);
		WE_addperson(62,31,13,3,400,true);
		if JY.Person[0]["����"]==2 then
			WE_addperson(0,30,14,3,300,true);
		end
		WAR.CurID=WAR.PersonNum-1;
		WarDrawMap(0);
		Light();
		say("ʦ����������������",52);
		say("��ɽ������̫���ˣ�",53);
		say("����֮�£����������޹أ������ֺα�......",50);
		if JY.Person[0]["����"]==2 then
			say("������ʦ�ź�����岻�ฺ�����ŵ��ӣ��Ͷ�ʦͬ��������");
		else
			say("������ʦ�ź�����岻�ฺ�����ŵ��ӣ��Ͷ�ʦͬ��������",52);
		end
		say("�ߣ�����������������������",113);
		JY.Person[50]["�⹦2"]=35;
		JY.Person[50]["�⹦����2"]=900;
		--AddPersonAttrib(50,"����",500000);
		--War_AddPersonLevel(50,true)--false); 
		if JY.Person[0]["����"]==2 then
			if GetFlag(12001)==1 then
				say("��ɽ�ɽ���������Ϊ����λ����Ī��Ҫ�����Թ۲��ɣ�");
				say("��������һ��ͬ����֦����ʦ���������Ϊʵ�ڲ��԰���",1);
				say("���ǣ����ձ�Ҫȥ����ʦ���ָ�����",66);
					Dark();
					SetWarMap(25,17,1,0);
					SetWarMap(25,16,1,0);
					SetWarMap(25,15,1,0);
					WE_addperson(1,24,16,1,750,true);
					WE_addperson(8,24,15,1,550,true);
					SetWarMap(32,17,1,0);
					SetWarMap(32,16,1,0);
					SetWarMap(32,15,1,0);
					WE_addperson(66,33,16,2,750,true);
					WE_addperson(75,33,15,2,550,true);
				Light();
				say("��λ����Ԯ��֮�����Һ�ɽ����û������");
			end
		elseif JY.Person[0]["����"]~=1 and JY.Person[0]["����"]~=5 then
			if DrawStrBoxYesNo(-1,-1,"�Ƿ���������磿",C_WHITE,CC.Fontbig) then
				say("��ɽ�ɽ���������Ϊ��ʵ������̫����");
				if JY.Person[0]["����"]==0 then
					say("���֣�����������",1);
					if true then
						say("��....");
					else
					say("ʦ��������������һ��ͬ����֦����������Ȼ�󽻷��ˣ����Ѿ����˳��������αط�ҪΪ��������");
					say("���......",1);
					say("�ð����㻪ɽ��ԭ��Ҳ��Ҫ���������粻�ɣ�",113);
					say("����֮�£�ԭֻΪ������һ�ˣ������ʦ�ܲ�Ҫ����ɱ����",1);
					say("��ɽ���������£����ŵ��ӣ�����ͬ����һ��������",113);
					say("��ˣ������ˡ�",1);
					Dark();
					SetWarMap(25,17,1,0);
					SetWarMap(25,16,1,0);
					SetWarMap(25,15,1,0);
					WE_addperson(0,24,17,1,650,true);
					WE_addperson(1,24,16,1,750,true);
					WE_addperson(8,24,15,1,550,true);
					WarDrawMap(0);
					Light();
					end
				elseif JY.Person[0]["����"]==2 then
				
				elseif JY.Person[0]["����"]==3 then
					say("���֣�����������",66);
					if true then
						say("��....");
					else
					say("ʦ��������������һ��ͬ����֦����������Ȼ�󽻷��ˣ����Ѿ����˳��������αط�ҪΪ��������");
					say("���......",66);
					say("�ð����㻪ɽ��ԭ��Ҳ��Ҫ���������粻�ɣ�",113);
					say("����֮�£�ԭֻΪ������һ�ˣ������ʦ�ܲ�Ҫ����ɱ����",66);
					say("��ɽ���������£����ŵ��ӣ�����ͬ����һ��������",113);
					say("��ˣ������ˡ�",66);
					Dark();
					SetWarMap(25,21,1,0);
					SetWarMap(25,20,1,0);
					SetWarMap(25,19,1,0);
					WE_addperson(0,24,21,1,650,true);
					WE_addperson(88,24,20,1,750,true);
					WE_addperson(95,24,19,1,550,true);
					WarDrawMap(0);
					Light();
					end
				
				elseif JY.Person[0]["����"]==4 then
					say("���֣�����������",88);
					if true then
						say("��....");
					else
					say("ʦ��������������һ��ͬ����֦����������Ȼ�󽻷��ˣ����Ѿ����˳��������αط�ҪΪ��������");
					say("���......",88);
					say("�ð����㻪ɽ��ԭ��Ҳ��Ҫ���������粻�ɣ�",113);
					say("����֮�£�ԭֻΪ������һ�ˣ������ʦ�ܲ�Ҫ����ɱ����",88);
					say("��ɽ���������£����ŵ��ӣ�����ͬ����һ��������",113);
					say("��ˣ������ˡ�",88);
					Dark();
					SetWarMap(32,17,1,0);
					SetWarMap(32,16,1,0);
					SetWarMap(32,15,1,0);
					WE_addperson(0,33,17,1,650,true);
					WE_addperson(66,33,16,1,750,true);
					WE_addperson(75,33,15,1,550,true);
					WarDrawMap(0);
					Light();
					end
				
				else
					WE_addperson(0,JY.Base["��X1"],JY.Base["��Y1"],1,650,true);
					WarDrawMap(0);
					Light();
				
				end
			else
				say("�����繴��ħ�̣�������ȡ���һ�������Զһ��ɡ�");
			end
		end
		WAR.tmp[1]=1;
	end
end
