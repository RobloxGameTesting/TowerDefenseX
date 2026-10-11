local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 1,
	ExecutionTime = 3.0330000000000004,
	AnimationName = "Rage",
	EffectParentInstanceNames = { "InnerFace", "RageModeSmoke" },
	EffectsStartDelay = 0,
	EffectsStopDelay = 3,
	PlayEffectsUntilDeath = true,
	TriggeredAtHealthPercentage = 0.4,
	MaximumUses = 1,
	EnemyToTowerRangedDataSequence = {
		{
			CanTargetAir = true,
			TowerBuffNames = { Enums.TowerBuffs.ElderWendigoRageStun },
			Range = 1000,
			HitAllTargetsInRange = true
		}
	},
	HealData = { HealAmount = 25000 },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.SnowWendigo,
			Count = 2,
			StaggerMaxDelay = 0.3,
			MaxSpawnOffsetStuds = 11,
			FavorSpawningBehindParent = true
		}
	}
}