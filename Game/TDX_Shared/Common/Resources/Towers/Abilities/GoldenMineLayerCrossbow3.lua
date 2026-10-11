local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("DamageTypes"))
local Enums = require(common:WaitForChild("Enums"))
local spawnStaticEntityData = {
	Name = Enums.StaticEntities.GoldenMine,
	CustomPathLevelStringDisplayText = "Crossbow LVL 3",
	Lifetime = 90,
	StealthDetection = true,
	DamageStatsTransferredToStaticEntity = true
}
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 5.5,
		DamageType = Enums.DamageTypes.Explosive,
		Damage = 2000,
		SpawnStaticEntityData = spawnStaticEntityData
	},
	Name = "Crossbow",
	DisplayName = "Crossbow LVL 3",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 16,
	Animated = true,
	Delay = 0.2,
	ExecutionTime = 5.5,
	IsManualAimAtPath = true,
	ManualAimCustomRange = 75,
	Icon = "rbxassetid://99462538635818",
	FullSizeIcon = true,
	Description = "Shoot mine at specified location",
	AnimationName = "Crossbow",
	ProjectileName = Enums.Projectiles.GoldenMineCrossbow3,
	EffectParentInstanceNames = { "CrossbowVFX" },
	HotbarData = { Level = 3 }
}