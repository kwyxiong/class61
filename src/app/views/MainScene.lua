
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

function MainScene:onCreate()
    -- add background image
    display.newSprite("HelloWorld.png")
        :move(display.center)
        :addTo(self)

    -- add HelloWorld label
    cc.Label:createWithSystemFont("Hello World", "Arial", 40)
        :move(display.cx-500, display.cy -500)
        :addTo(self)
    local map = ccexp.TMXTiledMap:create("tmx/class.tmx")
    map:move(333 - 500,333 - 500)
    	:addTo(self)

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
