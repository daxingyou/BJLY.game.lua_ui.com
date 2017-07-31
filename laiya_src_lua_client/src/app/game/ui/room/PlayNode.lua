--[[
    --玩家操作页面
]]--
local Player = require("app.game.ui.room.Player")
local _filePlayNode = "loading/PlayNode.csb"
local PlayNode = class("PlayNode", function()
    local node = display.newNode()
    node:setNodeEventEnabled(true)
    return node
end)

local Http_Load_HEAD = "Http_Load_HEAD"

function PlayNode:ctor(_isVideo)
    self:initUI(_isVideo)

    if not _isVideo then
        self:regEvent()
    end
end

function PlayNode:onCleanup()
    self:unregEvent()
end

--注册事件
function PlayNode:regEvent()
    g_msg:reg("PlayNode", g_msgcmd.DB_UPDATE_PLAYER_INFO, handler(self, self.updatePlayer))--玩家加入
    g_msg:reg("PlayNode", g_msgcmd.DB_PLAY_GAME_START, handler(self, self.gameStart))    --游戏开始
    g_msg:reg("PlayNode", g_msgcmd.DB_PLAY_ADD_CARD, handler(self, self.addCard))    --发牌
    g_msg:reg("PlayNode", g_msgcmd.DB_PLAY_OUT_CARD, handler(self, self.discard))    --打牌成功
    g_msg:reg("PlayNode", g_msgcmd.DB_PLAY_OPERATE_Result, handler(self, self.operateResult))
    g_msg:reg("PlayNode", g_msgcmd.UI_Rest_Card_State, handler(self, self.restCard))
    g_msg:reg("PlayNode", g_msgcmd.UI_Setting_Change, handler(self, self.setting))
    g_msg:reg("PlayNode", g_msgcmd.UI_MinglouBroadcast, handler(self, self.onTingStatus))
    g_C2LuaSystem.regC2LuaFunc(g_C2LuaSystem.C2Lua_GvoiceUserStateChange ,handler(self,self.C2Lua_GvoiceUserStateChange))
end

function PlayNode:C2Lua_GvoiceUserStateChange( value )
    --解析出是谁的状态改变了
    local  memberid = value.memberID
    local member_status = value.status

    g_msg:post(g_msgcmd.UI_VOICE_State,{memberid = memberid,member_status =member_status})
end
--注销事件
function PlayNode:unregEvent()
    g_msg:unreg("PlayNode", g_msgcmd.DB_UPDATE_PLAYER_INFO)
    g_msg:unreg("PlayNode", g_msgcmd.DB_PLAY_GAME_START)
    g_msg:unreg("PlayNode", g_msgcmd.DB_PLAY_ADD_CARD)
    g_msg:unreg("PlayNode", g_msgcmd.DB_PLAY_OUT_CARD)
    g_msg:unreg("PlayNode", g_msgcmd.DB_PLAY_OPERATE_Result)
    g_msg:unreg("PlayNode", g_msgcmd.UI_ChatBroadcast)
    g_msg:unreg("PlayNode", g_msgcmd.UI_Rest_Card_State)
    g_msg:unreg("PlayNode", g_msgcmd.UI_Setting_Change)
    g_msg:unreg("PlayNode", g_msgcmd.UI_MinglouBroadcast)
    self:removeNodeEventListener(self.listener)
end

--初始化UI
function PlayNode:initUI(_isVideo)
    display.addSpriteFrames("card.plist","card.pvr.ccz")

    self.UserId = g_data.userSys.UserID

    self.cardNode = cc.Node:create()
    self.cardNode:addTo(self)
    CardFactory:setBaseNode(self.cardNode) 
    CardFactory:setTipsParent(self)

    self.mPlayNode = cc.uiloader:load(_filePlayNode)
    self.mPlayNode:addTo(self)

    self.playerInfo      = {}
    local tb_node        = {"PlayerBottomNode","PlayerRightNode","PlayerTopNode","PlayerLeftNode"}
    local tb_info        = {"PlayerInfoBottom","PlayerInfoRight","PlayerInfoTop","PlayerInfoLeft"}
    
    for i =1 ,4 do
        local node_name = tb_node[i]
        local info_name = tb_info[i]
        --用户信息分发
        self.playerInfo[i] = Player.new(self.mPlayNode:getChildByName(info_name),self.mPlayNode:getChildByName(node_name),_isVideo,self.mPlayNode,self)
        self.playerInfo[i]:setDirection(i)     ---相对座位号
    end
    
    --更新用户信息
    self:updatePlayer()
    if not _isVideo then
        self.playerInfo[1]:registerTouch()
        --操作层 --TODO 暂时放这里
        self.operateNode = require("app.game.ui.room.OperateNode").new(self)
        self.operateNode:addTo(self)
        self:updateReconnect()
    end

    self.m_Animation = require("app.game.ui.room.AnimationNode").new()
    self.m_Animation:addTo(self)
