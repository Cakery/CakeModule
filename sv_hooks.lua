local function Spawn(victim)

	if DonatorCheck(victim) or victim:IsSuperAdmin() or victim:IsAdmin() then
	else
		--victim:SetPlayerColor(Vector(1,1,1))
		
			--PrintTable(team.GetColor(victim:Team()))
			for k,v in pairs(team.GetColor(victim:Team())) do
				if k=="r"
					then red=v/255
				elseif k=="b" then
					blue=v/255
				elseif k=="g" then
				green=v/255
			end
		

		end
	--print(red.." "..green.." "..blue)
	timer.Simple(0.1,function()
	--print("Setting")
	victim:SetPlayerColor(Vector(red,green,blue))
	end)
end
end

local function SetRPName(ply)
if ply:Nick()==ply:SteamName() then
ply:ConCommand("cake_rpname")
end
end

hook.Add("PlayerSpawn","afafafat",Spawn)
hook.Add("PlayerSpawn","SetRPName",SetRPName)
hook.Add("playerArrested","gotarrested",function(ply) timer.Simple(.5,function() ply:Give("weapon_arc_atmcard") ply:Give("pocket") end) end)
hook.Add("PlayerCanPickupWeapon", "arrested", function(ply,wep) if ply:isArrested() and wep:GetClass()=="weapon_arc_atmcard" or ply:isArrested() and wep:GetClass()=="pocket" then return true end end)
hook.Add("OnPlayerChangedTeam","ageragr",Spawn)
hook.Add("canDropWeapon","CPwepdrop",function(ply,wep) if ply:isCP() and JobWeaponCheck(ply,wep) then 
return false
end 
end)