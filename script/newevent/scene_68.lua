SceneEvent[68]={};--�����ɸ��¼�
SceneEvent[68]={
				[1]=function()	--���ŵ���
					--��ʱ���������ع���
					if JY.Person[0]["����"]~=13 then	--�����ص���
						local d=JY.Base["�˷���"];
						if d==2 then
							say("����ɽ�ش����򣬸��²�Զǧ���������֪�кι�ɣ�",JY.Da);
						else
							say("Ҫ������",JY.Da);
						end
						local menu={
												{"����",nil,1},
												{"��ʦ",nil,1},
												{"�뿪",nil,1},
												{"û��",nil,1},
											};
						if d==2 then
							menu[3][3]=0;
							if GetFlag(1)-GetFlag(23001)<=0 or Rnd(100)>JY.Person[0]["��Ե"] then
								SetFlag(23001,GetFlag(1)+2);
							end
						else
							menu[1][3]=0;
							menu[2][3]=0;
						end
						if JY.Person[0]["����"]>=0 then	--��������
							menu[2][3]=0;
						end
						local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
						if r==1 then
							if GetFlag(1)-GetFlag(23001)<=0 then
								say("ʮ�ֱ�Ǹ�����Ž�������������������У�����Ӵ�Զ�͡�",JY.Da);
								say("����Զ�����ף�������ɽ���Ҽ��ջ��Ϣ���ա�",JY.Da);
								return;
							end
							say("�����",JY.Da);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
							say("�˴��羰���ã���������ԭ�����²������̻����ա�",JY.Da);
						elseif r==2 then
							if GetFlag(1)-GetFlag(23001)<=0 then
								say("ʮ�ֱ�Ǹ�����Ž�������������������С�",JY.Da);
								say("����Զ�����ף�������ɽ���Ҽ��ջ��Ϣ���ա�",JY.Da);
								return;
							end
							say("���𣬿�С�ֵ�̸�·ǳ���ʦ���϶��ǳ�ϲ�õġ�",JY.Da);
							Dark();
							JY.Base["��X1"]=17;
							JY.Base["��Y1"]=35;
							JY.Base["�˷���"]=2;
							 JY.MyPic=GetMyPic();
							Light();
							--��ʱ�����ǰ�ʦ����
							if true then
								say("�������������������򣬴Ӳ�������ԭ��������������������ý����Ź棬�ж˱�����",402);
								if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ���������ɣ�",C_WHITE,CC.Fontbig) then
									say("ʦ�����ϣ�����ͽ��һ�ݣ�");
									say("���ã����ã�",402);
									JY.Person[0]["����"]=13;
									JY.Shop[5]["����ʱ��"]=GetFlag(1);
									DrawStrBoxWaitKey(JY.Person[0]["����"].."�����������",C_WHITE,CC.Fontbig);
									JY.Person[0]["���"]="���ص���";
									--GetItem(5,1);
								else
									say("��ˣ�С�ֵ���ذɡ�",402);
								end
							else
								say("�����ڽ���������ʢ�����ֺα�����ǲ������Ѱ���أ�",402);
							end
						elseif r==3 then
							--say("��Ȼ���£��͸Ͻ��뿪�ɡ�",JY.Da);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						elseif r==4 then
							say("�����ߣ�",JY.Da);
						end
					else
						local d=JY.Base["�˷���"];
						if JY.Da>0 then
							say("��ʲô������",JY.Da);
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
								say("�ð����������Ȼ��Ȼ��ɡ�",JY.Da);
								local result=vs(0,-1,28,JY.Da,29,28,300);
								Cls();
								ShowScreen();
								if result then
									say("�ù���",JY.Da);
								else
									say("������Ŭ���°ɡ�",JY.Da);
								end
								DayPass(1);
							elseif r==3 then
								PersonStatus(JY.Da);
							elseif r==4 then
								--say("��л������⣬��ϧ��������֮���޷�������",JY.Da);
								E_guarding(JY.Da);
							elseif r==5 then
								say("�����",JY.Da);
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
								say("�������£������������죬�����д����书Ҳ�á�",JY.Da);
							end
						else
							say("�롣",JY.Da);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						end
					end
				end,
				[2]=function()	--�д��õ���
					if JY.Person[0]["����"]~=13 then	--�����ص���
						say("����������أ���֪�кι�ɣ�",JY.Da);
					elseif JY.Da>0 then
						say("����ɽ���Ǹ��õط���",JY.Da);
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
							say("�ð������ǵ㵽Ϊֹ��",JY.Da);
								local result=vs(0,-1,28,JY.Da,29,28,300);
							Cls();
							ShowScreen();
							if result then
								say("�ù���",JY.Da);
							else
								say("������Ŭ���°ɡ�",JY.Da);
							end
							DayPass(1);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("�������£������������죬�����д����书Ҳ�á�",JY.Da);
						end
					else
						script_say("���ص��ӣ�����ɽ���Ǹ��õط���");
					end
				end,
				[3]=function()	--������
					if JY.Person[0]["����"]~=13 or JY.Da<=0 then
						script_say("���ص��ӣ�������������������֮�ء�");
					else
						say("���������ģ�",JY.Da);
						E_training(JY.Da);
					end
				end,
				[4]=function()	--����
					if JY.Person[0]["����"]~=13 then	--�����ص���
						say("����Զ���ǿͣ�������ιۡ�",JY.Da);
					else
						say("�μ�ʦ����");
						say("���£�",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							--say("����ɽ�书�������Ҫ�ú���ϰ��",JY.Da);
							RandomEvent(JY.Da);
						elseif r==2 then
							if true then
								say("�����δ�̣���ȥ����ʦ����ɽ�Ӱɡ�",JY.Da);
								return;
							end
							say("Ŷ������ѧ��ʲô��",JY.Da);
							local kflist={
												{59,10},
												{60,10},
												{61,10,1},
												{62,10},
												{63,10},
												{64,10},
												{65,10,1},
												{77,10},
												{78,10,2},
												{79,10},
												};
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<10 then
								say("������ʱ���㲻Ҫ�ø���Զ��",JY.Da);
							else
								say("�ã���ҪС���ˣ�",JY.Da);
								local result=vs(0,-1,27,JY.Da,13,26,3000);
								Cls();
								ShowScreen();
								if result then
									say("......",JY.Da);
								else
									say("��ʶ���˾͸Ͻ�ȥ������",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("���Ǿ��ˣ�Ҳ���Ե�������������ǲ��",JY.Da);
						end
					end
				end,
				[5]=function()	--���
					if JY.Person[0]["����"]==13 then
						say("�ף������ƺ��кܶ�����ǰ���������ĵá�");
						E_readbook();
					end
				end,
				[6]=function()	--��Ϣ
					if JY.Person[0]["����"]==13 then
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
							visit(13);
						end
					else
						visit(13);
					end
					walkto_old(3,0);
				end,
				[7]=function()	--����
					if JY.Person[0]["����"]~=13 then	--�����ص���
						say("��������������Ϣ��",JY.Da);
					else
						say("����Ҫ��ָ�����书��",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							--say("����ɽ�书�������Ҫ�ú���ϰ��",JY.Da);
							RandomEvent(JY.Da);
						elseif r==2 then
							say("Ŷ������ѧ��ʲô��",JY.Da);
							local kflist={
												{241,10},
												{242,10},
												{243,10},
												{244,10},
												{245,10},
												{248,10},
												{250,10},
												};
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if true then
								say("���ǵ㵽��ֹ�����ɣ�",JY.Da);
								local result=vs(0,-1,27,JY.Da,13,26,3000);
								Cls();
								ShowScreen();
								if result then
									say("�������Ŭ���˰���",JY.Da);
								else
									say("û���˰ɣ�ȥ��Ϣ�°ɡ�",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("ȥ�ɡ�",JY.Da);
						end
					end
				end,
				[8]=function()--����
					if JY.Person[0]["����"]~=13 then	--�����ص���
						script_say("���ص��ӣ������ǳ�����ûʲô�ÿ��ġ�");
					elseif JY.Da>0 then
						local menu={
												{"����",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
						if r==1 then
							--say("ȥȥȥ����û���Է�ʱ���ء�",JY.Da);
							RandomEvent(JY.Da);
						elseif r==2 then
							say("�����ǳ�����ʦ����ͱ������ˣ�ȥ�ұ��ʦ�ֵ��д��",JY.Da);
						elseif r==3 then
							PersonStatus(JY.Da);
						elseif r==4 then
							say("û�¾ͱ������ˣ��Ͻ���ȥ�ɡ�",JY.Da);
						end
					else
						script_say("���ص��ӣ����վ�������Һò��ã���ʦ�����������㡣");
					end
				end,
				[11]=function()		--��
				end,
				[12]=function()		--��
				end,
			}

						--say("")