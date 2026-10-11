local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 45,
	StartingCooldownVariance = 10,
	Cooldown = 777,
	Animated = true,
	AnimationName = "Summon",
	AutoHandleEffects = true,
	ContinueMovingWhileUsing = true,
	Delay = 17 / 12,
	ExecutionTime = 1.45,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Pustle,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 4,
			MaxSpawnOffsetStuds = 8
		},
		{
			EnemyType = Enums.Enemies.Tumor,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 1,
			FavorSpawningInFrontOfParent = true,
			MaxSpawnOffsetStuds = 15
		}
	},
	HealData = { ShieldGain = 3000, ShieldCap = 3000 }
}