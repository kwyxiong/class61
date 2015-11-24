--
-- Author: Your Name
-- Date: 2015-11-23 22:29:34
--
local scheduler = cc.Director:getInstance():getScheduler()
local OneByOneLabel = class("OneByOneLabel", function() 
		return display.newNode()
	end)

function OneByOneLabel:ctor(arg)
	self.arg = arg or {}
	self.text = self.arg.text
	self.speed = 1
	self.playIndex = 1
	self.maxPlayIndex = string.len(self.text) / 3
	print("self.maxPlayIndex", self.maxPlayIndex)
	self.label = cc.exports.ccsui.createLabel({
			text = "",
			maxLineWidth = 100
		})	
		-- :move(333, 333)
		:addTo(self)
	-- self.label = cc.Label:create(self.text)
	-- 	:addTo(self)
	self.label:setAnchorPoint(cc.p(0, 0.5))
	self.entry = nil

	self:onNodeEvent("exit", handler(self, self.onExit))
	self:play()
end

function OneByOneLabel:onExit()
	if self.entry then
		scheduler:unscheduleScriptEntry(self.entry)
		self.entry = nil
	end
end

function OneByOneLabel:playFunc(dt)
	local str = string.sub(self.text, 1, self.playIndex * 3)
	self.label:setString(str)
	self.playIndex = self.playIndex + 1
	if self.playIndex > self.maxPlayIndex then
		scheduler:unscheduleScriptEntry(self.entry)
		self.entry = nil
	end
end

function OneByOneLabel:play()
	if not self.entry then 
		self.entry = scheduler:scheduleScriptFunc(handler(self,self.playFunc), self.speed, false)
	end
end


return OneByOneLabel