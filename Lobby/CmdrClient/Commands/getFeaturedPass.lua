local BattlePass = require(game.ReplicatedStorage.TDX_Shared.Modules.BattlePass)
return {
	Name = "getfeaturedpass",
	Aliases = {},
	Description = "Returns the current featured battlepass",
	Group = "Programmer",
	Args = {},
	ClientRun = function()
		return (tostring(BattlePass.GetCurrentPass()))
	end
}