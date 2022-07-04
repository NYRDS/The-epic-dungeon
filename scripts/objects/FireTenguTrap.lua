---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by mike.
--- DateTime: 9/25/21 7:41 PM
---

local RPD = require "scripts/lib/commonClasses"

local object = require "scripts/lib/object"

local DungeonTileMap = luajava.bindClass("com.watabou.pixeldungeon.DungeonTilemap")

return object.init{

    bump = function(self, object, presser)
    local tile =
            {
                kind="CustomObject",
                object_desc="UnactiveFireTenguTrap"
            }
    RPD.createLevelObject(tile,object:getPos())
    RPD.placeBlob(RPD.Blobs.LiquidFlame,object:getPos(),10)
    object.sprite:kill()
    RPD.Dungeon.level:remove(object)
    end
}