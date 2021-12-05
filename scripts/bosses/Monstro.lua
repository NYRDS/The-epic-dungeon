--
-- User: mike
-- Date: 23.11.2017
-- Time: 21:04
-- This file is part of Remixed Pixel Dungeon.
--

local RPD = require "scripts/lib/epicClasses"

local mob = require"scripts/lib/mob"

local storage = require"scripts/lib/storage"

local EPD = require "scripts/lib/dopClasses"
return mob.init({
act       = function(me, ai, mee)
--me:getSprite():setScale(-5,-5)
--me:getSprite():update()
if not storage.get("scream") then
me:spend(1)
me:getSprite():emitter():burst(RPD.Sfx.Speck:factory( RPD.Sfx.Speck.SCREAM), 6)
me:getSprite():zap(1)
storage.put("scream",true)
end

if math.random(1,2) == 1 then
me:spend(4)
for i=1,RPD.Dungeon.level:getLength()-1 do
if RPD.Dungeon.level.map[i] == RPD.Terrain.CHASM_WATER then
if math.random(1,100) == 1 then
local mob = RPD.mob("Tentacle") 
mob:setPos(i-1)
RPD.Dungeon.level:spawnMob(mob)
end
end
end
elseif math.random(1,2) == 1 then
me:spend(1)
for i = 1, math.random(2,5) do
for i = 1, RPD.Dungeon.level:getLength() do
if RPD.Dungeon.level.map[i] ~= RPD.Dungeon.level.solid[i-1] and math.random(1,30) == 1 then
pos = i-1 
break
end
end
local mob = RPD.mob("effects/DarckShot") 
mob:setPos(me:getPos())
RPD.Dungeon.level:spawnMob(mob)
local distance = RPD.Dungeon.level:distance(me:getPos(),pos)
RPD.Tweeners.JumpTweener:attachTo(mob:getSprite(),pos, distance * 16,distance * 0.1)
mob:die()
RPD.topEffect(pos,"Explotion")
RPD.playSound( "snd_explosion.ogg" )
if pos == RPD.Dungeon.hero:getPos() then
RPD.Dungeon.hero:damage(math.random(45,70),me)
end
end
else
RPD.placeBlob(RPD.Blobs.ToxicGas, me:getPos(),100)
me:spend(2)
end
if me:hp() < 1000 then

if not storage.get("warlock") then
storage.put("warlock",true) 
local Music = luajava.bindClass("com.watabou.noosa.audio.Music")
Music.INSTANCE:play("Help.ogg",true)

for i=1,RPD.Dungeon.level:getLength()-1 do
if RPD.Dungeon.level.map[i] == RPD.Terrain.EMPTY then
RPD.topEffect(i-1,"Portal")
local mob = RPD.mob("BattleWarlok") 
mob:setPos(i-1)
RPD.Dungeon.level:spawnMob(mob)

EPD.showQuestWindow(mob,RPD.StringsManager:maybeId("BattleWarlock_Phrase1"))

break
end
end
RPD.topEffect(40,"Portal")
local mob = RPD.mob("DworfSolder") 
mob:setPos(40)
RPD.Dungeon.level:spawnMob(mob)
RPD.topEffect(51,"Portal")
RPD.setAi(mob,"Wandering")
local mob = RPD.mob("DworfSolder") 
mob:setPos(51)
RPD.Dungeon.level:spawnMob(mob)
RPD.setAi(mob,"Wandering")
RPD.topEffect(274,"Portal")
local mob = RPD.mob("DworfSolder") 
mob:setPos(274)
RPD.Dungeon.level:spawnMob(mob)
RPD.setAi(mob,"Wandering")
RPD.topEffect(285,"Portal")
local mob = RPD.mob("DworfSolder") 
mob:setPos(285)
RPD.Dungeon.level:spawnMob(mob)
RPD.setAi(mob,"Wandering")
end
end
end,
spawn = function(self)
lol = nil
local storage = require "scripts/lib/storage"
storage.put("keys",false)
end,
die = function(self, cause)
--[[
local storage = require "scripts/lib/storage"
storage.put("keys",false) 
--]]
RPD.GameScene:bossSlain()
RPD.playSound("snd_boss.mp3")
for i = 1, RPD.Dungeon.level:getLength()-1 do
local maybeMob = RPD.Actor:findChar(i)          
if maybeMob and maybeMob ~= RPD.Dungeon.hero and maybeMob:ht() == 76 then
maybeMob:damage(100,RPD.Dungeon.hero)
end
end
        local Camera = luajava.bindClass("com.watabou.noosa.Camera")
Camera.main:shake(8,0.7)
local level = RPD.Dungeon.level
local item = RPD.ItemFactory:itemByName("SkeletonKey")
level:drop(item,RPD.Dungeon.hero:getPos())
local itemf = RPD.ItemFactory:itemByName("Artifacts/ChestSharm")
level:drop(itemf,RPD.Dungeon.hero:getPos())
local Music = luajava.bindClass("com.watabou.noosa.audio.Music")
Music.INSTANCE:play("Return.ogg",true)

end
  })


