--
-- User: mike
-- Date: 06.11.2017
-- Time: 23:57
-- This file is part of Remixed Pixel Dungeon.
--

local RPD = require "scripts/lib/epicClasses"

local BlueWomb =
{
--Пустая комната 5 на 5
Room1 = function(cell, chance)
local level = RPD.Dungeon.level
if cell > level:getWidth()*3 and cell < level:getLength()-level:getWidth()*3 and math.random(1,chance) == 1 then
local x = level:cellX(cell)
local y = level:cellY(cell)
        for t = x - 2, x + 2 do
         for j = y - 2, y + 2 do
local pos = level:cell(t,j)
level:set(pos, RPD.Terrain.EMPTY )
RPD.GameScene:updateMap(pos)
end
end
end
end,
--Полная комната 5 на 5
Room2 = function(cell, chance)
local level = RPD.Dungeon.level
if cell > level:getWidth()*3 and cell < level:getLength()-level:getWidth()*3 and math.random(1,chance) == 1 then
local x = level:cellX(cell)
local y = level:cellY(cell)
        for t = x - 2, x + 2 do
         for j = y - 2, y + 2 do
local pos = level:cell(t,j)
level:set(pos, RPD.Terrain.EMPTY )
RPD.GameScene:updateMap(pos)
end
end
end
end,

-- Сердце на педестале
Room3 = function(cell, chance)
local level = RPD.Dungeon.level
if cell > level:getWidth()*3 and cell < level:getLength()-level:getWidth()*3 and math.random(1,chance) == 1 then
local x = level:cellX(cell)
local y = level:cellY(cell)
        for t = x - 2, x + 2 do
         for j = y - 2, y + 2 do
local pos = level:cell(t,j)
level:set(pos, RPD.Terrain.STATUE )
RPD.GameScene:updateMap(pos)
end
end
        for t = x - 1, x + 1 do
         for j = y - 2, y + 2 do
local pos = level:cell(t,j)
level:set(pos, RPD.Terrain.EMPTY )
RPD.GameScene:updateMap(pos)
end
end
        for t = x - 2, x + 2 do
         for j = y - 1, y + 1 do
local pos = level:cell(t,j)
level:set(pos, RPD.Terrain.EMPTY )
RPD.GameScene:updateMap(pos)
end
end
local mob = RPD.mob("BlueHeart")            mob:setPos(cell)
RPD.Dungeon.level:spawnMob(mob)
level:set(cell, RPD.Terrain.PEDESTAL )
end
end,
-- вход
Entrance = function()
local level = RPD.Dungeon.level
level:set(RPD.Dungeon.hero:getPos(), RPD.Terrain.ENTRANCE)
if RPD.Dungeon.hero:getPos() > level:getWidth()*2 and RPD.Dungeon.hero:getPos() < level:getLength()-level:getWidth()*2 then
local level = RPD.Dungeon.level
local x = level:cellX(RPD.Dungeon.hero:getPos())
local y = level:cellY(RPD.Dungeon.hero:getPos())
        for t = x - 1, x + 1 do
         for j = y - 1, y + 1 do
local pos = level:cell(t,j)
level:set(pos, RPD.Terrain.EMPTY )
RPD.GameScene:updateMap(pos)
end
end
end
end,
-- выход
Exit = function()
local p = RPD.Dungeon.level:randomRespawnCell()
RPD.Dungeon.level:setExit(p)
RPD.Dungeon.level:set(p, RPD.Terrain.EXIT )
RPD.GameScene:updateMap(p)
end
}

local Rooms =
{
BlueWomb = BlueWomb,
-- создание границ
MakeBorder = function()
local level = RPD.Dungeon.level
for i = 0,RPD.Dungeon.level:getLength()-1 do           
if i <= level:getWidth() then
level:set(i, RPD.Terrain.WALL )
RPD.GameScene:updateMap(i)
end
if level:cellX(i) == 1 and i ~= 1 then
level:set(i-1, RPD.Terrain.WALL )
RPD.GameScene:updateMap(i-1)
level:set(i-2, RPD.Terrain.WALL )
RPD.GameScene:updateMap(i-2)
end
--if level:cellX(i) == level:getWidth() then
--level:set(i-2, RPD.Terrain.WALL )
--RPD.GameScene:updateMap(i-2)
--end
if level:cellY(i) == level:getHeight() then
level:set(i, RPD.Terrain.WALL )
RPD.GameScene:updateMap(i)
end
end
end
}
return Rooms
