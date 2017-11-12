--Made by Cake, DecentGaming.org
print("Cake module Loaded: SH_Commands")

if CLIENT then
CreateClientConVar("cake_duty",0,false,true)
end

--Waits for DarkR to load the module and waits 3 seconds. This is needed to properly overide the advert command consistantly
timer.Simple(3,function()
DarkRP.removeChatCommand("advert")
--Runs a hook as soon as the advert command is gone
hook.Call("RemovedAdvert")
end)
--Add the advert command back with my new information
hook.Add("RemovedAdvert","afaf122",function ()
DarkRP.declareChatCommand({command="advert",description="Make a chat advertisement",delay=1.5})
end)

DarkRP.declareChatCommand({command="roll",description="Make a Dice roll",delay=2})
--DarkRP.declareChatCommand({command="switch",description="Go off/On Duty",delay=2})
DarkRP.declareChatCommand({command="looc",description="Use local OOC (LOOC)",delay=1.5})

DarkRP.declareChatCommand({command="buyhealth",description="Buy health when there is no medic",delay=1.5})

DarkRP.chatCommandAlias("looc","l")
DarkRP.chatCommandAlias("looc","///")

if SERVER then
--[[
local function ResetDuty(victim)
victim:ConCommand("cake_duty 0")
end
--]]

--hook.Add("teamChanged","blahblahafaf",ResetDuty)
hook.Add("PlayerDeath","tesaft",ResetDuty)
end