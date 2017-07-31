--[[
    --  动画页面
]]--
local _fileAnimationNode = "loading/AnimationNode.csb"
local AnimationNode = class("AnimationNode", function()
    local node = display.newNode()
    node:setNodeEventEnabled(true)
    return node
end)

local Http_Load_HEAD = "Http_Load_HEAD"

function AnimationNode:ctor()
    self:initUI()
    self:regEvent()
end

function AnimationNode:onCleanup()
    self:unregEvent()
end

--注册事件
function AnimationNode:regEvent()
    g_msg:reg("AnimationNode", g_msgcmd.UI_Chicken_Change, handler(self, self.onChickenStatus))--玩家加入
end

--注销事件
function AnimationNode:unregEvent()
    g_msg:unreg("AnimationNode", g_msgcmd.UI_Chicken_Change)
end

--初始化UI
function AnimationNode:initUI(_isVideo)
    local _UI = cc.uiloader:load(_fileAnimationNode)
    _UI:addTo(self)

    self.actions = {}
    for i = 1, 4 do
        temp = _UI:getChildByName("action_"..i)
        if temp then
            self.actions[i] = temp
            temp:setScale(0)
        end
    end
end

function AnimationNode:play(_uid,_code,_hu,_kong,_isZimo,_puid)
    local p = g_data.roomSys:getPlayerInfo(_uid)
    self.sex = p.sex
    print("sex ==",self.sex)
    print("p.direction = ",p.direction)
    self.current = self.actions[p.direction]
    self.current:setAnchorPoint(cc.p(0.6,0.49))
    if self.current then
        self:playAnimation(_code,_hu,_kong,_isZimo)
    end
end
--播放动画
function AnimationNode:playAnimation(_code,_hu,_kong,_isZimo)
    local _AnimationTabel = {}  --动画播放列表
    local function _Animation(node,value)
        self.current:setTexture(OperateType.Animation_Res[value.path])

        print("OperateType.Animation_Res[value.path] =",OperateType.Animation_Res[value.path])
        local tb = {}

        --播放操作声音
        local action = cc.CallFunc:create(function()
                        g_audio.playSound(g_audioConfig.operate[value.path][self.sex])
                    end)
        table.insert(tb,action)
         
         --图片动画
        action = cc.EaseBackOut:create(cc.ScaleTo:create(0.4, 1.5))
        table.insert(tb,action)

        if self:isPongOrKong(_code) then
            action = cc.CallFunc:create(function()
                        self.current:setAnchorPoint(cc.p(0.5,0.5))
                        self.current:setTexture(OperateType.Animation_Res_2[value.path])
                    end)
            table.insert(tb,action)
        end

        action = cc.EaseBackOut:create(cc.ScaleTo:create(0.4, 0.8))
        table.insert(tb,action)
       
        action= cc.DelayTime:create(0.3)
        table.insert(tb,action)
        action = cc.EaseBackOut:create(cc.ScaleTo:create(0.4, 0))
        table.insert(tb,action)
        
        self.current:runAction(cc.Sequence:create(tb))
    end
    
    if _code == OperateType.Hu then
      if _kong and _kong > 0 then
          table.insert(_AnimationTabel,cc.CallFunc:create(_Animation,{path = _kong+200}))
          table.insert(_AnimationTabel,cc.DelayTime:create(0.8))
      else
        if _isZimo then
          table.insert(_AnimationTabel,cc.CallFunc:create(_Animation,{path = OperateType.Hu_TYPE_9}))
          table.insert(_AnimationTabel,cc.DelayTime:create(0.8))
        else
          --点炮音效
          local action = cc.CallFunc:create(function()
                        g_audio.playSound(g_audioConfig.operate[OperateType.Hu_DianPao][self.sex])
                    end)
          table.insert(_AnimationTabel,action)
          table.insert(_AnimationTabel,cc.DelayTime:create(0.8))
        end
      end
      table.insert(_AnimationTabel,cc.CallFunc:create(_Animation,{path = _hu+100}))
    else
        table.insert(_AnimationTabel,cc.CallFunc:create(_Animation,{path = _code}))
    end

    self.current:runAction(cc.Sequence:create(_AnimationTabel))
end

--冲锋鸡动画特殊处理
function AnimationNode:onChickenStatus( _msg )
    local p = g_data.roomSys:getPlayerInfo(_msg.data.uid)
    if p == nil then return end
    if p.ChargeChicken then
        self:play(_msg.data.uid,OperateType.ChargeChicken)
    elseif p.DutyChicken then
        self:play(_msg.data.uid,OperateType.DutyChicken)
    end
end

--播放动画
function AnimationNode:playTing(_uid)
    local p = g_data.roomSys:getPlayerInfo(_uid)
    self.sex = p.sex
    self.current = self.actions[p.direction]
    self.current:setAnchorPoint(cc.p(0.6,0.49))
  
    self.current:setTexture(OperateType.Animation_Res[OperateType.Ready])

    local tb = {}

    --播放操作声音
    local action = cc.CallFunc:create(function()
                    g_audio.playSound(g_audioConfig.operate[OperateType.Ready][self.sex])
                end)
    table.insert(tb,action)
     
     --图片动画
    action = cc.EaseBackOut:create(cc.ScaleTo:create(0.4, 1.5))
    table.insert(tb,action)

    action = cc.CallFunc:create(function()
                    self.current:setAnchorPoint(cc.p(0.5,0.5))
                    self.current:setTexture(OperateType.Animation_Res_2[OperateType.Ready])
                end)
    table.insert(tb,action)

    action = cc.EaseBackOut:create(cc.ScaleTo:create(0.4, 0.8))
    table.insert(tb,action)
   
    action= cc.DelayTime:create(0.3)
    table.insert(tb,action)
    action = cc.EaseBackOut:create(cc.ScaleTo:create(0.4, 0))
    table.insert(tb,action)
    
    self.current:runAction(cc.Sequence:create(tb))
end

-- OperateType.pong          = 1 --碰
-- OperateType.Left_kong     = 2--左杠
-- OperateType.Right_kong    = 3
-- OperateType.Mid_kong      = 4
-- OperateType.Fill_kong     = 5--补杠
-- OperateType.Self_kong     = 6--暗杠
-- OperateType.Ready         = 7--听
-- OperateType.Hu            = 8--胡
-- OperateType.Left_pong     = 9 --左碰
-- OperateType.Mid_pong      = 10 --中碰
-- OperateType.Right_pong    = 11 
-- OperateType.ChargeChicken   = 12 --冲锋鸡
-- OperateType.DutyChicken   = 13 --


function AnimationNode:isPongOrKong(code)
    return    code ==OperateType.pong 
           or code ==OperateType.Left_pong 
           or code ==OperateType.Mid_pong 
           or code ==OperateType.Right_pong
           or code ==OperateType.Left_kong 
           or code ==OperateType.Right_kong 
           or code ==OperateType.Mid_kong 
           or code ==OperateType.Fill_kong 
           or code ==OperateType.Self_kong
end



return AnimationNode