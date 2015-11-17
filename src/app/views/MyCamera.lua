--
-- Author: kwyxiong
-- Date: 2015-11-17 16:41:06
--
local MyCamera = class("MyCamera", cc.Layer)


function MyCamera:ctor()
	self.drugEnabled = false 	--是否能拖拽

end


--开启拖拽
function MyCamera:setDrugEnabled(enabled)
	if enabled and not self.drugEnabled then
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
	elseif not enabled and self.drugEnabled then
		self:getEventDispatcher():removeAllEventListeners()
	end
	self.drugEnabled = enabled
end


return MyCamera