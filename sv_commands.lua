--Made by Cake
print("Cake module Loaded: SV_Commands")


--A simple roll command
local function roll(ply,max)
  if tonumber(max)==nil or tonumber(max)<0 then max=6 end
  if max!="" then


    local random=math.random(1,max)
    print(ply:Nick().." rolled "..random)

    if SERVER then
      DarkRP.talkToRange(ply,"[ROLL] ".. ply:Nick() .. " rolled "..random.." out of "..max, "", 250)
    end
    return ""
  end
end


--Simple command to switch peoples playermodels, idea is to have off duty cops
local function duty(ply)
  --Set what teams are allowed to use the command here, while the command does work with everyteam some act weird with it; but most should be fine
  local allowedTeams={
    "Thief",
    --Police Officer",
    --"Specialist Response Group",
    --"Police Chief",
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

--Local OOC, like OOC but functions like normal chat.
local function localooc(ply, args)
  if SERVER then
    local DoSay = function(text)
    if text == "" then
      DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
      return ""
    end
    DarkRP.talkToRange(ply, "(".. "LOOC" .. ") " .. ply:Nick(), text, 550)
  end
  return args, DoSay
end
end
--A buy health command. $1=1 hp. It will refuse to let somebody buy health if there is a medic
local function buyhealth(ply,args)
  for k,v in pairs(player.GetAll()) do
    if v:Team()==TEAM_MEDIC then  DarkRP.notify(ply,1,3,"You can not do this when there is a Medic!") return "" end
  end
  
  if ply:Health()<100 and timer.Exists(ply:EntIndex().."_health")!=true and ply:Alive() and ply:IsValid() and ply:getDarkRPVar("Energy")>5 then
    if ply:canAfford(100-ply:Health()) then
      ply:addMoney(ply:Health()-100)
      DarkRP.notify(ply,2,3,"You spent $".. 100-ply:Health() .. " on health!")
    else
      DarkRP.notify(ply,1,3,"You can not afford this!")
      return ""
    end



  timer.Create(ply:EntIndex().."_health",.5,100-ply:Health(),function() if ply:Alive() and ply:IsValid() then
    ply:SetHealth(ply:Health()+1)
  else
    timer.Destroy(ply:EntIndex().."_health")
  end
  end)

elseif timer.Exists(ply:EntIndex().."_health") then
  DarkRP.notify(ply,1,3,"You are already healing!")
elseif ply:getDarkRPVar("Energy")<5 then
  DarkRP.notify(ply,1,3,"You are too hungry to do this!")
  return ""
else
  DarkRP.notify(ply,1,3,"You already have full health!")
end
end

--Adds an old style advert command	
local function adverts(ply, args)
    local DoSay = function(text)
    if text == "" then
      DarkRP.notify(ply, 1, 4, DarkRP.getPhrase("invalid_x", "argument", ""))
      return ""
    end
   
	  for _,v in pairs(player.GetAll()) do 
--For some reason the talkToPerson function can only do 2 colours at once. So this just makes the first part of the message yellow.  
  DarkRP.talkToPerson(v,Color(255,255,0,255), "[ADVERT] ".. ply:Nick(),Color(255,255,255,255), text, ply)
    end
  end
  return args, DoSay
end



--Define commands
DarkRP.defineChatCommand( "roll",roll )
--	DarkRP.defineChatCommand( "switch",duty )
DarkRP.defineChatCommand( "looc",localooc,1.5 )
DarkRP.defineChatCommand( "buyhealth",buyhealth,1.5 )

--Since the advert command overrides the default, I have to wait a few seconds after DarkRP loads to override it without breaking anything. Hence the hook that is run from sh_commands.
hook.Add("RemovedAdvert","afaf12",function ()
DarkRP.defineChatCommand( "advert",adverts,1.5 )
end)