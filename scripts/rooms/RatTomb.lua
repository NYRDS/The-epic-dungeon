local RPD = require "scripts/lib/commonClasses"

local EPD = require "scripts/lib/dopClasses"

local Treasury = luajava.bindClass("com.nyrds.pixeldungeon.items.Treasury")

local customRoom = {
map = function()
return {
35, 1, 1, 1, 35, 1, 15, 15, 15, 1, 1, 15, 15, 15, 1, 1, 15, 15, 15, 1, 35, 1, 1, 1, 35
}
end,
getHidth = function()
return 5
end,
getWidth = function()
return 5
end,
objects = function(cell)
local W = RPD.Dungeon.level:getWidth()

item = Treasury:getLevelTreasury():bestOf(Treasury.Category.WEAPON,4 )
RPD.Dungeon.level:drop(item,cell-1).type = RPD.Heap.Type.TOMB

item = Treasury:getLevelTreasury():bestOf(Treasury.Category.ARMOR,4 )
RPD.Dungeon.level:drop(item,cell+1).type = RPD.Heap.Type.TOMB

end,
locked = function()
return nil
end,
Object2 = function(cell)
end
}
return customRoom