SceneEvent[133]={};--�������¼�
SceneEvent[133]={
				[1]=function()--��������ת�������޸�
					JY.Base["��X"],JY.Base["��Y"]=223,240;
					return true;
				end,
				[2]=function()--�ɿ�
					say("�͹���ȥ�Ķ���",162);
					local m={
								{"�����",nil,1},
								{"ȡ��",nil,1},
							};
					local i=EasyMenu(m);
					if i==1 then
						if false then
							say("��ѽ�������ƺ�������");
						else
							say("�ã��Ͻ����̰ɡ�");
							--SmartWalk(62,29,1);
							JY.Status=GAME_MMAP;
							CleanMemory();
							lib.ShowSlow(50,1);
							if JY.MmapMusic<0 then
								JY.MmapMusic=JY.Scene[JY.SubScene]["��������"];
							end
							JY.Base["�˴�"]=1;
							JY.Base["��X"],JY.Base["��Y"]=216,240;
							JY.MyPic=GetMyPic();
							Init_MMap();
							JY.SubScene=-1;
							JY.oldSMapX=-1;
							JY.oldSMapY=-1;
							lib.DrawMMap(JY.Base["��X"],JY.Base["��Y"],GetMyPic());
							lib.ShowSlow(50,0)
							lib.GetKey();
							SmartWalk(192,269,0);
							CleanMemory();
							JY.SubScene=132;
							lib.ShowSlow(50,1)
							JY.Base["��X1"],JY.Base["��Y1"]=22,46;
							JY.Status=GAME_SMAP;
							JY.MmapMusic=-1;
							JY.Base["�˴�"]=0;
							JY.MyPic=GetMyPic();
							Init_SMap(1);
						end
					else
						say("��ֻ����㿴����");
					end
				end,
				[100]=function()--����ħ������
					if JY.Person[0]["����"]>=0 then
						say("ԭ����������ﰡ���������ɣ�");
						if vs(0,12,33,JY.Da,7,33,500,0) then
							ModifyD(JY.SubScene,JY.CurrentD,0,-2,0,0,-2,0,0,0,0,-2,-2);
							MyQuest[1]=2;
						else
							JY.Status=GAME_END;
						end
					end
				end,
				[11]=function()--С��ؤ
					script_say("С��ؤ�����磬��������Ĵ�һ��ɡ����Һö�������")
					script_say("���ǣ��⡭��")
					if DrawStrBoxYesNo(-1,-1,"�Ƿ�ʩ�᣿",C_WHITE,CC.Fontbig) then
						script_say("���ǣ������������ĺ��ӣ�ֻ����Ҳ����̫��Ǯ�ƣ�ֻ����Щ���������Űɡ�")
						script_say("С��ؤ��лл���磡лл�����������һ�����кñ��ģ�лл��")
						script_say("���ǣ�����������������")
					else
						script_say("���ǣ�С�ֵܣ��������нţ�Ϊ�β�ȥ�뷨�����Լ���������������֮�£�������ǿ�԰�������������")
						script_say("С��ؤ�����磬��˵���Ҷ��������Һö������������㷢�����İɡ���")
						script_say("���ǣ���������ľ���ɵ�Ҳ����")
					end
				end,
				[12]=function()--
				end,
				[13]=function()	--ס��
					if DrawStrBoxYesNo(-1,-1,"�Ƿ���Ϣ��",C_WHITE,CC.Fontbig) then
						SetFlag(1,GetFlag(1)+1);
						rest();
						say("��Ϣ���ˣ�����Ŭ���ɡ�");
					else
					
					end
				end,
				[1001]=function()--
					return CommonEvent(1,JY.Da)
				end,
			}

						--say("")