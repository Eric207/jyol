SceneEvent[109]={};--����Ǹ��¼�
SceneEvent[109]={
				[1]=function()--�������ת�������޸�
					JY.Base["��X"],JY.Base["��Y"]=298,312;
					return true;
				end,
				[2]=function()--�ɿ�
					say("�͹���ȥ�Ķ���",162);
					local m={
								{"����",nil,1},
								{"ȡ��",nil,1},
							};
					local i=EasyMenu(m);
					if i==1 then
						if false then
							say("��ѽ�������ƺ�������");
						else
							say("�ã��Ͻ����̰ɡ�");
							SmartWalk(62,29,1);
							JY.Status=GAME_MMAP;
							CleanMemory();
							lib.ShowSlow(50,1);
							if JY.MmapMusic<0 then
								JY.MmapMusic=JY.Scene[JY.SubScene]["��������"];
							end
							JY.Base["�˴�"]=1;
							JY.Base["��X"],JY.Base["��Y"]=302,310;
							JY.MyPic=GetMyPic();
							Init_MMap();
							JY.SubScene=-1;
							JY.oldSMapX=-1;
							JY.oldSMapY=-1;
							lib.DrawMMap(JY.Base["��X"],JY.Base["��Y"],GetMyPic());
							lib.ShowSlow(50,0)
							lib.GetKey();
							SmartWalk(302,201,1);
							CleanMemory();
							JY.SubScene=130;
							lib.ShowSlow(50,1)
							JY.Base["��X1"],JY.Base["��Y1"]=8,23;
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
				[11]=function()--
				end,
				[1001]=function()--
					return CommonEvent(1,JY.Da)
				end,
			}

						--say("")