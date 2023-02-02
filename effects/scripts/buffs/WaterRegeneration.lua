---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by mike.
--- DateTime: 25.03.19 0:06
---
local RPD  = require "scripts/lib/epicClasses"

local buff = require "scripts/lib/buff"


return buff.init{
    desc  = function ()
        return {
            icon          = 1,
            name          = RPD.StringsManager:maybeId("Water_Regeneration_Buff"),
            info          = "DieHard_Info",
        }
    end,
    textureLarge = function()
    return "ui/CustomBuffsLarge.png"
    end,
    textureSmall = function()
    return "ui/CustomBuffs.png"
    end,
attachTo = function(self, buff, target)
return true
    end,
    detach = function(self, buff)
    end,
    act = function(self,buff)
        buff:detach()
end, 
   charAct = function(self,buff)
if RPD.Dungeon.level.water[buff.target:getPos()] then
buff.target:hp(math.min(buff.target:hp()+10));
buff:spend(1)
buff.target:getSprite():emitter():burst(RPD.Sfx.Speck:factory(RPD.Sfx.Speck.HEALING ), 5)
end
end 
}
