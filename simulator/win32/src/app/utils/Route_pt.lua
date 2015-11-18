--
-- Author: kwyxiong
-- Date: 2015-11-17 11:00:05
--
local Route_pt = class("Route_pt")

function Route_pt:ctor(x, y)
	if type(x) == "table" and x.__cname == "Route_pt" then
		self.x = x:getX() 
		self.y = x:getY()
	else
		self.x = x 
		self.y = y
	end
end

function Route_pt:getX()
	return self.x
end

function Route_pt:getMapPosition()


end

function Route_pt:getY()
	return self.y
end

return Route_pt