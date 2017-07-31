
local m = {}

m.settingUIKey = {
	
}

m.key = {
	activityImgList = "activityImgList",--{}
}

m.CustomEventKey = {
	Laba = "Laba",
	UpdateHeadInfo = "UpdateHeadInfo",
}


m.Chat = {
	Emoji_Tag_Start = 100,  --[101,102,...,199]
	CommonLanguage_Tag_Start = 200, --[201,202,...,299]
	comLanguage = {
	    "万水千山总是情，多输一点行不行！",
	    "麻将有首歌，上碰下自摸！",
	    "可以打快点没，瞌睡都出来噶！",
	    "这个牌都敢杠，小心着做老板呦！",
	    "死吧你，牌都摸不到!",
	    "今天高兴老火！",
	    "打的太好噶，你简直是我的偶像！",
	    "该出手时就出手，杠上开花有没有！",
	},
	emoji_num = {8,3,2,9,6,13,4,5,6,9,9,4,4,2,2},
	enoji_path_format = "res/srcRes/emoji/emoji_%d_%d.png"
}

return m -- g_enumKey