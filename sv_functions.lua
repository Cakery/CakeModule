--Very Simple function library

--Does what it says, make giveback true and it will give weapons instead of taking
function StripJobWeapons(ply,giveback) 
for k,v in pairs(ply:getJobTable( )) do
		if k=="weapons" then
		--PrintTable(v)
			for i,j in pairs(v) do
				ply:StripWeapon(j)
				end
		break
		
	
end

end
if giveback==true then
for k,v in pairs(ply:getJobTable( )) do
		if k=="weapons" then
		--PrintTable(v)
			for i,j in pairs(v) do
				ply:Give(j)
				end
		break
		
	
end

end
end
end

--A simple function to see if someone is a donator
function DonatorCheck(ply)
local found=false
--Add ranks here that should be considered donators
Ranks={
"donator",
"udonator",
"rdonator"
}
--Actual logic happens here
for k,v in pairs(Ranks) do
	if ply:GetUserGroup()==v then
		found=true
		--return found
		break
	end

end
return found
end


function JobWeaponCheck(ply,wep)
local Found
for k,v in pairs(ply:getJobTable( )) do
		if k=="weapons" then
		--PrintTable(v)
			for i,j in pairs(v) do
				--ply:StripWeapon(j)
				if wep:GetClass()==j then
					Found=true
					break
				end
			end
		break
end
end
return Found
end
