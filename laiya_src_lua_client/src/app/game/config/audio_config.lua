--
-- 音效及音乐配置 , 音乐音效文件在此配置
-- g_audio.playSoud("Button")  ,
--

local audio_config  = {}
--音乐
audio_config.music = {
	["dlyy"] = "sound/dlyy.mp3", --背景音乐1
	["yxyy"] = "sound/yxyy.mp3", --背景音乐2
}

--音效
audio_config.sound = {
	["alarm"] = "sound/alarm.mp3", --背景音乐2
	["tiletouch"] = "sound/tiletouch.mp3", --背景音乐2
	["tiletake"] = "sound/tiletake.mp3", --背景音乐2
}

--按钮特殊声音列表（设置为空字符表示不播放音效)
audio_config.btnlist = {
 
}


audio_config.card = {
	[CardDefine.cardValue.w1]    = {"sound/wan1_man_d.mp3",  "sound/wan1_woman_d.mp3"},
	[CardDefine.cardValue.w2]    = {"sound/wan2_man_d.mp3",  "sound/wan2_woman_d.mp3"},
	[CardDefine.cardValue.w3]    = {"sound/wan3_man_d.mp3",  "sound/wan3_woman_d.mp3"},
	[CardDefine.cardValue.w4]    = {"sound/wan4_man_d.mp3",  "sound/wan4_woman_d.mp3"},
	[CardDefine.cardValue.w5]    = {"sound/wan5_man_d.mp3",  "sound/wan5_woman_d.mp3"},
	[CardDefine.cardValue.w6]    = {"sound/wan6_man_d.mp3",  "sound/wan6_woman_d.mp3"},
	[CardDefine.cardValue.w7]    = {"sound/wan7_man_d.mp3",  "sound/wan7_woman_d.mp3"},
	[CardDefine.cardValue.w8]    = {"sound/wan8_man_d.mp3",  "sound/wan8_woman_d.mp3"},
	[CardDefine.cardValue.w9]    = {"sound/wan9_man_d.mp3",  "sound/wan9_woman_d.mp3"},
	[CardDefine.cardValue.tiao1] = {"sound/tiao1_man_d.mp3", "sound/tiao1_woman_d.mp3"},
	[CardDefine.cardValue.tiao2] = {"sound/tiao2_man_d.mp3", "sound/tiao2_woman_d.mp3"},
	[CardDefine.cardValue.tiao3] = {"sound/tiao3_man_d.mp3", "sound/tiao3_woman_d.mp3"},
	[CardDefine.cardValue.tiao4] = {"sound/tiao4_man_d.mp3", "sound/tiao4_woman_d.mp3"},
	[CardDefine.cardValue.tiao5] = {"sound/tiao5_man_d.mp3", "sound/tiao5_woman_d.mp3"},
	[CardDefine.cardValue.tiao6] = {"sound/tiao6_man_d.mp3", "sound/tiao6_woman_d.mp3"},
	[CardDefine.cardValue.tiao7] = {"sound/tiao7_man_d.mp3", "sound/tiao7_woman_d.mp3"},
	[CardDefine.cardValue.tiao8] = {"sound/tiao8_man_d.mp3", "sound/tiao8_woman_d.mp3"},
	[CardDefine.cardValue.tiao9] = {"sound/tiao9_man_d.mp3", "sound/tiao9_woman_d.mp3"},
	[CardDefine.cardValue.tong1] = {"sound/tong1_man_d.mp3", "sound/tong1_woman_d.mp3"},
	[CardDefine.cardValue.tong2] = {"sound/tong2_man_d.mp3", "sound/tong2_woman_d.mp3"},
	[CardDefine.cardValue.tong3] = {"sound/tong3_man_d.mp3", "sound/tong3_woman_d.mp3"},
	[CardDefine.cardValue.tong4] = {"sound/tong4_man_d.mp3", "sound/tong4_woman_d.mp3"},
	[CardDefine.cardValue.tong5] = {"sound/tong5_man_d.mp3", "sound/tong5_woman_d.mp3"},
	[CardDefine.cardValue.tong6] = {"sound/tong6_man_d.mp3", "sound/tong6_woman_d.mp3"},
	[CardDefine.cardValue.tong7] = {"sound/tong7_man_d.mp3", "sound/tong7_woman_d.mp3"},
	[CardDefine.cardValue.tong8] = {"sound/tong8_man_d.mp3", "sound/tong8_woman_d.mp3"},
	[CardDefine.cardValue.tong9] = {"sound/tong9_man_d.mp3", "sound/tong9_woman_d.mp3"}	
}

