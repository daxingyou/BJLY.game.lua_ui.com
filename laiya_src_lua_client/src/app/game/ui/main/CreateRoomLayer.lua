
--[[
    --创建房间
]]--
local _cFile = "loading/lobbyCsd/LayerCreateRoom.csb"
local Layer_delegatesuccess = require("app.game.ui.main.LayerDelegateSuccess")
local CreateRoomLayer = class("CreateRoomLayer", function()
   local node = require("app.common.ui.UILockLayer").new()
    node:setNodeEventEnabled(true)
    return node
end)
local Http_Tag_Fefresh        = "Http_Tag_Fefresh" --刷新
function CreateRoomLayer:ctor(_cfg)
    --添加网络监听
    g_http.listeners("CreateRoomLayer",handler(self, self.httpSuccess),handler(self, self.httpFail))
    self:initUI() 
end

--加载ui文件
function CreateRoomLayer:loadCSB()

    local _UI = cc.uiloader:load(_cFile)
    _UI:addTo(self)
     
    local mBackground = _UI:getChildByName("layer_bg")
    local tb = {
        "checkbox_ju_4",
        "checkbox_ju_8",
        "checkbox_gang_men",
        "checkbox_gang_zhuangwan",
        "btn_createRoom",
        "img_click_4ju",
        "img_click_8ju",
        "img_click_meng",
        "img_click_zi",
        "btn_exit",
    }
    local  tb_imagerule = {
        "ck_game_0",
        "ck_game_1",
        "ck_game_2",
        "ck_game_3",
        "ck_game_4",
    }
    self.m_Root = {}
    for i =1 ,#tb do
        local _name = tb[i]
        self.m_Root[_name] = mBackground:getChildByName(_name)
       
        local _xx = string.find(_name,"checkbox")
        local _yy = string.find(_name,"img_click")
        if _xx == 1 or _yy == 1 then
            g_utils.setButtonClick(self.m_Root[_name] ,handler(self,self.onCheckboxClick))
        end
    end
    self.imageRule = {}
    for i=1,#tb_imagerule do
        local _name = tb_imagerule[i]
        print("===== _name =",_name)
        self.m_Root[_name] = mBackground:getChildByName("bg_ck"):getChildByName(_name)
        local _yy = string.find(_name,"ck_game")
        if _yy == 1 then
            g_utils.setButtonClick(self.m_Root[_name] ,handler(self,self.onCheckboxClick))
            self.imageRule[_name] = self.m_Root[_name]
            self.imageRule[_name]:setTag(i)
        end
    end
    self.m_Root["ck_game_0"]:setSelected(true)
    g_utils.setButtonClick(self.m_Root["btn_exit"],handler(self,self.onCloseClick))
    g_utils.setButtonClick(self.m_Root["btn_createRoom"],handler(self,self.onCtRmClick))
    self.rule = 1

    self.button_createDelegate = mBackground:getChildByName("btn_daikaifangjian")
    g_utils.setButtonClick(self.button_createDelegate,handler(self, self.onBtcreateDelegate))

    self.button_daikaijiku = mBackground:getChildByName("btn_daikaijilu")
    g_utils.setButtonClick(self.button_daikaijiku,handler(self, self.onBtCheckDaikai))


    print("deeeeeee=====",g_data.userSys.isdelegate)
    if g_data.userSys.isdelegate == 0 then--不能代开房间
        self.button_createDelegate:setVisible(false)
        self.button_createDelegate:setEnabled(false)
        self.button_daikaijiku:setVisible(false)
        self.button_daikaijiku:setEnabled(false)
    end


    if g_GameConfig.isGuest then
        mBackground:getChildByName("img_4ju"):setVisible(false)
        mBackground:getChildByName("txt_4ju_two"):setVisible(false)
        mBackground:getChildByName("img_8ju"):setVisible(false)
        mBackground:getChildByName("txt_8ju_three"):setVisible(false)
        mBackground:getChildByName("Text_1"):setVisible(false)
        mBackground:getChildByName("Text_1_0"):setVisible(false)
    end
end

function CreateRoomLayer:onBtCheckDaikai()
    local checktable = {
        accessKey = g_data.userSys.accessKey,
        DeviceID = g_data.userSys.openid,
        UserID =  g_data.userSys.UserID,
     }
     local url =  g_GameConfig.URL.."/getTableInfo"
       g_http.POST(url,checktable,"CreateRoomLayer", Http_Tag_Fefresh)
end

local creat_tabel_delegate = {}
function CreateRoomLayer:onBtcreateDelegate(_sender)
    local _RoundLimit = self.m_Root["checkbox_ju_4"]:isSelected() and 4 or 8
    local _IsMenGangMulti2 = self.m_Root["checkbox_gang_men"]:isSelected() and 1 or 0
    local _IsGenZhuang = 0

    creat_tabel_delegate = {
        RoundLimit= _RoundLimit,
        IsMenGangMulti2= _IsMenGangMulti2,
        IsGenZhuang= _IsGenZhuang,
        PlayRule = self.rule,

        accessKey = g_data.userSys.accessKey,
        DeviceID = g_data.userSys.openid,
        UserID =  g_data.userSys.UserID,
        ReplaceTable = 1,
    }
    g_data.roomSys.m_roomInfo.ReplaceTable = 1
    printTable("creat_tabel=",creat_tabel_delegate)
    local url =  g_GameConfig.URL.."/createroom"  -- 登陆
    self:performWithDelay(function()
            g_http.POST(url,creat_tabel_delegate,"CreateRoomLayer", "crtRoom")
        end, 0.1)
     g_SMG:addWaitLayer()
