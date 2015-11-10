
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- add background image
    -- display.newSprite("HelloWorld.png")
    --     :move(display.center)
    --     :addTo(self)

    -- -- add HelloWorld label
    -- cc.Label:createWithSystemFont("Hello World", "Arial", 40)
    --     :move(display.cx-500, display.cy -500)
    --     :addTo(self)
    local layer = cc.Layer:create()
    	:addTo(self)
    local kTagTileMap = 1


    local function onTouchesMoved(touches, event )
        local diff = touches[1]:getDelta()
        local node = layer:getChildByTag(kTagTileMap)
        local currentPosX, currentPosY= node:getPosition()
        node:setPosition(cc.p(currentPosX + diff.x, currentPosY + diff.y))
    end

    local listener = cc.EventListenerTouchAllAtOnce:create()
    listener:registerScriptHandler(onTouchesMoved,cc.Handler.EVENT_TOUCHES_MOVED )
    local eventDispatcher = layer:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer)

    local map = ccexp.TMXTiledMap:create("tmx/class.tmx")
    map:move(333 - 500,333 - 500)
    	:addTo(layer, 0, kTagTileMap)

    -- local layer = map:getLayer("route")
    -- local size = layer:getLayerSize()
   
    -- local gid = layer:getTileGIDAt(cc.p(19, 99-80))
    -- print("gid", gid)
    --     local gid = layer:getTileGIDAt(cc.p(18,99- 80))
    -- print("gid", gid)
    --     local gid = layer:getTileGIDAt(cc.p(20, 99-80))
    -- print("gid", gid)

    -- for m = 0,size.width -1 do
    --     for n = 0, size.height -1 do
    --         if  layer:getTileGIDAt(cc.p(m, n)) ~= 0 then
    --             print("m", m)
    --             print("n", n)
    --             print("gid", layer:getTileGIDAt(cc.p(m, n)))
    --             layer:setTileGID(layer:getTileGIDAt(cc.p(m, n)) + 1, cc.p(m, n))
    --         end 
    --     end 
    -- end
end

return MainScene
