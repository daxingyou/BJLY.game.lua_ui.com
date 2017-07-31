--[[
    --回馈界面
]]--
local CellItemRecord = require("app.game.ui.main.CellItem.CellItemRecord_Main")
local ccbFile = "loading/lobbyCsd/LayerRecord.csb"

local LayerRecord = class("LayerRecord", function()
    local node = require("app.common.ui.UILockLayer").new()
    node:setNodeEventEnabled(true)
    return cc.Layer:create()
end)

function LayerRecord:ctor(_cfg)
    self.cgf = _cfg["HistoryData"]
    dump(self.cfg, "history------------------------")
    self:initUI() 
end

 --初始化ui
function LayerRecord:initUI()
    self:loadCCB()
end

--加载ui文件
function LayerRecord:loadCCB()
    local _UI = cc.uiloader:load(ccbFile)
    _UI:addTo(self)

    local mBackground = _UI:getChildByName("layer_bg")
    local btnExit = mBackground:getChildByName("btn_exit")

    g_utils.setButtonClick(btnExit,handler(self,self.onBtnClick))

    local lvMsg = mBackground:getChildByName("listView_record")
    local __cname = tolua.type(lvMsg)

    print("*************************LayerMessage==",__cname,lvMsg)

    local this = self
    local function cellClickHandle( id )
        print("------cellClickHandle------",id)
        --此处处理次级界面的展现------------------------------------
        local  tb = {}
        tb.RoomID = this.cgf[id].RoomID
        tb.PlayRule = this.cgf[id].PlayRule
        tb.Round = this.cgf[id].Round
        local layer = require("app.game.ui.main.LayerRecordDetail").new(tb)
         g_SMG:addLayer(layer)
    end
    for i=1,#self.cgf do
        local  data = self.cgf[i]
        data.index = i
        local cell = CellItemRecord.new(data)
        cell:setClickHandle(cellClickHandle)

        local layout = ccui.Layout:create()
        layout:setTouchEnabled(true)
        layout:setContentSize(cell:getContentSize()) 
        layout:addChild(cell)
        lvMsg:pushBackCustomItem(layout)
    end
end

function LayerRecord:onBtnClick( _sender )
    local s_name = _sender:getName()
    if s_name == "btn_exit" then
        g_SMG:removeLayer()
    elseif s_name == "btn_copy" then

    end
end


return LayerRecord