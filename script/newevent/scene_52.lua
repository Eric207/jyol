SceneEvent[52]={};--������ϸ��¼�
SceneEvent[52]={
				[2]=function()	--�����
					if JY.Person[0]["����"]==10 then
						say("������������Ȿ�ؼ��ɡ�");
						local kflist=	{
											{JY.Da,10},
										};
						LearnKF(0,320,kflist);
					else
						say("����ǹ���Ľ�ݵĻ�ʩˮ�󰡣�");
					end
				end,
				[3]=function()	--����
					if JY.Person[0]["����"]~=10 then	--��Ľ�ݼҽ�
						say("�������ã�",JY.Da);
					elseif JY.Da>0 then
						say("�Ҷ����ã�����Ȼ֪����������Ҳ�Ǻܺõġ����ǡ������ǡ���",JY.Da);
						local menu={
												{"����",nil,1},
												{"�д�",nil,1},
												{"����",nil,0},
												{"ѧ��",nil,0},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						if GetFlag(20003)==1 then
							menu[4][3]=1;
						end
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							RandomEvent(JY.Da);
						elseif r==2 then
							say("��ʲô�书�����ᰡ���������˰ɡ�",JY.Da);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							local kflist={
											{195,10},
											};
							LearnKF(0,JY.Da,kflist);
						elseif r==5 then
							PersonStatus(JY.Da);
						elseif r==6 then
							--say("���������£������������죬�����д����书Ҳ�á�",JY.Da);
						end
					else
						script_say("�����̣��Ҷ����ã�����Ȼ֪����������Ҳ�Ǻܺõġ����ǡ������ǡ���");
					end
				end,
				[4]=function()	--Ľ�ݸ�
					if JY.Person[0]["����"]~=10 then	--��Ľ�ݼҽ�
						say("�벻�����¾�Ȼ���ҵ�����������",JY.Da);
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
							RandomEvent(JY.Da);
						elseif r==2 then
							if true then
								say("���Ź���Ľ�ݶ�ת�����������֣���֪�ܷ�������£�");
								say("��Ľ���ϱ�λ���������ᣬ��Ҫ��������Ҳ�����ף�ֻҪ���ܷ��������˸����ࡣ",JY.Da);
								if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ�������Ľ�ݣ�",C_WHITE,CC.Fontbig) then
									say("����Ը������һ��֮����");
									JY.Person[0]["����"]=10;
									JY.Shop[5]["����ʱ��"]=GetFlag(1);
									DrawStrBoxWaitKey(JY.Person[0]["����"].."����Ϲ���Ľ��",C_WHITE,CC.Fontbig);
									JY.Person[0]["���"]="Ľ�ݼҽ�";
									--GetItem(5,1);
								else
									say("��Ǹ��");
								end
							end
						elseif r==3 then
							PersonStatus(JY.Da);
						else
							
						end
					else
						say("�μ�����ү��");
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
							if GetFlag(20002)==0 and JY.Person[0]["����"]==10 then
								local n=0;
								for i=1,CC.MaxKungfuNum do
									if JY.Person[0]["�����书"..i]>0 then
										n=n+1;
									end
								end
								if n>5 then
									SetFlag(20002,1)
									script_say("Ľ�ݸ����ҵ�һ���򣬴�����Ի�ʩˮ���еĸ����ؼ������������ң�������ȥ��ʩˮ����ĸ����ؼ���")
									script_say("���ǣ������ӣ�С���������Ļ�ʩˮ���е��ؼ�������ȴ�������в�û�и�����ķ������ļ�¼��")
									script_say("Ľ�ݸ����š���˵�����⣬�ҵ���Ҳ������������һ�����ȷ������Ƿȱ�������ɣ��������ұ㴫��һ��[������]�������ķ�������ȥ�������̡������䲻���䣬����                           ֪������ѧ���������ܸ���һ���𸴡�")
									script_say("���ǣ�л���ӣ�")
									return;
								end
							end
							if GetFlag(20004)==0 and GetFlag(20002)==1 and JY.Person[0]["����"]==10 then
								local n=0;
								for i=1,CC.MaxKungfuNum do
									if JY.Person[0]["�����书"..i]>0 then
										n=n+1;
									end
								end
								if n>10 then
									SetFlag(20004,1)
									script_say("���ǣ������ӣ�С���ڻ�ʩˮ����Ѱ�Ҷ��գ�ȴ���ָ��Ÿ��ɵľ�ѧ��û�б��ղؽ�������֪����")
									script_say("Ľ�ݸ����������Ҳ�������ʵ�����յĻ�ʩˮ��ֻ�Ǻ󽨳ɵġ���������Ľ�ݼҵ������ղظ��Ÿ��ɾ�ѧ�书�ĵط�������һ���С��ŋָ��ء��ĵط���ֻ��ϧ�ǡ��ŋָ��ء���λ�ã�ȴ����ʧ���˰���")
									if GetFlag(20005)==2 then
										script_say("���ǣ��ŋָ��أ�������������ɽ����һ��ɽ����������һ���ղ��书�ؼ������ڣ����ǽ��ŋָ���")
										script_say("Ľ�ݸ������𣡿�����ǰȥ��")
										script_say("���ǣ����ӣ���ȥ��ʱ�������Ѿ�ʲô�ղض�û���ˣ��ƺ��Ѿ�����ȡ���˰���")
										script_say("Ľ�ݸ���ʲô��ʲô�˾�Ȼ��͵����Ľ�ݼҲ��飡�Ҷ����������ˣ�Ѱ�ز��飡")
									end
									return;
								end
							end
							if GetFlag(20002)==0 then
								say("��ȥ��ʩˮ��ɣ������ղ������¸��Ÿ��ɵ��书�ؼ���",JY.Da);
							else
								say("Ŷ������ѧ��ʲô��",JY.Da);
								local kflist={
												{193,10},
												{194,10},
												{196,10},
												};
								LearnKF(0,JY.Da,kflist);
							end
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<1 then
								say("�㣿���������û�������",JY.Da);
							else
								say("�ã����㱾����������",JY.Da);
								local result=vs(0,21,27,JY.Da,13,26,3000);
								Cls();
								ShowScreen();
								if result then
									say("......",JY.Da);
								else
									say("����������죡",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("���£�",JY.Da);
						end
					end
				end,
				[5]=function()	--���
					if JY.Person[0]["����"]==14 then
						say("�ף������ƺ��кܶ�ǰ���������ĵá�");
						E_readbook();
					end
				end,
				[6]=function()	--���� Ԥ���Ժ��¼�ʹ��
					return true;
				end,
			}

SceneEvent[116]=SceneEvent[52];