SceneEvent[27]={};--��ɽ�ɸ��¼�
SceneEvent[27]={
				[1]=function()	--���ŵ���
					--��ʱ��������ɽ����
					if JY.Person[0]["����"]~=5 then	--��̩ɽ����
						local d=JY.Base["�˷���"];
						if d==2 then
							say("��������ɽ���صأ�����Ҫ�£������뿪��",JY.Da);
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
						else
							menu[1][3]=0;
							menu[2][3]=0;
						end
						if JY.Person[0]["����"]>=0 then	--��������
							menu[2][3]=0;
						end
						local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
						if r==1 then
							say("������",JY.Da);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						elseif r==2 then
							say("��Ȼ��ˣ�����ͨ�����š�",JY.Da);
							Dark();
							JY.Base["��X1"]=16;
							JY.Base["��Y1"]=26;
							JY.Base["�˷���"]=2;
							 JY.MyPic=GetMyPic();
							Light();
							--��ʱ�����ǰ�ʦ����
							if true then
								say("С�ֵܣ����Ը������ɽ����ı���£�",110);
								if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ������ɽ�ɣ�",C_WHITE,CC.Fontbig) then
									say("ʦ�����ϣ�����ͽ��һ�ݣ�");
									say("�ܺã�����������������ɽ���¡�ֻ��Ϊʦ�����²�����Ͼָ������书����ƽ�տ�������ʦ��ϰ�䣬������������������д衣",110);
									JY.Person[0]["����"]=5;
									JY.Shop[5]["����ʱ��"]=GetFlag(1);
									DrawStrBoxWaitKey(JY.Person[0]["����"].."�������ɽ��",C_WHITE,CC.Fontbig);
									JY.Person[0]["���"]="��ɽ����";
									GetItem(5,1);
								else
									say("������ˣ�ˡ��Զ�͡�",110);
								end
							else
								say("�����ڽ���������ʢ�����ֺα�����ǲ����ɽѰ���أ�",110);
							end
						elseif r==3 then
							--say("��Ȼ���£��͸Ͻ��뿪�ɡ�",JY.Da);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						elseif r==4 then
							say("���¼�Ȼ���£���������ȥ�ա�",JY.Da);
						end
					else
						local d=JY.Base["�˷���"];
						if JY.Da>0 then
							say("�к�ָ�̣�",JY.Da);
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
								ModifyWarMap=function()
									SetWarMap(25,26,1,851*2);
									SetWarMap(25,27,1,851*2);
									SetWarMap(25,28,1,851*2);
									SetWarMap(25,29,1,851*2);
									SetWarMap(48,29,1,1285*2);
								end
								local result=vs(0,39,28,JY.Da,29,28,300);
								--[[SetWarMap(25,26,1,921*2);
								SetWarMap(25,27,1,0);
								SetWarMap(25,28,1,0);
								SetWarMap(25,29,1,919*2);
								SetWarMap(48,29,1,0);]]--
								Cls();
								ShowScreen();
								if result then
									say("��������գ��ؽ���ί�����Ρ�",JY.Da);
								else
									say("������δ���Ұ�����Ҫ�ٶ��Ŭ����",JY.Da);
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
								say("ʦ���������£������������죬�����д����书Ҳ�á�",JY.Da);
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
					if JY.Person[0]["����"]~=5 then	--����ɽ����
						say("������ҰС�ӣ�������ȥ�ģ�",JY.Da);
					elseif JY.Da>0 then
						say("������",JY.Da);
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
								SetWarMap(25,26,1,851*2);
								SetWarMap(25,27,1,851*2);
								SetWarMap(25,28,1,851*2);
								SetWarMap(25,29,1,851*2);
								SetWarMap(48,29,1,1285*2);
							end
								local result=vs(0,39,28,JY.Da,29,28,300);
							--[[	SetWarMap(25,26,1,921*2);
								SetWarMap(25,27,1,0);
								SetWarMap(25,28,1,0);
								SetWarMap(25,29,1,919*2);
								SetWarMap(48,29,1,0);]]--
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
							say("���������£������������죬�����д����书Ҳ�á�",JY.Da);
						end
					else
						say("����ɽ�ɽ����������س��ȣ���ؽ��ϡ�",20);
					end
				end,
				[3]=function()	--������
					if JY.Person[0]["����"]~=5 then
						say("��������ɽ��������֮��������������뿪��",80);
					else
						say("���������ģ�",JY.Da);
						E_training(JY.Da);
					end
				end,
				[4]=function()	--����
					if JY.Person[0]["����"]~=5 then	--����ɽ����
						say("��Ҫ�ڴ��������ǡ�",JY.Da);
					else
						if GetFlag(12005)==0 and JY.Person[0]["����"]>30 and GetFlag(10004)~=0 and GetFlag(16001)==2 then
							SetFlag(12005,1);
							say("��ɽ�������⼸�վ�Ҫ����ϴ���˳������������������Ҳȥ�μӹ���ɡ�",JY.Da);
							say("�ǣ�");
							say("��������ȥ��ɽ����Ҫ������һ�����顣",JY.Da);
							say("��ʦ��ʾ�£�");
							say("��Ҫ��Ǳ��������լ����������ļ�С���¡�Ȼ����ѱ�ʦ������ȥ���������硣",JY.Da);
							say("ʦ��������ͽ���ӵ���ӣ�ֻ������������һ��ͬ����֦�������Ϊ��ֻ��......");
							say("�ߣ��������簵�й���ħ�̣�����Ͷ��֮�⡣��Ȼ����Ϊ���������ʢ�꣬���Ի��˳�������",JY.Da);
							return;
						end
						say("�μ�ʦ����");
						say("ͽ������Ϊʦ��ʲô����",JY.Da);
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
								say("Ϊʦ�����������������ʦ��ȥѧ��ɡ�",JY.Da);
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
				[5]=function()	--���
					if JY.Person[0]["����"]==5 then
						say("�ף������ƺ��кܶ�����ǰ���������ĵá�");
						E_readbook();
					end
				end,
				[6]=function()	--��Ϣ
					if JY.Person[0]["����"]==5 then
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
							visit(5);
						end
					else
						visit(5);
					end
					walkto_old(0,3);
				end,
				[7]=function()	--����
					if JY.Person[0]["����"]~=5 then	--��̩ɽ����
						say("������ɽ�صأ�������ȥ��",JY.Da);
					else
						say("���к��£�",JY.Da);
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
							say("���¾�ȥ��ʦ�ֵ����д�ȥ��",JY.Da);
						end
					end
				end,
				[8]=function()	--�����ѱ�
					if JY.Person[0]["����"]~=5 then	--��̩ɽ����
						say("������ɽ�صأ�������ȥ��",JY.Da);
					else
						say("���к��£�",JY.Da);
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
												{62,10},
												{63,10},
												{64,10},
												{65,10,1},
												{66,10,3},
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
							say("���¾�ȥ��ʦ�ֵ����д�ȥ��",JY.Da);
						end
					end
				end,
			}

						--say("")