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

cc.exports.ccsui = ccsui
