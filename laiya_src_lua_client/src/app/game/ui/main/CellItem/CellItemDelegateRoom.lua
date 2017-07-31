--[[
    --回馈界面
]]--
local ccbFile = "loading/lobbyCsd/cell_delegateroom.csb"
local Scheduler = require("framework.scheduler")
local CellItemDelegateRoom = class("CellItemDelegateRoom", function()
    local node  = cc.Layer:create()
    node:setNodeEventEnabled(true)
    return node
end)
function CellItemDelegateRoom:UpdatesetIcon(dt)
    for i= 1 ,#self._cfg.user_info do
        local path = device.writablePath..self._cfg.user_info[i].user_id..".png"
        if FileUtils.file_exists(path) == true then--已经存在就直接复制
           for j=1,#self.tb_head do
            if self.tb_head[j]:getTag() == self._cfg.user_info[i].user_id then
                self.tb_head[j]:getChildByName("head_1"):setTexture(path)
                self.tb_head[j]:getChildByName("head_1"):setScale(90.0/self.tb_head[j]:getChildByName("head_1"):getContentSize().width)
            end
           end
        end   
    end
end
function CellItemDelegateRoom:ctor(_cfg)  
    self._cfg = _cfg 
    if self._cfg.table_type == "四人房" then
        self.num_icon = 4
        elseif self._cfg.table_type == "三丁拐" or self._cfg.table_type == "三丁两房" then
            self.num_icon = 3
            elseif self._cfg.table_type == "二丁拐" or self._cfg.table_type =="二丁两房" then
                self.num_icon = 2 
    end
    self.tb_head = {}
    self:initUI()
    self.scheduler_tick = Scheduler.scheduleGlobal(function() self:UpdatesetIcon(0.1) end, 0.1)
end
function CellItemDelegateRoom:onExit()
    
end
function CellItemDelegateRoom:onCleanup()
    print("cleanup------")
    Scheduler.unscheduleGlobal(self.scheduler_tick)
end

function CellItemDelegateRoom:httpSuccessLoadImg(_response,_tag)
   
end
function CellItemDelegateRoom:httpFail( _response,_tag )
   
end
 --初始化ui
function CellItemDelegateRoom:initUI()
    self:loadCCB()
end

function CellItemDelegateRoom:httpSuccess(response, _tag)
    print("success")
    if not response then
        print("ERROR _response 没有数据")
        return
    end  
end
--加载ui文件
function CellItemDelegateRoom:loadCCB()
    local _UI = cc.uiloader:load(ccbFile)
    _UI:addTo(self)
--基本信息
    local  tx_roomid = _UI:getChildByName("Text_id")
    tx_roomid:setString(self._cfg.table_id)
    local  tx_status = _UI:getChildByName("Text_status")
    if self._cfg.table_status == 0 then
       tx_status:setString("未开始")
    elseif self._cfg.table_status == 1 then
        tx_status:setString("进行中")
    elseif self._cfg.table_status == 2 then
        tx_status:setString("已完成")
    end
    
    local  tx_time = _UI:getChildByName("Text_time")
    tx_time:setString(self._cfg.create_time)
    local  tx_jushu = _UI:getChildByName("Text_jushu")
    tx_jushu:setString(self._cfg.round_num)
    local  tx_type = _UI:getChildByName("Text_type")
    tx_type:setString(self._cfg.table_type)
    local  tx_gang_type = _UI:getChildByName("Text_gangtype")
    tx_gang_type:setString(self._cfg.gang)

    
--玩家信息
    for i=1,4 do
        local path = "icon_"..tostring(i) 
        local icon = _UI:getChildByName(path)
        local head = icon:getChildByName("head_1")
        print("#self._cfg.user_info",#self._cfg.user_info)
        if i > #self._cfg.user_info then
            --icon:setVisible(false)
            print("i====",i)
        else
            icon:setTag(self._cfg.user_info[i].user_id)
            self.tb_head[i] = icon 
        end
        local name_path = "name_"..i
        local tx_name = _UI:getChildByName(name_path)
        if i > #self._cfg.user_info then
            tx_name:setVisible(false)
        else
            tx_name:setString(self._cfg.user_info[i].nick_name)
        end

        if i > self.num_icon then
            icon:setVisible(false)
        end
    end
    --下载头像
    for i= 1 ,#self._cfg.user_info do
        local path = device.writablePath..self._cfg.user_info[i].user_id..".png"
        if FileUtils.file_exists(path) == true then--已经存在就直接复制
           for j=1,#self.tb_head do
            if self.tb_head[j]:getTag() == self._cfg.user_info[i].user_id then
                self.tb_head[j]:getChildByName("head_1"):setTexture(path)
                self.tb_head[j]:getChildByName("head_1"):setScale(90.0/self.tb_head[j]:getChildByName("head_1"):getContentSize().width)
                
            end
           end
        else
            if string.len(self._cfg.user_info[i].user_face_img_url)  >= 10 then
               g_http.Download(self._cfg.user_info[i].user_face_img_url,tostring(self._cfg.user_info[i].user_id),tostring(self._cfg.user_info[i].user_id),path)
            end
        end    
    end

--按钮

    self.button_invite=_UI:getChildByName("Button_invite")

    g_utils.setButtonClick(self.button_invite,handler(self,self.onBtnClick))

    self.button_dismiss=_UI:getChildByName("Button_dismiss")

    g_utils.setButtonClick(self.button_dismiss,handler(self,self.onBtnClick))
  
end
function CellItemDelegateRoom:setType(celltype)
    if celltype == 1 then --代开房间
        self.button_invite:setVisible(true)
        self.button_invite:setEnabled(true)
        self.button_dismiss:setVisible(true)
        self.button_dismiss:setEnabled(true)
        elseif celltype == 0 then
          self.button_invite:setVisible(false)
          self.button_invite:setEnabled(false)
          self.button_dismiss:setVisible(false)
          self.button_dismiss:setEnabled(false)
    end
end
function CellItemDelegateRoom:onBtnClick( _sender )
    local name = _sender:getName()
    if name == "Button_invite" then
    --邀请好友
    local jinping = "来呀锦屏麻将"
    local rule = "房间号：" .. self._cfg.table_id .. " "
    rule = rule .. self._cfg.round_num .. " "
    rule = rule .. self._cfg.table_type .. " "
    rule = rule .. self._cfg.gang
    g_ToLua:shareUrlWX("http://d.laiyagame.com/jinping/download.html",jinping,rule,0)
    elseif name == "Button_dismiss" then
      if self.clickHandle then
        self.clickHandle(self._cfg.table_id)
      end
    end
end
function CellItemDelegateRoom:setClickHandle( clickHandle)
    self.clickHandle = clickHandle
end

return CellItemDelegateRoom