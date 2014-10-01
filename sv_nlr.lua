print("Cake Module Loaded: NLR")
local function Death(victim)
victim:ConCommand("cake_nlr")
end
hook.Add("PlayerDeath","test",Death)


