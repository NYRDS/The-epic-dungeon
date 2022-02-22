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
        local Flare = RPD.new("com.watabou.pixeldungeon.effects.Flare",10,10):color(0xffffff,true)
        local Vis = RPD.new("com.watabou.noosa.Visual",DungeonTileMap:tileCenterToWorld(object:getPos()).x,DungeonTileMap:tileCenterToWorld(object:getPos()).y-4,1,1)
        local Gr = RPD.new("com.watabou.noosa.Group")
        Vis:setParent(Gr)
        Flare:showOnTop(Vis,0f)
        --Flare:show(RPD.Dungeon.hero:getSprite(),0f)
        --Flare:point(DungeonTileMap:tileCenterToWorld(object:getPos()).x,DungeonTileMap:tileCenterToWorld(object:getPos()).y-4)
        --RPD.Dungeon.hero:getSprite():getParent():addToBack(Flare)
        RPD.GameScene:effect(Flare)
    end
}