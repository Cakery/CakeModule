--Very Simple function library

--Does what it says, make giveback true and it will give weapons instead of taking
function StripJobWeapons(ply,giveback) 

local JobTable=ply:getJobTable()

if giveback==false then
		for k,v in pairs(JobTable.weapons) do
			ply:StripWeapon(v)
		end
else
	for k,v in pairs(JobTable.weapons) do
		ply:Give(v)
	end
end

end

--A simple function to see if someone is a donator
function DonatorCheck(ply)
local found=false
--Add ranks here that should be considered donators
Ranks={
"donator",
"pdonator",
"sdonator",
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

--See if a weapon is given by the job
function JobWeaponCheck(ply,wep)
local Found

local JobTable=ply:getJobTable()
for k,v in pairs(JobTable.weapons) do
	if wep:GetClass()==v then
		Found=true
	end
	end

return Found
end
