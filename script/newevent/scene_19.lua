SceneEvent[19]={};--ȫ��̸��¼�
SceneEvent[19]={
				[0]=function()
					if JY.Da>0 then
						say("�����",JY.Da);
					else
						script_say("ȫ����ӣ������");
					end
				end,
				[1]=function()	--���ŵ���
					--��ʱ������ȫ�湫��
					if JY.Person[0]["����"]~=14 then	--��ȫ�����
						local d=JY.Base["�˷���"];
						if d==0 then
							say("ƶ�������ˣ���֪С�ֵ��������£�",JY.Da);
						else
							say("������������",JY.Da);
						end
						local menu={
												{"����",nil,1},
												{"��ʦ",nil,1},
												{"�뿪",nil,1},
												{"û��",nil,1},
											};
						if d==0 then
							menu[3][3]=0;
						else
							menu[1][3]=0;
							menu[2][3]=0;
						end
						menu[2][3]=0;
						if JY.Person[0]["����"]>=0 then	--��������
							menu[2][3]=0;
						end
						local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
						if r==1 then
							say("�����",JY.Da);
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
									JY.Person[0]["����"]=14;
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
							say("С�ֵ����Ա㡣",JY.Da);
						end
					else
						local d=JY.Base["�˷���"];
						if JY.Da>0 then
							say("�����������£�",JY.Da);
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
								say("���������飡",JY.Da);
								local result=vs(0,-1,28,JY.Da,29,28,300);
								Cls();
								ShowScreen();
								if result then
									say("�ÿ������֣�",JY.Da);
								else
									say("�����ˣ�",JY.Da);
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
								say("�롣",JY.Da);
								Dark();
								JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
								JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
								Light();
							elseif r==7 then
								say("�������Ա㡣",JY.Da);
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
					if JY.Person[0]["����"]~=14 then	--��ȫ�����
						script_say("ȫ����ӣ�ȫ�����书����ѧ���ڡ�");
					elseif JY.Da>0 then
						say("�����������£�",JY.Da);
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
								say("�ÿ������֣�",JY.Da);
							else
								say("�����ˣ�",JY.Da);
							end
							DayPass(1);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("�������Ա㡣",JY.Da);
						end
					else
						script_say("ȫ����ӣ�ȫ�����书����ѧ���ڡ�");
					end
				end,
				[3]=function()	--������
					if JY.Person[0]["����"]~=14 or JY.Da<=0 then
						script_say("ȫ����ӣ��������ڳ�֮�Ժ㡣");
					else
						say("�������ɣ�",JY.Da);
						E_training(JY.Da);
					end
				end,
				[4]=function()	--����
					if JY.Da==433 then--����
						say("һס���Ѽ�ʮ�꣬��ͷ��������ߡ�",JY.Da);
					elseif JY.Da==438 then--̷����
						say("�������鳣�ܱʣ��Ŀ����������",JY.Da);
					elseif JY.Da==436 then--������
						say("�����໽֪���⣬媳��鲨���ɸߡ�",JY.Da);
					elseif JY.Da==435 then--�𴦻�
						say("����ͤ�������ӣ���Ҷ����̫����",JY.Da);
					elseif JY.Da==434 then--����һ
						say("�˵����Ƨ�����벻����Ҳ��������",JY.Da);
					elseif JY.Da==439 then--�´�ͨ
						say("�����������⣬��������δ��ǰ��",JY.Da);
					elseif JY.Da==437 then--�ﲻ��
						say("����һЦ�޾а����������������죡",JY.Da);
					else
						say("��������������",JY.Da);
					end
					if JY.Person[0]["����"]~=14 then	--��ȫ�����
						local menu={
												{"����",nil,1},
												{"��ʦ",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
									};
						if JY.Person[0]["����"]>=0 then
							menu[2][3]=0;
						end
						local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
						if r==1 then
							say("......",JY.Da);
						elseif r==2 then
							say("���Ӿ���"..JY.Person[JY.Da]["���"].."��ʦ���ɷ���ǣ����������£���Ϧ�̷��֪��ʦ��Ӧ�ʷ�");
							if JY.Da==437 then
								say("�Ҳ����е��ӵģ��㻹����Ѱ���˰ɡ�",JY.Da);
							else
								if true then
									say("���������ʦү�����������������������޵�����Ϊ����ȫ����书��Ȼ�����ѧ֮�޾��������������Ź��Ƿǳ������ģ���Ը���𣿡�",JY.Da);
									if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ����ȫ��̣�",C_WHITE,CC.Fontbig) then
										say("�ǣ�����Ը�����������������ʦ�� �̻壬��������ʦ��Ը�����Υ�棡");
										say("�����Ű���ʦ�ͱ������ʦ����˵�Ļ�������ʱҪ�ڷܿ̿࣬����ú��ù���������ȫ����ӵ�������",JY.Da);
										JY.Person[0]["����"]=14;
										JY.Shop[5]["����ʱ��"]=GetFlag(1);
										SetFlag(1003,JY.Da);
										DrawStrBoxWaitKey(JY.Person[0]["����"].."�����ȫ���",C_WHITE,CC.Fontbig);
										JY.Person[0]["���"]="ȫ�����";
										--GetItem(5,1);
									else
										say("�ۣ���ô�鷳�İ�����ʲô��Ц���Ҳ���ʦ�ˣ�");
									end
								else
									say("�����ڽ���������ʢ�����ֺα�����ǲ��ȫ���Ѱ���أ�",378);
								end
							end
						elseif r==3 then
							PersonStatus(JY.Da);
						else
							return;
						end
					else
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						if GetFlag(1003)~=JY.Da then
							menu[2][3]=0;
						end
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							RandomEvent(JY.Da);
						elseif r==2 then
							say("ȫ����书�������Ҫ�ú��ù���",JY.Da);
							local kflist={
												{261,10},--ȫ�潣
												{265,10},--ȫ����
												{270,10},--ȫ����
												{273,10},--ȫ����
										};
							if JY.Da==433 then--����
								kflist={
												{261,10},--ȫ�潣
												{265,10},--ȫ����
												{266,10},--������
												{267,10},--�����
												{268,10},--������
												{271,10},--������
												{272,10},--إ�ľ�
												{273,10},--ȫ����
												{274,10},--���㹦
										};
							elseif JY.Da==438 then--̷����
								kflist={
												{261,10},--ȫ�潣
												{262,10},--���ǽ�
												{265,10},--ȫ����
												{266,10},--������
												{267,10},--�����
												{268,8},--������
												{271,10},--������
												{272,10},--إ�ľ�
												{273,10},--ȫ����
												{274,8},--���㹦
										};
							elseif JY.Da==436 then--������
								kflist={
												{261,10},--ȫ�潣
												{262,10},--���ǽ�
												{263,8},--ͬ�齣
												{265,10},--ȫ����
												{266,10},--������
												{267,10},--�����
												{270,10},--ȫ����
												{271,10},--������
												{272,10},--إ�ľ�
												{273,10},--ȫ����
												{274,10},--���㹦
										};
							elseif JY.Da==435 then--�𴦻�
								kflist={
												{261,10},--ȫ�潣
												{262,10},--���ǽ�
												{264,6},--������
												{270,10},--ȫ����
												{272,8},--إ�ľ�
												{273,10},--ȫ����
												{274,10},--���㹦
										};
							elseif JY.Da==434 then--����һ
								kflist={
												{261,10},--ȫ�潣
												{262,10},--���ǽ�
												{263,10},--ͬ�齣
												{265,10},--ȫ����
												{266,10},--������
												{267,10},--�����
												{270,10},--ȫ����
												{273,10},--ȫ����
												{274,10},--���㹦
												{276,10},--��Ҷ
										};
							elseif JY.Da==439 then--�´�ͨ
								kflist={
												{261,10},--ȫ�潣
												{262,10},--���ǽ�
												{263,7},--ͬ�齣
												{265,10},--ȫ����
												{266,10},--������
												{267,10},--�����
												{271,10},--������
												{272,10},--إ�ľ�
												{273,10},--ȫ����
												{274,10},--���㹦
										};
							elseif JY.Da==437 then--�ﲻ��
								kflist={
												{261,10},--ȫ�潣
												{262,10},--���ǽ�
												{263,10},--ͬ�齣
												{265,10},--ȫ����
												{266,10},--������
												{270,10},--ȫ����
												{271,10},--������
												{272,8},--إ�ľ�
												{273,10},--ȫ����
												{274,10},--���㹦
										};
							else
								kflist={
												{261,10},--ȫ�潣
												{270,10},--ȫ����
												{273,10},--ȫ����
										};
							end
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<JY.Person[JY.Da]["�ȼ�"]-14 then
								say("�㻹���������ɡ�",JY.Da);
							else
								say("��ʲô��Ϊ����ʩչ�����ɣ�",JY.Da);
								local result=vs(0,-1,27,JY.Da,13,26,3000);
								Cls();
								ShowScreen();
								if result then
									say("�����н�����",JY.Da);
								else
									say("������ǲ���и���ˣ�",JY.Da);
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
					if JY.Person[0]["����"]==14 then
						say("�ף������ƺ��кܶ�����ǰ���������ĵá�");
						E_readbook();
					end
				end,
				[6]=function()	--��Ϣ ����
					if JY.Person[0]["����"]==14 then
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
							visit(14);
						end
					else
						visit(14);
					end
					walkto_old(3,0);
				end,
				[7]=function()	--���� ����
					if JY.Person[0]["����"]~=14 then	--��ȫ�����
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
					if JY.Person[0]["����"]~=14 then	--��ȫ�����
						script_say("ȫ����ӣ������ǳ�����ûʲô�ÿ��ġ�");
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
						script_say("ȫ����ӣ����վ�������Һò��ã���ʦ�����������㡣");
					end
				end,
				[11]=function()		--��
				end,
				[12]=function()		--��
				end,
			}

						--say("")