SceneEvent[112]={};--���ճǸ��¼�
SceneEvent[112]={
				[1]=function()--���ǣ������޸�
					JY.Base["��X"],JY.Base["��Y"]=308,197;
					return true;
				end,
				[2]=function()--�ɿ�
					say("���ճ����Ǻ÷羰����",162);
					if GetFlag(20001)==1 then
						script_say("���ǣ����ʴ��ң�ȥ����������ׯ��ô�ߣ�");
						say("ԭ���ǣι��Ӱ���ׯ�����н������һᰲ�Ŵ�ֻ������ȥ��",162);
						say("���ھ�Ҫ������",162);
						local m={
									{"ȷ��",nil,1},
									{"ȡ��",nil,1},
								};
						local i=EasyMenu(m);
						if i==1 then
							say("�ã��Ͻ����̰ɡ�");
							--SmartWalk(3,23,2);
							JY.Status=GAME_MMAP;
							CleanMemory();
							lib.ShowSlow(50,1);
							if JY.MmapMusic<0 then
								JY.MmapMusic=JY.Scene[JY.SubScene]["��������"];
							end
							JY.Base["�˴�"]=1;
							JY.Base["��X"],JY.Base["��Y"]=302,196;
							JY.MyPic=GetMyPic();
							Init_MMap();
							JY.SubScene=-1;
							JY.oldSMapX=-1;
							JY.oldSMapY=-1;
							lib.DrawMMap(JY.Base["��X"],JY.Base["��Y"],GetMyPic());
							lib.ShowSlow(50,0)
							lib.GetKey();
						else
							say("�ҹ�������ȥ�ݷ����ׯ���ɡ�");
						end
					end
				end,
				[11]=function()--
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