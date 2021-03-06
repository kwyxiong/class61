--
-- Author: kwyxiong
-- Date: 2015-11-19 19:56:15
--
local CharacterBaseModel = require("app.models.CharacterBaseModel")

local Character1Model = class("Character1Model", CharacterBaseModel)

function Character1Model:ctor()
	Character1Model.super.ctor(self)
	self.ani = "character1"
	self.resPlist = "characters/character1.plist"
	self.resPNG = "characters/character1.png"
end

return Character1Model
