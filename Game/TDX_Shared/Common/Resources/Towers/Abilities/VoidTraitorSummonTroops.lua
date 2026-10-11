local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "VoidTraitorSummonTroops",
	DisplayName = "Summon Troops",
	Passive = false,
	StartingCooldown = 30,
	Cooldown = 180,
	Animated = true,
	Delay = 2.5,
	ExecutionTime = 71 / 15,
	AnimationName = "SummonTroops",
	EffectParentInstanceNames = { "RootPart>SummonTroopsSFX" },
	Icon = "rbxassetid://129257289011903",
	FullSizeIcon = true,
	Description = "Summon void troops onto the path.",
	SpawnPathEntityData = {
		{
			PathEntityType = Enums.PathEntities.VoidEmpressPathEntity,
			Summoned = true,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectLarge,
			Count = 1,
			SpawnDelay = 2.5,
			PathPercentageLowerBound = 0.01,
			PathPercentageUpperBound = 0.05
		},
		{
			PathEntityType = Enums.PathEntities.NeuronPathEntity,
			Summoned = true,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 25,
			SpawnDelay = 0,
			StaggerMaxDelay = 1.25,
			EvenStagger = true,
			PathPercentageLowerBound = 0.1,
			PathPercentageUpperBound = 0.8,
			PathPercentageEvenStagger = true
		},
		{
			PathEntityType = Enums.PathEntities.VoidTankPathEntity,
			Summoned = true,
			SummonedVFXName = Enums.VisualEffects.VoidSummonEffectSmall,
			Count = 2,
			SpawnDelay = 3,
			StaggerMaxDelay = 0.75,
			EvenStagger = true,
			PathPercentageLowerBound = 0.15,
			PathPercentageUpperBound = 0.5,
			PathPercentageEvenStagger = true
		}
	}
}