local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		SpawnStaticEntityData = { Name = Enums.StaticEntities.IceShard, Lifetime = 120 }
	},
	Name = "Ice Shard",
	DisplayName = "Ice Shard",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 26,
	Animated = true,
	Delay = 1.83,
	ExecutionTime = 4.133,
	Icon = "rbxassetid://79502021171347",
	Description = "Spawn ice shard.",
	AnimationName = "Drill",
	ProjectileName = Enums.Projectiles.IceBreakerIceShardProjectile,
	FaceTargetPosition = true,
	IsManualAimAtPath = true,
	ManualAimCustomRange = 25,
	EffectParentInstanceNames = { "DigVFX" }
}