local BattlePass = require(game.ReplicatedStorage.TDX_Shared.Modules.BattlePass)
require(game.ReplicatedStorage.TDX_Shared.Modules.DataTemplate)
return {
	Name = "getpassprogress",
	Aliases = {},
	Description = "",
	Group = "Programmer",
	Args = {
		{ Type = "battlepass", Name = "battlepass" }
	},
	ClientRun = function(_, p: string)
		local Data = require(game.ReplicatedStorage.TDX_Shared.Client.Services.Data)
		local passes = Data.Get("Passes")

		if not passes.Progress[p] then
			return `No progress for pass {p}`
		end

		local v = passes.Progress[p]
		local passProgress, v2, v3 = BattlePass.GetPassProgress(p, v.Tokens)
		local v4 = `Tier: {passProgress}, TokensTowardsNextTier: {v2}, TokensRequiredForNextTier: {v3}\n` .. `Tokens: {v.Tokens}, Unlocked: {tostring(v.Unlocked)}`
		print(`PROGRESS FOR PASS {p} >`, v)
		return v4
	end
}