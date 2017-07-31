--[[
    --桌面
]]--

local ccbfile = "ccb/roomInfoPanel.ccbi"
local RoomInfoPanel = class("RoomInfoPanel", function()
    local node = display.newNode()
    node:setNodeEventEnabled(true)
    return node
end)

local state = 
{
  open  = 1,
  close = 2
}

function RoomInfoPanel:ctor()
   self:load_ccb()
   self:initUI()
   self:regEvent()
end
function RoomInfoPanel:onCleanup()
    self:unregEvent()
end

--加载ccbi
function RoomInfoPanel:load_ccb()
    self.m_ccbRoot = {
      ["onClick"] = function(_sender, _event) self:onClick(_sender, _event) end,
    }
    local proxy = cc.CCBProxy:create()
    local node  = CCBReaderLoad(ccbfile, proxy, self.m_ccbRoot)
    node:addTo(self)
end

--注册事件
function RoomInfoPanel:regEvent()
    g_msg:reg("RoomInfoPanel", g_msgcmd.DB_PLAY_GAME_START, function( )
         self:onClick()
     end)
end
--注销事件
function RoomInfoPanel:unregEvent()
    g_msg:unreg("RoomInfoPanel", g_msgcmd.DB_PLAY_GAME_START)
end

function RoomInfoPanel:initUI()
  self.state  = state.open
  local ccb   = self.m_ccbRoot
  local color = cc.c3b(247, 224, 167)
  ccb.m_roomName:setColor(color)
  ccb.m_roomNumber:setColor(color)
  ccb.m_roomRound:setColor(color)
  ccb.m_roomType:setColor(color)
  --房间号
  ccb.m_roomNumber:setString(g_data.roomSys.kTableID)
  --局数
  ccb.m_roomRound:setString(g_data.roomSys.RoundLimit.."局")
  --是否闷杠
  ccb.m_roomType:setString(g_data.roomSys.isMenGang == 1 and "闷杠x2" or "自杠x2")

end

function RoomInfoPanel:onClick(_sender, _event)
  if self.state  == state.open then
      self.m_ccbRoot.m_connet:stopAllActions()
      self.m_ccbRoot.m_connet:runAction(cc.MoveTo:create(0.3,cc.p(-135,36)))
      self.state  = state.close
      self.m_ccbRoot.m_sprite:setSpriteFrame("room_infoPanel_right.png")
  else
      self.state  = state.open
      self.m_ccbRoot.m_connet:stopAllActions()
      self.m_ccbRoot.m_connet:runAction(cc.MoveTo:create(0.3,cc.p(-15,36)))
      self.m_ccbRoot.m_sprite:setSpriteFrame("room_infoPanel_left.png")
  end
end

return RoomInfoPanel