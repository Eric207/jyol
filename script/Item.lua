JY.Item=	{
					[0]=	{--��ɽ����װ
								SR=	function(pid)--�ر�ʹ������
											return true;
										end,
								onuse=	function(pid)--ʹ��Ч��
												SetFlag(120,JY.Person[pid]["ս������"]);
												JY.Person[pid]["ս������"]=333;
												return;
											end,
								unuse=	function(pid)--ж��Ч��
												JY.Person[pid]["ս������"]=GetFlag(120);
												return;
											end,
							},
					[1]=	{--��ǵ���װ
								SR=	function(pid)--�ر�ʹ������
											return true;
										end,
								onuse=	function(pid)--ʹ��Ч��
												SetFlag(120,JY.Person[pid]["ս������"]);
												JY.Person[pid]["ս������"]=394;
												return;
											end,
								unuse=	function(pid)--ж��Ч��
												JY.Person[pid]["ս������"]=GetFlag(120);
												return;
											end,
							},
					[2]=	{--��ɽ����װ
								SR=	function(pid)--�ر�ʹ������
											return true;
										end,
								onuse=	function(pid)--ʹ��Ч��
												SetFlag(120,JY.Person[pid]["ս������"]);
												JY.Person[pid]["ս������"]=335;
												return;
											end,
								unuse=	function(pid)--ж��Ч��
												JY.Person[pid]["ս������"]=GetFlag(120);
												return;
											end,
							},
					[3]=	{--̩ɽ����װ
								SR=	function(pid)--�ر�ʹ������
											return true;
										end,
								onuse=	function(pid)--ʹ��Ч��
												SetFlag(120,JY.Person[pid]["ս������"]);
												JY.Person[pid]["ս������"]=332;
												return;
											end,
								unuse=	function(pid)--ж��Ч��
												JY.Person[pid]["ս������"]=GetFlag(120);
												return;
											end,
							},
					[4]=	{--��ɽ����װ
								SR=	function(pid)--�ر�ʹ������
											return true;
										end,
								onuse=	function(pid)--ʹ��Ч��
												SetFlag(120,JY.Person[pid]["ս������"]);
												JY.Person[pid]["ս������"]=334;
												return;
											end,
								unuse=	function(pid)--ж��Ч��
												JY.Person[pid]["ս������"]=GetFlag(120);
												return;
											end,
							},
					[5]=	{--��ɽ����װ
								SR=	function(pid)--�ر�ʹ������
											return true;
										end,
								onuse=	function(pid)--ʹ��Ч��
												SetFlag(120,JY.Person[pid]["ս������"]);
												JY.Person[pid]["ս������"]=336;
												return;
											end,
								unuse=	function(pid)--ж��Ч��
												JY.Person[pid]["ս������"]=GetFlag(120);
												return;
											end,
							},
					[999]=	{--Bak
								SR=	function(pid)--�ر�ʹ������
											return true;
										end,
								onuse=	function(pid)--ʹ��Ч��
												return;
											end,
								unuse=	function(pid)--ж��Ч��
												return;
											end,
							},
				}