audio_config.operate = {
	[OperateType.Left_kong]    = {"sound/man_minggang.mp3",  "sound/woman_minggang.mp3"},
	[OperateType.Right_kong]   = {"sound/man_minggang.mp3",  "sound/woman_minggang.mp3"},
	[OperateType.Mid_kong]     = {"sound/man_minggang.mp3",  "sound/woman_minggang.mp3"},
	[OperateType.Fill_kong]    = {"sound/man_bugang.mp3",  "sound/woman_bugang.mp3"},
	[OperateType.Self_kong]    = {"sound/man_angang.mp3",  "sound/woman_angang.mp3"},
	[OperateType.Ready]        = {"sound/man_tianting.mp3",  "sound/woman_tianting.mp3"},
	[OperateType.Hu]    	   = {"sound/man_hupai.mp3",  "sound/woman_hupai.mp3"},
	[OperateType.pong]         = {"sound/man_peng.mp3",  "sound/woman_peng.mp3"},
	[OperateType.Left_pong]    = {"sound/man_peng.mp3",  "sound/woman_peng.mp3"},
	[OperateType.Mid_pong]     = {"sound/man_peng.mp3", "sound/woman_peng.mp3"},
	[OperateType.Right_pong]   = {"sound/man_peng.mp3", "sound/woman_peng.mp3"},


	[OperateType.ChargeChicken]= {"sound/man_chongfengji.mp3", "sound/woman_chongfengji.mp3"},
	[OperateType.Hu_DianPao]   = {"sound/man_dianpao.mp3", "sound/woman_dianpao.mp3"},
	[OperateType.DutyChicken]  = {"sound/man_zerenji.mp3", "sound/woman_zerenji.mp3"},
	[OperateType.Kong_TYPE_2]  = {"sound/man_repao.mp3", "sound/woman_repao.mp3"},
	[OperateType.Kong_TYPE_1]  = {"sound/man_gangkai.mp3", "sound/woman_gangkai.mp3"},
	[OperateType.Kong_TYPE_3]  = {"sound/man_qianggang.mp3", "sound/woman_qianggang.mp3"},

	[OperateType.Hu_TYPE_9]    = {"sound/man_zimo.mp3", "sound/woman_zimo.mp3"},

	[OperateType.Hu_TYPE_1]    = {"sound/man_hupai.mp3",   "sound/woman_hupai.mp3"},
	[OperateType.Hu_TYPE_2]    = {"sound/man_hupai.mp3",   "sound/woman_hupai.mp3"},
	[OperateType.Hu_TYPE_3]    = {"sound/man_hupai.mp3",   "sound/woman_hupai.mp3"},
	[OperateType.Hu_TYPE_4]    = {"sound/man_hupai.mp3",   "sound/woman_hupai.mp3"},
	[OperateType.Hu_TYPE_5]    = {"sound/man_hupai.mp3",   "sound/woman_hupai.mp3"},
	[OperateType.Hu_TYPE_6]    = {"sound/man_hupai.mp3",   "sound/woman_hupai.mp3"},
	[OperateType.Hu_TYPE_7]    = {"sound/man_hupai.mp3",   "sound/woman_hupai.mp3"},
	[OperateType.Hu_TYPE_8]    = {"sound/man_hupai.mp3",   "sound/woman_hupai.mp3"},
	[OperateType.Hu_DianPao]    = {"sound/man_dianpao.mp3","sound/woman_dianpao.mp3"},

}

-- OperateType.Hu_DianPao      = 109--点炮
-- OperateType.ChargeChicken 	= 12 --冲锋鸡
-- OperateType.DutyChicken 	= 13 --责任鸡
-- OperateType.Hu_TYPE_1       = 101--胡
-- OperateType.Hu_TYPE_2       = 102--大对子
-- OperateType.Hu_TYPE_3       = 103--七小对
-- OperateType.Hu_TYPE_4       = 104--龙七对
-- OperateType.Hu_TYPE_5       = 105--清一色
-- OperateType.Hu_TYPE_6       = 106--清七对
-- OperateType.Hu_TYPE_7       = 107--清大对
-- OperateType.Hu_TYPE_8       = 108--青龙背

-- OperateType.Kong_TYPE_1     = 201--杠上开花
-- OperateType.Kong_TYPE_2     = 202--热炮
-- OperateType.Kong_TYPE_3     = 203--抢杠胡
return audio_config
