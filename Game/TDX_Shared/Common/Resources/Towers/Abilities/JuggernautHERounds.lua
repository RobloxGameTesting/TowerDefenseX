local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "JuggernautHERounds",
	DisplayName = "HE Rounds",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 38,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	TargetSelf = true,
	MainAttackOverrideData = {
		Damage = 105,
		DamageType = Enums.DamageTypes.Explosive,
		ReloadTime = 0.2,
		Range = 40,
		IsSplash = true,
		SplashRadius = 3
	},
	MainAttackOverrideDataDuration = 10,
	Icon = "rbxassetid://122133338102838",
	Description = "Switch to HE rounds.",
	EffectParentInstanceNames = { "Ability" }
}