--[[
    --玩家操作页面 吃 碰 杠 胡
    --只对玩家自己操作
]]--

local _file = "loading/OperateNode.csb"
local OperateNode = class("OperateNode", function()
    local node = require("app.common.ui.UILockLayer").new()
    node:setNodeEventEnabled(true)
    return node
end)

function OperateNode:ctor(_playNode)
    self.m_PlayNode = _playNode
    self.m_Player   = self.m_PlayNode.playerInfo[1]
    self:initUI()
    
    self:unlock()
    self.m_detailNode = self.m_PlayNode.playerInfo[1].cardNode:getChildByName("node_detail_actions")
    self.detail = {}
    self.detail[1] = self.m_detailNode:getChildByName("Button_action_arr_1")
    self.detail[2] = self.m_detailNode:getChildByName("Button_action_arr_2")
    self.detail[3] = self.m_detailNode:getChildByName("Button_action_arr_3")

    g_utils.setButtonClick(self.detail[1],handler(self,self.onKongClick))
    g_utils.setButtonClick(self.detail[2],handler(self,self.onKongClick))
    g_utils.setButtonClick(self.detail[3],handler(self,self.onKongClick))

    self:regEvent()
end

function OperateNode:onEnter()
end

function OperateNode:onExit()
end

function OperateNode:onCleanup()
    self:unregEvent()
end

--注册事件
function OperateNode:regEvent()
      --玩家加入
    g_msg:reg("OperateNode", g_msgcmd.DB_PLAY_OPERATE_ASK, handler(self, self.operate))
    g_msg:reg("OperateNode", g_msgcmd.DB_PLAY_OPERATE_Result, handler(self, self.finish))
    g_msg:reg("OperateNode", g_msgcmd.DB_PLAY_OPERATE_Pass, handler(self, self.finish))
    g_msg:reg("OperateNode", g_msgcmd.UI_MinglouAsk, handler(self, self.onMingLou))
    g_msg:reg("OperateNode", g_msgcmd.DB_PLAY_GAME_START, handler(self, self.gameStart))    --游戏开始
end

--注销事件
function OperateNode:unregEvent()
    g_msg:unreg("OperateNode", g_msgcmd.DB_PLAY_OPERATE_ASK)
    g_msg:unreg("OperateNode", g_msgcmd.DB_PLAY_OPERATE_Result)
    g_msg:unreg("OperateNode", g_msgcmd.UI_MinglouAsk)
    g_msg:unreg("OperateNode", g_msgcmd.DB_PLAY_OPERATE_Pass)
    g_msg:unreg("OperateNode", g_msgcmd.DB_PLAY_GAME_START)
end
--操作
-- resume_uid //点击“过”之后，需要找到的焦点用户
-- action_card    //牌
-- actions   //动作数组(0无动作，1左吃（吃的牌在左边），2中吃，3右吃，4碰，5杠，6明搂，7胡)
-- gang_cards
function OperateNode:operate(_msg)
    local op= _msg.data.op

    local actions = op.actions

    self.m_Player:un_m_Fn()--控制自动打牌

    if actions[1] == 0 then
        self.m_Player.opActionOK = true
        if self.m_Player.addCardOK then
            self.m_Player:canDiscard()
            self.m_Player.addCardOK = false
            self.m_Player.opActionOK = false
        end   
        return
    end
   
    self.action_card = op.action_card
    local resume_uid =  op.resume_uid
    self.gang_cards =  op.gang_cards

    self:addButton(CardDefine.operateType.Pass)
    for k,v in pairs(actions) do
         self:addButton(v)
    end
    self:setCardEnabled(false,nil,true)
    --如果听牌状态下 停止打牌
    self.m_PlayNode.playerInfo[1]:setAutoStatus(false)
end


function OperateNode:initUI()
    self.buttons ={}
    local  _UI = cc.uiloader:load(_file)
    _UI:addTo(self)
    local actions =  _UI:getChildByName("node_actions")
    local tb_btn        = {"Button_Hu","Button_Pong","Button_Kong","Button_Ready","Button_Pass"}
    for k,v in pairs(tb_btn) do
        self[v] = actions:getChildByName(v)
        self[v]:setVisible(false)
         g_utils.setButtonClick(self[v],handler(self,self.onOperateClick))
    end
end

