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

	self.label = ccui.Text:create()
		:addTo(self)
	self.label:setString("哈啊啊啊啊啊啊啊啊啊")
	-- self.label = cc.Label:create(self.text)
	-- 	:addTo(self)
end


return OneByOneLabel