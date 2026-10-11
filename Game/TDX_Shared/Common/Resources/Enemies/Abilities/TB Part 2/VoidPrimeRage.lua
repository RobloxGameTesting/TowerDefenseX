local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1e999,
	MaximumUses = 1,
	TriggeredAtHealthPercentage = 0.7,
	Animated = true,
	Delay = 0,
	ExecutionTime = 4.683,
	AnimationName = "Rage",
	SetInvulnerableForTime = 4.983,
	ReplaceAnimationMap = { Move = "MoveRage" },
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.VoidPrimeBoomerang,
		Enums.EnemyAbilities.VoidPrimeClawCalling,
		Enums.EnemyAbilities.VoidPrimeStomp,
		Enums.EnemyAbilities.VoidPrimeSwordSlam
	},
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.TBVoid,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 1,
			MinimumSpawnOffsetStuds = -75,
			MaxSpawnOffsetStuds = -75
		}
	},
	InstantPlayEffectParentInstanceNames = { "RageSFX" },
	EffectParentInstanceNames = { "RageBladeVFX1", "RageBladeVFX2", "RageTeleportVFX" },
	EffectsStartDelay = 8 / 3,
	PlayEffectsUntilDeath = true
}