local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RewardMultipliers = {
	Definitions = {
		Tokens = {
			ConfigKey = "TokenMultiplier",
			Global = "TOKEN_MULTIPLIER",
			DisplayName = "Tokens",
			ChatColor = Color3.fromRGB(255, 205, 50)
		},
		XP = {
			ConfigKey = "XPMultiplier",
			Global = "XP_MULTIPLIER",
			DisplayName = "XP",
			ChatColor = Color3.fromRGB(200, 160, 255)
		},
		Gold = {
			ConfigKey = "GoldMultiplier",
			Global = "GOLD_MULTIPLIER",
			DisplayName = "Gold",
			ChatColor = Color3.fromRGB(85, 220, 85)
		},
		Crystals = {
			ConfigKey = "CrystalMultiplier",
			Global = "CRYSTAL_MULTIPLIER",
			DisplayName = "Crystals",
			ChatColor = Color3.fromRGB(80, 170, 255)
		}
	},
	Order = { "Tokens", "XP", "Gold", "Crystals" }
}

function RewardMultipliers.GetFallback(p: string)
	return _G[RewardMultipliers.Definitions[p].Global] or 1
end

function RewardMultipliers.Get(p: string)
	local attribute = ReplicatedStorage:GetAttribute(RewardMultipliers.Definitions[p].ConfigKey)

	if typeof(attribute) == "number" then
		return attribute
	end

	return RewardMultipliers.GetFallback(p)
end

function RewardMultipliers.Format(p: number)
	return string.format("%gX", p)
end

function RewardMultipliers.GetChangedSignal(p: string)
	return ReplicatedStorage:GetAttributeChangedSignal(RewardMultipliers.Definitions[p].ConfigKey)
end

return RewardMultipliers