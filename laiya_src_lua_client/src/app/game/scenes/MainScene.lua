--[[
  主场景
]]
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)
local csbFile = "loading/GameMenu.csb"
local n = {
    loadHeadIconKey = "loadHeadIconKey",
    getDelegateTableInfo = "getDelegateTableInfo",
}

function MainScene:ctor()
    g_http.listeners("MainScene",
        handler(self, self.httpSuccess),
        handler(self, self.httpFail))

    self:uiLoadAndShow()
    self:regEvent()
    self:loadHeadIcon()
    self:addTouchLayer()--家返回监听
    
end
function MainScene:addTouchLayer()
    local layer = display.newLayer()      
    self:addChild(layer,-10)    
    layer:setKeypadEnabled(true)    
    layer:addNodeEventListener(cc.KEYPAD_EVENT, function (event)    
        if event.key == "back" then  --返回键  
            --弹出退出框
           local quit = require("app.game.ui.main.LayerQuit").new()
           g_SMG:addLayer(quit)
        end       
    end)
end

function MainScene:regEvent()
    g_msg:reg("MainScene", g_enumKey.CustomEventKey.Laba,handler(self,self.LabaHandle))
    g_msg:reg("MainScene", g_enumKey.CustomEventKey.UpdateHeadInfo,handler(self,self.updateHeadInfo))

    g_http.listeners(n.loadHeadIconKey,handler(self, self.httpSuccess),handler(self, self.httpFail))  
    g_http.listeners(n.getDelegateTableInfo,handler(self, self.httpSuccess),handler(self, self.httpFail)) 
    g_J2LuaSystem.regJ2LuaFunc(g_J2LuaSystem.J2Lua_WeiXinShare,handler(self,self.J2Lua_WeiXinShare)) 
end
function MainScene:unregEvent()
    g_msg:unreg("MainScene", g_enumKey.CustomEventKey.Laba)
    g_msg:unreg("MainScene", g_enumKey.CustomEventKey.UpdateHeadInfo)
end
--J2LUA
function MainScene:J2Lua_WeiXinShare( value )
    print("LoginLayer:J2Lua_WeiXinshare---value:",value)
    if value == 4 then
    local tb = {
        accessKey = g_data.userSys.accessKey,
        DeviceID = g_data.userSys.openid,
        UserID =  g_data.userSys.UserID,
    }
    local url =  g_GameConfig.URL.."/shareWxCircle"
    self:performWithDelay(function() g_http.POST(url, tb,"MainScene", "shareWxCircle") end, 0.1)
    end
    
end
--清理
function MainScene:onCleanup()
    self:unregEvent()
end

function MainScene:uiLoadAndShow()
	local _UI = cc.uiloader:load(csbFile)
    _UI:addTo(self)

    local tb = {"btnCreateRoom","btnJoinRoom","btnShareCircle","btn_msg","btnSet","btn_binding","btnHelp","btn_activity","btnAchievement","btn_feedback","goldBarBg"}
    self.m_Root = {}
    for i =1 ,#tb do
        local _name = tb[i]
        self.m_Root[_name] = _UI:getChildByName(_name)
        g_utils.setButtonClick(self.m_Root[_name],handler(self,self.onHandleClick))
    end

    local m_LogoSprite = _UI:getChildByName("slogan_1")
    self.m_ccbRoot = {}
    local ccbfile = "ccb/particle_xingxing.ccbi"
    local proxy = cc.CCBProxy:create()
    local node  = CCBReaderLoad(ccbfile, proxy, self.m_ccbRoot)

    node:addTo(m_LogoSprite)

    local particleFile = "csb/CSDPeach1.csb"
    local partic = cc.uiloader:load(particleFile)
    local x,y   = self.m_Root.btnSet:getPosition()
    partic:setPosition(cc.p(x,y))
    partic:addTo(_UI)
    
    local btn = _UI:getChildByName("headInfoSet"):getChildByName("btn_head_frame")
    g_utils.setButtonClick(btn,handler(self,self.onHandleClick))

    self._panelLaba = _UI:getChildByName("panelNotice")
    self._labaTxt = self._panelLaba:getChildByName("Text_notice")

    local click = _UI:getChildByName("headInfoSet"):getChildByName("iv_click")
    g_utils.setButtonClick(click,handler(self,self.onHandleClick))

    self._headInfoCtl = {}
    local ctrlName = {"goldNum","headIcon"}
    for i =1 ,#ctrlName do
        local _name = ctrlName[i]
        self._headInfoCtl[_name] = _UI:getChildByName("headInfoSet"):getChildByName(_name)
    end
    self._headInfoCtl["goldNum"]:setString(0) --默认为0
    _UI:getChildByName("headInfoSet"):getChildByName("nickName"):setString(g_data.userSys.nickname)
    _UI:getChildByName("headInfoSet"):getChildByName("userId"):setString(g_data.userSys.UserID)
  
    local action = cc.CSLoader:createTimeline(csbFile) 
    action:play("anim_gift",true)
    self:runAction(action)


    if g_GameConfig.isGuest then
        self.m_Root["btn_binding"]:setVisible(false)
        self.m_Root["btn_activity"]:setVisible(false)
        self.m_Root["btn_feedback"]:setVisible(false)
        self.m_Root["btnShareCircle"]:setVisible(false)

        self._panelLaba:setVisible(false)
        _UI:getChildByName("Sprite_9"):setVisible(false)
        click:setVisible(false)
        _UI:getChildByName("headInfoSet"):getChildByName("icon_fangka_7"):setVisible(false)
        _UI:getChildByName("headInfoSet"):getChildByName("goldNum"):setVisible(false)
        _UI:getChildByName("headInfoSet"):getChildByName("btn_addCard"):setVisible(false)
    end
