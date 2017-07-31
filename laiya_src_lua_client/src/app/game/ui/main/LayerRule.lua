--[[
    --回馈界面
]]--
local ccbFile = "loading/lobbyCsd/LayerRule.csb"

local LayerRule = class("LayerRule", function()
    local node = require("app.common.ui.UILockLayer").new()
    node:setNodeEventEnabled(true)
    return node
end)

function LayerRule:ctor(_cfg)
    self:initUI() 
end

 --初始化ui
function LayerRule:initUI()
    self:loadCCB()
end

--加载ui文件
function LayerRule:loadCCB()
    local _UI = cc.uiloader:load(ccbFile)
    _UI:addTo(self)

    local mBackground = _UI:getChildByName("layer_bg")
    local btnExit = mBackground:getChildByName("btn_exit")

    g_utils.setButtonClick(btnExit,handler(self,self.onBtnClick))
end

function LayerRule:onBtnClick( _sender )
    local s_name = _sender:getName()
    if s_name == "btn_exit" then
        g_SMG:removeLayer()
    elseif s_name == "btn_copy" then

    end
end


return LayerRule