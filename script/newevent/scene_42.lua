SceneEvent[42]={};--����ɽ��
SceneEvent[42]={
				[1]=function()--����
					if GetFlag(20005)==0 then
						if GetFlag(20004)==1 then
							SetFlag(20005,1)
							script_say("���ǣ����⡭�����ѵ����Ǵ�˵�еġ��ŋָ��ء������У���Ҫ�Ͻ�֪ͨ���ӣ���")
							Dark();
								SetS(42,32,13,1,6304);
							Light();
							script_say("Ľ�ݸ����⡭���⡭��û���������Ľ�ݼ��������ἰ�ġ��ŋָ��ء������쿪�ۣ������ڸ���һ��ʹ��Ľ�ݼҵĴ��ұ��ص���Ѱ�أ���������˴��ˣ���������һ����Щ�伮��������롣�պ������ȥ��ʩˮ������Щ�伮����Ϊ�������Ľ�����")
							script_say("���ǣ�л���Ӷ��䣡")
							Dark();
								SetS(42,32,13,1,0);
								for i,v in pairs(CC.Scene_S) do
									JY.Scene[116][i]=JY.Scene[52][i];
								end
								JY.Scene[52]["��������"]=1;
								JY.Shop[10]["�ݵ�"]=116
								Cal_EnterSceneXY();
							Light();
						else
							SetFlag(20005,2)
							script_say("���ǣ����ǣ��ƺ��ղ��˺ܶ����Ű���")
							Dark();
							Light();
							script_say("���ǣ�������ϵ�ǩ��......�������ɡ����������ɡ������Ĵ�����ɡ�����ɽ�������ɡ�......")
							Dark();
							Light();
							script_say("���ǣ��ţ���ô�ǰ�ֽ����Ī�������˽����ȵ��ˣ���")
							local add,str=AddPersonAttrib(0,"����",5000);
							DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
							War_AddPersonLevel(0);
							local add,str=AddPersonAttrib(0,"��������",10000);
							DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
						end
					else
						return true;
					end
				end,
				[1001]=function()--
					return CommanEvent(1,JY.Da)
				end,
			}

						--say("")