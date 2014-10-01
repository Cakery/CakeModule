--Made by Cake, DecentGaming.org
print("Cake module Loaded: SH_Commands")

if CLIENT then
CreateClientConVar("cake_duty",0,false,true)
end

--A simple roll command, prints message to entire server
local function roll(ply,max)
if tonumber(max)==nil then return end 
if max!="" then


	local random=math.random(0,max)
	print(ply:Nick().." rolled "..random)
	for j,k in pairs(player.GetAll()) do
-- if SERVER then
-- DarkRP.talkToRange(ply,ply:Nick(),"Rolled "..random,100)
-- end
k:PrintMessage( HUD_PRINTTALK,ply:Nick().." rolled: " .. random.." out of "..max)
return ""
end
end
end


--Simple command to switch peoples playermodels, idea is to have off duty cops
local function duty(ply)
--Set what teams are allowed to use the command here, while the command does work with everyteam some act weird with it; but most should be fine
local allowedTeams={
"Thief",
"Police Officer",
"Specialist Response Group",
"Police Chief",
"Mafia Member",
"The Don",
"Triad Member"
--"Security Guard"
}

local allowed=false

--Check if the person is in a team that is allowed to switch
 for k,v in ipairs(allowedTeams) do
 if team.GetName(ply:Team())==v then
 allowed=true
 break
 end
 end
--If not send them a error and stop all other code from running
if allowed!=true then DarkRP.notify(ply,1,3,"You are unable to access this command as your current job!") return end
if SERVER then
DarkRP.log(ply:Nick().." just switched models (DUTY)!",Color(255,255,51,255))
end
--Here we check if they are already switched and if they are we need to invert the state
if ply:GetInfoNum("cake_duty",0)==1 then
ply:ConCommand("cake_duty 0")
--DarkRP.notify(ply,2,3,"You are currently ON duty")
else ply:ConCommand("cake_duty 1")
--DarkRP.notify(ply,2,3,"You are currently OFF duty")
end

--This function here grabs the model chosen for a job, but it only returns somthing if the job has more than one model
JobModel=ply:getPreferredModel(ply:Team())
--Here we do job specific switches EG theif must switch to a specific model instead of the default civ
if team.GetName(ply:Team())=="Thief" then
	ply:SetModel("models/player/phoenix.mdl")
elseif team.GetName(ply:Team())=="Mafia Member" then
	ply:SetModel("models/player/suits/robber_tuckedtie.mdl") 
	ply:SetBodygroup(1,0)
	ply:SetBodygroup(2,0)
	ply:SetBodygroup(3,2)  
	ply:SetSkin(0)
elseif team.GetName(ply:Team())=="The Don" then
	ply:SetModel("models/player/suits/robber_open.mdl")
	ply:SetBodygroup(2,1)
	ply:SetBodygroup(1,1)
elseif team.GetName(ply:Team())=="Triad Member" then
ply:SetModel("models/player/rebels/rebel_arctic.mdl")
else
--If no specific model set them to this
ply:SetModel(ply:getPreferredModel(1))
end
--Similair to above except we switch them back to their default model
if JobModel!=ply:GetModel() and ply:GetInfoNum("cake_duty",0)==1 and JobModel!=nil then
ply:SetModel(JobModel)
--Here we check if jobmodel even had a value
elseif JobModel==nil and ply:GetInfoNum("cake_duty",0)==0 then
--If it has no value we need to give it one, by searching through the jobs table defined in jobs.lua
for k,v in pairs(ply:getJobTable( )) do
if k=="model" then
JobModel=v
--print(k..v)
--This check is needed in case the person has not set a preffered model, so jobmodel will get set to the value of the table, here we check if did and overide it to the first value in the table
if type(JobModel)=="table" then
	JobModel=v[1]
end
break
 end
end
--PrintTable(ply:getJobTable( ))
ply:SetModel(JobModel)

end




--Here we strip weapons if the player is a cop and goes off duty
if ply:isCP() and ply:GetInfoNum("cake_duty",0)==0 then
	if SERVER then
		StripJobWeapons(ply)
	end
end

--Here we give them back if they go back on duty
if SERVER then
		if ply:isCP() and ply:GetInfoNum("cake_duty",0)==1 then
			StripJobWeapons(ply,true)
		end
	end
end

if SERVER then
	DarkRP.defineChatCommand( "roll",roll )
	DarkRP.defineChatCommand( "switch",duty )
end

DarkRP.declareChatCommand({command="roll",description="Make a Dice roll",delay=2})
DarkRP.declareChatCommand({command="switch",description="Go off/On Duty",delay=2})

if SERVER then
local function ResetDuty(victim)
victim:ConCommand("cake_duty 0")
end


--hook.Add("teamChanged","blahblahafaf",ResetDuty)
hook.Add("PlayerDeath","tesaft",ResetDuty)
end