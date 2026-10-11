local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "???",
	DisplayName = "???",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 5,
	CanRunInParallel = true,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://137681259278610",
	Description = "???",
	HasRadiusEffect = true,
	EffectRadius = 3,
	RadiusEffectIgnoreAir = true,
	RandomEffects = {
		{ Type = "Unstun" },
		{ Type = "Heal", Percentage = 0.2, BuffName = Enums.TowerBuffs.ShotgunnerHeal_VisualOnly },
		{ BuffName = Enums.TowerBuffs.TrollfaceDamageBuff }
	},
	DisplayStatAdditions = {
		{
			Text = `RANDOM EFFECT (RADIUS: {3})`,
			ImageId = "rbxassetid://12191388343",
			ImageScale = 1
		}
	},
	HotbarData = { GroupName = "???", Level = 1 }
}