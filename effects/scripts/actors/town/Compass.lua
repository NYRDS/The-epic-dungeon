---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by mike.
--- DateTime: 04.08.18 18:14
---

local RPD = require "scripts/lib/epicClasses"

local actor = require "scripts/lib/actor"

local storage = require "scripts/lib/storage"

return actor.init({
    actionTime = function()
        return 1
    end,
    activate = function()
RPD.removeBuff(RPD.Dungeon.hero, "ModBuff")
RPD.permanentBuff(RPD.Dungeon.hero, "ModBuff")
if RPD.Dungeon.depth == 1 then
if not storage.get("storymod") then
       local wnd = RPD.new(RPD.Objects.Ui.WndStory,RPD.StringsManager:maybeId("Mod_Story"))
       RPD.GameScene:show(wnd)
       storage.put("storymod",true)
end
end
if not storage.get("light_in_town") then
storage.gamePut("snow_in_town",true)
storage.put("light_in_town",true)
RPD.createLevelObject({
    kind="CustomObject",
    object_desc="Light"
}
,335)
RPD.createLevelObject({
    kind="CustomObject",
    object_desc="Light"
}
,596)
RPD.createLevelObject({
    kind="CustomObject",
    object_desc="Light"
}
,358)
RPD.createLevelObject({
    kind="CustomObject",
    object_desc="Light"
}
,250)
RPD.createLevelObject({
    kind="CustomObject",
    object_desc="Light"
}
,787)
end

if storage.gameGet("snow_in_town") then
local levelSize = RPD.Dungeon.level:getLength()
for i = 0 , levelSize - 1 do
  if RPD.Dungeon.level.solid[i] then
   local emitter = RPD.Sfx.CellEmitter:get(i)
   emitter:pour(RPD.Sfx.SnowParticle.FACTORY, 2)
  end
  local mob = RPD.Actor:findChar(i)
  if mob then
  mob:getSprite():tint(0,0,0,0.3)
  end
end
end

    end,
act = function()
return true
end
})
