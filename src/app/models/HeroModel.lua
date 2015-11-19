--
-- Author: kwyxiong
-- Date: 2015-11-19 11:32:16
--
local HeroModel = class("HeroModel")

function HeroModel:ctor()
	self.speed = 20	--帧间隔
	self.ani = ""	--资源
	self.resPlist = ""
	self.resPNG = ""
end


return HeroModel