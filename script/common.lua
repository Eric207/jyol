-------------------------------------------------------------------------------------
-----------------------------------ͨ�ú���-------------------------------------------

function between(v,Min,Max)
	if Min>Max then
		Min,Max=Max,Min;
	end
	if v>=Min and v<=Max then
		return true;
	end
	return false;
end

function PUSH(x)
	local id;
	Stack[0]=Stack[0]+1;
	id=Stack[0];
	Stack[id]=x;
end

function POP()
	local id=Stack[0];
	local vaule=0;
	if id>0 then
		Stack[0]=Stack[0]-1;
		vaule=Stack[id];
	end
	return vaule;
end

function filelength(filename)         --�õ��ļ�����
    local inp=io.open(filename,"rb");
	if inp==nil then
		return -1;
	end
    local l= inp:seek("end");
	inp:close();
    return l;
end

--��S������, (x,y) ���꣬level �� 0-5
function GetS(id,x,y,level)       --��S������
    return lib.GetS(id,x,y,level);
end

--дS��
function SetS(id,x,y,level,v)       --дS��
    lib.SetS(id,x,y,level,v);
end

--��D*
--sceneid ������ţ�
--id D*���
--Ҫ���ڼ�������, 0-10
function GetD(Sceneid,id,i)          --��D*
    return lib.GetD(Sceneid,id,i);
end

--дD��
function SetD(Sceneid,id,i,v)         --дD��
    lib.SetD(Sceneid,id,i,v);
end

function tablecopy(t1,t2)
	if type(t2)~='table' then
		t2=nil;
		t2={};
	end
	for i,v in pairs(t1) do
		if type(t1[i])=='table' then
			tablecopy(t1[i],t2[i]);
		elseif t2[i]==nil then
			t2[i]=v;
		end
	end
end

--�����ݵĽṹ�з�������
--data ����������
--offset data�е�ƫ��
--t_struct ���ݵĽṹ����jyconst���кܶඨ��
--key  ���ʵ�key
function GetDataFromStruct(data,offset,t_struct,key)  --�����ݵĽṹ�з������ݣ�����ȡ����
    local t=t_struct[key];
	local r;
	if t[2]==0 then
		if t[3]==2 then
			r=Byte.get16(data,t[1]+offset);
		else
			r=Byte.get32(data,t[1]+offset);
		end
	elseif t[2]==1 then
		if t[3]==2 then
			r=Byte.getu16(data,t[1]+offset);
		else
			r=Byte.getu32(data,t[1]+offset);
		end
	elseif t[2]==2 then
		if CC.SrcCharSet==1 then
			r=lib.CharSet(Byte.getstr(data,t[1]+offset,t[3]),0);
		else
			r=Byte.getstr(data,t[1]+offset,t[3]);
		end
	end
	return r;
end

function SetDataFromStruct(data,offset,t_struct,key,v)  --�����ݵĽṹ�з������ݣ���������
    local t=t_struct[key];
	if t[2]==0 then
		if t[3]==2 then
			Byte.set16(data,t[1]+offset,v);
		else
			Byte.set32(data,t[1]+offset,v);
		end
	elseif t[2]==1 then
		if t[3]==2 then
			Byte.setu16(data,t[1]+offset,v);
		else
			Byte.setu32(data,t[1]+offset,v);
		end
	elseif t[2]==2 then
		local s;
		if CC.SrcCharSet==1 then
			s=lib.CharSet(v,1);
		else
			s=v;
		end
		Byte.setstr(data,t[1]+offset,t[3],s);
	end
end

--����t_struct ����Ľṹ�����ݴ�data�����ƴ��ж�����t��
function LoadData(t,t_struct,data)        --data�����ƴ��ж�����t��
    for k,v in pairs(t_struct) do
        if v[2]==0 then
            t[k]=Byte.get16(data,v[1]);
        elseif v[2]==1 then
            t[k]=Byte.getu16(data,v[1]);
		elseif v[2]==2 then
            if CC.SrcCharSet==0 then
                t[k]=lib.CharSet(Byte.getstr(data,v[1],v[3]),0);
		    else
		        t[k]=Byte.getstr(data,v[1],v[3]);
		    end
		end
	end
end

--����t_struct ����Ľṹ������д��data Byte�����С�
function SaveData(t,t_struct,data)      --����д��data Byte�����С�
    for k,v in pairs(t_struct) do
        if v[2]==0 then
            Byte.set16(data,v[1],t[k]);
		elseif v[2]==1 then
            Byte.setu16(data,v[1],t[k]);
		elseif v[2]==2 then
		    local s;
			if CC.SrcCharSet==0 then
			    s=lib.CharSet(t[k],1);
            else
			    s=t[k];
		    end
            Byte.setstr(data,v[1],v[3],s);
		end
	end
end

function GetDataFromStruct(data,offset,t_struct,key)  --�����ݵĽṹ�з������ݣ�����ȡ����
    local t=t_struct[key];
	local r;
	local tmp;
	if t[2]==0 then
		if t[3]==2 then
			r=Byte.get16(data,t[1]+offset);
		else
			r=Byte.get32(data,t[1]+offset);
		end
	elseif t[2]==1 then
		if t[3]==2 then
			r=Byte.getu16(data,t[1]+offset);
		else
			r=Byte.getu32(data,t[1]+offset);
		end
	elseif t[2]==2 then
		if CC.SrcCharSet==1 then
			r=lib.CharSet(Byte.getstr(data,t[1]+offset,t[3]),0);
		else
			r=Byte.getstr(data,t[1]+offset,t[3]);
		end
	end
	
	if data==JY.Data_Base then
		tmp=CC.Mem_Base[t[1]+offset];
	elseif data==JY.Data_Person then
		tmp=CC.Mem_Person[t[1]+offset];
	elseif data==JY.Data_Thing then
		tmp=CC.Mem_Thing[t[1]+offset];
	elseif data==JY.Data_Scene then
		tmp=CC.Mem_Scene[t[1]+offset];
	elseif data==JY.Data_Wugong then
		tmp=CC.Mem_Wugong[t[1]+offset];
	elseif data==JY.Data_Shop then
		tmp=CC.Mem_Shop[t[1]+offset];
	end
	return r;
end

function SetDataFromStruct(data,offset,t_struct,key,v)  --�����ݵĽṹ�з������ݣ���������
    local t=t_struct[key];
	--�������ڵ�ֵ(��Ϸ�еĸ�ֵ)��֮����Ժ�ʵ�ʶ�ȡ��ֵ���бȽ���ȷ���Ƿ�����
	if type(v)=="number" then
		v=math.modf(v);
	end
	if data==JY.Data_Base then
		CC.Mem_Base[t[1]+offset]=v;
	elseif data==JY.Data_Person then
		CC.Mem_Person[t[1]+offset]=v;
	elseif data==JY.Data_Thing then
		CC.Mem_Thing[t[1]+offset]=v;
	elseif data==JY.Data_Scene then
		CC.Mem_Scene[t[1]+offset]=v;
	elseif data==JY.Data_Wugong then
		CC.Mem_Wugong[t[1]+offset]=v;
	elseif data==JY.Data_Shop then
		CC.Mem_Shop[t[1]+offset]=v;
	end
	
	if t[2]==0 then
		if t[3]==2 then
			Byte.set16(data,t[1]+offset,v);
		else
			Byte.set32(data,t[1]+offset,v);
		end
	elseif t[2]==1 then
		if t[3]==2 then
			Byte.setu16(data,t[1]+offset,v);
		else
			Byte.setu32(data,t[1]+offset,v);
		end
	elseif t[2]==2 then
		local s;
		if CC.SrcCharSet==1 then
			s=lib.CharSet(v,1);
		else
			s=v;
		end
		Byte.setstr(data,t[1]+offset,t[3],s);
	end
end

function limitX(x,minv,maxv)       --����x�ķ�Χ
    if x<minv then
	    x=minv;
	elseif x>maxv then
	    x=maxv;
	end
	return x
end

function RGB(r,g,b)          --������ɫRGB
   return r*65536+g*256+b;
end

function GetRGB(color)      --������ɫ��RGB����
    color=color%(65536*256);
    local r=math.floor(color/65536);
    color=color%65536;
    local g=math.floor(color/256);
    local b=color%256;
    return r,g,b
end

--�ȴ���������
function WaitKey(delay)       --�ȴ���������
    local eventtype,keypress,x,y=-1,-1,-1,-1;
	local stime=lib.GetTime()
	delay=delay or 0;
    while true do
		eventtype,keypress,x,y=getkey();--lib.GetKey();
		if eventtype == 1 or eventtype >= 3 or (delay==1 and eventtype == 2) then
			break;
	    end
        lib.Delay(10);
		if delay>1 then
			if lib.GetTime()-stime>delay then
				break;
			end
		end
	end
	return eventtype,keypress,x,y;
end
function Delay(t)
	for i=1,t do
		lib.Delay(100);
		getkey();
	end
end
function MyDrawString(x1,x2,y,str,color,size) 
	local len=math.modf(string.len(str)*size/4)
	local x=math.modf((x1+x2)/2)-len
    DrawString(x,y,str,color,size);
end

--����һ���������İ�ɫ�����Ľǰ���
function DrawBox(x1,y1,x2,y2,color,bjcolor)         --����һ���������İ�ɫ����
    local s=4;
	bjcolor=bjcolor or 0;
	if bjcolor>=0 then
		lib.Background(x1,y1+s,x1+s,y2-s,128,bjcolor);    --��Ӱ���Ľǿճ�
		lib.Background(x1+s,y1,x2-s,y2,128,bjcolor);
		lib.Background(x2-s,y1+s,x2,y2-s,128,bjcolor);
	end
	if color>=0 then
		local r,g,b=GetRGB(color);
		DrawBox_1(x1+1,y1,x2,y2,RGB(math.modf(r/2),math.modf(g/2),math.modf(b/2)));
		DrawBox_1(x1,y1,x2-1,y2-1,color);
	end
end

--�����Ľǰ����ķ���
function DrawBox_1(x1,y1,x2,y2,color)       --�����Ľǰ����ķ���
    local s=4;
    lib.DrawRect(x1+s,y1,x2-s,y1,color);
    lib.DrawRect(x2-s,y1,x2-s,y1+s,color);
    lib.DrawRect(x2-s,y1+s,x2,y1+s,color);
    lib.DrawRect(x2,y1+s,x2,y2-s,color);
    lib.DrawRect(x2,y2-s,x2-s,y2-s,color);
    lib.DrawRect(x2-s,y2-s,x2-s,y2,color);
    lib.DrawRect(x2-s,y2,x1+s,y2,color);
    lib.DrawRect(x1+s,y2,x1+s,y2-s,color);
    lib.DrawRect(x1+s,y2-s,x1,y2-s,color);
    lib.DrawRect(x1,y2-s,x1,y1+s,color);
    lib.DrawRect(x1,y1+s,x1+s,y1+s,color);
    lib.DrawRect(x1+s,y1+s,x1+s,y1,color);
end
--NewBox
function DrawNewBox1(x1,y1,x2,y2,color,bjcolor)
	DrawNewBox(x1+4,y1+4,x2-5,y2-4,color,bjcolor)
end
function DrawNewBox(x1,y1,x2,y2,color,bjcolor)         --����һ���������İ�ɫ����
    local s=4;
	bjcolor=bjcolor or 0;
	if bjcolor>=0 then
		lib.Background(x1,y1+s,x1+s,y2-s,128,bjcolor);    --��Ӱ
		lib.Background(x2-s,y1+s,x2,y2-s,128,bjcolor);
		lib.Background(x1+s,y1,x2-s,y2,128,bjcolor);
	end
	--[[s=3;
	x1=x1+s;
	y1=y1+s;
	x2=x2-s;
	y2=y2-s;]]--
	if color>=0 then
		local r,g,b=GetRGB(color);
		DrawNewBox_1(x1-1,y1-1,x2+1,y2+1,RGB(math.modf(r/2),math.modf(g/2),math.modf(b/2)));
		DrawNewBox_1(x1+1,y1+1,x2-1,y2-1,RGB(math.modf(r/2),math.modf(g/2),math.modf(b/2)));
		DrawNewBox_1(x1,y1,x2,y2,color);
	end
end

--�����Ľǰ����ķ���
function DrawNewBox_1(x1,y1,x2,y2,color)       --�����Ľǰ����ķ���
    local s=3;
    lib.DrawLine(x1-s,y1-s,x2+s,y1-s,color);
    lib.DrawLine(x1-s,y2+s,x2+s,y2+s,color);
    lib.DrawLine(x1-s,y1-s,x1-s,y2+s,color);
    lib.DrawLine(x2+s,y1-s,x2+s,y2+s,color);
	s=4;
    lib.DrawLine(x1-s,y1-s,x2+s,y1-s,color);
    lib.DrawLine(x1-s,y2+s,x2+s,y2+s,color);
    lib.DrawLine(x1-s,y1-s,x1-s,y2+s,color);
    lib.DrawLine(x2+s,y1-s,x2+s,y2+s,color);
	
    lib.DrawLine(x1,y1,x2,y1,color);
    lib.DrawLine(x1,y2,x2,y2,color);
    lib.DrawLine(x1,y1,x1,y2,color);
    lib.DrawLine(x2,y1,x2,y2,color);
	--s=4
    lib.DrawLine(x1-s,y1+s,x1+s,y1+s,color);
    lib.DrawLine(x1+s,y1-s,x1+s,y1+s,color);
    lib.DrawLine(x2-s,y1+s,x2+s,y1+s,color);
    lib.DrawLine(x2-s,y1-s,x2-s,y1+s,color);
    lib.DrawLine(x1-s,y2-s,x1+s,y2-s,color);
    lib.DrawLine(x1+s,y2-s,x1+s,y2+s,color);
    lib.DrawLine(x2-s,y2-s,x2+s,y2-s,color);
    lib.DrawLine(x2-s,y2-s,x2-s,y2+s,color);
end
function DrawCircleBox(x1,y1,x2,y2,color)         --����һ���������Ļ���Բ�Ƿ���
    local s=4;
	lib.Background(x1+4,y1,x2-4,y1+s,128);
	lib.Background(x1+1,y1+1,x1+s,y1+s,128);
	lib.Background(x2-s,y1+1,x2-1,y1+s,128);
	lib.Background(x1,y1+4,x2,y2-4,128);
	lib.Background(x1+1,y2-s,x1+s,y2-1,128);
	lib.Background(x2-s,y2-s+1,x2-1,y2,128);
	lib.Background(x1+4,y2-s,x2-4,y2,128);
    local r,g,b=GetRGB(color);
	local color2=RGB(math.modf(r/2),math.modf(g/2),math.modf(b/2));
    --DrawBox_1(x1-1,y1-1,x2-1,y2-1,color2);
    --DrawBox_1(x1+1,y1-1,x2+1,y2-1,color2);
    --DrawBox_1(x1-1,y1+1,x2-1,y2+1,color2);
    DrawCircleBox_1(x1+1,y1+1,x2+1,y2+1,color2);
    DrawCircleBox_1(x1,y1,x2,y2,color);
	--------
	
end
function DrawCircleBox_1(x1,y1,x2,y2,color)       --����Բ�Ƿ���
    local s=4;
	lib.DrawRect(x1+s,y1,x2-s,y1,color);
	lib.DrawRect(x1+s,y2,x2-s,y2,color);
	lib.DrawRect(x1,y1+s,x1,y2-s,color);
	lib.DrawRect(x2,y1+s,x2,y2-s,color);
	lib.DrawRect(x1+2,y1+1,x1+s-1,y1+1,color);
	lib.DrawRect(x1+1,y1+2,x1+1,y1+s-1,color);
	lib.DrawRect(x2-s+1,y1+1,x2-2,y1+1,color);
	lib.DrawRect(x2-1,y1+2,x2-1,y1+s-1,color);
	
	lib.DrawRect(x1+2,y2-1,x1+s-1,y2-1,color);
	lib.DrawRect(x1+1,y2-s+1,x1+1,y2-2,color);
	lib.DrawRect(x2-s+1,y2-1,x2-2,y2-1,color);
	lib.DrawRect(x2-1,y2-s+1,x2-1,y2-2,color);
