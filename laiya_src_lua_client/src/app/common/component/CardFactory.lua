local Card = require("app.common.component.sprites.Card")
local CardCell = require("app.common.component.sprites.CardCell")
local CardTopCell = require("app.common.component.sprites.CardTopCell")
local CardLeftCell = require("app.common.component.sprites.CardLeftCell")
local CardRightCell = require("app.common.component.sprites.CardRightCell")
local CardLeftShow = require("app.common.component.sprites.CardLeftShow")
local CardRightShow = require("app.common.component.sprites.CardRightShow")

local CardFactory = class("CardFactory")


-- card 工厂
-- 工厂只管创建，不管牌的实际坐标
-- 如果有时间改成池
function CardFactory:ctor(node)
	self.baseNode = node
	self.handler  = nil
    self.angels   = nil
end

function CardFactory:register(handler)
	self.handler = handler
end

-- _direction 方向
-- _type 当前卡牌的类型，手牌，已出牌，碰牌，杠牌（明，暗）
-- _enum 当前卡牌对应的实际值，如一万，一条

--CardDefine.direction.bottom 缩小0.7
--CardDefine.direction.top    缩小0.35
--两侧    缩小0.4

function CardFactory:create(_direction, _type, _enum)
	local tmp = _enum
	if type(tmp) == "table" then
		_enum = tmp[1]
	end
	local card = nil
	local cardNode = nil
	local cardEnum = _enum
	local pic = nil
	if cardEnum ~= -1 and cardEnum ~= 0 and cardEnum ~= 255 then
		pic = CardDefine.enum[cardEnum][2]
	end

	if g_data.roomSys.UI_State == RoomDefine.UI_State.Video then
		if _direction == CardDefine.direction.bottom then
			if _type == CardDefine.type.shoupai then
				cardNode = CardCell.new(pic)
				cardNode:setScale(0.7)
			end
		elseif _direction == CardDefine.direction.right then
			if _type == CardDefine.type.shoupai then
				cardNode = CardRightShow.new(pic)
				cardNode:setScale(0.5)
			end

		elseif _direction == CardDefine.direction.left then
			if _type == CardDefine.type.shoupai then
				cardNode = CardLeftShow.new(pic)
				cardNode:setScale(0.5)
			end
		elseif _direction == CardDefine.direction.top then
			if _type == CardDefine.type.shoupai then
				cardNode = CardCell.new(pic)
				cardNode:setScale(0.35)
			end
		end
	else
		if _direction == CardDefine.direction.bottom then
			if _type == CardDefine.type.shoupai then
				cardNode = CardCell.new(pic)
				cardNode:setScale(0.7)
			end
		elseif _direction == CardDefine.direction.right then
			if _type == CardDefine.type.shoupai then
				cardNode = CardRightCell.new(pic)
				cardNode:setScale(0.5)
			end
	
		elseif _direction == CardDefine.direction.left then
			if _type == CardDefine.type.shoupai then
				cardNode = CardLeftCell.new(pic)
				cardNode:setScale(0.5)
			end
		elseif _direction == CardDefine.direction.top then
			if _type == CardDefine.type.shoupai then
				cardNode = CardTopCell.new()
				cardNode:setScale(0.35)
			end
		end
	end

	
	cardNode:setAnchorPoint(cc.p(0,0))
	cardNode:retain()
	card = Card.new(cardNode, cardEnum, _type)
	card.isBack = isBack
	self.baseNode:addChild(cardNode)
	if _direction == CardDefine.direction.bottom then
		card:register(self.handler)
		card:setTouchEnable(true)
	end
	return card
end

function CardFactory:setBaseNode(_node)
	if self.currCard then
		self.currCard:stopAllActions()
		self.currCard:removeFromParent(true)
		self.currCard = nil
	end
	self.baseNode = _node
end

function CardFactory:flagInit()
	-- 添加出牌标记
	if self.currCard then
		self.currCard:removeFromParent(true)
		self.currCard = nil
	end
	if self.currCard == nil then
		-- 当前出牌的标记
		print("aaaa")
		self.currCard =  display.newSprite("srcRes/diamond1.png")
		self.currCard:retain()
		self.currCard:setPosition(cc.p(65,110))
		self.currCard:setVisible(false)
		self.baseNode:getParent():addChild(self.currCard,10000)
	end
end

function CardFactory:flagShow(pos)
	if self.currCard == nil then
		self:flagInit()
	end
	if self.currCard then
		self.currCard:stopAllActions()
		self.currCard:setVisible(true)
		self.currCard:setLocalZOrder(1000)
        pos.y = pos.y + 30
		self.currCard:setPosition(pos)

		local seq = cc.Sequence:create({cc.MoveBy:create(0.5,cc.p(0,50)),cc.MoveBy:create(0.5,cc.p(0,-50))})
   		local rep = cc.RepeatForever:create(seq)
		self.currCard:runAction(rep)
	end
end

function CardFactory:flagHide()
	if self.currCard then
		self.currCard:setVisible(false)
	end
end

function CardFactory:setTipsParent(node)
	self.tipsParent = node
end

function CardFactory:setMaskNode(node, node2)
	self.mask = node
	self.line = node2
end

-- 拖动的卡牌
-- 因为节点的问题，拖动的卡牌要在灰图上面，所以要换父节点
function CardFactory:createTips(_chair, _type, _enum)
	if self.dragcard then
		self.dragcard:release()
		self.dragcard = nil
	end

	local card = self:create(_chair, _type, _enum)
	card.cardNode:removeFromParent(false)
	self.tipsParent:addChild(card.cardNode)
	self.dragcard = card
	return self.dragcard
end
--箭头需要旋转的角度
function CardFactory:arrowAngel(chair1,chair2)
    
    self.angels = nil
    --1号桌位对其他桌位角度
	if chair1 ==1 then
	  if chair2 ==2 then
	  self.angels = CardDefine.pointWay.one_two
	  elseif chair2 ==3 then
	  self.angels = CardDefine.pointWay.one_three
	  elseif chair2 ==4 then
	  self.angels = CardDefine.pointWay.one_four
	  end
	end
     --2号桌位对其他桌位角度
	if chair1 ==2 then
	  if chair2 ==1 then
	   self.angels = CardDefine.pointWay.two_one
	  elseif chair2 ==3 then
	   self.angels = CardDefine.pointWay.two_three
	  elseif chair2 ==4 then
	   self.angels = CardDefine.pointWay.two_four
	  end
	end
     --3号桌位对其他桌位角度
	if chair1 ==3 then
	  if chair2 ==1 then
	  self.angels = CardDefine.pointWay.three_one
	  elseif chair2 ==2 then
	  self.angels = CardDefine.pointWay.three_two
	  elseif chair2 ==4 then
	  self.angels = CardDefine.pointWay.three_four
	  end
	end
     --4号桌位对其他桌位角度
	if chair1 ==4 then
	  if chair2 ==1 then
	 	 self.angels = CardDefine.pointWay.four_one
	  elseif chair2 ==2 then
	  	self.angels = CardDefine.pointWay.four_two
	  elseif chair2 ==3 then
	  	self.angels = CardDefine.pointWay.four_three
	  end
	end

	return self.angels
end

return CardFactory