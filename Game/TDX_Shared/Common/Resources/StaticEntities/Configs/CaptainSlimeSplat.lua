local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Captain Slime Splat",
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
	SpawnEnemySequence = {
		{
			StartingDelay = 0,
			Interval = 1,
			Count = 1,
			SpawnEnemyData = {
				{
					EnemyType = Enums.Enemies.SlimeBloat,
					Count = 2,
					SpawnDelay = 0,
					StaggerMaxDelay = 2,
					EvenStagger = true,
					MaxSpawnOffsetStuds = 0.5,
					TransferStealth = true,
					NoCash = true
				},
				{
					EnemyType = Enums.Enemies.SlimeSoldier,
					Count = 20,
					SpawnDelay = 0.5,
					StaggerMaxDelay = 2,
					EvenStagger = true,
					MaxSpawnOffsetStuds = 0.5,
					TransferStealth = true,
					NoCash = true
				}
			}
		}
	}
}