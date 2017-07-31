local ccbfile = "ccb/cardRightShow.ccbi"

local CardRightShow = class("CardRightShow", function()

    return cc.Node:create()
end)

function CardRightShow:ctor(pic)
	self:setContentSize(cc.size(122, 98))
	self:load_ccb()
	self:init(pic)
end


--加载ccbi
function CardRightShow:load_ccb()
    self.m_ccbRoot = {}
    local proxy = cc.CCBProxy:create()
    local node  = CCBReaderLoad(ccbfile, proxy, self.m_ccbRoot)
    node:addTo(self)
end

function CardRightShow:init(pic)
	self.m_ccbRoot.m_Value:setSpriteFrame(pic)
end

function CardRightShow:setGray()
end

function CardRightShow:setNormal()
end

return CardRightShow