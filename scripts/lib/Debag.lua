local RPD = require "scripts/lib/epicClasses"

local Server = require "scripts/lib/Server"

local User = require "scripts/User"

local Process = require "scripts/lib/Process"

--[[
User.host = User.User.host
User.player = User.User.player
User.status = User.status
--]]
if User.status == User.host then
Cstats = User.player --User.player
else
Cstats = User.host
end
local item = {
giveItem = function(item)
if client == nil then
Server:connect()
end
item = tostring(item)
v = table.concat({User.status,item}," ")
client:sendMessage(v)
end,
receiveItem = function()
item = Server:receiveData()
sep = "%s"
t={}
i=1
for str in string.gmatch(item, "([^"..sep.."]+)") do
t[i] = str
i = i + 1
end
if t[1] == Cstats then
RPD.Dungeon.hero:collect(RPD.ItemFactory:itemByName(t[2]))
end
end
}
local sprite ={
-- я атаковал
sendAttack = function()
if client == nil then
Server:connect()
end
v = table.concat({User.status,"attack"}," ")
client:sendMessage(v)
end,
-- приём
receiveAttack = function()
attack = Server:receiveData()
sep = "%s"
t={}
i=1
for str in string.gmatch(attack, "([^"..sep.."]+)") do
t[i] = str
i = i + 1
end
if t[1] == Cstats then
if t[2] == "attack" then
for i = 1,RPD.Dungeon.level:getLength()-1 do
local maybeMob = RPD.Actor:findChar(i)
if maybeMob and maybeMob:getEntityKind() == "Heroes/Player" then
maybeMob:getSprite():attack(maybeMob:getPos()+1)
end
end
end
end
end

}
local hero = {
--отправка информации о герое
sendHero = function()
pos = tostring(RPD.Dungeon.hero:getPos())
hero = tostring(RPD.Dungeon.hero)
level = tostring(RPD.Dungeon.depth)
if client == nil then
Server:connect()
end
--отправка
v = table.concat({User.status,"hero",pos,hero,level}," ")
RPD.glog(v)
client:sendMessage(v)
end,
--получение
receiveHero = function()
msg = Server:receiveData()
--RPD.glog(msg)
--расшифровка в массив
sep = "%s"
t={}
i=1
for str in string.gmatch(msg, "([^"..sep.."]+)") do
t[i] = str
i = i + 1
end
-- проверка мне ли оно
if t[1] == Cstats and t[2] == "hero" then
-- спавн если нет, передвижение если нет и открытие следующего уровня для User.player
for i = 1,RPD.Dungeon.level:getLength()-1 do
local maybeMob = RPD.Actor:findChar(i)
if maybeMob and maybeMob:getEntityKind() == "Heroes/Player" then
if t[5] ~= tostring(RPD.Dungeon.depth) then
if t[5] > tostring(RPD.Dungeon.depth) then
for i = 1, RPD.Dungeon.level:getLength()-1 do
if RPD.Dungeon.level.map[i] == RPD.Terrain.EXIT or RPD.Dungeon.level[i] == 25 then
RPD.Dungeon.level:set(i-1,RPD.Terrain.EXIT)
end
end
end
maybeMob:destroy()
maybeMob:getSprite():killAndErase()
end
--maybeMob:getSprite():move(maybeMob:getPos(),tonumber(t[3]),true)
--maybeMob:move(tonumber(t[3]))
--maybeMob:beckon(tonumber(t[3]))
if t[3] ~= nil then
Process.beckon_player = tonumber(t[3])
break
end
end
if i == RPD.Dungeon.level:getLength()-1 then
if t[5] == tostring(RPD.Dungeon.depth) then
local mob = RPD.mob("Heroes/Player")
mob:setPos(t[3])
RPD.Dungeon.level:spawnMob(mob);
end
end
end
--[[
RPD.glog(t[5])
RPD.glog(t[3])
RPD.glog(t[4])
--]]
end
end
}
local level = {
-- отправка уровня
sendLevel = function()
if client == nil then
Server:connect()
end
level = {}
level[1] = Cstats
for i = 2, RPD.Dungeon.level:getLength() do
level[i] = RPD.Dungeon.level.map[i]
end
-- переработка в строку
v = table.concat(level," ")
--RPD.glog(v)
client:sendMessage(v)
end,
-- получение
receiveLevel = function()
if client == nil then
Server:connect()
end
level = Server:receiveData()
--RPD.glog(level)
-- обработка в массив
sep = "%s"
t={}
i=1
for str in string.gmatch(level, "([^"..sep.."]+)") do
t[i] = str
i = i + 1
end
-- если это мне
if t[1] == User.status then -- так и должно быть!
RPD.Dungeon.level:set(1,4)
s = {}
for i = 2, #t do
s[i-1] = t[i]
end
s[#t] = 4
for i = 1, #s-2 do
RPD.Dungeon.level:set(i,s[i])
RPD.GameScene:updateMap(i)
--RPD.glog(i.." of "..RPD.Dungeon.level:getLength())
end
-- удаление мобов и предметов
if Cstats == User.player then
for i = 0,RPD.Dungeon.level:getLength()-1 do
local item = RPD.Dungeon.level:getHeap(i)
if item then
item:pickUp()
end
local mob = RPD.Actor:findChar(i)
if mob and mob ~= RPD.Dungeon.hero then
mob:destroy()
mob:getSprite():killAndErase()
end
if RPD.Dungeon.level.map[i] == RPD.Terrain.EXIT or RPD.Dungeon.level[i] == 25 then
RPD.Dungeon.level:set(i-1, 4)
end
end
end

end

for i = 1, RPD.Dungeon.level:getLength()-1 do
if RPD.Dungeon.level.map[i] == RPD.Terrain.ENTRANCE then
f = i-1
end
end
RPD.Dungeon.hero:move(f)
RPD.Dungeon.hero:getSprite():move(RPD.Dungeon.hero:getPos(),f)
end,
sendDie = function()
if client == nil then
Server:connect()
end
v = table.concat({User.status,"true"}," ")
client:sendMessage(v)
end,
receiveDie = function()
die = Server:receiveData()
sep = "%s"
t={}
i=1
for str in string.gmatch(die, "([^"..sep.."]+)") do
t[i] = str
i = i + 1
end
if t[1] == Cstats then
if t[2] == "true" then
RPD.glog("-- Ваш товарищ скончался.")
for i = 1,RPD.Dungeon.level:getLength()-1 do
local maybeMob = RPD.Actor:findChar(i)
if maybeMob and maybeMob:getEntityKind() == "Heroes/Player" then
maybeMob:die()
end
end
end
end
end
}
local Multiplayer = {
hero = hero,
level = level,
sprite = sprite,
item = item
}
return Multiplayer
