SceneEvent[34]={};--����ɸ��¼�
SceneEvent[34]={
				[1]=function()	--���ŵ���
					--��ʱ��������Ἱ���
					if JY.Person[0]["����"]~=12 then	--����ἵ���
						local d=JY.Base["�˷���"];
						if d==2 then
							say("��������𽭺�������Ī��������ʦ����",JY.Da);
						else
							say("���Ҫ������",JY.Da);
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
							say("��������ƽƽ�������ʦ������ʦ��Ҳ�����յġ���ȥ�ɣ���Ҫ�������ܣ�",JY.Da);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						elseif r==2 then
							say("��������Ȼ����Ľ�������ѧ���ˡ��������ȥ�ɣ�ף����ˣ�",JY.Da);
							Dark();
							JY.Base["��X1"]=16;
							JY.Base["��Y1"]=28;
							JY.Base["�˷���"]=2;
							 JY.MyPic=GetMyPic();
							Light();
							--��ʱ�����ǰ�ʦ����
							if true then
								say("��������������ϣ�����պ���Ŭ���ù���",378);
								if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ��������ɣ�",C_WHITE,CC.Fontbig) then
									say("ʦ�����ϣ�����ͽ��һ�ݣ�");
									say("���ã����ã�",378);
									JY.Person[0]["����"]=12;
									JY.Shop[5]["����ʱ��"]=GetFlag(1);
									DrawStrBoxWaitKey(JY.Person[0]["����"].."����������",C_WHITE,CC.Fontbig);
									JY.Person[0]["���"]="��ἵ���";
									--GetItem(5,1);
								else
									say("�ߣ���ȻϷˣ���ң�",378);
								end
							else
								say("�����ڽ���������ʢ�����ֺα�����ǲ�����Ѱ���أ�",378);
							end
						elseif r==3 then
							--say("��Ȼ���£��͸Ͻ��뿪�ɡ�",JY.Da);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						elseif r==4 then
							say("�������£����������뿪��",JY.Da);
						end
					else
						local d=JY.Base["�˷���"];
						if JY.Da>0 then
							say("������",JY.Da);
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
								say("�ã���������ָ��ָ���㣡",JY.Da);
								local result=vs(0,-1,28,JY.Da,29,28,300);
								Cls();
								ShowScreen();
								if result then
									say("����һʱ���Ҷ��ѡ�",JY.Da);
								else
									say("����������ָ�����ǲ��������ǳ����",JY.Da);
								end
								DayPass(1);
							elseif r==3 then
								PersonStatus(JY.Da);
							elseif r==4 then
								--say("��л������⣬��ϧ��������֮���޷�������",JY.Da);
								E_guarding(JY.Da);
							elseif r==5 then
								say("�����ɡ�",JY.Da);
								Dark();
								JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
								JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
								Light();
							elseif r==6 then
								say("ȥ�ɡ�",JY.Da);
								Dark();
								JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
								JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
								Light();
							elseif r==7 then
								say("û���㻹��������ƣ�",JY.Da);
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
					if JY.Person[0]["����"]~=12 then	--�����ص���
						say("�������������������֮һ�����ֱ�����",JY.Da);
					elseif JY.Da>0 then
						say("����Ҫ���ҽ���������",JY.Da);
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
							say("�ã���������ָ��ָ���㣡",JY.Da);
								local result=vs(0,-1,28,JY.Da,29,28,300);
							Cls();
							ShowScreen();
							if result then
								say("����һʱ���Ҷ��ѡ�",JY.Da);
							else
								say("����������ָ�����ǲ��������ǳ����",JY.Da);
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
						script_say("��ἵ��ӣ��������������������֮һ�����ֱ�����");
					end
				end,
				[3]=function()	--������
					if JY.Person[0]["����"]~=12 or JY.Da<=0 then
						script_say("��ἵ��ӣ��������ڳ�֮�Ժ㡣");
					else
						say("�������ɣ�",JY.Da);
						E_training(JY.Da);
					end
				end,
				[4]=function()	--����
					if JY.Person[0]["����"]~=12 then	--����ἵ���
						say("����Զ���ǿͣ�������ιۡ�",JY.Da);
					else
						say("����������ʲô��������",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							RandomEvent(JY.Da);
						elseif r==2 then
							say("�����룬�ٽ����ʲô���أ�",JY.Da);
							local kflist={
												{231,10},
												{232,10},
												{233,10,3},
												{234,10},
												{235,10},
												};
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<14 then
								say("��С�������ֹ��������ҵĶ��֣�",JY.Da);
							else
								say("�ã����ҿ����㹦��������û�н�����",JY.Da);
								local result=vs(0,-1,27,JY.Da,13,26,3000);
								Cls();
								ShowScreen();
								if result then
									say("����������Ӧ�ö������㹦���ġ�",JY.Da);
								else
									say("�����ܼ����ô���������ܿɹ��ˡ�",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("��ȥ�ɡ�",JY.Da);
						end
					end
				end,
				[5]=function()	--���
					if JY.Person[0]["����"]==12 then
						say("�ף������ƺ��кܶ�����ǰ���������ĵá�");
						E_readbook();
					end
				end,
				[6]=function()	--��Ϣ ����
					if JY.Person[0]["����"]==12 then
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
							visit(12);
						end
					else
						visit(12);
					end
					walkto_old(3,0);
				end,
				[7]=function()	--���� ����
					if JY.Person[0]["����"]~=12 then	--�����ص���
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
					if JY.Person[0]["����"]~=12 then	--����ἵ���
						script_say("��ἵ��ӣ������ǳ�����ûʲô�ÿ��ġ�");
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
						script_say("��ἵ��ӣ����վ�������Һò��ã���ʦ�����������㡣");
					end
				end,
				[11]=function()		--��
				end,
				[12]=function()		--��
				end,
			}

						--say("")