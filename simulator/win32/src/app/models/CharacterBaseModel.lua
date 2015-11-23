--
-- Author: kwyxiong
-- Date: 2015-11-19 11:32:16
--
local CharacterBaseModel = class("CharacterBaseModel")

function CharacterBaseModel:ctor()
	self.actionSpeed = 8	--帧间隔
	self.moveSpeed = 200	--px/s
	self.ani = ""	--资源
	self.resPlist = ""
	self.resPNG = ""
end


return CharacterBaseModel