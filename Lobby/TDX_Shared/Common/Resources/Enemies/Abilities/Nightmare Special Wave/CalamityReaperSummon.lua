local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 1,
	Cooldown = 60,
	Animated = true,
	Delay = 43 / 30,
	ExecutionTime = 2.5,
	AnimationName = "Summon",
	InstantPlayEffectParentInstanceNames = { "Root>SummonSFX" },
	EffectParentInstanceNames = { "SummonFXPart" },
	EffectsStartDelay = 8 / 15,
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Imp,
			Count = 6,
			MaxSpawnOffsetStuds = 12,
			FavorSpawningBehindParent = true,
			StaggerMaxDelay = 1
		},
		{
			EnemyType = Enums.Enemies.Penance,
			Count = 12,
			MaxSpawnOffsetStuds = 12,
			FavorSpawningBehindParent = true,
			StaggerMaxDelay = 1
		}
	}
}