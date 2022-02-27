---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by mike.
--- DateTime: 9/25/21 7:41 PM
---

local RPD = require "scripts/lib/commonClasses"

local object = require "scripts/lib/object"

local DungeonTileMap = luajava.bindClass("com.watabou.pixeldungeon.DungeonTilemap")

return object.init{
    stepOn = function(self, object, hero)
        return true
    end,
    addedToScene = function(self, object)
        local Flare = RPD.new("com.watabou.pixeldungeon.effects.Flare",5,6):color(0xff0000,true)
        local Vis = RPD.new("com.watabou.noosa.Visual",DungeonTileMap:tileCenterToWorld(object:getPos()).x+2,DungeonTileMap:tileCenterToWorld(object:getPos()).y-2,1,1)
        local Gr = RPD.new("com.watabou.noosa.Group")
        Vis:setParent(Gr)
        Flare:show(Vis,0f)
        --Flare:point(DungeonTileMap:tileCenterToWorld(object:getPos()).x+3000,DungeonTileMap:tileCenterToWorld(object:getPos()).y-4)
        --RPD.Dungeon.hero:getSprite():getParent():addToBack(Flare)
        RPD.GameScene:effect(Flare)
    end
}