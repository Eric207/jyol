SceneEvent[58]={};--��ɽ�ɸ��¼�
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
						--say("")