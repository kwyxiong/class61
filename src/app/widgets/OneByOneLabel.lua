--
-- Author: Your Name
-- Date: 2015-11-23 22:29:34
--
local OneByOneLabel = class("OneByOneLabel", function() 
		return display.newNode()
	end)

function OneByOneLabel:ctor(arg)
	self.arg = arg or {}
	self.text = self.arg.text

	cc.exports.ccsui:createLabel({
			text = "啊哈哈哈哈哈哈哈"
		})	
		-- :move(333, 333)
		:addTo(self)
	-- self.label = cc.Label:create(self.text)
	-- 	:addTo(self)
end


return OneByOneLabel