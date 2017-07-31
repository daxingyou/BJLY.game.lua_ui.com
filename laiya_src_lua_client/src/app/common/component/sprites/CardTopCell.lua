local CardTopCell = class("CardTopCell", function()  
	local sprite = display.newSprite()
	sprite:setNodeEventEnabled(true)
	return sprite
end)


function CardTopCell:ctor()
	self:setting()
	self.index = g_data.cardSys:getIndex()
	self:regEvent()
end

function CardTopCell:onCleanup()
    self:unregEvent()
end

--注册事件
function CardTopCell:regEvent()

    g_msg:reg(self.index, g_msgcmd.UI_Setting_Change, handler(self, self.setting))
end

--注销事件
function CardTopCell:unregEvent()
    g_msg:unreg(self.index, g_msgcmd.UI_Setting_Change)
end

local card_bg = {
  "green_mj_bg5.png",
  "blue_mj_bg5.png"
}


function CardTopCell:setting()
	local tablestyle = g_LocalDB:read("tablestyle")
	self:setSpriteFrame(card_bg[tablestyle])
end

function CardTopCell:setGray()
end

function CardTopCell:setNormal()
end

return CardTopCell