end

function MainScene:onHandleClick( _sender )
    local btnName = _sender:getName()
    if btnName == 'btnCreateRoom' then    
        local ctrmly = g_UILayer.Main.UICreateRoom.new()
        g_SMG:addLayer(ctrmly)
    elseif btnName == "btnJoinRoom" then
        local layer = g_UILayer.Main.UIJoinRoom.new()
        g_SMG:addLayer(layer)    
    elseif btnName == "btnShareCircle" then
        local layer = g_UILayer.Main.UIShare.new()
        g_SMG:addLayer(layer)
    elseif btnName == "btn_msg" then
        g_LobbyCtl:showUIWithNetData(g_LobbyCtl.subUIName.UIMessage)
    elseif btnName == "btnSet" then
       g_LobbyCtl:showUIWithLocalData(g_LobbyCtl.subUIName.UISetting)
    
    elseif btnName == "btn_binding" then
        g_LobbyCtl:showUIWithLocalData(g_LobbyCtl.subUIName.UIBinding)
    elseif btnName == "btnHelp" then
        local layer = g_UILayer.Main.UIRule.new()
        g_SMG:addLayer(layer)
    elseif btnName == "btn_activity" then 
        g_LobbyCtl:showUIWithLocalData(g_LobbyCtl.subUIName.UIActivity)
    elseif btnName == "btnAchievement" then
        g_LobbyCtl:showUIWithNetData(g_LobbyCtl.subUIName.UIRecord)
    elseif btnName == "btn_feedback" then
        g_LobbyCtl:showUIWithLocalData(g_LobbyCtl.subUIName.UIFeedback)
    elseif btnName == "btn_head_frame" then
        g_LobbyCtl:showUIWithNetData(g_LobbyCtl.subUIName.UISelfInfo)
    elseif btnName == "iv_click" then
        g_LobbyCtl:showUIWithLocalData(g_LobbyCtl.subUIName.UIAddCard)
    end
end



function MainScene:onEnter()
    g_LobbyCtl:getContactInfo()
    g_LobbyCtl:updateGoldNum()
end

function MainScene:onExit()
    self._labaTxt:stopAllActions()
end

--http成功
function MainScene:httpSuccess(_response, _tag)
    print("httpSuccess", _tag)
    if not _response then
        print("ERROR _response 没有数据")
        return
    end
    if _tag == n.loadHeadIconKey then
        local path = device.writablePath .. g_data.userSys.UserID .. ".png"     
        g_msg:post(g_enumKey.CustomEventKey.UpdateHeadInfo,{headIconPath=path})
        return
    end
    local ok = false
    for i=1,1 do
        ok = true
    end
    --失败处理
    if not ok then
        self:httpFail({code="101", response=""}, _tag)
    end
end

--http失败
function MainScene:httpFail(_response, _tag)
    print("httpFail", _response, _tag)
    printTable("_response",_response)
end

function MainScene:LabaHandle(labaTxtEvent)
    self._labaTxt:setString(labaTxtEvent.data)
    self:runLabaAnim()
end

function MainScene:runLabaAnim()
    self._labaTxt:stopAllActions()
    local txtWidth,panelWidth = self._labaTxt:getContentSize().width,self._panelLaba:getContentSize().width
    self._labaTxt:setPositionX(panelWidth+10)
    local act1 = cc.CallFunc:create(function()
        self._labaTxt:setPositionX(panelWidth+10)
    end)
    local act2 = cc.MoveBy:create(20,cc.p(0-panelWidth-txtWidth,0))
    local act3 = cc.DelayTime:create(2)
    local seq = cc.Sequence:create(act1, act2,act3)
    local rep = cc.RepeatForever:create(seq)
    self._labaTxt:runAction(rep)
end

function MainScene:updateHeadInfo(infoEvent)
    if infoEvent.data.goldNum then
        self._headInfoCtl["goldNum"]:setString(infoEvent.data.goldNum)
    end

    if infoEvent.data.headIconPath then
        local sprite_head_icon = cc.Sprite:create(infoEvent.data.headIconPath)
        if sprite_head_icon then
            self._headInfoCtl["headIcon"]:setTexture(sprite_head_icon:getTexture())
        end
    end
end

function MainScene:loadHeadIcon()
    local path = device.writablePath .. g_data.userSys.UserID .. ".png"
    if FileUtils.file_exists(path) then             
        g_msg:post(g_enumKey.CustomEventKey.UpdateHeadInfo,{headIconPath=path})
    else
        if string.len(g_data.userSys.headimgurl) > 5 then
            g_http.Download(g_data.userSys.headimgurl,n.loadHeadIconKey,n.loadHeadIconKey,path)
        end
    end
end

return MainScene
