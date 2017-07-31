local CardCell = class("CardCell", function()
	
	local sprite = display.newSprite()
	sprite:setNodeEventEnabled(true)

	return sprite
end)


function CardCell:ctor(pic)

	display.addSpriteFrames("card.plist","card.pvr.ccz")
	self:setting()
	self.content = display.newSprite("#"..pic)
	self.content:setAnchorPoint(cc.p(0.5,0.5))
	local size = self:getContentSize()
	self.content:setPosition(cc.p(size.width*0.5, size.height*0.5-10))
	self.content:setScale(1.2)

	self.content:addTo(self)
	self.index = g_data.cardSys:getIndex()
	self:regEvent()
end
function CardCell:onCleanup()
    self:unregEvent()
end

--注册事件
function CardCell:regEvent()
    g_msg:reg(self.index, g_msgcmd.UI_Setting_Change, handler(self, self.setting))
end

--注销事件
function CardCell:unregEvent()
    g_msg:unreg(self.index, g_msgcmd.UI_Setting_Change)
end

function CardCell:setGray()
	self:setCascadeColorEnabled(true)
	self:setColor(cc.c3b(100,100,100))
end

local card_bg = {
  "green_mj_bg2.png",
  "blue_mj_bg2.png"
}

function CardCell:setting()
	local tablestyle = g_LocalDB:read("tablestyle")
	self:setSpriteFrame(card_bg[tablestyle])

end

function CardCell:setNormal()
	self:setColor(cc.c3b(255,255,255))
end

return CardCell