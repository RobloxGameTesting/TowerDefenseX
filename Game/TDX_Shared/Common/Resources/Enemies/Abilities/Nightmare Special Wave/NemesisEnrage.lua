local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 60,
	Animated = true,
	AnimationName = "Enrage",
	Delay = 0,
	ExecutionTime = 7.8,
	EffectParentInstanceNames = { "FX>Enrage>Immediate" },
	MovementSpeedIncrease = 1.1,
	MaximumUses = 1,
	SetInvulnerableForTime = 8,
	TriggeredAtHealthPercentage = 0.6,
	HealData = { HealAmount = 900000 },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.NightmareCalamity2,
			Count = 25,
			SpawnDelay = 14 / 3,
			StaggerMaxDelay = 3,
			MaxSpawnOffsetStuds = 100,
			FavorSpawningInFrontOfParent = false
		},
		{
			EnemyType = Enums.Enemies.HellStar,
			Count = 20,
			SpawnDelay = 14 / 3,
			StaggerMaxDelay = 3,
			MaxSpawnOffsetStuds = 50,
			FavorSpawningInFrontOfParent = false
		}
	}
}