end
--创建房间选项
function CreateRoomLayer:onCheckboxClick(_sender)
    local s_name = _sender:getName()
    --局数选择
    if s_name == "checkbox_ju_4" or s_name == "checkbox_ju_8" or s_name == "img_click_4ju" or s_name == "img_click_8ju" then
        self.m_Root["checkbox_ju_4"]:setSelected(false)
        self.m_Root["checkbox_ju_8"]:setSelected(false)

        if _sender.setSelected then
            _sender:setSelected(true)
        end
        if s_name == "img_click_4ju" then
            self.m_Root["checkbox_ju_4"]:setSelected(true)
        elseif s_name == "img_click_8ju" then
            self.m_Root["checkbox_ju_8"]:setSelected(true)
        end
    end
    --玩法
    if s_name == "checkbox_gang_men" or s_name == "checkbox_gang_zhuangwan" or s_name == "img_click_meng" or s_name == "img_click_zi" then
        self.m_Root["checkbox_gang_men"]:setSelected(false)
        self.m_Root["checkbox_gang_zhuangwan"]:setSelected(false)

        if _sender.setSelected then
            _sender:setSelected(true)
        end
        if s_name == "img_click_meng" then
            self.m_Root["checkbox_gang_men"]:setSelected(true)
        elseif s_name == "img_click_zi" then
            self.m_Root["checkbox_gang_zhuangwan"]:setSelected(true)
        end
    end
    local  _xx = string.find(s_name,"ck_game")
    if  _xx== 1 then
        for i , v in pairs(self.imageRule) do
            v:setSelected(false)
        end
        self.imageRule[s_name]:setSelected(true)
        self.rule = self.imageRule[s_name]:getTag()
    end
end

--创建房间
local creat_tabel = {}
function CreateRoomLayer:onCtRmClick(_sender)
    local _RoundLimit = self.m_Root["checkbox_ju_4"]:isSelected() and 4 or 8
    local _IsMenGangMulti2 = self.m_Root["checkbox_gang_men"]:isSelected() and 1 or 0
    local _IsGenZhuang = 0

    creat_tabel = {
        RoundLimit= _RoundLimit,
        IsMenGangMulti2= _IsMenGangMulti2,
        IsGenZhuang= _IsGenZhuang,
        PlayRule = self.rule,

        accessKey = g_data.userSys.accessKey,
        DeviceID = g_data.userSys.openid,
        UserID =  g_data.userSys.UserID,
        ReplaceTable = 0,
    }
    g_data.roomSys.m_roomInfo.ReplaceTable = 0
    printTable("creat_tabel=",creat_tabel)
    local url =  g_GameConfig.URL.."/createroom"  -- 登陆
    self:performWithDelay(function()
            g_http.POST(url,creat_tabel,"CreateRoomLayer", "crtRoom")
        end, 0.1)
     g_SMG:addWaitLayer()
end

 --初始化ui
function CreateRoomLayer:initUI()
    self:loadCSB()
end

--http成功
function CreateRoomLayer:httpSuccess(_response, _tag)
    print("httpSuccess", _tag)
    if not _response then
        print("ERROR _response 没有数据")
        return
    end

    local ok = false
    for i=1,1 do
        --请求客户端版本
        if "crtRoom" == _tag then
            -- self:performWithDelay(function() g_SMG:removeWaitLayer()  end, 0.1)
            g_SMG:removeWaitLayer() 
            print("====创建房间成功")
            --不保存本地，直接读取
            local tb = json.decode(_response)
            printTable("response_tb", tb)
            if not tb then break end

            if tb.ResultCode == -1 then
                local LayerTipError = g_UILayer.Common.LayerTipError.new(tb.ErrMsg)
                g_SMG:addLayer(LayerTipError)
                return
            end
            if tb.ResultCode == 3 then
                local LayerTipError = g_UILayer.Common.LayerTipError.new(tb.ErrMsg)
                g_SMG:addLayer(LayerTipError)
                return
            end
            g_GameConfig.kServerAddr = tb.Host
            g_GameConfig.kServerPort = tb.Port
            g_data.roomSys.kTableID  = tb.TableID
            g_GameConfig.kSeatID     = tb.SeatID
            g_data.roomSys.Owner     = tb.Owner
            creat_tabel.roomId       = tb.TableID
            g_data.roomSys:updateGameRule(creat_tabel)
            if g_data.roomSys.m_roomInfo.ReplaceTable == 1 then--此房间是代开的
                print("代开成功 代开的房间号是",tb.TableID)
                --弹出代开房间成功的消息
                creat_tabel_delegate.roomid =tb.TableID
                local layer_delegatesuceess=Layer_delegatesuccess.new(creat_tabel_delegate)
                g_SMG:addLayer(layer_delegatesuceess)
                return
            end
            g_netMgr:connectGameServer()
            
        elseif Http_Tag_Fefresh == _tag then
            printTable("tb========",tb)
            local tb = json.decode(_response)
            printTable("response_tb", tb)
            if not tb then break end
            if tb.ResultCode ~= 0 then
            local LayerTipError = g_UILayer.Common.LayerTipError.new(tb.ErrMsg)
            g_SMG:addLayer(LayerTipError)
                return
            end
               local layer = g_UILayer.Main.UIDelegateRoomLsyer.new(tb)
               g_SMG:addLayer(layer)
        end
        ok = true


    end
    --失败处理
    if not ok then
        self:httpFail({code="101", response=""}, _tag)
    end
end

--关闭页面
function CreateRoomLayer:onCloseClick()
    g_SMG:removeLayer()
end

--http失败
function CreateRoomLayer:httpFail(_response, _tag)
    g_SMG:removeWaitLayer()
    print("httpFail", _response, _tag)
    printTable("_response",_response)
end

return CreateRoomLayer