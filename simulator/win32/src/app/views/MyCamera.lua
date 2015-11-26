--
-- Author: kwyxiong
-- Date: 2015-11-17 16:41:06
--
local MyCamera = class("MyCamera", cc.Layer)


function MyCamera:ctor()
	self.drugEnabled = false 	--是否能拖拽
	self.focus = nil
	self.rect = nil
end

function MyCamera:setFocus(focusNode)
	self.focus = focusNode
end

function MyCamera:setRect(rect)
	self.rect = rect
end

function MyCamera:checkAndMove(x, y)

	--x方向

	local focusPos = cc.Director:getInstance():getRunningScene():convertToNodeSpace(self.focus:convertToWorldSpace(cc.p(0,0)))
	-- if (focusPos.x >= display.cx and self:getPositionX()- focusPos.x + display.cx >=  - self.rect.width + display.cx )
	-- 	or (focusPos.x <= display.cx and self:getPositionX() -  focusPos.x + display.cx <= display.cx )
	-- then
	-- 	print("focusPos.x - display.cx ", focusPos.x - display.cx )
	-- 	self:setPositionX(self:getPositionX() - focusPos.x + display.cx )

	-- 	if focusPos.x - display.cx >0 then
	-- 		self:setPositionX(self:getPositionX() - (focusPos.x - display.cx) )
	-- 	end
	-- end

	-- --y方向
	-- if (focusPos.y >= display.cy and self:getPositionY() - focusPos.y + display.cy >= - self.rect.height + display.cy)
	-- 	or (focusPos.y <= display.cy and self:getPositionY() - focusPos.y + display.cy <= display.cy )
	-- then
	-- 	-- self:setPositionY(self:getPositionY() - focusPos.x + display.cx )
	-- end	

	if x > 0 and focusPos.x >= display.cx and self:getPositionX() >=  - self.rect.width + display.cx then
		self:setPositionX(self:getPositionX() - math.min(x, self:getPositionX() + self.rect.width - display.cx) )
	elseif x < 0 and focusPos.x <= display.cx and self:getPositionX() <= 0 then
		self:setPositionX(self:getPositionX() + math.min(-x, - self:getPositionX() ) )
	end

	if y > 0 and focusPos.y >= display.cy and self:getPositionY() >=  - self.rect.height + display.cy then
		self:setPositionY(self:getPositionY() - math.min(y, self:getPositionY() + self.rect.height - display.cy) )
	elseif y < 0 and focusPos.y <= display.cy and self:getPositionY() <= 0 then
		self:setPositionY(self:getPositionY() + math.min(-y, - self:getPositionY() ) )
	end

end

--开启拖拽
function MyCamera:setDrugEnabled(enable)
	if enable and not self.drugEnabled then
	    local function onTouchesMoved(touches, event )
	        local diff = touches[1]:getDelta()
	        local currentPosX, currentPosY= self:getPosition()
	        self:setPosition(cc.p(currentPosX + diff.x, currentPosY + diff.y))
	    end

	    local listener = cc.EventListenerTouchAllAtOnce:create()
	    -- listener:registerScriptHandler(onTouchesEnded,cc.Handler.EVENT_TOUCHES_ENDED )
	    listener:registerScriptHandler(onTouchesMoved,cc.Handler.EVENT_TOUCHES_MOVED )
	    local eventDispatcher = self:getEventDispatcher()
	    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
	elseif not enable and self.drugEnabled then
		self:getEventDispatcher():removeAllEventListeners()
	end
	self.drugEnabled = enable
end


return MyCamera