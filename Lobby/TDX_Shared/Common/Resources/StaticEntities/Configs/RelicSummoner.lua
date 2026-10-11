local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Relic Summoner",
	RaycastIgnore = true,
	NoDisplayPathLevelString = true,
	StealthMaintainColor = true,
	Radius = 1,
	HoverHeight = 0,
	AnimationTimeScale = 1,
	NoAnimations = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	NoHead = true,
	NoTorso = true,
	FadeOutOnDeath = true,
	FadeOutDelay = 0,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 2,
	SpawnPathEntitySequence = {
		{
			PathEntityType = Enums.PathEntities.Warden,
			StartDelay = 0,
			Interval = 1e999,
			BurstSize = 2,
			BurstInterval = 1.1,
			MaximumCount = 2,
			IgnoreDespawnOnParentDeath = true,
			SpawnAsSummoned = true
		},
		{
			PathEntityType = Enums.PathEntities.PhantomOverseer,
			StartDelay = 0.5,
			Interval = 1e999,
			BurstSize = 1,
			BurstInterval = 1,
			MaximumCount = 1,
			IgnoreDespawnOnParentDeath = true,
			SpawnAsSummoned = true
		},
		{
			PathEntityType = Enums.PathEntities.Seraph,
			StartDelay = 0,
			Interval = 1e999,
			BurstSize = 3,
			BurstInterval = 0.8,
			MaximumCount = 3,
			IgnoreDespawnOnParentDeath = true,
			SpawnAsSummoned = true
		}
	}
}