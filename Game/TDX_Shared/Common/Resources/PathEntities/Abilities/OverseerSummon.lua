local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Summon",
	StartingCooldown = 10,
	Cooldown = 150,
	Animated = true,
	Delay = 3,
	ExecutionTime = 7.033,
	AnimationName = "Summon",
	EffectParentInstanceNames = { "Summon" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Summon" },
	SpawnPathEntities = {
		{
			PathEntityType = Enums.PathEntities.Warden,
			Count = 2,
			MaxSpawnOffsetStuds = 20,
			FavorSpawningBehindParent = true,
			StaggerMaxDelay = 1.5
		},
		{
			PathEntityType = Enums.PathEntities.Seraph,
			Count = 1,
			MaxSpawnOffsetStuds = 20,
			FavorSpawningBehindParent = true,
			StaggerMaxDelay = 1.5
		},
		{
			PathEntityType = Enums.PathEntities.Archer,
			Count = 3,
			MaxSpawnOffsetStuds = 7,
			FavorSpawningBehindParent = true,
			StaggerMaxDelay = 1.5
		}
	}
}