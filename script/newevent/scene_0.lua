SceneEvent[0]={}
SceneEvent[0]={
				[1]=function()	--���
							say("С�ֵܣ����˺���ѩ�أ���֪�к�ָ�̣�",JY.Da);
							local menu={
													{"����",nil,1},
													{"�д�",nil,1},
													{"״̬",nil,1},
													{"û��",nil,1},
												};
							local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
							if r==1 then
								RandomEvent(JY.Da);
							elseif r==2 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
								say("���������������ҹ���ģ��ǾͶ��ְɣ�",JY.Da);
								local result=vs(0,-1,28,JY.Da,29,28,600);
								Cls();
								ShowScreen();
								if result then
									say("������Լ��ķ������͸������ɶ����ң�",JY.Da);
								else
								if 	GetFlag(65001)==0 and
									Rnd(10)==1 and
									JY.Person[0]["�ȼ�"]>JY.Person[JY.Da]["�ȼ�"] and
									SetFlag(65001,1);
									script_say("��쳣�������Ҫ�����ҼҴ�����ȱ����ҳ����")
									script_say("���ǣ��ף�����磬������ô�£�")
									script_say("��쳣�����˵��������������������ѣ��������ף�����������ֻ��ƴ����ס�Ҵ��ĵ��ף������պ��������书���Ա��ҳ���֪����һ����ҽ�����ڻ���֮�У�ȴ�ǽ������е���ҳ˺�´��ߡ����������������ģ����ǲ�ȱ�ĵ�����Ҫ���ҵ��ꡭ������������Ҳ�ա���")
									script_say("���ǣ���һ������ҽ�������պ������⣬�����ܲ��ܰ�����Ѱ�ص��ס���")
								else
									say("���ң����ң�");
								end
								DayPass(1);
							elseif r==3 then
								PersonStatus(JY.Da);
							elseif r==7 then
								say("��������������̵�����");
							end
				end,
				[2]=function()	--�Ŷ�����
				end,
				[3]=function()	--ؤ�����
				end,
				[4]=function()	--ס��
					if DrawStrBoxYesNo(-1,-1,"�Ƿ���Ϣ��",C_WHITE,CC.Fontbig) then
						SetFlag(1,GetFlag(1)+1);
						rest();
						say("��Ϣ���ˣ�����Ŭ���ɡ�");
					else
					
					end
				end,
				[5]=function()	--��ǵ���
				end,
			}