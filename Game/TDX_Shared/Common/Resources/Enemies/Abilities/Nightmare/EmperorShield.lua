local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 25,
	Cooldown = 90,
	Animated = true,
	Delay = 4.25,
	ExecutionTime = 9.267,
	AnimationName = "Shield",
	ParallelAbilityNames = { Enums.EnemyAbilities.EmperorShield_StaffSlam },
	EffectParentInstanceNames = { "Shield" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Shield" },
	HealData = { ShieldGain = 1000000, ShieldCap = 3000000 }
}