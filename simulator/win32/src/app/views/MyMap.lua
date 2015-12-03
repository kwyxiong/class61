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

	self:initRouteMap()
	self:hideLayer()
end



function MyMap:hideLayer()
	self:getLayer("route_tiles-gakuen-001"):setVisible(false)
	self:getLayer("limit_tiles-gakuen-001"):setVisible(false)
	print("**************")
	print(self:getLayer("route_tiles-gakuen-001"):getLocalZOrder())
	print(self:getLayer("limit_tiles-gakuen-001"):getLocalZOrder())
end

function MyMap:initRouteMap()
	local route_layer = self:getLayer("route_tiles-gakuen-001")
	local size = route_layer:getLayerSize()
	
	for m = 1, size.width do
        local res ={}
        for n = 1, size.height do
            if route_layer:getTileGIDAt(cc.p(m-1, n-1)) ~= 0 then
            	local sp = route_layer:getTileAt(cc.p(m-1, n-1))

            	-- print(m-1 .. " " .. n-1 .. "sp " .. sp:getLocalZOrder())
                res[#res + 1] = 0
            else
                res[#res + 1] = 1
            end
        end
        self.routeMap[#self.routeMap + 1] = res
    end
    -- dump(self.routeMap, "self.routeMap")
end

--获取从一个块坐标到另一个块坐标的最短路径
function MyMap:getRoutesCoordinate(fromCoor, toCoor)
	local aStarRoute = AStarRoute.new(self.routeMap, fromCoor.x, fromCoor.y, toCoor.x, toCoor.y)
	local res = aStarRoute:getResult()
	return res
end


--根据点在屏幕的坐标获得在地图中的x和y块坐标
function MyMap:getTileCoordinateByTouchLocation(location)
	local relaPos = self:getPosInMapByLocation(location)
	local x = math.floor(relaPos.x / 32)
	local y = 100 - 1 - math.floor(relaPos.y / 32)	 
	-- print("x = " .. x .. " y = " .. y)
	return x, y
end

function MyMap:getPosInMapByCoor(coor)

	-- local posAt = self:getLayer("hero"):getPositionAt(coor)
	-- dump(posAt, "posAt")

	-- dump(cc.p((coor.x + 0.5) * 32, (100 - coor.y - 0.5) * 32))

	return cc.p((coor.x + 0.5) * 32, (100 - coor.y - 0.5) * 32)
end

function MyMap:getPosInMapByLocation(location)
	local mapPos = cc.Director:getInstance():getRunningScene():convertToNodeSpace(self:convertToWorldSpace(cc.p(0,0)))
	local relaPosX = location.x - mapPos.x
	local relaPosY = location.y - mapPos.y
	-- dump(cc.p(relaPosX, relaPosY) , "getPosInMapByLocation")
	return cc.p(relaPosX, relaPosY)
end

--根据点在屏幕的坐标获得在地图中能行走的距离触摸点最近的块的x和y坐标
--只支持半径为r个格子
function MyMap:getClosestMoveabledRoute(location)
	local route_layer = self:getLayer("route_tiles-gakuen-001")
	local size = route_layer:getLayerSize()
	local r = 5
	local x, y = self:getTileCoordinateByTouchLocation(location)
	local routes = {}
	for k = x - r, x + r do
		for m = y - r, y + r do
			if  k <= size.width -1 and k >= 0 and m <= size.height - 1 and m >= 0 and 
				route_layer:getTileGIDAt(cc.p(k, m)) ~= 0 then

				routes[#routes + 1] = cc.p(k, m)
			end
		end
	end
	-- dump(routes, "routes")
	if #routes > 0 then
		local min = 999999
		local minIndex = 1
		for k, v in ipairs(routes) do
			local dis = cc.pGetDistance(self:getPosInMapByCoor(v), self:getPosInMapByLocation(location))
			-- dump(self:getPosInMapByCoor(v), " x = " .. v.x .. " y = " .. v.y)
			-- print("x = " .. v.x .. " y = " .. v.y .. " dis = " .. dis)
			-- print("dis = " .. dis)
			if dis <= min then
				min = dis
				minIndex = k
			end
		end
		-- dump(routes[k], "routes[k]")
		return routes[minIndex]
	end

	return nil
end

function MyMap:setTouchEnabled(enable)
	if enable and not self.touchEnabled then
		local function onTouchesEnded(touches, event )
	        	   
	        if self.touchCallback then
	        	local location = touches[1]:getLocation()
	        	-- local x, y = self:getTileCoordinateByTouchLocation(location)
	        	self.touchCallback(location)
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