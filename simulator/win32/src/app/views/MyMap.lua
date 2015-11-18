--
-- Author: kwyxiong
-- Date: 2015-11-17 17:18:25
--
local MyMap = class("MyMap", function(tmxFile) 
		return ccexp.TMXTiledMap:create(tmxFile)
	end)

function MyMap:ctor(tmxFile, touchCallback)
	self.touchEnabled = false
	self.touchCallback = touchCallback
end

function MyMap:getTileCoordinateByTouchLocation(location)
	local mapPos = cc.Director:getInstance():getRunningScene():convertToNodeSpace(self:convertToWorldSpace(cc.p(0,0)))
	local relaPosX = location.x - mapPos.x
	local x = math.floor(relaPosX / 32)
	local relaPosY = location.y - mapPos.y
	local y = 100 - 1 - math.floor(relaPosY / 32)	 
	print("x = " .. x .. " y = " .. y)
	return x, y
end

function MyMap:setTouchEnabled(enable)
	if enable and not self.touchEnabled then
		local function onTouchesEnded(touches, event )
	        	   
	        if self.touchCallback then
	        	local location = touches[1]:getLocation()
	        	local x, y = self:getTileCoordinateByTouchLocation(location)
	        	self.touchCallback(x, y)
	        end
	    end

	    local listener = cc.EventListenerTouchAllAtOnce:create()
	    listener:registerScriptHandler(onTouchesEnded,cc.Handler.EVENT_TOUCHES_ENDED )
	    -- listener:registerScriptHandler(onTouchesMoved,cc.Handler.EVENT_TOUCHES_MOVED )
	    local eventDispatcher = self:getEventDispatcher()
	    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
	elseif not enable and self.touchEnabled then
		self:getEventDispatcher():removeAllEventListeners()
	end
	self.touchEnabled = enable
end

return MyMap