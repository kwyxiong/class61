
local MyMap = require("app.views.MyMap")
local MyCamera = require("app.views.MyCamera")
local Route_pt = require("app.utils.Route_pt")
local AStarRoute = require("app.utils.AStarRoute")
local ActionPlayer = require("app.views.ActionPlayer")
local MainScene = class("MainScene", cc.load("mvc").ViewBase)
local scheduler = cc.Director:getInstance():getScheduler()
function MainScene:onCreate()
    self:initCamera()
    self:initMap()
    self:initHero()
    self:onUpdate(handler(self, self.onTick))

 

    -- local route_layer = map:getLayer("route_tiles-gakuen-001")
    -- local hero_layer = map:getLayer("hero")


    -- display.loadSpriteFrames("characters/character1.plist", "characters/character1.png")
    -- self.actionPlayer = ActionPlayer.new({ani = "character1"})
    --     :moveToMap(2, 98)
    --     :addTo(hero_layer)
    -- -- local pt = Route_pt.new(11, 86)
    -- -- self.actionPlayer:move()
    -- local size = route_layer:getLayerSize()
    
    
    -- self.actionPlayer:playAction("up")
    

    -- local map = {}
    -- for m = 1, size.width do
    --     local res ={}
    --     for n = 1, size.height do
    --         if route_layer:getTileGIDAt(cc.p(m-1, n-1)) ~= 0 then
    --             res[#res + 1] = 0
    --         else
    --             res[#res + 1] = 1
    --         end
    --     end
    --     map[#map + 1] = res
    -- end


   
    -- local aStarRoute = AStarRoute.new(map, 6, 98, 8, 96)
    -- local res = aStarRoute:getResult()
    -- -- dump(res, "res")
    -- if res then
    --     for k, v in ipairs(res) do
    --         print("x = " .. v:getX() .. ", y = " .. v:getY())
    --     end
    -- end

end

function MainScene:initCamera()
    self.camera = MyCamera.new()
        :addTo(self)
    self.camera:setDrugEnabled(true)
end

function MainScene:initMap()
    self.map = MyMap.new("tmx/class.tmx", handler(self, self.mapTouch))
        :addTo(self.camera)
    self.map:setTouchEnabled(true)
end

function MainScene:mapTouch(x, y)
    self.actionPlayer:moveToMap(x, y)
end

function MainScene:initHero()
    display.loadSpriteFrames("characters/character1.plist", "characters/character1.png")
    self.actionPlayer = ActionPlayer.new({ani = "character1"})
        :moveToMap(2, 98)
        :addToMap(self.map)
    -- local pt = Route_pt.new(11, 86)
    -- self.actionPlayer:move()
    -- local size = route_layer:getLayerSize()
    
    
    self.actionPlayer:playAction("up")

end

function MainScene:onTick(dt)
    self.actionPlayer:onPlay(dt)
end

return MainScene
