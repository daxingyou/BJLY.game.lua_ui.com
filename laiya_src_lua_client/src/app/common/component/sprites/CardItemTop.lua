
local ccbfile = "ccb/cardItemTop.ccbi"

local CardItemTop = class("CardItemTop", function()
    local node = cc.Layer:create()
    node:setNodeEventEnabled(true)
    return node
end)

function CardItemTop:ctor(_op,_cardEnum)
   self.cardEnum = _cardEnum
	 self:setContentSize(cc.size(245, 125))
	 self:load_ccb()

	self:initUI(_op,true)
  self.index = g_data.cardSys:getIndex()
  self:setting()
  self:regEvent()
end

function CardItemTop:onCleanup()
    self:unregEvent()
end

--注册事件
function CardItemTop:regEvent()
    g_msg:reg(self.index, g_msgcmd.UI_Setting_Change, handler(self, self.setting))
end

--注销事件
function CardItemTop:unregEvent()
    g_msg:unreg(self.index, g_msgcmd.UI_Setting_Change)
end

local card_bg = {
  "green_mj_bg1.png",
  "blue_mj_bg1.png"
}

local card_bg_4_6 = {
  "green_mj_bg3.png",
  "blue_mj_bg3.png"
}

local card_bg_kong = {
  "green_mj_bg4.png",
  "blue_mj_bg4.png"
}

function CardItemTop:setting()
  local tablestyle = g_LocalDB:read("tablestyle")
  for i = 1,8 do
    if i==6 or i == 4 or i == 8 or i == 5 then
      self.child[i]:setSpriteFrame(card_bg_4_6[tablestyle])
    else
      self.child[i]:setSpriteFrame(card_bg[tablestyle])
    end

    if self.op == OperateType.Self_kong then
        if i == 1 or i == 2 or i == 3 then
            self.child[i]:setSpriteFrame(card_bg_kong[tablestyle])
        end
    end
  end
end

--加载ccbi
function CardItemTop:load_ccb()
    self.m_ccbRoot = {}
    local proxy = cc.CCBProxy:create()
    local node  = CCBReaderLoad(ccbfile, proxy, self.m_ccbRoot)
    node:addTo(self)
end

function CardItemTop:initUI(op,isOffset)
    local tablestyle = g_LocalDB:read("tablestyle")
    self.op = op

	  self.child ={}
    for i = 1,8 do
      self.child[i] = self.m_ccbRoot["item_"..i]
      local value = self.child[i]:getChildByTag(30)
      value:setSpriteFrame(CardDefine.enum[self.cardEnum][2])
    end
    local _child = self.child

    _child[1]:setVisible( op == OperateType.pong or
    					  op == OperateType.Left_pong or
    					  op == OperateType.Mid_pong or
    					  op == OperateType.Left_kong or
    					  op == OperateType.Right_kong or
    					  op == OperateType.Self_kong or 
    					  op == OperateType.Mid_kong or 
                op == OperateType.Fill_kong)
    
    _child[2]:setVisible(true)
    _child[3]:setVisible( op == OperateType.pong or
    					  op == OperateType.Right_pong or
    					  op == OperateType.Left_kong or
    					  op == OperateType.Right_kong or
    					  op == OperateType.Self_kong or
    					  op == OperateType.Mid_kong or
    					  op == OperateType.Fill_kong)
   
    _child[4]:setVisible( op == OperateType.Right_pong or
    					  op == OperateType.Right_kong)

    _child[5]:setVisible( op == OperateType.Mid_kong)
    
    _child[6]:setVisible( op == OperateType.Left_pong or
    					  op == OperateType.Left_kong)

    _child[7]:setVisible( op == OperateType.Fill_kong or 
    					  op == OperateType.Self_kong)
    _child[8]:setVisible( op == OperateType.Mid_pong)

    local _width = 0
    for k, v in pairs(_child) do
        if k == 1 or k == 2 or k == 3 or k == 4 or k == 6 then
            if v:isVisible() then
              _width  = _width+v:getContentSize().width*v:getScaleX()
            end
        end
        if op == OperateType.Self_kong then
            if k == 1 or k == 2 or k == 3 then
              v:getChildByTag(30):setVisible(false)
              v:setSpriteFrame(card_bg_kong[tablestyle])
            end
        end
    end

   self.m_Width = _width
   if not isOffset then
        return
   end

   local w3 =  _child[3]:getContentSize().width*_child[3]:getScale()
   local w4 =  _child[4]:getContentSize().width*_child[4]:getScale()
   self.w3 = w3
   if op == OperateType.Left_pong or
      op == OperateType.Mid_pong  then --责任鸡特殊与bottom不一样
   		self:setCardOffset(w3+w4)
   end

   if  op == OperateType.pong or 
   	   op == OperateType.Mid_kong or
   	   op == OperateType.Fill_kong or 
       op == OperateType.Left_kong or
   	   op == OperateType.Self_kong then

		self:setCardOffset(w4)
   end
end

--设置偏移
function CardItemTop:setCardOffset(_offset)
	for k, v in pairs(self.child) do
		local x = v:getPositionX()
		v:setPositionX(x + _offset)
  end
end

function CardItemTop:fixMidPong()
  for k, v in pairs(self.child) do
    local x = v:getPositionX()
    v:setPositionX(x - self.w3)
  end
end

return CardItemTop