end

function PlayNode:updateReconnect()
    local isReconnect = g_data.roomSys.isReconnect
    if isReconnect == false then return end 

    local temp_Player = nil
    local reconnectInfo = g_data.roomSys.m_reconnectInfo
    local current_uid   = reconnectInfo.current_uid
    local player = self:getPlayerById(current_uid)
    if player then  player.canSendMessage = true end

    local my_info = g_data.roomSys:myInfo()
    --玩家大厅准备 或非准备 取消初始化
    if my_info.status == 5 or my_info.status == 6 then return end
    --5等待准备 6 准备

    --step_1  ------- 初始化手牌
    self.playerInfo[1]:initCards(reconnectInfo.hand_cards)

    local handcnt = reconnectInfo.hand_cnts
    for i =2 ,#handcnt do
        local cards = {}
        for j = 1,handcnt[i] do
            table.insert(cards,-1)
        end
        temp_Player = self:getReconnectInfo(i)
        temp_Player:initCards(cards)
    end

    --step_2  ------- 初始化玩家各种鸡牌信息 1 冲锋鸡, 2 责任鸡, 0表示没有
    local ji_types = reconnectInfo.ji_types
    for k,v in pairs(ji_types) do
        temp_Player = self:getReconnectInfo(k)
        if temp_Player.m_info ==nil then break end

        if     v == 1 then temp_Player.m_info.ChargeChicken = true --冲锋鸡
        elseif v == 2 then temp_Player.m_info.DutyChicken   = true  --责任鸡
        else 
            temp_Player.m_info.ChargeChicken = false 
            temp_Player.m_info.DutyChicken   = false
        end
    end  

    --step_3 ----初始化玩家打出去的牌
    local discards =nil
    for i = 1 ,4 do
        discards = reconnectInfo["dismiss_cards_"..i]
        if discards then
           temp_Player = self:getReconnectInfo(i)
            for k,v in pairs(discards) do
               temp_Player:discard_r(v)
            end
        end
    end

    local ji_cnts = reconnectInfo.ji_cnts  --鸡排也算打牌
    for k,v in pairs(ji_cnts) do
        temp_Player = self:getReconnectInfo(k)
        for j = 1,v do
            temp_Player:discard_r(CardDefine.cardValue.tiao1)
        end  
    end
    --是否冲锋鸡 责任鸡
    local ji_types = reconnectInfo.ji_types  --鸡排也算打牌
    for k,v in pairs(ji_types) do
        temp_Player = self:getReconnectInfo(k)

        if v == 1 then
            temp_Player.m_info.ChargeChicken = true
        end 
        if v == 2 then
             temp_Player.m_info.DutyChicken  = true
        end 
    end 

    --setp_4 -----玩家是否听牌
    local is_tingpais = reconnectInfo.is_tingpais
    for k,v in pairs(is_tingpais) do
        temp_Player = self:getReconnectInfo(k)
        if v == 1 then
            temp_Player:setReady({})
            temp_Player.m_infoNode:setTingTexture()
        end
    end

     --setp_5 -----玩家是否定缺
    local quemen = reconnectInfo.quemen
    if quemen then
        for i =1 ,#quemen do
            temp_Player = self:getReconnectInfo(i)
            if temp_Player.m_info then
                local qm = quemen[i]
                if qm == 0 then qm = -1 end 
                temp_Player.m_info.QueMen = qm
                -- temp_Player.m_infoNode:updateReconnect()
                -- temp_Player:checkDingQue() --TODO
            end
        end
    end

    --刷新头像信息
    for k,v in pairs(self.playerInfo) do
        if v.m_info ~=nil then
             v.m_infoNode:updateReconnect()
        end
    end
   
    --step_6 ----成型牌
    local weaves =nil
    for i = 1 ,4 do
        weaves = reconnectInfo["weaves"..i]
        if weaves then
           temp_Player = self:getReconnectInfo(i)
            for k,v in pairs(weaves) do
               temp_Player:chengXing(v.card_id,v.weave_kind)
            end
        end
    end
