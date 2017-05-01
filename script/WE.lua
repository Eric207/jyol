function WAR_CALLEVENT(num)
	local war={}
	war[999]=true
	
	if num==999 then 
		return 0
	else	
		local eventfilename=string.format("warevent%03d.lua",num);
		--lib.Debug(eventfilename);
		return dofile(CONFIG.ScriptPath.."war\\" .. eventfilename) or 0;
	end
end


------ս���¼���ʹ�õĲ��ֺ���----ȫ����WE_��ͷ
function WE_xy(x,y,id)			--��ȡ��Ŀ��xy��ӽ��Ŀ�������
--����idʱ���������ƶ�
--������ʱ�������ڳ���
	if id~=nil then
		War_CalMoveStep(id,128,0)
		--MY_CalMoveStep(x,y,128,0)
	else
		CleanWarMap(3,0)
	end
	if GetWarMap(x,y,3)~=255 and War_CanMoveXY(x,y,0) then
		return x,y
	else
		for s=1,128 do
			for i=1,s do
				local j=s-i
				if x+i<63 and y+j<63 then
					if GetWarMap(x+i,y+j,3)~=255 and War_CanMoveXY(x+i,y+j,0) then
						return x+i,y+j
					end
				end
				if x+j<63 and y-i>0 then
					if GetWarMap(x+j,y-i,3)~=255 and War_CanMoveXY(x+j,y-i,0) then
						return x+j,y-i	
					end
				end
				if x-i>0 and y-j>0 then
					if GetWarMap(x-i,y-j,3)~=255 and War_CanMoveXY(x-i,y-j,0) then
						return x-i,y-j	
					end
				end
				if x-j>0 and y+i<63 then
					if GetWarMap(x-j,y+i,3)~=255 and War_CanMoveXY(x-j,y+i,0) then
						return x-j,y+i
					end
				end
			end
		end		
	end
	
	for s=1,128 do
		for i=1,s do
			local j=s-i
			if x+i<63 and y+j<63 then
				if War_CanMoveXY(x+i,y+j,0) then
					return x+i,y+j
				end
			end
			if x+j<63 and y-i>0 then
				if War_CanMoveXY(x+j,y-i,0) then
					return x+j,y-i	
				end
			end
			if x-i>0 and y-j>0 then
				if War_CanMoveXY(x-i,y-j,0) then
					return x-i,y-j	
				end
			end
			if x-j>0 and y+i<63 then
				if War_CanMoveXY(x-j,y+i,0) then
					return x-j,y+i
				end
			end
		end
	end	
	return x,y
