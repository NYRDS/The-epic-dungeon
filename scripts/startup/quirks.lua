local RPD = require "scripts/lib/commonClasses"

-- Engine-compat gate: this mod speaks the kind-string buff API introduced
-- with RPD.Buffs.Bleeding. On older engines the buff class binds are gone
-- and the mod would fail with obscure ClassCastExceptions - refuse early
-- with a clear message instead.
if not RPD.Buffs.Bleeding then
    error("The epic dungeon needs Remixed Pixel Dungeon 32.5 or newer - please update the game")
end

RPD.ModQuirks.only2dTiles = true
