local CardDefine = require("app.common.component.CardDefine")
local Card = class("Card")

--[[
卡牌相关信息
]]
function Card:ctor(cardNode, cardEnum, cardType)
	-- 卡牌的渲染节点
	self.cardNode = cardNode
	-- 当前卡牌代表的实际卡牌
	self.cardEnum = cardEnum
	-- 当前卡牌卡牌的类型，手牌，出牌，碰牌，扛牌
	self.cardType = cardType
	-- 点击事件的回调
	self.callback = nil

	self.canOperate = false
	self.isMoPai	= false
	self.selected 	= false

	self.pressedX 	= 0
	self.pressedY   = 0

	self.canDrag 	= true
	self.isBack = false
end

function Card:setTouchEnable(can)
	self.canOperate = can
end

-- self.m_particle = g_utils.playParticleFile(_particle, self, self.m_aniPos, 2, false)
function Card:touchEvent(event)
	if event.name == "began" then
		-- 此时不再做任何操作
		-- 记录一下，当前按下的时候的坐标
		self.pressedX = event.x
		self.pressedY = event.y
		return self.canOperate
	elseif event.name == "moved" then
		-- 当纵向移动超过定值后，显示拖动提示
		local suby = event.y - self.pressedY
		if (suby > 15 and self.canDrag) or self.tips ~= nil then
			-- print('=== it`s time to show tips !====')
			self.cardNode:setGray()
			if self.tips == nil then
				self.tips = CardFactory:createTips(CardDefine.direction.bottom, CardDefine.type.shoupai, self.cardEnum)
			end
        	local wpos = self.cardNode:convertToWorldSpace(cc.p(event.x, event.y))
        	-- node 节点跟顶层节点显示相同，这里就不改了
        	local npos = self.cardNode:convertToNodeSpace(wpos)
        	local size = self.tips.cardNode:getContentSize()
        	npos.x = npos.x - size.width/2
        	npos.y = npos.y - size.height/2
        	self.tips.cardNode:setPosition(npos)

        	local ty = 230
        	if npos.y + size.height/2 > ty then
        		self.moveSelected = true
        	else
        		self.moveSelected = false
			end
		end 
	elseif event.name == "ended" then
		-- 点击出牌的处理
		-- 清空拖动的相关标记以及状态
		if self.tips ~= nil then
			self.tips:release()
			self.tips = nil
        	-- CardFactory.mask:setVisible(false)
		end
		if self.canOperate then
			self.cardNode:setNormal()
		end

		-- 拖动出牌的处理
		if self.moveSelected then
			if self.callback then
				-- 第一个参数为真，说明是要打牌，此时会发消息
				self.callback(self.moveSelected, self)
			end
		end
		if self.callback and not self.moveSelected then
			-- 第一个参数为真，说明是要打牌，此时会发消息
			self.callback(self.selected, self)
			-- 如果不是选中状态，那么标记为选中状态
			if not self.selected then
				self.selected = true
			end
		end
		self.moveSelected = false
	elseif event.name == "cancelled" then
		-- 清空拖动的相关标记以及状态
		if self.tips ~= nil then
			self.tips:release()
			self.tips = nil
        	-- CardFactory.mask:setVisible(false)
		end
		if self.canOperate then
			self.cardNode:setNormal()
		end
		self.moveSelected = false
	end
end

function Card:register(_handler)
	self.callback = _handler
	if self.cardNode ~= nil and self.cardType == CardDefine.type.shoupai then
		self.cardNode:setTouchEnabled(true)
		if self.listener == nil then
			self.listener = self.cardNode:addNodeEventListener(cc.NODE_TOUCH_EVENT, handler(self,self.touchEvent))
		end
	end
end

--牌选中
function Card:select()
	if self.canOperate then
		local x,y = self.cardNode:getPosition()
		self.cardNode:setPosition(cc.p(x,y+15))
		self.selected = true
		self.moveSelected = false
	else
		self.selected = false
		self.moveSelected = false
	end
	g_audio.playSound(g_audioConfig.sound["tiletouch"])
end

--牌放下
function Card:unselect()
	if self.selected then
		local x,y = self.cardNode:getPosition()
		self.cardNode:setPosition(cc.p(x,y-15))
		self.canOperate = true
		self.selected = false
	end
end
--释放
function Card:release()
	if self.listener ~= nil then
		self.cardNode:removeNodeEventListener(self.listener)
	end
	self.cardNode:stopAllActions()
	self.cardNode:removeFromParent(true)
	self.canOperate = false
	self.isMoPai	= false
	if self.tips ~= nil then
		self.tips:release()
		self.tips = nil
	end
end
--坐标
function Card:setPosition(_ccp)
	self.cardNode:setPosition(_ccp)
end
return Card