end	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	--[[
	
	if GetWarMap(x,y,3)~=255 and War_CanMoveXY(x,y,0) then
		return x,y
	else
		CleanWarMap(4,0)
		local steparray={};     --�����鱣���n�������ꡣ
		
			steparray.num=1;
			steparray.x={};
			steparray.y={};
		
		steparray.x[1]=x;
		steparray.y[1]=y;
		SetWarMap(x,y,4,1) 
		x,y=WE_FindNextxy(steparray)
		CleanWarMap(4,0)
		return x,y
	end
end


function WE_FindNextxy(steparray)
	local num=0
	for i=1,steparray.num do
	    local x=steparray.x[i];
	    local y=steparray.y[i];
	--lib.Debug("a"..(x)..','..y..','..GetWarMap(x,y,4))
	    if x+1<CC.WarWidth-1 and GetWarMap(x+1,y,4)==0 then                        --��ǰ���������ڸ�
			if GetWarMap(x+1,y,3)==255 or War_CanMoveXY(x+1,y,0)==false then
                num=num+1;
                steparray.x[num]=x+1;
                steparray.y[num]=y;
				SetWarMap(x+1,y,4,1) 
	--lib.Debug((x)..','..y..','..GetWarMap(x,y,4))
			else return x+1,y
			end
		end
	    if x-1>=0 and GetWarMap(x-1,y,4)==0 then                        --��ǰ���������ڸ�
			if GetWarMap(x-1,y,3)==255 or War_CanMoveXY(x-1,y,0)==false then
                num=num+1;
                steparray.x[num]=x-1;
                steparray.y[num]=y;
				SetWarMap(x-1,y,4,1) 
			else return x-1,y
			end
		end
	    if y+1<CC.WarWidth-1 and GetWarMap(x,y+1,4)==0 then                        --��ǰ���������ڸ�
			if GetWarMap(x,y+1,3)==255 or War_CanMoveXY(x,y+1,0)==false then
                num=num+1;
                steparray.x[num]=x;
                steparray.y[num]=y+1;
				SetWarMap(x,y+1,4,1) 
			else return x,y+1
			end
		end
	    if y-1>=0 and GetWarMap(x,y-1,4)==0 then                        --��ǰ���������ڸ�
			if GetWarMap(x,y-1,3)==255 or War_CanMoveXY(x,y-1,0)==false then
                num=num+1;
                steparray.x[num]=x;
                steparray.y[num]=y-1;
				SetWarMap(x,y-1,4,1) 
			else return x,y-1
			end
		end	
	--lib.Debug("b"..(x)..','..y..','..GetWarMap(x,y,4))
	end
	steparray.num=num
	return WE_FindNextxy(steparray)
	--local nx,ny=WE_FindNextxy(steparray)
	--return nx,ny
end

--]]
function WE_getwarid(pid)
	if WAR.PersonNum==nil then
		return -1;
	end
	for i=0,WAR.PersonNum-1 do
		if WAR.Person[i]["������"]==pid then return i end
	end
	return -1;
end

function WE_move(pid,x,y)
--pid,������
--x,y,Ŀ����������������ֵ
	local id=WE_getwarid(pid)
	if id==-1 then return end
	WAR.CurID=id
	local cx,cy=WAR.Person[id]["����X"],WAR.Person[id]["����Y"]
	local nx,ny=WE_xy(cx+x,cy+y,id)
	--lib.Debug(x..','..y..','..nx..','..ny)
	War_MovePerson(nx,ny)
	lib.Delay(100)
end

function WE_moveto(pid,x,y)
--pid,������
--x,y,Ŀ������
	local id=WE_getwarid(pid)
	if id==-1 then return end
	WAR.CurID=id
	local nx,ny=WE_xy(x,y,id)
	--lib.Debug(x..','..y..','..nx..','..ny)
	War_MovePerson(nx,ny)
	lib.Delay(100)
end

function WE_follow(pid,eid)
--pid,������
--id,Ŀ������ƶ�����Ŀ�����������λ��
	local a=WE_getwarid(pid)
	local b=WE_getwarid(eid)
	--lib.Debug(a..','..b)
	if a==-1 or b==-1 then return end
	WAR.CurID=a
	local x,y=WAR.Person[b]["����X"],WAR.Person[b]["����Y"]
	local nx,ny=WE_xy(x,y,a)
	--lib.Debug(pid..','..eid..','..a..','..b..','..x..','..y..','..nx..','..ny)
	War_MovePerson(nx,ny)
	lib.Delay(100)
end

function WE_addperson(id,x,y,faseto,jq,flag)
--id,ս�����¼ӵ������������
--x,y,����λ��
--flag,���ұ�ʶ
--faceto���﷽��0����1����2����3����
	faseto=faseto or 0
	if flag==nil then
		flag=true;
	end
	jq=jq or 200;
	local cx,cy=WE_xy(x,y)
	WAR.Person[WAR.PersonNum]["������"]=id;
	WAR.Person[WAR.PersonNum]["�ҷ�"]=flag;
	WAR.Person[WAR.PersonNum]["����X"]=cx;
	WAR.Person[WAR.PersonNum]["����Y"]=cy;
	WAR.Person[WAR.PersonNum]["����"]=false;
	WAR.Person[WAR.PersonNum]["�˷���"]=faseto;
	WAR.Person[WAR.PersonNum]["AI"]={2,0,0};
	if id==0 then
		WAR.Person[WAR.PersonNum]["AI"]={0,0,0};
	end
	WAR.Person[WAR.PersonNum]["��ͼ"]=WarCalPersonPic(WAR.PersonNum);
		--WAR.Person[i]["��ͼ"]=WarCalPersonPic(i);
	--WAR.Person[WAR.PersonNum]["AI"]=2;
	SetWarMap(cx,cy,2,WAR.PersonNum);
	SetWarMap(cx,cy,5,WAR.Person[WAR.PersonNum]["��ͼ"]);
	lib.PicLoadFile(string.format(CC.FightPicFile[1],JY.Person[id]["ս������"]),string.format(CC.FightPicFile[2],JY.Person[id]["ս������"]),4+WAR.PersonNum);
	WAR.Person[WAR.PersonNum]["�Ṧ"]=GetSpeed(id);
	WAR.Person[WAR.PersonNum]["Time"]=jq;
	GetJiqi(WAR.PersonNum);
	WAR.PersonNum=WAR.PersonNum+1
	--WAR.CurID=WAR.PersonNum-1
