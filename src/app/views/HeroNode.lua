--
-- Author: kwyxiong
-- Date: 2015-11-19 20:01:34
--
local ActionPlayer = require("app.views.ActionPlayer")
local HeroNode = class("HeroNode", function() 
		return display.newNode()
	end)	

function HeroNode:ctor(heroModel)
	self.model = heroModel
	-- dump(self.model, "self.model")
	self.actionPlayer = ActionPlayer.new(heroModel)
		:addTo(self)

	self:loadRes()
	self:registerScriptHandler(handler(self, self.enter_exit))
end

function HeroNode:enter_exit(name)
	if name == "enter" then
		
	elseif name == "exit" then

	end
end

function HeroNode:up()
	self.actionPlayer:playAction("up")
end

function HeroNode:onTick(dt)
	self.actionPlayer:onPlay(dt)
end

function HeroNode:addToMap(map)
	map:getLayer("hero"):addChild(self)
	return self
end

function HeroNode:moveToMap(x, y)
	self:setPosition((x + 0.5) * 32, (100 - y - 1) * 32)
	return self
end

function HeroNode:loadRes()
	display.loadSpriteFrames(self.model.resPlist,self.model.resPNG)
end

return HeroNode