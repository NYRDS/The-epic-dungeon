---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by mike.
--- DateTime: 23.08.18 22:51
---

local RPD = require "scripts/lib/epicClasses"

local ai = require "scripts/lib/ai"

return ai.init{

act       = function(me, ai, me)

zap = function()
local cell = RPD.Ballistica:cast(me:getPos(),RPD.Dungeon.hero:getPos(),true,true,true)
me:getSprite():zap(cell)
if RPD.Actor:findChar(cell) and RPD.Actor:findChar(cell) ~= me then
RPD.Actor:findChar(cell):damage(math.random(10,25),me)
RPD.zapEffect(me:getPos(),cell,"WhiteBall")
end
end

addPool = function()
poolDamage = function(cell)
local mob = RPD.Actor:findChar(cell)
if mob and mob ~= me then
mob:damage(4,me)
end
end
RPD.forCellsAround(me:getPos(),poolDamage)
end

if RPD.Dungeon.level:distance(RPD.Dungeon.hero:getPos(),me:getPos()) < 3 then

me:spend(1)
addPool()
zap()

else

me:spend(1)

end
end,

    gotDamage = function(me, ai, me, src, dmg)
end,

    status = function(me, ai, me)
        return RPD.StringsManager:maybeId("attack_on_you")
    end
}