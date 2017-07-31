--[[
    --回馈界面
]]--
local CellItemTotal = require("app.game.ui.main.CellItem.CellItemResultTotal")
local ccbFile = "loading/lobbyCsd/Layer_result3.csb"

local shareFlag = false

local LayerResultFinal = class("LayerResultFinal", function()
    local node = require("app.common.ui.UILockLayer").new()
    node:setNodeEventEnabled(true)
    return node
end)

function LayerResultFinal:ctor()
    --退出语音房间
    g_gcloudvoice:quickteamroom(g_data.roomSys.kTableID)

    self:initUI() 
    self:setName("LayerResultFinal")
end

 --初始化ui
function LayerResultFinal:initUI()
    self:loadCCB()
end

--加载ui文件
function LayerResultFinal:loadCCB()
    local _UI = cc.uiloader:load(ccbFile)
    _UI:addTo(self)

    local  button_return = _UI:getChildByName("Button_1")
    local  button_share = _UI:getChildByName("Button_1_0")
    if g_GameConfig.isGuest == true then
        button_share:setVisible(false)
        button_share:setEnabled(false)
    end
    g_utils.setButtonClick(button_return,handler(self,self.onBtnClick))
    g_utils.setButtonClick(button_share,handler(self,self.onBtnClick))
    --加入cell
    local p_x = {
     294,
     537,
     775,
     1019,
    }
    local report = g_data.reportSys:getFinalReport()
    printTable("report = ",report)
    for k,v in pairs(report) do
        local  cellitem_total = CellItemTotal.new(v)
        cellitem_total:setPosition(p_x[k],597)
        self:addChild(cellitem_total, 2)
    end 
end

function LayerResultFinal:onBtnClick( _sender )
    local s_name = _sender:getName()
    if s_name == "Button_1" then
        --返回大厅
        g_utils.setButtonLockTime(_sender,0.5)
        app:enterMainScene()
    elseif s_name == "Button_1_0" then
        --分享
        if not shareFlag then
            shareFlag = true
            g_ToLua:printScreen("share.png")
            self:performWithDelay(function ()
                g_ToLua:shareImageWX(device.writablePath.."share.png", 0)
                shareFlag=false
            end, 0.05)
        end
    end
end

return LayerResultFinal