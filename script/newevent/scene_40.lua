SceneEvent[40]={};--�����Ǹ��¼�
SceneEvent[40]={
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
					return CommanEvent(1,JY.Da)
				end,
			}

						--say("")