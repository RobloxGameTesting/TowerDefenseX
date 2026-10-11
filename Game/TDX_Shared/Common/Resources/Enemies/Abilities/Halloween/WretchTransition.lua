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
	ExecutionTime = 6.5169999999999995,
	AnimationName = "Transition",
	EffectParentInstanceNames = { "Torso>TransitionVFX", "Hip>TransitionVFX" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 4.3,
	TriggeredAtHealthPercentage = 0.5,
	MaximumUses = 1,
	NextAbilityName = Enums.EnemyAbilities.WretchStage2Burrow,
	MovementSpeedIncrease = 0,
	SetInvulnerableForTime = 10.333,
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.WretchStage1Jump,
		Enums.EnemyAbilities.WretchStage1JumpDamage,
		Enums.EnemyAbilities.WretchStage1Summon,
		Enums.EnemyAbilities.WretchStage1Summon_Nightmare,
		Enums.EnemyAbilities.WretchStage1AirRockets,
		Enums.EnemyAbilities.WretchStage1Railgun,
		Enums.EnemyAbilities.WretchStage1PalmGuns,
		Enums.EnemyAbilities.WretchStage1PalmGunsForBase
	}
}