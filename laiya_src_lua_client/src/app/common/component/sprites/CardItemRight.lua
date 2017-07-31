
local ccbfile = "ccb/cardItemRight.ccbi"

local CardItemRight = class("CardItemRight", function()
    local node = cc.Layer:create()
    node:setNodeEventEnabled(true)
    return node
end)


function CardItemRight:ctor(_op,_cardEnum)
     self.cardEnum = _cardEnum
	 self:setContentSize(cc.size(125, 200))
	 self:load_ccb()

	 self:initUI(_op,true)
    self.index = g_data.cardSys:getIndex()
    self:setting()
    self:regEvent()
end

function CardItemRight:onCleanup()
    self:unregEvent()
end

--注册事件
function CardItemRight:regEvent()
    g_msg:reg(self.index, g_msgcmd.UI_Setting_Change, handler(self, self.setting))
end

--注销事件
function CardItemRight:unregEvent()
    g_msg:unreg(self.index, g_msgcmd.UI_Setting_Change)
end

local card_bg = {
  "green_mj_bg3.png",
  "blue_mj_bg3.png"
}

local card_bg_4_6 = {
  "green_mj_bg1.png",
  "blue_mj_bg1.png"
}

local card_bg_kong = {
  "green_mj_bg6.png",
  "blue_mj_bg6.png"
}

function CardItemRight:setting()
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
function CardItemRight:load_ccb()
    self.m_ccbRoot = {}
    local proxy = cc.CCBProxy:create()
    local node  = CCBReaderLoad(ccbfile, proxy, self.m_ccbRoot)
    node:addTo(self)
end

function CardItemRight:initUI(op,isOffset)

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

    _child[5]:setVisible(op == OperateType.Mid_kong )
    
    _child[6]:setVisible( op == OperateType.Left_pong or
    					  op == OperateType.Left_kong)

    _child[7]:setVisible( op == OperateType.Fill_kong or 
    					  op == OperateType.Self_kong)
    _child[8]:setVisible( op == OperateType.Mid_pong)

    local _width  = 0
    local _height = 0 
    for k, v in pairs(_child) do
        if k == 1 or k == 2 or k == 3 or k == 4 or k == 6 then
            if v:isVisible() then
              _width   = _width  + v:getContentSize().width*v:getScaleX()
              _height  = _height + v:getContentSize().height*v:getScaleY()-4.5
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
    self.m_Height = _height
    
    if not isOffset then
        return
    end

    local h4 =  _child[4]:getContentSize().height*_child[4]:getScaleY()
    local h3 =  _child[3]:getContentSize().height*_child[3]:getScaleY()
    self.h3 = h3
    if op == OperateType.Right_pong then
       self:setCardOffset(h3+h4)
    end

    if  op == OperateType.pong or 
        op == OperateType.Mid_pong or 
        op == OperateType.Mid_kong or
        op == OperateType.Fill_kong or 
        op == OperateType.Right_kong or
        op == OperateType.Self_kong then

        self:setCardOffset(h4)
    end
end

--设置偏移
function CardItemRight:setCardOffset(_offset)
	for k, v in pairs(self.child) do
		local y = v:getPositionY()
		v:setPositionY(y - _offset)
    end
end

function CardItemRight:fixMidPong(_fixset)
    for k, v in pairs(self.child) do
        local y = v:getPositionY()
        v:setPositionY(y + self.h3)
    end
end

return CardItemRight