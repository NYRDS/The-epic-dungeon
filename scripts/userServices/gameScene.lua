---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by mike.
--- DateTime: 5/2/20 12:57 AM
---

local RPD = require"scripts/lib/epicClasses"

local gameScene = {
    onStep = function()
        RPD.runFunctions()
    end,
    selectCell = function()
    end
}
return gameScene

