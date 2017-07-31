local CardRightCell = class("CardRightCell", function()  
	local sprite = display.newSprite()
	sprite:setFlippedX(true)
	return  sprite
end)



function CardRightCell:ctor()
	self:setting()
	self.index = g_data.cardSys:getIndex()
	self:regEvent()
end

function CardRightCell:onCleanup()
    self:unregEvent()
end

--注册事件
function CardRightCell:regEvent()

    g_msg:reg(self.index, g_msgcmd.UI_Setting_Change, handler(self, self.setting))
end

--注销事件
function CardRightCell:unregEvent()
    g_msg:unreg(self.index, g_msgcmd.UI_Setting_Change)
end

local card_bg = {
  "green_mj_bg7.png",
  "blue_mj_bg7.png"
}

function CardRightCell:setting()
	local tablestyle = g_LocalDB:read("tablestyle")
	self:setSpriteFrame(card_bg[tablestyle])
end

function CardRightCell:setGray()
end

function CardRightCell:setNormal()
end

return CardRightCell