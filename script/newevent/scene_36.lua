SceneEvent[36]={};--����ɸ��¼�
SceneEvent[36]={
				[1]=function()--���ŵ���
					if JY.Person[0]["����"]~=1 then
						say("�����ӵģ�����������ɣ������Ӳ�Ҫ�Ҵ���",45);
					else
						say("���������˰�壬��������������Ϣ�ۣ�������ٴ�����������",JY.Da);
						local menu={
												{"����",nil,1},
												{"�д�",nil,1},
												{"����",nil,1},
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
							say("����Ӳ��Ҫ�ã�����ʦ���Һú�ָ���㡣",JY.Da);
							ModifyWarMap=function()
								SetWarMap(29,24,1,854*2);
								SetWarMap(28,44,1,1021*2);
								SetWarMap(29,44,1,1022*2);
								SetWarMap(30,44,1,1023*2);
								SetWarMap(28,43,1,0);
								SetWarMap(30,43,1,0);
							end
							local result=vs(0,29,32,JY.Da,29,25,100);
							--[[SetWarMap(29,24,1,0);
							SetWarMap(28,44,1,1024*2);
							SetWarMap(29,44,1,0);
							SetWarMap(30,44,1,1026*2);
							SetWarMap(28,43,1,1025*2);
							SetWarMap(30,43,1,1027*2);]]--
							Cls();
							ShowScreen();
							if result then
								say("���������ţ�",JY.Da);
							else
								say("��������ʹ�죡",JY.Da);
							end
							DayPass(1);
						elseif r==3 then
							E_guarding(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("���˰�壡û�±������ң�",JY.Da);
						end
					end
				end,
				[2]=function()--��ֹ�޹��˽���
					if JY.Person[0]["����"]~=1 then
						if JY.Base["�˷���"]==0 then
							say("վס���������Ӳ�Ҫ�Ҵ���",45);
							local menu={
													{"����",nil,1},
													{"��ʦ",nil,1},
													{"�뿪",nil,1},
												};
							if JY.Person[0]["����"]>-1 then
								menu[2][3]=0;
							end
							local r=ShowMenu(menu,3,0,0,0,0,0,1,0);
							if r==1 then
								if JY.Da>=1 then
									say("���Ǽ��������ִ򣿡�");
									say("���ң�С�ֵ��롣",45);
									return;
								end
								say("�����ӵģ��������������޶�����ͽ�����",45);
								ModifyWarMap=function()
									SetWarMap(29,24,1,854*2);
									SetWarMap(28,44,1,1021*2);
									SetWarMap(29,44,1,1022*2);
									SetWarMap(30,44,1,1023*2);
									SetWarMap(28,43,1,0);
									SetWarMap(30,43,1,0);
								end
								local result=FIGHT(
																5,2,
																{
																	0,29,31,
																	-1,27,31,
																	-1,28,31,
																	-1,30,31,
																	-1,31,31,
																},
																{
																	46,28,25,
																	47,30,25,
																},
																50,0
															);
								--[[SetWarMap(29,24,1,0);
								SetWarMap(28,44,1,1024*2);
								SetWarMap(29,44,1,0);
								SetWarMap(30,44,1,1026*2);
								SetWarMap(28,43,1,1025*2);
								SetWarMap(30,43,1,1027*2);]]--
								Cls();
								ShowScreen();
								if result then
									say("ʲô���ڴ���������",27);
									say("ʦ�����������ô������ɷ�ۣ����Ҵ������ǣ�",45);
									say("���֣��ҿ������ǹ���Ϊ����λС�ֵܰɡ�����������������Ŵ��ɣ������������������أ��������£�",27);
									say("��л����������������ͨ���������һ������Ȼ�����鴫��");
									lib.SetD(JY.SubScene,JY.CurrentD,3,1);
								else
									say("���������",45);
									walkto_old(0,10);
								end
							elseif r==2 then
								say("������Ľ����ɵ�������������ʦ��");
								say("�ã�����ţ���ȥ����ʦ����",45);
								Dark();
								Light();
								say("�����������ã�ʦ����������������߰ɡ�",45);
								walkto_old(0,-5);
								say("�ո����������ľ�������",27);
								say("�����ˡ�����Ľ����������Ѿã�����ǰ����ʦ��");
								if JY.Da==2 then
									say("�ߣ�ԭ����������ȡЦ��ĳô����ĳ�εº��ܣ��������ʦ����",27);
									return;
								end
								say("���ҿ���������",27);
								say("�ţ����ǻ��С��ã���ͽ���Ҿ��������ˡ���������ʦ�ɡ�",27);
								if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ��������ɣ�",C_WHITE,CC.Fontbig) then
									say("ʦ�����ϣ�����Сͽһ�ݡ�");
									JY.Person[0]["����"]=1;
									JY.Shop[1]["����ʱ��"]=GetFlag(1);
									DrawStrBoxWaitKey(JY.Person[0]["����"].."����������",C_WHITE,CC.Fontbig);
									JY.Person[0]["���"]="��ǵ���";
									GetItem(1,1);
								else
									say("�󵨣�Ī������ϷŪ�Ϸ򲻳ɣ��������£�",27);
									ModifyWarMap=function()
										SetWarMap(29,24,1,854*2);
										SetWarMap(23,18,1,903*2);
										SetWarMap(34,18,1,903*2);
									end
									local result=FIGHT(
																	5,2,
																	{
																		0,29,21,
																		-1,28,21,
																		-1,30,21,
																		-1,27,21,
																		-1,31,21,
																	},
																	{
																		46,26,15,
																		47,31,15,
																	},
																	50,0
																);
									--[[SetWarMap(29,24,1,0);
									SetWarMap(23,18,1,0);
									SetWarMap(34,18,1,0);]]--
									if result then
										say("���º����֣����⼸����������ͽ��������Ц���ˡ�",27);
										say("����ƶ������Ȼ����аɡ�",27);
										ModifyWarMap=function()
											SetWarMap(29,24,1,854*2);
											SetWarMap(23,18,1,903*2);
											SetWarMap(34,18,1,903*2);
										end
										local rr=vs(0,29,21,27,28,14,100);
										--[[SetWarMap(29,24,1,0);
										SetWarMap(23,18,1,0);
										SetWarMap(34,18,1,0);]]--
										Cls();
										ShowScreen();
										if rr then
											say("�ߣ���������������ǲ��ĳ�İɡ����书���֮�ߣ����������С���ݲ�����������",27);
											lib.SetD(JY.SubScene,JY.CurrentD,3,2);
										else
											say("�ҿ�Ҳ������ˣ����΢ĩ������Ҳ��������ţ�",27);
											say("�ߣ����վ���������һ�����������ɣ�",27);
											walkto_old(0,15);
										end
									else
										say("�ߣ����վ���������һ�����������ɣ�",27);
										walkto_old(0,15);
									end
								end
							elseif r==3 then
								say("�ú�������������ߡ�");
								walkto_old(0,3);
							end
						end
					else
						return true;
					end
				end,
				[3]=function()--����
					if JY.Person[0]["����"]~=1 then	--����ǵ���
						say("............",JY.Da);
					else
						if GetFlag(12005)==0 and JY.Person[0]["����"]>30 and GetFlag(10004)~=0 and GetFlag(16001)==2 then
							SetFlag(12005,1);
							say("��ɽ�������⼸�վ�Ҫ����ϴ���˳������������������Ҳȥ�μӹ���ɡ�",JY.Da);
							say("�ǣ�");
							return;
						end
						say("�μ�ʦ����");
						say("��ʲô����",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							--say("������ʦ�泤����һ���˽ܣ���ϧ......",JY.Da);
							RandomEvent(JY.Da);
						elseif r==2 then
							local kflist={
												{21,10},
												{23,10,1},
												{22,10},
												{24,10,1},
												{25,10},
												{26,10,2},
												{27,10},
												{28,10,2},
												};
							if GetFlag(11003)==1 then
								kflist[9]={67,10};
							end
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<5 then
								say("ȥ����ʦ�����д�ɣ���Ĺ��򻹲��Զ�ء�",JY.Da);
							else
								say("�ã�ֻ�ܳ��аɣ����ҿ�������书��û�н�����",JY.Da);
								ModifyWarMap=function()
									SetWarMap(29,24,1,854*2);
									SetWarMap(23,18,1,903*2);
									SetWarMap(34,18,1,903*2);
								end
								local result=vs(0,29,21,JY.Da,28,14,100);
								--[[SetWarMap(29,24,1,0);
								SetWarMap(23,18,1,0);
								SetWarMap(34,18,1,0);]]--
								Cls();
								ShowScreen();
								if result then
									say("�����书���н�չ��",JY.Da);
								else
									say("�ú�Ŭ���ɡ�",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("û�¾�ȥ�ú�������",JY.Da);
						end
					end
				end,
				[4]=function()--���Ժ�ӵ���
					if JY.Person[0]["����"]~=1 then
						say("���������ģ��𵽴���ת��",45);
						--E_kungfugame(-4);
					else
						say("��˵��������Ժ��ɫ�ޱߣ�����ȥ���氡��",JY.Da);
						local menu={
												{"����",nil,1},
												{"�д�",nil,1},
												{"����",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							RandomEvent(JY.Da);
						elseif r==2 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							say("�ð�������ʦ���Һú�ָ�����㡣",JY.Da);
							ModifyWarMap=function()
								SetWarMap(29,24,1,854*2);
								SetWarMap(28,44,1,1021*2);
								SetWarMap(29,44,1,1022*2);
								SetWarMap(30,44,1,1023*2);
								SetWarMap(28,43,1,0);
								SetWarMap(30,43,1,0);
							end
							local result=vs(0,23,38,JY.Da,14,36,100);
							--[[SetWarMap(29,24,1,0);
							SetWarMap(28,44,1,1024*2);
							SetWarMap(29,44,1,0);
							SetWarMap(30,44,1,1026*2);
							SetWarMap(28,43,1,1025*2);
							SetWarMap(30,43,1,1027*2);]]--
							Cls();
							ShowScreen();
							if result then
								say("......",JY.Da);
							else
								say("��������ʹ�죡",JY.Da);
							end
							DayPass(1);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							
						end
					end
				end,
				[5]=function()--�ұ�Ժ�ӵ���A
					if JY.Person[0]["����"]~=1 then
						say("��������˲żüã�Сһ�����У���������㡹��Ҳ�ǽ���������������ſ���",45);
					else
						say("Ҫʦ����ָ����Ĺ����𣿡�",JY.Da);
						local menu={
												{"����",nil,1},
												{"�д�",nil,1},
												{"����",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							say("������ɵĴ�����Ҳ������һ������������ȴ���Ǻܴ�",JY.Da);
							say("Ϊʲô�أ�");
							say("��������Ϊ�������е��ˣ��Լ���û���������ʵ�Ѿ�����θ���ֻ�ܵ����ˡ�",JY.Da);
						elseif r==2 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							say("�ð�������ʦ���Һú�ָ�����㡣",JY.Da);
							ModifyWarMap=function()
								SetWarMap(29,24,1,854*2);
								SetWarMap(28,44,1,1021*2);
								SetWarMap(29,44,1,1022*2);
								SetWarMap(30,44,1,1023*2);
								SetWarMap(28,43,1,0);
								SetWarMap(30,43,1,0);
							end
							local result=vs(0,41,34,JY.Da,35,31,100);
							--[[SetWarMap(29,24,1,0);
							SetWarMap(28,44,1,1024*2);
							SetWarMap(29,44,1,0);
							SetWarMap(30,44,1,1026*2);
							SetWarMap(28,43,1,1025*2);
							SetWarMap(30,43,1,1027*2);]]--
							Cls();
							ShowScreen();
							if result then
								say("......",JY.Da);
							else
								say("��������ʹ�죡",JY.Da);
							end
							DayPass(1);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							
						end
					end
				end,
				[6]=function()--�ұ�Ժ�ӵ���B
					if JY.Person[0]["����"]~=1 then
						say("�������֣�������������Ϊ��",45);
					else
						say("��������ʱ���в�������������ɵ����硣",JY.Da);
						local menu={
												{"����",nil,1},
												{"�д�",nil,1},
												{"����",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							RandomEvent(JY.Da);
						elseif r==2 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							say("�ð�������ʦ���Һú�ָ�����㡣",JY.Da);
							ModifyWarMap=function()
								SetWarMap(29,24,1,854*2);
								SetWarMap(28,44,1,1021*2);
								SetWarMap(29,44,1,1022*2);
								SetWarMap(30,44,1,1023*2);
								SetWarMap(28,43,1,0);
								SetWarMap(30,43,1,0);
							end
							local result=vs(0,41,34,JY.Da,37,29,100);
							--[[SetWarMap(29,24,1,0);
							SetWarMap(28,44,1,1024*2);
							SetWarMap(29,44,1,0);
							SetWarMap(30,44,1,1026*2);
							SetWarMap(28,43,1,1025*2);
							SetWarMap(30,43,1,1027*2);]]--
							Cls();
							ShowScreen();
							if result then
								say("......",JY.Da);
							else
								say("��������ʹ�죡",JY.Da);
							end
							DayPass(1);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							
						end
					end
				end,
				[7]=function()--������
					if JY.Person[0]["����"]~=1 then
						say("�˴��������������֮����������޶����������뿪����",45);
					else
						say("ʦ��������������",JY.Da);
						E_training(JY.Da);
					end
				end,
				[8]=function()--����
					if JY.Person[0]["����"]==1 then
						say("�����ƺ��кܶ�����ǰ���������ĵá�");
						E_readbook();
					end
				end,
				[9]=function()--����
					if JY.Person[0]["����"]==1 then
						if JY.Da==GetFlag(1) then
							say("�����Ѿ��Ϲ����ˣ����������ɡ�");
						else
							 DrawStrBoxWaitKey("��ʦ������֮��λ",C_WHITE,CC.Fontbig);
							 Cls();
							if DrawStrBoxYesNo(-1,-1,"�Ƿ����㣿",C_WHITE,CC.Fontbig) then
								say("ʦ�����ϣ����������飬��������ǳ�ʢ��˥��");
								Dark();
								lib.Delay(500);
								SetFlag(11001,GetFlag(11001)+1);
								Light();
								lib.SetD(JY.SubScene,JY.CurrentD,3,GetFlag(1));
								if Rnd(20)==1 then
									AddPerformance(1);
								end
							else
								say("�´������ɡ�");
							end
						end
					end
				end,
				[10]=function()--��Ϣ
					if JY.Person[0]["����"]==1 then
						local menuItem=	{
														{"��Ϣ",nil,1},
														{"�ݷ�",nil,1},
														{"û��",nil,2},
													}
						local r=EasyMenu(menuItem);
						if r==1 then
							if rest() then
								say("��Ϣ���ˣ��������");
							end
						elseif r==2 then
							visit(1);
						end
					else
						visit(1);
					end
					walkto_old(2,0);
				end,
				[11]=function()--
				end,
			}

						--say("")