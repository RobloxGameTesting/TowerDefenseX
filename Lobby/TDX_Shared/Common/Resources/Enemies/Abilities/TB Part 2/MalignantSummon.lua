local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 1,
	Cooldown = 45,
	Animated = true,
	AnimationName = "Summon",
	AutoHandleEffects = true,
	Delay = 1 / 3,
	ExecutionTime = 2.9,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Clot,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 12,
			MaxSpawnOffsetStuds = 17,
			FavorSpawningInFrontOfParent = true
		},
		{
			EnemyType = Enums.Enemies.MysteryV,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 3,
			MaxSpawnOffsetStuds = 7,
			FavorSpawningInFrontOfParent = true
		}
	}
}