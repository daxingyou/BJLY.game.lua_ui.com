--
-- 房间信息系统，用户进入房间后，各玩家信息的管理,本地用户的数据也在房间中进行广播，比如金典版本中的total win数据。
--
--

local RoomSys = class("RoomSys")

local PLAYER_MAX = 4 --房间其他玩家最大数

function RoomSys:ctor()
	self:initData()
end

function RoomSys:initData()
	self.m_roomInfo = {} --房间信息 ReplaceTable:是否是代开的房间
	self.m_roomPlayers = {} --房间其他玩家
	self.isReconnect = false  -- 是否为断线重连
	self.m_reconnectInfo = {}
	self.m_status = 0 --0是游戏未开始
	self.m_HeartBeatCount = 0 --心跳次数
end

--进入房间
function RoomSys:joinTable(_banker_uid,infos)
	self.banker_uid = _banker_uid
	self:updateAllPlayers(infos)
	g_msg:post(g_msgcmd.DB_UPDATE_PLAYER_INFO)-- -- 用户数据变化
end

--正在玩牌的状态
function RoomSys:updateUIState(_state)
	self.UI_State = _state
	if self.UI_State == RoomDefine.UI_State.NULL then
		g_data.roomSys:exitRoom()
	end
end

--退出房间
function RoomSys:exitRoom()
	self:initData()
end

--获取房间其他玩家列表
function RoomSys:getRoomPlayers()
	return self.m_roomPlayers
end

--获取房间其他玩家数量
function RoomSys:getRoomPlayerNum()
	return #self.m_roomPlayers
end

--更新房间信息
function RoomSys:updateRoomInfo(_dt)
-- "_msg" = {
-- 	"banker_uid" = 100169
-- 	"errorcode"  = 0
-- 	"gold_now"   = 1000
-- 	"hand_cards" = {
-- 	1  = 2
-- 	}
-- 	"left_cnt"   = 82
-- 	"left_round" = 3
--  }
	if not _dt then return end

	for k,v in pairs(_dt) do
		self.m_roomInfo[k] = v
	end
	
	self.left_cnt = _dt.left_cnt
	self.left_round = _dt.left_round
	self.banker_uid = _dt.banker_uid

	local info = self:myInfo()
	info.cards = _dt.hand_cards

	g_msg:post(g_msgcmd.UI_Banker_Change)-- 庄家改变

end
function RoomSys:updateGameRule(tb)
	self.roomId     = tb["roomId"]
	self.isMenGang  = tb["IsMenGangMulti2"]
	self.RoundLimit = tb["RoundLimit"]
	self.PlayRule   = tb["PlayRule"]
	-- self.Owner      = tb.Owner
end

--更新其他所有玩家
function RoomSys:updateAllPlayers(_data)
	if not _data then return end
	for i,v in ipairs(_data) do

		self:addPlayer(v)
	end
end

-- 更新用户信息 _infoType (2退出玩家,0更新玩家,1新增玩家)
function RoomSys:updatePlyerInfo(_data)
	local userID = _data.uid
	local info,pos = self:getPlayerInfo(userID)
	--新加入
	if not info then
		info = {}
		info.jncnt_ok = false
		info.ChargeChicken =false --是否冲锋鸡
		info.DutyChicken   =false --是否责任鸡
		info.QueMen = -1
		info.cards  = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}
		info.score = 1000
		info.isTingPai = false
        
		table.insert(self.m_roomPlayers, info)
	end
	--拷贝新数据
	for k,v in pairs(_data) do
		info[k] = v
	end
	--更正无性别
	if info.sex == 1 then
    else
      	info.sex = 2
    end
end

--每一局清空玩家信息
function RoomSys:onCleanRound(_uid)
	local info,pos = self:getPlayerInfo(_uid)
	if info then
		info.ChargeChicken = false --是否冲锋鸡
		info.DutyChicken   = false --是否责任鸡
		info.QueMen = -1
		info.cards  = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1}
		info.isTingPai = false
	end
