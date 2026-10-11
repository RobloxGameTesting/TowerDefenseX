local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 35,
	Animated = true,
	AnimationName = "Radio",
	Delay = 2,
	AbilityBufferTime = 3,
	ExecutionTime = 83 / 30,
	ContinueMovingWhileUsing = true,
	EffectParentInstanceNames = {},
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.RailtrooperBot,
			Count = 3,
			StaggerMaxDelay = 0.75,
			MaxSpawnOffsetStuds = 9,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.JuggernautBot,
			Count = 5,
			StaggerMaxDelay = 0.75,
			MaxSpawnOffsetStuds = 9,
			FavorSpawningBehindParent = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.ScoutBot,
			Count = 6,
			StaggerMaxDelay = 0.75,
			MaxSpawnOffsetStuds = 13,
			FavorSpawningBehindParent = true,
			NoCash = true
		}
	}
}