local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	EnabledDifficulties = { Enums.Difficulties.TBPart2Casual },
	StartingCooldown = 12,
	Cooldown = 120,
	Animated = true,
	AnimationName = "Summon",
	Delay = 1.183,
	ExecutionTime = 2.483,
	AutoHandleEffects = true,
	PrerequisiteAbilityName = Enums.EnemyAbilities.VoidDevastatorAwakening,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.VoidGolem,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 5,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 15,
			FavorSpawningBehindParent = true,
			NoCash = true
		}
	}
}