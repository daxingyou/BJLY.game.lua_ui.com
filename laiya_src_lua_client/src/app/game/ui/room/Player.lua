
local SortCards = require("app.common.component.SortCards")
local Scheduler = require("framework.scheduler")
local Player = class("Player")
--[[
处理玩家相关信息
]]
local  DirectionX  = 0
local  DirectionY  = 0
function Player:ctor(_infoNode,_cardNode,_isVideo,_pnode)
  self.m_PlayerNode = _pnode
  if _isVideo then
      self.isVideo = _isVideo
  end

  self.opActionOK = false
  self.addCardOK  =false 

	self.direction 	   = -1 --客户端用的相对座位号
	self.uid		   = 0
  self.m_infoNode = nil

	self.cardNode        = _cardNode
	-- self.handNode		     = self.cardNode:getChildByName("nodeCards") --手牌
	self.showCardNode	   = self.cardNode:getChildByName("nodeCards_show") --显示

	self.m_chickenNode   = self.cardNode:getChildByName(RoomDefine.Ji_node[g_data.roomSys.PlayRule]) --未知TODO
	self.CXNode          = self.cardNode:getChildByName("node_chengxing_cards") --未知TODO

  local itemNode       = self.CXNode:getChildByName("node_chengxing_1")  

	self.disCardNode	   = self.cardNode:getChildByName(RoomDefine.PlayOutCard[g_data.roomSys.PlayRule])

	self.disCards		     = {}
  self.cards           = {}
  self.cardItems       = {}
  self.chickenNumber   = 0
  self.origin_x = 0
  self.origin_y = 0
  
  self.ready =false
  self.auto  = false

  if self.disCardNode then
      --打牌显示精灵
      self.m_outCardView  = self.disCardNode:getChildByName("mj_bg_poker_out") -- 打出去的效果牌
      self.m_outCardView:setVisible(false)
      self.m_outCardView:setLocalZOrder(1000)
      self.m_outCardView_x , self.m_outCardView_y = self.m_outCardView:getPosition()
      self.m_outCardView_ccp   = cc.p(self.m_outCardView_x , self.m_outCardView_y)
      self.m_outCardView_value = self.m_outCardView:getChildByName("mj_value")
      self.m_outCardShowing    = false
      self.m_outCard           = nil
  end

  self:un_m_Fn()
end

function Player:setDirection(_d)
  self.direction = _d
  self:initOrigin()
end

function Player:initOrigin( )
    if self.direction == CardDefine.direction.bottom then
        self.origin_x = 10
        self.origin_y = 0
    elseif self.direction == CardDefine.direction.top then
        self.origin_x = -220
        self.origin_y = -100
    elseif self.direction == CardDefine.direction.right then
        self.origin_x = -105 
        self.origin_y = 2
    elseif self.direction == CardDefine.direction.left then
        self.origin_x = -10 
        self.origin_y = -170
    end  
end

--设置uid
function Player:setInfo( _info)
  self.m_info = _info
  if self.m_info == nil then return end
  
  self.uid = self.m_info.uid

  if self.m_infoNode == nil then
     self.m_info.direction = self.direction
     self.m_infoNode = require("app.game.ui.room.PlayerIcon").new(self.m_info,self.m_PlayerNode,self)
     self.m_infoNode:addTo(self.m_PlayerNode)
  end
end

function Player:hide()
  if self.m_infoNode ~=nil then
    self.m_infoNode:removeSelf()
    self.m_infoNode = nil
  end
end

function Player:show()
end

