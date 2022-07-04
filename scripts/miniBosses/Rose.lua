--
-- User: mike
-- Date: 24.01.2018
-- Time: 23:58
-- This file is part of Remixed Pixel Dungeon.
--

local RPD = require "scripts/lib/epicClasses"

local mob = require"scripts/lib/mob"

local EPD = require "scripts/lib/dopClasses"

local storage = require "scripts/lib/storage"

return mob.init{
act = function(self)
local level = RPD.Dungeon.level
local x = level:cellX(self:getPos())
local y = level:cellY(self:getPos())
for i = x - 4, x + 4 do
for j = y - 4, y + 4 do
local pos = RPD.Dungeon.level:cell(i,j)
local object = RPD.Dungeon.level:getTopLevelObject(pos)
if object and object:getEntityKind() == "RoseTomb" then
object.sprite:kill()
level:remove(object)
local mob = RPD.mob("RoseSkeleton")
mob:setPos(pos)
level:spawnMob(mob)
RPD.topEffect(pos,"RaiseSkeleton")
end
end
end
self:spend(1)
end,
die = function(self)
local level = RPD.Dungeon.level
local x = level:cellX(self:getPos())
local y = level:cellY(self:getPos())
for i = x - 4, x + 4 do
for j = y - 4, y + 4 do
local pos = RPD.Dungeon.level:cell(i,j)
local mob = RPD.Actor:findChar(pos)  
if mob ~= RPD.Dungeon.hero then
if mob and mob:getMobClassName() == "Prison/RoseSkeleton" then
mob:damage(100,self)
end
end
end
end
end
}
