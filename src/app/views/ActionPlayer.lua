--
-- Author: kwyxiong
-- Date: 2015-11-13 14:28:52
--
local Route_pt = require("app.utils.Route_pt")
local ActionPlayer = class("ActionPlayer", function()
    return display.newNode()
end)

function ActionPlayer:ctor(heroModel)
	self.model = heroModel
	self.aniData_ = require("app.ani." .. self.model.ani)
	self.frameSequence = {}
	self.timesSequence = {}
	self.sequenceIndex = 0 
	self.timesCount = 0
	self.curLoopCount = 0  
	self.playCount = -1
	self.sprite_ = display.newSprite():addTo(self)
	self.sprite_:setAnchorPoint(cc.p(0.5, 0))
	self.actions = {}
	
end



function ActionPlayer:playAction(actionName)
	local Layer1 = self.aniData_[actionName]["Layer1"]
	local textures = self.aniData_[actionName]["textures"]
	local fSequence = {}
	for k, v in ipairs(Layer1[1]) do
		fSequence[#fSequence + 1] = textures[v + 1] .. ".png"
	end
	local tSequence =Layer1[2] 
	if self.model.speed then
		for k = 1, #Layer1[2] - 1 do
			tSequence[k] = self.model.speed
		end
	end
	local loopCount__ =self.aniData_[actionName]["loop"]
	self:setFrameSequence(fSequence,tSequence,loopCount__)
end

function ActionPlayer:setFrameSequence(fSequence,tSequence,loopCount__,actionEventTable_)
	if fSequence ~= nil and tSequence ~= nil then
		self.frameSequence = fSequence
		self.timesSequence = tSequence
		self.sequenceIndex = 0
		-- self.timesCount = self.timesSequence[1] --获得第一帧的切换时间
		--修改
		self.timesCount = 0 --self.timesSequence[1] --获得第一帧的切换时间
		self.playCount = loopCount__
		self.curLoopCount = 0

		--通过一个函数表
		--设定该动作序列的一些操作
		--包括帧事件
		--动作结束的回调
		if actionEventTable_ ~= nil then
			self:setActionFinishEvent(actionEventTable_["setActionFinishEvent"])
			self:setFrameEvent(actionEventTable_["setFrameEvent"])
		end


		-- 以下回调函数将会过期
		-- if self.chaneEvent_ then
		-- 	self.chaneEvent_({frame=1})
		-- end

	end
end

function ActionPlayer:getFrame()
	return self.sequenceIndex
end

function ActionPlayer:getFramesLength()
	return #self.frameSequence
end

function ActionPlayer:isFinished()
	if self.curLoopCount >= self.playCount and self.playCount ~= -1 then
		return true
	else
		return false
	end
end

function ActionPlayer:getSpriteSize( )
	return self.sprite_:getContentSize()
end

function ActionPlayer:getFrameName()
	return self.frameSequence[self.sequenceIndex]
end

--这个动作切换帧的时候的函数回调
function ActionPlayer:setFrameEvent(func_)
	self.frameEvent_ = func_
end

--这个动作播放完成的函数回调
function ActionPlayer:setActionFinishEvent(func_)
	self.actionEndEvent_ = func_
end

--动画转变的时候的函数回调
-- function ActionPlayer:setChangeActionEvent(func_)
-- 	self.chaneEvent_ = func_
-- end

function ActionPlayer:setDelayNextFrame(var)
	self.timesCount = self.timesCount *  var
end

function ActionPlayer:setDelayNextFrameByAdd(var)
	self.timesCount = self.timesCount + var
	------print("ActionPlayer:setDelayNextFrameByAdd:",self.timesCount )
end

function ActionPlayer:onPlay(ftimes)
	if not self.timesCount or not self.frameSequence or not self.timesSequence then
	    return
	end
	if self:isFinished() then
		-- ------print("ActionPlayer:onPlay isFinished")
		return 
	end

	self.timesCount = self.timesCount - 1
	-- ------print("self.timesCount",self.timesCount)
	if self.timesCount <= 0 then
		local nextIndex = self.sequenceIndex + 1 
		if nextIndex > #self.frameSequence then
			self.curLoopCount = self.curLoopCount + 1 
			if self.playCount == -1 then
				nextIndex = 1 
			else
				if self.curLoopCount >= self.playCount then
					-- ------print("结束了")
					if self.actionEndEvent_ then
						self.actionEndEvent_()
					end
					return 
				end
			end
		end

		self.sequenceIndex = nextIndex
		self.timesCount = self.timesSequence[nextIndex]
		-- ------print("set self.timesCount",self.timesCount)

		if self.frameSequence ~= nil then
			local fra = self.frameSequence[self.sequenceIndex]
			if fra then
				--print("Sprite Frame ",fra,self.sequenceIndex)
				-- print(fra)
				-- local temp = display.newSprite("#"..fra)
				-- if temp == nil then
				-- 	print(fra)
				-- end

				self.sprite_:setSpriteFrame(fra)

				if self.frameEvent_ then
					self.frameEvent_({frame=self.sequenceIndex})
				end
				
			end
		end
	end
end

return ActionPlayer


