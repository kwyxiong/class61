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

--走完一格回调
function HeroNode:oneCoorMovedCallback(targetCoordinate)
	self.curCoordinate = targetCoordinate
	-- print("moved " .. self.curCoordinate.x .. " " .. self.curCoordinate.y)
	-- dump(self.moveCoordinates, "self.moveCoordinates")
	if #self.moveCoordinates > 0 then
		
		local removeNums = 0
		for k, v in ipairs(self.moveCoordinates) do
			if v.x ~= self.curCoordinate.x or v.y ~= self.curCoordinate.y then
				self.targetCoordinate = v
				break
			else
				removeNums = removeNums + 1
			end
		end
		-- print("removeNums", removeNums)
		if removeNums > 0 then
			for k = 1, removeNums do
				table.remove(self.moveCoordinates, 1)
			end
			if #self.moveCoordinates == 0 then
				self.targetCoordinate = nil
			end
		end
	else
		self.targetCoordinate = nil
	end
	
	self:moveOnTick(0.016)	--优化执行oneCoorMovedCallback时角色的卡顿
	-- dump(self.targetCoordinate, "self.targetCoordinate")
end

function HeroNode:moveToMap(x, y)
	local fromCoor = self.targetCoordinate or self.curCoordinate
	local toCoor = cc.p(x, y)
	self.moveCoordinates = self.map:getRoutesCoordinate(fromCoor, toCoor)
	dump(self.moveCoordinates, "self.moveCoordinates")
	-- self.targetPos = cc.p((x + 0.5) * 32, (100 - y - 1) * 32)
	self.targetCoordinate = self.targetCoordinate or self.moveCoordinates[1]
end

function HeroNode:loadRes()
	display.loadSpriteFrames(self.model.resPlist,self.model.resPNG)
end

function HeroNode:moveOnTick(dt)
	if self.targetCoordinate then
		local targetPos = cc.p((self.targetCoordinate.x + 0.5) * 32, (100 - self.targetCoordinate.y - 1) * 32)
		local curPos = cc.p(self:getPosition())
		if targetPos.x > curPos.x then 			--向右
			local dis = math.min(self.model.moveSpeed * 0.016,  - curPos.x + targetPos.x)
			self:setPositionX(curPos.x + dis)
		elseif targetPos.x < curPos.x then 		--向左
			local dis = math.min(self.model.moveSpeed * 0.016, curPos.x - targetPos.x)
			self:setPositionX(curPos.x - dis)
		elseif targetPos.y > curPos.y then 		--向上
			local dis = math.min(self.model.moveSpeed * 0.016,  - curPos.y + targetPos.y)
			self:setPositionY(curPos.y + dis)
		elseif targetPos.y < curPos.y then 		--向下
			local dis = math.min(self.model.moveSpeed * 0.016,   curPos.y - targetPos.y)
			self:setPositionY(curPos.y - dis)
		end
		if targetPos.x == curPos.x and targetPos.y == curPos.y then
			self:oneCoorMovedCallback(self.targetCoordinate)
		end
	end
end

function HeroNode:onTick(dt)
	self.actionPlayer:onPlay(dt)
	-- local curPos = cc.p(self:getPosition())
	-- if curPos.x ~= self.targetPos.x or self.targetPos.y ~= curPos.y then
	-- 	--move
	self:moveOnTick(dt)

	-- end
end

return HeroNode