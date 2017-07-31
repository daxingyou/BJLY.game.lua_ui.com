
--[[
  房间内断线重连
]]--

local ccbfile = "ccb/netconnectTip.ccbi"
local NetconnectTip = class("NetconnectTip", function()
    local node = require("app.common.ui.UILockLayer").new()
    node:setNodeEventEnabled(true)
    return node
end)

local Http_Tag_LOGIN        = "HTTP_Tag_LOGIN" --登陆借口
local Http_Tag_WX_UserInfo  = "Http_Tag_WX_UserInfo" --请求用户信息
local Http_Tag_EnterRoom    = "Http_Tag_EnterRoom"

function NetconnectTip:ctor()
	self:load_ccb()
    g_http.listeners("NetconnectTip",
        handler(self, self.httpSuccess),
        handler(self, self.httpFail))
end

function NetconnectTip:onCleanup()
    g_http.unlisteners("NetconnectTip")
end

function NetconnectTip:load_ccb()
    self.m_ccbRoot = {
    	["onSureClick"] = function(_sender, _event) self:onSureClick(_sender, _event) end,
	}
    local proxy = cc.CCBProxy:create()
    local node  =  CCBReaderLoad(ccbfile, proxy, self.m_ccbRoot)
    node:addTo(self)
end

--重新连接
function NetconnectTip:onSureClick()

    -- 断线重连
    local url = g_GameConfig.URL.."/weichat_login"
    self:performWithDelay(function() g_http.POST(url, g_data.userSys.userInfo,"NetconnectTip", Http_Tag_LOGIN) end, 0.1)
    g_SMG:addWaitLayer()
end

--http成功
function NetconnectTip:httpSuccess(response, _tag)
    if not response then
        app:enterLoadingScene()
        return
    end
    local ok = false
    for i=1,1 do
        if Http_Tag_LOGIN == _tag then
            --不保存本地，直接读取
            local tb = json.decode(response)
            printTable("tb",tb)

            if not tb then
                app:enterLoadingScene()
                break
            end
            self:Login_Success(tb)
        end
        --短线重连
        if Http_Tag_EnterRoom == _tag then
            --不保存本地，直接读取
            local tb = json.decode(response)
            if tb.ResultCode == -1 then
                app:enterLoadingScene()
                return
            end
            g_GameConfig.kServerAddr = tb.Host
            g_GameConfig.kServerPort = tb.Port
            g_data.roomSys.kTableID  = tb.TableID
            g_GameConfig.kSeatID     = tb.SeatID
            g_data.roomSys.Owner     = tb.Owner
            g_data.roomSys:updateGameRule(tb)
            app:transitionScene()
            -- g_netMgr:connectGameServer()
        end
        ok = true
    end
    --失败处理
    if not ok then
        self:httpFail({code="101", response=""}, _tag)
    end
end

--登录成功
function NetconnectTip:Login_Success(info)
    g_data.userSys:updateServerInfo(info)
    
    if info.RoomID then
        if info.RoomID <1 then app:enterLoadingScene()  end
        local url =  g_GameConfig.URL.."/enterroom"
        local tb = {
            RoomID = info.RoomID,
            accessKey = g_data.userSys.accessKey,
            DeviceID = g_data.userSys.openid,
            UserID =  g_data.userSys.UserID,
        }
        g_http.POST(url,tb,"NetconnectTip", Http_Tag_EnterRoom)
    else
        app:enterLoadingScene()
    end
end

--http失败
function NetconnectTip:httpFail(response, _tag)
    g_SMG:removeWaitLayer()
    print("httpFail", response, _tag)
   app:enterLoadingScene()
end

function NetconnectTip:enterRoom()
    app:enterRoomScene()
end

return NetconnectTip