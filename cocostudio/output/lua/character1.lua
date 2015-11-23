-- moudle(character1)
local character1 = { }
-- 动作
character1.down = { }
-- 这是用到的图片名,用来做索引
character1.down.textures = { "character1 (1)" ,"character1 (2)" ,"character1 (3)" ,"character1 (4)" }
-- 碰撞矩形的坐标,对应着图片
character1.down.collision = { {} ,{} ,{} ,{} }
character1.down.Layer1 = { { 0 , 1 , 2 , 3 , 0 },{ 5 , 5 , 5 , 5 , 0 } }
-- 是否循环播放 down
character1.down.loop = -1
-- 动作
character1.left = { }
-- 这是用到的图片名,用来做索引
character1.left.textures = { "character1 (5)" ,"character1 (6)" ,"character1 (7)" ,"character1 (8)" }
-- 碰撞矩形的坐标,对应着图片
character1.left.collision = { {} ,{} ,{} ,{} }
character1.left.Layer1 = { { 0 , 1 , 2 , 3 , 0 },{ 5 , 5 , 5 , 5 , 0 } }
-- 是否循环播放 left
character1.left.loop = -1
-- 动作
character1.right = { }
-- 这是用到的图片名,用来做索引
character1.right.textures = { "character1 (9)" ,"character1 (10)" ,"character1 (11)" ,"character1 (12)" }
-- 碰撞矩形的坐标,对应着图片
character1.right.collision = { {} ,{} ,{} ,{} }
character1.right.Layer1 = { { 0 , 1 , 2 , 3 , 0 },{ 5 , 5 , 5 , 5 , 0 } }
-- 是否循环播放 right
character1.right.loop = -1
-- 动作
character1.up = { }
-- 这是用到的图片名,用来做索引
character1.up.textures = { "character1 (13)" ,"character1 (14)" ,"character1 (15)" ,"character1 (16)" }
-- 碰撞矩形的坐标,对应着图片
character1.up.collision = { {} ,{} ,{} ,{} }
character1.up.Layer1 = { { 0 , 1 , 2 , 3 , 0 },{ 5 , 5 , 5 , 5 , 0 } }
-- 是否循环播放 up
character1.up.loop = -1

return character1