end
--��ʾ��Ӱ�ַ���
function DrawString(x,y,str,color,size)         --��ʾ��Ӱ�ַ���
--    local r,g,b=GetRGB(color);
--    lib.DrawStr(x+1,y+1,str,RGB(math.modf(r/2),math.modf(g/2),math.modf(b/2)),size,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
    --lib.DrawStr(x,y,str,color,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
	local T2={{"��",C_RED},{"��",C_GOLD},{"��",C_BLACK},{"��",C_WHITE},{"��",C_ORANGE},{"��",M_Yellow}};
	local position=0;
	local s=0;
	while string.len(str)>=1 do
		local try=string.sub(str,1,1)
		if string.byte(try)>127 then	--����
			local s=string.sub(str,1,2);
			str=string.sub(str,3,-1);
			local control=false
			for i,v in pairs(T2) do
				if s==v[1] then
					color=v[2];
					control=true;
					break;
				end
			end
			if not control then
				lib.DrawStr(x+position,y,s,color,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
				position=position+lib.GetStrWidth(s,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
			end
		else
			local s=try;--string.sub(str,1,1);
			str=string.sub(str,2,-1);
			lib.DrawStr(x+position,y,s,color,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
			position=position+lib.GetStrWidth(s,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
		end
	end
end

--��ʾ��ѯ��Y/N��������Y���򷵻�true, N�򷵻�false
--(x,y) ���꣬�����Ϊ-1,������Ļ�м���ʾ
--��Ϊ�ò˵�ѯ���Ƿ�
function DrawStrBoxYesNo(x,y,str,color,size)        --��ʾ�ַ�����ѯ��Y/N
    lib.GetKey();
	color=color or C_WHITE;
	size=size or CC.Fontbig;
    local ll=Mylen(str);
    local w=size*ll/2+2*CC.MenuBorderPixel;
	local h=size+2*CC.MenuBorderPixel;
	if x==-1 then
        x=(CC.ScreenW-size/2*ll-2*CC.MenuBorderPixel)/2;
	end
	if y==-1 then
        y=(CC.ScreenH-size-2*CC.MenuBorderPixel)/2;
	end

    DrawStrNewBox(x,y,str,color,size);
    local menu={{"ȷ��/��",nil,1},
	            {"ȡ��/��",nil,2}};
	local bk=JY.Menu_keep;
	JY.Menu_keep=false;
	local r=ShowMenu(menu,2,0,x+w-3.5*size-2*CC.MenuBorderPixel,y+h+CC.MenuBorderPixel*3,0,0,1,0,CC.Fontbig,C_ORANGE, C_WHITE);
	JY.Menu_keep=bk;
	Cls();
    if r==1 then
	    return true;
	else
	    return false;
	end

end

function DrawStrCenter(str)
	--DrawString(CC.ScreenW/2-Mylen(s)*size/4,CC.ScreenH/2-16,s,C_WHITE,size,C_WHITE);
	local xnum,ynum=12,3;
	local size=CC.Fontbig;
	local x=(CC.ScreenW-size*xnum)/2;
	local y=(CC.ScreenH-size*ynum-CC.RowPixel*(ynum-1))/2;
	local T2={{"��",C_RED},{"��",C_GOLD},{"��",C_BLACK},{"��",C_WHITE},{"��",C_ORANGE},{"��",M_Yellow}};
	local cx,cy=0,0;
	local delay_time=50;
	local color=C_WHITE;
	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	while string.len(str)>=1 do
		local try=string.sub(str,1,1)
		local control=false;
		if string.byte(try)>127 then	--����
			local s=string.sub(str,1,2);
			str=string.sub(str,3,-1);
			for i,v in pairs(T2) do
				if s==v[1] then
					color=v[2];
					control=true;
					break;
				end
			end
			if not control then
				lib.DrawStr(x+size*cx,y+(size+CC.RowPixel)*cy,s,color,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
				cx=cx+1;
			end
		else
			local s=try;--string.sub(str,1,1);
			str=string.sub(str,2,-1);
			lib.DrawStr(x+size*cx,y+(size+CC.RowPixel)*cy,s,color,size,CC.FontName,CC.SrcCharSet,CC.OSCharSet);
			cx=cx+0.5;
		end
		if not control then
			ShowScreen();
			getkey();
			lib.Delay(delay_time);
			if cx>xnum then
				cx=0;
				cy=cy+1;
				if cy>=ynum then
					cy=0;
					WaitKey();
					lib.LoadSur(sid,0,0);
				end
			end
		end
	end
	lib.FreeSur(sid);
end
--��ʾ�ַ������ȴ��������ַ���������ʾ����Ļ�м�
function DrawStrBoxWaitKey(s,color,size,flag)          --��ʾ�ַ������ȴ�����
	color=color or C_WHITE;
	size=size or CC.Fontbig;
    lib.GetKey();
	if flag==nil then
		Cls();
	end
    DrawStrNewBox(-1,-1,s,color,size);
    ShowScreen();
	lib.Delay(200);
    WaitKey();
	Cls();
end

--���� [0 , i-1] �����������
function Rnd(i)           --�����
    local r=math.random(i);
    return r-1;
end

--�����������ԣ���������ֵ���ƣ���Ӧ�����ֵ���ơ���Сֵ������Ϊ0
--id ����id
--str�����ַ���
--value Ҫ���ӵ�ֵ��������ʾ����
--����1,ʵ�����ӵ�ֵ
--����2���ַ�����xxx ����/���� xxxx��������ʾҩƷЧ��
function AddPersonAttrib(id,str,value)            --������������
    local oldvalue=JY.Person[id][str];
    local attribmax=math.huge;
    if str=="����" then
        attribmax=JY.Person[id]["�������ֵ"] ;
    elseif str=="����" then
        attribmax=JY.Person[id]["�������ֵ"] ;
    else
        if CC.PersonAttribMax[str] ~= nil then
            attribmax=CC.PersonAttribMax[str];
        end
    end
	local attribmin=0;
	if str=="�Ѻ�" then
		attribmin=1;
	end
    local newvalue=limitX(oldvalue+value,attribmin,attribmax);
    JY.Person[id][str]=newvalue;
    local add=newvalue-oldvalue;

    local showstr="";
    if add>0 then
        showstr=string.format("%s ���� %d",str,add);
    elseif add<0 then
        showstr=string.format("%s ���� %d",str,-add);
    end
    return add,showstr;
end

--����midi
function PlayMIDI(id)             --����midi
	id=id or 0
    JY.CurrentMIDI=id;
    if JY.EnableMusic==0 then
        return ;
    end
    if id>=1 then--id>=0 then
        --lib.PlayMIDI(string.format(CC.MIDIFile,id+1));
        lib.PlayMIDI(string.format(CC.MP3File,id));
    end
end

--������Чatk***
function PlayWavAtk(id)             --������Чatk***
    if JY.EnableSound==0 then
        return ;
    end
    if id>=0 then
        lib.PlayWAV(string.format(CC.ATKFile,id));
    end
end

--������Чe**
function PlayWavE(id)              --������Чe**
    if JY.EnableSound==0 then
        return ;
    end
    if id>=0 then
        lib.PlayWAV(string.format(CC.EFile,id));
    end
end

--���(x1,y1)-(x2,y2)�����ڵ����ֵȡ�
--���û�в����������������Ļ����
--ע��ú�������ֱ��ˢ����ʾ��Ļ
function Cls(x1,y1,x2,y2)                    --�����Ļ
    if x1==nil then        --��һ������Ϊnil,��ʾû�в�������ȱʡ
	    x1=0;
		y1=0;
		x2=0;
		y2=0;
	end
	lib.SetClip(x1,y1,x2,y2);
	if JY.Status==GAME_START then
	    lib.FillColor(0,0,0,0,0);
        lib.LoadPicture(CC.FirstFile,-1,-1);
	elseif JY.Status==GAME_MMAP then
        lib.DrawMMap(JY.Base["��X"],JY.Base["��Y"],GetMyPic());             --��ʾ����ͼ
		DrawState();
	elseif JY.Status==GAME_SMAP then
        DrawSMap();
	elseif JY.Status==GAME_WMAP then
        WarDrawMap(0);
	elseif JY.Status==GAME_DEAD then
	    lib.FillColor(0,0,0,0,0);
        lib.LoadPicture(CC.DeadFile,-1,-1);
	end
	lib.SetClip(0,0,0,0);
end

--flag =0 or nil ȫ��ˢ����Ļ
--      1 ��������εĿ���ˢ��
function ShowScreen(flag)              --ˢ����Ļ��ʾ
	--���ƶ�����Ϣ
	if JY.Status==GAME_START then
		DrawString(CC.ScreenW-CC.FontSmall*(1+#CC.Version/2),CC.ScreenH-CC.FontSmall*2,CC.Version,C_GOLD,CC.FontSmall)
	elseif CC.ShowXY~=1 then
		
	elseif JY.Status==GAME_MMAP then
		DrawString(10,CC.ScreenH*0.95,string.format("���ͼ %d %d",JY.Base["��X"],JY.Base["��Y"]) ,C_GOLD,CC.FontSmall);
		DrawString(CC.ScreenW-CC.FontSmall*9,8,os.date("%c"),C_GOLD,CC.FontSmall);
	elseif JY.Status==GAME_SMAP then
		DrawString(10,CC.ScreenH*0.95,string.format("%s %d %d",JY.Scene[JY.SubScene]["����"],JY.Base["��X1"],JY.Base["��Y1"]) ,C_GOLD,CC.FontSmall);
		DrawString(CC.ScreenW-CC.FontSmall*9,8,os.date("%c"),C_GOLD,CC.FontSmall);
	elseif JY.Status==GAME_WMAP then
		DrawString(10,CC.ScreenH*0.95,string.format("ս��:%s %d %d",JY.Scene[JY.SubScene]["����"],WAR.Person[WAR.CurID]["����X"],WAR.Person[WAR.CurID]["����Y"]) ,C_GOLD,CC.FontSmall);
		DrawString(CC.ScreenW-CC.FontSmall*9,8,os.date("%c"),C_GOLD,CC.FontSmall);
	end
	lib.ShowSurface(flag);
end

--ͨ�ò˵�����
-- menuItem ��ÿ���һ���ӱ�����Ϊһ���˵���Ķ���
--          �˵����Ϊ  {   ItemName,     �˵��������ַ���
--                          ItemFunction, �˵����ú��������û����Ϊnil
--                          Visible       �Ƿ�ɼ�  0 ���ɼ� 1 �ɼ�, 2 �ɼ�����Ϊ��ǰѡ���ֻ����һ��Ϊ2��
--                                        ������ֻȡ��һ��Ϊ2�ģ�û�����һ���˵���Ϊ��ǰѡ���
--                                        ��ֻ��ʾ���ֲ˵�������´�ֵ��Ч��
--                                        ��ֵĿǰֻ�����Ƿ�˵�ȱʡ��ʾ������
--                       }
--          �˵����ú���˵����         itemfunction(newmenu,id)
--
--       ����ֵ
--              0 �������أ������˵�ѭ�� 1 ���ú���Ҫ���˳��˵��������в˵�ѭ��
--
-- numItem      �ܲ˵������
-- numShow      ��ʾ�˵���Ŀ������ܲ˵���ܶ࣬һ����ʾ���£�����Զ����ֵ
--                =0��ʾ��ʾȫ���˵���

-- (x1,y1),(x2,y2)  �˵���������ϽǺ����½����꣬���x2,y2=0,������ַ������Ⱥ���ʾ�˵����Զ�����x2,y2
-- isBox        �Ƿ���Ʊ߿�0 �����ƣ�1 ���ơ������ƣ�����(x1,y1,x2,y2)�ľ��λ��ư�ɫ���򣬲�ʹ�����ڱ����䰵
-- isEsc        Esc���Ƿ������� 0 �������ã�1������
-- Size         �˵��������С
-- color        �����˵�����ɫ����ΪRGB
-- selectColor  ѡ�в˵�����ɫ,
--;
-- ����ֵ  0 Esc����
--         >0 ѡ�еĲ˵���(1��ʾ��һ��)
--         <0 ѡ�еĲ˵�����ú���Ҫ���˳����˵�����������˳����˵�
function EasyMenu(menuItem)
	local n=0
	for i,v in pairs(menuItem) do
		n=n+1;
	end
	return ShowMenu(menuItem,n,0,0,0,0,0,1,0);
end
function ShowMenu(menuItem,numItem,numShow,x1,y1,x2,y2,isBox,isEsc,size,color,selectColor,justshow)     --ͨ�ò˵�����
    local w=0;
    local h=0;   --�߿�Ŀ��
    local i=0;
    local num=0;     --ʵ�ʵ���ʾ�˵���
    local newNumItem=0;  --�ܹ���ʾ���ܲ˵�����
	justshow=justshow or 0;
	size=size or CC.Fontbig;
	color=color or C_ORANGE;
	selectColor=selectColor or C_WHITE;
    getkey();

    local newMenu={};   -- �����µ����飬�Ա�����������ʾ�Ĳ˵���

    --�����ܹ���ʾ���ܲ˵�����
    for i=1,numItem do
        if menuItem[i][3]>0 then
            newNumItem=newNumItem+1;
            newMenu[newNumItem]={menuItem[i][1],menuItem[i][2],menuItem[i][3],i};   --���������[4],�����ԭ����Ķ�Ӧ
        end
    end

    --����ʵ����ʾ�Ĳ˵�����
    if numShow==0 or numShow > newNumItem then
        num=newNumItem;
    else
        num=numShow;
    end

    --����߿�ʵ�ʿ��
    local maxlength=0;
    if x2==0 and y2==0 then
        for i=1,newNumItem do
            if string.len(newMenu[i][1])>maxlength then
                maxlength=string.len(newMenu[i][1]);
            end
        end
        w=size*maxlength/2+2*CC.MenuBorderPixel;        --���հ�����ּ����ȣ�һ����4������
        h=(size+CC.RowPixel)*num+CC.MenuBorderPixel;            --��֮����4�����أ���������4������
    else
        w=x2-x1;
        h=y2-y1;
		num=math.min(num,(math.modf(h/(size+CC.RowPixel))));
    end
	
	if x1==0 and y1==0 then
		x1=(CC.ScreenW-w)/2;
		y1=(CC.ScreenH-h)/2;
	end
	if x1==-1 then
		x1=(CC.ScreenW-w)/2;
	end
	if y1==-1 then
		y1=(CC.ScreenH-h)/2;
	end
	
    local start=1;             --��ʾ�ĵ�һ��

	local current =1;          --��ǰѡ����
	for i=1,newNumItem do
	    if newMenu[i][3]==2 then
		    current=i;
			break;
		end
	end
				if current > num then
					start=1+current-num;
				end
	--[[
	if numShow~=0 then
	    current=1;
	end]]--
	if JY.Menu_keep then
		start=JY.Menu_start;
		current=JY.Menu_current;
	end
	local surid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
    local keyPress =-1;
    local returnValue =0;
	if isBox==1 then
		DrawNewBox(x1,y1,x1+w,y1+h,C_WHITE);
	elseif isBox==2 then
		DrawBox(x1,y1,x1+w,y1+h,C_WHITE);
	end
	local function redraw(flag)
		if num~=0 then --����������
	        --Cls(x1,y1,x1+w,y1+h);
			lib.LoadSur(surid,0,0);
			if isBox==1 then
				DrawNewBox(x1,y1,x1+w,y1+h,C_WHITE);
			elseif isBox==2 then
				DrawBox(x1,y1,x1+w,y1+h,C_WHITE);
			end
		end

	    for i=start,start+num-1 do
  	        local drawColor=color;           --���ò�ͬ�Ļ�����ɫ
			local menustr=newMenu[i][1];
	        if i==current then
	            drawColor=selectColor;
				local xx1,xx2,yy1,yy2;
				local s=4;
				xx1=x1+2;
				xx2=x1+w-1;
				yy1=y1+1+(i-start)*(size+CC.RowPixel);
				yy2=yy1+2+size+CC.RowPixel;
				lib.Background(xx1,yy1+s,xx1+s,yy2-s,128,color);    --��Ӱ���Ľǿճ�
				lib.Background(xx1+s,yy1,xx2-s,yy2,128,color);
				lib.Background(xx2-s,yy1+s,xx2,yy2-s,128,color);
	        end
			DrawString(x1+CC.MenuBorderPixel,y1+CC.MenuBorderPixel+(i-start)*(size+CC.RowPixel),
			           menustr,drawColor,size);

	    end
		if flag then
			lib.Background(x1,y1,x1+w,y1+h,128);
		end
	end
    while true do
	    --if numShow ~=0 then	--??��̫����Ϊʲô����д
		redraw();
		if justshow>0 then
			if type(newMenu[current][2])=="function" then
				newMenu[current][2](newMenu[current][4]);               --���ò˵�����
			end
		end
	    ShowScreen();
		local eventtype,keyPress,mx,my=WaitKey(1);
		lib.Delay(25);
		if eventtype==1 then
			if keyPress==VK_ESCAPE then                  --Esc �˳�
				if isEsc==1 then
					break;
				end
			elseif keyPress==VK_DOWN then                --Down
				current = current +1;
				if current > (start + num-1) then
					start=start+1;
				end
				if current > newNumItem then
					start=1;
					current =1;
				end
			elseif keyPress==VK_UP then                  --Up
				current = current -1;
				if current < start then
					start=start-1;
				end
				if current < 1 then
					current = newNumItem;
					start =current-num+1;
				end
			elseif   (keyPress==VK_SPACE) or (keyPress==VK_RETURN) then--or (keyPress==VK_RIGHT) then
				if newMenu[current][2]==nil or justshow>0 then
					returnValue=newMenu[current][4];
					break;
				else
					redraw(1);
					local r=newMenu[current][2](newMenu,newMenu[current][4],0);               --���ò˵�����
					if r==1 then
						returnValue=newMenu[current][4];
						break;
					else
						--Cls(x1,y1,x1+w,y1+h);
						lib.LoadSur(surid,0,0);
						if isBox==1 then
							DrawNewBox(x1,y1,x1+w,y1+h,C_WHITE);
						elseif isBox==2 then
							DrawBox(x1,y1,x1+w,y1+h,C_WHITE);
						end
					end
				end
			end
		elseif eventtype==2 then
			if mx>x1 and mx<x1+w and my>y1 and my<y1+h then
				current=start+math.modf((my-y1-CC.MenuBorderPixel)/(size+CC.RowPixel));
				current=limitX(current,1,newNumItem);
			end
		elseif eventtype==3 then
			if keyPress==1 then
				if mx>x1 and mx<x1+w and my>y1 and my<y1+h then
					current=start+math.modf((my-y1-CC.MenuBorderPixel)/(size+CC.RowPixel));
					current=limitX(current,1,newNumItem);
					if newMenu[current][2]==nil or justshow>0 then
						returnValue=newMenu[current][4];
						break;
					else
						redraw(1);
						local r=newMenu[current][2](newMenu,newMenu[current][4],0);               --���ò˵�����
						if r==1 then
							returnValue=newMenu[current][4];
							break;
						else
							--Cls(x1,y1,x1+w,y1+h);
							lib.LoadSur(surid,0,0);
							if isBox==1 then
								DrawNewBox(x1,y1,x1+w,y1+h,C_WHITE);
							elseif isBox==2 then
								DrawBox(x1,y1,x1+w,y1+h,C_WHITE);
							end
						end
					end
				end
			elseif keyPress==3 then
				if isEsc==1 then
					break;
				end
			elseif keyPress==4 then
				start=start-1
			elseif keyPress==5 then
				start=start+1
			end
		end
    end

	if JY.Menu_keep then
		JY.Menu_start=start;
		JY.Menu_current=current;
	end
    --Cls(x1,y1,x1+w+1,y1+h+1,0,1);
	lib.LoadSur(surid,0,0);
	lib.FreeSur(surid);
    return returnValue;
end

--������ʾ�˵���������ShowMenuһ��
function ShowMenu2(menuItem,numItem,numShow,x1,y1,x2,y2,isBox,isEsc,size,color,selectColor,justshow)     --ͨ�ò˵�����
    local w=0;
    local h=0;   --�߿�Ŀ��
    local i=0;
    local num=0;     --ʵ�ʵ���ʾ�˵���
    local newNumItem=0;  --�ܹ���ʾ���ܲ˵�����
	justshow=justshow or 0;
    lib.GetKey();
	local x_off=0;
    local newMenu={};   -- �����µ����飬�Ա�����������ʾ�Ĳ˵���

    --�����ܹ���ʾ���ܲ˵�����
    for i=1,numItem do
        if menuItem[i][3]>0 then
            newNumItem=newNumItem+1;
            newMenu[newNumItem]={menuItem[i][1],menuItem[i][2],menuItem[i][3],i};   --���������[4],�����ԭ����Ķ�Ӧ
        end
    end

    --����ʵ����ʾ�Ĳ˵�����
    if numShow==0 or numShow > newNumItem then
        num=newNumItem;
    else
        num=numShow;
    end

    --����߿�ʵ�ʿ��
	local maxlength=0;
	for i=1,newNumItem do
		if string.len(newMenu[i][1])>maxlength then
			maxlength=string.len(newMenu[i][1]);
		end
    end
    if x2==0 and y2==0 then
		w=(size*maxlength/2+CC.RowPixel)*num+CC.MenuBorderPixel;
		if isBox==2 then
			w=w+CC.MenuBorderPixel*2*num;
		end
		h=size+2*CC.MenuBorderPixel;
    else
        w=x2-x1;
        h=y2-y1;
		x_off=(w-CC.MenuBorderPixel-(maxlength*size/2+CC.RowPixel)*num)/2;
    end
	if x1==0 then
		x1=(CC.ScreenW-w)/2;
	end
    local start=1;             --��ʾ�ĵ�һ��

    local current =1;          --��ǰѡ����
	for i=1,newNumItem do
	    if newMenu[i][3]==2 then
		    current=i;
			break;
		end
	end
	if numShow~=0 then
	    current=1;
	end

	local surid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
    local keyPress =-1;
    local returnValue =0;
	if isBox==1 then
		DrawNewBox(x1,y1,x1+w,y1+h,C_WHITE);
	end
	local function redraw(flag)
	    if num ~=0 then
	        --Cls(x1,y1,x1+w,y1+h);
			lib.LoadSur(surid,0,0);
			if isBox==1 then
				DrawNewBox(x1,y1,x1+w,y1+h,C_WHITE);
			end
		end

	    for i=start,start+num-1 do
  	        local drawColor=color;           --���ò�ͬ�Ļ�����ɫ
			local bjcolor;
	        if i==current then
	            drawColor=selectColor;
				bjcolor=color;
	        end
			if isBox==2 then
				DrawStrNewBox(x1+(i-start)*(CC.MenuBorderPixel*2+size*maxlength/2+CC.RowPixel),
						y1,newMenu[i][1],drawColor,size,bjcolor);
			else
				if i==current then
					local xx1,xx2,yy1,yy2;
					local s=4;
					xx1=x1+x_off+(i-start)*(size*maxlength/2+CC.RowPixel)+2;
					xx2=xx1+size*maxlength/2+CC.RowPixel;
					yy1=y1+1;
					yy2=yy1+h-2;--2+size+CC.RowPixel;
					lib.Background(xx1,yy1+s,xx1+s,yy2-s,128,color);    --��Ӱ���Ľǿճ�
					lib.Background(xx1+s,yy1,xx2-s,yy2,128,color);
					lib.Background(xx2-s,yy1+s,xx2,yy2-s,128,color);
				end
				DrawString(x1+x_off+CC.MenuBorderPixel+(i-start)*(size*maxlength/2+CC.RowPixel),
						y1+CC.MenuBorderPixel,newMenu[i][1],drawColor,size,bjcolor);
			end
	    end
		if flag then
			lib.Background(x1,y1,x1+w,y1+h,128);
		end
	end
    while true do
		redraw();
		if justshow>0 then
			if newMenu[current][2]==nil then
				returnValue=newMenu[current][4];
			else
				if justshow>1 then
					redraw(1);
				end
				local r=newMenu[current][2](newMenu,newMenu[current][4],justshow);               --���ò˵�����
				if r==-1 then
					returnValue=-1 --newMenu[current][4];
					break;
				else
					returnValue=newMenu[current][4];
				end
			end
			if justshow>1 then
				--break;
				lib.FreeSur(surid);
				return returnValue;
			end
		end
	    ShowScreen();
		local eventtype,keyPress,mx,my=WaitKey(1);
		lib.Delay(100);
		if eventtype==1 then
			if keyPress==VK_ESCAPE then                  --Esc �˳�
				if isEsc==1 then
					break;
				end
			elseif keyPress==VK_RIGHT then                --Down
				current = current +1;
				if current > (start + num-1) then
					start=start+1;
				end
				if current > newNumItem then
					start=1;
					current =1;
				end
			elseif keyPress==VK_LEFT then                  --Up
				current = current -1;
				if current < start then
					start=start-1;
				end
				if current < 1 then
					current = newNumItem;
					start =current-num+1;
				end
			elseif   (keyPress==VK_SPACE) or (keyPress==VK_RETURN) or (keyPress==VK_DOWN) then
				if newMenu[current][2]==nil then
					returnValue=newMenu[current][4];
					break;
				else
					redraw(1);
					local r=newMenu[current][2](newMenu,newMenu[current][4],0);               --���ò˵�����
					if r==-1 then
						returnValue=-1 --newMenu[current][4];
						break;
					else
						--Cls(x1,y1,x1+w,y1+h);
						lib.LoadSur(surid,0,0);
						if isBox==1 then
							DrawNewBox(x1,y1,x1+w,y1+h,C_WHITE);
						end
					end
				end
			end
		elseif eventtype==2 then
			if mx>x1 and mx<x1+w and my>y1 and my<y1+h then
				current=1+math.modf((mx-x1-CC.MenuBorderPixel)/(size*maxlength/2+CC.RowPixel))
				current=limitX(current,1,num);
			end
		elseif eventtype==3 then
			if keyPress==1 then
				if mx>x1 and mx<x1+w and my>y1 and my<y1+h then
					current=1+math.modf((mx-x1-CC.MenuBorderPixel)/(size*maxlength/2+CC.RowPixel))
					current=limitX(current,1,num);
					if newMenu[current][2]==nil then
						returnValue=newMenu[current][4];
						break;
					else
						redraw(1);
						local r=newMenu[current][2](newMenu,newMenu[current][4],0);               --���ò˵�����
						if r==-1 then
							returnValue=-1 --newMenu[current][4];
							break;
						else
							--Cls(x1,y1,x1+w,y1+h);
							lib.LoadSur(surid,0,0);
							if isBox==1 then
								DrawNewBox(x1,y1,x1+w,y1+h,C_WHITE);
							end
						end
					end
				end
			elseif keyPress==3 then
				if isEsc==1 then
					break;
				end
			elseif keyPress==4 then
				start=start-1
			elseif keyPress==5 then
				start=start+1
			end
		end
    end
    --Cls(x1,y1,x1+w+1,y1+h+1,0,1);
	lib.LoadSur(surid,0,0);
	lib.FreeSur(surid);
    return returnValue;
end

------------------------------------------------------------------------------------
--------------------------------------��Ʒʹ��---------------------------------------
--��Ʒʹ��ģ��
--��ǰ��Ʒid
--����1 ʹ������Ʒ�� 0 û��ʹ����Ʒ��������ĳЩԭ����ʹ��
function UseThing(id)             --��Ʒʹ��
    --���ú���
	if JY.ThingUseFunction[id]==nil then
	    return DefaultUseThing(id);
	else
        return JY.ThingUseFunction[id](id);
    end
end

--ȱʡ��Ʒʹ�ú�����ʵ��ԭʼ��ϷЧ��
--id ��Ʒid
function DefaultUseThing(id)                --ȱʡ��Ʒʹ�ú���
    if JY.Thing[id]["����"]==0 then
        return UseThing_Type0(id);
    elseif JY.Thing[id]["����"]==1 then
        return UseThing_Type1(id);
    elseif JY.Thing[id]["����"]==2 then
        return UseThing_Type2(id);
    elseif JY.Thing[id]["����"]==3 then
        return UseThing_Type3(id);
    elseif JY.Thing[id]["����"]==4 then
        return UseThing_Type4(id);
    end
end

--������Ʒ�������¼�
function UseThing_Type0(id)              --������Ʒʹ��
    if JY.SubScene>=0 then
		local x=JY.Base["��X1"]+CC.DirectX[JY.Base["�˷���"]+1];
		local y=JY.Base["��Y1"]+CC.DirectY[JY.Base["�˷���"]+1];
        local d_num=GetS(JY.SubScene,x,y,3)
        if d_num>=0 then
            JY.CurrentThing=id;
            EventExecute(d_num,2);       --��Ʒ�����¼�
            JY.CurrentThing=-1;
			return 1;
		else
		    return 0;
        end
    end
end

--װ����Ʒ
function UseThing_Type1(id)            --װ����Ʒʹ��
    DrawStrBox(CC.MainSubMenuX,CC.MainSubMenuY,string.format("˭Ҫ�䱸%s?",JY.Thing[id]["����"]),C_WHITE,CC.Fontbig);
	local nexty=CC.MainSubMenuY+CC.SingleLineHeight;
    local r=SelectTeamMenu(CC.MainSubMenuX,nexty);

    if r>0 then
        local personid=JY.Base["����" ..r]
        if CanUseThing(id,personid) then
            if JY.Thing[id]["װ������"]==0 then
                if JY.Thing[id]["ʹ����"]>=0 then
                    JY.Person[JY.Thing[id]["ʹ����"]]["����"]=-1;
                end
                if JY.Person[personid]["����"]>=0 then
                    JY.Thing[JY.Person[personid]["����"]]["ʹ����"]=-1
                end
                JY.Person[personid]["����"]=id;
            elseif JY.Thing[id]["װ������"]==1 then
                if JY.Thing[id]["ʹ����"]>=0 then
                    JY.Person[JY.Thing[id]["ʹ����"]]["����"]=-1;
                end
                if JY.Person[personid]["����"]>=0 then
                    JY.Thing[JY.Person[personid]["����"]]["ʹ����"]=-1
                end
                JY.Person[personid]["����"]=id;
            end
            JY.Thing[id]["ʹ����"]=personid
        else
            DrawStrBoxWaitKey("���˲��ʺ��䱸����Ʒ",C_WHITE,CC.Fontbig);
			return 0;
        end
    end
--    Cls();
--    ShowScreen();
	return 1;
end

--�ж�һ�����Ƿ����װ��������һ����Ʒ
--���� true����������false����
function CanUseThing(id,personid)           --�ж�һ�����Ƿ����װ��������һ����Ʒ
    local str="";
    if JY.Thing[id]["����������"] >=0 then
        if JY.Thing[id]["����������"] ~= personid then
            return false;
        end
    end

    if JY.Thing[id]["����������"] ~=2 and JY.Person[personid]["��������"] ~=2 then
        if JY.Thing[id]["����������"] ~= JY.Person[personid]["��������"] then
            return false;
        end
    end

    if JY.Thing[id]["������"] > JY.Person[personid]["�������ֵ"] then
        return false;
    end
    if JY.Thing[id]["�蹥����"] > JY.Person[personid]["������"] then
        return false;
    end
    if JY.Thing[id]["���Ṧ"] > JY.Person[personid]["�Ṧ"] then
        return false;
    end
    if JY.Thing[id]["���ö�����"] > JY.Person[personid]["�ö�����"] then
        return false;
    end
    if JY.Thing[id]["��ҽ������"] > JY.Person[personid]["ҽ������"] then
        return false;
    end
    if JY.Thing[id]["��ⶾ����"] > JY.Person[personid]["�ⶾ����"] then
        return false;
    end
    if JY.Thing[id]["��ȭ�ƹ���"] > JY.Person[personid]["ȭ�ƹ���"] then
        return false;
    end
    if JY.Thing[id]["����������"] > JY.Person[personid]["��������"] then
        return false;
    end
    if JY.Thing[id]["��ˣ������"] > JY.Person[personid]["ˣ������"] then
        return false;
    end
    if JY.Thing[id]["���������"] > JY.Person[personid]["�������"] then
        return false;
    end
    if JY.Thing[id]["�谵������"] > JY.Person[personid]["��������"] then
        return false;
    end
    if JY.Thing[id]["������"] >= 0 then
        if JY.Thing[id]["������"] > JY.Person[personid]["����"] then
            return false;
        end
    else
        if -JY.Thing[id]["������"] < JY.Person[personid]["����"] then
            return false;
        end
    end

    return true
end


--�ؼ���Ʒ
function UseThing_Type2(id)               --�ؼ���Ʒʹ��
    if JY.Thing[id]["ʹ����"]>=0 then
        if DrawStrBoxYesNo(-1,-1,"����Ʒ�Ѿ������������Ƿ�������?",C_WHITE,CC.Fontbig)==false then
            Cls(CC.MainSubMenuX,CC.MainSubMenuY,CC.ScreenW,CC.ScreenH);
            ShowScreen();
            return 0;
        end
    end

    Cls();
    DrawStrBox(CC.MainSubMenuX,CC.MainSubMenuY,string.format("˭Ҫ����%s?",JY.Thing[id]["����"]),C_WHITE,CC.Fontbig);
	local nexty=CC.MainSubMenuY+CC.SingleLineHeight;
    local r=SelectTeamMenu(CC.MainSubMenuX,nexty);

    if r>0 then
        local personid=JY.Base["����" ..r]

        if JY.Thing[id]["�����书"]>=0 then
            local yes=0;
            for i = 1,10 do
                if JY.Person[personid]["�书"..i]==JY.Thing[id]["�����书"] then
                    yes=1;             --�书�Ѿ�����
                    break;
                end
            end
            if yes==0 and JY.Person[personid]["�书10"]>0 then
                DrawStrBoxWaitKey("һ����ֻ������10���书",C_WHITE,CC.Fontbig);
                return 0;
            end
        end

       if CC.Shemale[id]==1 then                --��а�Ϳ���
		    if JY.Person[personid]["�Ա�"]==0 then
				Cls(CC.MainSubMenuX,CC.MainSubMenuY,CC.ScreenW,CC.ScreenH);
				if DrawStrBoxYesNo(-1,-1,"������������Ȼӵ��Թ����Ƿ���Ҫ����?",C_WHITE,CC.Fontbig)==false then
					return 0;
				else
					JY.Person[personid]["�Ա�"]=2;
				end
			elseif JY.Person[personid]["�Ա�"]==1 then
				DrawStrBoxWaitKey("���˲��ʺ���������Ʒ",C_WHITE,CC.Fontbig);
				return 0;
			end
        end


        if CanUseThing(id,personid) then
            if JY.Thing[id]["ʹ����"]==personid then
                return 0;
            end

            if JY.Person[personid]["������Ʒ"]>=0 then
                JY.Thing[JY.Person[personid]["������Ʒ"]]["ʹ����"]=-1;
            end

            if JY.Thing[id]["ʹ����"]>=0 then
                JY.Person[JY.Thing[id]["ʹ����"]]["������Ʒ"]=-1;
                JY.Person[JY.Thing[id]["ʹ����"]]["��������"]=0;
                JY.Person[JY.Thing[id]["ʹ����"]]["��Ʒ��������"]=0;
            end

            JY.Thing[id]["ʹ����"]=personid
            JY.Person[personid]["������Ʒ"]=id;
            JY.Person[personid]["��������"]=0;
            JY.Person[personid]["��Ʒ��������"]=0;
        else
            DrawStrBoxWaitKey("���˲��ʺ���������Ʒ",C_WHITE,CC.Fontbig);
			return 0;
        end
    end

	return 1;
end

--ҩƷ��Ʒ
function UseThing_Type3(id)        --ҩƷ��Ʒʹ��
    local usepersonid=-1;
    if JY.Status==GAME_MMAP or JY.Status==GAME_SMAP then
        Cls(CC.MainSubMenuX,CC.MainSubMenuY,CC.ScreenW,CC.ScreenH);
        DrawStrBox(CC.MainSubMenuX,CC.MainSubMenuY,string.format("˭Ҫʹ��%s?",JY.Thing[id]["����"]),C_WHITE,CC.Fontbig);
	    local nexty=CC.MainSubMenuY+CC.SingleLineHeight;
        local r=SelectTeamMenu(CC.MainSubMenuX,nexty);
        if r>0 then
            usepersonid=JY.Base["����" ..r]
        end
    elseif JY.Status==GAME_WMAP then           ---ս������ʹ��ҩƷ
        usepersonid=WAR.Person[WAR.CurID]["������"];
    end

    if usepersonid>=0 then
        if UseThingEffect(id,usepersonid)==1 then       --ʹ����Ч��
            instruct_32(id,-1);            --��Ʒ��������
            WaitKey();
        else
            return 0;
        end
    end

 --   Cls();
 --   ShowScreen();
	return 1;
end

--ҩƷʹ��ʵ��Ч��
--id ��Ʒid��
--personid ʹ����id
--����ֵ��0 ʹ��û��Ч������Ʒ����Ӧ�ò��䡣1 ʹ����Ч������ʹ�ú���Ʒ����Ӧ��-1
function UseThingEffect(id,personid)          --ҩƷʹ��ʵ��Ч��
    local str={};
    str[0]=string.format("ʹ�� %s",JY.Thing[id]["����"]);
    local strnum=1;
    local addvalue;

    if JY.Thing[id]["������"] >0 then
        local add=JY.Thing[id]["������"]-math.modf(JY.Person[personid]["���˳̶�"]/2)+Rnd(10);
        if add <=0 then
            add=5+Rnd(5);
        end
        AddPersonAttrib(personid,"���˳̶�",-JY.Thing[id]["������"]/4);
        addvalue,str[strnum]=AddPersonAttrib(personid,"����",add);
        if addvalue ~=0 then
            strnum=strnum+1
        end
    end

    local function ThingAddAttrib(s)     ---����ֲ������������ҩ����������
        if JY.Thing[id]["��" .. s] ~=0 then
            addvalue,str[strnum]=AddPersonAttrib(personid,s,JY.Thing[id]["��" .. s]);
            if addvalue ~=0 then
                strnum=strnum+1
            end
        end
    end

    ThingAddAttrib("�������ֵ");

    if JY.Thing[id]["���ж��ⶾ"] <0 then
        addvalue,str[strnum]=AddPersonAttrib(personid,"�ж��̶�",math.modf(JY.Thing[id]["���ж��ⶾ"]/2));
        if addvalue ~=0 then
            strnum=strnum+1
        end
    end

    ThingAddAttrib("����");

    if JY.Thing[id]["�ı���������"] ==2 then
        str[strnum]="������·��Ϊ������һ"
        strnum=strnum+1
    end

    ThingAddAttrib("����");
    ThingAddAttrib("�������ֵ");
    ThingAddAttrib("������");
    ThingAddAttrib("������");
    ThingAddAttrib("�Ṧ");
    ThingAddAttrib("ҽ������");
    ThingAddAttrib("�ö�����");
    ThingAddAttrib("�ⶾ����");
    ThingAddAttrib("��������");
    ThingAddAttrib("ȭ�ƹ���");
    ThingAddAttrib("��������");
    ThingAddAttrib("ˣ������");
    ThingAddAttrib("�������");
    ThingAddAttrib("��������");
    ThingAddAttrib("��ѧ��ʶ");
    ThingAddAttrib("��������");

    if strnum>1 then
        local maxlength=0      --�����ַ�����󳤶�
        for i = 0,strnum-1 do
            if #str[i] > maxlength then
                maxlength=#str[i];
            end
        end
        Cls();
		local ww=maxlength*CC.Fontbig/2+CC.MenuBorderPixel*2;
		local hh=strnum*CC.Fontbig+(strnum-1)*CC.RowPixel+2*CC.MenuBorderPixel;
        local x=(CC.ScreenW-ww)/2;
		local y=(CC.ScreenH-hh)/2;
		DrawNewBox(x,y,x+ww,y+hh,C_WHITE);
        DrawString(x+CC.MenuBorderPixel,y+CC.MenuBorderPixel,str[0],C_WHITE,CC.Fontbig);
        for i =1,strnum-1 do
            DrawString(x+CC.MenuBorderPixel,y+CC.MenuBorderPixel+(CC.Fontbig+CC.RowPixel)*i,str[i],C_ORANGE,CC.Fontbig);
        end
        ShowScreen();
        return 1;
    else
        return 0;
    end

end

function walkto(xx,yy,flag)
	local x,y
	AutoMoveTab={[0]=0}
	if JY.Status==GAME_SMAP  then
		x=JY.Base['��X1']
		y=JY.Base['��Y1']
	elseif JY.Status==GAME_MMAP then
		x=JY.Base['��X']
		y=JY.Base['��Y']
	end
	if JY.Status==GAME_SMAP then
		if not between(xx,0,63) then
			return
		end
		if not between(yy,0,63) then
			return
		end
		if not SceneCanPass(xx,yy,0) then
			return
		end
	end
	if JY.Status==GAME_MMAP and ((lib.GetMMap(xx,yy,3)==0 and lib.GetMMap(xx,yy,4)==0) or CanEnterScene(xx,yy)~=-1)==false then
		if not between(x,0,480) then
			return
		end
		if not between(y,0,480) then
			return
		end
		if ((lib.GetMMap(xx,yy,3)==0 and lib.GetMMap(xx,yy,4)==0) or CanEnterScene(xx,yy)~=-1)==false then
			return
		end
	end
	local steparray={};
	local stepmax;
	local xy={}
	if JY.Status==GAME_SMAP then
		for i=0,63 do
			xy[i]={}
		end
	elseif JY.Status==GAME_MMAP then
		for i=0,479 do
			xy[i]={}
		end
	end
	if flag~=nil then
		stepmax=640
	else
		stepmax=240
	end
	steparray[0]={};
    steparray[0].x={};
    steparray[0].y={};
	local function canpass(cx,cy,direct)
		local nx,ny=cx+CC.DirectX[direct],cy+CC.DirectY[direct];
		if JY.Status==GAME_SMAP and (nx>63 or ny>63 or nx<1 or ny<1) then 
			return false 
		end
		if JY.Status==GAME_MMAP and (nx>479 or ny>479 or nx<1 or ny<1) then 
			return false 
		end
		if xy[nx][ny]==nil then
			if JY.Status==GAME_SMAP then
				local hb1,hb2
				hb1=GetS(JY.SubScene,cx,cy,4)
				hb2=GetS(JY.SubScene,nx,ny,4)
				if math.abs(hb1-hb2)>14 then
					return false
				end
				if  SceneCanPass(nx,ny,0) then
					return true
				end
			elseif JY.Status==GAME_MMAP then
				if (lib.GetMMap(nx,ny,3)==0 and lib.GetMMap(nx,ny,4)==0) or CanEnterScene(nx,ny)~=-1 then
					if CC.MMapBoat[lib.GetMMap(nx,ny,0)]==1 then
						if JY.Base["�˴�"]==1 then
							return true;
						end
					else
						if JY.Base["�˴�"]==0 then
							return true;
						end
					end
					return false;
				end
			end
		end
		return false
	end
	
	local function FindNextStep(step)
		if step==stepmax then
			return
		end
		local step1=step+1
		local num=0
	    steparray[step1]={};
        steparray[step1].x={};
        steparray[step1].y={};
		for i=1,steparray[step].num do
			if steparray[step].x[i]==xx and steparray[step].y[i]==yy then
				return
			end
			for d=1,4 do
				if canpass(steparray[step].x[i],steparray[step].y[i],d) then
					num=num+1
					steparray[step1].x[num]=steparray[step].x[i]+CC.DirectX[d]
					steparray[step1].y[num]=steparray[step].y[i]+CC.DirectY[d]
					xy[steparray[step1].x[num]][steparray[step1].y[num]]=step1
				end
			end
		end
		if num>0 then
			steparray[step1].num=num
			FindNextStep(step1)
		end
	end
	
    steparray[0].num=1;
	steparray[0].x[1]=x;
	steparray[0].y[1]=y;
	xy[x][y]=0
	FindNextStep(0);
	
	
    local movenum=xy[xx][yy];
	
	if movenum==nil then
		return
	end
	AutoMoveTab[0]=movenum
	for i=movenum,1,-1 do
        if xy[xx-1][yy]==i-1 then
            xx=xx-1;
            AutoMoveTab[1+movenum-i]=1;
        elseif xy[xx+1][yy]==i-1 then
            xx=xx+1;
            AutoMoveTab[1+movenum-i]=2;
        elseif xy[xx][yy-1]==i-1 then
            yy=yy-1;
            AutoMoveTab[1+movenum-i]=3;
        elseif xy[xx][yy+1]==i-1 then
            yy=yy+1;
            AutoMoveTab[1+movenum-i]=0;
        end
	end
end

--������Ʒ
function UseThing_Type4(id)             --������Ʒʹ��
    if JY.Status==GAME_WMAP then
         return War_UseAnqi(id);
    end
	return 0;
end

--α�����
function myRnd100()
	local maxnum=1000;
	local id=JY.Rnd100[0];
	if id==nil then
		for i=1,maxnum do
			JY.Rnd100[i]=math.random(100)-1;
		end
		JY.Rnd100[0]=1;
		id=1;
	end
	local v=JY.Rnd100[id];
	JY.Rnd100[id]=math.random(100)-1;
	JY.Rnd100[0]=JY.Rnd100[0]+1;
	if JY.Rnd100[0]>maxnum then
		JY.Rnd100[0]=1;
	end
	if CC.SL>0 then
		v=limitX(v+60,0,99);
		CC.SL=CC.SL-1;
	end
	return v;
end

--��ȡ���̻��������Ϣ
function getkey()
	local eventtype,keypress,x,y=lib.GetKey(1);
	--lib.Debug(string.format('eventtype:%d,keypress:%d,x:%d,y:%d',eventtype,keypress,x,y))
	--lib.Debug(VK_UP)
	if eventtype==0 then	--SDL_Quit
		if JY.EnableQuit then
			JY.EnableQuit=false;
			local button={'ȷ��','ȡ��'};
			local bk1=JY.EnableKeyboard;
			local bk2=JY.EnableMouse;
			JY.EnableKeyboard=true;
			JY.EnableMouse=true;
			if JYMsgBox('�뿪��Ϸ','��ȷ��Ҫ�뿪��Ϸ��*����δ��������Ͻ��ᶪʧ��',button,2)==1 then
				--JY.Status=GAME_END;
				os.exit();
			end
			JY.EnableKeyboard=bk1;
			JY.EnableMouse=bk2;
			JY.EnableQuit=true;
		end
	elseif eventtype==1 then	--keypress
		if JY.EnableKeyboard then
			return eventtype,keypress,x,y;
		end
	--[[
	elseif eventtype==2 then	--mouse move
		if JY.EnableMouse then
			return eventtype,keypress,x,y;
		end
	elseif eventtype==3 then	--mouse down
		if JY.EnableMouse then
			return eventtype,keypress,x,y;
		end--]]
	elseif eventtype~=-1 then
		if JY.EnableMouse then
			return eventtype,keypress,x,y;
		end
	end	
	return -1;
end

function JYMsgBox(title,str,button,num,headid)
	--���㳤��,�ֺ�ʹ��Ĭ���ֺţ�CC.Fontbig
	local strArray={};
	local xnum,ynum;
	local width,height;
	local picw,pich=0,0;
	local x1,x2,y1,y2;
	if headid~=nil then
		headid=headid*2;
		picw,pich=lib.PicGetXY(1,headid);
		picw=picw+CC.MenuBorderPixel*2;
		pich=pich+CC.MenuBorderPixel*2+CC.Fontbig;
	end
	ynum,strArray=Split(str,'*');
	xnum=0;
	for i=1,ynum do
		local len=string.len(strArray[i]);
		if len>xnum then
			xnum=len;
		end
	end
	if xnum<12 then
		xnum=12
	end
	width=CC.MenuBorderPixel*2+math.modf(CC.Fontbig*xnum/2)+picw;
	height=CC.MenuBorderPixel*2+(CC.Fontbig+CC.MenuBorderPixel)*(ynum+1);
	if height<pich then
		height=pich;
	end
	local blen=0;
	for i=1,num do
		local len=string.len(button[i]);
		if blen<len then
			blen=len;
		end
	end
	blen=(num+2)*CC.Fontbig*blen/2;
	if width<blen then
		width=blen;
	end
	y2=height;
	height=height+CC.MenuBorderPixel*2+CC.Fontbig+CC.FontBig/2;
	x1=(CC.ScreenW-width)/2+CC.MenuBorderPixel;
	x2=x1+picw;
	y1=(CC.ScreenH-height)/2+CC.MenuBorderPixel+2+CC.FontBig/2;
	y2=y2+y1-CC.Fontbig/2;
	width=width+CC.Fontbig
	local select=num;
	--lib.FreeSur(0)
	local surid=lib.SaveSur((CC.ScreenW-width)/2-4,(CC.ScreenH-height)/2-CC.FontBig,(CC.ScreenW+width)/2+4,(CC.ScreenH+height)/2+4);
	while true do
		lib.LoadSur(surid,(CC.ScreenW-width)/2-4,(CC.ScreenH-height)/2-CC.FontBig)
		DrawBoxTitle(width,height,title,C_GOLD);
		if headid~=nil then
			lib.PicLoadCache(1,headid,x1,(y1+y2+CC.Fontbig-pich)/2,1,0);
		end
		for i=1,ynum do
			DrawString(x2,y1+CC.Fontbig/2+(CC.MenuBorderPixel+CC.Fontbig)*(i-1),strArray[i],C_WHITE,CC.Fontbig);
		end
		for i=1,num do
			local color;
			local bjcolor;
			if i==select then
				color=M_Yellow;
				bjcolor=M_DarkOrange
			else
				color=M_DarkOrange;
			end
			DrawStrNewBox((CC.ScreenW-width)/2+width*i/(num+1)-string.len(button[i])*CC.Fontbig/4,y2,button[i],color,CC.Fontbig,bjcolor);
		end
		ShowScreen()
		local event,key,mx,my=WaitKey(1)
		if event==1 then
			if key==VK_LEFT then
				select=select-1;
			elseif key==VK_RIGHT then
				select=select+1;
			elseif key==VK_RETURN or key==VK_SPACE then
				break;
			end
		elseif event==2 or event==3 then
			if between(my,y2,y2+CC.Fontbig+2*CC.MenuBorderPixel) then
				local tmp=0;
				for i=1,num do
					if between(mx,(CC.ScreenW-width)/2+width*i/(num+1)-string.len(button[i])*CC.Fontbig/4,
								(CC.ScreenW-width)/2+width*i/(num+1)+string.len(button[i])*CC.Fontbig/4+CC.MenuBorderPixel*2) then
						tmp=i;
						break;
					end
				end
				if tmp>0 then
					select=tmp;
					if event==3 then
						break;
					end
				end
			end
		end
		select=limitX(select,1,num);
	end
	lib.LoadSur(surid,(CC.ScreenW-width)/2-4,(CC.ScreenH-height)/2-CC.FontBig)
	ShowScreen()
	lib.FreeSur(surid);
	return select;
end

function DrawBoxTitle(width,height,str,color,offx,offy)
	--���ò˵�Ҳ���õ��İ�
	offx=offx or 0;
	offy=offy or 0;
    local s=4;
	local x1,y1,x2,y2,tx1,tx2;
	local fontsize=s+CC.FontBig--math.min(CC.ScreenW/20,CC.ScreenH/15);
	local len=string.len(str)*fontsize/2;
	x1=(CC.ScreenW-width)/2+offx;
	x2=(CC.ScreenW+width)/2+offx;
	y1=(CC.ScreenH-height)/2+offy;
	y2=(CC.ScreenH+height)/2+offy;
	tx1=(CC.ScreenW-len)/2+offx;
	tx2=(CC.ScreenW+len)/2+offx;
    lib.Background(x1,y1+s,x1+s,y2-s,128);    --��Ӱ���Ľǿճ�,���岿��
    lib.Background(x1+s,y1,x2-s,y2,128);
    lib.Background(x2-s,y1+s,x2,y2-s,128);
    lib.Background(tx1-s,y1-fontsize/2-s,tx2+s,y1,128);    --��Ӱ���Ľǿճ�,���ⲿ��
    --lib.Background(tx1+s,y1-fontsize/2,tx2-s,y1-fontsize/2+s,128);
    local r,g,b=GetRGB(color);
    DrawBoxTitle_sub(x1+1,y1+1,x2,y2,tx1+1,y1-fontsize/2+1,tx2,y1+fontsize/2,RGB(math.modf(r/2),math.modf(g/2),math.modf(b/2)));
    DrawBoxTitle_sub(x1,y1,x2-1,y2-1,tx1,y1-fontsize/2,tx2-1,y1+fontsize/2-1,color);
	DrawString(tx1+2*s,y1-(fontsize-s)/2,str,color,CC.FontBig)
end
function DrawBoxTitle_sub(x1,y1,x2,y2,tx1,ty1,tx2,ty2,color)
    local s=4;
	lib.DrawRect(x1+s,y1,tx1-s,y1,color)
	lib.DrawRect(tx2+s,y1,x2-s,y1,color)
    lib.DrawRect(x2-s,y1,x2-s,y1+s,color);
    lib.DrawRect(x2-s,y1+s,x2,y1+s,color);
    lib.DrawRect(x2,y1+s,x2,y2-s,color);
    lib.DrawRect(x2,y2-s,x2-s,y2-s,color);
    lib.DrawRect(x2-s,y2-s,x2-s,y2,color);
    lib.DrawRect(x2-s,y2,x1+s,y2,color);
    lib.DrawRect(x1+s,y2,x1+s,y2-s,color);
    lib.DrawRect(x1+s,y2-s,x1,y2-s,color);
    lib.DrawRect(x1,y2-s,x1,y1+s,color);
    lib.DrawRect(x1,y1+s,x1+s,y1+s,color);
    lib.DrawRect(x1+s,y1+s,x1+s,y1,color);
	DrawNewBox_1(tx1,ty1,tx2,ty2,color)
end

function Split(szFullString,szSeparator)
	local nFindStartIndex = 1
	local nSplitIndex = 1
	local nSplitArray = {}
	while true do
		local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)
		if not nFindLastIndex then
			nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))
			break
		end
		nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)
		nFindStartIndex = nFindLastIndex + string.len(szSeparator)
		nSplitIndex = nSplitIndex + 1
	end
	return nSplitIndex,nSplitArray
end

function DrawStrBox(x,y,str,color,size,bjcolor)         --��ʾ������ַ���
	
	local strarray={}
	local num,maxlen;
	maxlen=0
	num,strarray=Split(str,'*')
	for i=1,num do
		local len=Mylen(strarray[i])
		if len>maxlen then
			maxlen=len
		end
	end
    local w=size*maxlen/2+2*CC.MenuBorderPixel;
	local h=2*CC.MenuBorderPixel+size*num;
	if x==-1 then
        x=(CC.ScreenW-size/2*maxlen-2*CC.MenuBorderPixel)/2;
	end
	if y==-1 then
        y=(CC.ScreenH-size*num-2*CC.MenuBorderPixel)/2;
	end
	if x<0 then
		x=CC.ScreenW-size/2*maxlen-2*CC.MenuBorderPixel+x;
	end
	if y<0 then
        y=CC.ScreenH-size*num-2*CC.MenuBorderPixel+y;
	end
	DrawBox(x,y,x+w-1,y+h-1,C_WHITE,bjcolor);
	for i=1,num do
		DrawString(x+CC.MenuBorderPixel,y+CC.MenuBorderPixel+size*(i-1),strarray[i],color,size);
	end
end
function DrawStrCircleBox(x,y,str,color,size,bjcolor)         --��ʾ������ַ���
	
	local strarray={}
	local num,maxlen;
	maxlen=0
	num,strarray=Split(str,'*')
	for i=1,num do
		local len=Mylen(strarray[i])
		if len>maxlen then
			maxlen=len
		end
	end
    local w=size*maxlen/2+2*CC.MenuBorderPixel;
	local h=2*CC.MenuBorderPixel+size*num;
	if x==-1 then
        x=(CC.ScreenW-size/2*maxlen-2*CC.MenuBorderPixel)/2;
	end
	if y==-1 then
        y=(CC.ScreenH-size*num-2*CC.MenuBorderPixel)/2;
	end
	if x<0 then
		x=CC.ScreenW-size/2*maxlen-2*CC.MenuBorderPixel+x;
	end
	if y<0 then
        y=CC.ScreenH-size*num-2*CC.MenuBorderPixel+y;
	end
	DrawCircleBox(x,y,x+w-1,y+h-1,C_WHITE,bjcolor);
	for i=1,num do
		DrawString(x+CC.MenuBorderPixel,y+CC.MenuBorderPixel+size*(i-1),strarray[i],color,size);
	end
end
function DrawStrNewBox1(x,y,str,color,size,bjcolor)
	DrawStrNewBox(x+5,y+6,str,color,size,bjcolor)
end
function DrawStrNewBox(x,y,str,color,size,bjcolor)         --��ʾ������ַ���
	
	local strarray={}
	local num,maxlen;
	maxlen=0
	num,strarray=Split(str,'*')
	for i=1,num do
		local len=Mylen(strarray[i])
		if len>maxlen then
			maxlen=len
		end
	end
    local w=size*maxlen/2+2*CC.MenuBorderPixel;
	local h=2*CC.MenuBorderPixel+size*num;
	if x==-1 then
        x=(CC.ScreenW-size/2*maxlen-2*CC.MenuBorderPixel)/2;
	end
	if y==-1 then
        y=(CC.ScreenH-size*num-2*CC.MenuBorderPixel)/2;
	end
	if x<0 then
		x=CC.ScreenW-size/2*maxlen-2*CC.MenuBorderPixel+x;
	end
	if y<0 then
        y=CC.ScreenH-size*num-2*CC.MenuBorderPixel+y;
	end
	DrawNewBox(x,y,x+w-1,y+h-1,C_WHITE,bjcolor);
	for i=1,num do
		DrawString(x+CC.MenuBorderPixel,y+CC.MenuBorderPixel+size*(i-1),strarray[i],color,size);
	end
end

function Mylen(str)
	local T2={{"��"},{"��"},{"��"},{"��"},{"��"},{"��"}};
	local position=0;
	while string.len(str)>=1 do
		local try=string.sub(str,1,1)
		if string.byte(try)>127 then	--����
			local s=string.sub(str,1,2);
			str=string.sub(str,3,-1);
			local control=false
			for i,v in pairs(T2) do
				if s==v[1] then
					control=true;
					break;
				end
			end
			if not control then
				position=position+2;
			end
		else
			local s=try;--string.sub(str,1,1);
			str=string.sub(str,2,-1);
			position=position+1;
		end
	end
	return position;
end

function DrawStrBox_1(x,y,str,color,size,bjcolor)         --�޿�� �б���
	
	local strarray={}
	local num,maxlen;
	maxlen=0
	num,strarray=Split(str,'*')
	for i=1,num do
		local len=string.len(strarray[i])
		if len>maxlen then
			maxlen=len
		end
	end
    local w=size*maxlen/2+2*CC.MenuBorderPixel;
	local h=2*CC.MenuBorderPixel+size*num;
	if x==-1 then
        x=(CC.ScreenW-size/2*maxlen-2*CC.MenuBorderPixel)/2;
	end
	if y==-1 then
        y=(CC.ScreenH-size*num-2*CC.MenuBorderPixel)/2;
	end
	if x<0 then
		x=CC.ScreenW-size/2*maxlen-2*CC.MenuBorderPixel+x;
	end
	if y<0 then
        y=CC.ScreenH-size*num-2*CC.MenuBorderPixel+y;
	end
	DrawBox(x,y,x+w-1,y+h-1,-1,bjcolor);
	for i=1,num do
		DrawString(x+CC.MenuBorderPixel,y+CC.MenuBorderPixel+size*(i-1),strarray[i],color,size);
	end
end
function DrawStrBox_2(x,y,str,color,size)         --�޿�� �ޱ���
	
	local strarray={}
	local num,maxlen;
	maxlen=0
	num,strarray=Split(str,'*')
	for i=1,num do
		local len=string.len(strarray[i])
		if len>maxlen then
			maxlen=len
		end
	end
    local w=size*maxlen/2+2*CC.MenuBorderPixel;
	local h=2*CC.MenuBorderPixel+size*num;
	if x==-1 then
        x=(CC.ScreenW-size/2*maxlen-2*CC.MenuBorderPixel)/2;
	end
	if y==-1 then
        y=(CC.ScreenH-size*num-2*CC.MenuBorderPixel)/2;
	end
	for i=1,num do
		DrawString(x+CC.MenuBorderPixel,y+CC.MenuBorderPixel+size*(i-1),strarray[i],color,size);
	end
end

function learnKF(kungfu,pid)
	local id=learnKF_sub(kungfu,pid)
	if id==0 then
		
	else
		
	end
end

function learnKF_sub(kungfu,pid)
	Cls()
	local num=0;
	while true do
		if kungfu[num+1]==nil then
			break;
		else
			num=num+1;
		end
	end
	local fontsize=math.min(CC.ScreenW/25,CC.ScreenH/16);
	DrawBoxTitle(CC.ScreenW*0.8,CC.ScreenH*0.8,'ѧϰ�书',C_GOLD);
	DrawStrBox(CC.ScreenW/10+fontsize/2,CC.ScreenH/10+fontsize,'��ѡ����ѧϰ���书',C_WHITE,fontsize);
	DrawStrBox(CC.ScreenW*0.9-fontsize*8-4,CC.ScreenH/10+fontsize,'��������:',C_WHITE,fontsize);
	DrawStrBox(CC.ScreenW*0.9-fontsize*3-4,CC.ScreenH/10+fontsize,JY.Person[pid]['��������'],C_GOLD,fontsize)
	local mykf=''
	for i=1,CC.Kungfunum do
		if JY.Person[pid]['�书'..i]>0 then
			local len=0.8*CC.ScreenW/fontsize-3-string.len(JY.Wugong[JY.Person[pid]['�书'..i]]['����'])
			len=math.modf(len)
			if len<2 then len=2 end
			local tmpstr=JY.Wugong[JY.Person[pid]['�书'..i]]['����']..'%'..len..'d'
			mykf=mykf..string.format(tmpstr,1+math.modf(JY.Person[pid]['�书�ȼ�'..i]/100))
		end
		if i<CC.Kungfunum then
			mykf=mykf..'*'
		end
	end
	DrawStrBox(CC.ScreenW/2+fontsize-4,CC.ScreenH/10+fontsize*2.5,mykf,C_WHITE,fontsize)
	local menu={}
	for i=1,num do
		local len=0.8*CC.ScreenW/fontsize-3-string.len(JY.Wugong[kungfu[i][1]]['����'])
		len=math.modf(len)
		if len<2 then len=2 end
		local tmpstr=JY.Wugong[kungfu[i][1]]['����']..'%'..len..'d'
		menu[i]={
					string.format(tmpstr,kungfu[i][2]),
					nil,
					1,
				}
	end
	return ShowMenu(menu,num,0,CC.ScreenW/10+fontsize/2,CC.ScreenH/10+fontsize*2.5,0,0,1,1,fontsize,C_GOLD,C_WHITE)
end

--���ɹ���
function ForceEnemy()
	local enemy={
							[0]={57},
						}
	local force=-1;
	for i,v in pairs(enemy) do
		if GetFlag(1000+100*i)==1 then
			for ii,vv in pairs(v) do
				if JY.SubScene==vv then
					force=i;
					break;
				end
			end
			if force>-1 then
				break;
			end
		end
	end
	if force>-1 and math.random(100)<10 then
		DrawStrBoxWaitKey("CC",C_WHITE,CC.FontBig);
	end
end

--Reset FW
function ResetFW()
	
	local p={0,0,0,0,0,0,0};
	local id=1;
	local function redraw()
		lib.FillColor(0,0,0,0,0);
		DrawStrBox(25,10,"������Χ*",C_WHITE,28);
		DrawStrBox(180,10," �� �� �� Χ * ",C_WHITE,28);
		for i=1,2 do
			local color=C_WHITE;
			if i==id then
				color=C_ORANGE;
			end
			DrawString(50+28*(i-1),45,string.format("%2d,",p[i]),color,24);
		end
		for i=3,7 do
			local color=C_WHITE;
			if i==id then
				color=C_ORANGE;
			end
			DrawString(145+28*(i-1),45,string.format("%2d,",p[i]),color,24);
		end
		DrawString(40,45,"{     }      {            }",M_Yellow,24);
	end
	while true do
		redraw();
		JY.Kungfu[1]["������Χ"][1]={p[1],p[2]};
		JY.Kungfu[1]["�˺���Χ"][1]={p[3],p[4],p[5],p[6],p[7]};
		ShowKungfuMove(10,120,380,380,1,1,24);
		ShowKungfuAtk(410,120,380,380,1,1,24);
		ShowScreen();
		local event,key,mx,my=WaitKey(1);
		lib.Delay(50)
		if event==1 then
			if key==VK_UP then
				p[id]=p[id]-1;
			elseif key==VK_DOWN then
				p[id]=p[id]+1;
			elseif key==VK_LEFT then
				id=id-1;
				id=limitX(id,1,7);
			elseif key==VK_RIGHT then
				id=id+1;
				id=limitX(id,1,7);
			elseif key==VK_ESCAPE then
				return 1;
			end
		end
		for i=1,7 do
			p[i]=limitX(p[i],0,20);
		end
		p[1]=limitX(p[1],0,3);
		p[3]=limitX(p[3],0,13);
	end
end

function ShowEFT()
	--lib.PicLoadFile(CC.EffectFile[1],CC.EffectFile[2],92);
	local starteft=0;          --������ʼ�书Ч��֡
	local id=100;
	local Max_eft=744;
	for i=0,id-1 do
		starteft=starteft+CC.Effect[i];
	end
	local x={300,	500,500+CC.XScale,500+CC.XScale*2,500+CC.XScale*3,500+CC.XScale*4,	};
	local y={500,	200,200+CC.YScale,200+CC.YScale*2,200+CC.YScale*3,200+CC.YScale*4,	};
	local num=6
	for i=1,3 do
		for j=1,3 do
			num=num+1;
			x[num]=600+CC.XScale*(i-j);
			y[num]=500+CC.YScale*(i+j);
		end
	end
	local eft=0;
	local off_x,off_y=0,0
	local pic_w,pic_h,pic_x,pic_y=0,0,0,0;
	while true do
		lib.FillColor(0,0,0,0,0);
        lib.LoadPicture(CC.FirstFile,-1,-1);
		DrawStrBox(0,0,id,C_WHITE,32);
		DrawStrBox(0,48,off_x..','..off_y,C_WHITE,32);
		lib.PicLoadCache(0,6034*2,x[1],y[1]);
		for i=1,num do
			local ox,oy=0,0;
			if type(CC.NEft_Offset[id])=='table' then
				--ox=CC.NEft_Offset[id][1];
				--oy=CC.NEft_Offset[id][2];
			end
			--lib.PicLoadCache(3,(starteft+eft)*2,x[i]+ox,y[i]+oy,7,255);
			lib.PicLoadCache(3,(starteft+eft)*2,x[i]+ox,y[i]+oy,0);
		end
		DrawLine(x[1]-100,y[1],x[1]+100,y[1],C_RED);
		DrawLine(x[1],y[1]-100,x[1],y[1]+100,C_RED);
		--lib.PicLoadCache(3,(starteft+eft)*2,400,300);
		eft=eft+1;
		if eft>=CC.Effect[id] then
			eft=0;
			PlayWavE(id);
		end
		ShowScreen();
		--lib.Delay(50);
		local event,key,mx,my=WaitKey(50);
		if event==1 then
			if key==VK_UP then
				id=limitX(id+1,0,Max_eft);
				starteft=0;
				for i=0,id-1 do
					starteft=starteft+CC.Effect[i];
				end
				eft=0;
			elseif key==VK_DOWN then
				id=limitX(id-1,0,Max_eft);
				starteft=0;
				for i=0,id-1 do
					starteft=starteft+CC.Effect[i];
				end
				eft=0;
			elseif key==VK_SPACE or key==VK_RETURN then
				WaitKey();
			elseif key==VK_ESCAPE then
				local s='';
				for i,v in pairs(CC.NEft_Offset) do
					s=s..'\n'..string.format("[%d]={%d,%d},",i,v[1],v[2])
				end
				lib.Debug(s)
				break;
			end
			--pic_w,pic_h,pic_x,pic_y=lib.PicGetXY(3,starteft*2)
		elseif event>=2 then
			off_x=mx-x[1];
			off_y=my-y[1];
			if event==3 then
				CC.NEft_Offset[id]={off_x,off_y};
				lib.Debug(string.format("[%d]={%d,%d},",id,off_x,off_y));
			end
		end
	end
end

function DrawLine(x1,y1,x2,y2,color)
	x1=limitX(x1,1,CC.ScreenW-2);
	x2=limitX(x2,1,CC.ScreenW-2);
	y1=limitX(y1,1,CC.ScreenH-2);
	y2=limitX(y2,1,CC.ScreenH-2);
	local r,g,b=GetRGB(color);
	lib.DrawLine(x1+1,y1,x2+1,y2,RGB(math.modf(r/2),math.modf(g/2),math.modf(b/2)));
	lib.DrawLine(x1-1,y1,x2-1,y2,RGB(math.modf(r/2),math.modf(g/2),math.modf(b/2)));
	lib.DrawLine(x1,y1+1,x2,y2+1,RGB(math.modf(r/2),math.modf(g/2),math.modf(b/2)));
	lib.DrawLine(x1,y1-1,x2,y2-1,RGB(math.modf(r/2),math.modf(g/2),math.modf(b/2)));
	lib.DrawLine(x1,y1,x2,y2,color);
end

function ShowKungfuMaxLv()
	local MaxKungfuNum=100;
	for i=1,MaxKungfuNum do
		local lv=10;
		local ng_add=0;
		local qg_add=0;
		local tj_add=0;
		for j=1,MaxKungfuNum do
			for k=1,JY.Kungfu[j]["����书"][0] do
				if JY.Kungfu[j]["����书"][k][1]==i then
					if JY.Wugong[j]["�书����"]<7 then
						lv=lv+JY.Kungfu[j]["����书"][k][2];
					elseif JY.Wugong[j]["�书����"]==7 then
						if JY.Kungfu[j]["����书"][k][2]>ng_add then
							ng_add=JY.Kungfu[j]["����书"][k][2];
						end
					elseif JY.Wugong[j]["�书����"]==8 then
						if JY.Kungfu[j]["����书"][k][2]>qg_add then
							qg_add=JY.Kungfu[j]["����书"][k][2];
						end
					elseif JY.Wugong[j]["�书����"]==9 then
						if JY.Kungfu[j]["����书"][k][2]>tj_add then
							tj_add=JY.Kungfu[j]["����书"][k][2];
						end
					end
				end
			end
		end
		lib.Debug(string.format("No.%03d %s,MaxLv=%d",i,JY.Wugong[i]["����"],lv+ng_add+qg_add+tj_add));
		for j=1,MaxKungfuNum do
			for k=1,JY.Kungfu[j]["����书"][0] do
				if JY.Kungfu[j]["����书"][k][1]==i then
					lib.Debug(string.format("  No.%03d %s,Lv+%d",j,JY.Wugong[j]["����"],JY.Kungfu[j]["����书"][k][2]));
				end
			end
		end
	end
	return 1;
end

function USEITEM(pid,tid)
	--normal req
	
	--SR
	if not JY.Item[tid].SR(pid) then
		return;
	end
	--
	if JY.Thing[tid]["����"]==2 then
		instruct_32(tid,-1);
	elseif JY.Thing[tid]["����"]==4 then
		instruct_32(tid,-1);
		if JY.Thing[tid]["װ������"]<4 then
			if JY.Person[pid]["����"]>0 then
				JY.Item[JY.Person[pid]["����"]].unuse(pid);
				instruct_32(JY.Person[pid]["����"],1);
			end
			JY.Person[pid]["����"]=tid;
		else
			if JY.Person[pid]["����"]>0 then
				JY.Item[JY.Person[pid]["����"]].unuse(pid);
				instruct_32(JY.Person[pid]["����"],1);
			end
			JY.Person[pid]["����"]=tid;
		end
		JY.Item[tid].onuse(pid);
		DrawStrBoxWaitKey(string.format("%sװ��%s",JY.Person[pid]["����"],JY.Thing[tid]["����"]),C_WHITE,CC.Fontbig,1);
	end
end

function Goto(id)
	if id==nil then
		local m={};
		for i=0,JY.SceneNum-1 do
			m[i+1]={JY.Scene[i]["����"],nil,0};
			if JY.Scene[i]["��������"]==0 then
				m[i+1][3]=1;
			end
		end
		id=ShowMenu(m,JY.SceneNum,12,CC.MainMenuX,CC.MainMenuY,0,0,1,1)-1;
	end
	if id<0 then
		return;
	end
	JY.SubScene=id;
	lib.ShowSlow(50,1);
	JY.Status=GAME_SMAP;
	JY.MmapMusic=-1;
	JY.MyPic=GetMyPic();
	JY.Base["��X1"]=JY.Scene[JY.SubScene]["���X"]
	JY.Base["��Y1"]=JY.Scene[JY.SubScene]["���Y"]
	Init_SMap(1);
end
function console()
	if CC.Debug~=true then
		return;
	end
	local menu=	{
							{"ShowKungfuMaxLv",ShowKungfuMaxLv,1},
							{"ShowQuest",nil,1},
							{"XiaoCun",nil,1},
							{"KungfuGame",nil,1},
							{"ShowEFT",nil,1},
							{"ShowFW",nil,1},
							{"ShowMeTheExp",nil,1},
							{"ShowMeThePoint",nil,1},
							{"ShowMeTheSkill",nil,1},
							{"Goto",nil,1},
							{"DayPass",nil,1},
							{"MaxAttrib",nil,1},
							{"PersonPosition",nil,1},
							{"MiniMap",nil,1},
							{"Migong",nil,1},
						}
	local r=ShowMenu(menu,15,15,CC.MainMenuX,CC.MainMenuY,0,0,1,1,CC.Fontbig,C_ORANGE, C_WHITE);
	if r==1 then
	
	elseif r==2 then
		lib.Debug("NowQuest:");
		for i,v in pairs(MyQuest) do
			lib.Debug(string.format("Quest:%d=%d",i,v));
		end
	elseif r==3 then
		JY.Scene[70]["��������"]=0;
		local add,str=AddPersonAttrib(0,"����",99900);
		DrawStrBoxWaitKey(JY.Person[0]["����"] .. str,C_ORANGE,CC.Fontbig);
		War_AddPersonLevel(0);
	elseif r==4 then
		E_kungfugame(-4,0)
	elseif r==5 then
		ShowEFT()
	elseif r==6 then
		ResetFW()
	elseif r==7 then
		AddPersonAttrib(0,"����",NextLvExp(JY.Person[0]["�ȼ�"]));
		War_AddPersonLevel(0);
	elseif r==8 then
		AddPersonAttrib(0,"��������",1000);
	elseif r==9 then
		AddPersonAttrib(0,"ȭ��",10);
		AddPersonAttrib(0,"����",10);
		AddPersonAttrib(0,"ˣ��",10);
		AddPersonAttrib(0,"ǹ��",10);
		--SceneEvent[62][201]();
		--JY.Base["����2"]=149
		JY.Person[0]["�⹦1"]=205
		JY.Person[0]["�⹦2"]=208
		JY.Person[0]["�⹦2"]=264
		JY.Person[0]["�⹦����1"]=1850
		JY.Person[0]["�⹦����2"]=1860
		JY.Person[0]["�⹦����2"]=1860
		JY.Person[0]["�ڹ�"]=111
		JY.Person[0]["�ڹ�����"]=900
		JY.Person[0]["�ؼ�"]=197
		JY.Person[0]["�ؼ�����"]=900
	elseif r==10 then
		Goto();
	elseif r==11 then
		DayPass(30);
	elseif r==12 then
		JY.Person[0]["����"]=100;
		JY.Person[0]["����"]=100;
		JY.Person[0]["����"]=100;
		JY.Person[0]["��Ե"]=100;
		JY.Person[0]["����"]=100;
	elseif r==13 then
		--[[JY.Status=GAME_MMAP;
		JY.Base["��X"],JY.Base["��Y"]=302,196;
		JY.Base["�˴�"]=1;
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
		]]--
		PersonMove();
	elseif r==14 then
		DrawMMap();
	elseif r==15 then
		migong(30,30);
	end
end

function PNG_Offset(id)
	return -NEft_OffsetX[id],-NEft_OffsetY[id];
end

function TableRandom(p1,num)
	local n=table.maxn(p1);
	local p2={};
	num=num or math.huge;
	num=math.min(n,num);
	for i=1,num do
		local pos=1;
		if n>1 then
			pos=math.random(n);
			n=n-1;
		end
		table.insert(p2,p1[pos]);
		table.remove(p1,pos);
	end
	return p2;
end

function migong(x,y)
	local mg={};
	local cx,cy;
	x=limitX(x,1,30);
	y=limitX(y,1,30);
	cx=math.random(32-math.modf(1+x/2),32+math.modf(1+x/2));
	cy=math.random(32-math.modf(1+y/2),32+math.modf(1+y/2));
	--���0,��ͨ 1,ͨ 2,�ȴ�����
	--�Ѿ�����,��Ҫ����,��û����
	for i=0,63 do--32-x,32+x do
		mg[i]={}
		for j=0,63 do--32-y,32+y do
			mg[i][j]=0
		end
	end
	mg[cx][cy]=1;
	local data={[0]=0};
	for i=1,4 do
		local nx,ny=cx+CC.DirectX[i]*2,cy+CC.DirectY[i]*2;
		if between(nx,32-x,32+x) and between(ny,32-y,32+y) then
			mg[nx][ny]=2;
			data[0]=data[0]+1;
			data[data[0]]={nx,ny};
		end
	end
	local function ranselect()
		if data[0]==0 then return end
		local select=math.random(data[0]);
		local xy=data[select];
		mg[xy[1]][xy[2]]=1;
		data[select],data[data[0]]=data[data[0]],data[select];
		data[data[0]]=nil;
		data[0]=data[0]-1;
		local point={[0]=0,};
		for i=1,4 do
			local nx,ny=xy[1]+CC.DirectX[i]*2,xy[2]+CC.DirectY[i]*2;
			if between(nx,32-x,32+x) and between(ny,32-y,32+y) then
				if mg[nx][ny]==1 then
					point[0]=point[0]+1;
					point[point[0]]={xy[1]+CC.DirectX[i],xy[2]+CC.DirectY[i]};
				elseif mg[nx][ny]==0 then
					data[0]=data[0]+1;
					data[data[0]]={nx,ny};
					mg[nx][ny]=2;
				end
			end
		end
		if point[0]>0 then
			local sss;
			if point[0]==1 then
				sss=1;
			else
				sss=math.random(point[0]);
			end
			local nx,ny=point[sss][1],point[sss][2];
			mg[nx][ny]=1;
		end
		
		ranselect()
		--return num
	end
	
	ranselect()
	for i=32-x,32+x do
		for j=32-y,32+y do
			local pic
			if mg[i][j]==1 then 
				pic=-1;
			else
				local ran=math.random(20);
				if ran==1 then
					pic =2*(1394+math.random(10));
				elseif ran<16 then
					pic=2288;
				else
					pic=2308;
				end
			end
			lib.SetS(JY.SubScene,i,j,0,12);
			lib.SetS(JY.SubScene,i,j,1,pic);
		end
	end
	--[[local nx,ny
	nx=1+2*Rnd(31)
	ny=1+2*Rnd(31)
	nx,cy=migong2(nx,ny)
	JY.Base['��X1']=nx
	JY.Base['��Y1']=ny
	nx,ny=migong2(nx,ny)
	lib.SetS(JY.SubScene,nx,ny,1,2331*2);]]--
end

function migong2(cx,cy)
	local data={}
	data[1]={
				num=1,
				x={cx},
				y={cy},
			}
	local mg={}
	for i=0,63 do
		mg[i]={}
		for j=0,63 do
			if SceneCanPass(i,j) then
				mg[i][j]=1
			else
				mg[i][j]=0
			end
		end
	end
	local function findnext(data,step)
		local n=0
		if data[step].num>0 then
			data[step+1]={}
			data[step+1].x={}
			data[step+1].y={}
		else
			return
		end
		for i=1,data[step].num do
			if data[step].x[i]<1 or data[step].x[i]>62 or data[step].y[i]<1 or data[step].y[i]>62 then
				break
			end
			if mg[data[step].x[i]+1][data[step].y[i]]==1 then
				mg[data[step].x[i]+1][data[step].y[i]]=step+1
				n=n+1
				data[step+1].x[n]=data[step].x[i]+1
				data[step+1].y[n]=data[step].y[i]
			end
			if mg[data[step].x[i]-1][data[step].y[i]]==1 then
				mg[data[step].x[i]-1][data[step].y[i]]=step+1
				n=n+1
				data[step+1].x[n]=data[step].x[i]-1
				data[step+1].y[n]=data[step].y[i]
			end
			if mg[data[step].x[i]][data[step].y[i]+1]==1 then
				mg[data[step].x[i]][data[step].y[i]+1]=step+1
				n=n+1
				data[step+1].x[n]=data[step].x[i]
				data[step+1].y[n]=data[step].y[i]+1
			end
			if mg[data[step].x[i]][data[step].y[i]-1]==1 then
				mg[data[step].x[i]][data[step].y[i]-1]=step+1
				n=n+1
				data[step+1].x[n]=data[step].x[i]
				data[step+1].y[n]=data[step].y[i]-1
			end
		end
		if n>0 then
			data[step+1].num=n
			findnext(data,step+1)
		end
	end
	findnext(data,1)
	for i=0,63 do
		for j=0,63 do
			if mg[i][j]>mg[cx][cy] then
				cx,cy=i,j
			end
		end
	end
	return cx,cy
end











local _class={}
 
function class(super)
	local class_type={}
	class_type.ctor=false
	class_type.super=super
	class_type.new=function(...) 
			local obj={}
			do
				local create
				create = function(c,...)
					if c.super then
						create(c.super,...)
					end
					if c.ctor then
						c.ctor(obj,...)
					end
				end
 
				create(class_type,...)
			end
			setmetatable(obj,{ __index=_class[class_type] })
			return obj
		end
	local vtbl={}
	_class[class_type]=vtbl
 
	setmetatable(class_type,{__newindex=
		function(t,k,v)
			vtbl[k]=v
		end
	})
 
	if super then
		setmetatable(vtbl,{__index=
			function(t,k)
				local ret=_class[super][k]
				vtbl[k]=ret
				return ret
			end
		})
	end
 
	return class_type
end

base_type=class()		-- ����һ������ base_type
 
function base_type:ctor(x)	-- ���� base_type �Ĺ��캯��
	print("base_type ctor")
	self.x=x
end
 
function base_type:print_x()	-- ����һ����Ա���� base_type:print_x
	print(self.x)
end
 
function base_type:hello()	-- ������һ����Ա���� base_type:hello
	print("hello base_type")
end

test=class(base_type)	-- ����һ���� test �̳��� base_type
 
function test:ctor()	-- ���� test �Ĺ��캯��
	print("test ctor")
end
 
function test:hello()	-- ���� base_type:hello Ϊ test:hello
	print("hello test")
end

base_timer=class();
function base_timer:ctor(fun)
	self.stime=lib.GetTime();
	self.status=0;
	self.fun=fun;
end
function base_timer:start()
	self.status=1;
end
function base_timer:pause()
	self.status=0;
end
function base_timer:go()
	if self.status~=1 or self.fun==nil then
		return;
	end
	local t=lib.GetTime()-self.stime;
	if self.fun(t)==1 then
		self.status=0;
	end
end
---------------------------
--window
base_window=class();
function base_window:ctor(mother,str,size,kind,array,color,bjcolor)
	--mother
	if mother~=nil then
		mother.sub[0]=mother.sub[0]+1;
		mother.sub[mother.sub[0]]=self;
		self.mother=mother;
	end
	self.sub={[0]=0,};
	--position
	self.x=10;
	self.y=10;
	self.w=1;
	self.h=1;
	self.str=str or "";
	self.size=size or CC.Fontbig;
	self.kind=kind or "nothing";
	self.array=array or "line";
	self.color=color or C_WHITE;
	self.bjcolor=bjcolor or C_BLACK;
end
function base_window:show()
	--[[
	--��re-size���Զ�����
	if self.mother==nil then
		x=(CC.ScreenW-self.w)/2;
		y=(CC.ScreenH-self.h)/2;
	else
		x=self.mother.x;
		y=self.mother.y;
	end
	]]--
	--self show
	if self.kind=="nothing" then
		
	elseif self.kind=="box" then
		DrawBox(self.x,self.y,self.x+self.w,self.y+self.h,self.color,self.bjcolor);
	elseif self.kind=="newbox" then
		DrawNewBox1(self.x,self.y,self.x+self.w,self.y+self.h,self.color,self.bjcolor);
	elseif self.kind=="str" then
		DrawString(self.x,self.y,self.str,self.color,self.size);
	elseif self.kind=="strbox" then
		DrawStrBox(self.x,self.y,self.str,self.color,self.size,self.bjcolor);
	elseif self.kind=="strnewbox" then
		DrawStrNewBox1(self.x,self.y,self.str,self.color,self.size,self.bjcolor);
	elseif self.kind=="strbox1" then
	
	elseif self.kind=="strbox2" then
	
	elseif self.kind=="strbox3" then
	
	end
	--child show
	for i=1,self.sub[0] do
		self.sub[i]:show();
	end
end
function base_window:autoposition()
	if self.mother==nil then
		self:autosize();
		self.x=(CC.ScreenW-self.w)/2;
		self.y=(CC.ScreenH-self.h)/2;
	end
		
	
	local x,y=self.x,self.y;
	if self.kind=="box" or self.kind=="strbox" then
		x=x+CC.MenuBorderPixel;
		y=y+CC.MenuBorderPixel;
	elseif self.kind=="newbox" or self.kind=="strnewbox" then
		x=x+CC.MenuBorderPixel*2;
		y=y+CC.MenuBorderPixel*2;
	end
	for i=1,self.sub[0] do
		if self.array=="line" then
			self.sub[i].x=x;
			self.sub[i].y=y;
			y=y+self.sub[i].h+CC.MenuBorderPixel;
		elseif self.array=="row" then
			self.sub[i].x=x;
			self.sub[i].y=y;
			x=x+self.sub[i].w+CC.MenuBorderPixel;
		else
		
		end
		self.sub[i]:autoposition();
	end
end
function base_window:autosize()
	local max_w,max_h=0,0;
	local total_w,total_h=0,0;
	for i=1,self.sub[0] do
		self.sub[i]:autosize();
		if self.sub[i].w>max_w then
			max_w=self.sub[i].w;
		end
		if self.sub[i].h>max_h then
			max_h=self.sub[i].h;
		end
		total_w=total_w+self.sub[i].w;
		total_h=total_h+self.sub[i].h;
	end
	if self.sub[0]>1 then
		total_w=total_w+CC.MenuBorderPixel*(self.sub[0]-1);
		total_h=total_h+CC.MenuBorderPixel*(self.sub[0]-1);
	end
	--self autosize
	if self.array=="line" then
		self.w=max_w;
		self.h=total_h;
	elseif self.array=="row" then
		self.w=total_w;
		self.h=max_h;
	else
	
	end
	if self.kind=="nothing" then
		
	elseif self.kind=="box" then
		self.w=self.w+CC.MenuBorderPixel*2;
		self.h=self.h+CC.MenuBorderPixel*2;
	elseif self.kind=="newbox" then
		self.w=self.w+CC.MenuBorderPixel*4;
		self.h=self.h+CC.MenuBorderPixel*4;
	elseif self.kind=="str" then
		self.w=self.size*#self.str/2;
		self.h=self.size;
	elseif self.kind=="strbox" then
		self.w=self.size*#self.str/2;
		self.h=self.size;
		self.w=self.w+CC.MenuBorderPixel*2;
		self.h=self.h+CC.MenuBorderPixel*2;
	elseif self.kind=="strnewbox" then
		self.w=self.size*#self.str/2;
		self.h=self.size;
		self.w=self.w+CC.MenuBorderPixel*4;
		self.h=self.h+CC.MenuBorderPixel*4;
	elseif self.kind=="strbox1" then
	
	elseif self.kind=="strbox2" then
	
	elseif self.kind=="strbox3" then
	
	end
	lib.Debug(self.w..","..self.h);
end
---------------------------
base_box=class();
function base_box:ctor(mother,x,y,w,h,linekind,linecolor,bjkind,bjcolor)
	if mother~=nil then
		mother.sub[0]=mother.sub[0]+1;
		mother.sub[mother.sub[0]]=self;
		self.mother=mother;
	end
	self.x=x;
	self.y=y;
	self.w=w;
	self.h=h;
	self.linekind=linekind;
	self.linecolor=linecolor;
	self.bjkind=bjkind;
	self.bjcolor=bjcolor;
	self.sub={[0]=0,};
end
function base_box:show()
	local x,y;
	if self.mother==nil then
		x=0;
		y=0;
	else
		x=self.mother.x;
		y=self.mother.y;
	end
	
	local s=4;
	local x1,y1,x2,y2=x+self.x,y+self.y,x+self.x+self.w,y+self.y+self.h;
	if self.bjkind~=0 then
		lib.Background(x1,y1+s,x1+s,y2-s,128,self.bjcolor);    --��Ӱ���Ľǿճ�
		lib.Background(x1+s,y1,x2-s,y2,128,self.bjcolor);
		lib.Background(x2-s,y1+s,x2,y2-s,128,self.bjcolor);
		if self.bjcolor~=0 then
			lib.Background(x1,y1+s,x1+s,y2-s,128,self.bjcolor);    --��Ӱ���Ľǿճ�
			lib.Background(x1+s,y1,x2-s,y2,128,self.bjcolor);
			lib.Background(x2-s,y1+s,x2,y2-s,128,self.bjcolor);
		end
	end
	if self.linekind==1 then
		DrawBox_1(x1,y1,x2,y2,self.linecolor);
	elseif self.linekind==2 then
		local r,g,b=GetRGB(self.linecolor);
		DrawBox_1(x1+1,y1,x2,y2,RGB(math.modf(r/2),math.modf(g/2),math.modf(b/2)));
		DrawBox_1(x1,y1,x2-1,y2-1,self.linecolor);
	end
	for i=1,self.sub[0] do
		self.sub[i]:show();
	end
end

base_string=class();
function base_string:ctor(mother,x,y,str,color)
	if mother~=nil then
		mother.sub[0]=mother.sub[0]+1;
		mother.sub[mother.sub[0]]=self;
		self.mother=mother;
	end
	self.x=x;
	self.y=y;
	self.str=str;
	self.color=color;
end
function base_string:show()
	local x,y;
	if self.mother==nil then
		x=0;
		y=0;
	else
		x=self.mother.x;
		y=self.mother.y;
	end
	DrawString();
	for i=1,self.sub[0] do
		self.sub[i]:show();
	end
end

base_label=class(base_box);
function base_label:ctor(str)
	self.str=str;
end
function base_label:show()
	
end


--========================================================================
function MMenu()      --���˵�
	--lib.PicLoadFile(CC.SMAPPicFile[1],CC.SMAPPicFile[2],90);
	--lib.PicLoadFile(CC.MMAPPicFile[1],CC.MMAPPicFile[2],91);
	--lib.PicLoadFile(CC.EffectFile[1],CC.EffectFile[2],92);
	local size=math.min(
										(math.modf((CC.ScreenW*1-CC.MenuBorderPixel*12-CC.RowPixel*5)/26)),						--����Ļ�����
										math.min(																													--����Ļ�߼���
															(math.modf((CC.ScreenH-CC.MenuBorderPixel*4)/16)),		--�ֺŽϴ�ʱ
															(math.modf((CC.ScreenH-CC.MenuBorderPixel*4-150)/12))	--�ֺŽ�Сʱ
														)-CC.RowPixel
									);
	--size=32
	local xy={};
	xy.x1=(CC.ScreenW-size*26-CC.MenuBorderPixel*12-CC.RowPixel*5)/2;
	xy.x2=xy.x1+CC.MenuBorderPixel*2+CC.RowPixel+size*4;
	xy.x3=xy.x1+CC.MenuBorderPixel*10+CC.RowPixel*5+size*20;
	xy.y1=(CC.ScreenH-CC.MenuBorderPixel*4-(size+CC.RowPixel)*12-math.max(size*4+CC.RowPixel*3,150))/2;
	xy.y2=xy.y1+CC.MenuBorderPixel*2+CC.RowPixel+size;
	
	local b={};
	b.main={};
	b.team={};
	b.status={};
	b.kungfu={};
	b.item={};
	b.sys={};
	
	
	local page=1;
	local select=b.main[1];
	local teamid=1;
	local teamid_start=0;
	local kungfu_start=0;
	local kfkind=0;
	local kfid=0;
	local itemkind=0;
	local useitem=-1;
	local itemstart=0;
	
	local eft=0;
	local oldeft=-1;
	
	--��Ʒ�����һЩ����
	local picw=80;
	local pich=80;
	local XPixel=4;
	local YPixel=4;
	local itemdx=xy.x2;
	local itemdy=xy.y2+size+CC.MenuBorderPixel*2+CC.RowPixel;
	local itemw=xy.x3-CC.MenuBorderPixel-xy.x2-XPixel;
	local itemh=CC.ScreenH-xy.y1-itemdy-YPixel;
	local xnum,ynum;
	xnum=math.modf(itemw/(picw+XPixel));
	ynum=math.modf(itemh/(pich+YPixel));
	local dw=itemw-(picw+XPixel)*xnum;
	local dh=itemh-(pich+YPixel)*ynum;
	XPixel=XPixel+math.modf(dw/(xnum+1));
	YPixel=YPixel+math.modf(dh/(ynum+1));
	--itemdx=itemdx+math.modf((itemw-(picw+XPixel)*xnum)/2);
	--itemdy=itemdy+math.modf((itemh-(pich+YPixel)*ynum)/2);
	
	
	JY.CurID=JY.Base["����"..teamid];
	
	local function findkf()
		for id=kfid+1,200 do
			local kf=JY.Person[JY.CurID]["�����书"..id];
			if kf<=0 then
				break;
			end
			if kfkind==0 or JY.Wugong[kf]["�书����"]==kfkind then
				kfid=id;
				return true;
			end
		end
		return false
	end
	local function finditem(num)
		local n=0;
		for id=xnum*itemstart+1,200 do
			local kf=JY.Base["��Ʒ"..id];
			local kfnum=JY.Base["��Ʒ����"..id];
			if kf <0 or kfnum<=0 then
				return 0;
			end
			if itemkind==0 or JY.Thing[kf]["����"]==itemkind-1 then
				n=n+1;
			end
			if n==num then
				return id;
			end
		end
		return 0;
	end
	local function setkf()
		local kid=JY.Person[JY.CurID]["�����书"..kfid];
		local kfexp=JY.Person[JY.CurID]["�����书����"..kfid];
		local kind=JY.Wugong[kid]["�书����"];
		if between(kind,1,6) then
			for i=1,5 do
				if JY.Person[JY.CurID]["�⹦"..i]==0 then
					JY.Person[JY.CurID]["�⹦"..i]=kid;
					JY.Person[JY.CurID]["�⹦����"..i]=kfexp;
					return;
				elseif JY.Person[JY.CurID]["�⹦"..i]==kid then
					JY.Person[JY.CurID]["�⹦"..i]=0;
					JY.Person[JY.CurID]["�⹦����"..i]=0;
					for j=i,4 do
						JY.Person[JY.CurID]["�⹦"..j],JY.Person[JY.CurID]["�⹦"..(j+1)]=JY.Person[JY.CurID]["�⹦"..(j+1)],JY.Person[JY.CurID]["�⹦"..j];
						JY.Person[JY.CurID]["�⹦����"..j],JY.Person[JY.CurID]["�⹦����"..(j+1)]=JY.Person[JY.CurID]["�⹦����"..(j+1)],JY.Person[JY.CurID]["�⹦����"..j];
					end
					return;
				end
			end
			JYMsgBox("��ʾ","���ֻ��װ������⹦Ŷ��",{"ȷ��"},1,16);
		elseif kind==7 then
			if JY.Person[JY.CurID]["�ڹ�"]==0 then
				JY.Person[JY.CurID]["�ڹ�"]=kid;
				JY.Person[JY.CurID]["�ڹ�����"]=kfexp;
			elseif JY.Person[JY.CurID]["�ڹ�"]==kid then
				JY.Person[JY.CurID]["�ڹ�"]=0;
				JY.Person[JY.CurID]["�ڹ�����"]=0;
			else
				JY.Person[JY.CurID]["�ڹ�"]=kid;
				JY.Person[JY.CurID]["�ڹ�����"]=kfexp;
			end
		elseif kind==8 then
			if JY.Person[JY.CurID]["�Ṧ"]==0 then
				JY.Person[JY.CurID]["�Ṧ"]=kid;
				JY.Person[JY.CurID]["�Ṧ����"]=kfexp;
			elseif JY.Person[JY.CurID]["�Ṧ"]==kid then
				JY.Person[JY.CurID]["�Ṧ"]=0;
				JY.Person[JY.CurID]["�Ṧ����"]=0;
			else
				JY.Person[JY.CurID]["�Ṧ"]=kid;
				JY.Person[JY.CurID]["�Ṧ����"]=kfexp;
			end
		elseif kind==9 then
			if JY.Person[JY.CurID]["�ؼ�"]==0 then
				JY.Person[JY.CurID]["�ؼ�"]=kid;
				JY.Person[JY.CurID]["�ؼ�����"]=kfexp;
			elseif JY.Person[JY.CurID]["�ؼ�"]==kid then
				JY.Person[JY.CurID]["�ؼ�"]=0;
				JY.Person[JY.CurID]["�ؼ�����"]=0;
			else
				JY.Person[JY.CurID]["�ؼ�"]=kid;
				JY.Person[JY.CurID]["�ؼ�����"]=kfexp;
			end
		end
		ResetPersonAttrib(JY.CurID);
	end
	local function DrawEFT()
		DrawBox(xy.x3,xy.y2+43+CC.MenuBorderPixel*13+size*10,CC.ScreenW-xy.x1,CC.ScreenH-xy.y1,C_WHITE);
		if oldeft<0 then
			return;
		end
		local starteft=0;          --������ʼ�书Ч��֡
		for mi=0,oldeft-1 do
			starteft=starteft+CC.Effect[mi];
		end
		lib.PicLoadCache(3,(starteft+eft)*2,(CC.ScreenW+xy.x3-xy.x1)/2,CC.ScreenH-xy.y1);
			eft=eft+1;
		if eft>=CC.Effect[oldeft] then
			eft=0;
		end
	end
	local function DrawKf(kid,kflv,flag)
		local x,y,w,h;
		--x=b.kungfu[1].x2+CC.MenuBorderPixel;
		--y=b.kungfu[1].y1;
		w=xy.x3-CC.MenuBorderPixel*2-b.kungfu[1].x2;
		h=(CC.ScreenH-xy.y1-b.kungfu[1].y1)/2;
		h=math.min(w-size-CC.MenuBorderPixel*2,math.max(h,(size+CC.RowPixel)*4+CC.MenuBorderPixel*2))+CC.MenuBorderPixel*2;
		w=h+size+CC.MenuBorderPixel*2-size;
		x=xy.x3-CC.MenuBorderPixel-w;
		y=CC.ScreenH-xy.y1-h*2;
		--kid=kf[1];
		--kflv=1+math.modf(kf[2]/100);
		ShowKungfuMove(x-3,y,w,h,kid,kflv,size);
		ShowKungfuAtk(x-3,y+h,w,h,kid,kflv,size);
		local size2=math.modf(w/8);
		
		x=xy.x2+CC.MenuBorderPixel*2;
		y=CC.ScreenH-xy.y1
		if flag then
			DrawString(x,y-size2*2-CC.RowPixel,"��F1�ɲ鿴�书��Ч",M_Gray,size2);
		end
		DrawString(x,y-size2-CC.RowPixel,string.format("����:%2d",JY.Wugong[kid]["����"]),M_Gray,size2);
		DrawString(x+w/2,y-size2-CC.RowPixel,string.format("����:%2d",JY.Wugong[kid]["����"]),M_Gray,size2);
		DrawString(x+w,y-size2-CC.RowPixel,string.format("��:%2d",JY.Wugong[kid]["��"]),M_Gray,size2);
		--DrawEFT(JY.Wugong[kid]["�书����&��Ч"])
		if oldeft~=JY.Wugong[kid]["�书����&��Ч"] then
			oldeft=JY.Wugong[kid]["�书����&��Ч"];
			eft=0;
		end
	end
	--local kungfuid
	b.main[1]={
						name=' ״  ̬ ',
						x1=xy.x2,
						x2=xy.x2+size*4+CC.MenuBorderPixel*2,
						y1=xy.y1,
						y2=xy.y1+size+CC.MenuBorderPixel*2,
						on=	function()
									page=1;
								end,
						click=function()
									select=b.team[teamid];
								end,
					};
	b.main[2]={
						name=' ��  �� ',
						x1=xy.x2+size*4+CC.MenuBorderPixel*2+CC.RowPixel,
						x2=xy.x2+size*8+CC.MenuBorderPixel*4+CC.RowPixel,
						y1=xy.y1,
						y2=xy.y1+size+CC.MenuBorderPixel*2,
						on=	function()
									page=2;
								end,
						click=function()
									select=b.team[teamid];
								end,
					};
	b.main[3]={
						name=' ��  Ʒ ',
						x1=xy.x2+size*8+CC.MenuBorderPixel*4+CC.RowPixel*2,
						x2=xy.x2+size*12+CC.MenuBorderPixel*6+CC.RowPixel*2,
						y1=xy.y1,
						y2=xy.y1+size+CC.MenuBorderPixel*2,
						on=	function()
									page=3;
								end,
						click=function()
									select=b.item[101+itemkind];
								end,
					};
	b.main[4]={
						name=' ϵ  ͳ ',
						x1=xy.x2+size*12+CC.MenuBorderPixel*6+CC.RowPixel*3,
						x2=xy.x2+size*16+CC.MenuBorderPixel*8+CC.RowPixel*3,
						y1=xy.y1,
						y2=xy.y1+size+CC.MenuBorderPixel*2,
						on=	function()
									page=4;
								end,
						click=function()
									select=b.sys[1];
								end,
					};
	for i=1,CC.TeamNum do
		local pid=JY.Base["����"..i];
		b.team[i]={
							name=fillblank(JY.Person[pid]["����"],8),
							x1=xy.x1,
							x2=xy.x1+size*4+CC.MenuBorderPixel*2,
							y1=xy.y2+(size+CC.RowPixel)*(i-1),
							y2=xy.y2+size+CC.MenuBorderPixel*2+(size+CC.RowPixel)*(i-1),
							on=	function()
										teamid=i;
										JY.CurID=JY.Base["����"..teamid];
									end,
							click=function()
										return;
									end,
						};
		if i==CC.TeamNum or JY.Base["����"..i+1]<0 then
			for j=i+1,CC.TeamNum do
				b.team[j]=nil;
			end
			break;
		end
	end
	b.status[1]={
							name='���',
							x1=xy.x2+math.max(150,size*2+120,size*7)+CC.MenuBorderPixel*2,
							x2=xy.x2+math.max(150,size*2+120,size*7)+CC.MenuBorderPixel*4+size,
							y1=CC.ScreenH-xy.y1-CC.MenuBorderPixel*3-size*2-CC.RowPixel,
							y2=CC.ScreenH-xy.y1-CC.MenuBorderPixel,
							on=	function()
										return;
									end,
							click=function()
										if JY.CurID==0 then
											return;
										end
										if DrawStrBoxYesNo(-1,-1,"ȷ��Ҫ�ã�"..JY.Person[JY.CurID]["����"].."�������",C_WHITE,CC.Fontbig) then
											say("��"..JY.Person[JY.CurID]["����"].."�ף��Ȼأ�"..JY.Scene[JY.Shop[JY.Person[JY.CurID]["����"]]["�ݵ�"]]["����"].."�װɣ��ҹ�����ȥ���㡣");
											decteam(JY.CurID);
											for i=teamid,CC.TeamNum-1 do
												if b.team[i+1]==nil then
													b.team[i]=nil;
													break;
												end
												b.team[i].name=b.team[i+1].name
											end
											if b.team[teamid]==nil then
												teamid=teamid-1;
											end
											JY.CurID=JY.Base["����"..teamid];
										end
										return;
									end,
						};
	b.status[2]={--xy.y2+CC.MenuBorderPixel+math.max(160,size*4+CC.RowPixel*3)+CC.Fontbig+CC.RowPixel;math.max((size+CC.RowPixel)*3,85);
							name='����',
							x1=xy.x2+CC.MenuBorderPixel*2+math.max(size*7,size*2+120,150)+size*5,
							x2=xy.x2+CC.MenuBorderPixel*2+math.max(size*7,size*2+120,150)+size*10,
							y1=xy.y2+CC.MenuBorderPixel+math.max(160,size*4+CC.RowPixel*3)+CC.Fontbig+CC.RowPixel+math.max((size+CC.RowPixel)*3,85),
							y2=xy.y2+CC.MenuBorderPixel+math.max(160,size*4+CC.RowPixel*3)+CC.Fontbig+CC.RowPixel+math.max((size+CC.RowPixel)*3,85)+size,
							on=	function()
										return;
									end,
							click=function()
										if JY.Person[JY.Base["����"..teamid]]["����"]>=0 then
											instruct_32(JY.Person[JY.Base["����"..teamid]]["����"],1);
											JY.Item[JY.Person[JY.Base["����"..teamid]]["����"]].unuse(JY.Base["����"..teamid]);
											JY.Person[JY.Base["����"..teamid]]["����"]=-1;
										end
										return;
									end,
						};
	b.status[3]={
							name='����',
							x1=xy.x2+CC.MenuBorderPixel*2+math.max(size*7,size*2+120,150)+size*5,
							x2=xy.x2+CC.MenuBorderPixel*2+math.max(size*7,size*2+120,150)+size*10,
							y1=xy.y2+CC.MenuBorderPixel+math.max(160,size*4+CC.RowPixel*3)+CC.Fontbig+CC.RowPixel+math.max((size+CC.RowPixel)*3,85)+size+CC.RowPixel,
							y2=xy.y2+CC.MenuBorderPixel+math.max(160,size*4+CC.RowPixel*3)+CC.Fontbig+CC.RowPixel+math.max((size+CC.RowPixel)*3,85)+size*2+CC.RowPixel,
							on=	function()
										return;
									end,
							click=function()
										if JY.Person[JY.Base["����"..teamid]]["����"]>=0 then
											instruct_32(JY.Person[JY.Base["����"..teamid]]["����"],1);
											JY.Item[JY.Person[JY.Base["����"..teamid]]["����"]].unuse(JY.Base["����"..teamid]);
											JY.Person[JY.Base["����"..teamid]]["����"]=-1;
										end
										return;
									end,
						};
	b.status[4]={
							name='ȫ',
							x1=xy.x3+1,
							x2=xy.x3+size+2,
							y1=xy.y2,
							y2=xy.y2+size+CC.MenuBorderPixel*2,
							on=	function()
										return;
									end,
							click=function()
										return;
									end,
						};
	b.status[5]={
							name='��',
							x1=xy.x3+(size+1)+1,
							x2=xy.x3+(size+1)*2+1,
							y1=xy.y2,
							y2=xy.y2+size+CC.MenuBorderPixel*2,
							on=	function()
										return;
									end,
							click=function()
										return;
									end,
						};
	b.status[6]={
							name='��',
							x1=xy.x3+(size+1)*2+1,
							x2=xy.x3+(size+1)*3+1,
							y1=xy.y2,
							y2=xy.y2+size+CC.MenuBorderPixel*2,
							on=	function()
										return;
									end,
							click=function()
										return;
									end,
						};
	b.status[7]={
							name='��',
							x1=xy.x3+(size+1)*3+1,
							x2=xy.x3+(size+1)*4+1,
							y1=xy.y2,
							y2=xy.y2+size+CC.MenuBorderPixel*2,
							on=	function()
										return;
									end,
							click=function()
										return;
									end,
						};
	b.status[8]={
							name='��',
							x1=xy.x3+(size+1)*4+1,
							x2=xy.x3+(size+1)*5+1,
							y1=xy.y2,
							y2=xy.y2+size+CC.MenuBorderPixel*2,
							on=	function()
										return;
									end,
							click=function()
										return;
									end,
						};
	b.status[9]={
							name='��',
							x1=xy.x3+(size+1)*5+1,
							x2=xy.x3+(size+1)*6+1,
							y1=xy.y2,
							y2=xy.y2+size+CC.MenuBorderPixel*2,
							on=	function()
										return;
									end,
							click=function()
										return;
									end,
						};
	--[[
	b.status[10]={};
	b.status[11]={};
	b.status[12]={};
	b.status[13]={};
	b.status[14]={};
	b.status[15]={};
	b.status[16]={};
	b.status[17]={};
	]]--
	b.kungfu[1]={
							name='�⹦1',
							x1=xy.x2+CC.MenuBorderPixel*3+size*2,
							x2=xy.x2+CC.MenuBorderPixel*3+size*8,
							y1=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*2,
							y2=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*3,
							on=	function()
										return;
									end,
							click=function()
										JY.Person[JY.Base["����"..teamid]]["�⹦"..1]=0;
										JY.Person[JY.Base["����"..teamid]]["�⹦����"..1]=0;
										for j=1,4 do
											JY.Person[JY.CurID]["�⹦"..j],JY.Person[JY.CurID]["�⹦"..(j+1)]=JY.Person[JY.CurID]["�⹦"..(j+1)],JY.Person[JY.CurID]["�⹦"..j];
											JY.Person[JY.CurID]["�⹦����"..j],JY.Person[JY.CurID]["�⹦����"..(j+1)]=JY.Person[JY.CurID]["�⹦����"..(j+1)],JY.Person[JY.CurID]["�⹦����"..j];
										end
										ResetPersonAttrib(JY.CurID);
									end;
							F1=	function()
										local kfid=JY.Person[JY.Base["����"..teamid]]["�⹦"..1];
										local kflv=GetLv(JY.Base["����"..teamid],1);
										if kfid>0 then
											ShowSmagic(kfid,kflv);
										end
									end
						};
	b.kungfu[2]={
							name='�⹦2',
							x1=xy.x2+CC.MenuBorderPixel*3+size*2,
							x2=xy.x2+CC.MenuBorderPixel*3+size*8,
							y1=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*3+math.modf((size+CC.RowPixel)/8),
							y2=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*4+math.modf((size+CC.RowPixel)/8),
							on=	function()
										return;
									end,
							click=function()
										JY.Person[JY.Base["����"..teamid]]["�⹦"..2]=0;
										JY.Person[JY.Base["����"..teamid]]["�⹦����"..2]=0;
										for j=2,4 do
											JY.Person[JY.CurID]["�⹦"..j],JY.Person[JY.CurID]["�⹦"..(j+1)]=JY.Person[JY.CurID]["�⹦"..(j+1)],JY.Person[JY.CurID]["�⹦"..j];
											JY.Person[JY.CurID]["�⹦����"..j],JY.Person[JY.CurID]["�⹦����"..(j+1)]=JY.Person[JY.CurID]["�⹦����"..(j+1)],JY.Person[JY.CurID]["�⹦����"..j];
										end
										ResetPersonAttrib(JY.CurID);
									end;
							F1=	function()
										local kfid=JY.Person[JY.Base["����"..teamid]]["�⹦"..2];
										local kflv=GetLv(JY.Base["����"..teamid],2);
										if kfid>0 then
											ShowSmagic(kfid,kflv);
										end
									end
						};
	b.kungfu[3]={
							name='�⹦3',
							x1=xy.x2+CC.MenuBorderPixel*3+size*2,
							x2=xy.x2+CC.MenuBorderPixel*3+size*8,
							y1=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*4+math.modf((size+CC.RowPixel)/4),
							y2=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*5+math.modf((size+CC.RowPixel)/4),
							on=	function()
										return;
									end,
							click=function()
										JY.Person[JY.Base["����"..teamid]]["�⹦"..3]=0;
										JY.Person[JY.Base["����"..teamid]]["�⹦����"..3]=0;
										for j=3,4 do
											JY.Person[JY.CurID]["�⹦"..j],JY.Person[JY.CurID]["�⹦"..(j+1)]=JY.Person[JY.CurID]["�⹦"..(j+1)],JY.Person[JY.CurID]["�⹦"..j];
											JY.Person[JY.CurID]["�⹦����"..j],JY.Person[JY.CurID]["�⹦����"..(j+1)]=JY.Person[JY.CurID]["�⹦����"..(j+1)],JY.Person[JY.CurID]["�⹦����"..j];
										end
										ResetPersonAttrib(JY.CurID);
									end;
							F1=	function()
										local kfid=JY.Person[JY.Base["����"..teamid]]["�⹦"..3];
										local kflv=GetLv(JY.Base["����"..teamid],3);
										if kfid>0 then
											ShowSmagic(kfid,kflv);
										end
									end
						};
	b.kungfu[4]={
							name='�⹦4',
							x1=xy.x2+CC.MenuBorderPixel*3+size*2,
							x2=xy.x2+CC.MenuBorderPixel*3+size*8,
							y1=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*5+math.modf((size+CC.RowPixel)*3/8),
							y2=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*6+math.modf((size+CC.RowPixel)*3/8),
							on=	function()
										return;
									end,
							click=function()
										JY.Person[JY.Base["����"..teamid]]["�⹦"..4]=0;
										JY.Person[JY.Base["����"..teamid]]["�⹦����"..4]=0;
										for j=4,4 do
											JY.Person[JY.CurID]["�⹦"..j],JY.Person[JY.CurID]["�⹦"..(j+1)]=JY.Person[JY.CurID]["�⹦"..(j+1)],JY.Person[JY.CurID]["�⹦"..j];
											JY.Person[JY.CurID]["�⹦����"..j],JY.Person[JY.CurID]["�⹦����"..(j+1)]=JY.Person[JY.CurID]["�⹦����"..(j+1)],JY.Person[JY.CurID]["�⹦����"..j];
										end
										ResetPersonAttrib(JY.CurID);
									end;
							F1=	function()
										local kfid=JY.Person[JY.Base["����"..teamid]]["�⹦"..4];
										local kflv=GetLv(JY.Base["����"..teamid],4);
										if kfid>0 then
											ShowSmagic(kfid,kflv);
										end
									end
						};
	b.kungfu[5]={
							name='�⹦5',
							x1=xy.x2+CC.MenuBorderPixel*3+size*2,
							x2=xy.x2+CC.MenuBorderPixel*3+size*8,
							y1=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*6+math.modf((size+CC.RowPixel)/2),
							y2=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*7+math.modf((size+CC.RowPixel)/2),
							on=	function()
										return;
									end,
							click=function()
										JY.Person[JY.Base["����"..teamid]]["�⹦"..5]=0;
										JY.Person[JY.Base["����"..teamid]]["�⹦����"..5]=0;
										ResetPersonAttrib(JY.CurID);
									end;
							F1=	function()
										local kfid=JY.Person[JY.Base["����"..teamid]]["�⹦"..5];
										local kflv=GetLv(JY.Base["����"..teamid],5);
										if kfid>0 then
											ShowSmagic(kfid,kflv);
										end
									end
						};
	b.kungfu[6]={
							name='�ڹ�',
							x1=xy.x2+CC.MenuBorderPixel*3+size*2,
							x2=xy.x2+CC.MenuBorderPixel*3+size*8,
							y1=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*7+math.modf((size+CC.RowPixel)*5/8),
							y2=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*8+math.modf((size+CC.RowPixel)*5/8),
							on=	function()
										return;
									end,
							click=function()
										JY.Person[JY.Base["����"..teamid]]["�ڹ�"]=0;
										JY.Person[JY.Base["����"..teamid]]["�ڹ�����"]=0;
										ResetPersonAttrib(JY.CurID);
									end;
							F1=	function()
										local kfid,kflv=JY.Person[JY.Base["����"..teamid]]["�ڹ�"],1+math.modf(JY.Person[JY.Base["����"..teamid]]["�ڹ�����"]/100);
										if kfid>0 then
											ShowSmagic(kfid,kflv);
										end
									end
						};
	b.kungfu[7]={
							name='�Ṧ',
							x1=xy.x2+CC.MenuBorderPixel*3+size*2,
							x2=xy.x2+CC.MenuBorderPixel*3+size*8,
							y1=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*8+math.modf((size+CC.RowPixel)*3/4),
							y2=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*9+math.modf((size+CC.RowPixel)*3/4),
							on=	function()
										return;
									end,
							click=function()
										JY.Person[JY.Base["����"..teamid]]["�Ṧ"]=0;
										JY.Person[JY.Base["����"..teamid]]["�Ṧ����"]=0;
										ResetPersonAttrib(JY.CurID);
									end;
							F1=	function()
										local kfid,kflv=JY.Person[JY.Base["����"..teamid]]["�Ṧ"],1+math.modf(JY.Person[JY.Base["����"..teamid]]["�Ṧ����"]/100);
										if kfid>0 then
											ShowSmagic(kfid,kflv);
										end
									end
						};
	b.kungfu[8]={
							name='�ؼ�',
							x1=xy.x2+CC.MenuBorderPixel*3+size*2,
							x2=xy.x2+CC.MenuBorderPixel*3+size*8,
							y1=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*9+math.modf((size+CC.RowPixel)*7/8),
							y2=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel*2+size*10+math.modf((size+CC.RowPixel)*7/8),
							on=	function()
										return;
									end,
							click=function()
										JY.Person[JY.Base["����"..teamid]]["�ؼ�"]=0;
										JY.Person[JY.Base["����"..teamid]]["�ؼ�����"]=0;
										ResetPersonAttrib(JY.CurID);
									end;
							F1=	function()
										local kfid,kflv=JY.Person[JY.Base["����"..teamid]]["�ؼ�"],1+math.modf(JY.Person[JY.Base["����"..teamid]]["�ؼ�����"]/100);
										if kfid>0 then
											ShowSmagic(kfid,kflv);
										end
									end
						};
	b.kungfu[9]={
							name='up',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2,
							y2=xy.y2+25,
							on=	function()
										return;
									end,
							click=function()
										kungfu_start=kungfu_start-1;
										if kungfu_start<0 then
											kungfu_start=0;
										end
									end,
						};
	b.kungfu[10]={
							name='down',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2+20+CC.MenuBorderPixel*11+size*10,
							y2=xy.y2+45+CC.MenuBorderPixel*11+size*10,
							on=	function()
										return;
									end,
							click=function()
										local flag;
										kfid=0;
										for i=1,kungfu_start+11 do
											flag=findkf();
										end
										if flag then
											kungfu_start=kungfu_start+1;
										end
									end,
						};
	b.kungfu[11]={
							name='ȫ',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel+size,
							y1=xy.y2+20+CC.MenuBorderPixel,
							y2=xy.y2+20+CC.MenuBorderPixel*2+size,
							on=	function()
										if kfkind~=0 then
											kfkind=0;
											kungfu_start=0;
										end
									end,
							click=function()
										select=b.kungfu[21];
									end,
						};
	b.kungfu[12]={
							name='ȭ',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel+size,
							y1=xy.y2+20+CC.MenuBorderPixel*2+size,
							y2=xy.y2+20+CC.MenuBorderPixel*3+size*2,
							on=	function()
										if kfkind~=1 then
											kfkind=1;
											kungfu_start=0;
										end
									end,
							click=function()
										select=b.kungfu[21];
									end,
						};
	b.kungfu[13]={
							name='��',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel+size,
							y1=xy.y2+20+CC.MenuBorderPixel*3+size*2,
							y2=xy.y2+20+CC.MenuBorderPixel*4+size*3,
							on=	function()
										if kfkind~=2 then
											kfkind=2;
											kungfu_start=0;
										end
									end,
							click=function()
										select=b.kungfu[21];
									end,
						};
	b.kungfu[14]={
							name='��',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel+size,
							y1=xy.y2+20+CC.MenuBorderPixel*4+size*3,
							y2=xy.y2+20+CC.MenuBorderPixel*5+size*4,
							on=	function()
										if kfkind~=3 then
											kfkind=3;
											kungfu_start=0;
										end
									end,
							click=function()
										select=b.kungfu[21];
									end,
						};
	b.kungfu[15]={
							name='��',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel+size,
							y1=xy.y2+20+CC.MenuBorderPixel*5+size*4,
							y2=xy.y2+20+CC.MenuBorderPixel*6+size*5,
							on=	function()
										if kfkind~=4 then
											kfkind=4;
											kungfu_start=0;
										end
									end,
							click=function()
										select=b.kungfu[21];
									end,
						};
	b.kungfu[16]={
							name='��',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel+size,
							y1=xy.y2+20+CC.MenuBorderPixel*6+size*5,
							y2=xy.y2+20+CC.MenuBorderPixel*7+size*6,
							on=	function()
										if kfkind~=5 then
											kfkind=5;
											kungfu_start=0;
										end
									end,
							click=function()
										select=b.kungfu[21];
									end,
						};
	b.kungfu[17]={
							name='��',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel+size,
							y1=xy.y2+20+CC.MenuBorderPixel*7+size*6,
							y2=xy.y2+20+CC.MenuBorderPixel*8+size*7,
							on=	function()
										if kfkind~=6 then
											kfkind=6;
											kungfu_start=0;
										end
									end,
							click=function()
										select=b.kungfu[21];
									end,
						};
	b.kungfu[18]={
							name='��',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel+size,
							y1=xy.y2+20+CC.MenuBorderPixel*8+size*7,
							y2=xy.y2+20+CC.MenuBorderPixel*9+size*8,
							on=	function()
										if kfkind~=7 then
											kfkind=7;
											kungfu_start=0;
										end
									end,
							click=function()
										select=b.kungfu[21];
									end,
						};
	b.kungfu[19]={
							name='��',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel+size,
							y1=xy.y2+20+CC.MenuBorderPixel*9+size*8,
							y2=xy.y2+20+CC.MenuBorderPixel*10+size*9,
							on=	function()
										if kfkind~=8 then
											kfkind=8;
											kungfu_start=0;
										end
									end,
							click=function()
										select=b.kungfu[21];
									end,
						};
	b.kungfu[20]={
							name='��',
							x1=xy.x3,
							x2=xy.x3+CC.MenuBorderPixel+size,
							y1=xy.y2+20+CC.MenuBorderPixel*10+size*9,
							y2=xy.y2+20+CC.MenuBorderPixel*11+size*10,
							on=	function()
										if kfkind~=9 then
											kfkind=9;
											kungfu_start=0;
										end
									end,
							click=function()
										select=b.kungfu[21];
									end,
						};
	b.kungfu[21]={
							name='�书',
							x1=xy.x3+CC.MenuBorderPixel+size,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2+20+CC.MenuBorderPixel,
							y2=xy.y2+20+CC.MenuBorderPixel*2+size,
							on=	function()
										return;
									end,
							click=function()
										kfid=0;
										local flag
										for i=1,kungfu_start+1 do
											flag=findkf();
										end
										if flag then
											setkf();
										end
									end,
						};
	b.kungfu[22]={
							name='�书',
							x1=xy.x3+CC.MenuBorderPixel+size,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2+20+CC.MenuBorderPixel*2+size,
							y2=xy.y2+20+CC.MenuBorderPixel*3+size*2,
							on=	function()
										return;
									end,
							click=function()
										kfid=0;
										local flag
										for i=1,kungfu_start+2 do
											flag=findkf();
										end
										if flag then
											setkf();
										end
									end,
						};
	b.kungfu[23]={
							name='�书',
							x1=xy.x3+CC.MenuBorderPixel+size,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2+20+CC.MenuBorderPixel*3+size*2,
							y2=xy.y2+20+CC.MenuBorderPixel*4+size*3,
							on=	function()
										return;
									end,
							click=function()
										kfid=0;
										local flag
										for i=1,kungfu_start+3 do
											flag=findkf();
										end
										if flag then
											setkf();
										end
									end,
						};
	b.kungfu[24]={
							name='�书',
							x1=xy.x3+CC.MenuBorderPixel+size,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2+20+CC.MenuBorderPixel*4+size*3,
							y2=xy.y2+20+CC.MenuBorderPixel*5+size*4,
							on=	function()
										return;
									end,
							click=function()
										kfid=0;
										local flag
										for i=1,kungfu_start+4 do
											flag=findkf();
										end
										if flag then
											setkf();
										end
									end,
						};
	b.kungfu[25]={
							name='�书',
							x1=xy.x3+CC.MenuBorderPixel+size,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2+20+CC.MenuBorderPixel*5+size*4,
							y2=xy.y2+20+CC.MenuBorderPixel*6+size*5,
							on=	function()
										return;
									end,
							click=function()
										kfid=0;
										local flag
										for i=1,kungfu_start+5 do
											flag=findkf();
										end
										if flag then
											setkf();
										end
									end,
						};
	b.kungfu[26]={
							name='�书',
							x1=xy.x3+CC.MenuBorderPixel+size,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2+20+CC.MenuBorderPixel*6+size*5,
							y2=xy.y2+20+CC.MenuBorderPixel*7+size*6,
							on=	function()
										return;
									end,
							click=function()
										kfid=0;
										local flag
										for i=1,kungfu_start+6 do
											flag=findkf();
										end
										if flag then
											setkf();
										end
									end,
						};
	b.kungfu[27]={
							name='�书',
							x1=xy.x3+CC.MenuBorderPixel+size,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2+20+CC.MenuBorderPixel*7+size*6,
							y2=xy.y2+20+CC.MenuBorderPixel*8+size*7,
							on=	function()
										return;
									end,
							click=function()
										kfid=0;
										local flag
										for i=1,kungfu_start+7 do
											flag=findkf();
										end
										if flag then
											setkf();
										end
									end,
						};
	b.kungfu[28]={
							name='�书',
							x1=xy.x3+CC.MenuBorderPixel+size,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2+20+CC.MenuBorderPixel*8+size*7,
							y2=xy.y2+20+CC.MenuBorderPixel*9+size*8,
							on=	function()
										return;
									end,
							click=function()
										kfid=0;
										local flag
										for i=1,kungfu_start+8 do
											flag=findkf();
										end
										if flag then
											setkf();
										end
									end,
						};
	b.kungfu[29]={
							name='�书',
							x1=xy.x3+CC.MenuBorderPixel+size,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2+20+CC.MenuBorderPixel*9+size*8,
							y2=xy.y2+20+CC.MenuBorderPixel*10+size*9,
							on=	function()
										return;
									end,
							click=function()
										kfid=0;
										local flag
										for i=1,kungfu_start+9 do
											flag=findkf();
										end
										if flag then
											setkf();
										end
									end,
						};
	b.kungfu[30]={
							name='�书',
							x1=xy.x3+CC.MenuBorderPixel+size,
							x2=xy.x3+CC.MenuBorderPixel*2+size*6,
							y1=xy.y2+20+CC.MenuBorderPixel*10+size*9,
							y2=xy.y2+20+CC.MenuBorderPixel*11+size*10,
							on=	function()
										return;
									end,
							click=function()
										kfid=0;
										local flag
										for i=1,kungfu_start+10 do
											flag=findkf();
										end
										if flag then
											setkf();
										end
									end,
						};
	
	
	----
	
	for i=1,5 do
		local str={'ȫ����Ʒ','������Ʒ','�鵤��ҩ','�书�ؼ�','�������'};
		b.item[100+i]={
							name=str[i],
							x1=xy.x1,
							x2=xy.x1+size*4+CC.MenuBorderPixel*2,
							y1=xy.y2+(size+CC.RowPixel)*(i-1),
							y2=xy.y2+size+CC.MenuBorderPixel*2+(size+CC.RowPixel)*(i-1),
							on=	function()
										itemkind=i-1;
									end,
							click=function()
										return;
									end,
						};
	end
	--[[
	b.item[1]={
						name='ȫ����Ʒ',
						x1=,
						x2=,
						y1=,
						y2=,
						on=	function()
									itemkind=0;
								end,
						click=function()
									return;
								end,
					};
	b.item[2]={
						name='������Ʒ',
						x1=,
						x2=,
						y1=,
						y2=,
						on=	function()
									itemkind=1;
								end,
						click=function()
									return;
								end,
					};
	b.item[3]={
						name='�鵤��ҩ',
						x1=,
						x2=,
						y1=,
						y2=,
						on=	function()
									itemkind=2;
								end,
						click=function()
									return;
								end,
					};
	b.item[4]={
						name='�书�ؼ�',
						x1=,
						x2=,
						y1=,
						y2=,
						on=	function()
									itemkind=3;
								end,
						click=function()
									return;
								end,
					};
	b.item[5]={
						name='�������',
						x1=,
						x2=,
						y1=,
						y2=,
						on=	function()
									itemkind=4;
								end,
						click=function()
									return;
								end,
					};
	]]--
	for i=1,ynum do
		for j=1,xnum do
			b.item[xnum*(i-1)+j]={
												name='��Ʒ',
												x1=itemdx+XPixel+(picw+XPixel)*(j-1),
												x2=itemdx+XPixel+picw+(picw+XPixel)*(j-1),
												y1=itemdy+YPixel+(pich+YPixel)*(i-1),
												y2=itemdy+YPixel+pich+(pich+YPixel)*(i-1),
												on=	function()
															return;
														end,
												click=function()
															local id=finditem(xnum*(i-1)+j);
															if id>0 then
																local tid=JY.Base["��Ʒ"..id];
																local kind=JY.Thing[tid]["����"];
																if kind>1 then
																	useitem=tid;
																end
															end
															return;
														end
											};
		end
	end
	
	
	
	
	---
		
	for i=1,4 do
		local str={' ����һ ',' ���ȶ� ',' ������ ',' �Զ��� '};
		b.sys[i]={
							name=str[i],
							x1=xy.x1,
							x2=xy.x1+size*4+CC.MenuBorderPixel*2,
							y1=xy.y2+(size+CC.RowPixel)*(i-1),
							y2=xy.y2+size+CC.MenuBorderPixel*2+(size+CC.RowPixel)*(i-1),
							on=	function()
										return;
									end,
							click=function()
										local button={"�������","��ȡ����","�ҵ����"};
										local rr=JYMsgBox("��ȡ����","���ʣ�����Ҫ��*                         ",button,3,6);
										if rr==1 then
											if JY.Status==GAME_SMAP then 			--���沿�ֺͳ�����ͼ�浵�����Ϣ
												JY.Base["����"]=JY.SubScene;
											else
												JY.Base["����"]=-1;
											end
											SaveRecord(i);
											return 0;
										elseif rr==2 then
											LoadRecord(i);
											if JY.Base["����"]>-1 then 
												if JY.SubScene < 0 then          --���ڴ��ͼ
													CleanMemory();
													--lib.UnloadMMap();
												end
												--lib.PicInit();
												lib.ShowSlow(50,1)
												JY.Status=GAME_SMAP
												JY.SubScene=JY.Base["����"]
												JY.MmapMusic=-1;
												JY.MyPic=GetMyPic();
												Init_SMap(1);
											else 
												JY.SubScene=-1;
												JY.Status=GAME_FIRSTMMAP;
											end
											return 0;
										else
											return;
										end
									end,
						};
	end
	--[[
		b.sys[1]={
							name=' ����һ ',
							x1=xy.x1,
							x2=xy.x1+size*4+CC.MenuBorderPixel*2,
							y1=xy.y2+(size+CC.RowPixel)*(1-1),
							y2=xy.y2+size+CC.MenuBorderPixel*2+(size+CC.RowPixel)*(1-1),
							on=	function()
										return;
									end,
							click=function()
										local button={"�������","��ȡ����","�ҵ����"};
										local rr=JYMsgBox("��ȡ����","��������Ҫ��",button,3,6);
										if rr==1 then
											SaveRecord(1);
										elseif rr==2 then
											LoadRecord(1);
										else
											return;
										end
									end,
						};
		b.sys[2]={
							name=' ���ȶ� ',
							x1=xy.x1,
							x2=xy.x1+size*4+CC.MenuBorderPixel*2,
							y1=xy.y2+(size+CC.RowPixel)*(2-1),
							y2=xy.y2+size+CC.MenuBorderPixel*2+(size+CC.RowPixel)*(2-1),
							on=	function()
										return;
									end,
							click=function()
										local button={"�������","��ȡ����","�ҵ����"};
										local rr=JYMsgBox("��ȡ����","��������Ҫ��",button,3,6);
										if rr==1 then
											SaveRecord(2);
										elseif rr==2 then
											LoadRecord(2);
										else
											return;
										end
									end,
						};
		b.sys[3]={
							name=' ������ ',
							x1=xy.x1,
							x2=xy.x1+size*4+CC.MenuBorderPixel*2,
							y1=xy.y2+(size+CC.RowPixel)*(3-1),
							y2=xy.y2+size+CC.MenuBorderPixel*2+(size+CC.RowPixel)*(3-1),
							on=	function()
										return;
									end,
							click=function()
										local button={"�������","��ȡ����","�ҵ����"};
										local rr=JYMsgBox("��ȡ����","��������Ҫ��",button,3,6);
										if rr==1 then
											SaveRecord(3);
										elseif rr==2 then
											LoadRecord(3);
										else
											return;
										end
									end,
						};
		b.sys[4]={
							name=' ������ ',
							x1=xy.x1,
							x2=xy.x1+size*4+CC.MenuBorderPixel*2,
							y1=xy.y2+(size+CC.RowPixel)*(4-1),
							y2=xy.y2+size+CC.MenuBorderPixel*2+(size+CC.RowPixel)*(4-1),
							on=	function()
										return;
									end,
							click=function()
										local button={"�������","��ȡ����","�ҵ����"};
										local rr=JYMsgBox("��ȡ����","��������Ҫ��",button,3,6);
										if rr==1 then
											SaveRecord(4);
										elseif rr==2 then
											LoadRecord(4);
										else
											return;
										end
									end,
						};]]--
	b.sys[11]={
						name='  ����С��  ',
						x1=xy.x3,
						x2=xy.x3+size*6+CC.MenuBorderPixel*2,
						y1=xy.y2,
						y2=xy.y2+size+CC.MenuBorderPixel*2,
						on=	function()
									return;
								end,
						click=function()
									return;
								end,
					};
	b.sys[12]={
						name='  ϵͳ����  ',
						x1=xy.x3,
						x2=xy.x3+size*6+CC.MenuBorderPixel*2,
						y1=xy.y2+(size+CC.RowPixel),
						y2=xy.y2+size+CC.MenuBorderPixel*2+(size+CC.RowPixel),
						on=	function()
									return;
								end,
						click=function()
									return Menu_Sys_Set(size);
								end,
					};
	b.sys[13]={
						name='  �뿪��Ϸ  ',
						x1=xy.x3,
						x2=xy.x3+size*6+CC.MenuBorderPixel*2,
						y1=xy.y2+(size+CC.RowPixel)*2,
						y2=xy.y2+size+CC.MenuBorderPixel*2+(size+CC.RowPixel)*2,
						on=	function()
									return;
								end,
						click=function()
									return Menu_Sys_Quit();
								end,
					};
	
	
	b.main[1].up=function() return b.main[1] end;
	b.main[1].down=function() return b.team[teamid] end;
	b.main[1].left=function() return b.main[4] end;
	b.main[1].right=function() return b.main[2] end;
	b.main[2].up=function() return b.main[2] end;
	b.main[2].down=function() return b.team[teamid] end;
	b.main[2].left=function() return b.main[1] end;
	b.main[2].right=function() return b.main[3] end;
	b.main[3].up=function() return b.main[3] end;
	b.main[3].down=function() return b.item[101+itemkind] end;
	b.main[3].left=function() return b.main[2] end;
	b.main[3].right=function() return b.main[4] end;
	b.main[4].up=function() return b.main[4] end;
	b.main[4].down=function() return b.sys[1] end;
	b.main[4].left=function() return b.main[3] end;
	b.main[4].right=function() return b.sys[11] end;
	
	
	for i=1,CC.TeamNum do
		if type(b.team[i])=='nil' then
			break;
		end
		b.team[i].up=function() return b.team[i-1] end;
		b.team[i].down=function() return b.team[i+1] end;
		b.team[i].left=function() return b.team[i] end;
		b.team[i].right=	function()
									if page==1 then
										return b.status[2];
									elseif page==2 then
										return b.kungfu[1];
									else
										return b.team[i];
									end
								end;
		if i==CC.TeamNum or JY.Base["����"..i+1]<0 then
			b.team[i].down=function() return b.team[i] end;
			break;
		end
	end
	b.team[1].up=function() return b.main[page] end;
	
	
	b.status[1].up=function() return b.status[3] end;
	b.status[1].down=function() return b.status[1] end;
	b.status[2].up=function() return b.main[page] end;
	b.status[2].down=function() return b.status[3] end;
	b.status[3].up=function() return b.status[2] end;
	b.status[3].down=function() return b.status[1] end;
	for i=1,3 do
		b.status[i].left=function() return b.team[teamid] end;
		b.status[i].right=function() return b.status[4] end;
	end
	for i=4,9 do
		b.status[i].up=function() return b.main[page] end;
		b.status[i].down=function() return b.status[4] end;
		if i==4 then
			b.status[i].left=function() return b.status[2] end;
		else
			b.status[i].left=function() return b.status[i-1] end;
		end
		if i==9 then
			b.status[i].right=function() return b.status[4] end;
		else
			b.status[i].right=function() return b.status[i+1] end;
		end
	end
	
	for i=1,8 do
		b.kungfu[i].up=function() return b.kungfu[i-1] end;
		b.kungfu[i].down=function() return b.kungfu[i+1] end;
		b.kungfu[i].left=function() return b.team[teamid] end;
		b.kungfu[i].right=function() return b.kungfu[11+kfkind] end;
	end
	b.kungfu[1].up=function() return b.main[page] end;
	b.kungfu[8].down=function() return b.kungfu[8] end;
	
	b.kungfu[9].up=function() return b.main[page] end;
	b.kungfu[9].down=function() return b.kungfu[21] end;
	b.kungfu[9].left=function() return b.kungfu[11+kfkind] end;
	b.kungfu[9].right=function() return b.kungfu[9] end;
	b.kungfu[10].up=function() return b.kungfu[30] end;
	b.kungfu[10].down=function() return b.kungfu[10] end;
	b.kungfu[10].left=function() return b.kungfu[11+kfkind] end;
	b.kungfu[10].right=function() return b.kungfu[10] end;
	
	for i=11,20 do
		b.kungfu[i].up=function() return b.kungfu[i-1] end;
		b.kungfu[i].down=function() return b.kungfu[i+1] end;
		b.kungfu[i].left=function() return b.kungfu[1] end;
		b.kungfu[i].right=function() return b.kungfu[21] end;
	end
	b.kungfu[11].up=function() return b.main[page] end;
	b.kungfu[20].down=function() return b.kungfu[11] end;
	
	for i=21,30 do
		b.kungfu[i].up=function() return b.kungfu[i-1] end;
		b.kungfu[i].down=function() return b.kungfu[i+1] end;
		b.kungfu[i].left=function() return b.kungfu[11+kfkind] end;
		b.kungfu[i].right=function() return b.kungfu[i] end;
	end
	b.kungfu[21].up=	function()
									if kungfu_start>0 then
										kungfu_start=kungfu_start-1;
										return b.kungfu[21];
									else
										return b.main[page];
									end
								end;
	b.kungfu[30].down=	function()
										local flag;
										kfid=0;
										for i=1,kungfu_start+11 do
											flag=findkf();
										end
										if flag then
											kungfu_start=kungfu_start+1;
											return b.kungfu[30];
										else
											return b.kungfu[21];
										end
									end;
	
	
	
	for i=1,ynum do
		for j=1,xnum do
			if i==1 then
				b.item[xnum*(i-1)+j].up=	function()
															if itemstart==0 then
																return b.main[page];
															else
																itemstart=itemstart-1;
																return b.item[xnum*(i-1)+j];
															end;
														end;
			else
				b.item[xnum*(i-1)+j].up=function() return b.item[xnum*(i-2)+j] end;
			end
			if i==ynum then
				b.item[xnum*(i-1)+j].down=	function()
																if finditem(xnum*ynum+1)>0 then
																	itemstart=itemstart+1;
																end
																return b.item[xnum*(i-1)+j];
															end;
			else
				b.item[xnum*(i-1)+j].down=function() return b.item[xnum*(i)+j] end;
			end
			if j==1 then
				b.item[xnum*(i-1)+j].left=	function() return b.item[101+itemkind] end;
			else
				b.item[xnum*(i-1)+j].left=function() return b.item[xnum*(i-1)+j-1] end;
			end
			if j==ynum then
				b.item[xnum*(i-1)+j].right=function() return b.item[xnum*(i-1)+1] end;
			else
				b.item[xnum*(i-1)+j].right=function() return b.item[xnum*(i-1)+j+1] end;
			end
		end
	end
	for i=101,105 do
		b.item[i].up=function() return b.item[i-1] end;
		b.item[i].down=function() return b.item[i+1] end;
		b.item[i].left=function() return b.item[i] end;
		b.item[i].right=function() return b.item[1] end;
	end
	b.item[101].up=function() return b.main[page] end;
	b.item[105].down=function() return b.item[101] end;
	
	
	for i=1,4 do
		b.sys[i].up=function() return b.sys[i-1] end;
		b.sys[i].down=function() return b.sys[i+1] end;
		b.sys[i].left=function() return b.sys[i] end;
		b.sys[i].right=function() return b.sys[11] end;
	end
	b.sys[1].up=function() return b.main[page] end;
	b.sys[4].down=function() return b.sys[1] end;
	
	for i=11,13 do
		b.sys[i].up=function() return b.sys[i-1] end;
		b.sys[i].down=function() return b.sys[i+1] end;
		b.sys[i].left=function() return b.sys[1] end;
		b.sys[i].right=function() return b.sys[i] end;
	end
	b.sys[11].up=function() return b.main[page] end;
	b.sys[13].down=function() return b.sys[11] end;
	
	
	
	select=b.main[1];
	
	
	
	local surid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	local function show()
		lib.LoadSur(surid,0,0);
		local color,bjcolor;
		--���˵�
		for i=1,4 do
			local m=b.main[i];
			if select==m then
				color=M_Yellow;
				bjcolor=M_DarkOrange;
			else
				color=M_DarkOrange;
				bjcolor=0;
			end
			DrawStrBox(m.x1,m.y1,m.name,color,size,bjcolor);
		end
		--����˵�
		if page<3 then
			DrawStrBox(xy.x1,xy.y1,'�����б�',C_WHITE,size);
			DrawBox(xy.x1,xy.y2,xy.x1+size*4+CC.MenuBorderPixel*2,CC.ScreenH-xy.y1,-1);
			color=M_Yellow;
			bjcolor=M_DarkOrange;
			for i=1,15 do
				local m=b.team[i];
				if type(m)=='nil' then
					break;
				end
				if select==m then
					DrawStrBox_1(m.x1+1,m.y1,m.name,color,size,bjcolor);
				else
					DrawString(m.x1+CC.MenuBorderPixel+1,m.y1+CC.MenuBorderPixel,m.name,color,size);
				end
			end
			DrawBox_1(xy.x1,xy.y2,xy.x1+size*4+CC.MenuBorderPixel*2,CC.ScreenH-xy.y1,C_WHITE);
		end
		--����ҳ��
		if page==1 or page==2 then	--����ͷ��Ѫ��
			DrawBox(xy.x2,xy.y2,xy.x2+size*16+CC.MenuBorderPixel*8+CC.RowPixel*3,CC.ScreenH-xy.y1,C_WHITE);
			local x,y=xy.x2+CC.MenuBorderPixel,xy.y2+CC.MenuBorderPixel;
			local pid=JY.Base["����"..teamid];
			local p=JY.Person[JY.Base["����"..teamid]];
			local headw,headh=lib.PicGetXY(1,p["ͷ�����"]*2);
			y=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel;
			lib.PicLoadCache(1,p["ͷ�����"]*2,x+(160+size*2-headw)/2,y-headh,1);
			y=y-size;
			
			for i=x,x+160+size*2 do
				lib.Background(i,y,i+1,y+size,16+160*math.abs(x+80+size-i)/80);
			end
			
			--DrawString(x,y,string.format("%s��%2d�׼�",fillblank(p["����"],10),p["�ȼ�"]),M_Yellow,size);
			
	local len=math.max(#p["����"]*size/2,#p["���"]*size/3)+size*8/3;
	len=len/2;
	DrawString(x+84+size-len,y-size*2/3,p["���"],C_WHITE,size*2/3);
	DrawString(x+80+size-len,y,p["����"],C_ORANGE,size);
	DrawString(x+80+size+len-size*8/3,y-size*2/3,string.format("%2d",p["�ȼ�"]+4),M_Yellow,size*5/3);
	DrawString(x+80+size+len-size,y,"��",C_WHITE,size);
			
			PUSH(size);
			size=math.max(size,24);
			x=xy.x2+CC.MenuBorderPixel*2+math.max(size*7,size*2+120,150);
			y=xy.y2+CC.MenuBorderPixel+math.max((150-(size+CC.RowPixel)*4)/2,10);
			
			local TT={(p["����"]+smagic(pid,64,1))/100,(p["����"]+smagic(pid,65,1))/100,(p["��Ե"]+smagic(pid,66,1))/100,(p["����"]+smagic(pid,67,1))/100,(p["����"]+smagic(pid,68,1))/100}
			DrawPolygon(5,TT,x+size*8-150,y+CC.FontSMALL,160,C_WHITE)
			
--			local T1={
--							{"����",p["�������ֵ"],502},
--							{"����",p["�������ֵ"],503},
--							{"����",100,504},
--							{"����",CC.Exp[p["�ȼ�"]],502},
--						};
--			for i,v in pairs(T1) do
--				DrawString(x,y,v[1],M_DarkOrange,size);
--				local bf=math.modf(p[v[1]]*160/v[2]);
--				lib.PicLoadCache(2,501*2,x+size*2,y+(size-24)/2,1);
--				lib.SetClip(x+size*2,y,x+size*2+bf,y+size+CC.RowPixel);
--				lib.PicLoadCache(2,v[3]*2,x+size*2,y+(size-24)/2,1);
--				lib.SetClip(0,0,0,0);
--				local numstr=string.format("%d/%d",p[v[1]],v[2]);
--				DrawString(x+size*2+(160-CC.Fontsmall*string.len(numstr)/2)/2,y+(size-16)/2,numstr,C_WHITE,20);
--				y=y+size+CC.RowPixel;
--			end
			
			size=POP();
			if page==1 then
				x=xy.x2+CC.MenuBorderPixel;
				y=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel;
				--[[
				for i,v in pairs({"����","��","����","����"}) do
					DrawString(x,y,v,C_WHITE,size);
					local bf=math.modf(p[v]*120/100);
					lib.PicLoadCache(2,505*2,x+size*2,y+2,1);
					lib.SetClip(x+size*2,y,x+size*2+bf,y+size+CC.RowPixel);
					lib.PicLoadCache(2,506*2,x+size*2,y+2,1);
					lib.SetClip(0,0,0,0);
					y=y+size+CC.RowPixel;
				end]]--
				--y=y+(size+CC.RowPixel)*4;
			local T1={
							{"����",p["�������ֵ"],502},
							{"����",p["�������ֵ"],503},
							{"����",100,504},
							{"����",NextLvExp(p["�ȼ�"]),502},
						};
			for i,v in pairs(T1) do
				DrawString(x,y,v[1],C_WHITE,size);
				local bf=math.modf(p[v[1]]*160/v[2]);
				lib.PicLoadCache(99,501*2,x+size*2,y+(size-24)/2,1);
				lib.SetClip(x+size*2,y,x+size*2+bf,y+size+CC.RowPixel);
				lib.PicLoadCache(99,v[3]*2,x+size*2,y+(size-24)/2,1);
				lib.SetClip(0,0,0,0);
				local numstr=string.format("%d/%d",p[v[1]],v[2]);
				DrawString(x+size*2+(160-CC.Fontsmall*string.len(numstr)/2)/2,y+(size-16)/2,numstr,C_WHITE,20);
				y=y+size+CC.RowPixel;
			end
			
				for i,v in pairs({"����","����","��"}) do
					local data=GetAttrib(JY.CurID,v);
					DrawString(x,y,v,C_WHITE,size);
					DrawString(x+size*2.5,y,data,C_GOLD,size);
					y=y+size+CC.RowPixel;
				end
				
				local T={"","��","��","���","���","����","����","�����","�����","������","������"}
				for i,v in pairs({"ȭ��","����","ˣ��","ǹ��"}) do
					DrawString(x,y,v,C_WHITE,size);
					local bf=math.modf(p[v]/10)+1;
					bf=limitX(bf,1,11);
					local xxstr=T[bf];
					DrawString(x+size*2.5,y,xxstr,C_GOLD,size);
					y=y+size+CC.RowPixel;
				end
				
				x=xy.x2+CC.MenuBorderPixel*2+math.max(size*7,size*2+120,150);
				y=xy.y2+CC.MenuBorderPixel+math.max(160,size*4+CC.RowPixel*3)+CC.Fontbig+CC.RowPixel;
				
				
				PUSH(y);
				for i,v in pairs({"��Ѫ","�ж�","����"}) do
					if p[v]>0 then
						local color;
						if i==1 then
							color=RGB(155+p[v],p[v],p[v]);
						elseif i==2 then
							color=RGB(p[v],155+p[v],p[v]);
						elseif i==3 then
							color=RGB(p[v],p[v],155+p[v]);
						end
						DrawString(x,y,v,color,size);
						y=y+size+CC.RowPixel;
					end
				end
	
				y=POP();
				if p["����"]>=0 then
					lib.PicLoadCache(99,p["����"]*2,x+size*2,y,1);
				end
				if p["����"]>=0 then
					lib.PicLoadCache(99,p["����"]*2,x+size*2+85,y,1);
				end
				y=y+math.max((size+CC.RowPixel)*3,85);
	
				DrawString(x+size*2,y,"����",C_WHITE,size);
				if select==b.status[2] then
					DrawBox(select.x1,select.y1,select.x2,select.y2-1,-1,M_DarkOrange);
				end
				if p["����"]>=0 then
					DrawString(x+size*5,y,JY.Thing[p["����"]]["����"],M_Yellow,size);
				else
					DrawString(x+size*5,y,"��",M_Yellow,size);
				end
				y=y+size+CC.RowPixel;
	
				DrawString(x+size*2,y,"����",C_WHITE,size);
				if select==b.status[3] then
					DrawBox(select.x1,select.y1,select.x2,select.y2-1,-1,M_DarkOrange);
				end
				if p["����"]>=0 then
					DrawString(x+size*5,y,JY.Thing[p["����"]]["����"],M_Yellow,size);
				else
					DrawString(x+size*5,y,"��",M_Yellow,size);
				end
				y=y+size+CC.RowPixel;
				
				
				
				if select==b.status[1] then
					DrawStrBox(b.status[1].x1,b.status[1].y1,'��*��',C_RED,size,M_DarkOrange);
				else
					DrawStrBox(b.status[1].x1,b.status[1].y1,'��*��',C_RED,size);
				end
				--
				
				DrawStrBox(xy.x3,xy.y1,'  װ    ��  ',C_WHITE,size);
				DrawBox(xy.x3,xy.y2,xy.x3+size*6+CC.MenuBorderPixel*2,xy.y2+size*9+CC.MenuBorderPixel*2,-1);
					--DrawString
					--DrawStrBox
				if select==b.status[4] then
					DrawBox(xy.x3,xy.y2,xy.x3+size+2,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE,M_DarkOrange);
				else
					DrawBox_1(xy.x3,xy.y2,xy.x3+size+2,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE);
				end
				if select==b.status[5] then
					DrawBox(xy.x3+(size+1)+1,xy.y2,xy.x3+(size+1)*2+1,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE,M_DarkOrange);
				else
					DrawBox_1(xy.x3+(size+1)+1,xy.y2,xy.x3+(size+1)*2+1,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE);
				end
				if select==b.status[6] then
					DrawBox(xy.x3+(size+1)*2+1,xy.y2,xy.x3+(size+1)*3+1,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE,M_DarkOrange);
				else
					DrawBox_1(xy.x3+(size+1)*2+1,xy.y2,xy.x3+(size+1)*3+1,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE);
				end
				if select==b.status[7] then
					DrawBox(xy.x3+(size+1)*3+1,xy.y2,xy.x3+(size+1)*4+1,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE,M_DarkOrange);
				else
					DrawBox_1(xy.x3+(size+1)*3+1,xy.y2,xy.x3+(size+1)*4+1,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE);
				end
				if select==b.status[8] then
					DrawBox(xy.x3+(size+1)*4+1,xy.y2,xy.x3+(size+1)*5+1,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE,M_DarkOrange);
				else
					DrawBox_1(xy.x3+(size+1)*4+1,xy.y2,xy.x3+(size+1)*5+1,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE);
				end
				if select==b.status[9] then
					DrawBox(xy.x3+(size+1)*5+1,xy.y2,xy.x3+(size+1)*6+2,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE,M_DarkOrange);
				else
					DrawBox_1(xy.x3+(size+1)*5+1,xy.y2,xy.x3+(size+1)*6+2,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE);
				end
				DrawString(xy.x3+2,xy.y2+CC.MenuBorderPixel,'ȫ',C_WHITE,size);
				DrawString(xy.x3+(size+1)+2,xy.y2+CC.MenuBorderPixel,'��',C_WHITE,size);
				DrawString(xy.x3+(size+1)*2+2,xy.y2+CC.MenuBorderPixel,'��',C_WHITE,size);
				DrawString(xy.x3+(size+1)*3+2,xy.y2+CC.MenuBorderPixel,'��',C_WHITE,size);
				DrawString(xy.x3+(size+1)*4+2,xy.y2+CC.MenuBorderPixel,'��',C_WHITE,size);
				DrawString(xy.x3+(size+1)*5+2,xy.y2+CC.MenuBorderPixel,'��',C_WHITE,size);
				DrawBox_1(xy.x3,xy.y2,xy.x3+size*6+CC.MenuBorderPixel*2,xy.y2+size*9+CC.MenuBorderPixel*2,C_WHITE);
			elseif page==2 then
				DrawString(xy.x2+CC.MenuBorderPixel*2,xy.y2+CC.MenuBorderPixel+math.max(150,size*5+CC.RowPixel*4)+CC.RowPixel+size/2,
								'��������',C_WHITE,size);
				DrawString(xy.x2+CC.MenuBorderPixel,xy.y2+CC.MenuBorderPixel+math.max(150,size*5+CC.RowPixel*4)+CC.RowPixel+size/2,
								string.format('%16d',p['��������']),M_Yellow,size);
				DrawString(b.kungfu[1].x1-size*2-CC.MenuBorderPixel,b.kungfu[1].y1,'�书',C_WHITE,size);
				DrawString(b.kungfu[1].x1-size*2-CC.MenuBorderPixel,b.kungfu[6].y1,'�ڹ�',C_WHITE,size);
				DrawString(b.kungfu[1].x1-size*2-CC.MenuBorderPixel,b.kungfu[7].y1,'�Ṧ',C_WHITE,size);
				DrawString(b.kungfu[1].x1-size*2-CC.MenuBorderPixel,b.kungfu[8].y1,'�ؼ�',C_WHITE,size);
				local T={"һ","��","��","��","��","��","��","��","��","ʮ","ʮһ","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","إ"}
				for i=1,8 do
					local m=b.kungfu[i];
					local kfid,kflv,str;
					if i==6 then
						kfid=p["�ڹ�"];
						kflv=1+math.modf(p["�ڹ�����"]/100);
					elseif i==7 then
						kfid=p["�Ṧ"];
						kflv=1+math.modf(p["�Ṧ����"]/100);
					elseif i==8 then
						kfid=p["�ؼ�"];
						kflv=1+math.modf(p["�ؼ�����"]/100);
					else
						kfid=p["�⹦"..i];
						kflv=1+math.modf(p["�⹦����"..i]/100);
					end
					
					if kfid>0 then
						str=JY.Wugong[kfid]["����"];
						DrawString(m.x1,m.y1,str,M_Yellow,size);
						DrawString(m.x1+size*7,m.y1,T[kflv],M_DarkOrange,size);
					end
					if m==select then
						if i<6 then
							kflv=GetLv(JY.CurID,i);
						end
						DrawBox(m.x1,m.y1,m.x2,m.y2,-1,M_DarkOrange);
						if kfid>0 then
							DrawKf(kfid,kflv,true);
						end
					end
				end
				
				DrawStrBox(xy.x3,xy.y1,'  �����书  ',C_WHITE,size);
				--DrawBox(xy.x3,xy.y2,xy.x3+CC.MenuBorderPixel*2+size*6,xy.y2+40+(size+CC.MenuBorderPixel)*10+CC.MenuBorderPixel,-1);
				DrawBox(b.kungfu[11].x1,b.kungfu[11].y1,b.kungfu[30].x2,b.kungfu[30].y2,-1);
				for i=11,20 do
					local m=b.kungfu[i];
					if m==select then
						DrawBox(m.x1,m.y1,m.x2,m.y2,C_WHITE,M_DarkOrange);
					else
						--DrawBox(m.x1,m.y1,m.x2,m.y2,C_WHITE);
					end
					DrawString(m.x1+CC.MenuBorderPixel,m.y1+CC.MenuBorderPixel,m.name,M_Yellow,size-CC.MenuBorderPixel);
				end
				DrawBox_1(b.kungfu[11].x1,b.kungfu[11].y1,b.kungfu[20].x2,b.kungfu[20].y2,C_WHITE);
				kfid=0;
				for i=1,kungfu_start do
					findkf();
				end
				for i=1,10 do
					local m=b.kungfu[20+i];
					if m==select then
						DrawBox(m.x1,m.y1,m.x2,m.y2,-1,M_DarkOrange);
					end
					if findkf(kungfu_start) then
						DrawString(
											m.x1+CC.MenuBorderPixel/2,m.y1+CC.MenuBorderPixel/2,
											JY.Wugong[JY.Person[JY.CurID]["�����书"..kfid]]["����"],
											M_Yellow,size-CC.MenuBorderPixel
										);
						if m==select then
							DrawKf(JY.Person[JY.CurID]["�����书"..kfid],1+math.modf(JY.Person[JY.CurID]["�����书����"..kfid]));
						end
					end
				end
				for i=9,10 do
					local m=b.kungfu[i];
					if m==select then
						DrawBox(m.x1,m.y1,m.x2,m.y2,C_WHITE,M_DarkOrange);
					else
						DrawBox(m.x1,m.y1,m.x2,m.y2,C_WHITE);
					end
					lib.PicLoadCache(99,(499+i)*2,(m.x1+m.x2)/2,m.y1+12);
				end
				--DrawBox_1(xy.x3,xy.y2,xy.x3+CC.MenuBorderPixel*2+size*6,xy.y2+40+(size+CC.MenuBorderPixel)*10+CC.MenuBorderPixel,C_WHITE);
				DrawBox_1(b.kungfu[11].x1,b.kungfu[11].y1,b.kungfu[30].x2,b.kungfu[30].y2,C_WHITE);
				DrawEFT();
			end
			
		elseif page==3 then
		
			DrawBox(xy.x2,xy.y2,xy.x3-CC.MenuBorderPixel,xy.y2+size+CC.MenuBorderPixel*2,C_WHITE);
			
			DrawStrBox(xy.x3,xy.y1,'  ��Ʒ˵��  ',C_WHITE,size);
			DrawBox(xy.x3,xy.y2,xy.x3+size*6+CC.MenuBorderPixel*2,CC.ScreenH-xy.y1,C_WHITE);
			
			DrawBox(xy.x2,xy.y2+size+CC.MenuBorderPixel*2+CC.RowPixel,xy.x3-CC.MenuBorderPixel,CC.ScreenH-xy.y1,-1);
			for i=1,ynum do
				for j=1,xnum do
					local m=b.item[xnum*(i-1)+j];
					if select==m then
						DrawBox(m.x1-XPixel/2,m.y1-YPixel/2,m.x2+XPixel/2,m.y2+YPixel/2,-1,M_DarkOrange);
					end
						--lib.Background(m.x1,m.y1,m.x2,m.y2,128);
						--lib.(m.x1-XPixel,m.y1-YPixel,m.x2+XPixel,m.y2+YPixel,M_DarkOrange,128);
					local tid=finditem(xnum*(i-1)+j);
					if tid>0 then
						local itemid=JY.Base["��Ʒ"..tid];
						lib.PicLoadCache(99,itemid*2,m.x1,m.y1,1);
						if select==m then
							DrawString((xy.x2+xy.x3-CC.MenuBorderPixel)/2-size*string.len(JY.Thing[itemid]["����"])/4,xy.y2+CC.MenuBorderPixel,JY.Thing[itemid]["����"],M_Yellow,size);
							DrawString(xy.x3-CC.MenuBorderPixel-size*4,xy.y2+CC.MenuBorderPixel,string.format("�� %d",JY.Base["��Ʒ����"..tid]),C_WHITE,size);
							DrawStrBox_2(xy.x3,xy.y2,GenTalkString(JY.Thing[itemid]["˵��"],6),M_Yellow,size);
						end
					end
				end
			end
			
			DrawBox_1(xy.x2,xy.y2+size+CC.MenuBorderPixel*2+CC.RowPixel,xy.x3-CC.MenuBorderPixel,CC.ScreenH-xy.y1,C_WHITE);
			
			if useitem>-1 then
				DrawStrBox(xy.x1,xy.y1,'�����б�',C_WHITE,size);
				local menu={};
				for i=1,CC.TeamNum do
					menu[i]={"",nil,0};
					local id=JY.Base["����" .. i];
					if id>=0 then
						menu[i][1]=fillblank(JY.Person[id]["����"],8);
						menu[i][2]=nil;
						menu[i][3]=1;
					end
				end
				local r=ShowMenu(menu,CC.TeamNum,0,xy.x1,xy.y2,xy.x2-CC.MenuBorderPixel,CC.ScreenH-xy.y1,2,1,size,M_DarkOrange,M_Yellow);
				if r>0 then
					USEITEM(JY.Base["����" .. r],useitem);
					--if can use
					--[[
					if JY.Item[useitem].SR(JY.Base["����" .. r]) then
						JY.Item[useitem].onuse(JY.Base["����" .. r]);
						--shiyong xiaoguo
					end
					]]--
				end
				useitem=-1;
			else
				DrawStrBox(xy.x1,xy.y1,'��Ʒ����',C_WHITE,size);
				DrawBox(xy.x1,xy.y2,xy.x1+size*4+CC.MenuBorderPixel*2,CC.ScreenH-xy.y1,-1);
				for i=1,5 do
					local m=b.item[100+i];
					if select==m then
						DrawStrBox_1(m.x1+1,m.y1,m.name,M_Yellow,size,M_DarkOrange);
					else
						DrawString(m.x1+CC.MenuBorderPixel+1,m.y1+CC.MenuBorderPixel,m.name,M_Yellow,size);
					end
				end
				DrawBox_1(xy.x1,xy.y2,xy.x1+size*4+CC.MenuBorderPixel*2,CC.ScreenH-xy.y1,C_WHITE);
			end
			
		elseif page==4 then
			DrawStrBox(xy.x1,xy.y1,'��ȡ����',C_WHITE,size);
			DrawBox(xy.x1,xy.y2,xy.x1+size*4+CC.MenuBorderPixel*2,CC.ScreenH-xy.y1,-1);
			for i=1,4 do
				local m=b.sys[i];
				if select==m then
					DrawStrBox_1(m.x1+1,m.y1,m.name,M_Yellow,size,M_DarkOrange);
				else
					DrawString(m.x1+CC.MenuBorderPixel+1,m.y1+CC.MenuBorderPixel,m.name,M_Yellow,size);
				end
			end
			DrawBox_1(xy.x1,xy.y2,xy.x1+size*4+CC.MenuBorderPixel*2,CC.ScreenH-xy.y1,C_WHITE);
			
			DrawStrBox(xy.x3,xy.y1,'  ϵͳ���  ',C_WHITE,size);
			DrawBox(xy.x3,xy.y2,xy.x3+size*6+CC.MenuBorderPixel*2,CC.ScreenH-xy.y1,-1);
			for i=11,13 do
				local m=b.sys[i];
				if select==m then
					DrawStrBox_1(m.x1+1,m.y1,m.name,M_Yellow,size,M_DarkOrange);
				else
					DrawString(m.x1+CC.MenuBorderPixel+1,m.y1+CC.MenuBorderPixel,m.name,M_Yellow,size);
				end
			end
			DrawBox_1(xy.x3,xy.y2,xy.x3+size*6+CC.MenuBorderPixel*2,CC.ScreenH-xy.y1,C_WHITE);
			
			DrawBox(xy.x2,xy.y2,xy.x3-CC.MenuBorderPixel,CC.ScreenH-xy.y1,C_WHITE);
			for i=1,4 do
				local m=b.sys[i];
				if select==m then
					Menu_Sys_SL_Show(i,xy.x2,xy.y2,xy.x3-CC.MenuBorderPixel,CC.ScreenH-xy.y1);
					break;
				end
			end
			if select==b.sys[11] then
				DrawStrBox_2(xy.x2,xy.y2,'������ ��ˮ������*������ ��novel*�׶԰� ����������*�׾籾 ����C��*���� ��������*���²� ��xzqcm111*�״��� ��tsmdsyp*�׽ű� ��jy027*******�ر��л���������ƵĽ���*�����ز�����СС��ġ���ӹˮ䰴���*�ش˸�л���в���������Ա',C_WHITE,size)
			elseif select==b.sys[12] then
				DrawStrBox_2(xy.x2,xy.y2,'ϵͳ����*�������������ֱ��ʡ�������*�밴ȷ�ϼ����������ô���',C_WHITE,size)
			elseif select==b.sys[13] then
				DrawStrBox_2(xy.x2,xy.y2,'�뿪��Ϸ*����ȷ���Ƿ��Ѿ��浵*��ȷ�ϼ���������',C_WHITE,size)
			end
		end
	end
	
	
	
	
	local returnvaule;
	while true do
		show();
		ShowScreen();
		lib.Delay(20);
		local event,key,mx,my=getkey();
		if event==1 then
			if key==VK_UP then
				select=select.up();
			elseif key==VK_DOWN then
				select=select.down();
			elseif key==VK_LEFT then
				select=select.left();
			elseif key==VK_RIGHT then
				select=select.right();
			elseif key==VK_SPACE or key==VK_RETURN then
				returnvaule=select.click();
			elseif key==282 then
				if select.F1~=nil then
					select.F1();
				end
			elseif key==VK_ESCAPE then
				break;
			end
			select.on();
		elseif event==2 or event==3 then
			local flag=false;
			for i,v in pairs(b.main) do
				if between(mx,v.x1,v.x2) and between(my,v.y1,v.y2) then
					select=v;
					flag=true;
					break;
				end
			end
			if page==1 then
				for i,v in pairs(b.team) do
					if between(mx,v.x1,v.x2) and between(my,v.y1,v.y2) then
						select=v;
						flag=true;
						break;
					end
				end
				for i,v in pairs(b.status) do
					if between(mx,v.x1,v.x2) and between(my,v.y1,v.y2) then
						select=v;
						flag=true;
						break;
					end
				end
			elseif page==2 then
				for i,v in pairs(b.team) do
					if between(mx,v.x1,v.x2) and between(my,v.y1,v.y2) then
						select=v;
						flag=true;
						break;
					end
				end
				for i,v in pairs(b.kungfu) do
					if between(mx,v.x1,v.x2) and between(my,v.y1,v.y2) then
						select=v;
						flag=true;
						break;
					end
				end
			elseif page==3 then
				for i,v in pairs(b.item) do
					if between(mx,v.x1,v.x2) and between(my,v.y1,v.y2) then
						select=v;
						flag=true;
						break;
					end
				end
			elseif page==4 then
				for i,v in pairs(b.sys) do
					if between(mx,v.x1,v.x2) and between(my,v.y1,v.y2) then
						select=v;
						flag=true;
						break;
					end
				end
			end
			if event==3 and flag then
				returnvaule=select.click();
			end
			select.on();
		end
		if type(returnvaule)=='number' then
			if returnvaule==0 then
				break;
			end
		end
	end
	lib.FreeSur(surid);
	-----------
	if true then
		return
	end
	CleanMemory();
	--[[
	if JY.Status==GAME_SMAP then
		lib.PicInit();
		lib.PicLoadFile(CC.SMAPPicFile[1],CC.SMAPPicFile[2],0);
		lib.PicLoadFile(CC.HeadPicFile[1],CC.HeadPicFile[2],1);
		if CC.LoadThingPic==1 then
			lib.PicLoadFile(CC.ThingPicFile[1],CC.ThingPicFile[2],2);
		end
	elseif JY.Status==GAME_MMAP then
		lib.PicInit();
		lib.PicLoadFile(CC.MMAPPicFile[1],CC.MMAPPicFile[2],0);
		lib.PicLoadFile(CC.HeadPicFile[1],CC.HeadPicFile[2],1);
		if CC.LoadThingPic==1 then
			lib.PicLoadFile(CC.ThingPicFile[1],CC.ThingPicFile[2],2);
		end
	end
	]]--
end

function GetAttrib(pid,v)
	local flag=false;
	local n=0
	for i,v in pairs({"����","����","��"}) do
		flag=true;
		n=i;
		break;
	end
	local p=JY.Person[pid];
	if flag then
		local data=p[v];
		for mi,mv in pairs({"�ڹ�","�Ṧ","�ؼ�"}) do
			local mkfid,mkfexp=p[mv],p[mv..'����'];
			if mkfid>0 then
				data=data+JY.Wugong[mkfid][v]*(1+div100(mkfexp));
			end
		end
		for ni=1,5 do
			local nid,nexp=p["�⹦"..ni],p["�⹦����"..ni];
			if nid>0 then
				data=data+JY.Wugong[nid][v]*(1+div100(nexp));
			end
		end
		data=math.modf(data*140/(175-p[v]))-3;
		data=data+smagic(pid,68+n,1);
		data=math.modf(data*(100+smagic(pid,71+n,1))/100)
		return data;
	else
		return p[v];
	end
end
function DrawPolygon(num,T,sx,sy,len,color)
	local cx,cy;
	local length;
	local angle;
	local p={};
	local pp={}
	local Sur={}
	if num<3 then
		return;
	end
	sx=math.modf(sx);
	sy=math.modf(sy);
	len=math.modf(len);
	length=math.modf(len/2-2);
	cx=sx+length;
	cy=sy+length;
	angle=math.pi*2/num;
	--ȷ��������
	for i=1,num do
		p[i]={
					x=cx+length*limitX(T[i]+0.1,0,1)*math.cos(angle*(i-1)-math.pi/2),
					y=cy+length*limitX(T[i]+0.1,0,1)*math.sin(angle*(i-1)-math.pi/2),
				};
	end
	p[num+1]=p[1];
	for i=1,num do
		pp[i]={
					x=cx+length*math.cos(angle*(i-1)-math.pi/2),
					y=cy+length*math.sin(angle*(i-1)-math.pi/2),
				};
	end
	pp[num+1]=pp[1];
	--��Χ
	for i=1,num do
		--lib.DrawLine(pp[i].x-1,pp[i].y,pp[i+1].x-1,pp[i+1].y,M_Gray);
		--lib.DrawLine(pp[i].x,pp[i].y-1,pp[i+1].x,pp[i+1].y-1,M_Gray);
		--lib.DrawLine(pp[i].x+1,pp[i].y,pp[i+1].x+1,pp[i+1].y,M_Gray);
		--lib.DrawLine(pp[i].x,pp[i].y+1,pp[i+1].x,pp[i+1].y+1,M_Gray);
		DrawLine(pp[i].x,pp[i].y,pp[i+1].x,pp[i+1].y,C_WHITE);
	end
	--��׼��
	for i=1,num do
		--lib.DrawLine(cx-1,cy,pp[i].x-1,pp[i].y,M_Gray);
		--lib.DrawLine(cx,cy-1,pp[i].x,pp[i].y-1,M_Gray);
		--lib.DrawLine(cx+1,cy,pp[i].x+1,pp[i].y,M_Gray);
		--lib.DrawLine(cx,cy+1,pp[i].x,pp[i].y+1,M_Gray);
		DrawLine(cx,cy,pp[i].x,pp[i].y,C_WHITE);
	end
	--�ڲ�
	for i=1,num do
		--lib.DrawLine(p[i].x-1,p[i].y,p[i+1].x-1,p[i+1].y,M_DarkOrange);
		--lib.DrawLine(p[i].x,p[i].y-1,p[i+1].x,p[i+1].y-1,M_DarkOrange);
		--lib.DrawLine(p[i].x+1,p[i].y,p[i+1].x+1,p[i+1].y,M_DarkOrange);
		--lib.DrawLine(p[i].x,p[i].y+1,p[i+1].x,p[i+1].y+1,M_DarkOrange);
		DrawLine(p[i].x,p[i].y,p[i+1].x,p[i+1].y,M_Yellow);
	end
	--��������
	--[[
	for i=1,num do
		DrawString(p[i].x,p[i].y,TN[i],C_WHITE,CC.Fontbig)
	end
	]]--
	local fsize=CC.FontSmall
	DrawString(pp[1].x-fsize,pp[1].y-fsize,'����',C_WHITE,fsize);
	DrawString(pp[2].x,pp[2].y-fsize,'��',C_WHITE,fsize);
	DrawString(pp[2].x,pp[2].y,'��',C_WHITE,fsize);
	DrawString(pp[3].x-fsize,pp[3].y,'��Ե',C_WHITE,fsize);
	DrawString(pp[4].x-fsize,pp[4].y,'����',C_WHITE,fsize);
	DrawString(pp[5].x-fsize,pp[5].y-fsize,'��',C_WHITE,fsize);
	DrawString(pp[5].x-fsize,pp[5].y,'��',C_WHITE,fsize);
end

function LearnKF(pid,teacher,kflist)
	local size=math.min(
										(math.modf((CC.ScreenW*1-CC.MenuBorderPixel*12-CC.RowPixel*5)/26)),						--����Ļ�����
										math.min(																													--����Ļ�߼���
															(math.modf((CC.ScreenH-20-CC.FontBig-320-CC.MenuBorderPixel*5)/2)),		--�ֺŽϴ�ʱ								--����Ļ�߼���
															(math.modf((CC.ScreenH-20-CC.FontBig-160-CC.MenuBorderPixel*5)/9)),		--�ֺŽϴ�ʱ
															(math.modf((CC.ScreenH-20-CC.FontBig-CC.MenuBorderPixel*5)/14))	--�ֺŽ�Сʱ
														)-CC.RowPixel
									);
	--size=32
	local xy={};
	xy.x1=(CC.ScreenW-size*24-CC.MenuBorderPixel*12-CC.RowPixel*3)/2;
	xy.x2=xy.x1+CC.MenuBorderPixel*3+CC.RowPixel+size*7+1;
	xy.x3=xy.x2+CC.MenuBorderPixel*4+CC.RowPixel+size*10;
	xy.y1=(CC.ScreenH-CC.MenuBorderPixel*5-math.max((size+CC.RowPixel)*9,160+(size+CC.RowPixel)*2)-math.max(160,(size+CC.RowPixel)*5))/2;
	xy.y2=xy.y1+CC.MenuBorderPixel*4+math.max(160,(size+CC.RowPixel)*5);
	--lib.Debug(size..'|'..xy.x1..','..xy.y1)
	local strnum=math.modf((xy.x3-xy.x1-CC.MenuBorderPixel*2)/size)-1;
	local r;
			local p=JY.Person[pid];
			local len=string.len(p["����"])/2;
	local T={"һ","��","��","��","��","��","��","��","��","ʮ"}
				local TS={"","��","��","���","���","����","����","�����","�����","������","������"}
	local function DrawKfString(showid)
		local kfid,kflv;
		kfid=kflist[showid][1];
		kflv=0;
		for i=1,80 do
			if p["�����书"..i]==kfid then
				kflv=1+math.modf(p["�����书����"..i]/100);
			end
		end
		DrawStrBox_2(xy.x2+CC.MenuBorderPixel,xy.y2+CC.MenuBorderPixel,GenTalkString(JY.Kungfu[kfid]["˵��"],10),C_WHITE,size);
		if kflv>0 then
			DrawString(xy.x2+CC.MenuBorderPixel,CC.ScreenH-xy.y1-size*0.7-CC.MenuBorderPixel,string.format("��ǰ��ϰ�ô��书:%s��",T[kflv]),C_WHITE,size*0.7);
		else
			DrawString(xy.x2+CC.MenuBorderPixel,CC.ScreenH-xy.y1-size*0.7-CC.MenuBorderPixel,"��ǰδϰ�ô��书",C_WHITE,size*0.7);
		end
	end
	local kfmenu={};
	local listnum=0;
	for i,v in pairs(kflist) do
		v[3]=v[3] or 0;
		kfmenu[i]={fillblank(JY.Wugong[kflist[i][1]]["����"],15),DrawKfString,1};
		listnum=listnum+1
	end
	JY.Menu_keep=true;
	while true do
	Cls();
	DrawBoxTitle(CC.ScreenW-xy.x1*2,CC.ScreenH-xy.y1*2,"�����书",C_GOLD)
			local x,y=xy.x1+CC.MenuBorderPixel,xy.y1+CC.MenuBorderPixel;
			local headw,headh=lib.PicGetXY(1,JY.Person[teacher]["ͷ�����"]*2);
			local headx=(160+size-headw)/2;
			local heady=(xy.y2-xy.y1-headh)/2;
			lib.PicLoadCache(1,JY.Person[teacher]["ͷ�����"]*2,x+headx,y+heady,1);
			
			local str=CC.Teacher[teacher] or "";
			DrawStrBox_2(x+160+size,y+size,"��"..JY.Person[teacher]["����"].."*"..GenTalkString(str,strnum) ,C_WHITE,size)
	
	DrawBox(xy.x1,xy.y2,xy.x2+1,CC.ScreenH-xy.y1,C_GOLD,-1)
	DrawBox(xy.x2,xy.y2,xy.x3+1,CC.ScreenH-xy.y1-size*0.7-CC.MenuBorderPixel*2,C_GOLD,-1)
	DrawBox(xy.x2,CC.ScreenH-xy.y1-size*0.7-CC.MenuBorderPixel*2-1,xy.x3+1,CC.ScreenH-xy.y1,C_GOLD,-1)
	DrawBox(xy.x3,xy.y2,CC.ScreenW-xy.x1,CC.ScreenH-xy.y1,C_GOLD,-1)
			x,y=xy.x3+CC.MenuBorderPixel,xy.y2+CC.MenuBorderPixel;
			headw,headh=lib.PicGetXY(1,p["ͷ�����"]*2);
			headx=(math.max(150,size*2+120)-headw)/2;
			heady=(150-headh)/2;
			lib.PicLoadCache(1,p["ͷ�����"]*2,x+headx,y+heady,17);
			for i=headx+x,headx+x+headw do
				lib.Background(i,y+heady+headh-size,i+1,y+heady+headh,64+128*math.abs(x+headx+headw/2-i)/75);
			end
			y=y+heady+headh-size;
			x=x+((CC.ScreenW-xy.x1-CC.MenuBorderPixel-xy.x3)-size*(len+3))/2;
			DrawString(x,y,p["����"],M_Yellow,size);
			DrawString(x+size*(len+1),y,string.format("%2d",p["�ȼ�"]+4),M_Yellow,size);
			DrawString(x+size*(len+2),y,"��",M_DarkOrange,size);

				x=xy.x3+CC.MenuBorderPixel;
			
				y=xy.y2+CC.MenuBorderPixel+math.max(150,size*4+CC.RowPixel*3)+CC.RowPixel;
				
				DrawString(x,y,'����:',C_WHITE,size);
				DrawString(x,y,string.format('%14d',p['����']),M_Yellow,size);
				y=y+size+CC.RowPixel;
				DrawString(x,y,'��������:',C_WHITE,size);
				DrawString(x,y,string.format('%14d',p['��������']),M_Yellow,size);
				y=y+size+CC.RowPixel;
				--[[				
				for i,v in pairs({"ȭ��","����","ˣ��","ǹ��"}) do
					DrawString(x,y,v..':',C_WHITE,size);
					local bf=math.modf(p[v]/10)+1;
					bf=limitX(bf,1,11);
					local xxstr=TS[bf];
					DrawString(x+size*2.5,y,xxstr,C_GOLD,size);
					y=y+size+CC.RowPixel;
				end]]--
		r=ShowMenu(kfmenu,listnum,9,xy.x1,xy.y2,0,0,0,1,size,C_ORANGE,C_WHITE,1)
		if r==0 then
			break;
		else
			local kfid,kflv,nowEXP;
			local baseEXP,needEXP;
			local EXPperPoint,needPoint;
			local kfexp=0;
			local kfnum;
			kfid=kflist[r][1];
			kflv,nowEXP=0,0;
			for i=1,80 do
				if p["�����书"..i]==kfid then
					kfnum=i;
					kfexp=p["�����书����"..i]+100;
					kflv,nowEXP=math.modf(p["�����书����"..i]/100);
					kflv=kflv+1;
				end
			end
			local canLearn,reason;
			if kflv>0 then
				canLearn=true;
			else
				canLearn,reason=IfCanLearn(pid,kfid);
			end
			
			if pid==0 and p["���"]+9999<kflist[r][3] then
				--if p["���"]<kflist[r][3] then
					local button={"ȷ��"}
					JYMsgBox("�޷�����","������ݲ���*",button,1,JY.Person[teacher]["ͷ�����"]);
				--end
			elseif not canLearn then
				local button={"ȷ��"}
				JYMsgBox("�޷�����",reason,button,1,JY.Person[teacher]["ͷ�����"]);
			elseif kflv>=kflist[r][2] then
				local button={"ȷ��"}
				JYMsgBox("�޷�����",string.format("���%s�ѵ���˾���*û��ʲô����ָ������*",JY.Wugong[kfid]["����"]),
								button,1,JY.Person[teacher]["ͷ�����"]);
			else
			--[[
				baseEXP=1+JY.Wugong[kfid]["��������"]/100;
				needEXP=50*baseEXP*1.4^(kflv+1)*(1-nowEXP);
				EXPperPoint=2*0.5^JY.Wugong[kfid]["�Ƚ�"]+(p["����"]/100)^3;
				needPoint=1+math.modf(needEXP/EXPperPoint);
				]]--
				needPoint=GetSkillPoint(kfid,kfexp,pid);
				--if p["��������"]<needPoint then
				if p["��������"]+p["����"]<needPoint then
					local button={"ȷ��"}
					JYMsgBox("�޷�����",string.format("������������*%s��%s����Ҫ%d��",JY.Wugong[kfid]["����"],T[kflv+1],needPoint),
									button,1,JY.Person[teacher]["ͷ�����"]);
				else
					local xlstr;
					if p["��������"]<needPoint then
						xlstr=string.format("����%s��%s��*������%d����������*��ǰ������������*ǿ���������������ﾭ��*�Ƿ������",JY.Wugong[kfid]["����"],T[kflv+1],needPoint);
					else
						xlstr=string.format("����%s��%s��*������%d����������*�Ƿ������",JY.Wugong[kfid]["����"],T[kflv+1],needPoint);
					end
					local button={"ȷ��","ȡ��"}
					if JYMsgBox("�Ƿ����",xlstr,button,2,JY.Person[teacher]["ͷ�����"])==1 then
						p["��������"]=p["��������"]-needPoint;
						if p["��������"]<0 then
							p["����"]=p["����"]+p["��������"];
							p["��������"]=0;
						end
						if kflv==0 then
							for i=1,80 do
								if p["�����书"..i]==0 then
									p["�����书"..i]=kfid;
									p["�����书����"..i]=0;
									
									if between(JY.Wugong[kfid]["�书����"],1,6) then
										for j=1,5 do
											if p["�⹦"..j]==0 then
												p["�⹦"..j]=kfid;
												p["�⹦����"..j]=0;
												break;
											end
										end
									elseif JY.Wugong[kfid]["�书����"]==7 then
										if p["�ڹ�"]==0 then
											p["�ڹ�"]=kfid;
											p["�ڹ�����"]=0;
										end
									elseif JY.Wugong[kfid]["�书����"]==8 then
										if p["�Ṧ"]==0 then
											p["�Ṧ"]=kfid;
											p["�Ṧ����"]=0;
										end
									elseif JY.Wugong[kfid]["�书����"]==9 then
										if p["�ؼ�"]==0 then
											p["�ؼ�"]=kfid;
											p["�ؼ�����"]=0;
										end
									end
									break;
								end
							end
						else
							p["�����书����"..kfnum]=100*kflv;
							for i,v in pairs({"�⹦1","�⹦2","�⹦3","�⹦4","�⹦5","�ڹ�","�Ṧ","�ؼ�"}) do
								if p[v]==kfid then
									if i<6 then
										p["�⹦����"..i]=p["�����书����"..kfnum];
									else
										p[v.."����"]=p["�����书����"..kfnum];
									end
									break;
								end
							end
						end
						ResetPersonAttrib(pid);
					end
				end
			end
		end
	end
	JY.Menu_keep=false;
	JY.Menu_start=1;
	JY.Menu_current=1;
	Cls();
end

function GetSkillPoint(kfid,kfexp,pid)
	local kflv,nowEXP;
	kflv,nowEXP=math.modf(kfexp/100);
	local baseEXP=1+JY.Wugong[kfid]["��������"]/80;
	local needEXP=50*baseEXP*(1.1+JY.Wugong[kfid]["��������"]/200)^(kflv+1)*(1-nowEXP);
	local EXPperPoint=2*0.6^JY.Wugong[kfid]["�Ƚ�"]+(JY.Person[pid]["����"]/120)^math.max(3,JY.Wugong[kfid]["�Ƚ�"]);
	local needPoint=1+math.modf(needEXP/EXPperPoint);
	return needPoint;
end
function IfCanLearn(pid,kfid)
	local p=JY.Person[pid];
	local wg=JY.Wugong[kfid];
	local tj=JY.Kungfu[kfid]["��������"];
	local qz=JY.Kungfu[kfid]["ǰ���书"];
	for i=1,tj[0] do
		if tj[i][2]>0 then
			if p[tj[i][1]]<tj[i][2] then
				return false,tj[i][1].."����";
			end
		else
			if p[tj[i][1]]>-tj[i][2] then
				return false,tj[i][1].."����";
			end
		end
	end
	if p["����"]==wg["����"] then
		for i=1,qz[0] do
			local notLearn=true;
			for j=1,CC.MaxKungfuNum do
				if p["�����书"..j]==qz[i][1] then
					local lv=1+math.modf(p["�����书����"..j]/100);
					if qz[i][2]>0 then
						if lv<qz[i][2] then
							return false,JY.Wugong[qz[i][1]]["����"].."�ȼ�����";
						else
							notLearn=false;
							break;
						end
					else
						if lv>-qz[i][2] then
							return false,JY.Wugong[qz[i][1]]["����"].."�ȼ�����";
						else
							notLearn=false;
							break;
						end
					end
				end
			end
			if notLearn and qz[i][2]>0 then
				return false,JY.Wugong[qz[i][1]]["����"].."�ȼ�����";
			end
		end
	end
	if p["����"]~=wg["����"] then
		for i,v in pairs({"����","����","ȭ��","����","ˣ��","ǹ��"}) do
			if p[v]<wg['��'..v]+math.max(100,wg['��'..v])*0.1 then
				return false,v.."����";
			end
		end
	end
	if p["����"]==wg["����"] then
		for i=1,3 do
			if wg["���书�ȼ�"..i]>Getkflv(pid,wg["���书"..i]) then
				return false,JY.Wugong[wg["���书"..i]]["����"].."�ȼ�����";
			end
		end
	end
	return true;
end

function ShowSmagic(kfid,kflv)
	Cls();
	local p=JY.Kungfu[kfid]["����Ч��"]
	local kfstr,strnum=GenTalkString(JY.Kungfu[kfid]["˵��"],13);
	local num=0;--=p[0];
	local flag_a=false;
	local flag_b=false;
	local flag_c=false;
	for i=1,p[0] do
		if (p[i][2]>=0 and kflv>=p[i][2]) or (p[i][2]<0 and kflv<-p[i][2]) then
			num=num+1;
			if p[i][1]<=40 then
				flag_a=true;
			elseif p[i][1]>100 then
				flag_c=true;
			else
				flag_b=true;
			end
		end
	end
	if flag_a then
		num=num+1;
	end
	if flag_b then
		num=num+1;
	end
	if flag_c then
		num=num+1;
	end
	DrawBoxTitle(CC.Fontbig*18,(CC.Fontbig+CC.RowPixel)*(num+strnum+1)+CC.FontBig/2,JY.Wugong[kfid]["����"],C_GOLD)
	local x=(CC.ScreenW-CC.Fontbig*18)/2;
	local y=(CC.ScreenH-((CC.Fontbig+CC.RowPixel)*(num+strnum+1)+CC.FontBig/2))/2+CC.FontBig/2+CC.RowPixel;
	DrawStrBox_2(x+CC.Fontbig*2,y,kfstr,C_WHITE,CC.Fontbig);
	y=y+(CC.Fontbig+CC.RowPixel)*(strnum)+CC.FontBig/3;
	local function GenStr(i)
		local str="";
		local cp,cq;
		if type(p[i][4])=="function" then
			cp=p[i][4](JY.Person[JY.CurID],kflv);
		else
			cp=p[i][4];
		end
		if type(p[i][3])=="function" then
			cq=p[i][3](JY.Person[JY.CurID],kflv);
		else
			cq=p[i][3];
		end
		if p[i][1]==1 then
			str=string.format("�����˺�%+d",cp);
		elseif p[i][1]==2 then
			str=string.format("�����˺�%+d��",cp);
		elseif p[i][1]==3 then
			str=string.format("����%d������",cp);
		elseif p[i][1]==4 then
			str=string.format("��ȥ����%d",cp);
		elseif p[i][1]==5 then
			str=string.format("��ȡ����%d",cp);
		elseif p[i][1]==6 then
			str=string.format("��ȡ����%d",cp);
		elseif p[i][1]==7 then
			str=string.format("���˼���%d",cp);
		elseif p[i][1]==8 then
			str=string.format("ɱ������%d",cp);
		elseif p[i][1]==9 then
			str=string.format("%d",cp);
		elseif p[i][1]==10 then
			str=string.format("%d���˺����˼���",cp);
		elseif p[i][1]==11 then
			str=string.format("��������%+d��",cp);
		elseif p[i][1]==12 then
			str=string.format("�ط���Ч������%+d��",-cp);
		elseif p[i][1]==13 then
			str=string.format("%d���˺�����",cp);
		elseif p[i][1]==14 then
			str=string.format("�����˺���Χ",cp);
		elseif p[i][1]==15 then
			str=string.format("�ڹ��س���ʽ",cp);
		elseif p[i][1]==16 then
			str=string.format("������%+d",cp);
		elseif p[i][1]==17 then
			str=string.format("������%+d��",cp);
		elseif p[i][1]==21 then
			str=string.format("�����˺�%+d",-cp);
		elseif p[i][1]==22 then
			str=string.format("�����˺�%+d��",-cp);
		elseif p[i][1]==23 then
			str=string.format("������Ч��Ч",cp);
		elseif p[i][1]==24 then
			str=string.format("����",cp);
		elseif p[i][1]==25 then
			str=string.format("����%d���˺�",cp);
		elseif p[i][1]==26 then
			str=string.format("����%d�˺�",cp);
		elseif p[i][1]==27 then
			str=string.format("����",cp);
		elseif p[i][1]==28 then
			str=string.format("�����˺�%d������",cp);
		elseif p[i][1]==29 then
			str=string.format("������%+d",cp);
		elseif p[i][1]==30 then
			str=string.format("������%+d��",cp);
		elseif p[i][1]==31 then
			str=string.format("�߻���ħ��ȫ����%+d��",cp);
		elseif p[i][1]==41 then
			str=string.format("�ƶ�����%+d",cp);
		elseif p[i][1]==42 then
			str=string.format("��ʼ����%+d",cp);
		elseif p[i][1]==43 then
			str=string.format("�����ٶ�%+d",cp);
		elseif p[i][1]==44 then
			str=string.format("%d",cp);
		elseif p[i][1]==45 then
			str=string.format("%d",cp);
		elseif p[i][1]==46 then
			str=string.format("ǿ���ƶ�",cp);
		elseif p[i][1]==47 then
			str=string.format("˲���ƶ�",cp);
		elseif p[i][1]==48 then
			str=string.format("ˮ���ƶ�",cp);
		elseif p[i][1]==49 then
			str=string.format("���߼���",cp);
		elseif p[i][1]==50 then
			str=string.format("%d",cp);
		elseif p[i][1]==57 then
			str=string.format("��Ч������%+d",cp);
		elseif p[i][1]==58 then
			str=string.format("��ȡ����%+d��",cp);
		elseif p[i][1]==61 then
			str=string.format("��������%+d",cp);
		elseif p[i][1]==62 then
			str=string.format("��������%+d",cp);
		elseif p[i][1]==63 then
			str=string.format("��������%+d��",cp);
		elseif p[i][1]==64 then
			str=string.format("����%+d",cp);
		elseif p[i][1]==65 then
			str=string.format("����%+d",cp);
		elseif p[i][1]==66 then
			str=string.format("����%+d",cp);
		elseif p[i][1]==67 then
			str=string.format("����%+d",cp);
		elseif p[i][1]==68 then
			str=string.format("��Ե%+d",cp);
		elseif p[i][1]==69 then
			str=string.format("����%+d",cp);
		elseif p[i][1]==70 then
			str=string.format("����%+d",cp);
		elseif p[i][1]==71 then
			str=string.format("��%+d",cp);
		elseif p[i][1]==72 then
			str=string.format("����%+d��",cp);
		elseif p[i][1]==73 then
			str=string.format("����%+d��",cp);
		elseif p[i][1]==74 then
			str=string.format("��%+d��",cp);
		elseif p[i][1]==75 then
			str=string.format("%d",cp);
		elseif p[i][1]==76 then
			str=string.format("%d",cp);
		elseif p[i][1]==77 then
			str=string.format("%d",cp);
		elseif p[i][1]==78 then
			str=string.format("%d",cp);
		elseif p[i][1]==81 then
			str=string.format("%d���ڵз�����%+d��",cq,-cp);
		elseif p[i][1]==82 then
			str=string.format("%d���ڵз�����%+d��",cq,-cp);
		elseif p[i][1]==83 then
			str=string.format("%d���ڵз���%+d��",cq,-cp);
		elseif p[i][1]==91 then
			str=string.format("%d���ڼ�������%+d��",cq,cp);
		elseif p[i][1]==92 then
			str=string.format("%d���ڼ�������%+d��",cq,cp);
		elseif p[i][1]==93 then
			str=string.format("%d���ڼ�����%+d��",cq,cp);
		else
			str="����Ч��"
		end
		return str;
	end
		--[[
		local str={
							[1]="����˺�",
							[2]="��ǿ�˺�",
							[3]="���Ӳ��ַ���",
							[4]="��ȥ����",
							[5]="��ȡ����",
							[6]="��ȡ����",
							[7]="���˼���",
							[8]="ɱ������",
							[9]="�������ӣ�",
							[10]="������",
							[21]="���������˺�",
							[22]="���������˺�",
							[23]="���ӹ�����Ч",
							[24]="����",
							[25]="�����˺�",
							[26]="�����˺�",
							[27]="һ����������",
							[41]="�ƶ���������",
							[42]="��ʼ��������",
							[43]="�����ٶ�����",
							[46]="ǿ���ƶ�",
							[47]="˲���ƶ�",
							[48]="ˮ���ƶ�",
							[49]="���߼���",
							[50]="δ������Ч",
							[61]="�����������",
							[62]="�����������",
							[63]="��ǿ��������",
							[64]="��ǿ��������",
							[70]="���ߣ�",
						}
		local str2={
							[1]="�ж�",
							[2]="����",
							[3]="��Ѫ",
							[11]="����",
							[12]="��Ѩ",
							[13]="����",
							[14]="���",
						}
		]]--
		x=x+CC.MenuBorderPixel+CC.Fontbig/2;
		if flag_a then
			for i=0,CC.Fontbig/2-1 do
				lib.Background(CC.ScreenW/2-CC.Fontbig*8-i,y+CC.Fontbig/2+i,CC.ScreenW/2+CC.Fontbig*8+i,y+CC.Fontbig,240,C_WHITE);
			end
			--lib.Background(x+CC.Fontbig*4,y+CC.Fontbig/2,x+CC.Fontbig*16,y+CC.Fontbig/2+8,128,C_WHITE);
			DrawString(x+CC.Fontbig*2,y,"�书��ʽ",M_Yellow,CC.Fontbig);
			y=y+CC.Fontbig+CC.RowPixel;
		end
		for i=1,p[0] do
			if p[i][1]<=40 then
				--DrawString(x,y,p[i][5],C_ORANGE,CC.Fontbig);
				local cv;
				if type(p[i][3])=="function" then
					cv=p[i][3](JY.Person[JY.CurID],kflv);
				else
					cv=p[i][3];
				end
				
				if (p[i][2]>=0 and kflv>=p[i][2]) or (p[i][2]<0 and kflv<-p[i][2]) then
					--if cv>0 then
						--DrawString(x,y,p[i][5],M_Gray,CC.Fontbig);
					--end
					--DrawString(x+CC.Fontbig*7.5,y,"δ���",M_Gray,CC.Fontbig);
				--else
					if cv>0 then
						DrawString(x,y,p[i][5],C_ORANGE,CC.Fontbig);
					end
					DrawString(x+CC.Fontbig*7.5,y,GenStr(i),C_WHITE,CC.Fontbig);
					y=y+CC.Fontbig+CC.RowPixel;
				end
			end
		end
		if flag_b then
			for i=0,CC.Fontbig/2-1 do
				lib.Background(CC.ScreenW/2-CC.Fontbig*8-i,y+CC.Fontbig/2+i,CC.ScreenW/2+CC.Fontbig*8+i,y+CC.Fontbig,240,C_WHITE);
			end
			DrawString(x+CC.Fontbig*2,y,"����Ч��",M_Yellow,CC.Fontbig);
			y=y+CC.Fontbig+CC.RowPixel;
		end
		--local nn=0;
		local T={"һ","��","��","��","��","��","��","��","��","ʮ",}
		for i=1,p[0] do
			if p[i][1]>40 and p[i][1]<=100 then
				--nn=nn+1;
				
				if (p[i][2]>=0 and kflv>=p[i][2]) or (p[i][2]<0 and kflv<-p[i][2]) then
					--DrawString(x,y,"����Ч��"..T[nn],M_Gray,CC.Fontbig);
					--DrawString(x+CC.Fontbig*7.5,y,"δ���",M_Gray,CC.Fontbig);
				--else
					--DrawString(x,y,"����Ч��"..T[nn],C_ORANGE,CC.Fontbig);
					if p[i][5]~="" then
						DrawString(x,y,p[i][5],C_ORANGE,CC.Fontbig);
						DrawString(x+CC.Fontbig*7.5,y,GenStr(i),C_WHITE,CC.Fontbig);--
					else
						DrawString(x,y,GenStr(i),C_ORANGE,CC.Fontbig);--+CC.Fontbig*7.5
					end
					y=y+CC.Fontbig+CC.RowPixel;
				end
			end
		end
		if flag_c then
			for i=0,CC.Fontbig/2-1 do
				lib.Background(x-i,y+CC.Fontbig+i,x+CC.Fontbig*16-CC.MenuBorderPixel+i,y+CC.Fontbig,240,C_WHITE);
			end
			DrawString(x+CC.Fontbig*2,y,"����ָ��",M_Yellow,CC.Fontbig);
			y=y+CC.Fontbig+CC.RowPixel;
		end
	ShowScreen();
	WaitKey();
end
function PersonStatus(pid,offx,offy)
	Cls();
	PersonStatus_sub(pid,offx,offy);
	WaitKey();
	Cls();
end
function PersonStatus_sub(pid,offx,offy)
	offx=offx or 0;
	offy=offy or 0;
	local size=CC.Fontbig;
	local width=math.max(150,size*7.5)+size*10;
	local depth=math.max(150,(size+CC.RowPixel)*4)+(size+CC.RowPixel)*8+CC.FontBig/2+size*1.5;
	local cx,cy=(CC.ScreenW-width)/2+size/2,(CC.ScreenH-depth)/2+CC.FontBig/2+size/2;
	cx=cx+offx;
	cy=cy+offy;
	local x,y=cx,cy;
	Cls(cx,cy,CC.ScreenW,CC.ScreenH);
	DrawBoxTitle(width,depth,"����״̬",C_GOLD,offx,offy);
	--ͷ��
	local p=JY.Person[pid];
	local headw,headh=lib.PicGetXY(1,p["ͷ�����"]*2);
	y=y+math.max(150,size*4+CC.RowPixel*3)-size;
	lib.PicLoadCache(1,p["ͷ�����"]*2,x+(160+size*2-headw)/2,y-headh+size,1);
	for i=x,x+160+size*2 do
		lib.Background(i,y,i+1,y+size,16+160*math.abs(x+80+size-i)/80);
	end
	local len=math.max(#p["����"]*size/2,#p["���"]*size/3)+size*8/3;
	len=len/2;
	DrawString(x+84+size-len,y-size*2/3,p["���"],C_WHITE,size*2/3);
	DrawString(x+80+size-len,y,p["����"],C_ORANGE,size);
	DrawString(x+80+size+len-size*8/3,y-size*2/3,string.format("%2d",p["�ȼ�"]+4),M_Yellow,size*5/3);
	DrawString(x+80+size+len-size,y,"��",C_WHITE,size);	
			--[[
	local headw,headh=lib.PicGetXY(1,p["ͷ�����"]*2);
	lib.PicLoadCache(1,p["ͷ�����"]*2,x+headx,y+heady,1);
	for i=headx+x,headx+x+headw do
		lib.Background(i,y+heady+headh-size,i+1,y+heady+headh,64+128*math.abs(x+headx+headw/2-i)/75);
	end
	y=y+heady+headh-size;
	local len=string.len(p["����"])/2;
	x=x+(math.max(150,size*2+120)-size*(len+3))/2;
	DrawString(x,y,p["����"],M_Yellow,size);
	DrawString(x+size*(len+1),y,string.format("%2d",p["�ȼ�"]+4),M_Yellow,size);
	DrawString(x+size*(len+2),y,"��",M_DarkOrange,size);
	y=y+size+CC.RowPixel;]]--
	--��������
	x=cx;
	y=cy+math.max(150,(size+CC.RowPixel)*4)+size/2;
	DrawString(x,y,"�Ѻ�",C_WHITE,size);
	if pid~=0 then
		lib.SetClip(x,y,x+size*2.5+size*5*p["�Ѻ�"]/100,y+size+CC.RowPixel);
		DrawString(x+size*2.5,y,"������",C_GOLD,size);
		lib.SetClip(0,0,0,0);
	end
	y=y+size+CC.RowPixel;
	for i,v in pairs({"����","����","��"}) do
		local data=GetAttrib(pid,v);
		--[[if p["�Ѻ�"]>60 then
			--data=""
		elseif p["�Ѻ�"]>40 then
			data=10*math.modf((data+5)/10).."?"
		elseif p["�Ѻ�"]>20 then
			data=10*math.modf((data+25)/50).."??"
		else
			data="???"
		end]]--
		DrawString(x,y,v,C_WHITE,size);
		DrawString(x+size*2.5,y,data,C_GOLD,size);
		y=y+size+CC.RowPixel;
	end
	lib.PicLoadCache(0,12000+8*p["ս������"]+4,x+size*6,y);	
	local T={"","��","��","���","���","����","����","�����","�����","������","������"}
	for i,v in pairs({"ȭ��","����","ˣ��","ǹ��"}) do
		DrawString(x,y,v,C_WHITE,size);
		local bf=math.modf(p[v]/10)+1;
		bf=limitX(bf,1,11);
		local xxstr=T[bf];
		--[[if p["�Ѻ�"]>70 then
			--data=""
		elseif p["�Ѻ�"]>55 then
			if bf>8 then
				xxstr=string.gsub(xxstr,1,4).."?"
			end
		elseif p["�Ѻ�"]>40 then
			if bf>6 then
				xxstr=string.gsub(xxstr,1,3).."?"
			end
		elseif p["�Ѻ�"]>25 then
			if bf>4 then
				xxstr=string.gsub(xxstr,1,2).."??"
			end
		elseif p["�Ѻ�"]>10 then
			if bf>2 then
				xxstr=string.gsub(xxstr,1,1).."??"
			end
		elseif bf>0 then
			xxstr="???"
		end]]--
		DrawString(x+size*2.5,y,xxstr,C_GOLD,size);
		y=y+size+CC.RowPixel;
	end
	
	--������
	x=cx+math.max(150,size*7.5)+size/2;
	y=cy+(math.max(150,(size+CC.RowPixel)*4)-(size+CC.RowPixel)*4)/2;
	local T1={
					{"����",p["�������ֵ"],502},
					{"����",p["�������ֵ"],503},
					{"����",100,504},
					{"����",NextLvExp(p["�ȼ�"]),502},
				};
	for i,v in pairs(T1) do
		DrawString(x,y,v[1],M_DarkOrange,size);
		local bf=math.modf(p[v[1]]*160/v[2]);
		lib.PicLoadCache(99,501*2,x+size*2,y+(size-24)/2,1);
		lib.SetClip(x+size*2,y,x+size*2+bf,y+size+CC.RowPixel);
		lib.PicLoadCache(99,v[3]*2,x+size*2,y+(size-24)/2,1);
		lib.SetClip(0,0,0,0);
		local numstr=string.format("%d/%d",p[v[1]],v[2]);
--		if p["�Ѻ�"]>90 then
--			--data=""
--		elseif p["�Ѻ�"]>80 then
--			if v[2]>3000 then
--				numstr=string.format("%d?/%d?",10*math.modf(p[v[1]]/10),100*math.modf(v[2]/100));
--			end
--		elseif p["�Ѻ�"]>60 then
--			if v[2]>2000 then
--				numstr=string.format("%d?/%d?",20*math.modf(p[v[1]]/20),200*math.modf(v[2]/200));
--			end
--		elseif p["�Ѻ�"]>40 then
--			if v[2]>1000 then
--				numstr=string.format("%d??/%d??",50*math.modf(p[v[1]]/50),200*math.modf(v[2]/200));
--			end
--		elseif p["�Ѻ�"]>20 then
--			if v[2]>500 then
--				numstr=string.format("%d??/%d??",100*math.modf(p[v[1]]/100),300*math.modf(v[2]/300));
--			end
--		elseif v[2]>300 then
--			numstr="???/???"
--		end
		DrawString(x+size*2+(160-CC.Fontsmall*string.len(numstr)/2)/2,y+(size-16)/2,numstr,C_WHITE,20);
		y=y+size+CC.RowPixel;
	end
	--�书
	y=cy+math.max(150,(size+CC.RowPixel)*4)+size/2;
	DrawString(x,y,'�书',C_WHITE,size);
	y=y+(size+CC.RowPixel)*5;
	DrawString(x,y,'�ڹ�',C_WHITE,size);
	y=y+size+CC.RowPixel;
	DrawString(x,y,'�Ṧ',C_WHITE,size);
	y=y+size+CC.RowPixel;
	DrawString(x,y,'�ؼ�',C_WHITE,size);
	y=y+size+CC.RowPixel;
	x=x+size*2.5;
	y=cy+math.max(150,(size+CC.RowPixel)*4)+size/2;
	local T={"һ","��","��","��","��","��","��","��","��","ʮ","ʮһ","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","ʮ��","إ"}
	for i=1,8 do
		local kfid,kflv,str;
		if i==6 then
			kfid=p["�ڹ�"];
			kflv=1+math.modf(p["�ڹ�����"]/100);
		elseif i==7 then
			kfid=p["�Ṧ"];
			kflv=1+math.modf(p["�Ṧ����"]/100);
		elseif i==8 then
			kfid=p["�ؼ�"];
			kflv=1+math.modf(p["�ؼ�����"]/100);
		else
			kfid=p["�⹦"..i];
			kflv=1+math.modf(p["�⹦����"..i]/100);
		end
		
		if kfid>0 then
			str=JY.Wugong[kfid]["����"];
			--[[if i<6 then
				if p["�Ѻ�"]<10 then
					str="��������";
				end
			elseif i==7 then
				if p["�Ѻ�"]<25 then
					str="��������";
				end
			else
				if p["�Ѻ�"]<30 then
					str="��������";
				end
			end]]--
			if string.len(str)>10 then
				local size2=math.modf(size*10/string.len(str));
				DrawString(x,y+(size-size2)/2,str,M_Yellow,size2);
			else
				DrawString(x,y,str,M_Yellow,size);
			end
			if str~="��������" then
				DrawString(x+size*5,y,T[kflv],M_DarkOrange,size);
			end
		end
		y=y+size+CC.RowPixel;
	end
	ShowScreen();
	--WaitKey();
end

function Welcome()

	local box1=base_window.new(nil,nil,nil,"newbox","row",C_WHITE,C_ORANGE);
	local box2=base_window.new(box1,nil,nil,"nothing","line",C_WHITE,C_ORANGE);
	local strs={};
	for i=1,10 do
		strs[i]=base_window.new(box2,"����"..i,nil,"str","line",C_RED,C_ORANGE);
	end
	local box3=base_window.new(box1,nil,nil,"box","line",C_WHITE,C_ORANGE);
	local box4=base_window.new(box3,nil,nil,"nothing","line",C_WHITE,C_ORANGE);
	for i=11,15 do
		strs[i]=base_window.new(box4,"����"..i,nil,"strnewbox","line",C_RED,C_ORANGE);
	end
	local box5=base_window.new(box3,nil,nil,"nothing","row",C_WHITE,C_ORANGE);
	for i=16,20 do
		strs[i]=base_window.new(box5,"����"..i,nil,"strbox","line",C_RED,C_ORANGE);
	end
	box1:autoposition();
	box1:show();
	ShowScreen();
	WaitKey();


	--NewGameString(2);
	Dark();
	DrawString(CC.ScreenW/2-8*#"A Game from txdx.net",CC.ScreenH/2-16,"A Game from txdx.net",C_WHITE,32,C_WHITE);
	Light();
	lib.Delay(500);
	WaitKey();
	lib.Delay(500);
	Dark();
	lib.LoadPicture(CONFIG.PicturePath.."logo1.png",-1,-1);
	DrawString(190,350,"���й����Լ�������������Ϸ",C_WHITE,32);
	Light();
	lib.Delay(500);
	WaitKey();
	lib.Delay(500);
	Dark();
end

function NewGameString(flag)
	
        lib.LoadPicture(CC.FirstFile,-1,-1);
	--	lib.FillColor(0,0,0,0,C_WHITE);
	lib.Background(0,0,CC.ScreenW,CC.ScreenH,64)
	ShowScreen();
	local str="������ʱ�ݡ������Ӣ��*��֪��ɽ֮�ۡ�����������*ȭ�羵ӳ���ġ�����Ӱ���˼�*�������貨*�̺�������Ц��������*����������*�������������졡����д*����������˭��ǧ��������*���ű��ڲ�ֹ������һ���ޱ�*���⾡����*������쳾������η��";
	local num,strarray=Split(str,'*');
	local size=CC.FontBig;
	local color=C_ORANGE;
	local delay=400;
	local RowPixel=CC.RowPixel*1.5;
	local sx,sy=CC.ScreenW-CC.FontBig,CC.FontBig;
	local function show(i,j)
		if flag==1 then
			ShowScreen();
			lib.Delay(delay);
		elseif flag==2 then
			local x1=sx-(size+RowPixel)*i;
			local y1=sy+size*j;
			for i=1,size do
				lib.SetClip(x1,y1+i-1,x1+size,y1+i);
				lib.ShowSurface(1);
				lib.Delay(delay/size);
				lib.SetClip(0,0,0,0);
			end
		elseif flag==3 then
			local x1=sx-(size+RowPixel)*i;
			local y1=sy+size*j;
			lib.SetClip(x1,y1,x1+size,y1+size);
			lib.ShowSlow(delay/32,0)
			lib.SetClip(0,0,0,0);
		end
	end
	for i=1,num do
		for j=1,#strarray[i]/2 do
			DrawString(sx-(size+RowPixel)*i,sy+size*(j-1+(13-#strarray[i]/2)/2),string.sub(strarray[i],j*2-1,j*2),color,size);
			show(i,j-1+(13-#strarray[i]/2)/2);
			getkey();
		end
	end
	lib.Delay(300);
	WaitKey();
	lib.Delay(300);
end

function NewGameSetting()
	--lib.PicLoadFile(CC.HeadPicFile[1],CC.HeadPicFile[2],1);
	local height=math.max(150,(CC.Fontbig+CC.RowPixel)*5)+CC.RowPixel*2;
	local status=1;
	local p=JY.Person[0];
	local Tip={"���Ҽ�ѡ��ͷ�񣬻س���ȷ��","���¼�ѡ�����ԣ����Ҽ��������س���ȷ��"}
	local pic={[0]=8,0,38,39,40,41,42,43,44};
	local sel_pic=1;
	local sx={"����","����","����","����","��Ե"};
	local sx_sel=1;
	local p_max={};--{["����"]=p["����"],["����"]=p["����"],["����"]=p["����"],["����"]=p["����"],["��Ե"]=p["��Ե"]};
	local p_min={};--{["����"]=p["����"],["����"]=p["����"],["����"]=p["����"],["����"]=p["����"],["��Ե"]=p["��Ե"]};
	local p_now={};--{["����"]=p["����"],["����"]=p["����"],["����"]=p["����"],["����"]=p["����"],["��Ե"]=p["��Ե"]};
	local point=10;
	for i,v in pairs(sx) do
		p_max[v]=math.modf(p[v]*0.85+math.random(30));
		p_min[v]=math.modf(p[v]*0.3+math.random(15));
		p_now[v]=math.modf(p[v]*0.6+math.random(15));
		p_max[v]=limitX(p_max[v],60,95);
		p_min[v]=limitX(p_min[v],20,50);
		p_now[v]=limitX(p_now[v],p_min[v],p_max[v]);
		point=point+limitX(math.modf((85-p_max[v])*1),-15,15);
	end
	if point<5 then
		point=5;
	end
	local function ReDraw()
		--lib.FillColor(0,0,0,0,0);
		Cls();
		DrawStrBox(0,CC.ScreenH-height-CC.FontBig-CC.RowPixel*2,Tip[status],C_WHITE,CC.Fontbig);
		DrawBox(0,CC.ScreenH-height-CC.RowPixel*2,CC.ScreenW,CC.ScreenH,C_WHITE);
		if status==1 then
			DrawBox(CC.RowPixel,CC.ScreenH-height-CC.RowPixel,CC.RowPixel+height,CC.ScreenH-CC.RowPixel,C_ORANGE);
		elseif status==2 then
			DrawBox(CC.RowPixel*2+height,CC.ScreenH-height-CC.RowPixel,CC.ScreenW-CC.RowPixel,CC.ScreenH-CC.RowPixel,C_ORANGE);
		end
		lib.PicLoadCache(1,pic[sel_pic]*2,CC.RowPixel+(height-150)/2,CC.ScreenH-height-CC.RowPixel+(height-150)/2,1);
		local cx=CC.RowPixel*4+height+CC.Fontbig*2;
		local cy=CC.ScreenH-height+(height-CC.Fontbig*5-CC.RowPixel*6)/2;
		local length=(CC.ScreenW-cx-CC.RowPixel*3-CC.Fontbig*8)/100;
		DrawString(cx+length*100+CC.Fontbig,cy,string.format("���õ���: ��%d",point),C_WHITE,CC.Fontbig);
		for i=1,5 do
--			if i==1 then
--				DrawBox(cx-CC.RowPixel,cy-CC.RowPixel/2,cx+200,cy+CC.Fontbig+CC.RowPixel/2,C_ORANGE);
--			end
			local color=C_WHITE;
			if i==sx_sel and status==2 then
				color=C_ORANGE;
			end
			DrawString(cx-CC.Fontbig*2-CC.RowPixel,cy,sx[i],color,CC.Fontbig);
			DrawBox(cx,cy,cx+math.modf(p_max[sx[i]]*length),cy+CC.Fontbig,C_WHITE);
			DrawBox(cx,cy,cx+math.modf(p_now[sx[i]]*length)-1,cy+CC.Fontbig,C_WHITE,color);
			cy=cy+CC.Fontbig+CC.RowPixel;
		end
	end
	Dark();
	ReDraw();
	Light();
	while status<3 do
		ReDraw();
		ShowScreen();
		lib.Delay(30);
		local event,key,mx,my=getkey();
		if status==1 then
			if event==1 then
				if key==VK_LEFT then
					sel_pic=sel_pic-1;
				elseif key==VK_RIGHT then
					sel_pic=sel_pic+1;
				elseif key==VK_SPACE or key==VK_RETURN then
					status=2;
				end
			end
			sel_pic=limitX(sel_pic,1,pic[0]);
		elseif status==2 then
			local now_sx=sx[sx_sel];
			if event==1 then
				if key==VK_LEFT then
					if p_now[now_sx]>p_min[now_sx] then
						p_now[now_sx]=p_now[now_sx]-1;
						point=point+1;
					end
				elseif key==VK_RIGHT then
					if p_now[now_sx]<p_max[now_sx] and point>0 then
						p_now[now_sx]=p_now[now_sx]+1;
						point=point-1;
					end
				elseif key==VK_UP then
					sx_sel=sx_sel-1;
				elseif key==VK_DOWN then
					sx_sel=sx_sel+1;
				elseif key==VK_SPACE or key==VK_RETURN then
					status=3;
				end
			end
			sx_sel=limitX(sx_sel,1,5);
		end
	end
	for i=1,5 do
		local v=sx[i];
		p[v]=p_now[v];
	end
	p["ͷ�����"]=pic[sel_pic];
	--WaitKey();
end

function GenSelection(menuItem)
	--DarkScreen
	local dk1,dk2=128,32;
	local y_step=2;
	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	for i=1,50 do
		local t1=lib.GetTime();
		lib.LoadSur(sid,0,0);
		dk1=256-96*i/50;
		dk2=256-224*i/50;
		for i=1,CC.ScreenH-1,y_step do
			lib.Background(1,i,CC.ScreenW,i+y_step,dk1+(dk2-dk1)*math.abs(i-CC.ScreenH/2)/(CC.ScreenH/2));
		end
		ShowScreen();
		getkey();
		lib.Delay(30+t1-lib.GetTime());
	end
	--lib.FreeSur(sid);
	lib.Delay(200);
	--[[
	local menuItem=	{
							{"���������",nil,1},
							{"�����ѱ�",nil,1},
							{"789",nil,0},
							{"���߶��ǲ��𣬶�һ��ȥ",nil,1},
						}]]--
	local n=0
	for i,v in pairs(menuItem) do
		v[1]=fillblank(v[1],2*CC.ScreenW/CC.Fontbig);
		v[3]=v[2] or 1;
		v[2]=nil;
		n=n+1;
	end
	for i=n,1,-1 do
		if menuItem[i][3]~=0 then
			menuItem[i][3]=2;
			break;
		end
	end
	local r=ShowMenu(menuItem,n,0,0,0,0,0,0,0,CC.Fontbig,M_DimGray,C_WHITE);
	--WaitKey();
	for i=50,0,-1 do
		local t1=lib.GetTime();
		lib.LoadSur(sid,0,0);
		dk1=256-96*i/50;
		dk2=256-224*i/50;
		for i=1,CC.ScreenH-1,y_step do
			lib.Background(1,i,CC.ScreenW,i+y_step,dk1+(dk2-dk1)*math.abs(i-CC.ScreenH/2)/(CC.ScreenH/2));
		end
		ShowScreen();
		getkey();
		lib.Delay(30+t1-lib.GetTime());
	end
	lib.FreeSur(sid);
	lib.Delay(200);
	return r;
end

function StrTalk()
end
function ShowStrTalk()
	local dk1,dk2=128,32;
	local y_step=2;
	local sid=lib.SaveSur(0,0,CC.ScreenW,CC.ScreenH);
	for i=1,50 do
		local t1=lib.GetTime();
		lib.LoadSur(sid,0,0);
		dk1=256-96*i/50;
		dk2=256-224*i/50;
		for i=1,CC.ScreenH-1,y_step do
			lib.Background(1,i,CC.ScreenW,i+y_step,dk1+(dk2-dk1)*math.abs(i-CC.ScreenH/2)/(CC.ScreenH/2));
		end
		ShowScreen();
		getkey();
		lib.Delay(30+t1-lib.GetTime());
	end
	--lib.FreeSur(sid);
	lib.Delay(200);
	
	StrTalk();
	
	for i=50,0,-1 do
		local t1=lib.GetTime();
		lib.LoadSur(sid,0,0);
		dk1=256-96*i/50;
		dk2=256-224*i/50;
		for i=1,CC.ScreenH-1,y_step do
			lib.Background(1,i,CC.ScreenW,i+y_step,dk1+(dk2-dk1)*math.abs(i-CC.ScreenH/2)/(CC.ScreenH/2));
		end
		ShowScreen();
		getkey();
		lib.Delay(30+t1-lib.GetTime());
	end
	lib.FreeSur(sid);
	lib.Delay(200);
	return;
end

function ShowAllPerson(p,mulitSelect)	--��������,�б���ʾ����
	local num=0;
	mulitSelect=mulitSelect or 0;
	for i,v in pairs(p) do
		num=num+1;
	end
	local PMenu={};
	local nowSelectNum=0;
	for i,v in pairs(p) do
		if v[2]>0 then
			nowSelectNum=nowSelectNum+1;
		end
	end
	local function thisShowPerson(id)
		PersonStatus_sub(p[id][1],CC.Fontbig*2,0);
	end
	local function thisShowSelect()
		local s="";
		local n=0;
		for i,v in pairs(p) do
			if v[2]>0 then
				n=n+1;
				if n%4==1 then
					s=s.."*";
				end
				s=s..JY.Person[v[1]]["����"].." ";
			end
		end
		if n>0 then
			s="��ǰ��ѡ�����"..s;
		else
			s="��ǰδѡ���κ�����";
		end
		DrawStrNewBox(CC.Fontbig*7,-1,s,C_WHITE,CC.Fontbig);
	end
	for i=1,num do
		if p[i][2]>0 then
			PMenu[i]={fillblank("*"..JY.Person[p[i][1]]["����"],10),thisShowPerson,1};
		else
			PMenu[i]={fillblank(JY.Person[p[i][1]]["����"],10),thisShowPerson,1};
		end
	end
	if mulitSelect>=1 then
		num=num+1;
		PMenu[num]={fillblank("����",10),thisShowSelect,1};
	else
		num=num+1;
		PMenu[num]={fillblank("ȡ��",10),nil,1};
	end
	JY.Menu_keep=true;
	while true do
		local r=ShowMenu(PMenu,num,22,24,-1,0,0,1,0,CC.FontSmall,C_ORANGE,C_WHITE,1);
		if mulitSelect>=1 then
			if r<num then
				local pid=p[r][1];
				if p[r][2]==0 then
					if nowSelectNum<mulitSelect then
						p[r][2]=1;
						PMenu[r][1]=fillblank("*"..JY.Person[pid]["����"],10);
						nowSelectNum=nowSelectNum+1;
					else
						DrawStrBoxWaitKey("��ѡ���㹻����",C_WHITE,CC.Fontbig);
					end
				elseif p[r][2]==2 then
					DrawStrBoxWaitKey("�������޷�ȡ��",C_WHITE,CC.Fontbig);
				else
					p[r][2]=0;
					PMenu[r][1]=fillblank(JY.Person[pid]["����"],10);
					nowSelectNum=nowSelectNum-1;
				end
			else
				if DrawStrBoxYesNo(-1,-1,"�Ƿ�ȷ����",C_WHITE,CC.Fontbig) then
					JY.Menu_keep=false;
					JY.Menu_start=1;
					JY.Menu_current=1;
					return p;
				end
			end
		else
			if r==num then
				JY.Menu_keep=false;
				JY.Menu_start=1;
				JY.Menu_current=1;
				return -1;
			else
				JY.Menu_keep=false;
				JY.Menu_start=1;
				JY.Menu_current=1;
				return p[r][1];
			end
		end
	end
























end

function game50(n)
	n= n or 50;
	local numbuf={};
	for i=1,n do
		numbuf={math.random(9),math.random(9)};
	end
	
end

function ResizeScreen(w,h)
	JY.WindowReSizeFlag=true;
	CC.ScreenW=w;
	CC.ScreenH=h;
	CC.FontBIG=math.modf(math.min(CC.ScreenW,CC.ScreenH)/12)	--���δʹ��	640x480ʱsize=40
	CC.FontBig=math.modf(math.min(CC.ScreenW,CC.ScreenH)/15)	--�ϴ���Ϸ��ʼ�˵�ʹ��	640x480ʱsize=32
	CC.Fontbig=math.modf(math.min(CC.ScreenW,CC.ScreenH)/20)	--ͨ���ֺţ��Ի��˵���ʹ��	640x480ʱsize=24
	CC.Fontsmall=math.modf(math.min(CC.ScreenW,CC.ScreenH)/24)	--��С�ֺ�	640x480ʱsize=20
	CC.FontSmall=math.modf(math.min(CC.ScreenW,CC.ScreenH)/30)	--��С�ֺ�	640x480ʱsize=16
	CC.FontSMALL=math.modf(math.min(CC.ScreenW,CC.ScreenH)/40)	--��С�ֺ�	640x480ʱsize=12
	CC.RowPixel=math.modf(math.min(CC.ScreenW,CC.ScreenH)/100)         -- ÿ���ֵļ��������
    CC.StartMenuY=CC.ScreenH-3*(CC.FontBig+CC.RowPixel)-20;
	CC.NewGameY=CC.ScreenH-4*(CC.Fontbig+CC.RowPixel)-10;
	CC.MainSize=math.modf(CC.ScreenW/24);
	CC.MainX_L=math.modf((CC.ScreenW-CC.MainSize*20-CC.RowPixel*4-CC.MenuBorderPixel*10)/2);
	CC.MainX=CC.MainX_L+(CC.MainSize*6+CC.RowPixel)+CC.MenuBorderPixel*2;
	CC.MainY=(CC.ScreenH-CC.MainSize-CC.MenuBorderPixel*4-160-(CC.Fontsmall+CC.RowPixel)*11)/2;--CC.ScreenH/20;
	CC.MainY2=CC.MainY+CC.MainSize+4+CC.MenuBorderPixel*2;
	--�Ӳ˵��Ŀ�ʼ����
	CC.MainSubMenuX=CC.MainMenuX+4*CC.MenuBorderPixel+2*CC.Fontbig+5;       --���˵�Ϊ��������
	CC.MainSubMenuY=CC.MainMenuY;

	--�����Ӳ˵���ʼ����
	CC.MainSubMenuX2=CC.MainSubMenuX+4*CC.MenuBorderPixel+4*CC.Fontbig+5;   --�Ӳ˵�Ϊ�ĸ��ַ�

	CC.SingleLineHeight=CC.Fontbig+2*CC.MenuBorderPixel+5;  --����ĵ����ַ���
						setBright();
	Cls();
	ShowScreen();
end












-------------ForceAI-----------------------

function ForcePersonPosition()
	local s_table={57};
	for idx1,sid in pairs(s_table) do
		local p_table={};
		AutoSelect(p_table,JY.Person,"���",">",0);
		AutoSelect(p_table,JY.Person,"����","==",sid);
		for idx2,pid in pairs(p_table) do
			for did=1,100 do
				GetD(sid,did,2)
			end
		end
	end
end
function PersoninItialize()
	local cx=(CC.ScreenW-460)/2-4;
	local cy=(CC.ScreenH-CC.FontBig)/2-4;
	local tx=(CC.ScreenW-CC.Fontbig*6)/2;
	local ty=(CC.ScreenH-CC.Fontbig)/2-4;
	lib.FillColor(0,0,0,0,0);
	for pid=1,460 do
			DrawNewBox(cx,cy,cx+460,cy+CC.FontBig,C_WHITE);
			DrawNewBox(cx,cy,cx+pid,cy+CC.FontBig,C_WHITE,C_ORANGE);
			DrawString(tx,ty," ���ݳ�ʼ�� ",C_WHITE,CC.Fontbig);
			ShowScreen();
			--lib.Delay(10)
		local p=JY.Person[pid];
		for i=1,80 do
			p["�����书"..i]=0;
			p["�����书����"..i]=0;
		end
		for i=1,5 do
			SetKF(pid,p["�⹦"..i],p["�⹦����"..i]);
		end
		SetKF(pid,p["�ڹ�"],p["�ڹ�����"]);
		SetKF(pid,p["�Ṧ"],p["�Ṧ����"]);
		SetKF(pid,p["�ؼ�"],p["�ؼ�����"]);
		--[[for ii=1,3 do
			local sc=p["ʦ��"..ii];
			if sc>0 then
				for j=1,7 do
					local kfid=JY.Shicheng[sc]["�书"..j];
					if kfid>0 then
						if true then--IfCanLearn(pid,kfid) and p["�ȼ�"]>JY.Wugong[kfid]["�Ƚ�"]^2 then--can learn
							local kflv=10*p["�ȼ�"]*(50+p["����"])/(50+JY.Wugong[kfid]["��������"])/(1+JY.Wugong[kfid]["�Ƚ�"]);
							if JY.Wugong[kfid]["�书����"]>=6 then
								kflv=kflv*0.7;
							end
							kflv=math.modf(kflv);
							if kflv>9 then
								kflv=9;
							end
							if Getkflv(pid,kfid)<kflv then
								SetKF(pid,kfid,kflv*100);
							end
						end
					end
				end
			end
		end]]--
		PersonKungfuSetup(pid);
		ResetPersonAttrib(pid);
		AddPersonAttrib(pid,"����",math.huge);
		AddPersonAttrib(pid,"����",math.huge);
	end
	Cls();
end
function PersonKungfuSetup(pid,kind)
	kind=kind or 0;
	pid=pid or 0;
	local p=JY.Person[pid];
	local k={};
	local num=0;
	for i=1,80 do
		local kfid=p["�����书"..i];
		if kfid<=0 then
			num=i-1;
			break;
		end
		local kflv=1+math.modf(p["�����书����"..i]/100);
		local point=-1;
		if kind==0 then
			point=JY.Wugong[kfid]["�Ƚ�"]+JY.Wugong[kfid]["�˺�"]/10+JY.Wugong[kfid]["����"]+JY.Wugong[kfid]["����"]+JY.Wugong[kfid]["��"];
			point=point*kflv;
			if point<1 then
				point=1
			end
		end
		k[i]={kfid,p["�����书����"..i],point};
	end
	for i=1,num-1 do
		for j=i+1,num do
			if k[i][3]<k[j][3] then
				k[i],k[j]=k[j],k[i];
			end
		end
	end
	for i=1,5 do
		p["�⹦"..i]=0;
		p["�⹦����"..i]=0;
	end
	p["�ڹ�"]=0;
	p["�ڹ�����"]=0;
	p["�Ṧ"]=0;
	p["�Ṧ����"]=0;
	p["�ؼ�"]=0;
	p["�ؼ�����"]=0;
	for i=1,num do
		if JY.Wugong[k[i][1]]["�书����"]<7 then
			for j=1,5 do
				if p["�⹦"..j]==0 then
					p["�⹦"..j]=k[i][1];
					p["�⹦����"..j]=k[i][2];
					break;
				end
			end
		elseif JY.Wugong[k[i][1]]["�书����"]==7 then
			p["�ڹ�"]=k[i][1];
			p["�ڹ�����"]=k[i][2];
		elseif JY.Wugong[k[i][1]]["�书����"]==8 then
			p["�Ṧ"]=k[i][1];
			p["�Ṧ����"]=k[i][2];
		elseif JY.Wugong[k[i][1]]["�书����"]==9 then
			p["�ؼ�"]=k[i][1];
			p["�ؼ�����"]=k[i][2];
		end
		if p["�⹦1"]>0 and p["�⹦2"]>0 and p["�⹦3"]>0 and p["�⹦4"]>0 and p["�⹦5"]>0 and p["�ڹ�"]>0 and p["�Ṧ"]>0 and p["�ؼ�"]>0 then
			break;
		end
	end
end

function DrawMMap()--50 18/9
	local cx,cy=JY.Base["��X"],JY.Base["��Y"];
	local pic_w,pic_h=18,9;
	local sf=50;
	local tx,ty=JY.Base["��X"],JY.Base["��Y"];
	local len=10;
	lib.PicLoadFile(CC.MMAPPicFile[1],CC.MMAPPicFile[2],5,sf);
	--lib.SetClip(CC.ScreenW*1/6,CC.ScreenH*1/6,CC.ScreenW*5/6,CC.ScreenH*5/6);
	local function ReDraw()
		lib.DrawMMapEnhance(cx,cy,5,sf,tx,ty,len);
		DrawStrNewBox(10,10,sf,C_WHITE,32)
		ShowScreen();
	end
	--[[
	for t=1,10 do
		for i=0,479,5 do
			for j=0,479,5 do
				cx,cy=i,j;
				ReDraw();
				getkey();
			end
		end
	end]]--
	while true do
		ReDraw();
		lib.Delay(50);
		local eventtype,keyPress,mx,my=WaitKey(1);
		if eventtype==1 then
			if keyPress==VK_ESCAPE then                  --Esc �˳�
				if isEsc==1 then
					break;
				end
			elseif keyPress==VK_UP then                  --Up
				cx=cx-math.modf(100/sf);
				cy=cy-math.modf(100/sf);
			elseif keyPress==VK_DOWN then                --Down
				cx=cx+math.modf(100/sf);
				cy=cy+math.modf(100/sf);
			elseif keyPress==VK_LEFT then                  --Left
				cx=cx-math.modf(100/sf);
				cy=cy+math.modf(100/sf);
			elseif keyPress==VK_RIGHT then                --Right
				cx=cx+math.modf(100/sf);
				cy=cy-math.modf(100/sf);
			end
			cx=limitX(cx,10,470);
			cy=limitX(cy,10,470);
		elseif eventtype==3 then
			mx=mx-CC.ScreenW/2;
			my=my-CC.ScreenH/2;
			mx=mx/math.modf(CC.XScale*sf/100);
			my=my/math.modf(CC.YScale*sf/100);
			mx,my=(mx+my)/2,(my-mx)/2;
			if mx>0 then mx=mx+0.99 else mx=mx-0.01 end
			if my>0 then my=my+0.99 else mx=mx-0.01 end
			mx=cx+math.modf(mx);
			my=cy+math.modf(my);
			local yyx=lib.GetMMap(mx,my,3);
			local yyy=lib.GetMMap(mx,my,4);
			local flag=false;
			if yyx>0 and yyy>0 then
				local v=lib.GetMMap(yyx,yyy,2);
				for i=-5,5 do
					for j=-5,5 do
						if lib.GetMMap(yyx+i,yyy+j,3)==yyx and lib.GetMMap(yyx+i,yyy+j,4)==yyy then
							local sid=CanEnterScene(yyx+i,yyy+j);
							if sid>=0 then
								if true then
									tx=yyx+i;
									ty=yyy+j;
									len=10+math.modf(sid/10);
									flag=true;
								end
							end
							if flag then
								break;
							end
						end
					end
					if flag then
						break;
					end
				end
			end
			if not flag then
				len=-1;
			end
		elseif eventtype==4 then
			local oldsf=sf;
			local off=10;
			if sf<50 then
				off=5;
			end
			if keyPress==4 then
				if sf<50 then
					sf=sf+5;
				else
					sf=sf+10;
				end
			elseif keyPress==5 then
				if sf<=50 then
					sf=sf-5;
				else
					sf=sf-10;
				end
			end
			sf=limitX(sf,25,100);
			if sf~=oldsf then
				lib.PicLoadFile(CC.MMAPPicFile[1],CC.MMAPPicFile[2],5,sf);
				lib.Delay(5);
				lib.GetKey();
			end
		end
	end
	lib.SetClip(0,0,0,0);
end