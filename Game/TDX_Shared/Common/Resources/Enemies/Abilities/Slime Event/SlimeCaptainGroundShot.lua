local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
local v = {
	TargetPath = true,
	ProjectileName = Enums.Projectiles.CaptainSlimeGooBall,
	DeployStaticEntityData = { ObjectName = Enums.StaticEntities.CaptainSlimeSplat, Lifetime = 20 },
	Range = 2.5
}
return {
	ProjectileHitData = { IsSplash = false },
	StartingCooldown = 28,
	Cooldown = 65,
	Animated = true,
	Delay = 2.167,
	ExecutionTime = 5.05,
	ParallelAbilityNames = { Enums.EnemyAbilities.SlimeCaptainGroundShot_Heal },
	AnimationName = "GroundShot",
	FaceTarget = false,
	EnemyToTowerRangedDataSequence = { v },
	EffectParentInstanceNames = { "RootPart>SFX>Cannon" }
}