end

--获取断线重连的 玩家信息
function PlayNode:getReconnectInfo(idx)
    local whileCnt = idx
    local temp_Player = self.playerInfo[whileCnt]

    local t = type(temp_Player)
    assert(t == "table" , "ERROR, temp_Player not a table ")

    while temp_Player.m_info == nil and whileCnt < 5 do --防止死循环
        temp_Player = self.playerInfo[whileCnt]
        whileCnt = whileCnt + 1
    end
    return temp_Player
end

--4人房间
function PlayNode:directionTo4()
    --4人麻将
    local _max =4
    --调整游戏顺序
    self._maxPlayers = 4
    local info  = g_data.roomSys:myInfo()
    self.playerInfo[1]:setInfo(info)

    local baseChair = info.seatid - 1
    local others = g_data.roomSys:ohterPlaerInfo()
    local chairInit = {true, false, false, false}
    for k,v in pairs(others) do
      local ii = v.seatid 
      if ii <= baseChair then
        ii = v.seatid + _max
      end
      ii = ii - baseChair
      self.playerInfo[ii]:setInfo(v)
      self.playerInfo[ii]:show()
      chairInit[ii] = true
    end
    for i=1,4 do
      if not chairInit[i] then
        self.playerInfo[i]:hide()
      end
    end
end
---3人房间
function PlayNode:directionTo3()
    --调整游戏顺序
    local info  = g_data.roomSys:myInfo()
    self.playerInfo[1]:setInfo(info)
  
    self.playerInfo[2]:hide()
    self.playerInfo[3]:hide()
    self.playerInfo[4]:hide()

    local others = g_data.roomSys:ohterPlaerInfo()

    if info.seatid == 0 then
        for k,v in pairs(others) do
            if v.seatid == 1 then
                self.playerInfo[2]:setInfo(v)
                self.playerInfo[2]:show() 
            end
            if v.seatid == 2 then
                v.seatid = 3
                self.playerInfo[4]:setInfo(v)
                self.playerInfo[4]:show()
            end
        end
    end

    if info.seatid == 1 then
        for k,v in pairs(others) do
            if v.seatid == 0 then
                self.playerInfo[4]:setInfo(v)
                self.playerInfo[4]:show()
            end
            if v.seatid == 2 then
                self.playerInfo[2]:setInfo(v)
                self.playerInfo[2]:show()
            end
        end
    end
    if info.seatid == 2 then
        for k,v in pairs(others) do
            if v.seatid == 1 then
                self.playerInfo[4]:setInfo(v)
                self.playerInfo[4]:show()
            end
            if v.seatid == 0 then
                v.seatid =3
                self.playerInfo[2]:setInfo(v)
                self.playerInfo[2]:show()
            end
        end
    end
end
---2人房间
function PlayNode:directionTo2()
    self.playerInfo[2]:hide()
    self.playerInfo[3]:hide()
    self.playerInfo[4]:hide()

    local info  = g_data.roomSys:myInfo()
    if info.seatid == 1 then
        info.seatid = 2
    end
    self.playerInfo[1]:setInfo(info)

    local others = g_data.roomSys:ohterPlaerInfo()
    for k,v in pairs(others) do
      if v.seatid == 1 then
        v.seatid = 2
      end
      self.playerInfo[3]:setInfo(v)  ---测试左边排序
      self.playerInfo[3]:show()
    end
end

--调整相对位置
function PlayNode:updatePlayer()
    local  fn = self[RoomDefine.Direction[g_data.roomSys.PlayRule]]
    fn(self)
end

--摸排
function PlayNode:addCard( _msg )
    local uid    = _msg.data.uid
    local player = self:getPlayerById(uid)
    if player then
        player:addCard(_msg.data.card)
    end
end

