--
-- Author: kwyxiong
-- Date: 2015-11-16 14:08:57
--
local Route_pt = require("app.utils.Route_pt")
local AStarRoute = class("AStarRoute")


function AStarRoute:ctor(mx, sx, sy, gx, gy)
	self.map = {}		--地图矩阵，0表示能通过，1表示不能通过
	self.map_w = 0		--地图宽度 ？行数
	self.map_h = 0		--地图高度 ？列数
	self.start_x = 0	--起点坐标X
	self.start_y = 0	--起点坐标Y
	self.goal_x = 0		--终点坐标X
	self.goal_y = 0		--终点坐标Y
	self.closeList = {}			--关闭列表
	self.openList = {}			--打开列表
	self.openListLength = 0

	self.EXIST = 1
	self.NOT_EXIST = 0			
	self.ISEXIST = 1			
	self.EXPENSE = 2			--自身的代价
	self.DISTANCE = 3			--距离的代价
	self.COST = 4				--消耗的总代价
	self.FATHER_DIR = 5			--父节点的方向
	self.DIR_NULL = 0
	self.DIR_DOWN = 1			--下
	self.DIR_UP = 2				--上
	self.DIR_LEFT = 3			--左
	self.DIR_RIGHT = 4			--右

	self.astar_counter = 0		--算法嵌套深度
	self.isFound = false 		--是否找到路径
	self.myMap = {}


	self:init(mx, sx, sy, gx, gy)

end

function AStarRoute:init(mx, sx, sy, gx, gy)

	self.start_x = sx + 1
    self.start_y = sy + 1
    self.goal_x  = gx + 1
    self.goal_y  = gy + 1
    self.map     = mx
    self.map_w   = #mx
    self.map_h   = #mx[1]
    self.astar_counter = 5000
    self:initCloseList()
    self:initOpenList(self.goal_x, self.goal_y)
    
end

