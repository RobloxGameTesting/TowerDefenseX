local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 70,
	Animated = true,
	Delay = 1.15,
	ExecutionTime = 2.133,
	AnimationName = "Summon",
	SecondaryAnimationForKeyframeEventsName = "Damaged_Summon",
	EffectParentInstanceNames = { "Root>SummonSFX" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.SnowGangsta,
			Count = 1,
			MaxSpawnOffsetStuds = 5,
			FavorSpawningBehindParent = true
		},
		{
			EnemyType = Enums.Enemies.IceCapwn,
			Count = 4,
			StaggerMaxDelay = 0.5,
			MaxSpawnOffsetStuds = 17,
			FavorSpawningBehindParent = true
		}
	}
}