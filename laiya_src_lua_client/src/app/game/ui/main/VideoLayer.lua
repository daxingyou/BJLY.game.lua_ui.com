--[[
  录像
]]
local TableDesk = require("app.game.ui.room.TableDesk")
local VideoLayer = class(" VideoLayer", function()
    local node = require("app.common.ui.UILockLayer").new()
    node:setNodeEventEnabled(true)
    return node
end)

function  VideoLayer:ctor(_Detail)
    printTable("_Detail ==",_Detail)
    self.detail = _Detail
    self:initUI()

    g_data.roomSys:updateUIState(RoomDefine.UI_State.Video)
end

function  VideoLayer:onCleanup()
    g_data.roomSys:updateUIState(RoomDefine.UI_State.NULL)
end

function  VideoLayer:regEvent()
end

function  VideoLayer:unregEvent()
end


function  VideoLayer:initUI()
    --添加背景
    --桌面层
    self.m_TabelDesk = TableDesk.new()
    self.m_TabelDesk:addTo(self)

    self.current = 1
    self.speed = 1
    self.speedX = 1

    self:initRoomInfo()

    --房间信息
    local _isVideo = true
    self.m_roomInfoNode = require("app.game.ui.room.RoomInfoNode").new(_isVideo)
    self.m_roomInfoNode:addTo(self)
    --初始化牌局
    self.playNode = require("app.game.ui.room.PlayNode").new(_isVideo)
    self.playNode:addTo(self)

    self.m_roomInfoNode:setDirection()
    self:updateRound()

    self.m_roomInfoNode:setVideoCallback(handler(self, self.onVideoButtonClick))
    
    self.m_SpeedLabel = cc.ui.UILabel.new({
            UILabelType = 2, text = "speed: x1", size = 32})
        :align(display.CENTER, 180, display.top-80)
        :addTo(self)
end

function VideoLayer:onEnter()
end

function VideoLayer:onExit()
end


function VideoLayer:initRoomInfo()
 
    local tb = {}
    local temp_info =nil
    for i =1 ,#self.detail.UserDetail do
        temp_info = self.detail.UserDetail[i]
        tb[i] = {}
        tb[i].weichat_nick         = temp_info.Nick
        tb[i].QueMen               = temp_info.QueMen
        tb[i].seatid               = temp_info.SeatID
        tb[i].weichat_face_address = temp_info.Face
        tb[i].gold                 = temp_info.gold
        tb[i].uid                  = temp_info.UserID
    end
    local BankerUid = self.detail.BankerUid

    local rd = self.detail.RoundDetail
    self.roundTable = {}
    for i =1 ,#rd do
        self.roundTable[i] = rd[i]
        
    end
    g_data.roomSys:joinTable(BankerUid,tb)
end

function VideoLayer:getRound(idx)
    local tb = self.roundTable[idx]
    if tb ==nil then return -1 end
    local round = {}
    round.ActionKind  = tb.ActionKind
    round.ActionUser  = tb.ActionUser
    round.ProvideUser = tb.ProvideUser
    if round.ActionKind == 1 then  --发牌
        round.cards ={}
        for i =0,tb.CardLen do
            local card = tb[tostring(i)]
            table.insert(round.cards,card)
        end
    else
        round.card = tb["0"]
    end
    return round
end

-- self.m_buttonBack   = self.VideNode:getChildByName("Button_back")
-- self.m_buttonBefor  = self.VideNode:getChildByName("Button_befor")
-- self.m_buttonNext   = self.VideNode:getChildByName("Button_next")
-- self.m_buttonPause  = self.VideNode:getChildByName("Button_pause")
function VideoLayer:onVideoButtonClick( _sender)
    local _name = _sender:getName()
    if _name == "Button_back" then
        g_data.roomSys:updateUIState(RoomDefine.UI_State.NULL)
        g_SMG:removeLayer()
    end
    if _name == "Button_next" then
        self.speed = self.speed-0.5
        if self.speed <0.5 then
            self.speed =0.5
        else
            self.speedX = self.speedX +1  
        end
        self.m_SpeedLabel:setString("speed: x".. self.speedX)
        self:stopRound()
        self:updateRound()
    end
    if _name == "Button_befor" then
       
        self.speedX =  self.speedX -1
        if self.speedX <1 then
            self.speedX =1
        else
            self.speed = self.speed + 0.5
        end
        self.m_SpeedLabel:setString("speed: x".. self.speedX)
        self:stopRound()
        self:updateRound()
    end
    if _name == "Button_pause" then
        if self.m_RoundSchedule == nil then
            self:updateRound()
        else
           self:stopRound() 
        end 
    end
