local function Spawn(victim)

	if DonatorCheck(victim) or victim:IsAdmin() then
	else
		local Colour=team.GetColor(victim:Team())
		red=Colour.r/255
		blue=Colour.b/255
		green=Colour.g/255
		timer.Simple(0.1,function()
			victim:SetPlayerColor(Vector(red,green,blue))
			victim:SetWeaponColor(Vector(red,green,blue))
		end)
	end

	
	if victim:Nick()==victim:SteamName() then
		victim:ConCommand("cake_rpname")
	end
	
end



//hook.Add("PlayerSpawn","afafafat",Spawn)
//hook.Add("OnPlayerChangedTeam","ageragr",Spawn)

hook.Add("playerArrested","gotarrested",function(ply)
 timer.Simple(.5,function() 
 ply:Give("weapon_arc_atmcard") 
 ply:Give("pocket") 
 end) 
 end)
 
hook.Add("PlayerCanPickupWeapon", "arrested", function(ply,wep) 
if ply:isArrested() and wep:GetClass()=="weapon_arc_atmcard" or ply:isArrested() and wep:GetClass()=="pocket" then 
return true 
end 
end)

/*
hook.Add("canDropWeapon","CPwepdrop",function(ply,wep) if ply:isCP() and JobWeaponCheck(ply,wep) then 
DarkRP.notify(ply, 1, 3, "You can not drop this while you have your current job!");
return false
end 
end)*/