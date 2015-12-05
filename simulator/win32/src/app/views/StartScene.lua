--
-- Author: kwyxiong
-- Date: 2015-12-05 15:21:21
--
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

    local menu = cc.Menu:create()
    	:move(333,333)
    	:addTo(self)
     local function onRightKeyPressed()
                -- local event = cc.EventKeyboard:new(cc.KeyCode.KEY_DPAD_RIGHT, false)
                -- cc.Director:getInstance():getEventDispatcher():dispatchEvent(event)
                self:getApp():enterScene("MainScene")
            end

  local rightItem = cc.MenuItemFont:create("哈哈")
            rightItem:setPosition(100, 0)
            rightItem:registerScriptTapHandler(onRightKeyPressed)
            menu:addChild(rightItem)
    rightItem:setFontNameObj(cc.exports.s_fontPath)


  local rightItem = cc.MenuItemFont:create("哈哈")
            rightItem:setPosition(200, 0)
            rightItem:registerScriptTapHandler(onRightKeyPressed)
            menu:addChild(rightItem)
    -- rightItem:setFontNameObj(cc.exports.s_fontPath)


	-- AudioEngine.preloadMusic( cc.exports.s_bgm1 )
	self:init()
end

function StartScene:init()
	-- local sp1 = display.newSprite(#)
	-- AudioEngine.playEffect(cc.exports.s_bgm1, true)
	-- print("aaaaaaaaaaaaaa")
end

return StartScene