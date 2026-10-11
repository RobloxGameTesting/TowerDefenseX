local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("DamageTypes"))
local Enums = require(common:WaitForChild("Enums"))
local spawnStaticEntityData = {
	Name = Enums.StaticEntities.GoldenMine,
	CustomPathLevelStringDisplayText = "Crossbow LVL 1",
	Lifetime = 90,
	StealthDetection = true,
	DamageStatsTransferredToStaticEntity = true
}
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 3.5,
		DamageType = Enums.DamageTypes.Explosive,
		Damage = 450,
		SpawnStaticEntityData = spawnStaticEntityData
	},
	Name = "Crossbow",
	DisplayName = "Crossbow LVL 1",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 14,
	Animated = true,
	Delay = 0.2,
	ExecutionTime = 5.5,
	IsManualAimAtPath = true,
	ManualAimCustomRange = 32,
	Icon = "rbxassetid://91734168727402",
	FullSizeIcon = true,
	Description = "Shoot mine at specified location",
	AnimationName = "Crossbow",
	ProjectileName = Enums.Projectiles.GoldenMineCrossbow1,
	EffectParentInstanceNames = { "CrossbowVFX" },
	HotbarData = { Level = 1 }
}