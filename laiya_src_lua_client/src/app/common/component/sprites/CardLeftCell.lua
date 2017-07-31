local CardLeftCell = class("CardLeftCell", function()  
	return  display.newSprite()
end)


function CardLeftCell:ctor()
	self:setting()
	self.index = g_data.cardSys:getIndex()
	self:regEvent()
end

function CardLeftCell:onCleanup()
    self:unregEvent()
end

--注册事件
function CardLeftCell:regEvent()

    g_msg:reg(self.index, g_msgcmd.UI_Setting_Change, handler(self, self.setting))
end

--注销事件
function CardLeftCell:unregEvent()
    g_msg:unreg(self.index, g_msgcmd.UI_Setting_Change)
end

local card_bg = {
  "green_mj_bg7.png",
  "blue_mj_bg7.png"
}


function CardLeftCell:setting()
	local tablestyle = g_LocalDB:read("tablestyle")
	self:setSpriteFrame(card_bg[tablestyle])
end

function CardLeftCell:setGray()
end

function CardLeftCell:setNormal()
end

return CardLeftCell