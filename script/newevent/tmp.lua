SceneEvent[1]={}
SceneEvent[1]={
				[1]=function()	--��ջ�ſ�,Ѱ������ɺ�¼�
					if not (GetFlag(10001)==1 or GetFlag(11002)==1 or GetFlag(1)-GetFlag(2)>60) then
						return true;
					elseif GetFlag(16001)~=0 then
						return true;
					else
						Dark();
						ModifyD(JY.SubScene,20,-2,-2,-2,-2,-2,5178,5178,5178,-2,-2,-2);
						ModifyD(JY.SubScene,22,-2,-2,-2,-2,-2,8520,8520,8520,-2,-2,-2);
						Light();
					end
					--35���˴�,36������,45��ǵ���,14����ɺ,9�͵�ŵ,136��ƽ֮,137ʷ��ͷ,138֣��ͷ,139-146��ʦ
					MoveSceneTo(24,17);	--�ӽ�:��ǵ���
					say("���֣��㿴���",36);
					MoveSceneTo(19,16);	--�ӽ�:����ɺ
					say("��椶����ĵ��ǲ���",35);
					say("......",14);
					say("ʦ�ã�С�������Ҵ�ı��һ����ʦ���Ľ���Ϊ�����������������",9);
					Dark();
					say("ʲô���������������۵Ĺ����ӣ�ȴ�����Ǹ��ݸ�����Ұ��",136)
					SetD(JY.SubScene,2,5,2931*2);
					SetD(JY.SubScene,2,6,2931*2);
					SetD(JY.SubScene,2,7,2931*2);
					Light();
					Cls();
					MoveSceneTo(22,18);	--�ӽ�:��ƽ֮
					PlayMovie(2,2931*2,2943*2);
					say("���϶����˼�������ġ�������ö�ү������˭��",36);
					say("��С�ӣ�����ױ��̨ȥ��������Ӳ�ǹ������ˣ�Ҫ˵��ܣ��ɻ����ɡ�",35);
					say("��λ�������Ǹ����ھֵ�������ͷ��������ӣ�����̫��ͷ�϶�����",137);
					say("�����ھ֣�����û���������Ǹ�ɶ�ӵģ�",36);
					say("ר�����ӵģ�",136)
					MoveSceneTo();
					local r;
					if JY.Person[0]["����"]==0 and GetFlag(10001)==1 then
						say("��������װ�������һ�ɽ�����ˣ�����һ��һŮ��һ��һ�٣�Ī�Ǿ��Ƕ�ʦ�ֺ�Сʦ�ã�");
						say("������Σ����Ұ�����ǡ�");
						ModifyWarMap=function()
							SetWarMap(22,26,1,854*2);
						end
						--SetWarMap(22,26,1,0);
						ModifyD(JY.SubScene,20,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,22,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,2,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,11,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,12,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,13,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,14,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						--����ɺ,�͵�ŵ�ػ�ɽ
						JY.Person[9]["����"]=0;
						JY.Person[14]["����"]=0;
						ModifyD(57,28,1,-2,5,14,-1,4259*2,4259*2,4259*2,-2,-2,-2);
						ModifyD(57,29,1,-2,5,9,-1,5180,5180,5180,-2,-2,-2);
						SetFlag(10001,2);	--Ѱ������ɺOK
						SetFlag(11002,2);
						SetFlag(16001,1);	--���������ھ�����
						SetFlag(16002,GetFlag(1));
						JY.Person[14]["�Ѻ�"]=50;
						r=FIGHT(
										5,6,
										{
											0,	21,21,
											136,22,20,
											-1,22,22,
											-1,21,23,
											-1,22,24,
										},
										{
											35,21,16,
											36,19,19,
											41,18,18,
											42,22,18,
											43,25,20,
											44,21,20,
										},
										1000,0,1
									);
						--Light();
						--SetWarMap(22,26,1,0);
						if r then
							DrawStrBoxWaitKey("��ս�У���ƽ֮�����ײ����Ȼ������������",C_WHITE,CC.Fontbig);
							say("��ʦ�ܣ���ʦ�������ѣ�",35);
							say("��..��ʦ��....֪ͨ....��....������Ϊ��....Ϊ��..����",36);
						else
							JY.Status=GAME_END;
							return;
						end
						say("Ī��������ҵ������յ�Сʦ�ܣ�",14);
						say("�ǰ���������ǰ�ɶ�ʦ������ǽ");
						say("�����书���Ĳ�������ʦ�������˸���ͽ�ܰ���",9);
						AddPerformance(10);
						say("���ҡ�");
						say("��ʦ�֣��ҿ������ھֺ��������Ȼ�Ƴ�ˮ������ɱ�Ȼ��ȥ�Ҹ����ھֵ��鷳��������ͷ�վ�������Ϊ���Ҳ����һ�£����Ǿ�ȥ������Ǻ���",14);
						say("���У������ɽ��ʦ�����н��������ö����Ƿǡ��������ģ������ջ�ɽ��ʦ���������������˼��������ǡ�",9);
					elseif JY.Person[0]["����"]==1 then
						say("��ʦ�֣���ʦ�֣���˼�Ʒ���ö�ү����С��Ҳ����һ������Ҫ�ã�");
						say("������Ҫ��Ҫ�á����ǹ��������ٺú����ơ�",36);
						ModifyWarMap=function()
							SetWarMap(22,26,1,854*2);
						end
						--SetWarMap(22,26,1,0);
						ModifyD(JY.SubScene,20,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,22,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,2,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,11,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,12,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,13,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,14,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						--����ɺ,�͵�ŵ�ػ�ɽ
						JY.Person[9]["����"]=0;
						JY.Person[14]["����"]=0;
						ModifyD(57,28,1,-2,5,14,-1,4259*2,4259*2,4259*2,-2,-2,-2);
						ModifyD(57,29,1,-2,5,9,-1,5180,5180,5180,-2,-2,-2);
						SetFlag(10001,2);	--Ѱ������ɺOK
						SetFlag(11002,2);
						SetFlag(16001,1);	--���������ھ�����
						SetFlag(16002,GetFlag(1));
						r=FIGHT(
										5,8,
										{
											0,	22,25,
											35,24,16,
											36,26,17,
											-1,21,25
											-1,23,25
										},
										{
											136,22,19,
											137,21,18,
											138,23,20,
											142,21,21,
											143,22,21,
											144,21,23,
											145,23,23,
											146,22,24,
										},
										1000,0
									);
						--Light();
						if r then
							DrawStrBoxWaitKey("��ս�У���ƽ֮�����ײ����Ȼ�˵���������",C_WHITE,CC.Fontbig);
							say("��ʦ�ܣ���ʦ�������ѣ�",35);
							say("��ʦ�磬��û�£��ˣ���㣬С�˲����¡�",36);
							say("�Ͻ�����ʦ�ֻ�ȥ���˰�");
							say("�����������ʦ�ֻ�ȥ��",45);
							ModifyD(36,16,1,-2,6,36,-1,6038,6038,6038,-2,-2,-2);
						else
							DrawStrBoxWaitKey("��ս�У���ƽ֮�����ײ����Ȼ������������",C_WHITE,CC.Fontbig);
							say("��ʦ�ܣ���ʦ�������ѣ�",35);
							say("��..��ʦ��....֪ͨ....��....������Ϊ��....Ϊ��..����",36);
						end
						say("���������ڣ��֣����Ʊ����������Ÿ���ʦ�ֱ���",35);
						say("С���䲻�ţ�ȴԸ����ʦ��һͬѪȾ���ݣ�");
						say("�á�Ϊ������һ�����쿴�����ھֵĶ��������Ȼ�ȥ��ʦ��������¡�",35);
						say("�ǣ�ʦ�֡����Ұ��������������һ�£����̻سǡ�");
						--SetWarMap(22,26,1,0);
					else
						if JY.Person[0]["����"]==0 then
							say("�����˵�װ���������һ�ɽ�ɣ�����Ϊ����ȴ����û�м�����")
						end
						ModifyWarMap=function()
							SetWarMap(22,26,1,854*2);
						end
						ModifyD(JY.SubScene,20,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,22,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,2,-2,-2,-2,-2,-2,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,11,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,12,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,13,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						ModifyD(JY.SubScene,14,-2,-2,-1,-1,-1,-1,-1,-1,-2,-2,-2);
						--����ɺ,�͵�ŵ�ػ�ɽ
						JY.Person[9]["����"]=0;
						JY.Person[14]["����"]=0;
						ModifyD(57,28,1,-2,5,14,-1,4259*2,4259*2,4259*2,-2,-2,-2);
						ModifyD(57,29,1,-2,5,9,-1,5180,5180,5180,-2,-2,-2);
						SetFlag(10001,2);	--Ѱ������ɺOK
						SetFlag(11002,2);
						SetFlag(16001,1);	--���������ھ�����
						SetFlag(16002,GetFlag(1));
						r=FIGHT(
										3,3,
										{
											136,22,19,
											137,21,18,
											138,23,20,
										},
										{
											35,24,16,
											36,26,17,
											45,24,19,
										},
										0,0
									);
						--SetWarMap(22,26,1,0);
						--Dark();
						--Light();
						if r then
							DrawStrBoxWaitKey("��ս�У���ƽ֮�����ײ����Ȼ������������",C_WHITE,CC.Fontbig);
							say("��ʦ�ܣ���ʦ�������ѣ�",35);
							say("��..��ʦ��....֪ͨ....��....������Ϊ��....Ϊ��..����",36);
						end
						if JY.Person[0]["����"]==0 then
							say("��ѽ����������ʲôʱ�򲻼��ˣ��һ��ǻػ�ɽȥ�����ɡ�")
						end
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
			}SceneEvent[27]={};--��ɽ�ɸ��¼�
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

						--say("")SceneEvent[29]={};--̩ɽ�ɸ��¼�
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

						--say("")SceneEvent[36]={};--����ɸ��¼�
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

						--say("")SceneEvent[38]={};--�����Ǹ��¼�
SceneEvent[38]={
				[1]=function()--����ϰ��
					say("Ҫѧϰ����ϰ��ô���⼸���Ҳ��շѵ�Ŷ��",JY.Da);
					AddZIZHI(JY.Da);
				end,
				[2]=function()--����¥
					if GetFlag(10004)==0 and GetFlag(1)-GetFlag(2)>60 then
						Dark();
						say("��ô���������������Ƶģ�Ī����ʲô����������");
						SetS(JY.SubScene,28,32,1,3578*2);
						SetS(JY.SubScene,29,32,1,4223*2);
						SetS(JY.SubScene,29,36,1,4222*2);
						Light();
						say("�ţ����ǣ�");
						MoveSceneTo(29,32);	--�ӽ�:�����
						say("����֣���ֻ�����Ǹ��첻�¡��ز��µĺú��ӣ���ôһ�ᵽ��ã���ƫ�������ɻ䣿",149);
						if JY.Person[0]["����"]==0 then
							say("������֣����ѵ��Ǵ�ʦ�磿��");
						end
						say("�٣���һ���������֮�󣬵���ùʵ��̫�࣬�ɲ��ɵ��Ҳ��š����룬���������һ��Ǻö˶˵ģ�����С��õ���Ҳû������ֻ������������˵�����������͸��������Ͽ�����������Щ��ɥ���������ⲻ�㵹ù����ô���ǵ�ù��",8);
						if JY.Person[0]["����"]==0 then
							say("���������������õ��ĺ��֣���ô��ʦ�־�Ȼ������������������");
						end
						say("�������⵹˵���ǡ�",149);
						say("���֣��Ҳ������˵�����������Ӻ����ɷ򣬺ȾƱ�ȸ�ʹ�죬�����С��ù����գ�������Ȱ�㣬��ֻ������һ������ͽ����˻����ˣ��Ժ��ڽ����ϵ����������ӣ��������Լ�����ȥ�����У��⡰����������������ô��Զ����֮��",8);
						--���Vs�ﲮ��
						if JY.Person[0]["����"]==0 then
							say("����ʦ��һ��һ�����֣����ƺ����������Ǹ�����뿪���ѵ�����õ��ļһ���������ﲮ�⣿���ã���ʦ������׶༪�١���");
							if DrawStrBoxYesNo(-1,-1,"�Ƿ����������",C_WHITE,CC.Fontbig) then
								say("��ʦ�֣�����ô���ڴ˴����ƣ�������ʦ��֪���ˣ���ɾͲ��ˡ�");
								say("�����ʦ�����յ�Сʦ�ܣ�",8);
								say("���ۣ�����֣��벻���⸽���������ǻ�ɽ�ɵ����ڣ�������Ҳ��Ҫ����ĳ�����˰���",149);
								say("�ߣ����ֱ㶯�֣��Ѳ��������û�ɽ����������һ���������ɣ���");
								say("Сʦ��ĪҪ���������",8);
								ModifyWarMap=function()
									SetWarMap(28,32,1,0);
									SetWarMap(29,32,1,0);
									SetWarMap(29,36,1,0);
									SetWarMap(37,35,1,851*2);
								end
								local r=vs(0,35,35,149,29,36,1000);
								--[[SetWarMap(37,35,1,0);
								SetWarMap(28,32,1,3578*2);
								SetWarMap(29,32,1,4223*2);
								SetWarMap(29,36,1,4222*2);]]--
								if r then
									say("�ã��벻����ɽ�ɳ�����������⻹����������С�ӡ������ո�ֻ�Ǻ�����������ˣ����ڣ���Ҫ������ˡ����ҵķ�ɳ��ʯ���ɣ�",149);
									Dark();
									say("�����ÿ�ĵ���......");
									Light();
									say("Сʦ�ܣ�",8);
									say("���ģ��������ˡ����Ǳ������������һ����ѡ�",149);
								else
									say("�ߣ���Ļ�ɽ����Ҳ�㴿���ˣ��ɾ��������Ĵ�ʦ�֣�Ҳ������һ��ء�",149);
								end
							end
						end
						--�ٰٳ�Vs�ﲮ��
						Dark();
						SetS(JY.SubScene,29,34,1,5461*2);
						say("�㡭��������ﲮ����",74);
						Light();
						if JY.Person[0]["����"]==0 then
							say("��������Ҳ�������С��һ��ô��",149);
						else
							say("������",149);
						end
						say("�����������������������������˶���ɱ�����죬��ȴ�������ҡ��ڵĴ���ʴʣ����ǻ�ò��ͷ��ˣ������ұ������е���Ϊ���ֳ�ȥһ����",74);
						if JY.Person[0]["����"]==3 then
							say("����С�ģ�");
						end
						Dark();
						SetS(JY.SubScene,29,34,1,0*2);
						say("����......",74);
						say("���Բ��ѣ�",149);
						if JY.Person[0]["����"]==3 then
							say("����С�ӣ�Ī��Ҳ��̩ɽ�ɵģ�",149);
							say("���ǣ�");
							say("���������ȸղ���С��ǿ��",149);
						end
						Dark();
						SetS(JY.SubScene,31,36,1,5460*2);
						say("�ٳ�ֶ����",68);
						Light();
						say("����������",68);
						local result;
						ModifyWarMap=function()
							SetWarMap(28,32,1,0);
							SetWarMap(29,32,1,0);
							SetWarMap(29,36,1,0);
							SetWarMap(37,35,1,851*2);
							SetWarMap(31,36,1,0*2);
						end
						if JY.Person[0]["����"]==3 then
							say("ʦ�壬����һ���ϣ�");
							result=FIGHT(
										5,1,
										{
											0,	35,35,
											68,31,36,
											-1,35,33,
											-1,35,31,
											-1,36,32,
										},
										{
											149,29,36,
										},
										1000,0
									);
						else
							result=FIGHT(
										1,1,
										{
											68,31,36,
										},
										{
											149,29,36,
										},
										1000,0
									);
						end
						--[[
						SetWarMap(37,35,1,0);
						SetWarMap(28,32,1,3578*2);
						SetWarMap(29,32,1,4223*2);
						SetWarMap(29,36,1,4222*2);]]--
						if result then
							Cls();
							say("�ߣ��벻������̩ɽ�ɣ�Ҳ��������������֮��",149);
							if JY.Person[0]["����"]==3 then
								say("���ȥ����������ȣ���̩ɽ��һ��΢���������ʲô��");
							end
							Dark();
							SetS(JY.SubScene,29,36,1,0);
							if JY.Person[0]["����"]==3 then
								say("�������أ�");
							end
							Light();
							say("���ˣ��������ų�������У�������ܵĹ�������ȷʵ�ǱȲ��ϡ�",68);
							if JY.Person[0]["����"]==3 then
								say("�´�һ��Ҫ�������е�����");
								say("�����ȴ��ٳ�ֶ����ȥ���˰ɡ�",68);
								say("�����ٳ��⺢�ӣ����Ǹ��ú��ӣ�ֻ����������ӣ�����",68);
							end
							say("�ȣ��ȵȡ�",8);
							say("��ɽ����������л̩ɽ�ɵ�ʦ��ʦ��������֮����",8);
							say("�ߣ����ҵ����ո��㲻�ǻ������������ֵ�����",68);
							say("��ʦ���˽��������˳��޵ľ��ӽ�����ô���������ͽ���أ�",68);
							say("......ʦ����ѵ����",8);
							say("ʦ�������������ӵģ�",95);
							say("�ţ����Ǻ�ɽ�ɵ�ʦֶ��",68);
							say("�ǵģ���ɽ���գ��μ�ʦ����",95);
							say("Ϊʲôû����ʦ��ʦ����һ��",68);
							say("ʦ����������ȥ��ɽ���μ���ʦ�����ϴ�ִ�ᣬ����·�ϣ��ұ��ǣ��ǣ��������ˡ�",95);
							say("���ˣ��Ͻ�ȥ����ʦ���ɡ��������Ҳ�����㡣",68);
							say("ʦ����������������",95);
							say("�ߣ�����˵�ˣ������ߣ�",68);
							SetS(JY.SubScene,31,36,1,0);
							ModifyD(29,18,1,-2,2,74,-2,5170,5170,5170,0,-2,-2);
							ModifyD(29,19,1,-2,8,68,-2,5170,5170,5170,0,-2,-2);
							JY.Person[68]["����"]=3;
							JY.Person[74]["����"]=3;
						else
							SetS(JY.SubScene,31,36,1,0);
							Cls();
							say("��ţ�����ϵ�Ҳ������ˣ�",149);
							say("����֣��ҵ��������ѣ�������й��ң�������Ȼ���Ų������Ǿ������㲻�����书�����ߣ�����ȴ����Ϊ�ˣ���˲���ʤ�ܣ����������мܡ��Ը���ţ����ȴ�ֲ�ͬ��",149);
							say("�ߣ��������ۣ��������������",8);
							Dark();
							say("��һ��֮�У��鷳���춼�У�������ģ��Ⱦƣ��Ⱦơ����֣�����һ������������ؿڣ����书��������ʦ�����Ǳ�ܲ��ˡ�",8);
							Light();
							say("�ղ��ҳ���֮ʱ��ȷ�����������飬���Ǳ�����������ɽ���в�ɱ�ҵ����ꡣ",149);
                                                        say("���Ǳ����ˣ���ȴ�ֳ��㲻ɱ֮�顣�������֣��Ҿ���һ������",8);
							if JY.Person[0]["����"]==0 then
								say("��ʦ�֣�����������������ˡ���");
								say("����С��Ҳ�治���ϣ��β�����ʦ��ѧѧ���������������ᣬ�������ˡ�",149);
								DrawStrBoxWaitKey("��Ѩ����",C_WHITE,CC.Fontbig);
							end
							say("���ֺù�����վ�Ŵ��ҵ�ȷ��������֡����������Ŵ����������������������ˡ�",8);
							say("���������������ɲ�֪���˰ɡ�������֮ʱ�����ϵù�������������ʱ�⣬����������ϰ�����������Ŵ����������ֺ�Ϸ��",149);
							say("Ŷ����Ȼ��ˣ����ǲ������Ȼ��Ȼ������������ǵö���һ��������ʤ��δ��֮ʱ����һ����վ�������������䡣",8);
							say("����ʤ��δ��֮ʱ����һ����վ�����������ˡ�",149);
							if JY.Person[0]["����"]==0 then
								say("��ԭ����ˣ�ʦ�����뼤�����ԣ��þȳ��Ǻ�ɽ�ɵ�ʦ�㡣ֻ���⡰���ű��䡱����������ʦ�����������뷨����");
							end
							Dark();
							say("��ô�����������Ŵ����µڶ��Ľ������ҿ�Ҳ��ϡ��ƽ����",149);
							say("��С��û����ߣ�������ù��㣿�����ڣ�������ע��Ҫ����ù��",8);
							Light();
							say("���Ŵ����µڶ������Ŵ����µڼ���",149);
							say("���������֣������ˣ�������ǰ��ô˵����",8);
							say("����Լ�����Ŵ���˭��վ��������ƨ���������ӡ����㡭���㡭���㡭���ߣ���ĳ�޻���˵��Ը�ķ��䣬С��ã����߰ɡ�",149);
							say("��С��ã��㻹����������´������Ҽ����㣬�ұ�һ������ɱ�ˡ�",8);
							Dark();
							SetS(JY.SubScene,29,36,1,0);
							DrawStrBoxWaitKey("�ﲮ���뿪",C_WHITE,CC.Fontbig,1);
							Light();
						end
						say("��ɽ�ɵ�ʦ�ã�������Ӧ�ò��������ˣ���Ͻ�����ʦ��ȥ�ɡ��ո������϶��е���������¡�",8);
						say("�����磬����˵�ˣ�����������Ϊ�˾��ҡ���ѽ�����˵���ô�أ����ȸ���ֹѪ��",95);
						if JY.Person[0]["����"]==0 then
							say("�һ�ûʲô�����Ȱ�����Сʦ�����˰ɡ�",8);
							say("��λ��磬лл�������ȣ���������ֹѪ�ɡ�",95);
							DrawStrBoxWaitKey("����������������"..JY.Person[0]["����"].."��������",C_WHITE,CC.Fontbig);
							say("��ɽ�ɵ���ҩ����Ȼ�����鴫����");
						end
						--�����
						Dark();
						SetS(JY.SubScene,28,34,1,5706*2);
						SetS(JY.SubScene,29,34,1,5706*2);
						SetS(JY.SubScene,30,34,1,5706*2);
						say("����������壬��ύ�����ﲮ�⣬��������������˽ܾ�Ҫ�����е���",31);
						local n=1;
						if JY.Person[0]["����"]==0 then
							say("�����������ְ��࣬�޳�֮��������֮Σ��Ю���屨˽�𣬻�����ʲô�������ɣ�����ֻҪ����һ�����ڣ����Ǿͱ�������ʦ��һ��һ����");
							n=5;
						else
							say("�ߣ�һȺ������ѡ��������������ˣ����뱨֮ǰ����֮�ޣ�ֻ��������������è���򻹲����������",8);
						end
						ModifyWarMap=function()
							SetWarMap(28,32,1,0);
							SetWarMap(29,32,1,0);
							SetWarMap(28,34,1,0);
							SetWarMap(29,34,1,0);
							SetWarMap(30,34,1,0);
							SetWarMap(37,35,1,851*2);
						end
						result=FIGHT(
										n,7,
										{
											8,29,32,
											0,35,35,
											-1,35,33,
											-1,35,31,
											-1,36,32,
										},
										{
											31,28,33,
											37,30,33,
											38,30,31,
											39,28,31,
											40,34,35,
											41,35,33,
											42,35,37,
										},
										1000,0
									);
						--[[SetWarMap(37,35,1,0);
						SetWarMap(28,32,1,3578*2);]]--
						if result then
							SetS(JY.SubScene,28,34,1,0);
							SetS(JY.SubScene,29,34,1,0);
							SetS(JY.SubScene,30,34,1,0);
							SetS(JY.SubScene,29,32,1,4256*2);
							Cls();
							if JY.Person[0]["����"]==1 then
								say("���ˣ����˽���Σ�գ�");
								ModifyWarMap=function()
									SetWarMap(28,32,1,0);
									SetWarMap(29,32,1,0);
									SetWarMap(37,35,1,851*2);
								end
								local rr=vs(0,35,35,8,29,32,1000);
								--SetWarMap(28,32,1,3578*2);
								--SetWarMap(29,32,1,4223*2);
								--SetWarMap(37,35,1,0);
								if rr then
									SetS(JY.SubScene,28,32,1,0);
									SetS(JY.SubScene,29,32,1,0);
									say("���Ǽ���������ȥ���˰ɡ�");
									say("��лʦ�ֳ�����ȣ�",40);
								else
									JY.Status=GAME_END;
								end
							else
								DrawStrBoxWaitKey("�����������˽ܺ�Ҳ������ȥ��",C_WHITE,CC.Fontbig);
								say("�����磡",95);
								say("Ҫ�Ҹ��徲�ĵط������������ˡ�",95);
								Dark();
								SetS(JY.SubScene,28,32,1,0);
								SetS(JY.SubScene,29,32,1,0);
								Light();
								DrawStrBoxWaitKey("���մ���������뿪��",C_WHITE,CC.Fontbig);
							end
						else
							SetS(JY.SubScene,29,32,1,4223*2);
							SetS(JY.SubScene,28,34,1,5706*2);
							SetS(JY.SubScene,29,34,1,5706*2);
							SetS(JY.SubScene,30,34,1,5706*2);
							Cls();
							say("����壬�㻹��Ӳ��",31);
							if JY.Person[0]["����"]==0 then
								say("����⣬��ʦ�ֵ�����Խ��Խ�أ���Ҫ�����ˡ���");
							end
							say("�ٺ٣�����ʦ�ã��ҡ������и������ܣ�˵���������Ǹ����������ھֵı�а������а���ף����ڡ������ڡ���",8);
							Dark();
							say("����ô��",31);
							SetS(JY.SubScene,28,34,1,0);
							SetS(JY.SubScene,29,34,1,0);
							SetS(JY.SubScene,30,34,1,0);
							Light();
							say("��~~",31);
							DrawStrBoxWaitKey("���������˽ܸ�������ʱ����֮����",C_WHITE,CC.Fontbig);
							DrawStrBoxWaitKey("�������˽ܺ������Ҳ������ȥ��",C_WHITE,CC.Fontbig);
							Dark();
							say("�����磡",95);
							DrawStrBoxWaitKey("���ո��������������",C_WHITE,CC.Fontbig);
							SetS(JY.SubScene,29,32,1,4256*2);
							Light();
							say("��ɽ�ɵ���ҩ����Ȼ�����鴫",8);
							say("����ʦ�ã����ȥ����ʦ���ɣ�������ض�Ҫ�����ˡ�",8);
							say("��������������˻�ûȫ�ð���",95);
							say("ȥ�ɣ�������Ѿ��������ˡ�",8);
							say("�ţ��ǣ������磬����~",95);
							if JY.Person[0]["����"]==0 then
								Dark();
								SetS(JY.SubScene,28,32,1,0);
								Light();
								say("��ʦ�֣����������֮�أ����Ǻ�ɽ��ҩҲ�޷�����Ȭ���ɡ����ǻػ�ɽ���˰ɡ�");
								say("���ˣ����������У�������Ҫ�졣",8);
								Dark();
								say("����ʦ�������˸��õ���.....",8);
								SetS(JY.SubScene,29,32,1,0);
								Light();
							else
								Dark();
								SetS(JY.SubScene,28,32,1,0);
								SetS(JY.SubScene,29,32,1,0);
								Light();
							end
						end
						ModifyD(38,10,0,-2,0,0,-2,0,0,0,0,-2,-2);
						SetFlag(10004,2);
					end
				end,
				[100]=function()--����ħ������
					if JY.Person[0]["����"]>=0 then
						say("ԭ����������ﰡ���������ɣ�");
						if vs(0,39,26,JY.Da,38,22,500,0) then
							ModifyD(38,18,0,-2,0,0,-2,0,0,0,0,-2,-2);
							MyQuest[1]=2;
						else
							JY.Status=GAME_END;
						end
					end
				end,
				[11]=function()--
				end,
			}

						--say("")SceneEvent[5]={};
SceneEvent[5]={
				[1]=function()		--�����¼�...���볡���󴥷�
					if JY.Person[0]["����"]==2 and GetFlag(1)-GetFlag(2)>60 and GetFlag(12001)==0 and GetFlag(12005)==0 then
						for i=2,CC.TeamNum do
							if JY.Base["����"..i]>=0 then--���������ˣ��򲻴���
								return true;
							end
						end
						Dark();
						SetS(JY.SubScene,29,19,1,4226*2);
						SetS(JY.SubScene,31,19,1,2635*2);
						Light();
						say("���ף����������������֮��������Ī����ʦ���ڴ˴����ѣ�����ȥ��һ������");
						MoveSceneTo(30,18);
						say("��������������磬�ҽ���ʵ���Ǹ��˰��������Ҷ���֮�����������ڴ����⡶Ц��������֮���ˣ�",50);
						say("������磿��Ц������������");
						say("�ǰ���������Ȼ����ͬ�������ֻ��ѣ��������ڴ���������ֻ�ǡ���",150)
						say("���İɣ�����硣���Ѿ�������ϴ�֣��Ӵ˲��ٹ��ʽ���֮�¡���ʱ��ʲô����а�̶������޹��ˡ�",50);
						say("��Ҳ���д��⡣",150);
						say("����ʦ������˼��Ī�Ǵ��˷����������ˣ��ţ����ˣ���");
						SetS(JY.SubScene,48,12,1,2604*2);
						MoveSceneTo(48,12);
						say("�����˴��ţ�����ɽ�ɵ��ˣ���ɽ�ɵ���Ϊ�λ��ڴˣ��ѵ������롭���ף����أ���");
						Dark();
						JY.SubSceneX=0;
						JY.SubSceneY=0;
						SetS(JY.SubScene,29,19,1,0);
						SetS(JY.SubScene,31,19,1,0);
						SetS(JY.SubScene,48,12,1,0);
						SetS(JY.SubScene,48,32,1,4228*2);
						say("�������Ѱ�ң�",113);
						Light();
						say("��֪��������ɽ�ɵġ���");
						say("���·ѱ�",113);
						say("����Ȼ����������ɽ���Ӳμ���ɽ�ɷ�ʦ�塣��֪��ʦ�����ǡ���");
						say("���˲�˵������������Ҳ�����ˡ������㣬���֪������˭��",113);
						say("���Ӳ�֪��");
						say("���˱���ħ��ʮ����֮һ����������ħͷ��",113);
						say("����������Ȼ��ħ�̣���");
						say("�ߣ��������Ǵ���ȥ���ؽ������������ɵĵ�һ����š�����������ʦ�����жԲߣ�����ǰ��������£����Ը���ң�",113);
						say("�����������жԲߣ������֪�������£���Ӧ��Ӧ�ð����أ���");
						if DrawStrBoxYesNo(-1,-1,"�Ƿ�����ѱ�",C_WHITE,CC.Fontbig) then
							say("��˳��ţ���Ȼ���ܴ���ȥ��ֻ�ǵ����书��΢����֪��������£�������ʦ��ָ�㡣");
							say("�ã����һ�ȥ��װ��ʲô����֪������ʱ��һ�����Ի�������Ҫ��ȥ����",113);
							Dark();
							SetS(JY.SubScene,48,32,1,0);
							Light();
							SetFlag(12001,2);
						else
							say("��л��ʦ�����⡣ֻ��ʦ���վ������Һ�ɽ֮�ˣ������һ���������ʦ�����������ᡣ");
							say("�ߣ���ʶ�ô�������ڵģ�",113);
							Dark();
							say("��˵����ô˵����ֻ������ʦ����������");
							SetS(JY.SubScene,48,32,1,2615*2);
							Light();
							say("����ʦ�������㡭���㶼�����ˣ�");
							say("�š�",49);
							say("����ʦ����������ʵ���ǲ�֪����");
							say("�㣬�ܺá��㣬ʲô����֪�����ң�û������",49);
							Dark();
							SetS(JY.SubScene,48,32,1,0);
							Light();
							say("������ʦ����Ҫ��װ����֪�����£������������Ѿ������뷨�˰���");
							SetFlag(12001,1);
						end
					elseif GetFlag(12005)==2 and GetFlag(12006)==0 then
						--JY.Person[0]["����"]=0;
						Dark();
							SetS(JY.SubScene,29,19,1,4226*2);
							SetS(JY.SubScene,31,19,1,2635*2);
							SetS(JY.SubScene,30,23,1,5002*2);
							SetS(JY.SubScene,30,21,1,4254*2);
						Light();
						MoveSceneTo(30,18);
						say("����壬��˾ٿ��������ŵ���˼��",113);
						say("���´˾��������Լ�����˼����ɽ���Ѿ�������ʦ�����ţ�Ϊ�λ���Ҫ����ʦ���������أ�",8);
						say("�����繴��ħ�̣�����Ϊ������������ͽ����ʦ�ָ��������ᣬ�����������ڸġ�����壬�ҷ�Ȱ�����һ�㡣��Ȼ�����⽣��������Ҫ����һ���ˡ�",113);
						script_say("����壺����������������һ����������һ����С�ģ�˵�������ܲ�һ���ô��������������ء�");
						script_say("�ѱ�������");
						local menu=	{
												{"����֣��������㣡",1},
												{"�����繴��ħ�̣�������ȡ",1},
												{"����壬������Ҫ������",0},
												{"��ʦ�壬�������㣡",0},
												{"�������",1},
											};
						--local menu={"����֣��������㣡","�����繴��ħ�̣�������ȡ","�������"};
						if JY.Person[0]["����"]==0 then
							menu[1][1]="��ʦ�֣��������㣡";
							--menu[1][2]=0;
						elseif JY.Person[0]["����"]==1 then
							menu[1][2]=0;
							menu[2][2]=0;
							menu[3][2]=1;
						elseif JY.Person[0]["����"]==2 then
							menu[2][2]=0;
						elseif JY.Person[0]["����"]==5 then
							menu[1][2]=0;
							menu[2][2]=0;
							menu[4][2]=1;
						end
						local sel=GenSelection(menu);
						if sel<5 then
							if sel==2 then
								script_say("���ǣ����������繴��ħ��������ʵ���������ȴִ��ά�������磬���治��ȡ����");
							elseif sel==3 then
								script_say("���ǣ���̤����Ь���ٴ�����ȫ���ѹ�������壬������Ҫ��������");
							end
							JY.SubSceneX,JY.SubSceneY=0,0;
							JY.EnableKeyboard=false;
							JY.EnableMouse=false;
							walkto(31,22);
							walk(2);
							JY.EnableKeyboard=true;
							JY.EnableMouse=true;
						else
							script_say("���ǣ�����ʧ���꼰���㣬�һ��Ǽ����������ɡ�");
							PlayWavAtk(9);
							script_say("���ǣ�������");
							--Dark();
							ScreenFlash(C_WHITE);
							lib.Delay(400);
							DrawStrBoxWaitKey(JY.Person[0]["����"].."��֪����ʲô�����",C_WHITE,CC.Fontbig,1);
							lib.Delay(400);
							--
							JY.SubSceneX,JY.SubSceneY=0,0;
							SetS(JY.SubScene,29,19,1,0);
							SetS(JY.SubScene,31,19,1,0);
							SetS(JY.SubScene,30,23,1,0);
							SetS(JY.SubScene,30,21,1,0);
							Light();
							script_say("���ǣ�������ô���£�");
							SetFlag(12006,2);
							return
							--����
						end
						local n1,n2=1,1;
						if sel==1 then
							SetFlag(12007,1);
							if JY.Person[0]["����"]==0 then
								script_say("���ǣ���ʦ�֣��������㣡");
							else
								script_say("���ǣ�����֣�����ɽ�Դ���С���ò�Ҫ�����������㣡");
							end
							n1=2;
						elseif sel==2 then
							SetFlag(12007,2);
							script_say("���ǣ�����֣�������ô�����������繴��ħ�̳���������ʵ������ִ�Բ��򰡡�");
							script_say("����壺��л���Ȱ�棬ֻ�������ʵ�ڿ�������ɽ�������ŵ���Ϊ���ʶ����֣���Ը��������ɱ¾��");
							if JY.Person[0]["����"]==0 then
								script_say("���ǣ���˿����нύħ��֮�ӣ�ʦ����Ȼ�����������");
								script_say("����壺ʦ��Ϊ��֮�ģ�Ϊ����Ϊ�ж���ֻ��ƽ��ʦ�������̵���Ϊ��������ţ��Գ�����С�������ŵ�������ˣ���������ʦ����ֶ���ʳ�����أ�");
								script_say("���ǣ���ʦ�ֺ������ˣ�ֻ����ȴ....");
								script_say("���ǣ����ˣ��͵��Ҵ�δ�������ˡ�");
								script_say("�ѱ���С�ӵ���ͦʶʱ��İ���");
								--�¼�����
								JY.EnableKeyboard=false;
								JY.EnableMouse=false;
								walkto(57,32);
								walk(1);
								JY.EnableKeyboard=true;
								JY.EnableMouse=true;
								SetS(5,29,19,1,0);
								SetS(5,31,19,1,0);
								SetS(5,30,23,1,0);
								SetS(5,30,21,1,0);
								SetFlag(12006,2);
								return;
							else
								script_say("���ǣ��ǲ��罫�Ƕ��˽������£���Σ�");
								script_say("����壺��л������⡣ֻ�Ǵ��ɷ��Գ����У��Ҽ�Ȼ�ų�����Ҫ�������ˣ��Ե�˵��������");
								script_say("���ǣ�������ˣ������ˡ�");
								n2=2;
							end
						elseif sel==3 then
							SetFlag(12007,2);
							script_say("���ǣ������ӵģ����������֣�������͸���ʦ�ֳ����ɣ�");
							n2=2;
						elseif sel==4 then
							SetFlag(12007,2);
							script_say("���ǣ�ʦ�壬����һ���ϡ�");
							script_say("�ѱ�����ʦ���ڣ�����Ҫ���æ������һ�߿����ˡ�");
						end
						ModifyWarMap=function()
							SetWarMap(29,19,1,0);
							SetWarMap(31,19,1,0);
							SetWarMap(30,23,1,0);
							SetWarMap(30,21,1,0);
							SetWarMap(49,32,1,1492*2);
						end
--������+�����VS����+�ѱ���Ӯ�ް���
						local r1=FIGHT(
										n1,n2,
										{
											8,31,19,
											0,33,23,
										},
										{
											113,29,25,
											0,33,23,
										},
										0,0
									);
						if true then
							script_say("�ѱ�����壬�����ɣ�");
							if true then
								if JY.Person[0]["����"]==1 then
									script_say("���ǣ�����ӣ�����Ͱ����������ɣ�");
								elseif sel==2 then
									script_say("���ǣ���������������ǻ�ɽ���ӣ���Ȼһʱû�������Ƿǣ������վ�û�����ɴ����������һ���ɡ�");
									script_say("�ѱ򣺸���֮�ʣ�������");
								end
							end
						else
							if sel==2 then
								script_say("���ǣ��ý����������������硣����֮�£������²�����������������ˡ���ǡ�");
								return;
							else
								script_say("�ѱ򣺹�Ȼ�м����ӣ��Ǿ������Ǽ�ʶһ�´������ֵ������ɣ�");
							end
						end
--��ͻȻ����һ���������
						Dark();
							SetS(5,29,22,1,2615*2);
							script_say("�ѱ�����ҹ�ꣿ��Īʦ�֣������һ����");
						Light();
--��Ī����֣�
						script_say("Ī�󣺷�ʦ�֣���ʦ�ְ��ã�");
						script_say("�ѱ���ʦ��һ�ж��á�Īʦ�֣��������ɽ�������˹���ħ�̣���˵��ɱ���ǲ���ɱ��");
						script_say("Ī����Ȼ������ɱ��");
						ModifyWarMap=function()
							SetWarMap(29,19,1,0);
							SetWarMap(31,19,1,0);
							SetWarMap(30,23,1,0);
							SetWarMap(30,21,1,0);
							SetWarMap(29,22,1,0);
							SetWarMap(49,32,1,1492*2);
						end
						local n3=1;
						if JY.Person[0]["����"]~=5 then
							JY.Person[49]["����"]=JY.Person[49]["����"]+30;
							JY.Person[49]["��"]=JY.Person[49]["��"]+30;
						else
							JY.Person[49]["����"]=JY.Person[49]["����"]-30;
							JY.Person[49]["��"]=JY.Person[49]["��"]-30;
							n3=2;
						end
						local rr=FIGHT(
										n3,1,
										{
											113,30,23,
											0,31,22,
										},
										{
											49,29,22,
										},
										0,0,4
									);--vs(113,30,23,49,29,22,0);
						if JY.Person[0]["����"]~=5 then
							JY.Person[49]["����"]=JY.Person[49]["����"]-30;
							JY.Person[49]["��"]=JY.Person[49]["��"]-30;
						else
							JY.Person[49]["����"]=JY.Person[49]["����"]+30;
							JY.Person[49]["��"]=JY.Person[49]["��"]+30;
						end
--��Ī��VS�ѱ򣬷ѱ������
						if rr then
							script_say("���ǣ����ú�ɽ������Ҳ�����ǰ���͵Ϯ��С�ˣ�");
							script_say("�ѱ���ͺ�������һ����������ɡ�");
							Dark();
								script_say("Ī�󣺡����ߣ�");
								SetS(5,29,22,1,0);
								SetS(5,30,21,1,0);
							Light();
							script_say("���ǣ����ˣ���");
							script_say("�ѱ��벻��Ī���Ȼû�а��Լ���ʦ�ܴ��ߣ��������ǻ�ɽ�ɵ�С�Ӵ����ˡ�");
							script_say("���ǣ���С���书ƽƽ�����˾����ˣ�������Σ�");
							script_say("�ѱ������磬�ҿ�˭���ȵ����㣡");
							ScreenFlash(C_RED);
							script_say("�ѱ����ǻ���ɽ�ɡ�");
							SetS(5,31,19,1,0);
							SetS(5,29,19,1,0);
							ModifyD(27,20,1,-2,8,113,0,8456,8456,8456,-2,-2,-2);
							SetFlag(12006,1)
							return;
						elseif JY.Person[0]["����"]==5 then
							JY.Status=GAME_END;
							return;
						end
						local sel2
						if JY.Person[0]["����"]~=1 then
							script_say("���ǣ���Ī������Ҫɱ�ѱ���Ҫ��Ҫ�����أ���");
							menu={{"�ѱ�Ͼ���������������"},{"��˶��ˣ���Ȼ����"},};
--���Ƿ���� ��/��
--���ǡ�
							sel2=GenSelection(menu);
						else
							sel2=2
						end
						if sel2==1 then
							script_say("���ǣ�������");
							script_say("���ǣ�������Ϊ��Ϊ�������ݣ����Ծ��������������ˣ�����ʹ�ɱ�������¡���");
							script_say("Ī�󣺡����ߣ�����");
							script_say("�ѱ򣺶�лĪʦ�ֽ������飬��ǡ�");
						else
--���ѱ���ʧ��
							SetS(5,30,23,1,0);
							--SetS(JY.SubScene,28,15,1,0);
							Cls();
							lib.FillColor(0,0,CC.ScreenW,CC.ScreenH,C_RED,128);
							ShowScreen();
							lib.Delay(80);
							lib.ShowSlow(50,1);
							Light();
							if JY.Person[0]["����"]~=1 then
								script_say("����壺��лĪʦ������֮����");
								script_say("Ī�������������ܲ���");
								script_say("���ǣ������Ӧ������Ǻã�");
								script_say("Ī����û�������������Ҳ��֪��������ʲô����ס�ˡ�");
							else
								script_say("����壺��лĪʦ������֮������ô�����С�ӣ����ڻ�Ҫȡ���������ɣ�");
								script_say("���ǣ���Ī�����ˣ���Ȼɱ�����á�ֻ�����뿪�����һ��ᣩ�ߣ�����ӣ���������");
								JY.EnableKeyboard=false;
								JY.EnableMouse=false;
								walkto(57,32);
								walk(1);
								JY.EnableKeyboard=true;
								JY.EnableMouse=true;
								SetS(5,29,19,1,0);
								SetS(5,31,19,1,0);
								SetS(5,30,23,1,0);
								SetS(5,30,21,1,0);
								return
							end
						end
						Dark();
							SetS(5,30,23,1,0);
							SetS(5,29,22,1,0);
						Light();
--��Ī����ʧ��
						script_say("����壺Īʦ����");
						script_say("�����磺���ú��ˣ�ʦ�����Ѿ����ˡ�");
						script_say("����ƽ����������ʦ�ֵܲ��ϣ�����һ������ʦ�������Ǻ����������ʦ�ܵİ���");
						script_say("�����磺ƽ��Ҳֻ��������󣬶�ʦ���������Դǣ����ǽ�Ϊ��Զ����ʵ�������Ժ�ɽ�������ڰ�����");
						script_say("���ǣ���������ô˵����������һ������ϴ�֣�һ��������ħ�̡��ȷǽ������ˣ�Ϊ�λ�Ҫ���⽭��֮���أ�");
						script_say("�����磺�Ǽ��Ǽ�����ĳ��һ�������������������ཻһ�¡��������˵Ŀ��������Һθɣ�");
						script_say("���󣺶�л��λС����ȡ���������Ϊ����ֻ�н��Ҷ��˺������ɵ������������ǡ�ϣ���������ҵ����ʵ��������ࡣ���ѣ������߰ɡ�");
						script_say("�����磺�š�������һ������֮�أ��ٲ��������ˡ�");
						--script_say("�����̣���λ���磬�����Ǻ��ˡ�������лл��λ�������үү��үү���ҷ����߰ɡ�");
						Dark();
							SetS(5,29,19,1,0);
							SetS(5,31,19,1,0);
						Light();
--��������ʧ��
						if JY.Person[0]["����"]==0 then
							script_say("����壺ʦ�ܣ�����Ҳȥ��ʦ���ɡ�");
						elseif sel==1 then--if JY.Person[0]["����"]==3 then
							script_say("����壺��λ�ֵܣ�������л�����֮����");
							script_say("���ǣ�����������ĳ�����ηǿȨ�����˺����������Ҿ���֮�Բ���̸��ʵ���ǲ����������书��΢��������Ī���������֣����������˰��ˣ���������ʲ���ˡ���Ҫ��ȥ�ˣ��´��л���Ļ���������Ⱦơ�");
							script_say("����壺�ã�һ��Ϊ�����ҵ�����ľƣ�");
							script_say("���ǣ�������ڡ�");
						elseif sel==2 then
							script_say("����壺�ոշѱ�Ҫɱ�ң���������裬������������ˡ�");
							script_say("���ǣ�ֻ���벻���ѱ���ˣ���˱��ɡ�");
							script_say("����壺������Īʦ����ȡ��һ�����Ҫ�ػ�ɽ���ʹ˱����");
							script_say("���ǣ�������ڡ�");
						end
						Dark();
							SetS(5,30,21,1,0);
						Light();
						SetFlag(12006,2);
					else
						return true;
					end
				end,
			}
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

						--say("")SceneEvent[57]={};--��ɽ�ɸ��¼�
SceneEvent[57]={
				[1]=function()--����
					--��ʱ�����ǻ�ɽ����
					if JY.Person[0]["����"]~=0 then	--�ǻ�ɽ����
						local d=JY.Base["�˷���"];
						if d==2 then
							say("������û�ɽ����֪�кι�ɣ�",20);
						else
							say("�������ߣ�ˡ��Զ�͡�",20);
						end
						local menu={
												{"����",nil,1},
												{"��ʦ",nil,1},
												{"�뿪",nil,1},
												{"����",nil,0},
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
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							say("�һ�ɽ��ɫ�����������������С�ʯ����������̨��֮��������������Ͼ���������Ĵ����ߡ�",20);
							Dark();
							JY.Base["��X1"]=45;
							Light();
						elseif r==2 then
							say("�������ʦ��ͨ����С�ֵ�����������",20);
							Dark();
							JY.Base["��X1"]=22;
							JY.Base["��Y1"]=28;
							JY.Base["�˷���"]=2;
							 JY.MyPic=GetMyPic();
							Light();
							--��ʱ�����ǰ�ʦ����
							if true then
								say("�һ�ɽ�Ź漫�ϣ�����Υ������������ش�������������ն���⡣���Ը�⣿",1);
								if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ���뻪ɽ�ɣ�",C_WHITE,CC.Fontbig) then
									say("ʦ�����ϣ�����ͽ��һ�ݣ�");
									say("��ͽ������Ȱ����һ�ɽ�ɣ�����������Ź棬�������壬�ú÷����һ�ɽ���ŷ硣����������ѧ����ʲô���ʣ�����������ʦ�����������̡�",1);
									say("�ǣ�");
									JY.Person[0]["����"]=0;
									JY.Shop[0]["����ʱ��"]=GetFlag(1);
									DrawStrBoxWaitKey(JY.Person[0]["����"].."����ϻ�ɽ��",C_WHITE,CC.Fontbig);
									JY.Person[0]["���"]="��ɽ����";
									GetItem(0,1);
								else
									say("��Ȼ��ˣ��Ǵ��¾ʹ����հɡ�",1);
								end
							else
								say("�����ֽ������࣬Ҳ������һ�ɽ��ǽ��",1);
							end
						elseif r==3 then
							say("�´��пգ�����������ɽ������",20);
							Dark();
							JY.Base["��X1"]=47;
							Light();
						elseif r==4 then
							if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ������ɽ�ɣ�",C_WHITE,CC.Fontbig) then
								say("����������ʲô�ط�����Ҳ�������ۺú����ƣ�",20);
								--Fight
								SetFlag(1000,1);
							else
								say("������ɫ����ã�û�°ɣ�",20);
							end
						elseif r==5 then
							say("���¼�Ȼ���£��벻Ҫ�ڴ˶�����",20);
						end
					else
						local d=JY.Base["�˷���"];
						if JY.Da>0 then
							say("ʦ�ܣ���ʲô����",JY.Da);
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
								--say("ʦ�����Ź�����ˣ��������챻��ץסʹ�",JY.Da);
								RandomEvent(JY.Da);
							elseif r==2 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
								say("�ð������������档",JY.Da);
								ModifyWarMap=function()
									SetWarMap(47,28,1,1840);
									SetWarMap(47,29,1,1840);
									SetWarMap(47,30,1,1840);
									SetWarMap(47,31,1,1840);
									SetWarMap(26,28,1,2274);
									SetWarMap(26,29,1,2274);
									SetWarMap(26,30,1,2274);
									SetWarMap(36,19,1,2268);
									SetWarMap(37,19,1,2268);
									SetWarMap(38,19,1,2268);
								end
								local result=vs(0,38,38,JY.Da,33,35,300);
								--[[SetWarMap(47,28,1,1842);
								SetWarMap(47,29,1,0);
								SetWarMap(47,30,1,0);
								SetWarMap(47,31,1,1838);
								SetWarMap(26,28,1,2276);
								SetWarMap(26,29,1,0);
								SetWarMap(26,30,1,2272);
								SetWarMap(36,19,1,2266);
								SetWarMap(37,19,1,0);
								SetWarMap(38,19,1,2270);]]--
								Cls();
								ShowScreen();
								if result then
									say("�벻��ʦ������û���գ��书������˵ã����������硣",JY.Da);
								else
									say("ʦ�����⼸��Ӧ�������㡭����ȥ�������������´����д��д衣",JY.Da);
								end
								DayPass(1,0);
							elseif r==3 then
								PersonStatus(JY.Da);
							elseif r==4 then
								--say("��лʦ�����⣬��ϧ����ְ�����ڣ��������밡��",JY.Da);
								E_guarding(JY.Da);
							elseif r==5 then
								say("ʦ�������",JY.Da);
								Dark();
								JY.Base["��X1"]=45;
								Light();
							elseif r==6 then
								say("�����ն�ʦ�ܶ��С�ġ�",JY.Da);
								Dark();
								JY.Base["��X1"]=47;
								Light();
							elseif r==7 then
								say("ʦ���������£�������������д����书Ҳ�ð���",JY.Da);
							end
						else
							say("ʦ���롣",20);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							Light();
						end
					end
				end,
				[2]=function()--����
					if JY.Person[0]["����"]~=0 then	--�ǻ�ɽ����
						say("�˴����һ�ɽ�����ã�����������£���ȥ�������档",JY.Da);
					else
						if GetFlag(12005)==0 and JY.Person[0]["����"]>30 and GetFlag(10004)~=0 and GetFlag(16001)==2 then
							SetFlag(12005,1);
							say("��ɽ�������⼸�վ�Ҫ����ϴ���˳������������������Ҳȥ�μӹ���ɡ�",JY.Da);
							say("�ǣ�");
							return;
						end
						say("�μ�ʦ����");
						say("ͽ�����£�",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							--say("���˽����һ�ɽ�������ڣ��ⲻ֪�һ�ɽ�书����������������Ϊ������Ϊ�Ρ��������书���в�����һζ̰ͼ��������������ħ���������ѻ�ͷ�ˡ�",1);
							RandomEvent(JY.Da);
						elseif r==2 then
							if JY.Db==1 or JY.Person[0]["�ȼ�"]>10 then
								local kflist={
													{1,10},
													{5,10,1},
													{10,10},
													{11,10,1},
													{13,10},
													{18,10,2},
													{15,10},
													{16,10,1},
													--{85,10},
													--{86,10},
													};
								LearnKF(0,JY.Da,kflist);
							else
								say("��Ļ���������㣬��Ҫ�ø���Զ����������ʦ����̰ɡ�",JY.Da);
							end
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<5 then
								say("����书��������ϰ��ȥ����ʦ�����д�ɡ�",JY.Da);
							else
								say("�ã�ֻ�ܳ��аɣ���Ϊʦ��������书���޽�����",JY.Da);
								ModifyWarMap=function()
									SetWarMap(26,28,1,2274);
									SetWarMap(26,29,1,2274);
									SetWarMap(26,30,1,2274);
									SetWarMap(21,24,1,2268);
									SetWarMap(22,24,1,2268);
									SetWarMap(23,24,1,2268);
									SetWarMap(21,34,1,1708);
									SetWarMap(22,34,1,1708);
									SetWarMap(23,34,1,1708);
								end
								local result=vs(0,24,28,1,21,28,2000);
								--[[SetWarMap(26,28,1,2276);
								SetWarMap(26,29,1,0);
								SetWarMap(26,30,1,2272);
								SetWarMap(21,24,1,2266);
								SetWarMap(22,24,1,0);
								SetWarMap(23,24,1,2270);
								SetWarMap(21,34,1,1710);
								SetWarMap(22,34,1,0);
								SetWarMap(23,34,1,1712);]]--
								Cls();
								ShowScreen();
								if result then
									say("�⼸��ʹ�ò������н����������ǵ�Ҫ�佾���꣬����Ŭ����",JY.Da);
								else
									say("�ú�Ŭ������Ҫ�����һ�ɽ������",JY.Da);
								end
								--SetFlag(1,GetFlag(1)+1);
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("û�¾�ȥ�ú���������Ҫ�Ĵ��й䡣��֪��׳��Ŭ�����ϴ�ͽ�˱���",JY.Da);
						end
					end
				end,
				[3]=function()--��ֹ��������
					if JY.Person[0]["�Ա�"]~=1 then
						if JY.Person[0]["����"]~=0 then	--�ǻ�ɽ����
							say("�����������ŷ���լ�����������Ů������һ��ǲ�Ҫ�Ҵ��ȽϺá�");
							walkto_old(0,-1);
						else
							if GetFlag(10003)==2 then
								return true
							elseif  GetFlag(10003)~=1 then
								say("������ʦ���ס����լ���Ҵ��ᱻʦ�������ģ����ǸϽ��߱ȽϺá�");
								walkto_old(0,-1);
							else
								say("������ʦ���ס����լ�ɡ�");
								SetFlag(10003,2)
							end
						end
					end
				end,
				[4]=function()--���⣬���䳡
					--Menpaibiwu(2)
					if JY.Person[0]["����"]~=0 then	--�ǻ�ɽ����
						say("��ѧ֮�������ڼ�ֲ�и�Ķ�����",20);
					else
						say("���������䳡��ʦ��Ҫһ��������",20);
						E_training(20);
					end
				end,
				[5]=function()--����
					if JY.Person[0]["����"]~=0 then	--�ǻ�ɽ����
						say("��ӭ�������һ�ɽ���͡�",20);
					elseif JY.Da>0 then
						say("ʦ�����Ź�����ˣ��������챻��ץסʹ�",JY.Da);
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
								SetWarMap(47,28,1,1840);
								SetWarMap(47,29,1,1840);
								SetWarMap(47,30,1,1840);
								SetWarMap(47,31,1,1840);
								SetWarMap(26,28,1,2274);
								SetWarMap(26,29,1,2274);
								SetWarMap(26,30,1,2274);
								SetWarMap(36,19,1,2268);
								SetWarMap(37,19,1,2268);
								SetWarMap(38,19,1,2268);
							end
								local result=vs(0,38,38,JY.Da,33,35,500);
								--[[SetWarMap(47,28,1,1842);
								SetWarMap(47,29,1,0);
								SetWarMap(47,30,1,0);
								SetWarMap(47,31,1,1838);
								SetWarMap(26,28,1,2276);
								SetWarMap(26,29,1,0);
								SetWarMap(26,30,1,2272);
								SetWarMap(36,19,1,2266);
								SetWarMap(37,19,1,0);
								SetWarMap(38,19,1,2270);]]--
							Cls();
							ShowScreen();
							if result then
								say("�벻��ʦ������û���գ��书��������˵ã����������硣",JY.Da);
							else
								say("ʦ�����⼸��Ӧ�������㡭����ȥ�������������´����д��д衣",JY.Da);
							end
							--SetFlag(1,GetFlag(1)+1);
							DayPass(1);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("ʦ���������£�������������д����书Ҳ�ð���",JY.Da);
						end
					else
						say("ȭ�����֣����黪ɽ������仰����˵������ȭ����Ϊ�˵ã���Ҫ��˵�����µ�һ�Ľ������Ǿͷ��һ�ɽĪ���ˡ�",20);
					end
				end,
				[6]=function()--����
					if JY.Person[0]["����"]~=0 then	--�ǻ�ɽ����
						say("�����ǳ�����ûʲô�ÿ��ġ�",20);
					elseif JY.Da>0 then
						if GetFlag(10005)==1 then
							if GetFlag(10006)==1 then
								if GetFlag(1)-lib.GetD(JY.SubScene,JY.CurrentD,4)<7 then
									say("�Ͻ�����ʦ����ȥ�ɡ�",JY.Da);
								else
									say("����ô���ˣ�����ô��������ʦ���ͷ���",JY.Da);
								end
							elseif GetFlag(1)-lib.GetD(JY.SubScene,JY.CurrentD,4)>GetFlag(10006) then
								say("����ʦ�ֵķ����Ѿ������ˣ����æ����ȥ�ɣ�",JY.Da);
								lib.SetD(JY.SubScene,JY.CurrentD,4,GetFlag(1));
								if DrawStrBoxYesNo(-1,-1,"�Ƿ���ܣ�",C_WHITE,CC.Fontbig) then
									say("�ã��ѷ��˸��Ұɡ�");
									SetFlag(10006,1);
									return;
								else
									say("�һ���������");
									say("�����������˰ɡ�",JY.Da);
									SetFlag(10006,7);
								end
							end
						end
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
						say("���վ�������Һò��ã���ʦ�����������㡣",20);
					end
				end,
				[7]=function()--��ֹ�����ɽ
					say("������ͨ����ɽ��ɽ��·��ɽ·��᫣����ǲ�Ҫ��ȥ�ȽϺá�",20);
					if GetFlag(10005)==0 then
						return;
					end
					if JY.Person[0]["����"]==0 then	--��ɽ����
						local menu={
												{"����",nil,0},
												{"����",nil,1},
												{"�д�",nil,0},
												{"״̬",nil,0},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==2 then
							if GetFlag(10006)==1 then
								say("����ȥ����ʦ���ͷ��˵ġ�");
								say("ɽ·��᫣���С�ġ�",20);
							else
								say("ɽ·��᫣���С�ġ�",20);
							end
							Dark();
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[JY.Base["�˷���"]+1]*2;
							Light();
						end
					end
				end,
				[8]=function()--ѧ��
					if JY.Person[0]["����"]~=0 then	--�ǻ�ɽ����
						say("������Ҫ�����һ�ɽ����",20);
						say("��ֻ�������תת��");
					elseif JY.Db==0 then
						say("�����ʦ�����յĵ�����",JY.Da);
						say("���ǣ�ʦ����������ʦ����ѧ�䡣");
						say("�ã����ȴ���һ�׻�ɽ�����书�ɡ�",JY.Da);
						Dark();
						Light();
						local add,str=AddPersonAttrib(0,"��������",500);
						DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
						while JY.Person[0]["�⹦"..1]==0 do
							local kflist={
												{1,6},
												{9,6},
												};
							LearnKF(0,JY.Da,kflist);
						end
						say("��лʦ��ָ�㡣");
						say("��ֻ�����Ź�����ѣ��������ı��»�Ҫ�����Լ�Ŭ����",JY.Da);
						lib.SetD(JY.SubScene,22,4,1);
						--JY.Person[0]["����"]=500;
						--JY.Person[0]["�������ֵ"]=500;
						--JY.Person[0]["����Max"]=500;
						--JY.Person[0]["����"]=500;
						--JY.Person[0]["�������ֵ"]=500;
						--JY.Person[0]["����Max"]=500;
						--JY.Person[0]["����"]=100;
						--JY.Person[0]["����"]=100;
					elseif JY.Da>0 then
						say("ʦ������ѧ�����",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							--say("�����ĵ�ʱ���㻹����ȥ���䳡�����ء�",JY.Da);
							RandomEvent(JY.Da);
						elseif r==2 then
							local kflist={
												{1,6},
												{9,10},
												{10,6},
												{13,6},
												{15,6},
												};
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							say("�ð������������档",JY.Da);
							ModifyWarMap=function()
								SetWarMap(26,28,1,2274);
								SetWarMap(26,29,1,2274);
								SetWarMap(26,30,1,2274);
								SetWarMap(21,24,1,2268);
								SetWarMap(22,24,1,2268);
								SetWarMap(23,24,1,2268);
								SetWarMap(21,34,1,1708);
								SetWarMap(22,34,1,1708);
								SetWarMap(23,34,1,1708);
							end
								local result=vs(0,24,28,JY.Da,21,28,800);
								--[[SetWarMap(26,28,1,2276);
								SetWarMap(26,29,1,0);
								SetWarMap(26,30,1,2272);
								SetWarMap(21,24,1,2266);
								SetWarMap(22,24,1,0);
								SetWarMap(23,24,1,2270);
								SetWarMap(21,34,1,1710);
								SetWarMap(22,34,1,0);
								SetWarMap(23,34,1,1712);]]--
							Cls();
							ShowScreen();
							if result then
								if JY.Db==1 then
									say("ʦ����Ļ��������Ѿ���һ������ҿ�����ȥ��ʦ����̸�������书�ˡ�",JY.Da);
									lib.SetD(JY.SubScene,22,4,2);
									lib.SetD(JY.SubScene,1,4,1);
								else
									say("�벻��ʦ������û���գ��书��������˵á�",JY.Da);
								end
							else
								say("ʦ�����⼸��Ӧ�������㡭����ȥ�������������´����д��д衣",JY.Da);
							end
							--SetFlag(1,GetFlag(1)+1);
							DayPass(1);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("ʦ������û�¾�ȥ�����ɣ���ʦ���������й���Ҫ���ˡ�",JY.Da);
						end
					else
						say("������仰��˵����Ϸ����϶��������⣬���Ŀ��ܾ������޸��ˡ�",20);
					end
				end,
				[9]=function()--�������ſ�
					if JY.Person[0]["����"]~=0 then	--�ǻ�ɽ����
						say("���˻�ɽ�����ã����������Ҫ�Ҽ�ʦ��������ɡ�",20);
					elseif JY.Da>0 then
						say("�˴����һ�ɽ�����ã�ʦ���������£��벻Ҫ�ڴ˶�����",JY.Da);
						local menu={
												{"����",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
						if r==1 then
							--say("ʦ���������棬���ǲ�Ҫ�����˰�",JY.Da);
							RandomEvent(JY.Da);
						elseif r==2 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
								say("�ð������������档",JY.Da);
								ModifyWarMap=function()
									SetWarMap(47,28,1,1840);
									SetWarMap(47,29,1,1840);
									SetWarMap(47,30,1,1840);
									SetWarMap(47,31,1,1840);
									SetWarMap(26,28,1,2274);
									SetWarMap(26,29,1,2274);
									SetWarMap(26,30,1,2274);
									SetWarMap(36,19,1,2268);
									SetWarMap(37,19,1,2268);
									SetWarMap(38,19,1,2268);
								end
								local result=vs(0,38,38,JY.Da,33,35,300);
								--[[SetWarMap(47,28,1,1842);
								SetWarMap(47,29,1,0);
								SetWarMap(47,30,1,0);
								SetWarMap(47,31,1,1838);
								SetWarMap(26,28,1,2276);
								SetWarMap(26,29,1,0);
								SetWarMap(26,30,1,2272);
								SetWarMap(36,19,1,2266);
								SetWarMap(37,19,1,0);
								SetWarMap(38,19,1,2270);]]--
							Cls();
							ShowScreen();
							if result then
								say("�벻��ʦ������û���գ��书��������˵á�",JY.Da);
							else
								say("ʦ�����⼸��Ӧ�������㡭����ȥ�������������´����д��д衣",JY.Da);
							end
							--SetFlag(1,GetFlag(1)+1);
							DayPass(1);
						elseif r==3 then
							PersonStatus(JY.Da);
						elseif r==4 then
						end
					else
						say("�������һ�ɽ�����ã�֮����ȡ�����֣�����Ϊ�һ�ɽ��ѧ�����������Ǹ�������ѧ��������������������",20);
					end
				end,
				[10]=function()--��Ϣ
					if JY.Person[0]["����"]==0 then
						local menuItem=	{
														{"��Ϣ",nil,1},
														{"�ݷ�",nil,1},
														{"û��",nil,2},
													}
						local r=EasyMenu(menuItem);
						if r==1 then
							if rest() then
								say("һ��һ�ڣ�����֮������Ϣ���ˣ�����Ŭ���ɡ�");
							end
						elseif r==2 then
							visit(0);
						end
					else
						visit(0);
					end
					walkto_old(-2,0);
				end,
				[11]=function()--������
					if JY.Person[0]["����"]~=0 then	--�ǻ�ɽ����
						say("ʦ��ÿ�³�һʮ�嶼�����˸����ָ���书��ʦ�ܡ��������㲻���һ�ɽ�ɵİ���������˼��",20);
					else
								if JY.Person[0]["����"]<30 then
									say("���������ã�ʦ����Ҫ������ָ���书�ء���������ɫ��ô��ô���ξ����˰ɣ�������������Ҫ����",JY.Da);
									return;
								end
						local day=GetFlag(1)%30;
						if day==0 or day==14 then
							Dark();
							ModifyWarMap=function()
								SetWarMap(21,24,1,2268);
								SetWarMap(22,24,1,2268);
								SetWarMap(23,24,1,2268);
							end
							SetWarMap(20,18,1,5958);
							SetWarMap(21,16,1,5184);
							SetWarMap(22,16,1,5184);
							SetWarMap(23,16,1,5184);
							SetWarMap(24,16,1,5184);
							SetWarMap(21,20,1,5184);
							SetWarMap(22,20,1,5184);
							SetWarMap(23,20,1,5184);
							SetWarMap(24,20,1,5184);
							SetWarMap(21,18,1,5184);
							SetWarMap(22,18,1,5184);
							SetWarMap(23,18,1,5184);
							SetWarMap(24,18,1,5184);
							Light();
							say("��Ҷ����ù˼ɣ��ó��汾��������Ϊʦ�������ǵ��书��չ��Ρ�",1);
							say("�ǣ���ʦ��ָ�㡣",20);
							SetWarMap(20,18,1,0);
							SetWarMap(21,16,1,0);
							SetWarMap(22,16,1,0);
							SetWarMap(23,16,1,0);
							SetWarMap(24,16,1,0);
							SetWarMap(21,20,1,0);
							SetWarMap(22,20,1,0);
							SetWarMap(23,20,1,0);
							SetWarMap(24,20,1,0);
							SetWarMap(21,18,1,0);
							SetWarMap(22,18,1,0);
							SetWarMap(23,18,1,0);
							SetWarMap(24,18,1,0);
							FIGHT(
										5,1,
										{
											0,	24,22,
											10,24,20,
											11,24,18,
											12,24,16,
											13,24,14,
										},
										{
											1,20,18,
										},
										5000,1
									);
							--[[SetWarMap(21,24,1,2266);
							SetWarMap(22,24,1,0);
							SetWarMap(23,24,1,2270);]]--
							Cls();
							ShowScreen();
							say("лʦ��ָ�㡣",20)
							--SetFlag(1,GetFlag(1)+1);
							DayPass(1);
						else
							if JY.Da>0 then
								say("ʦ��ÿ�³�һʮ�嶼������������ָ���书��ʦ��ǧ���������",JY.Da);
								local menu={
													{"����",nil,1},
													{"�д�",nil,1},
													{"״̬",nil,1},
													{"û��",nil,1},
													};
								local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
								if r==1 then
									say("ÿ��ʦ��ָ���书���Ҷ���о���Ȼ���ʣ�Ҫ��ʦ�����춼��ָ���ͺ��ˡ�",JY.Da);
								elseif r==2 then
									if JY.Person[0]["����"]<30 then
										say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
										return;
									end
									say("�ð���ʦ����ָ�̡�",JY.Da);
									ModifyWarMap=function()
										SetWarMap(21,24,1,2268);
										SetWarMap(22,24,1,2268);
										SetWarMap(23,24,1,2268);
									end
									local result=vs(0,21,22,JY.Da,21,13,400);
									--[[SetWarMap(21,24,1,2266);
									SetWarMap(22,24,1,0);
									SetWarMap(23,24,1,2270);]]--
									Cls();
									ShowScreen();
									if result then
										say("ʦ�ܺù���",JY.Da);
									else
										say("ʦ�ܱ���ģ��Ժ��ѧ�������书��Ȼ�ͻ��������",JY.Da);
									end
									--SetFlag(1,GetFlag(1)+1);
									DayPass(1);
								elseif r==3 then
									PersonStatus(JY.Da);
								elseif r==4 then
									say("ʦ�����ߡ�",JY.Da);
								end
							else
								say("ʦ��ÿ�³�һʮ�嶼������������ָ���书��ʦ��ǧ���������",20);
							end
						end
					end
				end,
				[12]=function()--ľ׮
					if JY.Person[0]["����"]~=0 then	--�ǻ�ɽ����
						say("ץ��������",20);
					elseif JY.Da>0 then
						say("�����ľ��׮��������Ȥ�������Ҹ��˶�������",JY.Da);
						local menu={
												{"����",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
						if r==1 then
							--say("Ϊʲôû�������������أ�",JY.Da);
							RandomEvent(JY.Da);
						elseif r==2 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
								say("�ð���һ�쵽���ľͷ�ˣ�����ͷ����ˡ�",JY.Da);
								ModifyWarMap=function()
									SetWarMap(47,28,1,1840);
									SetWarMap(47,29,1,1840);
									SetWarMap(47,30,1,1840);
									SetWarMap(47,31,1,1840);
									SetWarMap(26,28,1,2274);
									SetWarMap(26,29,1,2274);
									SetWarMap(26,30,1,2274);
									SetWarMap(36,19,1,2268);
									SetWarMap(37,19,1,2268);
									SetWarMap(38,19,1,2268);
								end
								local result=vs(0,38,38,JY.Da,33,35,100);
								--[[SetWarMap(47,28,1,1842);
								SetWarMap(47,29,1,0);
								SetWarMap(47,30,1,0);
								SetWarMap(47,31,1,1838);
								SetWarMap(26,28,1,2276);
								SetWarMap(26,29,1,0);
								SetWarMap(26,30,1,2272);
								SetWarMap(36,19,1,2266);
								SetWarMap(37,19,1,0);
								SetWarMap(38,19,1,2270);]]--
							Cls();
							ShowScreen();
							if result then
								say("������ľͷ��ûʲô�ð������ǵ�ʵս�ء�",JY.Da);
							else
								say("����ԭ���ҵ��书��ô�����˰���",JY.Da);
							end
							--SetFlag(1,GetFlag(1)+1);
							DayPass(1);
						elseif r==3 then
							PersonStatus(JY.Da);
						elseif r==4 then
							say("��Ȼû�£��Ҿͼ��������ˡ�",JY.Da);
						end
					else
						say("ħ�������ֵĹ��У������������ɶ�Թ���ʦ��һ��Ҫ�ú�����������ħ�̣�",20);
					end
				end,
				[13]=function()	--������
					if JY.Person[0]["����"]~=0 then
						say("����ʲô�ˣ������뿪��",JY.Da);
					else
						say("ʦ��á�");
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
							say("��ѧʲô�أ�",JY.Da);
							local kflist;
							if GetFlag(10002)~=2 then
								kflist={
											{1,10},
										};
							else
								kflist={
											{1,10},
											{3,10},
											{4,10,1},
										};
							end
							if GetFlag(10017)==1 then
								for i=1,10 do
									if kflist[i]==nil then
										kflist[i]={83,10};
										break;
									end
								end
							end
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<5 then
								say("����书��������ϰ��ȥ����ʦ�����д�ɡ�",JY.Da);
							else
								say("����ռ�̫С�ˣ�����ȥ�����ð�",JY.Da);
								ModifyWarMap=function()
									SetWarMap(21,24,1,2268);
									SetWarMap(22,24,1,2268);
									SetWarMap(23,24,1,2268);
								end
								local result=vs(0,21,22,JY.Da,21,13,800);
								--[[SetWarMap(21,24,1,2266);
								SetWarMap(22,24,1,0);
								SetWarMap(23,24,1,2270);]]--
								Cls();
								ShowScreen();
								if result then
									say("�⼸��ʹ�ò������н����������ǵ�Ҫ�佾���꣬����Ŭ����",JY.Da);
								else
									say("�ú�Ŭ������Ҫ�����һ�ɽ������",JY.Da);
								end
								--SetFlag(1,GetFlag(1)+1);
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("û�¾�ȥ�ú���������Ҫ�Ĵ��й䡣��֪��׳��Ŭ�����ϴ�ͽ�˱���",JY.Da);
						end
					end
				end,
				[14]=function()	--���������
					if GetFlag(10005)==0 and GetFlag(16003)~=0 then
						--��ƽ֮����
						Dark();
							ModifyD(57,28,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,30);	--���
							ModifyD(57,5,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,26);	--��
							SetS(57,23,27,1,4256*2);	--���
							SetS(57,23,29,1,4685*2);	--ƽ֮
						Light();
						if JY.Person[0]["����"]==0 then
							say("����ʦ��������ͽ�ء�");
							SmartWalk(22,25,3);
						else
							say("��ɽ���ƺ���ʲô��ʽ��������һ���Թ۰ɡ�");
						end
						DrawStrBoxWaitKey("������Ⱥ�����㰸ǰ��ͷ����");
						say("��������Ⱥ��������¼������ƽ֮Ϊͽ��Ը�д���������֮��ӣ�����ƽ֮�ù���ѧ�������԰�����ر����Ź棬���ö��˻�ɽ�ɵ�������",1);
						say("��ƽ֮����������һ�ɽ�����£��������Ź棬����Υ������������ش�������������ն���⡣�����������������꣬�书����ȻҲ�ܺͱ��ɻ����۳�����һʱ��ǿ��ʤ�ܣ��ⲻ���������Ҫ�����ǣ����ɵ������˰�ϧʦ����������һ������úü�ס�ˡ�",1);
						say("�ǣ����ӽ���ʦ����ѵ��",136);
						if JY.Person[0]["����"]==1 then
							say("��ƽ֮�����Ѿ����뻪ɽ�ɣ��������ö��������ˡ�");
						end
						say("����壬���б����Ź棬�ý���ƽ֮��֪��",1);
						say("�ǣ���ʦ�ܣ��������ˡ������׽���ʦ���棬�����𳤡�������ǿ�����������޹������������ɫ����Ϸ��Ů���Ľ�ͬ�ż��ʣ������ɱ�����������壬͵�Բ�����佾���Դ󣬵���ͬ�����߽��Ľ����࣬������а�����ǻ�ɽ�߽䣬���ŵ��ӣ�һ�����С�",8);
						say("�ǣ�С�ܽ��Ǵ�ʦ������ʾ�Ļ�ɽ�߽䣬Ŭ�����У�����Υ����",136);
						say("���ˣ���������ࡣ���ɲ�������������������������ɡ���ֻ��ú��������߽䣬ʱʱ�ǵ�����Ϊ�ȣ��������˾��ӣ�ʦ��ʦ��ͻ�ϲ�ú��ˡ�",1);
						say("�ǣ�",136);
						say("����֮�У����������ˣ�������һ�����£����˶���������أ��˺������",1);
						say("ƽ���������ȸ��㸸ĸ�����ˣ����㾡�����ӵ����£���Ŵ��ڱ��ŵĻ�������",2);
						say("��лʦ����ʦ�",136);
						say("���ˣ�ƽ֮�������°ɡ�",1);
						say("�ǣ�",136);
						Dark();
							SetS(57,23,29,1,0);	--ƽ֮
							SetS(57,23,25,1,4262*2);	--ƽ֮
						Light();
						say("������������ɽ�����˻�ɽ�߽�Ķ��ٽ�����",1);
						say("����֪���ˣ����Ӳ���ʦ����ʦ��Ľ̻壬���˵����佾���Դ󣬵���ͬ���Ľ������ں�ɽ����¥�ϣ�ɱ������ɵ����˽ܡ�",8);
						say("�ߣ�",1);
						say("�����������˽��������ʦ��ġ���ʱ��ʦ����ﲮ���֮���������ˣ����˽ܳ���֮Σ����ʦ���������ִ��У�",14);
						say("��Ҫ�������£�����»����ɵ��ճ������������ǵ��Ӷ���������ǰ����϶�������˽ܺö˶˵أ����������˳��֮Σ��",1);
						say("��ʦ��������ǵ��ӣ����Ѵ�������ʮ�����𷣹��ˣ�ǰ�����壬�������㡣��ʦ���������ˣ������ٰ������ˡ�",14);
						say("�˿����۾����Ž��ɣ����ǻ�ɽ���ӣ��ݵú��Ҳ��졣",1);
						say("���˽ܳ���֮Σ��������裬������������ԭ�����Ӻ����ɷ�������Ϊ����Ҳ���ˡ����������س��ԶԺ�ɽ������˵��ô��һ����ã���ı��䡯����˵����Ҳ�¼���ã�",1);
						say("����",14);
						say("���ӵ�ʱֻ��Ҫ��ɽ�ɵ��Ǹ�ʦ�ü�����ȥ��������֪�����ﲮ��Ķ��֣��޷���Ⱥ�ɽ�ɵ���ʦ�ã�����������ͬ���������������ˣ�����ֻ�ú�˵�˵�һ���������������ں�ɽ�ɵ�ʦ����ʦ���Ƕ��У�ȷ�Ǽ�Ϊ����",8);
						say("��Ҫ����ʦֶ��ȥ��������Ȼ����������ô������˵��ƫƫҪ�ڳ�����֮�ԣ�����ƽ��̫���ḡ����һ���£�������������Ȼ���˽�֪�����˱���Ȼ˵�㲻�����˾��ӣ����ҹܽ��޷���",1);
						say("�ǣ�����֪�",8);
						say("�Ƿѱ�Ҫɱ������Ϊ��Ҫ���֣�",1);
						say("ʦ��������ֻ�Ǽ��ѱ��ñ��ӵ��ֶ�ɱ�����������ţ�һʱ������ߣ��š���",8);
						say("�ѱ���Ϊ����Ȼ���˲��ݣ������վ��������ύħ�����ȡ���������ħ�����ӣ�����ύ���������ˣ�����������䣬�������ǺεȾ����ܸ�֮�ˣ�ȴҲ���������˼ҵĵ�������ͷ���ֵ�������ѣ�����������ħ��������ն������ֶΣ������������������������������а�Ҽ�֮����һ���ϣ���Ȼʮ�ֺ�Ϳ�ˡ����¹��浽���Ժ��������Ĵ�ؽڣ����м�ɰ�ֺ������á�",1);
						say("ʦ���������ǣ�����������Ϊ��ʵ�ڲ��á�",8);
						say("��������¹�ϵ���һ�ɽһ�ɵ���˥���裬Ҳ��ϵ����һ���İ�Σ�ɰܣ��㲻�ɶ�����˿����������ֻ���㣬������ħ�����ˣ��Ƿ񼵶���𣬸�ɱ���⣿",1);
						say("�⡪�����ħ������Ϊ�����������Ե���֮�������ǡ���",8);
						say("���ˣ���ʱ������ǿҪ��ش�Ҳ�����á���˷���ɽ�����������������������һ�꣬������´�ͷ��β�úõ���һ�롣",1);
						say("�ǣ����ӹ����𷣡�",8);
						say("���һ�ꣿ��ô��һ��֮�У�ÿ����ڼ���ʱ����",14);
						say("��ô����ʱ����ÿ���Գ��������˳Է�˯��֮�⣬������˼����",1);
						say("����ô�ɣ����ǽ�����Ҳ�����ˣ��ѵ�����С��Ҳ����",14);
						say("Ů�����ң�˵��û���˹�ģ�",2);
						say("���һ�꣬����ôϣ����������ʦ�淸��������������Ů������������������£������·�һ����",1);
						say("��ô���һ�꣬����������ˣ���ʵ��ʦ��˵��һ����ã���ı��䡯��ȫ�ǳ��ھ��˵ĺ��ģ��ֲ��ǹ������ˣ�",14);
						say("����Ϊ���ں��ģ���ŷ������һ�꣬Ҫ�ǳ��ڴ��⣬�Ҳ�������������ݡ�����������ͷ�Ź֡�",1);
						say("ɺ����Ҫ��������������ʦ������Ů�������˼������ɱ�ȥ��������˵�������������ȫ����һ�����⣬��ȫ��������ˡ�",2);
						say("����ʦ������Ů�������Σ���˵�ǳ�ȫ�ģ�������ȥ�������죬��ô��ʦ���į֮ʱ����˭����˵�����ƣ���һ��֮�У�˭����������",14);
						say("��������죬��������ô�ڡ�˼��ô������ɽ�϶���ʦ��ʦ梣�˭���ɺ����д轣����",2);
						say("��ô��ʦ�����ô�أ�һ�겻�·壬�񲻶���������",14);
						say("�㲻�õ��ģ��Ի������ͷ��˸�����",2);
						say("���ˣ��������ȥ�ɡ�",1);
						say("�ǡ�",8);
						SetFlag(10005,1);
						Dark();
							ModifyD(57,28,-2,-2,-2,-2,-2,-2,-2,-2,-2,29,24);	--���
							ModifyD(57,5,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,44);	--��
							ModifyD(57,16,-2,-2,-2,24,-2,-2,-2,-2,-2,-2,-2);	--����
							SetS(57,23,27,1,0);	--���
							SetS(57,23,25,1,0);	--ƽ֮
							ModifyD(57,30,1,-2,5,136,0,5862,5886,5862,3,-2,-2);	--ƽ֮
							--SetS(57,27,29,3,-1);	--�رջ�ɽ��ƽ֮��ʦ���������¼�
							ModifyD(81,0,1,-2,1,8,-2,4256*2,4256*2,4256*2,-2,-2,-2);
						Light();
					elseif JY.Person[0]["����"]==0 and GetFlag(10007)==0 and GetFlag(16003)~=0 and GetFlag(1)-GetFlag(16004)>90 then
						--��ɽ����֧
						Dark();
							ModifyD(57,28,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,30);	--���
							ModifyD(57,5,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,26);	--��
							SetS(57,21,31,1,2591*2);
							SetS(57,22,31,1,2591*2);
							SetS(57,23,31,1,2591*2);
							SetS(57,22,25,1,2590*2);
						Light();
						say("��ô��Ҷ����������ʦ���ƺ���ʲô����Ҫ������");
						SmartWalk(23,25,3);
						say("�����������϶��������������ﲮ���������һ�ɽ���ڷ�������Ϊ�������ɣ����ǻ�ɽ������֮�����˴���ɽ����������֮�⣬����Ҳ���������������쳵����Ϊ������ϰ����꣬������Ǽ����ʱ���ˡ�Ҳ�������Ǽ�ʶһ�½��������ҹ���Դ�",1);
						say("�ǣ�ʦ������",24);
						SetFlag(10010,GetFlag(1));
						if DrawStrBoxYesNo(-1,-1,"�Ƿ���ɽ��") then
							say("ʦ�������Ƕ���ɽ�ˣ��Ǵ�ʦ��������",13);
							say("�š�������ܷ������ǲ���ͬȥ��ֻ�ǣ�������������������ˡ���",1);
							say("ʦ���������书��΢����˼��ȥҲ�޷��ﵽʦ����Ҫ�����Զ�������ʦ���������£�ÿ�ո���ʦ���ͷ���",13);
							say("ϰ��֮������������ԷƱ������������ѵ�������������ұ����ˡ��мǲ��ɴ��ơ�",1);
							say("�ǣ�ʦ����",13);
							say("�������������Ӧ�ĵ��죬ֻ�ǵ�ʱ�������ֻ��һ��ջ��ɡ�",1);
							say("�Ǻǡ���",13);
							say("�ߣ����󻰣����Ǳ��ҷ��֣���Ҳ��˼����ȥ�ɡ������ߡ�",1);
							SetFlag(10007,1);
						else
							say("ʦ������ʦ������˼���¡�������������ÿ���ͷ�����ʦ��Ӧ�ʡ�");
							say("�ѵ��㻹�ǵó��������£�������ʦ��ͬ���ˡ�",2);
							say("�š��������мǣ�ֻ���ͷ������ɴ��ơ�����˼���±������ܷ��ġ����Ǵ��Ƹ������ߺ�!",1);
							say("�ǣ�ʦ��������������ô˵�ţ�������ʱ��ʦ��Ҳ����������");
							say("��ʦ�ֵķ����鷳���ˡ����У���Ϊ��ʦ��׼����һЩ���òˡ���������̨��ߵĹ����ø��������ˡ��鷳�㵽ʱ��ȡ�����͸���ʦ�֡�",13);
							say("ʦ�ַ��ģ�����ʡ�á�");
							SetFlag(10007,2);
							ModifyD(81,0,-2,-2,2,-2,-2,3812*2,3827*2,3812*2,3,-2,-2);	--�޸��������
						end
						Dark();
							ModifyD(57,28,-2,-2,-2,-2,-2,-2,-2,-2,-2,29,24);	--���
							ModifyD(57,5,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,44);	--��
							SetS(57,21,31,1,0);
							SetS(57,22,31,1,0);
							SetS(57,23,31,1,0);
							SetS(57,22,25,1,0);
							--������ʧ
							ModifyD(57,0,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,1);
							ModifyD(57,1,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,2);
							ModifyD(57,17,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,3);
							ModifyD(57,22,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,4);
							ModifyD(57,26,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,5);
							ModifyD(57,6,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,6);
							ModifyD(57,5,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,7);
							ModifyD(57,23,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,8);
							ModifyD(57,24,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,9);
							ModifyD(57,15,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,10);
							ModifyD(57,16,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,11);
							ModifyD(57,27,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,12);
							ModifyD(57,28,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,13);
							ModifyD(57,30,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,14);
							ModifyD(57,2,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,15);
							ModifyD(57,29,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,16);
							ModifyD(57,3,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,17);
							ModifyD(57,4,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,18);
							ModifyD(57,18,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,19);
							ModifyD(57,19,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,20);
							ModifyD(57,20,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,21);
							ModifyD(57,21,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,22);
							SetS(57,52,29,3,201);
							SetS(57,52,30,3,201);
							SetS(57,30,13,3,202);
							SetS(57,31,13,3,202);
							SetS(62,50,25,3,201);
							SetS(62,50,26,3,201);
						Light();
					elseif GetFlag(10015)==0 and GetFlag(10013)>0 then	--������ɽ
						SetFlag(10015,1);
						Dark();
							ModifyD(57,28,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,30);	--���
							ModifyD(57,5,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,26);	--��
							ModifyD(57,22,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,1);	--����
							SetS(57,21,31,1,2591*2);
							SetS(57,22,31,1,4706*2);
							if JY.Person[0]["����"]==0 then
								SetS(57,23,25,1,4267*2);
							else
								SetS(57,23,31,1,2591*2);
							end
							SetS(57,21,25,1,4267*2)
							SetS(57,22,25,1,4271*2)
							SetS(57,23,25,1,2602*2)
						Light();
						if JY.Person[0]["����"]==0 then
							SmartWalk(23,31,0);
						else
							SmartWalk(23,25,3);
						end
						say("��ʦ�֣������Ż�֮�£��������˱���������졣ֻ�����������ɽ������֣����ٹ��裬Ҫ����һ�ɴ��²�����Ϊ����ͬ����Ц���������ɹ������ߡ��ʲ������˵����ɽ�ɲ��ö�����£��⻰δ�ⲻ���ˡ�",112);
						say("��ԭ�����ǻ�����ִ����û�е��֡�����Ȼ֪��������죬Ϊ�λ�Ҫ���£��������Դ���ͣ�",8);
						say("���˷�����",112);
						say("������ȴ˼�������������˽������֮�ˡ�������½ʦ������",1);
						say("Ŷ��½ʦ��Բ����ˡ����ǽ��ڣ������һ�ɽ�����ԡ������������ʦ������ɡ�",8);
						say("��ʦ�֣��������˹̵ܽ��ӵ�ô���첽����������ɽҲ���Ż�ɽ��į֮�ԡ�",3);
						say("������Զ�Ϊ������˵�������е���֮�����������¡�",1);
						say("�㣡���ˣ�����֮�ԣ�����Ҳ�ա��㻹�ǹԹԵİ�����֮λ�ó����ɡ�",3);
						say("����һλ������ʦ�������������£��������ڡ�ˡ�Ѵ�����",1);
						say("��������������ʦ���£����ܸ���һ����",8);
						say("������ݵ�����",1);
						say("�ߣ�",3);
						if JY.Person[0]["����"]==0 then
							say("������һλ��������ʵ�顣���ǲ��ܷ��ڣ�������������ţ�");
							say("����½ʦ��֮�⣿",1);
							say("�Ƚ���ʤ��������ɽ��");
						else
							say("������һλ��������ʵ�顣���ǲ��ܷ��ڣ�������������ţ�",112);
							say("��������֮�⣿",1);
							say("�Ƚ���ʤ��������ɽ��",112);
						end
						say("�⡭��",8);
						say("�ã���������˭˭˭����ս��ʦ�������ʹ����⻪ɽ��ʦ�ְɣ�",8);
						say("�ã��ã��ã����������٣��������ã�������Լ����������Ǿ��ݹ��������ˣ�",3);
						say("�㱾�Ͳ������⣬��������֮�ԣ������뵱���ţ�������ʦ�����£�����һ����ʦ�֣�Ȼ�󾤾�ҵҵ���ź���һ�ɽ���²�����;��",8);
						say("����������",3);
						--fight
						ModifyWarMap=function()
							SetWarMap(21,31,1,0);
							SetWarMap(22,31,1,0);
							SetWarMap(23,31,1,0);
							SetWarMap(21,25,1,0);
							SetWarMap(22,25,1,0);
							SetWarMap(23,25,1,0);
							SetWarMap(26,28,1,2274);
							SetWarMap(26,29,1,2274);
							SetWarMap(26,30,1,2274);
							SetWarMap(21,24,1,2268);
							SetWarMap(22,24,1,2268);
							SetWarMap(23,24,1,2268);
							SetWarMap(21,34,1,1708);
							SetWarMap(22,34,1,1708);
							SetWarMap(23,34,1,1708);
						end
						vs(8,24,28,3,21,28,500);
						say("���˰��ˡ�������ڼ�������ţ�ȴ�����ڵ��Ӷ���������ʵ�˿�Ц֮����",3);
						say("�Ǽ��Ǽ����㻹�ǳ���Ϊ��ʦ�֣����ǡ�������",8);
						say("�ⲻƽ������Ϊʦ�壬��Ȼ͵Ϯһ���󱲣����Ұ������£�",2);
						say("�ߣ�",3);
						say("������ʦ�֣��ҳ���һ��ʦ�֣�ʵ���ǲ��������ǳ��׾��ѡ������ҷ��������ڣ�����Ϊ��ɽ���ˣ���������ɱ��ֻ��������ĳЩ�������⡣",1);
						say("�ߣ�",112);
						say("�㲻����˵�ˡ��ӽ��Ժ��Ҿ����ٳ�����ɽ��",3);
						say("��лʦ���������塣",1);
						Dark();
							say_2("����",8);
							say_2("�����",2);
							SetS(57,22,31,1,0);
							SetS(57,22,28,1,4224*2);
							SetS(57,21,28,1,3398*2);
							SetS(57,23,28,1,3401*2);
							SetS(57,22,27,1,3399*2);
							SetS(57,22,29,1,3400*2);
							SetS(57,24,27,1,3401*2);
							SetS(57,24,29,1,3401*2);
						Light();
						say("���������壿",152);
						say("�ող�����Ů�˽��������",153);
						say("�г����һ�������������",154);
						say("���������Ϊ��ô�г���أ�",155);
						say("�������������ͺ�����",156);
						say("Ů�ˣ���еĳ�����������",157);
						say("��Ȼ��������Ҫ��ʲô��",2);
						say("��������塣",157);
						say("�����Ǿ�û�Ҵ����ˡ�",156);
						say("������û���ˡ�",155);
						say("�����������ˣ��ܲ����ˡ�",154);
						say("����ô�죿",153);
						say("�����Ȱ������˺��ˡ�",152);
						Dark();
							say("�����",2);
							SetS(57,22,28,1,0);
							SetS(57,21,28,1,0);
							SetS(57,23,28,1,0);
							SetS(57,22,27,1,0);
							SetS(57,22,29,1,0);
							SetS(57,24,27,1,0);
							SetS(57,24,29,1,0);
						Light();
						say("������ɽ����̫������������������ǰ��ָʹа������ҵ����ں󣬽����������ǲ��ѳ���������ҽ������²��˻�ɽ��",2);
						say("��ʦ�֣�����������ɽ������ʶ��",112);
						say("����һʱ����֮�ԣ��������档ֻ�����һ�£��һ�ɽ���е���������ʦ�ּ��¡�ˡ��Զ�͡�",1);
						say("��ǡ�",112);
						Dark();
							ModifyD(57,28,-2,-2,-2,-2,-2,-2,-2,-2,-2,29,24);	--���
							ModifyD(57,5,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,44);	--��
							ModifyD(57,22,-2,-2,-2,-2,-2,-2,-2,-2,-2,21,25);	--����
							SetS(57,21,31,1,0);
							SetS(57,23,31,1,0);
							SetS(57,21,25,1,0);
							SetS(57,22,25,1,0);
							SetS(57,23,25,1,0);
						Light();
						if JY.Person[0]["����"]==0 then
							--say("�����ǽ���֮�˽����ƺ���ʦ�������������ǲ���Ӧ�ø���ȥ�أ���");
							--say("���˴λ�ɽ������ɽ����֮Ӱ��Ȼ�������������ⷬ����ʵ����������֮������");
							say("����ʦ�ֱ����������˴����ˣ���֪��Ρ���ȥ�����ɡ��ո����Ǻ�������ɽȥ�ˡ���");
						elseif JY.Person[0]["����"]<0 then
							say("�����ǽ���֮�˽����ƺ��Ȼ�ɽ���Ż�������");
							--say("ʦ�ַ��ģ�����ʡ�á�");
							--say("ʦ�ַ��ģ�����ʡ�á�");
						end
						SetS(81,49,36,3,201);
						SetS(62,9,21,1,4707*2);
						SetS(62,9,21,3,211);
					else
						return true;
					end
				end,
				[201]=function()	--��ɽ������ɽ-����
					if JY.Person[0]["����"]==0 then
						if GetFlag(10007)==1 then
							say("ʦ�ֵ��Ƕ������ˣ��һ��ǸϽ���Ѱ�ﲮ��ȥ�ɡ�");
							walkto_old(2,0);
						elseif GetFlag(10007)==2 then
							say("��ʦ�ֻ��ں�ɽ���ҵø����ͷ���������ɽ��");
							walkto_old(-2,0);
						end
					else
						say("��ɽ����ô����һ�ˣ�����֡�");
						SetS(57,30,13,3,-1);
						SetS(57,31,13,3,-1);
					end
				end,
				[202]=function()	--���òˡ�
					if JY.Person[0]["����"]==0 then
						say("��������Ȼ��ˡ���ˡ��òˡ���ֻ�´�ʦ�������ˡ�");
						SetFlag(10008,1)
					end
					SetS(57,30,13,3,-1);
					SetS(57,31,13,3,-1);
				end,
			}

						--say("")
						--[[
						�ⲻƽ���Ǳߵ�С�ѣ���������һ·���ѵ�������Ⱥ��Ҫ�Ͼ�ɱ�����ɣ�
��ң���Ҳ��С�Ӹոչ۷�ʦ�彣��������˳��ԣ������԰Ρ���β�����ˣ�ֻԸ����ʦ�����£�ϰ���ϳ˽�����
�ⲻƽ��Ŷ����Ը��������ܾ����£�
��ң�ʤ����һʱ֮�����ѡ��ҹ��ǻ�ɽ���²�������Ⱥ������������ˡ���������Ⱥ��α���ӣ������ֻһ���ӣ����˲��ԣ���ʮ����������ˣ����ҽ������˿�Ϊ֮�С���ʱ�ҽ����Կɾ���������
�ⲻƽ�������뷨����ֻ�ǣ��������ģ���Ը������ִ������Ը�⣬ÿ��ʮ�������Ѱ��ѧϰ��������ʦ֮���ݵ����ᡣ
��ң��ǡ�
]]--SceneEvent[58]={};--��ɽ�ɸ��¼�
SceneEvent[58]={
				[1]=function()	--���ŵ���
					--��ʱ�����Ǻ�ɽ����
								--ResetFW();
					--ShowEFT()
					--vs(149,38,51,66,29,49,300);
					--GetItem(0,1);
					if JY.Person[0]["����"]~=2 and  GetFlag(12005)==1 then
						SceneEvent[58][201]();
						return;
					end
					if JY.Person[0]["����"]~=2 then	--�Ǻ�ɽ����
						local d=JY.Base["�˷���"];
						if d==0 then
							say("������ú�ɽ����֪�кι�ɣ�",60);
						else
							say("����Ҫ������",60);
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
						if JY.Person[0]["����"]>=0 then	--��������
							menu[2][3]=0;
						end
						local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
						if r==1 then
							say("�Һ�ɽ����ï�������滨��ݣ�����������Ͼ���������Ĵ����ߡ�",60);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						elseif r==2 then
							say("�������ʦ��ͨ����С�ֵ�����������",60);
							Dark();
							JY.Base["��X1"]=28;
							JY.Base["��Y1"]=14;
							JY.Base["�˷���"]=0;
							 JY.MyPic=GetMyPic();
							Light();
							--��ʱ�����ǰ�ʦ����
							if true then
								say("��Ը���Һ�ɽ��",49);
								if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ�����ɽ�ɣ�",C_WHITE,CC.Fontbig) then
									say("ʦ�����ϣ�����ͽ��һ�ݣ�");
									say("��������ͽ�����Ұ�����ʦ������������",49);
									say("�ǣ�");
									JY.Person[0]["����"]=2;
									JY.Shop[2]["����ʱ��"]=GetFlag(1);
									DrawStrBoxWaitKey(JY.Person[0]["����"].."����Ϻ�ɽ��",C_WHITE,CC.Fontbig);
									JY.Person[0]["���"]="��ɽ����";
									GetItem(2,1);
								else
									say("��ˣ��ڴ�������",49);
								end
							else
								say("ƾ�����ֽ������࣬Ҳ������Һ�ɽ��ǽ��",49);
							end
						elseif r==3 then
							say("С�ֵ��´��пգ�����������ɽ������",60);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						elseif r==4 then
							say("��Ȼ���£�����²�Ҫ�ڴ˶�����",60);
						end
					else
						local d=JY.Base["�˷���"];
						if JY.Da>0 then
							say("ʦ�ܣ���ʲô����",JY.Da);
							local menu={
													{"����",nil,1},
													{"�д�",nil,1},
													{"״̬",nil,1},
													{"վ��",nil,1},
													{"����",nil,1},
													{"���",nil,1},
													{"û��",nil,1},
												};
							if d==0 then
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
								say("�ð������������档",JY.Da);
								ModifyWarMap=function()
									SetWarMap(27,47,1,1021*2);
									SetWarMap(28,47,1,1022*2);
									SetWarMap(29,47,1,1022*2);
									SetWarMap(30,47,1,1023*2);
									SetWarMap(27,46,1,0);
									SetWarMap(30,46,1,0);
									SetWarMap(48,55,1,1144*2);
									SetWarMap(49,55,1,1144*2);
									SetWarMap(25,53,1,1144*2);
								end
								local result=vs(0,38,51,JY.Da,29,49,300);
								--[[SetWarMap(27,47,1,1024*2);
								SetWarMap(28,47,1,0);
								SetWarMap(29,47,1,0);
								SetWarMap(30,47,1,1026*2);
								SetWarMap(27,46,1,1025*2);
								SetWarMap(30,46,1,1027*2);
								SetWarMap(48,55,1,0);
								SetWarMap(49,55,1,0);]]--
								Cls();
								ShowScreen();
								if result then
									say("�벻��ʦ������û���գ��书��������˵á�",JY.Da);
								else
									say("ʦ���㻹�ö����ģ������´����д�ɡ�",JY.Da);
								end
								DayPass(1);
							elseif r==3 then
								PersonStatus(JY.Da);
							elseif r==4 then
								--say("��лʦ�����⣬��ϧ����ְ�����ڣ��޷�������",JY.Da);
								E_guarding(JY.Da);
							elseif r==5 then
								say("ʦ�������",JY.Da);
								Dark();
								JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
								JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
								Light();
							elseif r==6 then
								say("�����ն����Ĺ��ܣ�ʦ�ܶ��С�ġ�",JY.Da);
								Dark();
								JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
								JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
								Light();
							elseif r==7 then
								say("ʦ���������£�������������д����书Ҳ�ð���",JY.Da);
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
					if JY.Person[0]["����"]~=2 then	--�Ǻ�ɽ����
						say("��ӭ�������Һ�ɽ���͡�",60);
					elseif JY.Da>0 then
						say("��ɽ���У��ɽ��������ɽ��������ɽ���ԣ�Ω����������ɡ�",JY.Da);
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
								SetWarMap(27,47,1,1021*2);
								SetWarMap(28,47,1,1022*2);
								SetWarMap(29,47,1,1022*2);
								SetWarMap(30,47,1,1023*2);
								SetWarMap(27,46,1,0);
								SetWarMap(30,46,1,0);
								SetWarMap(28,40,1,1429*2);
								SetWarMap(29,40,1,1429*2);
								SetWarMap(30,40,1,1429*2);
							end
								local result=vs(0,33,43,JY.Da,25,43,500);
								--[[SetWarMap(27,47,1,1024*2);
								SetWarMap(28,47,1,0);
								SetWarMap(29,47,1,0);
								SetWarMap(30,47,1,1026*2);
								SetWarMap(27,46,1,1025*2);
								SetWarMap(30,46,1,1027*2);
								SetWarMap(28,40,1,0);
								SetWarMap(29,40,1,0);
								SetWarMap(30,40,1,0);]]--
							Cls();
							ShowScreen();
							if result then
								say("�벻��ʦ������û���գ��书��������˵á�",JY.Da);
							else
								say("ʦ���㻹�ö����ģ������´����д�ɡ�",JY.Da);
							end
							DayPass(1);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("ʦ���������£�������������д����书Ҳ�ð���",JY.Da);
						end
					else
						say("�Һ�ɽ�ɽ������Ī�⣬���аٱ�ǧ������ʮ�������侫����ס�",20);
					end
				end,
				[3]=function()	--������ߵ���-������
					if JY.Person[0]["����"]~=2 then	--�ǻ�ɽ����
						say("����������",60);
					else
						--[[	if GetFlag(12005)==0 and JY.Person[0]["����"]>30 and GetFlag(10004)~=0 and GetFlag(16001)==2 then
								say("Ϊʦ�⼸���Ҫ����ϴ�֣��˳������ˣ����пվ������æ�ɡ�",JY.Da);
								say("�ǡ�");
								Dark();
								DayPass(5,-1);
								if GetFlag(12001)==2 then
									say("��������",113);
									SetS(58,36,58,1,4228*2);
									JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=37,58,2;
									JY.MyPic=GetMyPic();
									script_say("���ǣ���ʦ�壡");
									script_say("�ѱ����ҹ���������Ҫ��������");
									script_say("���ǣ�һ������ʦ�尲�š�");
									script_say("�ѱ򣺺ܺã�����Ҫ�㽫������ļ�С����ץ����");
									script_say("���ǣ��⡭��");
									script_say("�ѱ���ô���µ���񣬻��뷴�ڲ��ɣ�");
									script_say("���ǣ����Ӳ��ң�����ȥ�ˣ�");
									Dark();
										SetS(58,36,58,1,0);
										JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=14,32,2;
										JY.MyPic=GetMyPic();
										SetS(JY.SubScene,13,32,1,3679*2);
									Light();
									say("����������ȫ���ѹ���");
									SetS(JY.SubScene,13,32,1,0);
									say("ȥ�μ�ʦ������ϴ�ְɡ�");
								else
									Light();
									say("����ʦ������ϴ�֣��ҿɱ�����ʱ����");
								end
								SceneEvent[58][201]();
								return;
							end]]--
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
							say("����ɢ������ɢ��������֮�󣬴˵����ӡ�",JY.Da);
							if GetFlag(12008)<100 and Rnd(100)>50 then
								SetFlag(12008,GetFlag(12008)+1);
							end
						elseif r==2 then
							say("ͽ����ѧЩʲô��",JY.Da);
							local kflist={
												{31,10},
												{33,10,1},
												{37,10},
												{39,10},
												{40,10,2},
												};
							if GetFlag(12008)>5 then
								kflist[6]={84,10};
							end
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<5 then
								say("ͽ�������Ϊ����ĥ����ȥ����ʦ�����д�ɡ�",JY.Da);
							else
								say("�ã�ֻ�ܳ��У���Ϊʦ��������书������Ρ�",JY.Da);
								ModifyWarMap=function()
									SetWarMap(28,28,1,1429*2);
									SetWarMap(29,28,1,1429*2);
									SetWarMap(30,28,1,1429*2);
									SetWarMap(23,23,1,903*2);
									SetWarMap(35,25,1,903*2);
								end
								local result=vs(0,28,20,JY.Da,26,13,2000);
								--[[SetWarMap(28,28,1,0);
								SetWarMap(29,28,1,0);
								SetWarMap(30,28,1,0);
								SetWarMap(23,23,1,0);
								SetWarMap(35,25,1,0);]]--
								Cls();
								ShowScreen();
								if result then
									say("�������н�չ��",JY.Da);
								else
									say("�⼸��Ӧ�������㡭��ͽ������Ŭ���ɡ�",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("�������������ˣ�����ѧЩ���֣����д�����֮ͨ�",JY.Da);
						end
					end
				end,
				[4]=function()	--�����ұߵ���-³����
					if JY.Person[0]["����"]~=2 then	--�ǻ�ɽ����
						say("����������",60);
					else
						--[[	if GetFlag(12005)==0 and JY.Person[0]["����"]>30 and GetFlag(10004)~=0 and GetFlag(16001)==2 then
								say("��ʦ���⼸��J��Ҫ����ϴ�֣���ûʲô�¾�ȥ���æ�ɡ�",JY.Da);
								say("�ǡ�");
								Dark();
								DayPass(5,-1);
								if GetFlag(12001)==2 then
									say("��������",113);
									SetS(58,36,58,1,4228*2);
									JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=37,58,2;
									JY.MyPic=GetMyPic();
									script_say("���ǣ���ʦ�壡");
									script_say("�ѱ����ҹ���������Ҫ��������");
									script_say("���ǣ�һ������ʦ�尲�š�");
									script_say("�ѱ򣺺ܺã�����Ҫ�㽫������ļ�С����ץ����");
									script_say("���ǣ��⡭��");
									script_say("�ѱ���ô���µ���񣬻��뷴�ڲ��ɣ�");
									script_say("���ǣ����Ӳ��ң�����ȥ�ˣ�");
									Dark();
										SetS(58,36,58,1,0);
										JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=14,32,2;
										JY.MyPic=GetMyPic();
										SetS(JY.SubScene,13,32,1,3679*2);
									Light();
									say("����������ȫ���ѹ���");
									SetS(JY.SubScene,13,32,1,0);
									say("ȥ�μ�ʦ������ϴ�ְɡ�");
								else
									Light();
									say("����ʦ������ϴ�֣��ҿɱ�����ʱ����");
								end
								SceneEvent[58][201]();
								return;
							end]]--
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
							say("ʦ������Щ����Ҫ�������룬�������°ɡ�",JY.Da);
						elseif r==2 then
							say("��ѧʲô�أ�",JY.Da);--JY.Person[0]["���"]=5
							local kflist={
												{32,10},
												{34,10,1},
												{37,10},
												{38,10,2},
												{39,10},
												--{83,10},
												--{84,10},
												--{45,10},
												};
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<5 then
								say("�����Ϊ̫ǳ��ȥ����ʦ�����д�ɡ�",JY.Da);
							else
								say("�ã�ֻ�ܳ��аɣ���ʦ���ҿ�������书������Ρ�",JY.Da);
								ModifyWarMap=function()
									SetWarMap(28,28,1,1429*2);
									SetWarMap(29,28,1,1429*2);
									SetWarMap(30,28,1,1429*2);
									SetWarMap(23,23,1,903*2);
									SetWarMap(35,25,1,903*2);
								end
								local result=vs(0,28,20,JY.Da,30,13,2000);
								--[[SetWarMap(28,28,1,0);
								SetWarMap(29,28,1,0);
								SetWarMap(30,28,1,0);
								SetWarMap(23,23,1,0);
								SetWarMap(35,25,1,0);]]--
								Cls();
								ShowScreen();
								if result then
									say("�����书���н�������",JY.Da);
								else
									say("ʦֶ���⼸��ʹ�û��У�����Ŭ���ɡ�",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("û�¾�ȥ�ú���������Ҫ�Ĵ��й䡣",JY.Da);
						end
					end
				end,
				[5]=function()	--����
					if JY.Person[0]["����"]~=2 then	--�ǻ�ɽ����
						say("���£�",49);
					else
						if GetFlag(12005)==0 and JY.Person[0]["����"]>30 and GetFlag(10004)~=0 and GetFlag(16001)==2 then
							if GetFlag(12001)==1 then
								say("��ʦ���⼸�վ�Ҫ����ϴ�֣�����������������£�ר�ı������żҾ켴�ɡ�",49);
								say("�ǡ�");
								SmartWalk(14,32,1);
								Dark();
								DayPass(5,-1);
								script_say("��ɽ���ӣ��죬ץס������ļҾ죬���˷����ˡ�")
								say_2("�ߣ��������ߣ���")
								local r1=FIGHT(
											5,2,
											{
												0,13,32,
												-1,13,33,
												-1,13,34,
												-1,13,35,
												-1,13,36,
											},
											{
												132,16,32,
												134,16,34,
											},
											0,0
											);
							--Light()
								if r1 then
									say("ȥ�μ�ʦ������ϴ�ִ��ɡ�");
								else
									JY.Status=GAME_END;
									return;
								end
							else
								say("��ʦ���⼸�վ�Ҫ����ϴ�֣���ûʲô�¾�ȥ���æ�ɡ�",49);
								say("�ǡ�");
								Dark();
								DayPass(5,-1);
								if GetFlag(12001)==2 then
									say("��������",113);
									SetS(58,36,58,1,4228*2);
									JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=37,58,2;
									JY.MyPic=GetMyPic();
									script_say("���ǣ���ʦ�壡");
									script_say("�ѱ����ҹ���������Ҫ��������");
									script_say("���ǣ�һ������ʦ�尲�š�");
									script_say("�ѱ򣺺ܺã�����Ҫ�㽫������ļ�С����ץ����");
									script_say("���ǣ��⡭��");
									script_say("�ѱ���ô���µ���񣬻��뷴�ڲ��ɣ�");
									script_say("���ǣ����Ӳ��ң�����ȥ�ˣ�");
									Dark();
										SetS(58,36,58,1,0);
										JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=14,32,2;
										JY.MyPic=GetMyPic();
										SetS(JY.SubScene,13,32,1,3679*2);
									Light();
									say("����������ȫ���ѹ���");
									local flag=0;
									for i=2,CC.TeamNum do
										local ppid=JY.Base["����"..i];
										if ppid>0 and JY.Person[ppid]["����"]==2 then
											flag=flag+1;
											e[flag]=ppid;
										end
									end
									if flag>0 then
										local maxp=e[1];
										for i=2,flag do
											if JY.Person[e[i]]["���"]>JY.Person[maxp]["���"] then
												maxp=e[i];
											elseif JY.Person[e[i]]["���"]==JY.Person[maxp]["���"] then
												if JY.Person[e[i]]["�ȼ�"]>JY.Person[maxp]["�ȼ�"] then
													maxp=e[i];
												end
											end
										end
										Dark();
											say("���Ӻô󵨣�",maxp);
										Light();
										say("��Ҫ��ʲô��");
										say("���Һ����ཻһ�����벻����ȴ���й�����ɽ�ɣ�Ҫ����ʦ�������������ɣ�",maxp);
										local r2=FIGHT(
													5,flag,
													{
														0,13,32,
														-1,13,33,
														-1,13,34,
														-1,13,35,
														-1,13,36,
													},
													{
														e[1],16,32,
														e[2],16,34,
														e[3],16,36,
														e[4],16,38,
														e[5],17,31,
														e[6],17,33,
														e[7],17,35,
														e[8],17,37,
														e[9],15,31,
														e[10],15,33,
														e[11],15,35,
														e[12],15,37,
														e[13],14,36,
														e[14],14,34,
													},
													0,0
													);
									end
									SetS(JY.SubScene,13,32,1,0);
									say("ȥ�μ�ʦ������ϴ�ְɡ�");
								else
									Light();
									say("����ʦ������ϴ�֣��ҿɱ�����ʱ����");
								end
							end
							SceneEvent[58][201]();
							return;
						end
						say("�μ�ʦ����");
						say("���£�",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,0},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						if GetFlag(12005)==3 then
							menu[2][3]=1;
						end
						local r=ShowMenu(menu,5,0,0,0,0,0,1,0);
						if r==1 then
							--say("��ƽ��������Ͼ������ҲѧЩ���֡�",JY.Da);
							RandomEvent(JY.Da);
						elseif r==2 then
							say("��ѧʲô��",JY.Da);
							local kflist={
												{33,10,1},
												{35,10,2},
												{38,10,2},
												{40,10,2},
												};
							LearnKF(0,JY.Da,kflist);
						elseif r==3 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
							if JY.Person[0]["�ȼ�"]<5 then
								say("����",JY.Da);
							else
								say("�����������䣬�D�D�K�K������",JY.Da);
								ModifyWarMap=function()
									SetWarMap(28,28,1,1429*2);
									SetWarMap(29,28,1,1429*2);
									SetWarMap(30,28,1,1429*2);
									SetWarMap(23,23,1,903*2);
									SetWarMap(35,25,1,903*2);
								end
								local result=vs(0,28,20,JY.Da,28,13,2000);
								--[[SetWarMap(28,28,1,0);
								SetWarMap(29,28,1,0);
								SetWarMap(30,28,1,0);
								SetWarMap(23,23,1,0);
								SetWarMap(35,25,1,0);]]--
								Cls();
								ShowScreen();
								if result then
									say("����",JY.Da);
								else
									say("������",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							--say("���������£���ƷһƷʦ�����ס�����ҹ�꡷�ɡ�",JY.Da);
						end
					end
				end,
				[6]=function()	--���
					if JY.Person[0]["����"]==2 then
						say("�����ƺ��кܶ�����ǰ���������ĵá�");
						E_readbook();
					end
				end,
				[7]=function()	--������
					if JY.Person[0]["����"]~=2 then
						say("�˴����Һ�ɽ������֮�������������뿪��",60);
					else
						say("ʦ��������������",JY.Da);
						E_training(JY.Da);
					end
				end,
				[8]=function()	--����
					if JY.Person[0]["����"]~=2 then	--�Ǻ�ɽ����
						say("�����ǳ�����ûʲô�ÿ��ġ�",60);
					elseif JY.Da>0 then
						local menu={
												{"����",nil,1},
												{"�д�",nil,1},
												{"״̬",nil,1},
												{"û��",nil,1},
											};
						local r=ShowMenu(menu,4,0,0,0,0,0,1,0);
						if r==1 then
							say("�����п������İɣ�æ���ˡ�",JY.Da);
						elseif r==2 then
							say("�����ǳ�������������ˣ�ȥ�ұ��ʦ�ֵ��д�ȥ��",JY.Da);
						elseif r==3 then
							PersonStatus(JY.Da);
						elseif r==4 then
							say("û�¾͸Ͻ���ȥ�ɡ�",JY.Da);
						end
					else
						say("���վ����ò��ã�Ӱ�������˵����顣",60);
					end
				end,
				[9]=function()	--��Ϣ
					if JY.Person[0]["����"]==2 then
						local menuItem=	{
														{"��Ϣ",nil,1},
														{"�ݷ�",nil,1},
														{"û��",nil,2},
													}
						local r=EasyMenu(menuItem);
						if r==1 then
							if rest() then
								say("��˯���𣬷�����������Ϊʲô�Ҿ���������Ϥ������");
							end
						elseif r==2 then
							visit(2);
						end
					else
						visit(2);
					end
					walkto_old(-3,0);
				end,
				[201]=function()	--����ϴ��
					--ǰ���,����
					if JY.Person[0]["����"]==0 then
						say("��λʦ�֣������˻�ɽ���ӣ���ʦ�����˹�����ʦ�����ϴ�֡�");
						say("ԭ���ǻ�ɽ������������롣���ˣ���ʦ�������������ù���",JY.Da);
					elseif JY.Person[0]["����"]==1 then
						say("��λʦ�֣���������ǵ��ӣ���ʦ�����˹�����ʦ�����ϴ�֡�");
						say("ԭ�������������������롣���ˣ���ʦ������������ù���",JY.Da);
					--elseif JY.Person[0]["����"]==2 then
					elseif JY.Person[0]["����"]==3 then
						say("��λʦ�֣�������̩ɽ���ӣ���ʦ�����˹�����ʦ�����ϴ�֡�");
						say("ԭ����̩ɽ������������롣���ˣ���ʦ����ʦ���������ù���",JY.Da);
					elseif JY.Person[0]["����"]==4 then
						--��ɽ
						--say("��λʦ�֣������˻�ɽ���ӣ���ʦ�����˹�����ʦ�����ϴ�֡�");
						--say("ԭ���ǻ�ɽ������������롣���ˣ���ʦ�������������ù���",JY.Da);
					elseif JY.Person[0]["����"]==5 then
						--��ɽ
						say("��λʦ�֣���������ɽ���ӣ���ʦ�����˹�����ʦ�����ϴ�֡�");
						say("ԭ������ɽ������������롣ֻ�ǲ�֪��������ʦ��ʦ����ô��û�е���",JY.Da);
						say("���·�ʦ������һ������ʦ���Ժ�㵽��");
						say("ԭ����ˣ�������ʦ����Щ���źá����±�����ʦ��ȥ���ü�����λ���Űɡ�",JY.Da);
						say("���أ�ʦ�������ӭ���������Ͱɡ����¾��ź�ɽ��ɽ������Ҳ���洦���ߣ��������ƺ��������ף�ڡ�");
						say("��ˣ�ʦ����㡣",JY.Da);
						Dark();
							say("�ߣ��������������ϴ�֣���ɽ���н����������࣬���ó��˶����ӣ�ȥ���������С����ץ����");
							JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=14,32,2;
							JY.MyPic=GetMyPic();
							SetS(JY.SubScene,13,32,1,3679*2);
						Light();
						say("����������ȫ���ѹ���");
						say("����ȥ�������������ϴ�ְɡ�");
						SetS(JY.SubScene,13,32,1,0);
					end
					if JY.Person[0]["����"]~=5 and JY.Person[0]["����"]~=2 then
						say("����ʦ������ǰȥ���á�");
						say("���ң�����롣",JY.Da);
					end
					Dark();
						--Ī���������
						ModifyD(58,9,-2,-2,-2,-2,-2,-2,-2,-2,-2,27,2);
						ModifyD(58,10,-2,-2,-2,-2,-2,-2,-2,-2,-2,28,2);
						ModifyD(58,11,-2,-2,-2,-2,-2,-2,-2,-2,-2,29,2);
						ModifyD(58,12,-2,-2,-2,-2,-2,-2,-2,-2,-2,26,3);
						ModifyD(58,13,-2,-2,-2,-2,-2,-2,-2,-2,-2,30,3);
						--������+�������˵ǳ�
						--SetS(JY.SubScene,28,13,1,5188);	--��
						SetS(JY.SubScene,24,16,1,2979*2);	--��
						SetS(JY.SubScene,24,15,1,4261*2);
						SetS(JY.SubScene,24,17,1,2589*2);
						SetS(JY.SubScene,24,20,1,4239*2);	--��
						SetS(JY.SubScene,24,19,1,2597*2);
						SetS(JY.SubScene,24,21,1,2597*2);
						SetS(JY.SubScene,33,16,1,2986*2);	--����
						SetS(JY.SubScene,33,15,1,2588*2);
						SetS(JY.SubScene,33,17,1,2588*2);
						SetS(JY.SubScene,33,20,1,2966*2);	--��
						SetS(JY.SubScene,33,19,1,3022*2);
						SetS(JY.SubScene,33,21,1,3022*2);
						if JY.Person[0]["����"]==0 then
							SetS(JY.SubScene,24,17,1,0);
							JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=24,17,1;
						elseif JY.Person[0]["����"]==1 then
							SetS(JY.SubScene,33,21,1,0);
							JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=33,21,2;
						elseif JY.Person[0]["����"]==2 then
							JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=30,14,3;
						elseif JY.Person[0]["����"]==3 then
							SetS(JY.SubScene,33,17,1,0);
							JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=33,17,2;
						elseif JY.Person[0]["����"]==4 then
							SetS(JY.SubScene,24,21,1,0);
							JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=24,21,1;
						elseif JY.Person[0]["����"]==5 then
							JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=33,22,2;
						elseif JY.Person[0]["����"]==6 then
							
						else
						end
						JY.MyPic=GetMyPic();
					Light();
					if JY.Person[0]["����"]==5 or JY.Person[0]["����"]==2 then
						say("����"..JY.Person[0]["����"].."�μ���λʦ��");
						say("����",1);
					elseif JY.Person[0]["����"]==0 then
						say("���Ӳμ�ʦ����");
						say("�������°ɡ�",1);
					elseif JY.Person[0]["����"]==1 then
						say("���Ӳμ�ʦ����");
						say("�������°ɡ�",27);
					elseif JY.Person[0]["����"]==3 then
						say("���Ӳμ�ʦ����");
						say("�������°ɡ�",66);
					end
					if GetFlag(10004)==1 and JY.Person[0]["����"]==0 then	--����¥����
						say("��ʦ�֣����ӵ�������ͽ�ܣ�",66);
						say("��ǰ�����һ�ɽ��ɽ���룬�ҹ�������пɣ���������ǽ����֪���ŵ��ֺ��д��ʣ�",1);
						say("��ʦ��Ϊ��ǫǫ���ӣ������������С��˼�롣ֻ�ǿ����������µ��Ӳ��Ƕ�����һ����Ӷ��˰���",66);
						say("ʦ�����ҡ���");
						say("������Ϊʦ��������ʦ��˵���������ɲ��죡���ŵ��֣����¼���ͽ����Ȼ���ӣ��������¿�������С�ˣ���֪���ŵ��˴��ԡ���",1);
						say("�ߣ������ͽ�������ա������ˣ�����һ�ˣ���������壬��Ҳ�������£�",66);
						say("������Ϊ������ͽ��",1);
						say("ԭ���⵹�������١������ڳ�������¥�����������ɼ�������������������뽭�������ﲮ��ͬ��һϯ���Ա߻���һ��ɽ���ӣ������Ǳ�������Ю�֡��˶��Ӳ��������������ɣ�ͬ����֦�ķ��ϣ����Ǻ�ɽ���ӣ���Ȼ�������������ֵ��ܣ�����һ�����ߺߣ�����ò����簡��",66);
						say("���д��£����󣡹��£�",1);
						say("ʦ�����������ǡ���");
						say("�ݵýƱ磡�ѻ�ɽ�߽���ұ�һ�飡",1);
						say("�ǡ��������׽���ʦ���棬�����𳤡�������ǿ�����������޹������������ɫ����Ϸ��Ů���Ľ�ͬ�ż��ʣ������ɱ�����������壬͵�Բ�����佾���Դ󣬵���ͬ�����߽��Ľ����࣬������а��");
						say("�ܺð�����Ȼ�㶼�ǵã���Ҳ������ԩ���ˡ������ұ������Ż�������������ͽ��",1);
						say("ʦ�����ҡ���");
						Dark();
						say("����ʦ���������飡",95);
					else
						say("��ʦ�֣���Ϊ��ǫǫ���ӣ������������С��˼�롣ֻ�ǿ����������µ��Ӳ��Ƕ�����һ����Ӷ��˰���",66);
						say("���ŵ��֣����¼���ͽ����Ȼ���ӣ��������¿�������С�ˣ���֪���ԡ���",1);
						say("�ߣ���һ�ˣ���������壬���������£�",66);
						say("������Ϊ������ͽ��",1);
						say("ԭ���⵹�������١������ڳ�������¥�����������ɼ���������壬���뽭�������ﲮ��ͬ��һϯ���Ա߻���һ��ɽ���ӣ������Ǳ�������Ю�֡����Ӳ��������������ɣ�ͬ����֦�ķ��ϣ����Ǻ�ɽ���ӣ���Ȼ�������������ֵ��ܣ�����һ�����ߺߣ�����ò����簡��",66);
						if JY.Person[0]["����"]==1 then
							script_say("���ǣ���ʱ�����ڳ������ɵ������Է��顣")
						end
						say("���д��£������󣬾�Ȼ�������֮�£��������ã�",1);
						Dark();
						say("���������ģ�",95);
					end
					SetS(JY.SubScene,27,22,1,2599*2);
					Light();
					say("���ǣ�",1);
					say("���գ���û�£�",88);
					say("�ǵģ�ʦ������û�¡��������λʦ���Լ�������ľ������Ҳſ������յġ�",95);
					say("����ľ��������������ģ������ٵ�����",88);
					say("�ǣ�ʦ����",95);
					DrawStrBoxWaitKey("���ս�����¥�ľ���һһ����",C_WHITE,CC.Fontbig);
					say("Ŷ���˻����档",1);
					say("���Ÿ�λʦ�岮���棬�������ϣ����Ӳ���ڿ�",95);
					say("�ǲ�֪������ͽ�������ںδ���",1);
					say("�����������������ˣ��ڱ���֮�������ԣ�����ֻ�ý�������һ��ȫ֮�����������ˡ��ոյ����Ͻ�����ʦ���ѵ����������ȸ����ݼ�ʦ���ˡ�",95);
					if true and JY.Person[0]["����"]==0 then	--����¥����
						say("������ˣ��������Ҵ�������ǡ������ɡ�",1);
						say("лʦ����");
					else
						say("������ˣ��������Ҵ��������",1);
					end
					say("��ʦ�֣���������һƬ֮�ԣ������ͽ��������ʵ�����ã��������¡�",66);
					say("���Ҳ��ҡ�����ʦ�ּ�������д˷�Ӧ������Ҳ�������������ɣ�ͬ����֦�����䲻�������һ�ɽ֮������һ�����˷�ȭȭΪ�һ�ɽ֮�ģ���ĳ��л�����������θ��Թ֣�",1);
					say("��ʦ�ֿ����ˡ�",66);
					say("�ߣ���һ����г��ͬ��֮�갡���ߣ�",27);
					say("��������ǡ���",1);
					say("����ͽ�ܣ�����������������ɵ��ӵ��鷳�������ڻ���¥�б����ֶΣ�ɱ�ҵ��ӡ���ô����������˵�ˣ�",27);
					say("������԰����ꡣ��ɽ������޶񽻣������˷����飬��������Ե�ɣ������������������ɲ��ϣ�����ֻ�������ߺޣ����߿찡��",88);
					if JY.Person[0]["����"]==1 then
						script_say("���ǣ���᣿�����ɱ��ʦ�����Ǿ���һ��������£���һ���������ɰ�����һ��ͬ����֦����");
					else
						say("��᣿�����ɱ�ҵ������Ǿ���һ��������£���һ���������ɰ�����һ��ͬ����֦����",27);
					end
					say("���ǵġ�������֮����ɱ��λ��ǵ�ʦ�֣�����Ϊ�����������������ˣ���Ҫ�û�����������û������ɱ�����ġ�",95);
					say("��������㿴�⡭��",1);
					if JY.Person[0]["����"]==1 then
						script_say("���ǣ��ߣ������������ɣ�ͬ����֦������˵��ʲô������ʲô��")
						script_say("��׺�������������СС���һ�ۣ����Ҷ��������ɶ����������˵��������Ҳֻ��ʹ����ֻ�л�ɽ���ӲŻ����Ǿ�ѧ�ˡ�")
					else
						say("�ߣ������������ɣ�ͬ����֦����СС���һ�ۣ������������ԡ�����˵��������Ҳֻ��ʹ����ֻ�л�ɽ���ӲŻ����Ǿ�ѧ�ˡ�",27);
					end
					say("ˡ���²�������������ԡ�",1);
					say("�ߣ����������ǻ�ɽ����һ����еġ���",27);
					Dark();
						SetS(JY.SubScene,29,22,1,4479*2);
						say("ƨ�����ƽɳ����ʽ��",8);
					Light();
					if JY.Person[0]["����"]==0 then
						say("��ʦ�֣�");
					end
					say("�����磡",95);
					say("��������壬�ݼ�ʦ�����Լ���λʦ��ʦ�塣",8);
					say("���������ˣ�",1);
					say("��ʦ�������ӵ����Ѿ����ˡ����ˣ�����ʦ������л��ɽ�鵤��ҩ����Ȼ����Ҳ�����ָܻ������֮�졣",8);
					say("���ء�˵������ƶ�ỹҪлл����ҵ����ء�",88);
					say("������������ͬ����֦������ʦ�����ѣ���Ȼ���ܲ��ܡ�",8);
					say("�ߣ�",27);
					say("���ˣ���������ո���˵����һ�㣬��ƨ�����ƽɳ����ʽ����һֱ��������ɵľ�ѧ���������һ�ɽ���ӣ���ʹ�������ġ�",8);
					say("�㣡",27);
					say("���ˣ����������ĳ����ǰ����һ���ӣ���������ĸ�����ɷ�������͡������ô�����������͵ģ���ϧСͽ˼���������̶�����������ܳ���֮��������һ�ҹ������ס�",1);
					say("�ߣ��Ҳ�֪��ʲô��ʲô�������ɷ��������ţ������Ǳ�ĳЩС�˸�ڿ�˰ɡ�",27);
					say("���˵���ҵ����������Ǳ�������ɵ��˸�ץ���ˣ����ǻ����Ҹ����ھ�ȫ�ң�",136);
					say("Сͽһʱ���ߣ���������֮���������ţ�������������¡���ȥ��ŷ֣����Ǹ�ĸ֮�ԣ��������٣������������̧���֡�",1);
					say("��˵���ڱ��ǲ��ڣ�",27);
					say("����������������Ǳ��䡭��",8);
					say("��������׺����Ҹ���ƴ�ˣ�����",136);
					say("���ӷ�����",27);
					Dark();
						SetS(JY.SubScene,28,13,1,5188);	--��
						SetS(JY.SubScene,27,22,1,0);
						SetS(JY.SubScene,29,22,1,0);
						SetS(JY.SubScene,24,14,1,4224*2);
						say("��λ��λ��������ĳһ�ԡ�",50);
					Light();
					say("�����ǲ������½���ϴ��֮�գ�������λ�������µı����ϣ������ԵĶ�Թ���ҷ��¡�",50);
					say("����ĳʧ���ˡ������ƽ֮���������������Ǹ��",1);
					say("��ʦ��������������е����Ǹ�ˡ�",8);
					say("�������",136);
					say("�ߣ�",27);
					say("��л��λ���顣����ʱ�̽�������Ȼ��ɽ�ĸ�λʦ�ֻ�û�������ǿ���Ҳ�Ȳ����ˡ�",50);
					say("��λ����λ�����ɸ�λӢ�ۿ�������������СС�ĵ���֮��������ϴ��֮����ĳ��ʤ�м�����ĳ����������֮���ٲ����뽭��֮�£��ʹ����ӣ������̸̸���֣�����˹������ף�",50);
					--ϴ�� ����
					Dark();
						SetS(JY.SubScene,28,15,1,2603*2);
						SetS(JY.SubScene,31,17,1,2603*2);
						SetS(JY.SubScene,31,19,1,2603*2);
						SetS(JY.SubScene,31,21,1,2603*2);
						SetS(JY.SubScene,26,17,1,2603*2);
						SetS(JY.SubScene,26,19,1,2603*2);
						SetS(JY.SubScene,26,21,1,2603*2);
						SetS(JY.SubScene,28,27,1,2603*2);
						SetS(JY.SubScene,29,27,1,2603*2);
						SetS(JY.SubScene,23,23,1,2601*2);
						SetS(JY.SubScene,35,25,1,2604*2);
						say("�������������쵽��",113);
					Light();
					say("������������������ݻ�ϴ�֣�����죡",113);
					say("�⡭��ϴ��֮�£���������֪����������ˣ�һֱû�еõ���Ӧ���ιʽ���ͻȻ������������ֹ�����أ�",50);
					say("����Ե�ɣ��Ժ��Ի��˵��",113);
					if GetFlag(12001)==2 then
						say("С�ӣ��ҷԸ�����£�������ã�",113);
						say("............");
						say("............",50);
						say("����������С�ӻ�������������ʱ��",113);
						JY.Person[0]["����"]=5;
					end
					if JY.Person[0]["����"]==5 then
						SmartWalk(29,15,2);
						say("��˽�ʦ�壬�ո��Ѿ�............");
						say("֪���ˣ������ĺܺá�",113);
						if GetFlag(12001)==2 then
							say("�ҿ�����Ҳû�취�ں�ɽ�����ˣ�����һ�ˣ������һ���ɽ�ɡ�",113);
							say("............");
									JY.Person[0]["����"]=5;
									JY.Shop[5]["����ʱ��"]=GetFlag(1);
									DrawStrBoxWaitKey(JY.Person[0]["����"].."�������ɽ��",C_WHITE,CC.Fontbig);
									JY.Person[0]["���"]="��ɽ����";
						end
					else
						Dark();
							SetS(JY.SubScene,29,15,1,2604*2);
						Light();
						say("��˽�ʦ�壬�ո��Ѿ�............",123);
						say("֪���ˣ�����ȥ�ɡ�",113);
						Dark();
							SetS(JY.SubScene,29,15,1,0);
						Light();
					end
					say("�š����������������˽ͨħ�̣�������������ͬ�ˣ��������������£�",113);
					say("�㣡",50);
					say("˽ͨħ�̣��⡭���ⲻ̫���ܰɣ� ",66);
					say("���»���˵���Ϊ�ã��������ˣ���������������֮��ĺ�����",88);
					say("��֪��ʦ�ֿ���֤�ݣ���տ���ƾ�ģ�Ī�������Ų��ԣ�",1);
					say("��Ȼ���Ǻ���֤�ݡ����λ�Եȡ�",113);
					if GetFlag(12001)==1 then
					
						script_say("���ǣ���ʦ�壬��������ڵ����õ���Щ��ɽ���ӵĻ����������ǵȲ����ˡ�");
						script_say("�ѱ򣺣������㣡����");
						script_say("���ǣ�����ɽ�ɺεȾ��ģ���Ȼ׼��Ю����ʦ���ļ���������ʦ���ͷ���");
						script_say("�ѱ��ݵ��ſڴƻƣ�С�����ƣ�");

					else
						Dark();
							SetS(JY.SubScene,28,15,1,5002*2);
							SetS(JY.SubScene,28,14,1,3679*2);
						Light();
						say("��ʦ�֣������Ǻ��⣿",50);
						say("û��ʲô��������˼��ֻ��ϣ����ʦ���ܹ�����ʵʵ�ش���һ��������ѡ��㣬�ϲ���ʶħ�̳�������",113);
						say("����������Ѿ���Ӧ�Ҳ��ٲ���ħ��֮���ˣ������ֺο��������أ�",50);
						say("ħ�����ˣ���������˿�������档��ʦ�֣�������˵�ˣ�ֻҪɱ������һ�ж��������̡�",113);
						say("����",50);
						say("��ʦ�ܣ���ֻ��Ҫ��һ��ͷ����ĳ�������������Ǹ�ħͷ��",1);
						say("������л��ʦ�ֺ��⡣ֻ������������֪�����󡣶������������������壬�Ҳ��ܳ�������",50);
						say("������ˣ��Ǿ��ݹ��������ˡ����֣�",113);
						SetS(JY.SubScene,28,14,1,0);
						lib.FillColor(0,0,CC.ScreenW,CC.ScreenH,C_RED,128);
						ShowScreen();
						lib.Delay(80);
						lib.ShowSlow(50,1);
						DrawStrBoxWaitKey("��ɽ���ӽ���������ɱ��",C_WHITE,CC.Fontbig);
						say("�㣡�Ҹ���ƴ�ˣ�",50);
						say("���úã�",113);
					end
					ModifyWarMap=function()
									SetWarMap(24,14,1,0);
									SetWarMap(24,15,1,0);
									SetWarMap(24,16,1,0);
									SetWarMap(24,17,1,0);
									SetWarMap(24,19,1,0);
									SetWarMap(24,20,1,0);
									SetWarMap(24,21,1,0);
									SetWarMap(33,15,1,0);
									SetWarMap(33,16,1,0);
									SetWarMap(33,17,1,0);
									SetWarMap(33,19,1,0);
									SetWarMap(33,20,1,0);
									SetWarMap(33,21,1,0);
									
									SetWarMap(28,13,1,0);
									SetWarMap(28,15,1,0);
									SetWarMap(31,17,1,0);
									SetWarMap(31,19,1,0);
									SetWarMap(31,21,1,0);
									SetWarMap(26,17,1,0);
									SetWarMap(26,19,1,0);
									SetWarMap(26,21,1,0);
									SetWarMap(28,27,1,0);
									SetWarMap(29,27,1,0);
									SetWarMap(23,23,1,0);
									SetWarMap(35,25,1,0);
					end
					local r=FIGHT(
										1,11,
										{
											50,28,13,
										},
										{
											113,28,15,
											120,31,17,
											123,31,19,
											125,31,21,
											121,26,17,
											124,26,19,
											126,26,21,
											127,28,27,
											128,29,27,
											129,23,23,
											122,35,25,
										},
										0,0,3
									);
					if r then
						if JY.Person[0]["����"]==5 then
							JY.Status=GAME_END;
							return;
						end
						Dark();
							SetS(JY.SubScene,31,17,1,0);
							SetS(JY.SubScene,31,19,1,0);
							SetS(JY.SubScene,31,21,1,0);
							SetS(JY.SubScene,26,17,1,0);
							SetS(JY.SubScene,26,19,1,0);
							SetS(JY.SubScene,26,21,1,0);
							SetS(JY.SubScene,28,27,1,0);
							SetS(JY.SubScene,29,27,1,0);
							SetS(JY.SubScene,23,23,1,0);
							SetS(JY.SubScene,35,25,1,0);
						Light();
						say("�벻�������ŵ����и��ֲ��ٰ���",113);
						say("�������ɵ�����������繴��ħ�̣������������ˣ���ó�����׽�������磡",113);
						say("��......",1);
						Dark();
							SetS(JY.SubScene,28,14,1,6208*2);
							say("��ɽ֮�ˣ���Ȼ�ɺ�ɽ���������ᡣ",49);
						Light();
						say("�ߣ�Īʦ�ֵ���˼��������ӲҪ�������ˣ�",113);
						say("����",49);
						JY.Person[49]["����"]=JY.Person[49]["����"]+30;
						JY.Person[49]["��"]=JY.Person[49]["��"]+30;
						ModifyWarMap=function()
									SetWarMap(28,14,1,0);
									SetWarMap(24,14,1,0);
									SetWarMap(24,15,1,0);
									SetWarMap(24,16,1,0);
									SetWarMap(24,17,1,0);
									SetWarMap(24,19,1,0);
									SetWarMap(24,20,1,0);
									SetWarMap(24,21,1,0);
									SetWarMap(33,15,1,0);
									SetWarMap(33,16,1,0);
									SetWarMap(33,17,1,0);
									SetWarMap(33,19,1,0);
									SetWarMap(33,20,1,0);
									SetWarMap(33,21,1,0);
									
									SetWarMap(28,13,1,0);
									SetWarMap(28,15,1,0);
									SetWarMap(31,17,1,0);
									SetWarMap(31,19,1,0);
									SetWarMap(31,21,1,0);
									SetWarMap(26,17,1,0);
									SetWarMap(26,19,1,0);
									SetWarMap(26,21,1,0);
									SetWarMap(28,27,1,0);
									SetWarMap(29,27,1,0);
									SetWarMap(23,23,1,0);
									SetWarMap(35,25,1,0);
						end
						vs(113,28,15,49,28,14,0);
						JY.Person[49]["����"]=JY.Person[49]["����"]-30;
						JY.Person[49]["��"]=JY.Person[49]["��"]-30;
						SetS(JY.SubScene,28,15,1,0);
						Cls();
						lib.FillColor(0,0,CC.ScreenW,CC.ScreenH,C_RED,128);
						ShowScreen();
						lib.Delay(80);
						lib.ShowSlow(50,1);
						say("�󡭡���ʦ�ֲ��ᡭ���Ź����ǵġ���",113);
						say("����",113);
						say("�����ӷ𡭡�",88);
						say("Īʦ�֣��⡭��",1);
						if JY.Person[0]["����"]==2 then
							say("��λʦ�岮����λ�ֵܡ����н�����С��������ʦ��ϴ��֮ʱ�������������졣���Ǳ�������ʦ���������У�����Ȼ���˸�λ�����£��Ҵ����ɽ���ӣ����λ��һ����Ǹ�ˡ�");
						else
							say("��λʦ�岮����λ�ֵܡ����н�����С��������ʦ��ϴ��֮ʱ�������������졣���Ǳ�������ʦ���������У�����Ȼ���˸�λ�����£��Ҵ����ɽ���ӣ����λ��һ����Ǹ�ˡ�",52);
						end
						say("�⡭��",66);
						say("�����ӷ��޺�ŭ����������֣����֡�",88);
						say("������ˡ����������ˣ���С֮�����˵Ƚ���������֪���������Ǳ�Īʦ�ֻ��У���֪�Ժ�Ҫ���������ˡ�ֻ�ǣ���ʦ��������",1);
						say("����ʦ�֣����ҶԲ����㣬�Բ����ɽ����",50);
						say("�������֪�",49);
						say("���������˺�ɽ���ˣ�������졣",50);
						say("���֪����Ըõ�����",49);
						say("�����Ϸ�����ʦ�ַ��䡣",50);
						say("�������Һ�ɽ�������ţ��ӽ��Ժ������粻�����Һ�ɽ���ӣ��ҽ��ս������ʦ�ţ�����һ�в������Һ�ɽ���κιϸ�",49);
						say("���������⣡������");
						say("������л����лʦ�ֶ��䣡����",50);
						say("�������ա�",88);
						say("������ã�������ð���",66);
						say("Īʦ�ִ�������һ������ĳ�����",1);
						say("���������������£���������ȥ���Ҳ���������ɼ������ں�ɽ��",49);
						if JY.Person[0]["����"]==2 then
							say("�����˶�ֻ������ʦ����ʦ�����ϣ�û�뵽����ʦ��Ϊ��ʦ����Ȼ������˹�ز�������");
							say("�㡣",49);
							say("�����ڣ�");
							say("�ܲ�����Ը�������£�",49);
							say("������");
							say("����������ߵлʦ����Ī�����Ŷ��䣡",50);
							say("���ӡ����ݼ�ʦ����");
						end
						Dark();
							SetS(JY.SubScene,28,14,1,0);
						Light();
						say("�����¶࣬������ţ���ĳ�ʹ˸���ˡ�",1);
						say("��л���������ţ�ֻ�Ƕ��в��㣬ˡ��Զ�͡�",50);
						say("ƶ��Ҳ����ɽ�ˡ�",88);
						say("ʦ̫���ء�",50);
						say("��������ౣ�ء�",66);
						say("��л����ǡ�",50);
						Dark();
							SetS(JY.SubScene,24,14,1,0);
							SetS(JY.SubScene,24,16,1,0);	--��
							SetS(JY.SubScene,24,15,1,0);
							SetS(JY.SubScene,24,17,1,0);
							SetS(JY.SubScene,24,20,1,0);	--��
							SetS(JY.SubScene,24,19,1,0);
							SetS(JY.SubScene,24,21,1,0);
							SetS(JY.SubScene,33,16,1,0);	--����
							SetS(JY.SubScene,33,15,1,0);
							SetS(JY.SubScene,33,17,1,0);
							SetS(JY.SubScene,33,20,1,0);	--��
							SetS(JY.SubScene,33,19,1,0);
							SetS(JY.SubScene,33,21,1,0);
						if JY.Person[0]["����"]==2 then
							Light();
							say("ʦ������");
							say("������ˡ�����ʦͽԵ���Ѿ���Ϊʦ�����ң�Ҳû��ʲô������ģ������Һ�����������һ�����ף�ϣ�����Ժ��ܹ��ҵ����Խ�������������ˡ�",50);
							say("��лʦ������л�����Ժ��пգ���������ʦ������ġ�");
							say("���ı�á�",50);
							Dark();
						end
						say("ʦ������");
							SetS(JY.SubScene,28,13,1,0);
							ModifyD(58,9,-2,-2,-2,-2,-2,-2,-2,-2,-2,27,12);
							ModifyD(58,10,-2,-2,-2,-2,-2,-2,-2,-2,-2,28,12);
							ModifyD(58,11,-2,-2,-2,-2,-2,-2,-2,-2,-2,29,12);
							--ModifyD(58,12,-2,-2,-2,-2,-2,-2,-2,-2,-2,26,3);
							ModifyD(58,13,-2,-2,-2,-2,-2,-2,-2,-2,-2,30,13);
						Light();
						SetFlag(12005,3);
						SetFlag(12006,2);
					else
						say("�������ɣ�",113);
						Dark();
							say("�ߣ�",150);
							SetS(JY.SubScene,28,13,1,0);
						Light();
						say("�������ߣ�",113);
						Dark();
							SetS(JY.SubScene,28,15,1,0);
						Light();
						say("�⡭���������Ǻã�",66);
						say("��������Ҳ�߲�Զ���������Ǹ�ǲ���µ��ӣ�ȥѰ��һ����Σ�",1);
						say("ֻ������ˡ�",88);
						script_say("��׺������������������£������������֣��ʹ˸�ǣ�");
						--Dark();
						
						if JY.Person[0]["����"]==1 then
							script_say("���ǣ�ʦ�����ҿ��������һ�������Ǳ�ȥ�ˣ����롭��");
							script_say("��׺������ǻعۣ���������Ĵ������������д裬�೤��ʶ��");
							script_say("���ǣ�лʦ����ȫ��");
						elseif JY.Person[0]["����"]==5 then
							say("����Ͼ��Ǻ�ɽ�����ڣ�ʦ�嵥��һ�ˣ�δ��Σ�գ��øϽ�ȥ��æ����");
							--Dark();
								JY.Base["��X1"],JY.Base["��Y1"],JY.Base["�˷���"]=30,50,3;
								JY.MyPic=GetMyPic();
							--Light();
						end
						Dark();
							SetS(JY.SubScene,31,17,1,0);
							SetS(JY.SubScene,31,19,1,0);
							SetS(JY.SubScene,31,21,1,0);
							SetS(JY.SubScene,26,17,1,0);
							SetS(JY.SubScene,26,19,1,0);
							SetS(JY.SubScene,26,21,1,0);
							SetS(JY.SubScene,28,27,1,0);
							SetS(JY.SubScene,29,27,1,0);
							SetS(JY.SubScene,23,23,1,0);
							SetS(JY.SubScene,35,25,1,0);
							SetS(JY.SubScene,24,14,1,0);
							SetS(JY.SubScene,24,16,1,0);	--��
							SetS(JY.SubScene,24,15,1,0);
							SetS(JY.SubScene,24,17,1,0);
							SetS(JY.SubScene,24,20,1,0);	--��
							SetS(JY.SubScene,24,19,1,0);
							SetS(JY.SubScene,24,21,1,0);
							SetS(JY.SubScene,33,16,1,0);	--����
							SetS(JY.SubScene,33,15,1,0);
							SetS(JY.SubScene,33,17,1,0);
							SetS(JY.SubScene,33,20,1,0);	--��
							SetS(JY.SubScene,33,19,1,0);
							SetS(JY.SubScene,33,21,1,0);		
							ModifyD(58,9,-2,-2,-2,-2,-2,-2,-2,-2,-2,27,12);
							ModifyD(58,10,-2,-2,-2,-2,-2,-2,-2,-2,-2,28,12);
							ModifyD(58,11,-2,-2,-2,-2,-2,-2,-2,-2,-2,29,12);
							--ModifyD(58,12,-2,-2,-2,-2,-2,-2,-2,-2,-2,26,3);
							ModifyD(58,13,-2,-2,-2,-2,-2,-2,-2,-2,-2,30,13);				
						Light();
						SetFlag(12005,2);
					end
					JY.Person[50]["����"]=-1;
					SetS(58,48,55,3,202);
					SetS(58,49,55,3,202);
				end,
				[202]=function()
					if JY.Person[0]["��Ե"]>75 and (JY.Person[0]["����"]==0 or JY.Person[0]["����"]==1) then
						SetFlag(16004,GetFlag(1));	--��¼����������ʱ��
						--SetS(57,27,29,3,201);	--������ɽ��ƽ֮��ʦ���������¼�
						say("�ţ����ﴫ�������������ҹ�ȥ������");
						JY.SubScene=62;
						lib.ShowSlow(50,1);
						JY.Base["��X1"],JY.Base["��Y1"]=44,25;
						JY.Base["�˷���"]=2;
						SetS(JY.SubScene,17,18,1,3512*2);
						SetS(JY.SubScene,18,18,1,4425*2);
						Init_SMap(1);
						
						if JY.Person[0]["����"]==1 then
							SetFlag(16003,2);
							MoveSceneTo(21,19);
							script_say("���ǣ������ǣ�������������ү����վ������ߵġ���������������˵ʲô����");
							Dark();
							JY.SubSceneX,JY.SubSceneY=0,0;
							Light();
--������͵���У�
							SmartWalk(19,15,3);
							script_say("�����ϣ����ˣ��˴�����Ҳ������ȫ�����ǻ��ǿ�Щ��ȥ�ɡ�");
							script_say("�ַ��ˣ�����ƽ֮������");
							script_say("�����ϣ���˵�������˻�ɽ���ӽ������ŵ����£��㻹��ʲô�õ��ĵ��أ�");
							script_say("�ַ��ˣ������ҡ���");
							script_say("�����ϣ����ˣ�����ĥ���ˡ���������ɵ����Ѿ��뿪�����ˣ��������ʱ��ɱ��ȥ������������լ�ġ�������ȡ������");
							script_say("�ַ��ˣ�ƽ֮����");
							script_say("���ǣ�����������լ�����������ѱ���Ҳ�����ҵ��ǡ���а���ס������ѵ��л��ذ���һ˵�����У��ҵ��ٱ����������");
--�����ǳ��ȥ��
							Dark();
							JY.Base["��X1"],JY.Base["��Y1"]=18,21;
							JY.Base["�˷���"]=0;
							JY.MyPic=GetMyPic();
							Light();
							script_say("���ǣ�������ͷ����������");
							script_say("�����ϣ��ɶ񣬱�׷���ˣ����ˣ�����ߣ���������һ����");
							script_say("���ǣ�����������");
--���׹�һ���������ϵ��أ�
							ScreenFlash(C_WHITE);
							script_say("�ַ��ˣ���ү��");
							script_say("���ǣ����ģ�����û����������Ϊ�����ʳ�Сү����֪���Ĵ𰸣����ˣ����������");
							ScreenFlash(C_WHITE);
							script_say("�����ϣ����ˣ�");
--���׹�һ�����ַ��˵��أ�
							script_say("���ǣ�������ͷ�������ֻ�������˶��ѡ�����������ʱ��ҽֹѪ�����»�Ѫ����������ֻҪ��ϹԹԵĻش���һ�����⣬�Ҿͷ�������ȥ����Σ�");
							script_say("�����ϣ�����Ҳ��������㡶��а���ס�������ģ�");
							script_say("���ǣ��ã�����Ҳ�����������ֻ���㣬������������լ��������Բض�����");
							script_say("�����ϣ��㣡�㣡��͵�����ˣ�");
							script_say("���ǣ��ҿɲ��ǹ���ģ�����˵����������һ�㡣���ˣ���ĥ���ˣ���˵��");
							script_say("�����ϣ�����");
							script_say("���ǣ���˵���Ǿ�ֻ��������˰�æȰȰ���ˣ�");
							Dark();
--����������
							script_say("����壺ס�֣�");
							SetS(JY.SubScene,20,20,1,4256*2);
							Light();
--���������֣�
							script_say("���ǣ������ӵģ������㣡������������");
							ModifyWarMap=function()
								SetWarMap(17,18,1,0);
								SetWarMap(18,18,1,0);
								SetWarMap(20,20,1,0);
								SetWarMap(22,23,1,851*2);
							end
							if not vs(0,18,18,8,21,23,0) then
								JY.Status=GAME_END;
								return;
							end
--������VS����壬����GAMEOVER��
							script_say("���ǣ������������ɣ�");
							Dark();
--����������
							script_say("����ɺ��������˵��ʦ����ô����׷�����������Ƕ������Ų����������ˡ�");
							lib.FillColor(0,0,0,0,0);
							script_say("����Ⱥ��������������ʲô�£�������Ҳ˵������");
							lib.FillColor(0,0,0,0,0);
							script_say("���ǣ�����Ⱥ���ߣ���������");
							SetS(JY.SubScene,17,18,1,0);
							SetS(JY.SubScene,18,18,1,0);
							SetS(JY.SubScene,20,20,1,0);
--�������뿪�ǽ���
							JY.Status=GAME_MMAP;

		--lib.PicInit();
							CleanMemory();
							lib.ShowSlow(50,1)

							if JY.MmapMusic<0 then
								JY.MmapMusic=JY.Scene[JY.SubScene]["��������"];
							end

							Init_MMap();



							JY.SubScene=-1;
							JY.oldSMapX=-1;
							JY.oldSMapY=-1;

							lib.DrawMMap(JY.Base["��X"],JY.Base["��Y"],GetMyPic());
							lib.ShowSlow(50,0)
							lib.GetKey();
							script_say("���ǣ����������ǻ���ˣ������������Ⱥ������˵���������ڶ�������������Ȼ����ƽ֮���뻪ɽ������ҲӦ�ø������ˡ�����һ���������Ͽ϶��Ὣ�ؽ���֮���������ġ�֮��ֻҪ�����ǱƳ��������ڣ����ߵ���ȡ����֮ʱ��ȡ���׾����ˡ���");
--�����ɽ����
--������� ������
						elseif JY.Person[0]["����"]==0 then
							SetFlag(16003,1);
							SetS(JY.SubScene,18,20,1,4946*2);
							MoveSceneTo(21,19);
							script_say("��׺�����˵���Ǳ�а���ײ��ںδ���");
							script_say("�����ϣ��ҡ����ּҡ�����а����������Ϊ�����ڴ����������С������н��ס������¡���");
							script_say("��׺���������ͷ������Ӳ���ҵ�Ҫ���㻹��֧�ֶ�ã�");
							Dark();
								script_say("����壺ס�֣�");
								lib.FillColor(0,0,0,0,0);
								say("��ʦ�֣���Ҳ���ˣ�")
								JY.Base["��X1"],JY.Base["��Y1"]=19,22;
								JY.Base["�˷���"]=0;
								JY.MyPic=GetMyPic();
								SetS(JY.SubScene,20,20,1,4256*2);
								JY.SubSceneX,JY.SubSceneY=0,0;
							Light();
--������VS��׺�������GAMEOVER��
							ModifyWarMap=function()
								SetWarMap(17,18,1,0);
								SetWarMap(18,18,1,0);
								SetWarMap(18,20,1,0);
								SetWarMap(20,20,1,0);
								SetWarMap(22,23,1,851*2);
							end
							FIGHT(
										2,1,
										{
											0,19,22,
											8,21,20,
										},
										{
											27,18,18,
										},
										0,0
									);
							script_say("��׺��������������������Ż��Ҵ��£��浱�Ҳ�ɱ��ô����������");
--����������
							Dark();
							script_say("����ɺ��������˵��ʦ�ֺ�ʦ����ô����׷�����������Ƕ������Ų������ǰ����ˡ�");
							lib.FillColor(0,0,0,0,0);
							script_say("����Ⱥ����������������ʲô�£�������Ҳ˵������");
							lib.FillColor(0,0,0,0,0);
							script_say("��׺����ߣ���������������������");
							SetS(JY.SubScene,18,20,1,0);
							Light();
--����׺���ʧ��
							script_say("���ǣ��Һ�ʦ���������ˣ���Ȼ����");
							script_say("����壺�ǰ���������ͷ���ַ��ˣ����ǡ���");
							script_say("�����ϣ��ҡ��������ǡ��������ˡ�����������������С�������ǡ������ݡ������������լ�����Ķ�����������������ԡ����ԡ������á�����������");
							script_say("����壺�������ˡ�");
							script_say("�����ϣ�л����");
							script_say("�ַ��ˣ�����");
							script_say("���ǣ���ʦ�֣���λ�����Ѿ�����");
							script_say("����壺��λ�Ѿ����ˡ���");
--����������
							Dark();
								SetS(JY.SubScene,20,20,1,0);
								SetS(JY.SubScene,23,23,1,4224*2);
								SetS(JY.SubScene,25,23,1,2982*2);
								SetS(JY.SubScene,26,22,1,2592*2);
								SetS(JY.SubScene,27,22,1,2592*2);
								SetS(JY.SubScene,28,22,1,2592*2);
								SetS(JY.SubScene,26,24,1,2592*2);
								SetS(JY.SubScene,27,24,1,2592*2);
								SetS(JY.SubScene,28,24,1,2592*2);
								JY.Base["��X1"],JY.Base["��Y1"]=23,24;
								JY.Base["�˷���"]=1;
								JY.MyPic=GetMyPic();
								script_say("����Ⱥ�������");
--����ɽ���˳��֣�
							
							Light();
							script_say("��ƽ֮�������");
							script_say("����Ⱥ�������������ô���£�");
							script_say("����壺ʦ�����ո�����ʦ�����ˣ���������׺����ڱ���������ͷ�򸾱�а���׵����䣬����ʦ�ܶ��˺���Ҳ����������������Ҫ��ɱ�ֵ�ʱ���Һ�ʦ����ʱ�ϵ������������ˡ���������ͷ��������̫�ء������ԡ���");
							script_say("����Ⱥ������׺���Ϊһ��֮������Ȼ�����������֮�¡�");
							script_say("���ǣ��´μ�������һ��Ҫ����֪���һ�ɽ������������");
							script_say("����壺���ˣ���ʦ�ܣ��㸸������ת���㡭����˽�");
							script_say("��ƽ֮������лл��ʦ�֡���");
							script_say("����Ⱥ��ƽ֮����Ȼ����ʱ�ˣ������һ�����Ҫ����һ�ʣ���ʬ����׼������");
							script_say("��ƽ֮����ϣ���ܽ�������ظ��ݡ���");
							script_say("����Ⱥ���ɸ������һ�ɽ����ͬ·����ȥ���ǡ���");
							script_say("���ǣ�ʦ�������罫��λ�͵ػ𻯣�����ǻҴ��ػ�ɽ���պ���ʦ�ܻظ���֮ʱ���ٴ���ȥ�ɺã�");
							script_say("����Ⱥ�����֣�����Ϊ�����ɷ���ʬ��");
							script_say("��ƽ֮�������Ͱ�ʦ����˵�����ɡ���");
							script_say("����Ⱥ��������");
								SetS(JY.SubScene,23,23,1,0);
								SetS(JY.SubScene,25,23,1,0);
								SetS(JY.SubScene,26,22,1,0);
								SetS(JY.SubScene,27,22,1,0);
								SetS(JY.SubScene,28,22,1,0);
								SetS(JY.SubScene,26,24,1,0);
								SetS(JY.SubScene,27,24,1,0);
								SetS(JY.SubScene,28,24,1,0);
							JY.Status=GAME_MMAP;

		--lib.PicInit();
							CleanMemory();
							lib.ShowSlow(50,1)

							if JY.MmapMusic<0 then
								JY.MmapMusic=JY.Scene[JY.SubScene]["��������"];
							end

							Init_MMap();
							JY.SubScene=-1;
							JY.oldSMapX=-1;
							JY.oldSMapY=-1;

							lib.DrawMMap(JY.Base["��X"],JY.Base["��Y"],GetMyPic());
							lib.ShowSlow(50,0)
							lib.GetKey();
						end
					else
						SetS(58,48,55,3,-1);
						SetS(58,49,55,3,-1);
						return true;
					end
				end,
			}
						--say("")SceneEvent[6]={};
SceneEvent[6]={
				[200]=function()
					JY.SubScene=7
					JY.Base["��X1"],JY.Base["��Y1"]=31,59
					lib.ShowSlow(50,1);
					Init_SMap(1);
				end,
				[201]=function()
					JY.SubScene=8
					JY.Base["��X1"],JY.Base["��Y1"]=4,27
					lib.ShowSlow(50,1);
					Init_SMap(1);
				end,
			}SceneEvent[62]={};--����/��ɽ���ڸ��¼�
SceneEvent[62]={
				[211]=function()--�����normal
					say("�Ǳߵ�С�ѣ���������һ·����֪�кμ��̣�",3);
					say("С�Ӹոչ۷��ʦ����������˳��ԣ������԰Ρ���β�����ˣ�ֻԸ����ʦ�����£�ϰ���ϳ˽�����");
					say("Ŷ����Ը��������ܾ����£�",3);
					say("ʤ����һʱ֮�����ѡ��ҹ��ǻ�ɽ���²�������Ⱥ������������ˡ���������Ⱥ��α���ӣ������ֻһ���ӣ����˲��ԣ���ʮ����������ˣ����ҽ������˿�Ϊ֮�С���ʱ�ҽ����Կɾ���������");
					say("�����뷨����ֻ�ǣ��������ģ���Ը������ִ������Ը�⣬������Ѱ��ѧϰ��������ʦ֮���ݵ����ᡣ",3);
					say("�ǡ�");
					SetS(62,9,21,3,212);
				end,
				[212]=function()--�����normal
					say("�ҽ��ڽ�������ǳ��������ʶ��ʶ��",3);
					say("�����ʦָ�̡�");
					local kflist={
									{7,10},
									{8,10},
									{17,10},
								};
					LearnKF(0,3,kflist);
				end,
				[100]=function()--����ħ������
					if JY.Person[0]["����"]>=0 then
						say("ԭ����������ﰡ���������ɣ�");
						if vs(0,39,26,JY.Da,38,22,500,0) then
							ModifyD(38,18,0,-2,0,0,-2,0,0,0,0,-2,-2);
							MyQuest[1]=2;
						else
							JY.Status=GAME_END;
						end
					end
				end,
				[11]=function()--
				end,
				[201]=function()	--Χ���ﲮ��
					SetS(62,50,25,3,-1);
					SetS(62,50,26,3,-1);
					if JY.Person[0]["����"]==0 then
						Dark();
							SetS(62,44,24,1,2590*2);
							SetS(62,44,26,1,2591*2);
							SetS(62,17,19,1,4222*2);
							SetS(62,17,18,1,4433*2);
						Light();
						SmartWalk(45,25,2);
						say("��λʦ�֣�ʦ��Ҫ��������һ��ֿ������ﲮ�⡣���������ֻ������һ�䣬����Ҳ�����������˰ɡ�");
						say("���ɴ��⡣������ϸ����һ����Ҫ��ʦ��������������",24);
						say("����");
						MoveSceneTo(17,19);	--�ӽ�:�ﲮ��
						say("�ٺ٣�С���ˡ��������ܲ����˰ɡ������ү����������ɡ�����������",149);
						MoveSceneTo();
						say("���ã����ﲮ�⣡ʦ�ֿ촫��ʦ��������ȥ����һ���������ܲ��ܾ��ˣ�");
						Dark();
							SetS(62,44,24,1,0);
							SetS(62,44,26,1,0);
							--SetS(62,17,19,1,0);
							--SetS(62,17,18,1,0);
							JY.Base["��X1"],JY.Base["��Y1"]=21,23;
						Light();
						--SetS(62,17,19,1,0);
						--SetS(62,18,21,1,6326*2);
						--SetS(62,17,18,1,0);
						--fight
						ModifyWarMap=function()
							SetWarMap(17,18,1,0);
							SetWarMap(18,21,1,0);
							SetWarMap(17,19,1,0);
							--SetWarMap(22,23,1,851*2);
							SetS(62,17,19,1,0);
							SetS(62,18,21,1,6326*2);
							SetS(62,17,18,1,0);
						end
						FIGHT(
									5,1,
									{
										0,23,23,
										-1,22,24,
										-1,24,24,
										-1,21,25,
										-1,25,25,
									},
									{
										149,18,21,
									},
									0,0
								);
						say("�����ģ��������书ȷʵ�ߡ�");
						say("��ô����Ͳ����ˣ������үҲ�����������ˣ��������ɣ�",149);
						say("С�ģ�",24);
						say("�����ով�Ȼ��û��ȫ�������Ҿ�Ҫ��ô��������ô������");
						Dark();
							SetS(62,19,21,1,2982*2);
							say("��л����һֱ����ȡ��ͽ��������������Ҿͻ�������ˡ�",1);
						Light();
						say("ʦ����");
						say("���������Ⱥ�����ţ������ܴ���㣬˵������Щ����Ů�ӻ������Ľ�����ү�ء�",149);
						say("�����г���֮�������Ȼ�����룬���Ҿͳ�ȫ�㡣",1);
						--fight
						ModifyWarMap=function()
							SetWarMap(17,18,1,0);
							SetWarMap(18,21,1,0);
							SetWarMap(19,21,1,0);
						end
						FIGHT(
									1,1,
									{
										1,23,23,
									},
									{
										149,18,21,
									},
									0,0
								);
						say("�����������������书��ȷ��������ϧ�����һ���Ҫ�������ȸ���ˡ�",149);
						Dark();
							--SetS(62,20,20,1,0);
							--SetS(62,20,21,1,0);
							--SetS(62,20,22,1,0);
							--SetS(62,19,21,1,0);
							SetS(62,18,21,1,0);
						Light();
						say("ʦ����Ϊ�β���������");
						say("���������˺ų��������У����Ṧ�ϵ������ȷ�Ƿ�����׷�����ϡ����Ǽ��������Ĳ����ܼ�ʱ���ţ�������ֹ���ж�",1);
						say("������ʦ����ʱ�ϵ������ǿ������ѡ���");
						say("�š����������书Ҳ�������һս��ֻ���Ѽ�ס���ǵ�ģ���ˡ�Ҳ�գ���ɽ֮�����ٴ�����һ·������ֻ�������Ժ����߽������ϣ��������е���",1);
						say("лʦ����");
						Dark();
							SetS(62,19,21,1,0);
						Light();
						
					else
						Dark();
							SetS(62,44,24,1,2590*2);
							SetS(62,44,26,1,2591*2);
							SetS(62,18,21,1,6326*2);
							SetS(62,17,18,1,4433*2);
						Light();
						SmartWalk(45,25,2);
						say("�Ѿ����Ÿ�ʦ���ˣ���ȥ��ʦ�֣�",24);
						Dark();
							SetS(62,44,24,1,0);
							SetS(62,44,26,1,0);
							SetS(62,20,20,1,2592*2);
							SetS(62,20,21,1,2592*2);
							SetS(62,20,22,1,2592*2);
						Light();
						SmartWalk(27,23,2);
						MoveSceneTo(18,21);	--�ӽ�:�ﲮ��
						say("�����ﲮ�⣡���������һ�ɽ���ڷ�������ζ��һ�ɽ���ƣ��������Ǳ�Ҫ����Щ�ܺ���Ů���ָ�������",24);
						say("����������Ҫ������Ⱥ�����������һ������˼ɣ��������Ǽ������һ����ү�����£�����������ɣ�",149);
						say("�����˾������������ﲮ�⣿����������֪�����������Ͼ�Ҫ�����ء���������������ɽ����Ӧ��Ҳ�Ų��Ķ���ˡ���");
						local menu=	{
												{"�ﲮ������ӯ���ҵ�������ɽ���ӣ����������",1},
												{"��ɽ���Զ����٣��޳�֮����",1},
												{"�²��ؼ����߸߹���",1},
											};
						local sel=GenSelection(menu);
						if sel==1 then
							say("����Ȼ�򲻹��ﲮ�⣬���Ǿ���һ�����ǿ��������ģ�ֻҪ�ŵ����������������ˡ�����ɽ�ĸ�λ���������㣡");
							say("��������������һ�������ү���˵��ˡ�",149);
							say("��˵���棡�ﲮ�⣡����¶�Ϊ�����գ��Ͱ���������ɣ�");
							ModifyWarMap=function()
								SetWarMap(20,20,1,0);
								SetWarMap(20,21,1,0);
								SetWarMap(20,22,1,0);
								SetWarMap(18,21,1,0);
								SetWarMap(17,18,1,0);
								SetS(62,17,18,1,0);
							end
							FIGHT(
									5,1,
									{
										0,23,23,
										-1,22,24,
										-1,24,24,
										-1,21,25,
										-1,25,25,
									},
									{
										149,18,21,
									},
									0,0
								);
							say("�����ģ��������书ȷʵ�ߡ�");
							say("��ô����Ͳ����ˣ������үҲ�����������ˣ��������ɣ�",149);
							say("С�ģ�",24);
							say("�����ով�Ȼ��û��ȫ�������Ҿ�Ҫ��ô��������ô������");
							Dark();
								SetS(62,19,21,1,2982*2);
								say("��л����һֱ����ȡ��ͽ��������������Ҿͻ�������ˡ�",1);
							Light();
							say("ʦ����");
							say("���������Ⱥ�����ţ������ܴ���㣬˵������Щ����Ů�ӻ������Ľ�����ү�ء�",149);
							say("�����г���֮�������Ȼ�����룬���Ҿͳ�ȫ�㡣",1);
							--fight
							ModifyWarMap=function()
								SetWarMap(20,20,1,0);
								SetWarMap(20,21,1,0);
								SetWarMap(20,22,1,0);
								SetWarMap(18,21,1,0);
								SetWarMap(17,18,1,0);
								SetWarMap(19,21,1,0);
							end
							FIGHT(
									1,1,
									{
										1,23,23,
									},
									{
										149,18,21,
									},
									0,0
								);
							say("�����������������书��ȷ��������ϧ�����һ���Ҫ�������ȸ���ˡ�",149);
							Dark();
								SetS(62,18,21,1,0);
							Light();
							say("�����ţ�Ϊ�β���������");
							say("���������˺ų��������У����Ṧ�ϵ������ȷ�Ƿ�����׷�����ϡ����Ǽ��������Ĳ����ܼ�ʱ���ţ�������ֹ���ж�",1);
							say("�����������ż�ʱ�ϵ������ǿ������ѡ���");
							say("�š����������书Ҳ�������һս��ֻ���Ѽ�ס���ǵ�ģ���ˡ�Ҳ�գ��Ҵ�����һ·��������л�������һ�ɽ���ӡ�ֻ�ν��������ٴ����ϴ����¼����ܹ����ǽ��յľ�����",1);
							local kflist={
											{5,10},
										};
							LearnKF(0,1,kflist);
							say("л�����ţ������Ե����ǣ�");
							Dark();
								SetS(62,20,20,1,0);
								SetS(62,20,21,1,0);
								SetS(62,20,22,1,0);
								SetS(62,19,21,1,0);
							Light();
						elseif sel==2 then
							say("����Ȼ�ﲮ����������������Ϊ�������ɵĻ�ɽ���Ӿ�ȻȺ���������Ҳ̫��˽��������ˡ����������ﲮ��һ�ء�����Ϊ�������ɣ���Ȼ������һ�������ǲ�Ҫ�������֣��������㡣");
							say("���˾�Ȼ��������������������ͬ��Ҳ�����ˡ�һ�����£�����ʦ�����䣡",24);
							--fight
							ModifyWarMap=function()
								SetWarMap(20,20,1,0);
								SetWarMap(20,21,1,0);
								SetWarMap(20,22,1,0);
								SetWarMap(18,21,1,0);
								SetWarMap(17,18,1,0);
								SetS(62,17,18,1,0);
							end
							FIGHT(
									2,5,
									{
										0,23,23,
										149,18,21,
									},
									{
										9,17,19,
										10,18,19,
										11,20,19,
										12,20,21,
										13,20,23,
									},
									0,0
								);
							say("��ô����ɽ�ɵĵ���ֻ����ô����è����",149);
							say("�������������޵ò��񣡵���ʦ�����ˣ���������ô����",24);
							say("��ѽ���Һ��°�������������",149);
							say("���֣���ս�پ��ɡ�����֮ʱ���������Ѵ�������Ⱥ�ˡ�");
							say("�У���Ȼ��λ���������ˣ����ҾͲ��������ˣ��������ɣ�",149);
							Dark();
								SetS(62,19,21,1,2982*2);
								say("��л����һֱ����ȡ��ͽ��������������Ҿͻ�������ˡ�",1);
							Light();
							say("����Ⱥ��");
							say("���������Ⱥ�����ţ������ܴ���㣬˵������Щ����Ů�ӻ������Ľ�����ү�ء�",149);
							say("�����г���֮�������Ȼ�����룬���Ҿͳ�ȫ�㡣",1);
							--fight
							ModifyWarMap=function()
								SetWarMap(20,20,1,0);
								SetWarMap(20,21,1,0);
								SetWarMap(20,22,1,0);
								SetWarMap(18,21,1,0);
								SetWarMap(17,18,1,0);
								SetWarMap(19,21,1,0);
							end
							FIGHT(
									2,8,
									{
										0,19,22,
										149,19,23,
									},
									{
										1,24,23,
										2,25,22,
										9,26,21,
										10,26,23,
										11,26,25,
										12,27,22,
										13,27,24,
										9,25,24,
									},
									0,0
								);
							say("�����������������书��ȷ��������ϧ�����һ���Ҫ�������ȸ���ˡ������������ߣ�",149);
							Dark();
								SetS(62,20,20,1,0);
								SetS(62,20,21,1,0);
								SetS(62,20,22,1,0);
								SetS(62,19,21,1,0);
								SetS(62,18,21,1,0);
								JY.SubScene=38;
								JY.SubSceneX,JY.SubSceneY=0,0;
								SetS(38,16,13,1,4708*2);
								JY.Base["�˷���"]=0;
								JY.MyPic=GetMyPic();
								JY.Base["��X1"],JY.Base["��Y1"]=16,14;
							Light();
							say("��л����������",149);
							say("�������û���ң�����һ��������ȥ���硣�����ҹ��������ˡ�");
							say("����˵Ц�ˡ�ֻ����˷����ң�ֻ�»�ɽ����Ȼ������Ϊ�ҵ�ͬ���ˡ�",149);
							say("�ߣ�������Σ����Ҿ��ǿ��������Ǳ��Ϊ�������ɣ�ȴ�����Զ�����֮�¡����������˳ƾ��ӽ��������µ�����ˣ�ֻ��Ҳ�Ǹ�α���Ӷ��ѡ�");
							say("˵�úã������������Ǵ�����ģ�������Ⱥ���Ǹ�α���ӣ����������������������书ȷʵ��ǿ���ҿ�ƾ�Ṧ���ѣ�ֻ����������",149);
							say("����ʲô��������ô���ܲ����ܶ�������ɽ�ɵĵ��̰ɡ�");
							say("˵�úã��������粻���������½��Լ��ܽ������һ·��������������ϣ�������ܶ�һ���Ա�֮����",149);
							local kflist={
											{80,10},
										};
							LearnKF(0,149,kflist);
							say("��л���֡�");
							say("ɽ��ˮ����������ڣ�",149);
							Dark();
								SetS(38,16,13,1,0);
							Light();
						else
							say("����ʧ���꼰���㡣�����߰ɡ�",24);
							SetS(62,44,24,1,0);
							SetS(62,44,26,1,0);
							SetS(62,18,21,1,0);
							SetS(62,17,18,1,0);
							SetS(62,20,20,1,0);
							SetS(62,20,21,1,0);
							SetS(62,20,22,1,0);
							JY.Status=GAME_MMAP;
							CleanMemory();
							lib.ShowSlow(50,1)
							if JY.MmapMusic<0 then
								JY.MmapMusic=JY.Scene[JY.SubScene]["��������"];
							end
							Init_MMap();
							JY.SubScene=-1;
							JY.oldSMapX=-1;
							JY.oldSMapY=-1;
							lib.DrawMMap(JY.Base["��X"],JY.Base["��Y"],GetMyPic());
							lib.ShowSlow(50,0)
							lib.GetKey();
						end
					end
					
										--���˳���
										ModifyD(57,0,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,29);
										ModifyD(57,1,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,28);
										ModifyD(57,17,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,27);
										ModifyD(57,22,-2,-2,-2,-2,-2,-2,-2,-2,-2,21,25);
										ModifyD(57,26,-2,-2,-2,-2,-2,-2,-2,-2,-2,21,13);
										ModifyD(57,6,-2,-2,-2,-2,-2,-2,-2,-2,-2,24,40);
										ModifyD(57,5,-2,-2,-2,-2,-2,-2,-2,-2,-2,20,44);
										ModifyD(57,23,-2,-2,-2,-2,-2,-2,-2,-2,-2,27,28);
										ModifyD(57,24,-2,-2,-2,-2,-2,-2,-2,-2,-2,27,30);
										ModifyD(57,15,-2,-2,-2,-2,-2,-2,-2,-2,-2,30,37);
										ModifyD(57,16,-2,-2,-2,-2,-2,-2,-2,-2,-2,30,14);
										ModifyD(57,27,-2,-2,-2,-2,-2,-2,-2,-2,-2,40,36);
										ModifyD(57,28,-2,-2,-2,-2,-2,-2,-2,-2,-2,29,24);
										ModifyD(57,30,-2,-2,-2,-2,-2,-2,-2,-2,-2,30,25);
										ModifyD(57,2,-2,-2,-2,-2,-2,-2,-2,-2,-2,39,22);
										ModifyD(57,29,-2,-2,-2,-2,-2,-2,-2,-2,-2,38,13);
										ModifyD(57,3,-2,-2,-2,-2,-2,-2,-2,-2,-2,46,29);
										ModifyD(57,4,-2,-2,-2,-2,-2,-2,-2,-2,-2,46,30);
										ModifyD(57,18,-2,-2,-2,-2,-2,-2,-2,-2,-2,50,32);
										ModifyD(57,19,-2,-2,-2,-2,-2,-2,-2,-2,-2,50,27);
										ModifyD(57,20,-2,-2,-2,-2,-2,-2,-2,-2,-2,51,27);
										ModifyD(57,21,-2,-2,-2,-2,-2,-2,-2,-2,-2,51,32);
										SetS(57,52,29,3,-1);
										SetS(57,52,30,3,-1);
										SetS(57,30,13,3,-1);
										SetS(57,31,13,3,-1);
					MoveSceneTo();
				end,
			}

						--say("")SceneEvent[JY.SubScene]={};
SceneEvent[7]={
				[1]=function()		--�Ի���������
					local v=GetFlag(2010);
					if v==0 then
						say('���ϣ����������˵�����֣�ÿ�μ������������������ϱ�Ŀ���񡣣��ףȼ������ˡ�');
						say('�������ӷ�ԭ����С��ү�ݵ���������',3);
						say('��������˵���������ſ��۾���װģ�����������ˣ�������������������ѧ�䡣');
						say('������ү�Ѿ�������˵���ˣ�ϣ��С��ү�ӽ�������ר��ѧϰ������Ҳ��ÿ��������ү�㱨���ѧϰ�����',3);
						say('�����������Ϻ����湻���ģ�ÿ���»�Ҫ�Ҽҳ������������ѧ�㶫���ˣ��������˽����̵�С����');
						say('��С��ү����Ҫѧ���书���ͱ�������ϰ�������ȭ�Ź��򣬶�Ҫ�����ҷ��ŵĻ���ȭ�Ź��������ͬʱϰ�������ڵľ��壬�˽�����������ӽ��쿪ʼ�����Ǿͽ��е�һ�׶ε���ϰ��ÿ��ѧ����ʱ�����ۿΣ��μ�һ����Ϣ��',3);
						say('��Ŷ��֪���ˡ�');
						say('���ã��������Ľ����ǡ���',3);
						say('�������ӷ�С��ү�о���Σ�',3);
						say('���ң��Ҹо����ۡ���');
						say('����һ���Ͽ�������ۣ��Ժ��ϰ�ߵġ��������ľͽ������С��ү��ȥҪ�úò���',3);
						say('���õĺõģ�С����ǡ�');
					elseif v==1 then
						say('�����������ˡ�');
						say('��С��ү��������������Ҫ�����ǡ���',3);
						say('�������ֿ�ʼ�ˡ�������');
						say('���ţ�����С��ү��ɫ�������ľͶིһ��ɡ���%*��~%����',3);
						say('�����ˡ�����ÿ�ζ�ѹ�ã����ܲ���������');
						say('�������ã�����ͽ���Щ��С��ү���Ի�ȥ�ˡ�',3);
						say('�������ڽ����ˡ���лл���ˡ�С����ǡ������ߡ���');
						say('����ϸ���룬������ջ񻹲���');
						say('�����Ϻ���ߴߴ���ᣬͷ�۵�����������ʲô��û����ȥ��');
						say('���ţ���˵���������Ϻ��н���һЩ����������Щ���������һ�ȥ��ҪϸϸƷζ��');
					elseif v==2 then
						say('�����ˡ�');
						say('��С��ү���ˣ���������������ѧ���ǡ���',3);
						say('�����ˣ����Ѿ�ѧ�˼����µľ��飬�ܲ���ѧһ���ģ�');
						say('���ţ����Ŀ��������Ѿ�����һ������������ɣ�����ͽ��ҵĶ����书������ӡ��������ɡ��㿴�á���',3);
						say('�����ˣ������ѧ��Щ��С��ү���Ի�ȥ�ˡ�',3);
						say('��лл���ˡ��������š���');
						say('����Ҳ��֪�����ӡ�ò���ʹ�������������');
						say('��С��ү��',8);
						say('����������Ȼ�Ǹ���ӡ������С�˵㣬�������ö����ϰ��');
						say('���أ��ҵ�������',8);
					elseif v==3 then
						say('�����ˡ�');
						say('��С��ү������',3);
						say('������');
						say('������֣��Ϻ��н�����ô��˵���ˣ����ˣ����ǽ��첻�Ͽ�����');
						say('���ǰ���С��ү���������ǲ��Ͽ��ˡ�',3);
						say('��Ү��̫���ˣ���С���͡���');
						say('�����������첻�Ͽ��ˣ���Ϊ���İ��ŵ��ǿ��ԡ�',3);
						say('������������һ�������ף�����������Ϻ��л������۾�һ��ͱ��������');
						say('���ã����ڿ�ʼ���ԡ������⡣�������ڷ��к�Ϊ����ա���',3);
						say('���������������ƣ��ݻ���ħ���㳣��������Ϊ"���"��');
						say('����úã��ǽ�ս�ġ���ݱ�޾Żᡱ����ָʲô��',3);
						say('�������г���ᡢ����Ү�ᡢ΢ϸ�ᡢ�����ᡢ��ӡ�ᡢһӡ�ᡢ��Ȥ�ᡢ��������ĥ�ᡢ����������Ү�ᡣ');
						say('���ţ������������㣬ʲô�ǡ�һ����������',3);
						say('�������롭�����Ƿ���"һ������"����һ�����������������Ϊ���ı��ԣ���ĸ�Դ������"һ������".');
						say('����ѽѽ��С��ү��û�뵽�����ҷ������Ե����Ȼ��ˣ����ľͽ������ڵ��ķ���������ɡ�',3);
						say('��С��ү���������ķ���������ȥҪ�ú���ϰ���̡�',3);
						say('��С���������˽̵���');
						say('���������ź�ӻ����ó���ն��������Һ��Ҹ��ɴ����Ȿ���������Ϻ�������������۾�����֪������������ش�ġ����������еĶ������Ϻ��н�����ͬһ��·��ûʲô�ÿ��ģ��ŵ��������ˡ�');
					end
				end,
				[200]=function()
					JY.SubScene=5
					JY.Base["��X1"],JY.Base["��Y1"]=59,31
					lib.ShowSlow(50,1);
					Init_SMap(1);
				end,
				[201]=function()
					JY.SubScene=9
					JY.Base["��X1"],JY.Base["��Y1"]=34,60
					lib.ShowSlow(50,1);
					Init_SMap(1);
				end,
				[202]=function()
					JY.SubScene=6
					JY.Base["��X1"],JY.Base["��Y1"]=26,6
					lib.ShowSlow(50,1);
					Init_SMap(1);
				end,
			}SceneEvent[70]={};
SceneEvent[70]={
				[698]=function()		--�ݼ�ĸ��
					--vs(1,20,15,2,25,16,500)
					--vs(1,20,15,3,25,16,500)
					--vs(1,20,15,5,25,16,500)
					--vs(1,20,15,6,25,16,500)
					--vs(1,20,15,27,25,16,500)
					--vs(1,20,15,49,25,16,500)
					--vs(1,20,15,50,25,16,500)
					--vs(1,20,15,66,25,16,500)
					--vs(1,20,15,67,25,16,500)
					--vs(1,20,15,68,25,16,500)
					--vs(1,20,15,69,25,16,500)
					--vs(1,20,15,70,25,16,500)
					--vs(1,20,15,71,25,16,500)
					--vs(1,20,15,72,25,16,500)
					for i=2,15 do
						JY.Base["����"..i]=i-1
					end
					--if JY.Person[0]["��������"]==0 then
						JY.Person[0]["��������"]=99999;
					--end
					local kflist={};
					for i=1,30 do
						kflist[i]={i,10};
					end
					LearnKF(0,1,kflist)
					--[[
					WAR={};
					WAR.Data={};
					WAR.Data["����"]=0;
					WAR.Data["����"]="����ս��";
					WAR.Data["��ͼ"]=0;
					WAR.Data["����"]=0;
					WAR.Data["����"]=0;
					WAR.Data["�Զ�ѡ���ս��"  .. 1]=0;
					WAR.Data["�ҷ�X"  .. 1]=9;
					WAR.Data["�ҷ�Y"  .. 1]=21;
					WAR.Data["����"  .. 1]=19;
					WAR.Data["�з�X"  .. 1]=9;
					WAR.Data["�з�Y"  .. 1]=20;
					WarMain(999,0)]]--
				end,
			}
SceneEvent[8]={};
SceneEvent[8]={
				[200]=function()
					JY.SubScene=6
					JY.Base["��X1"],JY.Base["��Y1"]=57,34
					lib.ShowSlow(50,1);
					Init_SMap(1);
				end,
			}







--[[
if inrect(1,26,2,28) then
	JY.SubScene=6
	JY.Base["��X1"],JY.Base["��Y1"]=57,34
	lib.ShowSlow(50,1);
	Init_SMap(1);
else--if lib.GetS(0,0,1,0)==1230 and inrect(29,17,45,26) then
	--��������
	lib.SetS(3,39,22,1,2)
    WAR={};
    WAR.Data={};
    WAR.Data["����"]=0;
    WAR.Data["����"]="����ս��";
    WAR.Data["��ͼ"]=0;
    WAR.Data["����"]=0;
    WAR.Data["����"]=0;
	WAR.Data["�Զ�ѡ���ս��"  .. 1]=0;
	WAR.Data["�ҷ�X"  .. 1]=24;
	WAR.Data["�ҷ�Y"  .. 1]=28;
	WAR.Data["����"  .. 1]=1;
	WAR.Data["�з�X"  .. 1]=23;
	WAR.Data["�з�Y"  .. 1]=26;
	WarMain(999,0)
	if true then return end
	lib.SetS(3,39,22,1,0)
	movesceneto(38,17)
	say("��磬�Ǳ����ֵúܣ���˵����Ҫ������һ���죬����ˣ�������ҿ���ȥ",1)
	say("���ɷ�һŵǧ�������Ҽ�ʱʧ�����ˡ������ͨ�����ػ�������Ӧ�һ�����= =��",0,1)
	say("��û�ߣ��ϴ�˵��������������Ҫ�����书�����ֻ�����Ҽ������ؼ���������������С������д����������������ô��ʵ��������һ�أ��ٲ��߿ɿ�������������",1)
	movesceneto()
	walkto(31,24)
	walkto(31,27)
	walkto(39,27)
	walkto(39,26)
	movesceneto(39,17)
	say("�����������ף�ɽ�����ϡ�·����أ�һ������������Ϊ����ֻΪСŮ���Ѽ��ǣ���δ����żҡ���������һԸ�������������󣬵�Ը�Ǹ����ճ�Ⱥ�ĺú�������϶����������ס���������ʮ�����£���δȢ�ף���ʤ��СŮһȭһ�ŵģ����¼���СŮ�������������¸�Ů���ˣ�����������������·��ֻ������ĺ��ܶ��ѻ��䣬������Ӣ�����ٿ����¹ˣ�����ʼ��δ����Ե���������Ի�����֮�أ�������ʿ�ض࣬�������»��ƣ����λ��������",100)
	say("ԭ������ԭ�˱���̨�İ�ʽ������㿴���ҵı�����ȥ�ܶ����",1,5)
	say("����",0,1)
	say("����",2,4)
	say("�Ǹ������кκÿ��ģ��ҿ���궼�ɳ����ˣ���������������ȥ�����㽫�Ǹ��������������ͽ������Σ�",1,5)
	say("ӹ֬�׷۶��ѣ����ȵ��ϱ��ã�����ȥ¶���֡�",0,1)
	say("ÿ���к�����㶼������������������㻹��˵����",1,5)
	movesceneto()
	walkto(39,19)
	say("�������׵Ŀ�����λ������",0,1)
	say("����",2,4)
	say("�������£�����ү�кμ��̣�",100)
	say("��������",0,1)
	say("С�˸�Ů�ǽ�����ç�������빫��ү�Ŷԣ���˵�ⲻ��Ѱ���Ķ�ʤ���գ��¹�СŮ������£��빫��ү���¡�",100)
	say("���Ǳ����������м����ˣ�",0,1)
	say("������·�����д�����ˡ�",100)
	say("�ѵ���Ȼ����ʤ�������������ȴ�����ˡ�")
	say("С�˸�Ů��ɽҰ��ç֮�ˣ������빫��ү���С����Ǿʹ˱�������������Ǹ�Ѱ���˼ҵ����꣬��Ҳ���Һ������䡣�����Ǹ����ӣ��˴��ǽ��˵ľ�ʦ�������־��㲻�ڳ������٣�Ҳ�����в�����֮�ˡ��Һ�������ʤ���������������к󻼣�Ҫ�Ǳ�����ʤ���������ܸ�����˼ҽ��ף���",100)
	say("�д����գ��㵽Ϊֹ������ģ��Ҿ������˴�ʹ��Ĺ�����ǡ���λ�����ֻ������һȭ����������Ӯ�ˣ��ò��ã�")
	say("������У�ʤ�����빫ƽ��",2,4)
	say("���⹫��ү��������������������ô�书�ˣ����콫�����ˣ�������ͳ��ǣ���ö����Ƿǡ�����ô������ɡ�",100)
	say("��ã�",0)
	--lib.SetS(0,0,1,0,1)
end]]--SceneEvent[81]={};--˼���¸��¼�
SceneEvent[81]={
				[1]=function()--�����normal
					if GetFlag(1)<=lib.GetD(JY.SubScene,JY.CurrentD,4) then
						say("............",JY.Da);
						return;
					end
					local str={
									"���պ����ħ�����ˣ��Ƿ����Ƿǣ��ν��㽫����ɱ�ˣ�",
									"�ѵ�ħ��֮�е������һ�����ˣ��������Ǻ��ˣ�Ϊ��ô����ħ�̣�",
									"�����������һ�ɽ�ɲ�֪���ж���ǰ����������������������ǽ��ջ�ɽ�ɵ�һ�������Ե��ڴ�������",
									"Сʦ�úö��춼û���ˣ�Ī�������ˣ�",
									};
					say(str[math.random(4)],JY.Da);
					lib.SetD(JY.SubScene,JY.CurrentD,4,GetFlag(1));
					if GetFlag(10006)==1 then
						if GetFlag(1)-lib.GetD(JY.SubScene,JY.CurrentD,4)<7 then
							say("��ʦ�֣��Ҹ����ͷ������ˡ�");
							say("��ôСʦ��û����������лл������߾����ˡ�",JY.Da);
							AddPersonAttrib(JY.Da,"�Ѻ�",1);
							SetFlag(10006,0);
						else
							say("��ʦ�֣��Ҹ����ͷ������ˡ�");
							say("��ô��ô�ò���������",JY.Da);
							SetFlag(10006,4);
						end
					end
				end,
				[2]=function()	--������־
					say("��ʦ�֣�����Ϣһ�£��óԷ��ˡ�");
					say("������ô�������ͷ���½����أ�",8);
					say("ʦ�������ﲮ�����һ�ɽ���ڷ���������������ɽȥ�����ˡ�");
					SetS(57,30,13,3,-1);
					SetS(57,31,13,3,-1);
					if GetFlag(10008)==1 then
						say("ԭ����ˡ����������Ȼ��׼������˺þƣ������ˣ�",8);
						say("������һ����ᣬ��������һ����������ᣩ֪����ʦ�ֺô˱���֮����Ҳ�������");
						say("����������ġ�",8);
					else
						say("ԭ����ˡ���",8);
					end
					Dark();
						SetS(81,15,21,1,3409*2);	--Ԭ��־
						SetS(81,13,21,1,1719*2);
						SetS(81,13,20,1,1720*2);
					Light();
					say("�˴����ģ���ֻ�ǵôӶ��г���֮�����һƬ���֣���֪ԭ�����д˵ȵط���",160);
					say("���Ǻ��ˣ�Ϊ��˽���һ�ɽ����˼���£�",8);
					say("ԭ���˴�����˼���£���������������氡�����ǻ�ɽ����Ԭ��־��",160);
					say("���ǻ�ɽ���ӣ�Ԭ��־�������ܣ��һ�ɽ�ڵ���֮��û��һ����Ԭ��־�ġ��㾿���Ǻ��ˣ�",8);
					say("��ʦ�֣������ô��һ�ɽ���أ��ּ�װ�һ�ɽ���ӣ�ֻ�����Ĳ������������ǽ������£��Խ�ʦ�����ã�");
					say("�ã�����ô�졣",8);
					say("Ҫ���֣�Ҳ�ã��պ���������߽���������",160);
					--fight
					ModifyWarMap=function()
						SetWarMap(15,21,1,0);
					end
					vs(8,25,23,160,17,21,500);
					Dark();
						SetS(81,18,19,1,2951*2);
						SetS(81,18,21,1,6187*2);
						getkey();
					Light();
					say("������ľ�Դ����Ҵ�δ����ʹ�����֮����Ļ�ɽ������",7);
					say("������ɽ��û����Ǵ�һʱ���ѣ�",159);
					say("�������Ǻ��ˣ��������һ�ɽ���ؾ���������Ϊ��",8);
					say("��ɽ֮�ϣ���Ȼ�ǻ�ɽ֮�ˡ��Ϸ������塣",159);
					say("�Ϸ�����",7);
					say("�����壿�����Ī�����һ�ɽ���ֱ���ǰ����",8);
					say("Ŷ�����Ȼ֪�����ǣ�",7);
					say("ͽ������壬�ݼ���λ̫ʦ�塣",8);
					say("ͽ��ݼ���λ̫ʦ�塣");
					say("�ݼ��Ͳ����ˡ�����С�ӣ������㣬����ͽ���书��Σ�",159);
					say("��λ����ʦ���书��ǿ�����Ҷ���֮��������֮һս�����ǵ���������Ҳ��Ƕ��֡�",8);
					say("��ֱ���Լ����У������������������嵫���˻��С����ҹ������Ҿͽ̽��������Ļ�ɽ����������ôʹ��",7);
					Dark();
					Light();
						for i=1,10 do
							AddPersonAttrib(8,"����",5000);
							War_AddPersonLevel(8,true);
						end
					say("��л̫ʦ��ָ�㣡",8);
					say("����ͷ�����⼸����������ã�����ֻ��װװ���ӣ������ӵܰɣ�",159);
					say("���������ȥ����ʦ��ָ��һ����",7);
					say("�ǣ�̫ʦ�塣Ԭʦ�壬��ָ�̡�",8);
					say("ָ�̲��ҵ����д��д���ѡ�",160);
					--fight
					ModifyWarMap=function()
						SetWarMap(15,21,1,0);
						SetWarMap(18,19,1,0);
						SetWarMap(18,21,1,0);
					end
					vs(8,25,23,160,17,21,500);
					say("ʦ�彣����������һ�㣬���������벻���ĽǶȹ������ҿ���ֻ�ֵܵ���������һ������������",8);
					say("����㽫һ�׻����Ļ�ɽ����ʹ�û�Ȼ��ɣ���ˮ��©������������ʮ������Ȼ�������£����⻪ɽ������Ȼ��ɰ���",160);
					say("���˵����Ȼ��ƽ�֣�����ͷֻ��ָ�㼸����ܴ��ƽ�֣��Ҳ��š���־�������ߡ������º�������̡�",159);
					say("������������������������º�ָ��һ�����ǡ�",7);
					say("�ߣ�˭ָ��˭��˵�����أ�",159);
					say("����֣��Ǳ������º��ټ��ˡ�ֻ�ǣ���������ʹ�������˲���ǰ�����õ���һ·������������º������������ʹ��һ������������ֲ�Ҫ���⡣",160);
					say("��л��档��ֻ����ֻ������Ļ�ɽ����������������˵���ǿ��¡�����",8);
					say("��������Իᴫ��һ�׽����������º�����ʤ����",7);
					say("��л̫ʦ�塣",8);
					say("��ϲ��ʦ�֡�");
					Dark();
						ModifyD(81,0,-2,-2,3,-2,-2,-2,-2,-2,-2,-2,-2);	--�޸��������
						SetS(81,15,21,1,0);	--Ԭ��־
						SetS(81,18,19,1,0);
						SetS(81,18,21,1,0);
						SetFlag(10009,GetFlag(1));
						SetFlag(10012,1);
					Light();
				end,
				[3]=function()	--�ճ��д�
					if GetFlag(10009)>0 and GetFlag(1)-GetFlag(10009)>=90 then	--����
						if GetFlag(10012)==1 then
							Dark();
								SetS(81,15,21,1,3409*2);	--Ԭ��־
								SetS(81,18,19,1,2951*2);
								SetS(81,18,21,1,6187*2);
							Light();
							say("����֣���ָ�̡�",160);
							say("Ī�Ҳ��ӡ�",8);
							SetFlag(10013,1);
							--fight
							ModifyWarMap=function()
								SetWarMap(15,21,1,0);
								SetWarMap(18,19,1,0);
								SetWarMap(18,21,1,0);
							end
							local resule=vs(8,25,23,160,17,21,500);
							Dark();
								say_2("��ʦ�֣���ʦ�֣�",13);
								say_2("��־�������ߡ�",159);
								say_2("����˼�ס���������κ���͸¶������֮�¡�",7);
								say_2("�ǣ�",8);
								say_2("�ǣ�");
								SetS(81,15,21,1,0);	--Ԭ��־
								SetS(81,18,19,1,0);
								SetS(81,18,21,1,0);
								--½����
								SetS(81,17,19,1,2592*2)
							Light();
						else
							Dark();
								say("��ʦ�֣���ʦ�֣�",13);
								--½����
								SetS(81,17,19,1,2592*2)
							Light();
						end
						say("��ʦ�֣�",13);
						say("��������ʲô����ô������",8);
						say("��ʦ�֣����²����ˣ���ɽ�ɵ����Ž������ţ���ʦ����������֮λ���ˡ�",13);
						say("ʲô�����д������ǿ�ȥ��",8);
						Dark();
							SetS(81,17,19,1,0)
							ModifyD(81,0,-2,-2,-2,-2,-2,-2,-2,-2,-2,1,1);	--�޸����
							SetFlag(10014,GetFlag(1)+5);
						Light();
						return;
					end
					--�ճ�
						say("�Ƚ�֮�ڽ���������ҪŬ������",JY.Da);
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
								SetWarMap(49,35,1,0);
							end
							local result=vs(0,25,23,JY.Da,17,21,500);
							Cls();
							ShowScreen();
							if result then
								say("�ý����������������硣",JY.Da);
							else
								say("����书�������ټӰѾ��ɡ�",JY.Da);
							end
							DayPass(1);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							--say("ʦ���������£�������������д����书Ҳ�ð���",JY.Da);
						end
					
				end,
				[201]=function()	--�ҹ��������������
							SetS(81,22,26,1,4223*2);
							SetS(81,21,26,1,3398*2);
							SetS(81,23,26,1,3401*2);
							SetS(81,22,25,1,3399*2);
							SetS(81,22,27,1,3400*2);
							SetS(81,24,25,1,3401*2);
							SetS(81,24,27,1,3401*2);
					MoveSceneTo(22,26);
					say("����������ˡ�",152);
					say("��ô�Σ�",153);
					say("�����������ˣ���ȻҪ���������ơ�",154);
					say("�������ǽ����ǵ�����ע�룬�������ˣ�",155);
					say("��ô���ע���أ�",156);
					say("�������Ǹ���һ������ע�룿",157);
					say("�����������",156);
					say("����ô����ˡ�",155);
					say("���������ô֪����˭�Ĺ����أ�",154);
					say("���������������������",153);
					say("�ţ��Ǿ��Ⱦ�������",152);
					DrawStrBoxWaitKey("���˰�����ע�����������");
					Dark();
						say("������",8);
					Light();
					say("��������ˡ�",152);
					say("û��û�ѡ�",153);
					say("û����Ϊʲô��У�",154);
					say("���Ҳ��һ�������ˡ�",155);
					say("������������û�У�",156);
					say("ι������壬��������",157);
					say("û�з�Ӧ�ء�",156);
					say("�Ǿ���û�ѡ�",155);
					say("Ҳ�п����������˹��ⲻ�ش�",154);
					say("�����ǰ���˺���Ŀ飬�����ز��ش�",153);
					say("˺���Ŀ鲻��������������Ȼ�ش��ˡ�",152);
					say("�����ˣ�����Ҫ�Ѵ�ʦ��˺���Ŀ飡��ʦ����ʦ���ʦ�����⣡���ף��������������أ���");
					Dark();
						JY.SubSceneX,JY.SubSceneY=0,0;
							SetS(81,21,26,1,0);
							SetS(81,23,26,1,0);
							SetS(81,22,25,1,0);
							SetS(81,22,27,1,0);
							SetS(81,24,25,1,0);
							SetS(81,24,27,1,0);
						SetS(81,21,26,1,4258*2);
						SetS(81,22,25,1,2613*2);
						JY.Base["��X1"],JY.Base["��Y1"]=23,26;
					Light();
					say("��������������ô���˳����",2);
					say("ʦ�ã��𼱣����ҿ����������������������һ�������ᴳֱײ����������һ�ţ�ֻ�¡���",1);
					say("�������ɽ����ɶ�",2);
					say("�ҹ������˲�����ɽ֮�ˡ����������ĥ��������к���ͼ��",1);
					say("ʦ�֣���������о�ô��",2);
					say("�����ް���ֻ���������������������롭�����Ȱ����ʦ�ַ��ط���",1);
					say("�ǡ�");
					Dark();
						SetS(81,21,26,1,0);
						SetS(81,22,25,1,0);
						SetS(81,22,26,1,0);
						JY.SubScene=57;
						SetS(57,43,13,1,4323*2);
						JY.Base["�˷���"]=0;
						JY.MyPic=GetMyPic();
						JY.Base["��X1"],JY.Base["��Y1"]=43,14;
					Light();
					say("ʦ������ô˵��",8);
					say("�ǵġ���ʦ����𼱣��ú����ˣ�ʦ��һ�����а취�ġ�");
					say("��Ը�ɡ���",8);
					say("���ˡ���ɽ�Ź�����ϼ��һ��������ϼ��һ�����԰�������Щ���������ġ�ֻ��Ϊ��ʦ�����ϴ��㡭�����ˡ���ϼ��ֻ�����š�������ʦ����ϣ����ʦ��������������Ϊ�ܼ縺�һ�ɽ���������ţ��ٴ���ϼ�񹦡���ʦ���������Ƿϣ������˷�ʦ����һƬ���İ���");
					say("��֮����������ܽ��ˡ���һ�����Ṽ��ʦ���������ģ�",8);
					Dark();
						JY.Base["�˷���"]=2;
						JY.MyPic=GetMyPic();
						JY.Base["��X1"],JY.Base["��Y1"]=38,17;
					Light();
				end,
				[11]=function()--
				end,
			}

						--say("")SceneEvent[9]={};
SceneEvent[9]={
				[1]=function()	--���ƶԻ�
				end,
				[200]=function()
					JY.SubScene=7;
					JY.Base["��X1"],JY.Base["��Y1"]=31,7;
					lib.ShowSlow(50,1);
					Init_SMap(1);
				end,
				[201]=function()
					--JY.SubSceneX,JY.SubSceneY=0,0;
					MoveScene(0,0);
				end,
				[202]=function()
					--JY.SubSceneX,JY.SubSceneY=5,5;
					MoveScene(5,5);
				end,
				[203]=function()
					--JY.SubSceneX,JY.SubSceneY=-5,-5;
					MoveScene(-5,-5);
				end,
				[204]=function()
					JY.SubScene=2;
					for i=0,63 do
						for j=0,63 do
							SetS(JY.SubScene,i,j,0,-1);
							SetS(JY.SubScene,i,j,1,-1);
							SetS(JY.SubScene,i,j,2,-1);
							SetS(JY.SubScene,i,j,3,-1);
							SetS(JY.SubScene,i,j,4,0);
							SetS(JY.SubScene,i,j,5,0);
						end
					end
					migong(30,30);
					JY.Base["��X1"],JY.Base["��Y1"]=32,32;
					lib.ShowSlow(50,1);
					Init_SMap(1);
					--[[Timer[1].status='start';
					Timer[1].t=60;
					Timer[1].event=SceneEvent[2][200];
					Timer[2].status='start';
					Timer[2].t=5;
					Timer[2].event=SceneEvent[2][201];]]--
				end,
				[205]=function()
					for i=48,58 do
						SetS(9,26,i,3,-1);
					end
					say('������ľ��ĵط�����ô�����д򶷵���������ȥ������');
					local x,y=JY.Base["��X1"],JY.Base["��Y1"];
					MoveSceneTo(12,51);
					DrawStrBoxWaitKey("���ƺ��ݷ������Ķ���",C_WHITE,CC.Fontbig);
					say('��ʦ�磬���������',12,0);
					say('���ţ�ʦ�ã�����ý��������⼸��������ô����',11,4);
					say('��ʦ�磬�Ҽǵõ�������˵�����С������羪�磬��ɽ�����ӡ�Ӧ�����ý�����һƥ��һ�����˿�ȥ��',12,0);
					say('���ţ�����˵����������ȷʵû��������ʦ�ã��������ǻ��úúõ����������ĵط���ʦ���������������˼ҡ�',11,4);
					say('��ʦ�磬����ÿ�γ��Ŷ�Ҫ�ü���������һ���꣬��֪��ʲôʱ��Ż�����',12,0);
					say('����֮�����ڼҺú��ֲ˾����ˣ����������ס���ʬ��������ʦ�������˿϶����ˡ�',11,4);
					say('���ţ������Ƚ��ݰɣ���ȥ������',12,0);
					say('���ã�ʦ�ã�����ȥι������ǡ�',11,4);
					say('����ԭ����һ����������������������ʬ�����������ֻ�������˼����֪��������˵�����׽��������������Ժ��л��᲻��������һ������');
					MoveScene(5,5);
				end,
			}