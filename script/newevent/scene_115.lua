SceneEvent[115]={};--������ϸ��¼�
SceneEvent[115]={
				[1]=function()	--���ŵ���
					--��ʱ�����Ǵ�����Ϲ���
					if JY.Person[0]["����"]~=7 then
						script_say("���ϼҽ����˴����Ǵ�������������");
					else
						if JY.Da>0 then
							say("�к�ָ�̣�",JY.Da);
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
								say("�ã����ǽ���������",JY.Da);
								local result=vs(0,-1,32,JY.Da,29,25,100);
								Cls();
								ShowScreen();
								if result then
									say("��лָ�㣡",JY.Da);
								else
									say("���ҽ��ң�",JY.Da);
								end
								DayPass(1);
							elseif r==3 then
								E_guarding(JY.Da);
							elseif r==4 then
								PersonStatus(JY.Da);
							elseif r==5 then
								say("�ٻᣡ",JY.Da);
							end
						else
							script_say("���ϼҽ����ٻᣡ");
						end
					end
				end,
				[2]=function()	--�д�+��������
					if JY.Person[0]["����"]~=7 then	--�Ƕ��ϵ���
						say("�˴����Ǵ�������������",JY.Da);
					elseif JY.Da>0 then
						say("�к�ָ�̣�",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,1},
												{"�д�",nil,1},
												{"����",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,6,0,0,0,0,0,1,0);
						if r==1 then
							RandomEvent(JY.Da);
						elseif r==2 then
							local n=0;
							local kflist={};
							for i=1,10 do
								if JY.Person[JY.Da]["�����书"..i]>0 then
									n=n+1;
									table.insert(kflist,{JY.Person[JY.Da]["�����书"..i],limitX(1+math.modf(JY.Person[JY.Da]["�����书����"..i]/100),1,100)})
								end
							end
							if n>0 then
								say("Ŷ������ѧ��ʲô��",JY.Da);
								LearnKF(0,JY.Da,kflist);
							else
								say("��û��ʲô�ɽ̸���ġ�",JY.Da);
							end
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							say("�ð������������档",JY.Da);
								local result=vs(0,-1,28,JY.Da,29,28,300);
							Cls();
							ShowScreen();
							if result then
								say("��������",JY.Da);
							else
								say("������ȥ�������������´����д��д衣",JY.Da);
							end
							DayPass(1);
						elseif r==4 then
							E_learning(JY.Da);
						elseif r==5 then
							PersonStatus(JY.Da);
						else
							--say("���������£������������죬�����д����书Ҳ�á�",JY.Da);
						end
					else
						script_say("���ϼҽ����˴����Ǵ�������������");
					end
				end,
				[3]=function()	--�ĳ�
					if JY.Person[0]["����"]~=7 then	--�Ƕ��ϵ���
						say("�˴����Ǵ�������������",JY.Da);
					elseif JY.Da>0 then
						say("�к�ָ�̣�",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,1},
												{"�д�",nil,1},
												{"����",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,6,0,0,0,0,0,1,0);
						if r==1 then
							RandomEvent(JY.Da);
						elseif r==2 then
							local n=0;
							local kflist={};
							for i=1,10 do
								if JY.Person[JY.Da]["�����书"..i]>0 then
									n=n+1;
									table.insert(kflist,{JY.Person[JY.Da]["�����书"..i],limitX(1+math.modf(JY.Person[JY.Da]["�����书����"..i]/100),1,100)})
								end
							end
							if n>0 then
								say("Ŷ������ѧ��ʲô��",JY.Da);
								LearnKF(0,JY.Da,kflist);
							else
								say("��û��ʲô�ɽ̸���ġ�",JY.Da);
							end
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							say("�ð������������档",JY.Da);
								local result=vs(0,-1,28,JY.Da,29,28,300);
							Cls();
							ShowScreen();
							if result then
								say("��������",JY.Da);
							else
								say("������ȥ�������������´����д��д衣",JY.Da);
							end
							DayPass(1);
						elseif r==4 then
							E_learning(JY.Da);
						elseif r==5 then
							PersonStatus(JY.Da);
						else
							--say("���������£������������죬�����д����书Ҳ�á�",JY.Da);
						end
					else
						script_say("���ϼҽ����˴����Ǵ�������������");
					end
				end,
				[4]=function()	--����
					if JY.Person[0]["����"]~=7 then	--�Ƕ��ϵ���
						say("���������ÿͣ�����������������",JY.Da);
						local menu={
												{"����",nil,1},
												{"���",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						if JY.Person[0]["����"]>=0 then
							menu[2][3]=0;
						end
						local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
						if r==1 then
							RandomEvent(JY.Da);
						elseif r==2 then
							if true then
								say("�Ҷ��ϱ�����ԭ���ˣ���ϲ�ύ�������Ľ���������ǲ����⣬�������ڴ������ҽ��ɡ�",JY.Da);
								if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ���������ϣ�",C_WHITE,CC.Fontbig) then
									say("�ǣ��ݼ���ү��");
									JY.Person[0]["����"]=7;
									JY.Shop[5]["����ʱ��"]=GetFlag(1);
									DrawStrBoxWaitKey(JY.Person[0]["����"].."����ϴ������",C_WHITE,CC.Fontbig);
									JY.Person[0]["���"]="���ϼҽ�";
									--GetItem(5,1);
								else
									say("�ۣ����Ǹ��ҽ������ҲŲ�Ҫ�أ�");
								end
							end
						elseif r==3 then
							PersonStatus(JY.Da);
						else
							
						end
					else
						say("�μ���ү��");
						say("�������棿",JY.Da);
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
												{101,10},
												{102,10},
												{103,10},
												{109,10},
												};
							if GetFlag(17004)==1 then
								kflist=	{
												{101,10},
												{102,10},
												{103,10},
												{109,10},
												{110,10},
										};
							end
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<15 then
								say("�㣿���������û�������",JY.Da);
							else
								say("Ҳ�ã�����Ҫ��ʶ�����ж�ߵġ�",JY.Da);
								ModifyWarMap=function()
									SetWarMap(25,26,1,851*2);
									SetWarMap(25,27,1,851*2);
									SetWarMap(25,28,1,851*2);
									SetWarMap(25,29,1,851*2);
								end
								local result=vs(0,21,27,JY.Da,13,26,3000);
								--[[SetWarMap(25,26,1,921*2);
								SetWarMap(25,27,1,0);
								SetWarMap(25,28,1,0);
								SetWarMap(25,29,1,919*2);]]--
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
							say("���¾�ȥ��ʦ�ֵ����д�ȥ��",JY.Da);
						end
					end
				end,
				[5]=function()	--����
					if JY.Person[0]["����"]~=7 then	--�Ƕ��ϵ���
						say("������Զ�����������ֺ���",JY.Da);
					elseif JY.Da>0 then
						say("������Զ�����������ֺ���",JY.Da);
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
							if true then
								say("���ɱɱ�����˺��������ǲ�Ҫ�ˡ�",JY.Da);
								return;
							end
							say("�ð������������档",JY.Da);
								local result=vs(0,-1,28,JY.Da,29,28,300);
							Cls();
							ShowScreen();
							if result then
								say("��������",JY.Da);
							else
								say("������ȥ�������������´����д��д衣",JY.Da);
							end
							DayPass(1);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							--say("���������£������������죬�����д����书Ҳ�á�",JY.Da);
						end
					else
						script_say("���ϼҽ����˴����Ǵ�������������");
					end
				end,
				[6]=function()	--���� Ԥ���Ժ��¼�ʹ��
					return true;
				end,
				[7]=function()	--����̩
					if JY.Person[0]["����"]~=7 then	--�Ƕ��ϵ���
						say("�˴����Ǵ�������������",JY.Da);
					else
						say("�˴����Ǵ�������������",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,0},
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
												{59,10},
												{60,10},
												--{61,10,1},
												{62,10},
												{63,10},
												{64,10},
												--{65,10,1},
												{77,10},
												--{78,10,2},
												{79,10},
												};
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if true then
								say("����������Ҳ�Һ��ҹ��С�",JY.Da);
								ModifyWarMap=function()
									SetWarMap(25,26,1,851*2);
									SetWarMap(25,27,1,851*2);
									SetWarMap(25,28,1,851*2);
									SetWarMap(25,29,1,851*2);
								end
								local result=vs(0,21,27,JY.Da,13,26,3000);
								--[[SetWarMap(25,26,1,921*2);
								SetWarMap(25,27,1,0);
								SetWarMap(25,28,1,0);
								SetWarMap(25,29,1,919*2);]]--
								Cls();
								ShowScreen();
								if result then
									say("��������Ȼ���Ҵ����ˣ�������������һ����Ҳ�����ܿɹ��ˡ�",JY.Da);
								else
									say("��ȥ��������ɡ�",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("���°ɡ�",JY.Da);
						end
					end
				end,
				[8]=function()	--����
					if JY.Person[0]["����"]~=14 then	--��ȫ�����
						script_say("���ϼҽ��������ǳ�����ûʲô�ÿ��ġ�");
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
						script_say("���ϼҽ������վ�������Һò��ã���ʦ�����������㡣");
					end
				end,
			}

						--say("")