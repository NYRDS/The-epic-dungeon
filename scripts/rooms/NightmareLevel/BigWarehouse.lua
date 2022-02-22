local RPD = require "scripts/lib/epicClasses"

local EPD = require "scripts/lib/dopClasses"

local Treasury = luajava.bindClass("com.nyrds.pixeldungeon.items.Treasury")

local customRoom = {
map = function()
return {
4, 4, 4, 4, 5, 4, 4, 4, 4, 4, 9, 9, 9, 9, 9, 9, 9, 4, 4, 9, 9, 9, 9, 9, 9, 9, 4, 4, 9, 9, 4, 4, 4, 9, 9, 4, 5, 9, 9, 4, 4, 4, 9, 9, 5, 4, 9, 9, 9, 9, 9, 9, 9, 4, 4, 9, 9, 9, 9, 9, 9, 9, 4, 4, 9, 9, 9, 9, 9, 9, 9, 4, 4, 4, 4, 4, 5, 4, 4, 4, 4
}
end,
getHidth = function()
return 9
end,
getWidth = function()
return 9
end,
locked = function()
return nil
end,
objects = function(cell)
local W = RPD.Dungeon.level:getWidth()
l = {
"ArmoredStatue",
"Statue"
}
armor = {
"effects/ArmorOnHanger",
"effects/ArmorOnHanger_Cloth",
"effects/ArmorOnHanger_Lether",
"effects/ArmorOnHanger_Mail",
"effects/ArmorOnHanger_Scale",
"effects/ArmorOnHanger_Plate",
"effects/ArmorOnHanger_Gotic"
}
local level = RPD.Dungeon.level
local x = level:cellX(cell)
local y = level:cellY(cell)
for i = x - 4, x + 4 do
for j = y - 4, y + 4 do
local pos = RPD.Dungeon.level:cell(i,j)
if level.map[pos] == RPD.Terrain.EMBERS then

local mob = RPD.mob(armor[math.random(1,#armor)])
if math.random(1,10) == 1 then
local level = RPD.Dungeon.level
mob:setPos(pos-1)
level:spawnMob(mob);
elseif math.random(1,5) == 1 then
local barrel =
{
    kind="CustomObject",
    object_desc = ("NightTile"..tostring(math.random(1,2)))
}
RPD.createLevelObject(barrel, pos-1)
elseif math.random(1,8) == 1 then
if math.random(1,3) == 1 then
item = Treasury:getLevelTreasury():bestOf(Treasury.Category.ARMOR,4 )
else
item = Treasury:getLevelTreasury():bestOf(Treasury.Category.WEAPON,4 )
end
RPD.Dungeon.level:drop(item,pos-1).type = RPD.Heap.Type.CHEST
RPD.GameScene:updateMap(pos-1)
elseif math.random(1,12) == 1 then
mob = RPD.mob(l[math.random(1,#l)])
local level = RPD.Dungeon.level
mob:setPos(pos-1)
level:spawnMob(mob)
elseif math.random(1,16) == 1 then
level:set(pos-1,RPD.Terrain.BARRICADE)
end


end
end
end

local tile =
{
    kind="CustomObject",
    object_desc="HallTile4"
}

RPD.roomsInstruments.spawnObj(9,tile,4,cell)
local tile =
{
    kind="CustomObject",
    object_desc="NightTile8"
}

RPD.roomsInstruments.spawnObj(4,tile,4,cell)
for i = -1,1 do
local barrel =
{
    kind="CustomObject",
    object_desc = ("NightTile"..tostring(math.random(8,10)))
}
RPD.createLevelObject(barrel, cell+i)
end
end
}
return customRoom