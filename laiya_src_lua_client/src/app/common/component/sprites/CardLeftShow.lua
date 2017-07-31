local ccbfile = "ccb/cardLeftShow.ccbi"

local CardLeftShow = class("CardLeftShow", function()

    return cc.Node:create()
end)

function CardLeftShow:ctor(pic)
	self:setContentSize(cc.size(122, 98))
	self:load_ccb()
	self:init(pic)
end


--加载ccbi
function CardLeftShow:load_ccb()
    self.m_ccbRoot = {}
    local proxy = cc.CCBProxy:create()
    local node  = CCBReaderLoad(ccbfile, proxy, self.m_ccbRoot)
    node:addTo(self)
end

function CardLeftShow:init(pic)
	self.m_ccbRoot.m_Value:setSpriteFrame(pic)
end

function CardLeftShow:setGray()
end

function CardLeftShow:setNormal()
end

return CardLeftShow