--初始化关闭列表
function AStarRoute:initCloseList()
	self.closeList = {}
	for i = 1, self.map_w do
		local tb = {}
		for j = 1, self.map_h do
			tb[#tb + 1] = false
		end
		self.closeList[#self.closeList + 1] = tb
	end
end

--初始化打开列表
function AStarRoute:initOpenList(ex, ey)

    self.openList  = {}
    for i = 1, self.map_w do
    	local tb = {}
    	for j = 1, self.map_h do
    		local res = {}
    		res[self.ISEXIST] = self.NOT_EXIST
    		res[self.EXPENSE] = self:getMapExpense(i, j)
    		res[self.DISTANCE] = self:getDistance(i, j, ex, ey)
    		res[self.COST] = res[self.EXPENSE] + res[self.DISTANCE]
    		res[self.FATHER_DIR] = self.DIR_NULL
    		tb[#tb + 1] = res
    	end
    	self.openList[#self.openList + 1] = tb
    end
    self.openListLength = 0

end

--移除打开列表的一个元素
function AStarRoute:removeOpenList(x, y)
	if self.openList[x][y][self.ISEXIST] == self.EXIST then
		self.openList[x][y][self.ISEXIST] = self.NOT_EXIST
		self.openListLength = self.openListLength - 1
	end
end

--添加关闭列表
function AStarRoute:addCloseList(x, y)
	self.closeList[x][y] = true
end

--得到给定坐标格子此时的总消耗值
function AStarRoute:getCost(x, y)
	return self.openList[x][y][self.COST]
end

--寻路
function AStarRoute:aStar(x, y)
	--控制算法深度
	for k = 1, self.astar_counter do
		if x == self.goal_x and y == self.goal_y then
			self.isFound = true
			return
		elseif self.openListLength == 0 then
			self.isFound = false
			return
		end

		self:removeOpenList(x, y)
		self:addCloseList(x, y)

		--该点周围能够行走的点
		self:addNewOpenList(x, y, x, y + 1, self.DIR_UP)
        self:addNewOpenList(x, y, x, y - 1, self.DIR_DOWN)
        self:addNewOpenList(x, y, x - 1, y, self.DIR_RIGHT)
        self:addNewOpenList(x, y, x + 1, y, self.DIR_LEFT)

        --找到估值最小的点，进行下一轮算法
        local cost = 0x7fffffff
        for i = 1, self.map_w do
        	for j = 1, self.map_h do
        		if self.openList[i][j][self.ISEXIST] == self.EXIST then
        			if cost > self:getCost(i, j) then
        				cost = self:getCost(i, j)
        				x = i
        				y = j
        			end
        		end
        	end
        end
	end

    --算法超深
    self.isFound = false
    return
end


--得到地图上这一点的消耗值
function AStarRoute:getMapExpense(x, y)
	return 1
end

--得到距离的消耗值
function AStarRoute:getDistance(x, y ,ex, ey)

	return (math.abs(x - ex) + math.abs(y - ey))
end

--判断一个点是否可以通过
function AStarRoute:isCanPass(x, y)
	--超出边界
	if x < 1 or x > self.map_w or y < 1 or y > self.map_h then
		return false
	end

	--地图不通
	if self.map[x][y] ~= 0 then
		return false
	end
    
    --在关闭列表中
    if self:isInCloseList(x, y) then
    	return false
    end

    return true
end

--判断一点是否在关闭列表中
function AStarRoute:isInCloseList(x, y)
	return self.closeList[x][y]
end

--添加一个新的节点
function AStarRoute:addNewOpenList(x, y, newX, newY, dir)
	if self:isCanPass(newX, newY) then
		if self.openList[newX][newY][self.ISEXIST] == self.EXIST then
			if self.openList[x][y][self.EXPENSE] + self:getMapExpense(newX, newY) < self.openList[newX][newY][self.EXPENSE] then
				self:setFatherDir(newX, newY, dir)
				self:setCost(newX, newY, x, y)
			end
		else
			self:addOpenList(newX, newY)
            self:setFatherDir(newX, newY, dir)
            self:setCost(newX, newY, x, y)
		end
	end


end


--设置消耗值
function AStarRoute:setCost(x, y, ex, ey)
    self.openList[x][y][self.EXPENSE] = self.openList[ex][ey][self.EXPENSE] + self:getMapExpense(x, y)
    self.openList[x][y][self.DISTANCE] = self:getDistance(x, y, ex, ey)
    self.openList[x][y][self.COST] = self.openList[x][y][self.EXPENSE] + self.openList[x][y][self.DISTANCE]
end

--设置父节点方向
function AStarRoute:setFatherDir(x, y, dir)
	self.openList[x][y][self.FATHER_DIR] = dir
end

--添加打开列表
function AStarRoute:addOpenList(x, y)
	if self.openList[x][y][self.ISEXIST] == self.NOT_EXIST then
		self.openList[x][y][self.ISEXIST] = self.EXIST
		self.openListLength = self.openListLength + 1
	end

end

--开始寻路
function AStarRoute:searchPath()
	self:addOpenList(self.start_x, self.start_y)
    self:aStar(self.start_x, self.start_y)
end

--获得寻路结果
function AStarRoute:getResult()
	local result = {}
	local route = {}
	self:searchPath()
	if not self.isFound then
		return 
	end
    --openList是从目标点向起始点倒推的
    local iX = self.goal_x
    local iY = self.goal_y

    if iX ~= self.start_x or iY ~= self.start_y then
		repeat
			route[#route + 1] = Route_pt.new(iX, iY)
			if self.openList[iX][iY][self.FATHER_DIR] == self.DIR_DOWN then
				iY = iY + 1
			elseif self.openList[iX][iY][self.FATHER_DIR] == self.DIR_UP then
				iY = iY - 1
			elseif self.openList[iX][iY][self.FATHER_DIR] == self.DIR_LEFT then
				iX = iX - 1
			elseif self.openList[iX][iY][self.FATHER_DIR] == self.DIR_RIGHT then
				iX = iX + 1
			end
		until iX == self.start_x and iY == self.start_y
	end

	local size = #route
    -- dump(route, "route")
    for k = 1, size do
    	result[#result + 1] = Route_pt.new(route[k]:getX() - 1, route[k]:getY() - 1)
    end
  
    return result
end


return AStarRoute