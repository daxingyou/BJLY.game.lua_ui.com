
--[[
--翻牌鸡
]]--

local _File = "loading/Layer_fanpaiji.csb"
local FanPaiJiLayer = class("FanPaiJiLayer", function()
    local node = require("app.common.ui.UILockLayer").new()
    node:setNodeEventEnabled(true)
    return node
end)

function FanPaiJiLayer:ctor()
    self:initUI() 
end

function FanPaiJiLayer:initUI()
	local _UI = cc.uiloader:load(_File)
    _UI:addTo(self)
    local mCardBody = _UI:getChildByName("mCardBody")
    self.mValueSprite = mCardBody:getChildByName("mValueSprite")

    local roundReport = g_data.reportSys:getRoundReport()
    local cardEnum    = roundReport.fanpaiji_cardid
    if cardEnum == 1 then
        cardEnum = 9
    elseif cardEnum == 17  then
        cardEnum = 25
    elseif cardEnum == 33  then
        cardEnum = 41
    else
        cardEnum = cardEnum -1
    end

    self.mValueSprite:setSpriteFrame(CardDefine.enum[cardEnum][2])
    self:toRound()
end

function FanPaiJiLayer:toRound( ... )
    self:performWithDelay(
    function()
        g_SMG:removeLayer()
        g_SMG:addLayer(require("app.game.ui.main.LayerResultOneRound").new())
    end, 2.0)
end

return FanPaiJiLayer