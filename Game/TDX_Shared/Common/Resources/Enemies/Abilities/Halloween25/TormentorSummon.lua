local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 30,
	Animated = true,
	Delay = 3,
	ExecutionTime = 4,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "SummonEffectPart" },
	SpawnEnemies = {
		{ EnemyType = Enums.Enemies.TormentedSoul, Count = 15, MaxSpawnOffsetStuds = 12 }
	}
}