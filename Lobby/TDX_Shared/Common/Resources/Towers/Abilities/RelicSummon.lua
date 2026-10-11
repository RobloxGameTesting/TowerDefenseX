local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = false,
		SpawnStaticEntityData = { Name = Enums.StaticEntities.RelicSummoner, Lifetime = 5 }
	},
	Name = "Relic Summon",
	DisplayName = "Relic Summon",
	Passive = false,
	StartingCooldown = 100,
	Cooldown = 200,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://79956392583552",
	Description = "Summon Relic troops.",
	ProjectileName = Enums.Projectiles.RelicSummonProjectile,
	FaceTargetPosition = false,
	IsManualAimAtPath = true,
	ManualAimInfiniteRange = true
}