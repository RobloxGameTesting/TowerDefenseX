local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
local spawnEnemies = {}

for i = 1, 10 do
	local pathPercentageLowerBound = (i - 1) * 0.083 + 0.1
	table.insert(spawnEnemies, {
		EnemyType = Enums.Enemies.UmbrixClone,
		SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
		PathPercentageLowerBound = pathPercentageLowerBound,
		PathPercentageUpperBound = pathPercentageLowerBound + 0.053000000000000005,
		NoCash = true
	})
end

return {
	StartingCooldown = 22,
	Cooldown = 160,
	Animated = true,
	AnimationName = "CrystalCopy",
	AutoHandleEffects = true,
	Delay = 53 / 30,
	ExecutionTime = 4.967,
	SpawnEnemies = spawnEnemies,
	TimeManipulationData = {
		SpeedMultiplier = 0.001,
		Duration = 77 / 30
	}
}