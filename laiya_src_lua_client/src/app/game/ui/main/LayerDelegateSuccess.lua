--[[
    --回馈界面
]]--
local ccbFile = "loading/lobbyCsd/layer_delegatesuccess.csb"

local Layer_delegatesuccess = class("Layer_delegatesuccess", function()
    local node = require("app.common.ui.UILockLayer").new()
    node:setNodeEventEnabled(true)
    return node
end)


function Layer_delegatesuccess:ctor(_cfg)
    printTable("table ===== ",_cfg)
    self.data=_cfg
    self:initUI() 
end

 --初始化ui
function Layer_delegatesuccess:initUI()
    self:loadCCB()
end

--加载ui文件
function Layer_delegatesuccess:loadCCB()
    local _UI = cc.uiloader:load(ccbFile)
    _UI:addTo(self)

    local tx_roomid = _UI:getChildByName("Text_roomid")
    tx_roomid:setString(self.data.roomid)
    local tx_kouzuan = _UI:getChildByName("Text_kouzuan")
    print("limit======",self.data.RoundLimit)
    if self.data.RoundLimit == 4 then
        tx_kouzuan:setString("2颗钻石")
    else
        tx_kouzuan:setString("3颗钻石")
    end
    self.button_share = _UI:getChildByName("Button_1") 
    self.button_confirm = _UI:getChildByName("Button_1_0")
    g_utils.setButtonClick(self.button_share,handler(self,self.onBtnClick))
    g_utils.setButtonClick(self.button_confirm,handler(self,self.onBtnClick))
end
function Layer_delegatesuccess:onBtnClick( _sender )
    local s_name = _sender:getName()
    if s_name == "Button_1_0" then
        g_SMG:removeLayer()
    elseif s_name == "Button_1" then--分享
        local jinping = "来呀锦屏麻将"
        local rule = "房间号：" .. self.data.roomid .. " "
        
        local tx_ju = ""
        if self.data.RoundLimit == 4 then
             tx_ju="4局" 
        else
             tx_ju="8局"
        end

        rule = rule .. tx_ju .. " "
        local tx_rule = RoomDefine.RuleText[self.data.PlayRule]
        rule = rule .. tx_rule .. " "

        local tx_type = ""
        if self.data.IsMenGangMulti2 == 0 then
            tx_type = "自杠X2"
        else
            tx_type = "闷杠X2"
        end
        rule = rule .. tx_type
        g_ToLua:shareUrlWX("http://d.laiyagame.com/jinping/download.html",jinping,rule,0)
    end
end



return Layer_delegatesuccess