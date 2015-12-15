--
-- Author: kwyxiong
-- Date: 2015-11-24 17:00:31
--

local ccsui = {}

ccsui.getDefaultFont = function() 
	return cc.exports.s_fontPath
end


ccsui.createLabel = function(options) 
	
	local fontName = options.fontName or ccsui.getDefaultFont()
	local fontSize = options.fontSize or 24
	local fontColor = options.fontColor or cc.c4b(255, 255, 255, 255)
	local text = options.text or ""
	local maxLineWidth = options.maxLineWidth or display.width
	local hAlignment = options.hAlignment or cc.VERTICAL_TEXT_ALIGNMENT_TOP
   
	local ttfConfig = {}
    ttfConfig.fontFilePath=fontName
    ttfConfig.fontSize=fontSize
  	
    local label = cc.Label:createWithTTF(ttfConfig,text, hAlignment, maxLineWidth)
    label:setTextColor(fontColor)
  	return label
end

--创建一个全屏触摸
ccsui.addTouchLayer = function(touchCallback) 
	local scene = cc.Director:getInstance():getRunningScene()
	local layer = cc.Layer:create()
		:addTo(scene)
	local function onTouchesEnded(touches, event )
	    if touchCallback then
	    	touchCallback()
	    end
	end

    local listener = cc.EventListenerTouchAllAtOnce:create()
    listener:registerScriptHandler(onTouchesEnded,cc.Handler.EVENT_TOUCHES_ENDED )
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

end

cc.exports.ccsui = ccsui
