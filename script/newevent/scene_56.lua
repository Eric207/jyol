SceneEvent[56]={};--�����ھָ��¼�
--�����ھ������¼�����������ܿ���
SceneEvent[56]={
				[1]=function()--����
					if GetFlag(16001)==1 then	--���ſ���
						if GetFlag(1)-GetFlag(16002)<=15 then	--ʱ������
							if JY.Person[0]["����"]==1 then	--�����
								say("ʦ�֣�������");
								walkto_old(-3,0);
								SetFlag(16000,1);	--�����ھֹ��б��
							else--�����ھ�
								ModifyD(JY.SubScene,0,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
								ModifyD(JY.SubScene,1,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
								ModifyD(JY.SubScene,2,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
								ModifyD(JY.SubScene,3,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
								ModifyD(JY.SubScene,6,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
								ModifyD(JY.SubScene,7,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
								ModifyD(JY.SubScene,8,0,0,0,0,0,0,0,0,0,-2,-2);
								SetS(JY.SubScene,13,28,1,3021*2);
								SetS(JY.SubScene,15,28,1,3021*2);
								SetS(JY.SubScene,13,24,1,3020*2);
								SetS(JY.SubScene,15,24,1,3020*2);
								SetS(JY.SubScene,17,27,1,3022*2);
								SetS(JY.SubScene,17,25,1,3022*2);
								MoveSceneTo(19,27);	--�ӽ�:��ǵ���
								say("�����ϣ��㻹����˵�����׵�������",35);
								say("�������������һ��ɱ���ң���Ц�һ�������������ǽ���������Ϲ���ҹ����ϲ������ǵ�����Ұ�ģ�",135);
								MoveSceneTo();
								say("���ң������ˡ�");
								walkto_old(-26,0);
								say("ʲô�ˣ�������",35);
								
								SetS(JY.SubScene,13,28,1,0);
								SetS(JY.SubScene,15,28,1,0);
								SetS(JY.SubScene,13,24,1,0);
								SetS(JY.SubScene,15,24,1,0);
								SetS(JY.SubScene,17,27,1,0);
								SetS(JY.SubScene,17,25,1,0);
								ModifyWarMap=function()
									SetWarMap(26,39,1,854*2);
									SetWarMap(26,17,1,854*2);
								end
								local r=FIGHT(
														5,10,
														{
															0,	19,27,
															135,13,26,
															-1,20,26,
															-1,20,28,
															-1,21,27,
														},
														{
															35,14,24,
															37,14,28,
															38,22,26,
															39,15,23,
															40,15,29,
															41,17,23,
															42,17,29,
															43,20,29,
															44,20,25,
															45,22,28,
														},
														2000,0,2
													);
								--[[SetWarMap(26,39,1,0);
								SetWarMap(26,17,1,0);]]--
						
								ModifyD(JY.SubScene,9,0,0,0,0,0,0,0,0,0,-2,-2);
								if r then
									say("��ϲ�㣬ȡ�������������ʤ������������������Ϊ�ⳡʤ��׼�����飡",1);
								else
									say_2("����С�ӣ�������£�ȥ���ɣ�",35);
									ScreenFlash(C_WHITE);
									--Dark();
									say_2("�ţ��������ˣ�",40);
									say_2("ȥ������",35);
									Dark();
									lib.Delay(300);
									WaitKey();
									lib.Delay(600);
									Light();
									say_2("�ƺ���˭�����ҡ�");
									--JY.Status=GAME_END;
								end
							end
						else	--���ʬ��
							
							ModifyD(JY.SubScene,0,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,1,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,2,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,3,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,6,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,7,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,8,0,0,0,0,0,0,0,0,0,-2,-2);
							ModifyD(JY.SubScene,9,0,0,0,0,0,0,0,0,0,-2,-2);
							if JY.Person[0]["����"]==1 then	--�����
								say("�����ˣ���ʦ���ƺ��Ѿ����ھֵ���ɱ���ˡ����ǸϽ����ɷ�۰ɣ�ϣ��ʦ���������ҡ�");
							else
								say("�����ˣ�����ɺú������ֶΣ�");
							end
						end
						SetFlag(16001,2);
					elseif GetFlag(16001)==2 and GetFlag(16000)==1 then
						say("��ʦ�ֵĳ�û���أ�");
						walkto_old(-3,0);
					else
						return true;
					end
				end,
				[2]=function()--��ʦ
					if JY.Da>0 then
						RandomEvent(JY.Da);
					else
						say("�����������Ҫ������ȥ������ͷ��",145);
					end
				end,
				[3]=function()--����
				end,
				[4]=function()--������
					if JY.Da>0 then
						RandomEvent(JY.Da);
					else
						say("��ʾ��仰����ʾ��Ϸ�����ˡ�",135);
					end
				end,
				[5]=function()--����
					--��а���׺���ʱ�䣬����
				end,
				[6]=function()--��ƽ֮
					say("���Ҫ���ڣ���ȥ���ҼҸ���",136);
				end,
				[7]=function()--����-ƽ֮
					if GetFlag(16000)==1 and GetFlag(16003)==0 then
						say("ʲô�ˣ�",140);
						say("Ҫ�������ˣ�");
						ModifyWarMap=function()
							SetWarMap(18,26,1,902*2);
							SetWarMap(18,27,1,902*2);
							SetWarMap(18,28,1,902*2);
							SetWarMap(26,39,1,854*2);
						end
						local r=FIGHT(
										5,5,
										{
											0,	25,21,
											35,27,21,
											-1,25,22,
											-1,26,22,
											-1,27,22,
										},
										{
											136,20,13,
											139,24,19,
											140,28,19,
											141,25,22,
											142,27,22,
										},
										1000,1
									);
						--[[
						SetWarMap(18,26,1,0);
						SetWarMap(18,27,1,0);
						SetWarMap(18,28,1,0);
						SetWarMap(26,39,1,0);]]--
						if r then
							SetFlag(16006,1);	--ƽ֮����
							SetFlag(16003,1);
							ModifyD(JY.SubScene,6,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,7,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,8,0,0,0,0,0,0,0,0,0,-2,-2);
							SetS(JY.SubScene,20,13,3,-1);
							say("������С�ӿ��������ӣ���ͷ��ȥ��ʦ����Ϊʦ�ֱ���");
						else
							JY.Status=GAME_END;
						end
					else
						return true;
					end
				end,
				[8]=function()--����-�Ʊ�
					if GetFlag(16000)==1 and GetFlag(16004)==0 then
						say("ʲô�ˣ�",140);
						say("Ҫ�������ˣ�");
						ModifyWarMap=function()
							SetWarMap(18,26,1,902*2);
							SetWarMap(18,27,1,902*2);
							SetWarMap(18,28,1,902*2);
							SetWarMap(26,17,1,854*2);
						end
						local r=FIGHT(
										5,6,
										{
											0,	25,35,
											35,27,35,
											-1,25,34,
											-1,26,34,
											-1,27,34,
										},
										{
											141,24,34,
											142,28,33,
											143,24,37,
											144,28,37,
											145,24,40,
											146,27,42,
										},
										1000,1
									);
						--[[SetWarMap(18,26,1,0);
						SetWarMap(18,27,1,0);
						SetWarMap(18,28,1,0);
						SetWarMap(26,17,1,0);]]--
						if r then
							SetFlag(16004,1);
							ModifyD(JY.SubScene,0,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,2,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
						else
							JY.Status=GAME_END;
						end
					else
						return true;
					end
				end,
				[9]=function()--����-����
					if GetFlag(16000)==1 and GetFlag(16005)==0 then
						say("ʲô�ˣ�",140);
						say("Ҫ�������ˣ�");
						SetFlag(16000,2);
						ModifyWarMap=function()
							SetWarMap(26,39,1,854*2);
							SetWarMap(26,17,1,854*2);
						end
						local r=FIGHT(
										5,11,
										{
											0,	16,27,
											35,16,25,
											-1,20,26,
											-1,20,28,
											-1,21,27,
										},
										{
											135,13,26,
											137,14,24,
											138,14,28,
											139,15,23,
											140,15,29,
											141,17,23,
											142,17,29,
											143,20,29,
											144,20,25,
											145,22,28,
											146,22,26,
										},
										2000,0
									);
						--[[SetWarMap(26,39,1,0);
						SetWarMap(26,17,1,0);]]--
						if r then
							SetFlag(16003,1);
							SetFlag(16004,1);
							SetFlag(16005,1);
							ModifyD(JY.SubScene,0,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,1,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,2,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,3,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,6,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,7,-2,-2,10,-2,-2,2724*2,2724*2,2724*2,-2,-2,-2);
							ModifyD(JY.SubScene,8,0,0,0,0,0,0,0,0,0,-2,-2);
							ModifyD(JY.SubScene,9,0,0,0,0,0,0,0,0,0,-2,-2);
							SetS(JY.SubScene,20,20,13,-1);
							SetS(JY.SubScene,20,13,26,-1);
							say("������ͷ��Ҫ�ޣ��ͺ��������Ϊʲô����Զͼ��Ҫ�֣��͹���Ķ���ΪʲôҪɱ���ٹ����ɣ�");
						else
							
							JY.Status=GAME_END;
						end
					else
						return true;
					end
				end,
				[10]=function()--��ʦʬ��
					DrawStrBoxWaitKey("��ʦ��ʬ��",C_WHITE,CC.Fontbig);
				end,
				[77]=function()--BAK
				end,
			}

						--say("")