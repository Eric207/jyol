SceneEvent[29]={};--̩ɽ�ɸ��¼�
SceneEvent[29]={
				[1]=function()	--���ŵ���
					--��ʱ������̩ɽ����
					if JY.Person[0]["����"]~=3 then	--��̩ɽ����
						local d=JY.Base["�˷���"];
						if d==2 then
							say("���ʸ�������̩ɽ�кι�ɣ�",80);
						else
							say("�������ߣ�ˡ��Զ�͡�",80);
						end
						local menu={
												{"����",nil,1},
												{"��ʦ",nil,1},
												{"�뿪",nil,1},
												{"û��",nil,1},
											};
						if d==2 then
							menu[3][3]=0;
						else
							menu[1][3]=0;
							menu[2][3]=0;
						end
						if JY.Person[0]["����"]>=0 then	--��������
							menu[2][3]=0;
						end
						local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
						if r==1 then
							say("��̩ɽ������֮�ף��������棬���ŷ��٣�����������Ͼ���������Ĵ����ߡ�",80);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						elseif r==2 then
							say("�����������ͨ������������������",80);
							Dark();
							JY.Base["��X1"]=20;
							JY.Base["��Y1"]=28;
							JY.Base["�˷���"]=2;
							 JY.MyPic=GetMyPic();
							Light();
							--��ʱ�����ǰ�ʦ����
							if true then
								say("С�ֵ�������̩ɽ����ǽ��",66);
								if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ����̩ɽ�ɣ�",C_WHITE,CC.Fontbig) then
									say("ʦ�����ϣ�����ͽ��һ�ݣ�");
									say("���������£����Ե���ѭ���Ź档",66);
									JY.Person[0]["����"]=3;
									JY.Shop[3]["����ʱ��"]=GetFlag(1);
									DrawStrBoxWaitKey(JY.Person[0]["����"].."�����̩ɽ��",C_WHITE,CC.Fontbig);
									JY.Person[0]["���"]="̩ɽ����";
									GetItem(3,1);
								else
									say("��Ȼ��ˣ����¾ʹ����ա�",49);
								end
							else
								say("�󵨿�ͽ��ƾ����Ƚ������࣬Ҳ�������̩ɽ��ǽ����",49);
							end
						elseif r==3 then
							say("�����������У���������̩ɽ������",80);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						elseif r==4 then
							say("���¼�Ȼ���£���������ȥ�ա�",80);
						end
					else
						local d=JY.Base["�˷���"];
						if JY.Da>0 then
							say("ʦ�����Һ��£�",JY.Da);
							local menu={
													{"����",nil,1},
													{"�д�",nil,1},
													{"״̬",nil,1},
													{"վ��",nil,1},
													{"����",nil,1},
													{"���",nil,1},
													{"û��",nil,1},
												};
							if d==2 then
								menu[6][3]=0;
							else
								menu[5][3]=0;
							end
							local r=ShowMenu(menu,7,0,0,0,0,0,1,0);
							if r==1 then
								RandomEvent(JY.Da);
							elseif r==2 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
								say("�ð����۸����д��д衣",JY.Da);
								ModifyWarMap=function()
									SetWarMap(26,27,1,1137*2);
									SetWarMap(26,28,1,1137*2);
									SetWarMap(26,29,1,1137*2);
									SetWarMap(43,26,1,2243*2);
									SetWarMap(43,27,1,2242*2);
									SetWarMap(43,28,1,2242*2);
									SetWarMap(43,29,1,2241*2);
								end
								local result=vs(0,33,29,JY.Da,27,28,300);
								--[[SetWarMap(26,27,1,1138*2);
								SetWarMap(26,28,1,0);
								SetWarMap(26,29,1,1136*2);
								SetWarMap(43,26,1,2251*2);
								SetWarMap(43,27,1,0);
								SetWarMap(43,28,1,0);
								SetWarMap(43,29,1,2246*2);]]--
								Cls();
								ShowScreen();
								if result then
									say("�벻��ʦ������û���գ��书��������˵ã����ֲ�����",JY.Da);
								else
									say("ʦ���⼸�����ò���������Ӯʦ���ң����������ܰ�����������������ȥ�������������´����д��д衣",JY.Da);
								end
								DayPass(1);
							elseif r==3 then
								PersonStatus(JY.Da);
							elseif r==4 then
								--say("��лʦ�����⣬��ϧ��������֮���޷�������",JY.Da);
								E_guarding(JY.Da);
							elseif r==5 then
								say("ʦ�������",JY.Da);
								Dark();
								JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
								JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
								Light();
							elseif r==6 then
								say("�����ն�ʦ�ܶ��С�ġ�",JY.Da);
								Dark();
								JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
								JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
								Light();
							elseif r==7 then
								say("ʦ���������£������������죬�����д����书Ҳ�á�",JY.Da);
							end
						else
							say("ʦ���롣",20);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						end
					end
				end,
				[2]=function()	--�д��õ���
					if JY.Person[0]["����"]~=3 then	--��̩ɽ����
						say("�ѵø�������̩ɽ���ͣ���ʤ���ҡ�",80);
					elseif JY.Da>0 then
						say("������ʿʦ������;��ǹѵ����滳���ϸ��³Եĺ���¿�⣬������",JY.Da);
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
							say("�ð������������档",JY.Da);
							ModifyWarMap=function()
								SetWarMap(26,27,1,1137*2);
								SetWarMap(26,28,1,1137*2);
								SetWarMap(26,29,1,1137*2);
								SetWarMap(43,26,1,2243*2);
								SetWarMap(43,27,1,2242*2);
								SetWarMap(43,28,1,2242*2);
								SetWarMap(43,29,1,2241*2);
							end
								local result=vs(0,37,24,JY.Da,38,33,300);
							--[[	SetWarMap(26,27,1,1138*2);
								SetWarMap(26,28,1,0);
								SetWarMap(26,29,1,1136*2);
								SetWarMap(43,26,1,2251*2);
								SetWarMap(43,27,1,0);
								SetWarMap(43,28,1,0);
								SetWarMap(43,29,1,2246*2);]]--
							Cls();
							ShowScreen();
							if result then
								say("�벻��ʦ������û���գ��书��������˵ã����ֲ�����",JY.Da);
							else
								say("ʦ���⼸�����ò���������Ӯʦ���ң����������ܰ�����������������ȥ�������������´����д��д衣",JY.Da);
							end
							DayPass(1);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("ʦ���������£������������죬�����д����书Ҳ�á�",JY.Da);
						end
					else
						say("��̩ɽ�ɽ����������س��ȣ���ؽ��ϡ�",20);
					end
				end,
				[3]=function()	--������
					if JY.Person[0]["����"]~=3 then
						say("������̩ɽ��������֮��������������뿪��",80);
					else
						say("ʦ�ܺ������㣬���������ģ�",JY.Da);
						E_training(JY.Da);
					end
				end,
				[4]=function()	--����
					if JY.Person[0]["����"]~=3 then	--��̩ɽ����
						say("�����ѵ�����̩ɽ�������Ĵ�����һ����",66);
					else
						if GetFlag(12005)==0 and JY.Person[0]["����"]>30 and GetFlag(10004)~=0 and GetFlag(16001)==2 then
							SetFlag(12005,1);
							say("��ɽ�������⼸�վ�Ҫ����ϴ���˳������������������Ҳȥ�μӹ���ɡ�",JY.Da);
							say("�ǣ�");
							return;
						end
						say("�μ�ʦ����");
						say("�ţ�",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							--say("̩ɽ���������ף���̩ɽ��Ҳ���������š����������߽��������ɻ�����̩ɽ�ɵ�������",JY.Da);
							RandomEvent(JY.Da);
						elseif r==2 then
							say("Ŷ������ѧ��ʲô��",JY.Da);
							local kflist={
												{41,10},
												{42,10},
												{43,10,1},
												{46,10},
												{47,10,2},
												{48,10},
												};
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<5 then
								say("�����̫�",JY.Da);
							else
								say("��Ϊʦ���Ͽ����㡣",JY.Da);
								ModifyWarMap=function()
									SetWarMap(26,27,1,1137*2);
									SetWarMap(26,28,1,1137*2);
									SetWarMap(26,29,1,1137*2);
									SetWarMap(23,24,1,854*2);
									SetWarMap(23,33,1,854*2);
								end
								local result=vs(0,23,28,JY.Da,18,27,3000);
								--[[SetWarMap(26,27,1,1138*2);
								SetWarMap(26,28,1,0);
								SetWarMap(26,29,1,1136*2);
								SetWarMap(23,24,1,0);
								SetWarMap(23,33,1,0);]]--
								Cls();
								ShowScreen();
								if result then
									say("��̩ɽ��������ˣ�����������",JY.Da);
								else
									say("������ˮƽ����ȥ������",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("ҵ�����ڻ����ң���û�¾�ȥ�ú��ù�����Ҫ�Ĵ��й䡣",JY.Da);
						end
					end
				end,
				[5]=function()--����
					if JY.Person[0]["����"]==3 then
						if JY.Da==GetFlag(1) then
							say("���������ѱϣ����������ɡ�");
						else
							 DrawStrBoxWaitKey("��ʦ�������֮��λ",C_WHITE,CC.Fontbig);
							 Cls();
							if DrawStrBoxYesNo(-1,-1,"�Ƿ����㣿",C_WHITE,CC.Fontbig) then
								say("ʦ�����ϣ������������飬����̩ɽ��ʢ��˥���������֡�");
								Dark();
								lib.Delay(500);
								Light();
								lib.SetD(JY.SubScene,JY.CurrentD,3,GetFlag(1));
								if Rnd(20)==1 then
									AddPerformance(1);
								end
							else
								say("���������ɡ�");
							end
						end
					end
				end,
				[6]=function()	--���
					if JY.Person[0]["����"]==3 then
						say("�ף������ƺ��кܶ�����ǰ���������ĵá�");
						E_readbook();
					end
				end,
				[7]=function()	--��Ϣ
					if JY.Person[0]["����"]==3 then
						local menuItem=	{
														{"��Ϣ",nil,1},
														{"�ݷ�",nil,1},
														{"û��",nil,2},
													}
						local r=EasyMenu(menuItem);
						if r==1 then
							if rest() then
								say("һ��������������ˬ��");
							end
						elseif r==2 then
							visit(3);
						end
					else
						visit(3);
					end
					walkto_old(0,-2);
				end,
				[8]=function()	--����
					if JY.Person[0]["����"]~=3 then	--��̩ɽ����
						say("�����ѵ�����̩ɽ�������Ĵ�����һ����",66);
					else
						say("�μ�ʦ�壡");
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
							say("̩ɽ���������ף���̩ɽ��Ҳ���������š����������߽��������ɻ�����̩ɽ�ɵ�������",JY.Da);
							--RandomEvent(JY.Da);
						elseif r==2 then
							say("Ŷ������ѧ��ʲô��",JY.Da);
							local kflist={
												{41,10},
												{45,10,1},
												};
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<5 then
								say("�����̫�",JY.Da);
							else
								say("�ã�����ָ����һ�¡�",JY.Da);
								ModifyWarMap=function()
									SetWarMap(26,27,1,1137*2);
									SetWarMap(26,28,1,1137*2);
									SetWarMap(26,29,1,1137*2);
									SetWarMap(23,24,1,854*2);
									SetWarMap(23,33,1,854*2);
								end
								local result=vs(0,23,28,JY.Da,18,27,3000);
								--[[SetWarMap(26,27,1,1138*2);
								SetWarMap(26,28,1,0);
								SetWarMap(26,29,1,1136*2);
								SetWarMap(23,24,1,0);
								SetWarMap(23,33,1,0);]]--
								Cls();
								ShowScreen();
								if result then
									say("�ù���",JY.Da);
								else
									say("��ҪŬ����",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("ҵ�����ڻ����ң���û�¾�ȥ�ú��ù�����Ҫ�Ĵ��й䡣",JY.Da);
						end
					end
				end,
			}

						--say("")