end

--TODO暂时 冲锋鸡
function RoomSys:setChargeChicken(_info,is)
	_info.ChargeChicken = is
	g_msg:post(g_msgcmd.UI_Chicken_Change,{uid = _info.uid})
end


--TODO暂时 责任鸡
function RoomSys:setDutyChicken(_info,is)
	_info.ChargeChicken = false
	_info.DutyChicken   = is
	g_msg:post(g_msgcmd.UI_Chicken_Change,{uid = _info.uid})
end

--玩家加入
function RoomSys:addPlayer(_player)
	self:updatePlyerInfo(_player)
end

--玩家退出
function RoomSys:removePlayer(_data)

	local _playerID = _data.uid
	local info,pos = self:getPlayerInfo(_playerID)
	if info then
		table.remove(self.m_roomPlayers, pos)
	end
	g_msg:post(g_msgcmd.DB_UPDATE_PLAYER_INFO) -- 用户数据变化
end

--更新玩家信息
function RoomSys:updatePlayer(_plyaer)
	self:updatePlyerInfo(_player)

end

--根据用户ID得到用户的信息,第2个返回值表示在数组中的索引位置
function RoomSys:getPlayerInfo(_userID)
	for i,v in pairs(self.m_roomPlayers) do
		if _userID==v.uid then
			return v,i
		end
	end
	return nil,-1
end

--获取玩家自己信息
function RoomSys:myInfo()
	return self:getPlayerInfo(g_data.userSys.UserID)
end

--获取其他玩家
function RoomSys:ohterPlaerInfo()
	local tb = {}
	for i,v in pairs(self.m_roomPlayers) do
		if g_data.userSys.UserID ~=v.uid then
			table.insert(tb,v)
		end
	end
	return tb
end

function RoomSys:updateQingQueInfo(dt) 
	local info  = self:getPlayerInfo(dt.uid)
	if info then
		info.QueMen = dt.QueMen
		g_msg:post(g_msgcmd.UI_DingQue_Success,{uid = info.uid})
	end
end

function RoomSys:updateLeft_cnt(_left_cnt)
	self.left_cnt = _left_cnt
	g_msg:post(g_msgcmd.DB_Left_CNT,{left_cnt=_left_cnt})
end

--断线重连数据
function RoomSys:updateReconnect(_dt)
	self.isReconnect = false
	if _dt.reconnect == nil then return end
	self.isReconnect = true
	self.m_reconnectInfo = {}
	for k,v in pairs(_dt.reconnect) do
		self.m_reconnectInfo[k] = v
	end
	self.left_round = self.m_reconnectInfo.left_round
end

-- 更新分数
-- total_gold  = 982
-- uid        = 100133
function RoomSys:updateRoundScore(_dt)
	for i,v in pairs(_dt) do
		local temp = self:getPlayerInfo(v.uid)
		temp.score = v.total_gold
	end
	g_msg:post(g_msgcmd.UI_ROUND_SCORE_State)
end

 -- "_msg" = {
  --     "errorcode" = 0
  --     "ju_draw"   = 0
  --     "ju_lose"   = 47
  --     "ju_win"    = 17
  --     "uid"       = 100133
  -- }
function RoomSys:updateJuCnt( _dt )
	local info  = self:getPlayerInfo(_dt.uid)
	for k,v in pairs(_dt) do
		info[k] = v
	end
	info.jncnt_ok = true
	g_SMG:addLayerByName(g_UILayer.Main.UISelfInfo.new({},_dt.uid))
end


function RoomSys:updateStatus(_status)
	self.m_status = _status
	if self.m_status == RoomDefine.Status.Wait then

	elseif self.m_status == RoomDefine.Status.Doing then

	elseif self.m_status == RoomDefine.Status.End then	
		g_netMgr:close()
	end

end
return RoomSys
