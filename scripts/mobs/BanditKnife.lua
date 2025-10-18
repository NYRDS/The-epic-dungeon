--
-- User: mike
-- Date: 23.11.2017
-- Time: 21:04
-- This file is part of Remixed Pixel Dungeon.
--

local RPD = require "scripts/lib/epicClasses"

local mob = require "scripts/lib/mob"

local function teleport(chr, level)
    local opos = chr:getPos()
    local x = level:cellX(opos)
    local y = level:cellY(opos)
    for i = x - 3, x + 3 do
        for j = y - 3, y + 3 do
            local pos = RPD.Dungeon.level:cell(i, j)
            if math.random(1, 5) == 1 then
                chr:getSprite():emitter():burst(RPD.Sfx.Speck:factory(RPD.Sfx.Speck.WOOL), 4)
                local dst = RPD.Ballistica:cast(opos, pos, true, true, false)
                chr:move(dst)
                chr:getSprite():move(opos, dst)
                return
            end
        end
    end
end

return mob.init({
    zapProc = function(self, enemy, dmg)
        local level = RPD.Dungeon.level
        if level:distance(self:getPos(), enemy:getPos()) < 3 then
            teleport(self, level)
        end
        return dmg
    end,
    attackProc = function(self, enemy, dmg)
        teleport(self)
        return dmg
    end
})


