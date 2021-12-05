--
-- User: mike
-- Date: 24.01.2018
-- Time: 23:58
-- This file is part of Remixed Pixel Dungeon.
--

local RPD = require "scripts/lib/epicClasses"

local mob = require"scripts/lib/mob"

return mob.init{
    stats = function(self)
        RPD.permanentBuff(self, RPD.Buffs.Light)
    end,
    interact = function(self, chr)
    	RPD.resetPos(self,chr)
    end,
    zapProc = function(self,enemy,dmg)
local Callback = luajava.bindClass("com.watabou.utils.Callback")
missile = self:getSprite():getParent():recycle(RPD.Sfx.MagicMissile)
missile:reset( self:getPos(),enemy:getPos(),Callback.callback)
missile:size(4);
missile:pour( RPD.Sfx.ElmoParticle.FACTORY, 0.01f);
--RPD.affectBuff(enemy, "MagicFire",RPD.Dungeon.depth*2)

        RPD.playSound( "snd_zap.mp3" )
    end,

    spawn = function(me, level)
        RPD.playSound( "CrystalGaurd.ogg" )
    end,
        damage = function(me, level)
        RPD.playSound( "CrystalGaurd.ogg" )
    end


}
