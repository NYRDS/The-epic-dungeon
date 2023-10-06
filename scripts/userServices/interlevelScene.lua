---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by mike.
--- DateTime: 5/9/22 1:15 AM
---

local RPD = require "scripts/lib/commonClasses"
local storage = require "scripts/lib/storage"

local interlevelScene = {}

local Camera = luajava.bindClass("com.watabou.noosa.Camera")

local function add(file, h)
local h = h or 128
local img = RPD.new("com.watabou.noosa.Image", ("backgrounds/"..file..".png"))
local k = Camera.main.height/h
img:setPos(0,0)
img:setScaleX(k)
img:setScaleY(k)
return img
end

--! Called when interlevelScene enters static mode
interlevelScene.onStep = function(mode, done)
        if RPD.Dungeon.levelId == 'Town' then
           art = add("Hero",1440)
        elseif RPD.Dungeon.levelId == 'Sewer1' then
           art = add("SewerSnails")
        end
        if art then
        if storage.get(RPD.Dungeon.levelId) == nil then
            RPD.RemixedDungeon:scene():add(art)
            art = nil
            storage.put(RPD.Dungeon.levelId,true)
        else
            art:killAndErase()
        end
        end
    return true
end


return interlevelScene