--打牌成功
function PlayNode:discard(_msg)
    local dt        = _msg.data
    local uid       = dt.uid
    local cardEnum  = dt.cardEnum
    local chargeChickenType = _msg.data.chargeChickenType
    local player = self:getPlayerById(uid)
    player:discard_Success(cardEnum,chargeChickenType)
end

function PlayNode:getPlayerById(_id)
    local info =nil
    for k,v in pairs(self.playerInfo) do
      if v.uid == _id then
        info = v
        break
      end
    end
    return info
end

--根据作为好获取玩家信息
function PlayNode:getPlayerBySeatId(_seatid)
    local info =nil
    for k,v in pairs(self.playerInfo) do
      if v.seatid == _seatid then
        info = v
        break
      end
    end
    return info
end

--游戏开始
function PlayNode:gameStart()
  --初始化玩家手牌
    for i=1,4 do
      self.playerInfo[i]:initCards()
    end
    self:endShowHu()
    CardFactory:flagHide()
end
--碰牌
function PlayNode:pong( _uid,_puid,_cardEnum,_code,_DutyChicken)
    local player_oper     = self:getPlayerById(_uid)
    local player_provider = self:getPlayerById(_puid)
    player_oper:peng(_cardEnum,_code,_DutyChicken)
    player_provider:removeDisCard(_cardEnum)

    --责任鸡
    if _DutyChicken == 1 then
        g_data.roomSys:setDutyChicken(player_provider.m_info,true)
    end
    CardFactory:flagHide()
end

--杠
function PlayNode:kong( _uid,_puid,_cardEnum ,_code,_DutyChicken)
    local player_oper     = self:getPlayerById(_uid)
    local player_provider = self:getPlayerById(_puid)
    player_oper:kong(_cardEnum,_code,_DutyChicken)
    player_provider:removeDisCard(_cardEnum)
    --被刚走 取消冲锋鸡    
    if _DutyChicken == 2 then
        if player_provider.m_info.ChargeChicken then
            g_data.roomSys:setChargeChicken(player_provider.m_info,false)
        end
    end
    self.playerInfo[1]:setAutoStatus(true)
end

--胡
function PlayNode:hu( _uid,_puid,_cardEnum ,_huType,_kongType)
    --特殊处理
end

function PlayNode:showHu()
     for k,v in pairs(self.playerInfo) do
        v:showHu()
    end
end

function PlayNode:endShowHu()
     for k,v in pairs(self.playerInfo) do
        v:endShowHu()
    end
end

--操作结果
function PlayNode:operateResult(_msg)
    local op           = _msg.data.op
    local _uid         = op.operate_uid  --主碰
    local _puid        = op.provide_uid  --被碰
    local _code        = op.operate_code --(1碰，2左杠，3右杠，4对门杠，5补杠，6暗杠，7听，8胡，9左碰，10中碰，11右碰)
    local _cardEnum    = op.operate_cardid
    local _dutyChicken = op.is_zerenji   --碰杠中是否有责任鸡   0 不是鸡，1责任鸡，2普通鸡
    local _huType      = op.hu_type      -- 胡类型(1平胡， 2大对子， 3七对， 4龙七对， 5清一色， 6清七对， 7清大对， 8青龙背)  
    local _kongType    = op.gang_type    --杠类型（1杠上花， 2杠上炮， 3枪杠胡)
    local _player      = self:getPlayerById(_uid)
    local _isZimo     = false
    local  fn          = self[OperateType.Functions[_code]]
    if fn then
        if _code == OperateType.Hu then
            local _hu = _huType
            if _uid == _puid then
                _isZimo = true
            end 
        else
            fn(self,_uid,_puid,_cardEnum,_code,_dutyChicken)
        end 
    end
    if _dutyChicken ~= 1 then
        self.m_Animation:play(_uid,_code,_huType,_kongType,_isZimo,_puid)
    end
end

function PlayNode:operate(_msg)
    self.playerInfo[1]:setAutoStatus(false)
end

--服务器延迟 重新打牌
function PlayNode:restCard()
    -- self.playerInfo[1]:run_m_Fn()
    self.playerInfo[1]:canDiscard()
end

function PlayNode:setting( )
    for i=1,4 do
      self.playerInfo[i]:card_setting()
    end
end

function PlayNode:onTingStatus( _msg )
    local _uid  = _msg.data.uid
   
    self.m_Animation:playTing(_uid)
 
end

return PlayNode