end

function WE_sort()
--���д��������¼�����
--��������ͼ���Ṧ�����
--δ������ȫ	
--���������������û���ˣ����ұ�����
	WarPersonSort(1)
	for i=0,WAR.PersonNum-1 do
		local pid=WAR.Person[i]["������"]
		lib.PicLoadFile(string.format(CC.FightPicFile[1],JY.Person[pid]["ͷ�����"]),string.format(CC.FightPicFile[2],JY.Person[pid]["ͷ�����"]),4+i);
		end
end

function WE_atk(id,cx,cy,kfid,lv,flag)
--�����书����
--���lvΪ�գ���ֻ�������﹥������
	CleanWarMap(4,0)
	local cid=WE_getwarid(id)
	local x0=WAR.Person[cid]["����X"];
	local y0=WAR.Person[cid]["����Y"];
	WAR.Person[cid]["�˷���"]=War_Direct(0,0,cx,cy) or WAR.Person[cid]["�˷���"]
	if lv~=nil then
		local kind,len1,len2=fenjie(JY.Wugong[kfid]["��Χ"..math.modf((lv+2)/3)])
		WarDrawAtt(x0+cx,y0+cy,kind,len1,len2,3,x0,y0)
	end
	local tmp=WAR.CurID
	WAR.CurID=cid
	War_ShowFight(id,kfid,JY.Wugong[kfid]["�书����"],lv,x0+cx,y0+cy,JY.Wugong[kfid]["�书����&��Ч"],0,0,0);
	WAR.CurID=tmp
	CleanWarMap(4,0)
end

function WE_close(id1,id2,len)
--�ж�����id֮��ľ��룬���С�ڵ���len�򷵻���
--���lenΪ���򷵻����˵ľ���
	--len=len or 1
	local cid1=WE_getwarid(id1);
	local cid2=WE_getwarid(id2);
	if cid1==-1 or cid2==-1 then
		if len==nil then
			return -1;
		else
			return false;
		end
	end
	local x1,y1=WAR.Person[cid1]["����X"],WAR.Person[cid1]["����Y"]
	local x2,y2=WAR.Person[cid2]["����X"],WAR.Person[cid2]["����Y"]
	local s;
	if WAR.Person[cid1]["����"] or WAR.Person[cid2]["����"] then
		s=math.huge;
	else
		s=math.abs(x1-x2)+math.abs(y1-y2);
	end
	if len==nil then return s
	elseif s<=len then return true
	else return false
	end
end

function WE_chuxian(id,x,y)
	local pid=WE_getwarid(id)
	local cx,cy=WE_xy(x,y)
	SetWarMap(cx,cy,2,pid);
	SetWarMap(cx,cy,5,WAR.Person[pid]["��ͼ"]);
	WAR.Person[pid]["����X"]=cx
	WAR.Person[pid]["����Y"]=cy
end

function WE_xiaoshi(id)
	local pid=WE_getwarid(id)
	local cx,cy=WAR.Person[pid]["����X"],WAR.Person[pid]["����Y"]
	SetWarMap(cx,cy,2,-1);
	SetWarMap(cx,cy,5,-1);
end
