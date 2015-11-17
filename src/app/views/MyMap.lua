--
-- Author: kwyxiong
-- Date: 2015-11-17 17:18:25
--
local MyMap = class("MyMap", function(tmxFile) 
		return ccexp.TMXTiledMap:create(tmxFile)
	end)

function MyMap:ctor(tmxFile)
	

end


return MyMap