function OperateNode:addButton(_type)
    print("CardDef. bb")
    local button = nil
    if _type == CardDefine.operateType.Pass then
        button = self.Button_Pass
    elseif _type == CardDefine.operateType.Kong then
        button = self.Button_Kong
    elseif _type == CardDefine.operateType.Pong then
        button = self.Button_Pong
    elseif _type == CardDefine.operateType.Hu then
        button = self.Button_Hu
    elseif _type == CardDefine.operateType.Ready then
        button = self.Button_Ready
    end
    button:setVisible(true)
    for i=1,#self.buttons do
        if self.buttons[i] == button then
            return
        end
    end
    self.buttons[#self.buttons+1] = button

    -- 这个坐标是按钮的右侧
    -- 每排完一个减去自身的宽度，等待下一个按钮的设置
    local x = 800/960*display.width
    local y = 200
    for i=1,#self.buttons do
        local size = self.buttons[i]:getContentSize()
        self.buttons[i]:setPosition(cc.p(x-size.width/2, y))
        x = x - size.width
    end
end

function OperateNode:onOperateClick( _btn )
    local op = _btn:getName()
    if op == 'Button_Hu' then 
        -- CardDefine.operateType.Hu  --不知道为啥是7
         g_netMgr:send(g_netcmd.MSG_OPERATE, { operate_code = 7 ,  operate_cardid =  self.action_card} , 0)
    elseif op == "Button_Pong" then
        g_netMgr:send(g_netcmd.MSG_OPERATE, { 
            operate_code = CardDefine.operateType.Pong ,  
            operate_cardid =  self.action_card} , 0)
    elseif op == "Button_Kong" then
        --杠
        if #self.gang_cards == 1 then
             print("self.action_card =",self.gang_cards[1])
             g_netMgr:send(g_netcmd.MSG_OPERATE, { 
                operate_code = CardDefine.operateType.Kong ,  
                operate_cardid =  self.gang_cards[1]} , 0)
        else
            self:finish()
            local temp = nil
            for k,v in pairs(self.gang_cards) do
                temp = self.detail[k]
                self:setDetail(temp,v)
            end
        end
    elseif op == "Button_Ready" then
         g_netMgr:send(g_netcmd.MSG_MINGLOU_ASK, {} , 0)
    elseif op == "Button_Pass" then
         g_netMgr:send(g_netcmd.MSG_OPERATE, { operate_code = 0 ,  operate_cardid =  0} , 0)
    end
end

function OperateNode:setDetail(_node,_value)
    local temp = nil
    local child = nil
    _node:setVisible(true)
    _node:setTag(_value)
    for i =1 ,4 do
        temp = _node:getChildByName("mj_sp_"..i)
        temp:removeAllChildren()
        child = display.newSprite("cards/"..CardDefine.enum[_value][2])
        child:setAnchorPoint(cc.p(0.5,0.5))
        child:addTo(temp)
        child:setPosition(temp:getContentSize().width/2,temp:getContentSize().height/2)
    end
end

function OperateNode:onKongClick( _sender )
    local value = _sender:getTag()
    print("value = ",value)
    g_netMgr:send(g_netcmd.MSG_OPERATE, {
                operate_code = CardDefine.operateType.Kong ,
                operate_cardid =  value} , 0)
    self:hideButtons()
end

--操作结果
function OperateNode:finish(_msg)
    self:hideButtons()

    if _msg then
        local op           = _msg.data.op
        local code        = op.operate_code
        if code == OperateType.Hu then return end
    end
    self.m_PlayNode.playerInfo[1]:canDiscard() 

    self:setCardEnabled(true)
    self.m_PlayNode.playerInfo[1]:toQueMen()
    --如果是听 回复自动打牌
    self.m_PlayNode.playerInfo[1]:setAutoStatus(true)
end

function OperateNode:operateReady( )
    -- body
end

function OperateNode:hideButtons()
    for i=1,#self.buttons do
        self.buttons[i]:setVisible(false)
    end
    self.buttons = {}
    self.detail[1]:setVisible(false)
    self.detail[2]:setVisible(false)
    self.detail[3]:setVisible(false)
end

function OperateNode:onMingLou( _msg )
    self:finish()
    local canDiscards  = _msg.data.can
    printTable("----canDiscards------>",canDiscards)
    self.m_PlayNode.playerInfo[1]:setReady(canDiscards)
end

function OperateNode:setCardEnabled(_b,_can,_noGray)
    self.m_PlayNode.playerInfo[1]:setCardEnabled(_b, _can,_noGray)
end

--游戏开始
function OperateNode:gameStart( ... )
    self:hideButtons()
end

return OperateNode