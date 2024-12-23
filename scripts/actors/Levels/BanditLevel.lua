--
-- User: mike
-- Date: 06.11.2017
-- Time: 23:57
-- This file is part of Remixed Pixel Dungeon.
--

local RPD = require "scripts/lib/epicClasses"

local actor = require "scripts/lib/actor"

local Ginerator = require "scripts/lib/Ginerator"

local storage = require "scripts/lib/storage"

return actor.init({
    activate = function()
        local level = RPD.Dungeon.level
        if RPD.Dungeon.depth ~= 25 then
            Ginerator.CreateLevel("BanditLevel")
            if not storage.get("Deco") then 
                storage.put("Deco", true)
                for i = 1, level:getLength() - 1 do
                    if level.map[i] == 4 then
                        if math.random(1, 100) == 1 then
                            level:set(i - 1, RPD.Terrain.WALL_DECO)
                            RPD.GameScene:updateMap(i - 1)
                        end
                    end
                end
            end
        else
            for i = 1, 15 * 15 do
                if level.map[i] == RPD.Terrain.PEDESTAL then
                    level:set(i - 1, RPD.Terrain.EMPTY_SP)
                    level:drop(RPD.item("Gold"), i - 1).type = RPD.Heap.Type.CHEST
                end
            end

        end
        local levelSize = level:getLength()
        for i = 0, levelSize - 1 do
            if level.map[i] == RPD.Terrain.EMPTY and math.random(1, 3) == 1 then
                local emitter = RPD.Sfx.CellEmitter:get(i - 1)
                emitter:pour(RPD.Sfx.WindParticle.FACTORY, 0.9)
            end
        end

        for i = 1, level:getLength() - 1 do
            local maybeMob = RPD.Actor:findChar(i)
            if maybeMob and maybeMob:getEntityKind() == "Shopkeeper" then
                RPD.topEffect(i, "BanditKeeper")
                maybeMob:getSprite():killAndErase()
            end
        end

        return true
    end,
    actionTime = function()
        return 1
    end,
    act = function()
        if RPD.Dungeon.depth == 21 then
            if not storage.get("storybandit") then
                local wnd = RPD.new(RPD.Objects.Ui.WndStory, RPD.StringsManager:maybeId("Bandit_Story"))
                RPD.GameScene:show(wnd)
                storage.put("storybandit", true)
            end
        end
        return true
    end
})
