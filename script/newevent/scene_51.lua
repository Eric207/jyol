SceneEvent[51]={};--ؤ����¼�
SceneEvent[51]={
				[1]=function()	--���ŵ���
					--��ʱ������ؤ�﹫��
					if JY.Person[0]["����"]~=9 then	--��ؤ�����
						local d=JY.Base["�˷���"];
						if JY.Base["��X1"]+CC.DirectX[d+1]~=40 or JY.Base["��Y1"]+CC.DirectY[d+1]~=30 then
							say("ؤ�������µ�һ��",JY.Da);
							return;
						end
						if d==2 then
							say("�㲻��ؤ����ˣ���������������������",JY.Da);
						else
							say("Ҫ��ȥ��",JY.Da);
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
							say("����ɡ�",JY.Da);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						elseif r==2 then
							say("��������Ӻ�������Ͷ�����ˣ�Ҫ��������ؤ����������ȥ����Ҳ�и���Ӧ�����˲Ų����۸��㡣",JY.Da);
							say("�������������ؤ�ϣ�������������ҡ�");
							Dark();
							JY.Base["��X1"]=17;
							JY.Base["��Y1"]=29;
							JY.Base["�˷���"]=2;
							 JY.MyPic=GetMyPic();
							Light();
							--��ʱ�����ǰ�ʦ����
							if true then
								say("���뱾�ﲻ�ѣ����������ذ�棬�������������",261);
								if DrawStrBoxYesNo(-1,-1,"�Ƿ����Ҫ����ؤ���ɣ�",C_WHITE,CC.Fontbig) then
									say("���ӵ������棡");
									JY.Person[0]["����"]=9;
									JY.Shop[5]["����ʱ��"]=GetFlag(1);
									DrawStrBoxWaitKey(JY.Person[0]["����"].."�����ؤ��",C_WHITE,CC.Fontbig);
									JY.Person[0]["���"]="ؤ�����";
									--GetItem(5,1);
								else
									say("������˵أ��������֡�");
								end
							else
								say("�����ڽ���������ʢ�����ֺα�����ǲ��ؤ��Ѱ���أ�",261);
							end
						elseif r==3 then
							--say("��Ȼ���£��͸Ͻ��뿪�ɡ�",JY.Da);
							Dark();
							JY.Base["��X1"]=JY.Base["��X1"]+CC.DirectX[d+1]*2;
							JY.Base["��Y1"]=JY.Base["��Y1"]+CC.DirectY[d+1]*2;
							Light();
						elseif r==4 then
							say("��㡣",JY.Da);
						end
					else
						local d=JY.Base["�˷���"];
						if JY.Da>0 then
							say("�ֵ�����Ҫ��æ����",JY.Da);
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
							if JY.Base["��X1"]+CC.DirectX[d+1]~=40 or JY.Base["��Y1"]+CC.DirectY[d+1]~=30 then
								menu[5][3]=0;
								menu[6][3]=0;
							end
							local r=ShowMenu(menu,7,0,0,0,0,0,1,0);
							if r==1 then
								RandomEvent(JY.Da);
							elseif r==2 then
								if JY.Person[0]["����"]<30 then
									say("�ҿ�����ɫ��̫�ã������Ⱥú���Ϣ�ɡ�",JY.Da);
									return;
								end
								say("�ţ����ǱȻ��Ȼ���",JY.Da);
								local result=vs(0,-1,28,JY.Da,29,28,300);
								Cls();
								ShowScreen();
								if result then
									say("�ù���",JY.Da);
								else
									say("�ֵ��㻹ҪŬ��������Ȼ�պ����߽�����Σ�յģ�",JY.Da);
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
								say("�������Ҫ����ʱ�����ҡ�",JY.Da);
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
					if JY.Person[0]["����"]~=9 then	--��ؤ�����
						say("ؤ�������µ�һ��",JY.Da);
					elseif JY.Da>0 then
						say("�ֵ�����Ҫ��æ����",JY.Da);
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
							say("�ţ����ǱȻ��Ȼ���",JY.Da);
								local result=vs(0,-1,28,JY.Da,29,28,300);
							Cls();
							ShowScreen();
							if result then
								say("�ù���",JY.Da);
							else
								say("�ֵ��㻹ҪŬ��������Ȼ�պ����߽�����Σ�յģ�",JY.Da);
							end
							DayPass(1);
						elseif r==3 then
							E_learning(JY.Da);
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							say("�������Ҫ����ʱ�����ҡ�",JY.Da);
						end
					else
						script_say("ؤ����ӣ�ؤ�������µ�һ��");
					end
				end,
				[3]=function()	--������
					if JY.Person[0]["����"]~=9 or JY.Da<=0 then
						script_say("ؤ����ӣ��������ڳ�֮�Ժ㡣");
					else
						say("�������ɣ�",JY.Da);
						E_training(JY.Da);
					end
				end,
				[4]=function()	--����
					if JY.Person[0]["����"]~=9 then	--��ؤ�����
						say("ؤ����Ϊ���µ�һ�������ӵܱ鼰���ϱ���",JY.Da);
					else
						say("ؤ����Ϊ���µ�һ�������ӵܱ鼰���ϱ���",JY.Da);
						local menu={
												{"����",nil,1},
												{"ѧ��",nil,0},
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
							if JY.Person[0]["�ȼ�"]<25 then
								say("�㻹���Ⱥ��������������ɡ�",JY.Da);
							else
								say("ĳ���ü������ͺ���Ȼ����аɣ�",JY.Da);
								local result=vs(0,-1,27,JY.Da,13,26,3000);
								Cls();
								ShowScreen();
								if result then
									say("��������Ȼ��������������",JY.Da);
								else
									say("һʱ���ң�С�ֵ���û�°ɡ�",JY.Da);
								end
								DayPass(1);
							end
						elseif r==4 then
							PersonStatus(JY.Da);
						elseif r==5 then
							--say("��ȥ�ɡ�",JY.Da);
						end
					end
				end,
				[5]=function()	--���
					if JY.Person[0]["����"]==9 then
						say("�ף������ƺ��кܶ�����ǰ���������ĵá�");
						E_readbook();
					end
				end,
				[6]=function()	--��Ϣ ����
					if JY.Person[0]["����"]==9 then
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
							visit(9);
						end
					else
						visit(9);
					end
					walkto_old(0,3);
				end,
				[7]=function()	--���� ����
					if JY.Person[0]["����"]~=9 then	--��ؤ�����
						say("ؤ��������˶��������壬��Σ������",JY.Da);
					else
						say("ؤ��������˶��������壬��Σ������",JY.Da);
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
							say("���Ͽ��Խ��ҵ��书�����𣿲�Ȼ��ȥ���������һ����¡�");
							say("�ã�����ͽ����书������Ժúüǵá�",JY.Da);
							local kflist={
												{151,10},
												{152,10},
												{153,10},
												{154,10},
												{155,10},
												{158,10},
												{159,10},
												{160,10},
												{161,10},
												{166,10},
												{167,10},
												{168,10},
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
				[8]=function()	--����
					if JY.Person[0]["����"]~=9 then	--��ؤ�����
						script_say("ؤ����ӣ������ǳ�����ûʲô�ÿ��ġ�");
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
						script_say("ؤ����ӣ����վ�������Һò��ã���ʦ�����������㡣");
					end
				end,
				[9]=function()
					if JY.Person[0]["����"]~=9 or JY.Da<=0 then
						script_say("ؤ����ӣ�ؤ�������µ�һ��");
					else
						say("����ո�ѧ������ӣ��������˵�ʲô���Ұ��㰲���д�Ķ��󣬻�����԰��������Щȱ�㡣",JY.Da); 
						if DrawStrBoxYesNo(-1,-1,"�Ƿ���ܣ�",C_WHITE,CC.Fontbig) then
							say("�ǣ�");
							local eid={};
							local num=0;
							for i=1,CC.ToalPersonNum do
								local p=JY.Person[i];
								if p["����"]==JY.Person[0]["����"] then
									if p["���"]<=JY.Person[0]["���"] then
										num=num+1;
										eid[num]=i;
									end
								end
							end
							for i=1,num-1 do
								for j=i+1,num do
									if JY.Person[eid[i]]["�ȼ�"]>JY.Person[eid[j]]["�ȼ�"] then
										eid[i],eid[j]=eid[j],eid[i];
									end
								end
							end
							for i=1,num do
								if JY.Person[eid[i]]["�ȼ�"]>JY.Person[0]["�ȼ�"] then
									num=i;
									break;
								end
							end
							say(string.format("%s�����书��࣬���Ǳ���һ�°ɡ�",JY.Person[eid[num]]["����"]),JY.Da);
							if vs(0,-1,28,eid[num],29,28,300) then
								say("�������������Ŭ������",JY.Da);
								say("ָ��һ������书��.",JY.Da);
								local add,str=AddPersonAttrib(0,"����",(4+JY.Person[0]["�ȼ�"])*15+200+math.random(50));
								DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
								War_AddPersonLevel(0);
							else
								say("��Ҫ���ģ��ú�Ŭ���ɡ�",JY.Da);
								say("��΢ָ��һ������书��.",JY.Da);
								local add,str=AddPersonAttrib(0,"����",(4+JY.Person[0]["�ȼ�"])*5+50+math.random(50));
								DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
								War_AddPersonLevel(0);
							end
							DayPass(3);
						else
							say("�����Ǹ��������е㲻�����");
							say("û�õļһ���°ɡ�",JY.Da);
							DayPass(1);
						end
					end
				end,
				[11]=function()		--��
				end,
				[12]=function()		--��
				end,
			}

						--say("")