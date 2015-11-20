--
-- Author: kwyxiong
-- Date: 2015-11-19 20:01:34
--

local ActionPlayer = require("app.views.ActionPlayer")
local HeroNode = class("HeroNode", function() 
		return display.newNode()
	end)	

function HeroNode:ctor(heroModel)
	self.model = heroModel
	self.map = nil
	self.curCoordinate = nil 			--当前所在格子
	self.targetCoordinate = nil 		--当前正前往的格子，与当前所在格子相邻
	self.moveCoordinates = {}			--当前需要行走的路径
	self.actionPlayer = ActionPlayer.new(heroModel)
		:addTo(self)

	self:loadRes()
	self:registerScriptHandler(handler(self, self.enter_exit))
end

function HeroNode:enter_exit(name)
	if name == "enter" then
		
	elseif name == "exit" then

	end
end

function HeroNode:up()
	self.actionPlayer:playAction("up")
end

function HeroNode:onTick(dt)
	self.actionPlayer:onPlay(dt)
	-- local curPos = cc.p(self:getPosition())
	-- if curPos.x ~= self.targetPos.x or self.targetPos.y ~= curPos.y then
	-- 	--move

	-- end
end

function HeroNode:addToMap(map)
	self.map = map
	map:getLayer("hero"):addChild(self)
	return self
end

function HeroNode:setToMap(x, y)
	self:setPosition((x + 0.5) * 32, (100 - y - 1) * 32)
	self.curCoordinate = cc.p(x, y)
	return self
end

function HeroNode:move(coordinates)


end

function HeroNode:moveToMap(x, y)
	local fromCoor = self.targetCoordinate or self.curCoordinate
	local toCoor = cc.p(x, y)
	local coordinates = self.map:getRoutesCoordinate(fromCoor, toCoor)
	dump(coordinates, "coordinates")
	-- self.targetPos = cc.p((x + 0.5) * 32, (100 - y - 1) * 32)
end

function HeroNode:loadRes()
	display.loadSpriteFrames(self.model.resPlist,self.model.resPNG)
end

return HeroNode