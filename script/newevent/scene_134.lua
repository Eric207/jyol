SceneEvent[134]={};--�����Ǹ��¼�
SceneEvent[134]={
				[1]=function()--����ϰ��
					say("Ҫѧϰ����ϰ��ô���⼸���Ҳ��շѵ�Ŷ��",JY.Da);
					AddZIZHI(JY.Da);
				end,
				[2]=function()--��ȭ����
					say("Ϊ�˹��ɽһ�ɵ�ȭ����Ҳ�����ٱ��������ˡ�",JY.Da);
					local kflist={
										{9,10},
										{10,10},
										{11,10},
									};
					LearnKF(0,JY.Da,kflist);
				end,
				[3]=function()--��ȭ����
					say("��ȭ���ǽ���һ����ֻ��ϧ��ɽ����֮���󣬻�ɽ����Ҫô����Ҫô��������������ȭ�ˡ�",JY.Da);
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
				[11]=function()--
				end,
				[1001]=function()--
					return CommonEvent(1,JY.Da)
				end,
			}

						--say("")