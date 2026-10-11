local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	EnabledDifficulties = { Enums.Difficulties.TBPart2Voidmare },
	StartingCooldown = 8,
	Cooldown = 999,
	Animated = true,
	AnimationName = "Summon",
	Delay = 1.183,
	ExecutionTime = 2.483,
	AutoHandleEffects = true,
	PrerequisiteAbilityName = Enums.EnemyAbilities.VoidDevastatorAwakening,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.VoidApexPredator,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 1,
			StaggerMaxDelay = 0.75,
			MaxSpawnOffsetStuds = 45,
			HealthMultiplier = 0.45,
			SpeedBoostMultiplier = 1.85,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.ApexPredator,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 1,
			StaggerMaxDelay = 0.75,
			MaxSpawnOffsetStuds = 25,
			HealthMultiplier = 1.5,
			SpeedBoostMultiplier = 1.2,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.TB2CorruptedApexPredator,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 1,
			MaxSpawnOffsetStuds = 20,
			SpeedBoostMultiplier = 1.2
		},
		{
			EnemyType = Enums.Enemies.RavagedPredator,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 4,
			StaggerMaxDelay = 1.25,
			HealthMultiplier = 5,
			MaxSpawnOffsetStuds = 20
		}
	}
}