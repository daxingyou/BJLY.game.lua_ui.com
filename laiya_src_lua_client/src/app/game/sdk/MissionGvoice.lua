local MissionGvoice = class("MissionGvoice")
local Scheduler = require("framework.scheduler")
function MissionGvoice:ctor()		
	    self.Gvoice = my.GcloudVoiceInstance:getinstance()
end
function MissionGvoice:initGvoice()
	     self.Gvoice:setAppinfo("1251714476","55cd9c737ab72beeac7b9fbbcb6e26c8",g_data.userSys.openid)
       self.Gvoice:initEngine()
       self.Gvoice:setGvoiceModel(0)
       self.scheduler_tick = Scheduler.scheduleGlobal( function() self:tick(0.25) end, 0.25)
end
function MissionGvoice:openspeaker()
	self.Gvoice:opemspeaker()
end
function MissionGvoice:closespeaker()
  self.Gvoice:closespeaker()
end
function MissionGvoice:jointeamroom(roomid)
	self.Gvoice:jointeamroom(roomid)
end
function MissionGvoice:quickteamroom(roomid)
    self.Gvoice:quickteamroom(roomid)
end
function MissionGvoice:openmic()
	self.Gvoice:openmic()
end
function MissionGvoice:closemic()
	self.Gvoice:closemic()
end
function MissionGvoice:tick( ft )
    local Gvoice_ = my.GcloudVoiceInstance:getinstance()
    Gvoice_:pollEngine()
end

return MissionGvoice
