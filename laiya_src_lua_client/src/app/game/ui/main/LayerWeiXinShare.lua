--[[
    --回馈界面
]]--
local ccbFile = "loading/lobbyCsd/LayerWeiXinShare.csb"

local m = class("LayerWeiXinShare", function()
    local node = require("app.common.ui.UILockLayer").new()
    node:setNodeEventEnabled(true)
    return node
end)

function m:ctor(_cfg)
    self:initUI() 
end

 --初始化ui
function m:initUI()
    self:loadCCB()
    self:setTouchEndedFunc(function()
        g_SMG:removeLayer()
    end)
end

--加载ui文件
function m:loadCCB()
    local _UI = cc.uiloader:load(ccbFile)
    _UI:addTo(self)

    local mBackground = _UI:getChildByName("layer_bg")
    local ctlName = {"btn_share_qun","btn_share_quan"}
    for i,v in ipairs(ctlName) do  
        local btn = mBackground:getChildByName(v)
        g_utils.setButtonClick(btn,handler(self,self.onBtnClick))
    end
end

function m:onBtnClick( _sender )
    local s_name = _sender:getName()
    if s_name == "btn_share_qun" then
        self:shareUrlWX(g_ToLua.shareType.friendQun)
    elseif s_name == "btn_share_quan" then
        self:shareUrlWX(g_ToLua.shareType.friendCircle)
    end
end

function m:shareUrlWX(_type)
    local appName = "来呀锦屏麻将"
    local shareDes = "最正宗的锦屏麻将,好友约局神器,快来一起加入吧!邀请码:%s,记得要绑定我呦!"
    local shareUrl = "http://d.laiyagame.com/jinping/download.html"    
    shareDes = string.format(shareDes,g_data.userSys.InviteCode or 0)
    print("shareDes-------",shareDes,_type)
    if _type == g_ToLua.shareType.friendCircle then
        g_ToLua:shareUrlWX(shareUrl,shareDes,shareDes,_type)
    else
        g_ToLua:shareUrlWX(shareUrl,appName,shareDes,_type)
    end
end

return m