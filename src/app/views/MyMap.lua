--
-- Author: kwyxiong
-- Date: 2015-11-17 17:18:25
--
local AStarRoute = require("app.utils.AStarRoute")
local MyMap = class("MyMap", function(tmxFile) 
		return ccexp.TMXTiledMap:create(tmxFile)
	end)

function MyMap:ctor(tmxFile, touchCallback)
	self.routeMap = {}
	self.touchEnabled = false
	self.touchCallback = touchCallback

	-- self:initRouteMap()
end

function MyMap:initRouteMap()
	local route_layer = self:getLayer("route_tiles-gakuen-001")
	-- dump(hero_layer)
	dump(route_layer, "route_layer")
	local size = route_layer:getLayerSize()
	dump(size, "size")
	for m = 1, size.width do
        local res ={}
        for n = 1, size.height do
            if route_layer:getTileGIDAt(cc.p(m-1, n-1)) ~= 0 then
                res[#res + 1] = 0
            else
                res[#res + 1] = 1
            end
        end
        self.routeMap[#self.routeMap + 1] = res
    end
end

--获取从一个块坐标到另一个块坐标的最短路径
function MyMap:getRoutesCoordinate(fromCoor, toCoor)
	local aStarRoute = AStarRoute.new(self.routeMap, fromCoor.x, fromCoor.y, toCoor.x, toCoor.y)
	local res = aStarRoute:getResult()
	return res
end


--根据点在屏幕的坐标获得在地图中的x和y块坐标
function MyMap:getTileCoordinateByTouchLocation(location)
	local mapPos = cc.Director:getInstance():getRunningScene():convertToNodeSpace(self:convertToWorldSpace(cc.p(0,0)))
	local relaPosX = location.x - mapPos.x
	local x = math.floor(relaPosX / 32)
	local relaPosY = location.y - mapPos.y
	local y = 100 - 1 - math.floor(relaPosY / 32)	 
	-- print("x = " .. x .. " y = " .. y)
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