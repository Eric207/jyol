JY.Person={
	[0]={												--0,人物编号
		["代号"]=0,									--游戏里不使用
		["头像代号"]=0,								--头像代号
		["战斗动作"]=0,								--战斗动作编号
		["姓名"]='杨康',
		["性别"]=0,									--性别，0-男1-女2-东方
		["等级"]=1,									--等级
		["经验"]=0,									--经验
		["生命"]=8700,								--当前生命
		["生命最大值"]=8700,						--生命最大值
		["生命Max"]=8700,
		["内力性质"]=2,								--内力性质012阴阳调和
		["内力"]=8800,								--当前内力
		["内力最大值"]=8800,						--内力最大值
		["内力Max"]=8800,
		["体力"]=100,								--体力
		["武器"]=-1,									--武器，-1或nil表示无武器
		["防具"]=-1,									--防具，其余同上
		["内功"]={0,0},									--装备的内功，填写
															--若为0则无装备了的内功
		["轻功"]={0,0},									--装备了的轻功，其余同上
		["特技"]={0,0},									--装备了的特技，其余同上
		["医疗"]=0,									--医疗能力
		["用毒"]=0,									--用毒能力
		["解毒"]=0,									--解毒能力
		["抗毒"]=0,								--抗毒能力
		["拳掌"]=0,									--拳掌能力
		["御剑"]=0,									--御剑能力
		["耍刀"]=0,									--耍刀能力
		["枪棍"]=0,									--使棍能力
		["暗器"]=0,									--暗器能力
		["力道"]=100,									--力道
		["精纯"]=150,									--精彩
		["身法"]=200,									--身法
		["根骨"]=0,									--根骨
		["修为"]=0,									--修为
		["资质"]=0,									--资质
		["修炼物品"]=-1,								--修炼物品，nil或-1表示无
		["修炼点数"]=0,								--修炼点数
		["中毒"]=0,["内伤"]=0,["流血"]=0,
		["武功"]={{151,999},},
		["备用武功"]={
						{354,900},{371,900},{372,900},{393,900},{394,900},{334,900},{335,900},{351,900},{352,900},{353,900},
						{19,900},{20,900},{31,900},{35,900},{41,900},{42,900},{43,900},{54,900},{71,900},{78,900},{72,900},{73,900},{74,900},
						{101,900},{102,900},{103,900},{104,900},{111,900},{112,900},{113,900},{114,900},{115,900},{116,900},
						{132,900},{133,900},{134,900},{135,900},{136,900},{137,900},{138,900},{139,900},{140,900},{141,900},{151,900},{152,900},
						{501,999},{191,999},{199,999},{547,999},{562,999},{91,999},{94,999},{93,999},{291,999},{292,999},{272,999},{545,999},
						{75,999},{175,999},{192,999},
					},									--内部{,}第一个数是武功编号，第二个是武功经验
		["携带物品"]={[0]=0,},					--最前面[0]=就不解释了，后面的{,}第一个数是物品编号，第二个是物品数目
	},
	[1]={
		["代号"]=1,
		["头像代号"]=2,
		["战斗动作"]=1,
		["姓名"]='包惜弱',
		["性别"]=1,
		["等级"]=1,
		["经验"]=0,
		["生命"]=100,
		["生命最大值"]=100,
		["内力性质"]=2,
		["内力"]=100,
		["内力最大值"]=100,
		["体力"]=100,
		["武器"]=-1,
		["防具"]=-1,
		["内功"]=-1,
		["轻功"]=-1,
		["特技"]=-1,
		["医疗"]=0,
		["用毒"]=0,
		["解毒"]=0,
		["抗毒"]=0,
		["拳掌"]=0,
		["御剑"]=0,
		["耍刀"]=0,
		["枪棍"]=0,
		["暗器"]=0,
		["力道"]=0,
		["精纯"]=0,
		["身法"]=0,
		["根骨"]=0,
		["修为"]=0,
		["资质"]=0,
		["修炼物品"]=-1,
		["修炼点数"]=0,
		["武功"]={{1,900},},
		["携带物品"]={[0]=0,},
	},
	[2]={
		["代号"]=2,
		["头像代号"]=1,
		["战斗动作"]=1,
		["姓名"]='完颜洪烈',
		["性别"]=0,
		["等级"]=1,
		["经验"]=0,
		["生命"]=100,
		["生命最大值"]=100,
		["内力性质"]=2,
		["内力"]=100,
		["内力最大值"]=100,
		["体力"]=100,
		["武器"]=-1,
		["防具"]=-1,
		["内功"]=-1,
		["轻功"]=-1,
		["特技"]=-1,
		["医疗"]=0,
		["用毒"]=0,
		["解毒"]=0,
		["抗毒"]=0,
		["拳掌"]=0,
		["御剑"]=0,
		["耍刀"]=0,
		["枪棍"]=0,
		["暗器"]=0,
		["力道"]=0,
		["精纯"]=0,
		["身法"]=0,
		["根骨"]=0,
		["修为"]=0,
		["资质"]=0,
		["修炼物品"]=-1,
		["修炼点数"]=0,
		["武功"]={{1,900},},
		["携带物品"]={[0]=0,},
	},
	[3]={
		["代号"]=3,
		["头像代号"]=4,
		["战斗动作"]=1,
		["姓名"]='灵智上人',
		["性别"]=0,
		["等级"]=1,
		["经验"]=0,
		["生命"]=100,["生命最大值"]=100,
		["内力性质"]=2,["内力"]=100,["内力最大值"]=100,
		["体力"]=100,
		["武器"]=-1,["防具"]=-1,
		["内功"]=-1,["轻功"]=-1,["特技"]=-1,
		["医疗"]=0,["用毒"]=0,["解毒"]=0,["抗毒"]=0,
		["拳掌"]=0,["御剑"]=0,["耍刀"]=0,["枪棍"]=0,["暗器"]=0,
		["力道"]=0,["精纯"]=0,["身法"]=0,["根骨"]=0,
		["修为"]=0,
		["资质"]=0,
		["修炼物品"]=-1,
		["修炼点数"]=0,
		["武功"]={{1,900},},
		["携带物品"]={[0]=0,},
	},
	[4]={
		["代号"]=4,
		["头像代号"]=5,
		["战斗动作"]=1,
		["姓名"]='侯通海',
		["性别"]=0,
		["等级"]=1,
		["经验"]=0,
		["生命"]=9100,["生命最大值"]=9100,["生命Max"]=9100,
		["内力性质"]=14,["内力"]=6100,["内力最大值"]=6100,["内力Max"]=3100,
		["体力"]=100,
		["武器"]=-1,["防具"]=-1,
		["内功"]={549,999},["轻功"]={0,0},["特技"]={0,0},
		["医疗"]=0,["用毒"]=0,["解毒"]=0,["抗毒"]=0,
		["拳掌"]=0,["御剑"]=0,["耍刀"]=0,["枪棍"]=0,["暗器"]=0,
		["力道"]=0,["精纯"]=0,["身法"]=100,["根骨"]=0,
		["中毒"]=0,["内伤"]=0,["流血"]=0,
		["修为"]=0,
		["资质"]=0,
		["修炼物品"]=-1,
		["修炼点数"]=0,
		["武功"]={{31,900},{32,900},{33,999},{34,999},{35,999}},
		["备用武功"]={
						{32,900},{33,999},{34,999},
						{354,900},{371,900},{372,900},{393,900},{394,900},{334,900},{335,900},{351,900},{352,900},{353,900},
						{19,900},{20,900},{31,900},{35,900},{41,900},{42,900},{43,900},{54,900},{71,900},{78,900},{72,900},{73,900},{74,900},
						{101,900},{102,900},{103,900},{104,900},{111,900},{112,900},{113,900},{114,900},{115,900},{116,900},
						{132,900},{133,900},{134,900},{135,900},{136,900},{137,900},{138,900},{139,900},{140,900},{141,900},{151,900},{152,900},
						{501,999},{191,999},{199,999},{547,999},{562,999},{91,999},{94,999},{93,999},{291,999},{292,999},{272,999},{545,999},
						{75,999},{175,999},{192,999},{549,999},
					},
		["携带物品"]={[0]=0,},
	},
	[5]={
		["代号"]=5,
		["头像代号"]=6,
		["战斗动作"]=1,
		["姓名"]='沙通天',
		["性别"]=0,
		["等级"]=1,
		["经验"]=0,
		["生命"]=9100,["生命最大值"]=9100,
		["内力性质"]=2,["内力"]=100,["内力最大值"]=100,
		["体力"]=100,
		["武器"]=-1,["防具"]=-1,
		["内功"]=-1,["轻功"]=-1,["特技"]=-1,
		["医疗"]=0,["用毒"]=0,["解毒"]=0,["抗毒"]=0,
		["拳掌"]=0,["御剑"]=0,["耍刀"]=0,["枪棍"]=0,["暗器"]=0,
		["力道"]=0,["精纯"]=0,["身法"]=0,["根骨"]=0,
		["修为"]=0,
		["资质"]=0,
		["修炼物品"]=-1,
		["修炼点数"]=0,
		["武功"]={{1,900},},
		["携带物品"]={[0]=0,},
	},
	[6]={
		["代号"]=6,
		["头像代号"]=31,
		["战斗动作"]=1,
		["姓名"]='梁子翁',
		["性别"]=0,
		["等级"]=1,
		["经验"]=0,
		["生命"]=100,["生命最大值"]=100,
		["内力性质"]=2,["内力"]=100,["内力最大值"]=100,
		["体力"]=100,
		["武器"]=-1,["防具"]=-1,
		["内功"]=-1,["轻功"]=-1,["特技"]=-1,
		["医疗"]=0,["用毒"]=0,["解毒"]=0,["抗毒"]=0,
		["拳掌"]=0,["御剑"]=0,["耍刀"]=0,["枪棍"]=0,["暗器"]=0,
		["力道"]=0,["精纯"]=0,["身法"]=0,["根骨"]=0,
		["修为"]=0,
		["资质"]=0,
		["修炼物品"]=-1,
		["修炼点数"]=0,
		["武功"]={{1,900},},
		["携带物品"]={[0]=0,},
	},
	[7]={
		["代号"]=7,
		["头像代号"]=9,
		["战斗动作"]=1,
		["姓名"]='沈青刚',
		["性别"]=0,
		["等级"]=1,
		["经验"]=0,
		["生命"]=100,["生命最大值"]=100,
		["内力性质"]=2,["内力"]=100,["内力最大值"]=100,
		["体力"]=100,
		["武器"]=-1,["防具"]=-1,
		["内功"]=-1,["轻功"]=-1,["特技"]=-1,
		["医疗"]=0,["用毒"]=0,["解毒"]=0,["抗毒"]=0,
		["拳掌"]=0,["御剑"]=0,["耍刀"]=0,["枪棍"]=0,["暗器"]=0,
		["力道"]=0,["精纯"]=0,["身法"]=0,["根骨"]=0,
		["修为"]=0,
		["资质"]=0,
		["修炼物品"]=-1,
		["修炼点数"]=0,
		["武功"]={{1,900},},
		["携带物品"]={[0]=0,},
	},
	[8]={
		["代号"]=8,
		["头像代号"]=10,
		["战斗动作"]=1,
		["姓名"]='吴青烈',
		["性别"]=0,
		["等级"]=1,
		["经验"]=0,
		["生命"]=100,["生命最大值"]=100,
		["内力性质"]=2,["内力"]=100,["内力最大值"]=100,
		["体力"]=100,
		["武器"]=-1,["防具"]=-1,
		["内功"]=-1,["轻功"]=-1,["特技"]=-1,
		["医疗"]=0,["用毒"]=0,["解毒"]=0,["抗毒"]=0,
		["拳掌"]=0,["御剑"]=0,["耍刀"]=0,["枪棍"]=0,["暗器"]=0,
		["力道"]=0,["精纯"]=0,["身法"]=0,["根骨"]=0,
		["修为"]=0,
		["资质"]=0,
		["修炼物品"]=-1,
		["修炼点数"]=0,
		["武功"]={{1,900},},
		["携带物品"]={[0]=0,},
	},
	[9]={
		["代号"]=9,
		["头像代号"]=8,
		["战斗动作"]=1,
		["姓名"]='马青熊',
		["性别"]=0,
		["等级"]=1,
		["经验"]=0,
		["生命"]=100,["生命最大值"]=100,
		["内力性质"]=2,["内力"]=100,["内力最大值"]=100,
		["体力"]=100,
		["武器"]=-1,["防具"]=-1,
		["内功"]=-1,["轻功"]=-1,["特技"]=-1,
		["医疗"]=0,["用毒"]=0,["解毒"]=0,["抗毒"]=0,
		["拳掌"]=0,["御剑"]=0,["耍刀"]=0,["枪棍"]=0,["暗器"]=0,
		["力道"]=0,["精纯"]=0,["身法"]=0,["根骨"]=0,
		["修为"]=0,
		["资质"]=0,
		["修炼物品"]=-1,
		["修炼点数"]=0,
		["武功"]={{1,900},},
		["携带物品"]={[0]=0,},
	},
	[10]={
		["代号"]=10,
		["头像代号"]=7,
		["战斗动作"]=1,
		["姓名"]='钱青健',
		["性别"]=0,
		["等级"]=1,
		["经验"]=0,
		["生命"]=100,["生命最大值"]=100,
		["内力性质"]=2,["内力"]=100,["内力最大值"]=100,
		["体力"]=100,
		["武器"]=-1,["防具"]=-1,
		["内功"]=-1,["轻功"]=-1,["特技"]=-1,
		["医疗"]=0,["用毒"]=0,["解毒"]=0,["抗毒"]=0,
		["拳掌"]=0,["御剑"]=0,["耍刀"]=0,["枪棍"]=0,["暗器"]=0,
		["力道"]=0,["精纯"]=0,["身法"]=0,["根骨"]=0,
		["修为"]=0,
		["资质"]=0,
		["修炼物品"]=-1,
		["修炼点数"]=0,
		["武功"]={{1,900},},
		["携带物品"]={[0]=0,},
	},
	[11]={
		["代号"]=11,
		["头像代号"]=14,
		["战斗动作"]=1,
		["姓名"]='狄云',
	},
	[12]={
		["代号"]=12,
		["头像代号"]=2,
		["姓名"]='戚芳',
	},
	--[[
	[1]={
		["代号"]=,
		["头像代号"]=,
		["姓名"]='',
		["性别"]=,
		["等级"]=,
		["经验"]=,
		["生命"]=,
		["生命最大值"]=,
		["内力性质"]=,
		["内力"]=,
		["内力最大值"]=,
		["体力"]=,
		["武器"]=,
		["防具"]=,
		["内功"]=,
		["轻功"]=,
		["特技"]=,
		["出招动画帧数"]={0,0,0,0,0},
		["出招动画延迟"]={0,0,0,0,0},
		["出招音效延迟"]={0,0,0,0,0},
		["医疗"]=,
		["用毒"]=,
		["解毒"]=,
		["抗毒"]=,
		["拳掌"]=,
		["御剑"]=,
		["耍刀"]=,
		["枪棍"]=,
		["暗器"]=,
		["力道"]=,
		["精纯"]=,
		["身法"]=,
		["根骨"]=,
		["修为"]=,
		["资质"]=,
		["修炼物品"]=,
		["修炼点数"]=,
		["武功"]={},
		["携带物品"]={[0]=0,},
	},
	--]]
}

JY.Base["队伍2"]=4;
for i=1,320 do
	tablecopy(JY.Person[0],JY.Person[i]);
end