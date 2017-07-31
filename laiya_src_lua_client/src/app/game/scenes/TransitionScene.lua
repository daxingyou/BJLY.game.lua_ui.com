--[[
  解决断线重连问题
]]

local TransitionScene = class("TransitionScene", function()
    return display.newScene("TransitionScene")
end)

function TransitionScene:ctor()

end

function TransitionScene:onCleanup()
   
end

function TransitionScene:regEvent()
    --监听定缺事件
end

function TransitionScene:unregEvent()

end

function TransitionScene:initUI()
   
end


function TransitionScene:onEnter()
    g_SMG:addWaitLayer()
    self:performWithDelay(function() g_netMgr:connectGameServer() end, 0.1)

end

function TransitionScene:onExit()
    g_SMG:removeWaitLayer() 
end

return TransitionScene
