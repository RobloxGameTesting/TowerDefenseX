local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 45,
	Animated = true,
	Delay = 0.75,
	ExecutionTime = 2,
	AnimationName = "Summon",
	InstantPlayEffectParentInstanceNames = { "Root>Ability" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.SlimeSummon,
			Count = 5,
			MaxSpawnOffsetStuds = 7,
			FavorSpawningBehindParent = true
		}
	}
}