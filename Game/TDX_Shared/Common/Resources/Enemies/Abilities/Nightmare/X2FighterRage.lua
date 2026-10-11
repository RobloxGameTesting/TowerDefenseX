local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 0,
	ExecutionTime = 25.683,
	AnimationName = "Rage",
	ParallelAbilityNames = {
		Enums.EnemyAbilities.X2FighterRage_Invulnerable,
		Enums.EnemyAbilities.X2FighterRage_Strafe1,
		Enums.EnemyAbilities.X2FighterRage_Strafe2,
		Enums.EnemyAbilities.X2FighterRage_Land
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Rage" },
	EffectParentInstanceNames = { "RootPart>SFX>RageKeyframeSFX", "Rage" },
	TriggeredAtHealthPercentage = 0.35,
	MaximumUses = 1,
	GainDamageReductionData = { Amount = 0.9, Time = 15 },
	DisableAbilityListIfUsed = {}
}