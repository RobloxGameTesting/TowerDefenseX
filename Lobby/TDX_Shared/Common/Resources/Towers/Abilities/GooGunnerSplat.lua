local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		SpawnStaticEntityData = { Name = Enums.StaticEntities.GooGunnerSplat, Lifetime = 45 }
	},
	Name = "Spawn Puddle",
	DisplayName = "Spawn Puddle",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 60,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://128253568889096",
	Description = "Spawn puddle.",
	ProjectileName = Enums.Projectiles.GooGunnerSplatProjectile,
	FaceTargetPosition = false,
	IsManualAimAtPath = true,
	ManualAimCustomRange = 25
}