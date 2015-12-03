--
-- Author: kwyxiong
-- Date: 2015-11-19 20:01:34
--

local ActionPlayer = require("app.views.ActionPlayer")
local HeroNode = class("HeroNode", function() 
		return display.newNode()
	end)	
HeroNode.kActionStateNone = 0
HeroNode.kActionStateUp = 1
HeroNode.kActionStateDown = 2
HeroNode.kActionStateLeft = 3
HeroNode.kActionStateRight = 4
HeroNode.kActionStateUpPause = 5
HeroNode.kActionStateDownPause = 6
HeroNode.kActionStateLeftPause = 7
HeroNode.kActionStateRightPause = 8

function HeroNode:ctor(heroModel)
	self.model = heroModel
	self.map = nil
	self.camera = nil
	self.actionState = 0
	self.curCoordinate = nil 			--当前所在格子
	self.targetCoordinate = nil 		--当前正前往的格子，与当前所在格子相邻
	self.moveCoordinates = {}			--当前需要行走的路径
	self.actionPlayer = ActionPlayer.new(heroModel)
		:addTo(self)
	self.actionPlayer:setFrameEvent(handler(self, self.frameEvent))
	self:loadRes()
	self:registerScriptHandler(handler(self, self.enter_exit))
end

function HeroNode:setCamera(camera)
	self.camera = camera
end

function HeroNode:enter_exit(name)
	dump(name, "name")
	if name == "enter" then
		
	elseif name == "exit" then

	end
end

function HeroNode:frameEvent(event)
	local res = true
	if event.frame % 2 ~= 0 and not self.targetCoordinate then
		-- print("pppppppppppppp")
		event.actionPlayer:setTimesSequence(nil)
		self.actionState = HeroNode.kActionStateNone
	elseif (event.frame ) % 2 == 0 and not self.targetCoordinate then
		event.actionPlayer:setTimesSequence(nil)
		self.actionState = HeroNode.kActionStateNone
		res= false		
	end
	-- print(res)
	return res
end

function HeroNode:up()
	if self.actionState ~= HeroNode.kActionStateUp then
		self.actionPlayer:playAction("up")
		self.actionState = HeroNode.kActionStateUp
	end
end

function HeroNode:down()
	if self.actionState ~= HeroNode.kActionStateDown then
		self.actionPlayer:playAction("down")
		self.actionState = HeroNode.kActionStateDown
	end
end

function HeroNode:left()
	if self.actionState ~= HeroNode.kActionStateLeft then
		self.actionPlayer:playAction("left")
		self.actionState = HeroNode.kActionStateLeft
	end
end

function HeroNode:right()
	if self.actionState ~= HeroNode.kActionStateRight then
		self.actionPlayer:playAction("right")
		self.actionState = HeroNode.kActionStateRight
	end
end

function HeroNode:upPause()
	if self.actionState ~= HeroNode.kActionStateUpPause then
		self.actionPlayer:pauseOnAction("up", 1)
		self.actionState = HeroNode.kActionStateUpPause
	end
end

function HeroNode:downPause()
	if self.actionState ~= HeroNode.kActionStateDownPause then
		self.actionPlayer:pauseOnAction("up", 1)
		self.actionState = HeroNode.kActionStateDownPause
	end
end

function HeroNode:leftPause()
	if self.actionState ~= HeroNode.kActionStateLeftPause then
		self.actionPlayer:pauseOnAction("up", 1)
		self.actionState = HeroNode.kActionStateLeftPause
	end
end

function HeroNode:rightPause()
	if self.actionState ~= HeroNode.kActionStateRightPause then
		self.actionPlayer:pauseOnAction("up", 1)
		self.actionState = HeroNode.kActionStateRightPause
	end
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
	
	
end

function HeroNode:moveToMap(x, y)
	local fromCoor = self.targetCoordinate or self.curCoordinate
	local toCoor = cc.p(x, y)
	if fromCoor.x == toCoor.x and fromCoor.y == toCoor.y then
		return false
	end
	self.moveCoordinates = self.map:getRoutesCoordinate(fromCoor, toCoor)
	-- dump(self.moveCoordinates, "self.moveCoordinates")
	-- self.targetPos = cc.p((x + 0.5) * 32, (100 - y - 1) * 32)
	self.targetCoordinate = self.targetCoordinate or self.moveCoordinates[1]
	return true
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
			self:right()
			self.camera:checkAndMove(dis, 0)
		elseif targetPos.x < curPos.x then 		--向左
			local dis = math.min(self.model.moveSpeed * 0.016, curPos.x - targetPos.x)
			self:setPositionX(curPos.x - dis)
			self:left()
			self.camera:checkAndMove(-dis, 0)
		elseif targetPos.y > curPos.y then 		--向上
			local dis = math.min(self.model.moveSpeed * 0.016,  - curPos.y + targetPos.y)
			self:setPositionY(curPos.y + dis)
			self:up()
			self.camera:checkAndMove(0, dis)
		elseif targetPos.y < curPos.y then 		--向下
			local dis = math.min(self.model.moveSpeed * 0.016,   curPos.y - targetPos.y)
			self:setPositionY(curPos.y - dis)
			self:down()
			self.camera:checkAndMove(0, - dis)
		end
		if targetPos.x == self:getPositionX() and targetPos.y == self:getPositionY() then
			self:oneCoorMovedCallback(self.targetCoordinate)
		end
		-- print(self.map:getLayer("hero"):getVertexZForPos(self:getPosition()))


		-- print("x = " .. curPos.x .. " y = " .. curPos.y .. ", x = " .. self:getPositionX() .. " y = " .. self:getPositionY())
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