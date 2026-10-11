local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 25,
	Animated = true,
	Delay = 0.9,
	ExecutionTime = 2.133,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "RootPart>SummonSFX" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.VoidWarden,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 6,
			StaggerMaxDelay = 0.8,
			MaxSpawnOffsetStuds = 10,
			FavorSpawningInFrontOfParent = true,
			HealthMultiplier = 2
		},
		{
			EnemyType = Enums.Enemies.VoidFloater,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 4,
			StaggerMaxDelay = 0.8,
			MaxSpawnOffsetStuds = 10,
			FavorSpawningInFrontOfParent = true
		}
	}
}