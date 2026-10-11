local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 50,
	Animated = true,
	Delay = 257 / 60,
	ExecutionTime = 5.8,
	EffectsStartDelay = 7 / 3,
	EffectsStopDelay = 5.25,
	AutoHandleEffects = true,
	AnimationName = "StaffSummon",
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.TB2Boss2,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 4,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 8,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.TB2Boss1,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 15,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 18,
			NoCash = true
		}
	}
}