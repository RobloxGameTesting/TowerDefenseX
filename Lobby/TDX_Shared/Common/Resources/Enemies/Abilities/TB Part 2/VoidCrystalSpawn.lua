local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 45,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	InstantPlayEffectParentInstanceNames = { "Root>SFX>Summon" },
	SpawnEnemies = {
		{
			EnemyType = Enums.Enemies.Neuron,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 12,
			StaggerMaxDelay = 3,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.VoidSlime,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 12,
			StaggerMaxDelay = 5,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 1,
			TransferStealth = true,
			NoCash = true
		},
		{
			EnemyType = Enums.Enemies.SludgeBoss,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 4,
			SpawnDelay = 0.5,
			StaggerMaxDelay = 3,
			EvenStagger = true,
			MaxSpawnOffsetStuds = 1,
			TransferStealth = true,
			NoCash = true
		}
	}
}