end


-- HISTORY_ACTION_NULL             =       0
-- HISTORY_ACTION_START            =       1
-- HISTORY_ACTION_TING             =       2
-- HISTORY_ACTION_OUT              =       3
-- HISTORY_ACTION_DISPATCH         =       4
-- HISTORY_ACTION_PENG             =       5
-- HISTORY_ACTION_LET_GANG          =      6
-- HISTORY_ACTION_CENTER_GANG       =      7
-- HISTORY_ACTION_RIGHT_GANG        =      8
-- HISTORY_ACTION_BUGANG           =       9
-- HISTORY_ACTION_MENGANG           =      10
-- HISTORY_ACTION_HU               =       11
-- HISTORY_ACTION_LEFT_PENG        =       12
-- HISTORY_ACTION_CENTER_PENG       =      13
-- HISTORY_ACTION_RIGHT_PENG       =       14

-- OperateType.pong            = 1 --碰
-- OperateType.Left_kong       = 2--左杠
-- OperateType.Right_kong      = 3
-- OperateType.Mid_kong        = 4
-- OperateType.Fill_kong       = 5--补杠
-- OperateType.Self_kong       = 6--暗杠
-- OperateType.Ready           = 7--听
-- OperateType.Hu              = 8--胡
-- OperateType.Left_pong       = 9 --左碰
-- OperateType.Mid_pong        = 10 --中碰
-- OperateType.Right_pong      = 11 
-- OperateType.ChargeChicken   = 12 --冲锋鸡
-- OperateType.DutyChicken     = 13 --责任鸡
local op = {
    [5]  = OperateType.pong,
    [6]  = OperateType.Left_kong,
    [7]  = OperateType.Mid_kong ,
    [8]  = OperateType.Right_kong ,
    [9]  = OperateType.Fill_kong ,
    [10] = OperateType.Self_kong ,
    [11] = OperateType.Hu ,
    [12] = OperateType.Left_pong ,
    [13] = OperateType.Mid_pong,
    [14] = OperateType.Right_pong ,
}

function VideoLayer:nextRound()
    print("self.current =",self.current,"#self.roundTable =",#self.roundTable) 
    if self.current > #self.roundTable then
       self:stopRound()
    end 
    local round = self:getRound(self.current)

    printTable("round == ",round)
    if round == -1 then return end
    local temp_player = self:getPlayerById( round.ActionUser )

    if round.ActionKind == 1 then --发牌
        temp_player:initCards(round.cards)
    end

    if round.ActionKind == 3 then --打牌
        temp_player:discard_Success(round.card)
    end

    if round.ActionKind == 4 then --摸排
        temp_player = self:getPlayerById( round.ActionUser )
        temp_player:addCard(round.card)
    end

    if round.ActionKind == 5 or round.ActionKind == 12 or round.ActionKind == 13 or round.ActionKind == 14 then --pong
        local code  = op[round.ActionKind]
        self.playNode:pong(round.ActionUser,round.ProvideUser,round.card,code)
        self.playNode.m_Animation:play(temp_player.uid,code)
    end

    if round.ActionKind == 6 or round.ActionKind == 7 or round.ActionKind == 8 or round.ActionKind == 9  or round.ActionKind == 10 then --pong
        local code  = op[round.ActionKind]
        self.playNode:kong(round.ActionUser,round.ProvideUser,round.card,code)
        self.playNode.m_Animation:play(temp_player.uid,code)
    end

    if round.ActionKind == 11 then --pong
        local code  = op[round.ActionKind]
        if round.card then
            temp_player:addCard(round.card)
        end
        self.playNode.m_Animation:play(temp_player.uid,code,1)
    end
end

function VideoLayer:getPlayerById( _id )
    return self.playNode:getPlayerById(_id)
end

--头像更新计时器，直到更新到头像后停止
function VideoLayer:updateRound()
    if self.m_RoundSchedule == nil then
        self.m_RoundSchedule = self:schedule(function() 
            self:nextRound() 
            self.current =  self.current + 1
            end, self.speed)
    end
end

function VideoLayer:stopRound()
  if self.m_RoundSchedule ~= nil then
        self:stopAction(self.m_RoundSchedule)
        self.m_RoundSchedule = nil
  end
end
return  VideoLayer
