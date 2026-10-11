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
	ExecutionTime = 0.95,
	AnimationName = "LoseLegs",
	EffectParentInstanceNames = { "LoseLegs" },
	InstantPlayEffectParentInstanceNames = { "Root>SFX>LoseLegs" },
	TriggeredAtHealthPercentage = 0.2,
	MaximumUses = 1,
	MovementSpeedIncrease = 3,
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.NightmareSlimeKingScream,
		Enums.EnemyAbilities.NightmareSlimeKingGroundSlamAndSummon,
		Enums.EnemyAbilities.NightmareSlimeKingPhase2Jump,
		Enums.EnemyAbilities.NightmareSlimeKingPhase2Jump_Land
	},
	ReplaceAnimationMap = { Move = "MoveDamaged" }
}