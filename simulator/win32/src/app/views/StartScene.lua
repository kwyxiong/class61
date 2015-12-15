--
-- Author: kwyxiong
-- Date: 2015-12-05 15:21:21
--
local ParticleLeaf = require("app.utils.ParticleLeaf")
local StartScene = class("StartScene", cc.load("mvc").ViewBase)


function StartScene:onCreate()


    -- local function touchEvent(sender,eventType)
    --     if eventType == ccui.TouchEventType.began then
    --         -- self._displayValueLabel:setString("Touch Down")
    --     elseif eventType == ccui.TouchEventType.moved then
    --         -- self._displayValueLabel:setString("Touch Move")
    --     elseif eventType == ccui.TouchEventType.ended then
    --         -- self._displayValueLabel:setString("Touch Up")
    --     elseif eventType == ccui.TouchEventType.canceled then
    --         -- self._displayValueLabel:setString("Touch Cancelled")
    --     end
    -- end
    -- local button = ccui.Button:create()
    -- button:setTouchEnabled(true)
    -- button:loadTextures("cocosui/animationbuttonnormal.png", "cocosui/animationbuttonpressed.png", "")
    -- button:setPosition(cc.p(widgetSize.width / 2.0, widgetSize.height / 2.0))
    -- button:addTouchEventListener(touchEvent)
    -- self._uiLayer:addChild(button)


    -- dump(cc.p(menu:getPosition()))
    -- dump(cc.p(menu:getPosition()))
  -- local rightItem = cc.MenuItemFont:create("哈哈")
  --           rightItem:setPosition(200, 0)
  --           rightItem:registerScriptTapHandler(onRightKeyPressed)
  --           menu:addChild(rightItem)
    -- rightItem:setFontNameObj(cc.exports.s_fontPath)
	-- AudioEngine.preloadMusic( cc.exports.s_bgm1 )
	
	self:playFade()
	self:initUI()
	self:playMusic()
	self:playParticle()
end

function StartScene:start()
	self:getApp():enterScene("StartLabels", "FADE", 2)
end

function StartScene:playParticle()
	self:runAction(cc.Sequence:create(
			cc.DelayTime:create(2),
			cc.CallFunc:create(function() 

					local particleLeaf = ParticleLeaf.new({image = cc.exports.s_leaf})
						:addTo(self)
				end)
		))
end

function StartScene:playFade()
	self:setOpacity(0)
	self:setCascadeOpacityEnabled(true)
	self:runAction(cc.FadeIn:create(2))
end

function StartScene:initMenu()
    local menu = cc.Menu:create()
    	-- :move(0,0)
    	:addTo(self)
     local function onRightKeyPressed()
                -- local event = cc.EventKeyboard:new(cc.KeyCode.KEY_DPAD_RIGHT, false)
                -- cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
                self:start()
            end

  local rightItem = cc.MenuItemFont:create("start")
            rightItem:setPosition(0,  - 100)
            rightItem:registerScriptTapHandler(onRightKeyPressed)
            menu:addChild(rightItem)
    rightItem:setFontNameObj(cc.exports.s_fontPath)


    display.newSprite("s2.png")
    	:move(333,333)
    	:addTo(self)

end

function StartScene:initUI()

	local bg = display.newSprite("bg4.png")
		:move(display.cx, display.cy)
		:addTo(self)
	bg:setAnchorPoint(cc.p(0.5, 0.5))

	local bg = display.newSprite("bg3.png")
		:move(display.cx, display.cy)
		:addTo(self)
	bg:setAnchorPoint(cc.p(0.5, 0.5))


	local uiNode = display.newNode()
		:addTo(self)
	uiNode:setCascadeOpacityEnabled(true)

    local function touchEvent(sender,eventType)
        if eventType == ccui.TouchEventType.began then
            -- self._displayValueLabel:setString("Touch Down")
            -- sender:setScale(1.1)
        elseif eventType == ccui.TouchEventType.moved then
            -- self._displayValueLabel:setString("Touch Move")
        elseif eventType == ccui.TouchEventType.ended then
            -- self._displayValueLabel:setString("Touch Up")
            -- sender:setScale(1)
            -- self:getApp():enterScene("MainScene")



            self:getEventDispatcher():pauseEventListenersForTarget(self, true)
            uiNode:runAction(cc.Sequence:create(
            	cc.FadeOut:create(1),
            	cc.CallFunc:create(function() 
            			bg:runAction(cc.Sequence:create(
            					cc.FadeOut:create(3),
            					cc.CallFunc:create(function() 
            							local rand = math.random(1, table.nums(display.SCENE_TRANSITIONS))
            							local tran
            							local index = 1
            							for k, v in pairs(display.SCENE_TRANSITIONS) do
            								if index == rand then
            									tran = k
            									break
            								else
            									index = index + 1
            								end
            							end
            							-- dump(display.SCENE_TRANSITIONS)
            							self:start()
            						end)
            				))	
            		end)
            	))
            -- bg:runAction(cc.FadeOut:create(3))
        elseif eventType == ccui.TouchEventType.canceled then
        	-- sender:setScale(1)
            -- self._displayValueLabel:setString("Touch Cancelled")
        end
    end
    local button = ccui.Button:create()
    button:setTouchEnabled(true)
    button:loadTextures("s1.png", "s2.png", "")
    button:setPosition(display.cx + 300, display.cy - 100)
    button:addTouchEventListener(touchEvent)
    uiNode:addChild(button)	

end

function StartScene:playMusic()
	-- local sp1 = display.newSprite(#)
	AudioEngine.playEffect(cc.exports.s_bgm1, true)
	-- print("aaaaaaaaaaaaaa")
end

return StartScene