--初始化手牌
function Player:initCards(cards)
    if self.m_info == nil then
      return
    end
    for i=1, #self.cards do
      --释放内存
      self.cards[i]:release()
  	end
  	self.cards = {}
    local _crds =nil
    if cards then
      _crds = cards
    else
      _crds =  self.m_info.cards 
    end
  	for i=1,#_crds do
	    local card = CardFactory:create(self.direction, CardDefine.type.shoupai, _crds[i])
	    card.isMoPai = false
	    self.cards[#self.cards+1] = card
  	end
    self:updatePos(true)
end

-- 摸牌
function Player:addCard(_enum)
	local enum = self:getNum(_enum)
	print("===============> add card------>",enum)
  if enum == nil then
		print("[can no see]=====Player:addCard====> param ERROR return!!!!!!!")
		return
	end
  self:un_m_Fn()

	local card = CardFactory:create(self.direction, CardDefine.type.shoupai, enum)
	card.isMoPai = true
	self.cards[#self.cards+1] = card
	self.lastMopai = card
	self:updateAll()
  self:toQueMen()

  if self.direction == CardDefine.direction.bottom then
    self.addCardOK = true
    if self.opActionOK then
        self:canDiscard()
        self.addCardOK  = false
        self.opActionOK = false
    end
  end
end

function Player:getNum(param)
  local opcard = nil
  if type(param) == "number" then
    opcard = param
  end
  if type(param) == "table" then
    if type(param[1]) == "number" then
      opcard = param[1]
    end
  end
  if opcard == 0 then
    opcard = nil
  end
  return opcard
end

--移除摸牌标记
function Player:removeMopai()
  print("========== 删除摸牌标记 ===========")
  if self.direction == CardDefine.direction.bottom then
    local pos = 1
    while pos <= #self.cards do
      if self.cards[pos].isMoPai then
        self.cards[pos].isMoPai = false
      end
      if self.cards[pos] == self.nextDeleteCard then
        self.nextDeleteCard:release()
        table.remove(self.cards, pos)
        self.nextDeleteCard = nil
        self.selectedCard = nil
      else
        pos = pos + 1
      end
    end
    self.sendok = false
    print("======Seting======message already send!========== > ", self.sendok)
  else
      local find = false
      for i=1,#self.cards do
        if self.cards[i].isMoPai then
          self.cards[i]:release()
          table.remove(self.cards, i)
          find = true
          break
        end
      end
      if not find then
        for i=1,#self.cards do
          if self.cards[i].cardEnum == -1 then
            self.cards[i]:release()
            table.remove(self.cards, i)
            find = true
            break
          end
        end
      end
      if not find then
        print("====================ERROR: 移除首牌失败！============")
      end
  end
end

--注册点击事件
function Player:registerTouch()
  CardFactory:register(handler(self, self.touchCallback))
end
--[[
打牌流程处理
]]
function Player:touchCallback(isSelected, card)
  -- 第二次的出牌判断
  if isSelected then
    if not self.canSendMessage then
      print("============can not send message!========== > ", self.canSendMessage)
      return
    end
    if self.sendok then
      print("============message already send!========== > ", self.sendok)
      -- return
    end
   
    --- 防止有缺门的情况下 把非缺门牌打出去
    if self.m_info.QueMen > 0 then
      local isHave = self:isHaveQuemen()
      local isQumen = self:isQueMen(card.cardEnum)
      if isHave and  isQumen ==false then
          return
      end
    end
     --服务端发起打牌
    print("打牌---->card.cardEnum =",card.cardEnum)
    self.fn_cont = 0
    self.fn = function() g_netMgr:send(g_netcmd.MSG_OUT, { card = card.cardEnum } , 0) end
    
    g_netMgr:send(g_netcmd.MSG_OUT, { card = card.cardEnum } , 0)
  	self.sendok = true
    self:disableTouch()
    self.nextDeleteCard = card
    if self.selectedCard and self.selectedCard ~= card then
      self.selectedCard:unselect()
    end
    return
  else
    if self.selectedCard and self.selectedCard ~= card then
      self.selectedCard:unselect()
    end
    self.selectedCard = card
    self.selectedCard:select()
  end
end

function Player:unselect()
  -- 这里只做牌的选中判断处理
    if self.selectedCard then
      self.selectedCard:unselect()
    end
end

-- 取消操作
function Player:disableTouch()
  self.canSendMessage = false
end

--排序
function Player:updateAll(noSort)
  if noSort == nil then
    self.cards = SortCards:sort(self.cards,self.auto)
  end
  self:updatePos()
end

function Player:updatePos()
  if self.direction == CardDefine.direction.bottom then
    SortCards:sortBottom(self.cards)
  elseif self.direction == CardDefine.direction.right then
    SortCards:sortRight(self.cards)
  elseif self.direction == CardDefine.direction.top then
    SortCards:sortTop(self.cards)
  elseif self.direction == CardDefine.direction.left then
    SortCards:sortLeft(self.cards)
  end
  -- 重新排序后，如果当前有选中的牌，那么设为选中状态
  if self.selectedCard then
    self.selectedCard:select()
  end
end

function Player:canDiscard()
  self.fn = nil -- 打牌不成功路由
  self.fn_cont = 0
  self.canSendMessage = true
  print("============can send message!========== > ", self.canSendMessage)
 
  if self.direction ~= CardDefine.direction.bottom then return end

  self:autoDiscard()
end

-- 碰牌处理
function Player:peng(_enum,_type)
  local enum = self:getNum(_enum)
  if enum == nil then
    print("================Player:peng====> param ERROR !!!!!!!")
    return
  end
  -- 碰删除2张，添加3张
  self:removePengCard(enum)
  self:updateAll()

  self:chengXing(enum,_type)
  self:toQueMen()
  self:canDiscard()
end

--一处碰牌
function Player:removePengCard(enum)
  -- Peng牌的时候 移除2张牌
  if self.direction == CardDefine.direction.bottom or self.isVideo then
    self:removeSameCard(enum, 2)
  else
    self:removeCard(2)
  end
end

-- enum 要删除的类型
-- num 要删除的个数，如果为nil 全部删除
function Player:removeSameCard(enum, num)
  local pos = 1
  local nums= 0
  while pos <= #self.cards do
    -- 只删除手牌相同的
    if self.cards[pos].cardEnum == enum and self.cards[pos].cardType == CardDefine.type.shoupai then
      self.cards[pos]:release()
      table.remove(self.cards, pos)
      nums = nums + 1
    else
      pos = pos + 1
    end
    if num ~= nil and nums >= num then
      return
    end
  end
end

-- num 要移除和卡牌数量
-- 这里只是给其它玩家，即除自己外的其它玩家删除片牌的时候使用的
function Player:removeCard(num)
  local pos = 1
  local nums= 0
  while pos <= #self.cards do
    if self.cards[pos].cardEnum == -1 then
      self.cards[pos]:release()
      table.remove(self.cards, pos)
      nums = nums + 1
    else
      pos = pos + 1
    end
    if num ~= nil and nums >= num then
      return
    end
  end
end

-- 收到消息后再处理
-- _enum: 牌
-- type: 杠的类型
-- pId,provideId,cardEnum,opCode
function Player:kong(_enum, _type, _DutyChicken)
  --TODO 暗杠暂时没有处理
   print("================Player:kong====> _type ==",_type)
  local enum = self:getNum(_enum)
  if enum == nil then
    print("================Player:kong====> param ERROR !!!!!!!")
    return
  end

  local _number = 3
  if _type == OperateType.Fill_kong then
    _number = 1
  elseif _type == OperateType.Self_kong then
    _number = 4
  end
  print("================Player:kong====> _number ==",_number)
 
  if self.direction == CardDefine.direction.bottom or self.isVideo then
    self:removeSameCard(enum, _number)
    self:removeMopai()
  else
    self:removeCard(_number)
  end

  for k, v in pairs(self.cards) do
    v.isMoPai = false
  end
  self:chengXing(enum,_type)
  self:toQueMen()
  self:updateAll()
 
end

--成型牌
function Player:chengXing(cardEnum,op)
    --补杠特殊处理
    if op == OperateType.Fill_kong then
      local isHave = false
      local isMid  = false
      for k, v in pairs(self.cardItems) do
          if  v.cardEnum == cardEnum then
              isHave =true
              --如果是中碰 后面的要后移
              if v.op == OperateType.Mid_pong then
                isMid = true
              end
              v:initUI(op)
          else
            if isHave and isMid then
              v:fixMidPong()
            end
          end
      end
      if isHave then return end
    end

    local item = nil
    local gap  = 10
    if self.direction == CardDefine.direction.bottom then
        item = require("app.common.component.sprites.CardItemBottom").new(op,cardEnum)
        item:setPosition(cc.p(self.origin_x,self.origin_y))
        self.origin_x = self.origin_x + item.m_Width + gap
    elseif self.direction == CardDefine.direction.top then
        item = require("app.common.component.sprites.CardItemTop").new(op,cardEnum)
        item:setPosition(cc.p(self.origin_x,self.origin_y))
        self.origin_x = self.origin_x - item.m_Width - gap
    elseif self.direction == CardDefine.direction.left then
        item = require("app.common.component.sprites.CardItemLeft").new(op,cardEnum)
        item:setPosition(cc.p(self.origin_x,self.origin_y))
        self.origin_y = self.origin_y - item.m_Height - gap
    elseif self.direction == CardDefine.direction.right then
        item = require("app.common.component.sprites.CardItemRight").new(op,cardEnum)
        item:setPosition(cc.p(self.origin_x,self.origin_y))
        self.origin_y = self.origin_y + item.m_Height + gap
    end
    if item then
      item:addTo(self.CXNode)
      table.insert(self.cardItems, item)
    end
end

function Player:toQueMen()
  if self.m_info.QueMen < 1 then return end

  print("self.m_info.QueMen =",self.m_info.QueMen)
  local card   = CardDefine.AllcardType[self.m_info.QueMen]
  local flag = {}
  for i=1,#card do
       flag[card[i]] = true
  end

  local _lock = false
  for i =1 ,#self.cards do 
    if flag[self.cards[i].cardEnum] then
      _lock =true
      break
    end
  end
 
  if _lock then
    self:setCardEnabled(false, card)
  else
    self:setCardEnabled(true)
  end
end

--碰杠 
function Player:removeDisCard(_enum)
    local enum = self:getNum(_enum)
    if enum == nil then
      print("================Player:removeUsedCard====> param ERROR !!!!!!!")
      return
    end
    --暂停打牌动画
    self:un_outCardAnimation()

    if enum == CardDefine.cardValue.tiao1 then
      self.chickenNumber = self.chickenNumber - 1
      local chickenCard =nil
      for i = 4, 1,-1 do
        chickenCard = self.m_chickenNode:getChildByName("mj_bg_"..i)
        if chickenCard:isVisible() then
            chickenCard:setVisible(false)
            break
        end
      end
    else
      local idx =  #self.disCards
      if idx == 0 then return end
      local _cardEnum = self.disCards[idx]
      if enum ~= _cardEnum then return end

      local cardIndex ="mj_bg_"..idx
      local card = self.disCardNode:getChildByName(cardIndex)
      card:setVisible(false)
      table.remove(self.disCards,idx)
      CardFactory:flagHide()
  end
end

--暂时这样
function Player:reset()
    if self.m_info == nil then
      return
    end
    g_data.roomSys:onCleanRound(self.uid)
    self:initCards({})
    for i= 1 , 4 do
      self.m_chickenNode:getChildByName("mj_bg_"..i):setVisible(false)
    end
    self.chickenNumber = 0

    for i = 1 , #self.disCards do
        local card = self.disCardNode:getChildByName("mj_bg_"..i)
        card:setVisible(false)
    end
    self.disCards = {}
    
    for k, v in pairs(self.cardItems) do
        v:removeSelf() 
    end
    self.cardItems = {}
    self:initOrigin()
    self.sendok = false
    self.ready =false

    self:endShowHu()
end
---听
function Player:setReady(_can)
  self:setCardEnabled(false, _can)
  self.ready = true
  self.auto = true
end

--设置卡牌是否可以点击
function Player:setCardEnabled(_b,_can,_noGray)
  if self.direction ~= CardDefine.direction.bottom then return end
  local flag = {}
  if _can then
      for i=1,#_can do
       flag[_can[i]] = true
      end
  end

  for i=1,#self.cards do
    if _b then
      self.cards[i].cardNode:setNormal()
    else
      self.cards[i].cardNode:setGray()
      self.cards[i]:unselect()
      if _noGray then
        self.cards[i].cardNode:setNormal()
      end
    end
    self.cards[i]:setTouchEnable(_b)
    if  flag[self.cards[i].cardEnum]  then
        self.cards[i].cardNode:setNormal()
        self.cards[i]:setTouchEnable(true)
    end
  end
end

function Player:discard_r(_cardEnum)
  if self.m_info == nil then
      return
  end
  local cardEnum = _cardEnum
  --自己
  if cardEnum == -1 then
    cardEnum = self.nextDeleteCard.cardEnum
  end

  local _TexturePath = CardDefine.enum[cardEnum][2]
  local card  = nil
  local value = nil 
  --鸡排特殊处理
  if cardEnum == CardDefine.cardValue.tiao1 then
    self.chickenNumber = self.chickenNumber +1

    if  self.m_info.ChargeChicken then
      card = self.m_chickenNode:getChildByName("mj_bg_"..self.chickenNumber)
    else
      card = self.m_chickenNode:getChildByName("mj_bg_"..self.chickenNumber+1)
    end
    value = card:getChildByName("mj_value")
  else
      local idx ="mj_bg_"..(#self.disCards + 1)
      card = self.disCardNode:getChildByName(idx)
      value = card:getChildByName("mj_value")
      table.insert(self.disCards,cardEnum)
  end
  value:setSpriteFrame(_TexturePath)
  card:setVisible(true)
  self:card_setting()
end

-- _cardEnum 出去的牌，
-- _chargeChickenType 鸡的类型  1 为冲锋鸡,2是普通鸡
function Player:discard_Success(_cardEnum,_chargeChickenType)
  self:un_m_Fn()
  
  local cardEnum = _cardEnum
  --自己
  if cardEnum == -1 then
    cardEnum = self.nextDeleteCard.cardEnum
  end

  local _TexturePath = CardDefine.enum[cardEnum][2]
  local card  = nil
  local value = nil 
  --鸡排特殊处理
  if cardEnum == CardDefine.cardValue.tiao1 then
    self.chickenNumber = self.chickenNumber +1
    if _chargeChickenType == 1 then
       g_data.roomSys:setChargeChicken(self.m_info,true)
    end
    if  self.m_info.ChargeChicken then
      card = self.m_chickenNode:getChildByName("mj_bg_"..self.chickenNumber)
    else
      card = self.m_chickenNode:getChildByName("mj_bg_"..self.chickenNumber+1)
    end
    value = card:getChildByName("mj_value")
  else
      local idx ="mj_bg_"..(#self.disCards + 1)
      card = self.disCardNode:getChildByName(idx)
      value = card:getChildByName("mj_value")
      table.insert(self.disCards,cardEnum)
  end
  self:card_setting()
  value:setSpriteFrame(_TexturePath)

  if _chargeChickenType == 1 then
  else

    local _sound = g_audioConfig.card[cardEnum][self.m_info.sex]
    
    local lg = g_LocalDB:read("language_type")
    if "normal" == lg then --普通话
        _sound = (string.gsub(_sound, "_d.", "_p."))
    end

    g_audio.playSound(_sound)
  end

  self:outCardAnimation(cardEnum,card)

  ---天听处理逻辑
  if self.ready then
    self.m_info.isTingPai = self.ready
    self:setCardEnabled(false) --打牌成功后全部置灰
    g_netMgr:send(g_netcmd.MSG_MINGLOU, {} , 0)
  end

  --录像
  if self.isVideo then
      for i = 1 , #self.cards do
        if self.cards[i].isMoPai then
            self.cards[i].isMoPai = false
            break
        end
      end
      self:removeSameCard(cardEnum,1)
      self:updateAll()
  else
    self:removeMopai()
    self:updateAll()
  end
end

--停止打牌动画
function Player:un_outCardAnimation()
   if self.m_outCardShowing then
      self.m_outCardView:stopAllActions()
      self.m_outCardView:setVisible(false)
      self.m_outCard:setVisible(true)
      self:flagShow()
  end
end

--打牌动画
function Player:outCardAnimation(_cardEnum,_card)
  self:un_outCardAnimation()

  self.m_outCard = _card
  if self.m_outCard == nil then 
      self.m_outCardShowing = false
      return 
  end
  self.m_outCardShowing = true
  local frame = CardDefine.enum[_cardEnum][2]
  self.m_outCardView_value:setSpriteFrame(frame)
  self.m_outCardView:setScale(0)
  self.m_outCardView:setVisible(true)
  self.m_outCardView:setPosition(self.m_outCardView_ccp)

  local x,y = self.m_outCard:getPosition()
  local outCard_ccp = cc.p(x,y)

  local _time = 0.8
  self.m_outCardView:runAction(cc.Sequence:create({
        cc.Spawn:create({
            cc.Sequence:create({ 
                cc.EaseBackInOut:create(cc.MoveTo:create(_time, outCard_ccp)),
                }),
             --冲
            cc.Sequence:create({    --放大到缩小
                cc.ScaleTo:create(0.3*_time, 1.8),
                cc.ScaleTo:create(0.7*_time, 0.5)
                })
            }),
        cc.CallFunc:create(function() --结束后回调
                              self.m_outCardView:setVisible(false)
                              self.m_outCard:setVisible(true)
                              self.m_outCardShowing = false
                              self:flagShow() -- 打出的牌的提示
                          end)}))
 
end

-- 显示打牌标记
function Player:flagShow()
  if self.m_outCard == nil then return end
  local x,y = self.m_outCard:getPosition()
  local outCard_ccp = cc.p(x,y)
  local outCard_world_cpp = self.m_outCard:getParent():convertToWorldSpace(outCard_ccp)
  CardFactory:flagShow(outCard_world_cpp)
end


--回复自动打牌
function Player:autoDiscard()
  if self.ready then
    local function actionCallback()
      if self.auto and self.canSendMessage then
        self.canSendMessage = false
        self.selectedCard =  self.lastMopai --self.cards[#self.cards]
        self.nextDeleteCard = self.selectedCard
        g_netMgr:send(g_netcmd.MSG_OUT, { card = self.selectedCard.cardEnum} , 0)
      end
    end

    for i=1,#self.cards do
      if self.cards[i].cardType == CardDefine.type.shoupai
        and self.direction == CardDefine.direction.bottom then
        -- 注意，只有手牌有此方法，其实类型没有！！！！！！！！！！
        -- if i ~= #self.cards then
        self.cards[i].cardNode:setGray()
        -- end
        self.cards[i]:setTouchEnable(false)
      end
    end
    if self.lastMopai then
      self.lastMopai.cardNode:setNormal()
    end
    local action = cc.DelayTime:create(0.5)
    local seq = cc.Sequence:create({action, cc.CallFunc:create(actionCallback)})
    self.cardNode:runAction(seq)
  end
end

function Player:setAutoStatus(_isAuto)
  if self.ready then
    self.auto = _isAuto
    -- self.cards[#self.cards]:setTouchEnable(true)
    self:autoDiscard()
  end
end

--校验是否是缺门牌
function Player:isQueMen(_cardEnum)
  --暂时这样以后优化
  local is = false
  local card   = CardDefine.AllcardType[self.m_info.QueMen]
  for i=1,#card do
    if card[i] == _cardEnum then
        is = true
        break
    end
  end
  return is
end

--手里是否还有缺门牌
function Player:isHaveQuemen()
 if self.m_info.QueMen < 1 then return false end
  --暂时这样以后优化
  local card   = CardDefine.AllcardType[self.m_info.QueMen]
  local flag = {}
  for i=1,#card do
       flag[card[i]] = true
  end

  local isHave = false
  for i =1 ,#self.cards do 
    if flag[self.cards[i].cardEnum] then
      isHave =true
      break
    end
  end
  return isHave
end

--胡牌展示
     -- local  path_png = CardDefine.enum[value_mj][2] 
     --    sp_fanpaiji:setSpriteFrame(path_png)
function Player:showHu()

  if self.m_info == nil then return end
   --清楚手中的牌
   self:initCards({})

  local report = g_data.reportSys:getRoundReportByUID(self.uid)

  local function m_sort(a,b)
      return  a > b
  end

  local cards  = report.hand_cards
  table.sort(cards,m_sort)

  local hucard = report.hu_cardid
  local hupai_fangshi = report.hupai_fangshi
  local hupai_type = report.hupai_type
  local cardLen = #cards
  local sp    = nil 
  local value = nil
  local j     = 1
 
  local isWin  = false
  if hupai_type > 1 then
    isWin =true
  end

  local tablestyle = g_LocalDB:read("tablestyle")

  for i = 2,14 do
      sp = self.showCardNode:getChildByName("poker_"..i)
      sp:setSpriteFrame(CardDefine.card_bg[self.direction][tablestyle])
      sp:setVisible(false)
      if j <= cardLen then
        sp:setVisible(true)
        value = sp:getChildByName("mj_value")
        value:setSpriteFrame(CardDefine.enum[cards[j]][2])
        j = j+1
      end
  end
  if not hucard then return end
  if not isWin  then return end

  sp = self.showCardNode:getChildByName("poker_1")
  sp:setSpriteFrame(CardDefine.card_bg[self.direction][tablestyle])
  value = sp:getChildByName("mj_value")
  value:setSpriteFrame(CardDefine.enum[hucard][2])
 
  local x ,y = sp:getPosition()
  if self.direction == CardDefine.direction.bottom then
      sp:setPositionX(x+15)
  elseif self.direction == CardDefine.direction.top then
      sp:setPositionX(x-15)
  elseif self.direction == CardDefine.direction.left then
      sp:setPositionY(y-15)
  elseif self.direction == CardDefine.direction.right then
      sp:setPositionY(y+15)
  end
  sp:setVisible(true)
end

--展示隐藏
function Player:endShowHu()
  for i = 1,14 do
      sp = self.showCardNode:getChildByName("poker_"..i)
      sp:setVisible(false)
  end
end

function Player:un_m_Fn()
  if self.m_FnSchedule then Scheduler.unscheduleGlobal(self.m_FnSchedule) end
  self.m_FnSchedule = nil
  self.fn = nil
  self.fn_cont = 0
end

function Player:run_m_Fn()
  if self.m_FnSchedule == nil then
        self.m_FnSchedule = Scheduler.scheduleGlobal(function()   
            self.fn_cont = self.fn_cont +1
            if self.fn_cont > 3 then
              self:un_m_Fn()
            else
              if self.fn then
                   self.fn() 
              end
            end
          end, 0.5)
  end
end
--暂时
function Player:card_setting()
  local tablestyle = g_LocalDB:read("tablestyle")
  if self.m_chickenNode then
    for i = 1 ,4 do
      local card = self.m_chickenNode:getChildByName("mj_bg_"..i)
      if i == 1 then
        card:setSpriteFrame(CardDefine.card_ji_bg[self.direction][tablestyle])
      else
        card:setSpriteFrame(CardDefine.card_bg[self.direction][tablestyle])
      end
    end
  end

  for i = 1 , #self.disCards do
        local card = self.disCardNode:getChildByName("mj_bg_"..i)
        card:setSpriteFrame(CardDefine.card_bg[self.direction][tablestyle])
  end
end

return Player
