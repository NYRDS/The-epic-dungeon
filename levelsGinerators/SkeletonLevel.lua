local table = 
{
kind = "Castle",
Entrance = "Entrance",
EntranceDebag = "EntranceDebag",
Exit = "Exit",
ExitHeigth = 4,
ExitWidth = 4,
RoomHeigth = 7,
RoomWidth = 7,
RandRooms = {"ShadowLibrary"},
-- RandRooms = {"PrisonArmory"},
HasBase = false,
Items = {"Ration"},
Water = true,
WaterMin = 1,
WaterMax = 2,
WaterChanse = 0.0005,
Grass = true,
GrassChanse = 0.0001,
GrassMin = 1,
GrassMax = 2,
Traps = {
"ToxicTrap",
"FireTrap",
"PoisonTrap",
"AlaramTrap",
"GrippingTrap",
"LightingTrap",
"ParalyticTrap",
"SecretToxicTrap",
"SecretFireTrap",
"SecretPoisonTrap",
"SecretAlaramTrap",
"SecretGrippingTrap",
"SecretLightingTrap",
"SecretParalyticTrap"
},
ChanseTrap = 0.1,
Shop = "PrisonShop",
LevelShop = 16,
ShopWidth = 7,
ShopHeigth = 7,
NPC = nil,
levelNPC = 17,
NPCRoom = "ElderShamanRoom",
NPCRoomWidth = 7,
NPCRoomHeigth = 7,
Range = 10000,
GinFactor = 20,
RoomFactor = 0,
MiniBoss = {"NightBroneRoom"},
LevelMiniBoss = 19
}

return table