local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Goo Gunner Splat",
	OverrideCharacterModelName = "GooGunnerSplat",
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
			PathEntityType = Enums.PathEntities.Goo1,
			StartDelay = 2,
			Interval = 13,
			BurstSize = 2,
			BurstInterval = 1,
			MaximumCount = 8
		},
		{
			PathEntityType = Enums.PathEntities.Goo2,
			StartDelay = 4,
			Interval = 14,
			BurstSize = 1,
			BurstInterval = 1,
			MaximumCount = 3
		}
	}
}