local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("DamageTypes"))
local Enums = require(common:WaitForChild("Enums"))
local damageData = {
	IgnoreResistance = false,
	StunData = {
		StunType = Enums.StunTypes.GoldenMineStun,
		StunDuration = 1,
		CanStunBoss = true,
		IgnoreStunResistance = true
	}
}
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 4,
		DamageType = Enums.DamageTypes.Explosive,
		Damage = 1250,
		DamageData = damageData,
		PrimaryTargetExtraDamage = 4000,
		PrimaryTargetExtraDamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
		BurnEffectStats = {
			Name = Enums.BurnEffects.RedThermite,
			DisplayName = "Burn",
			DamageType = Enums.DamageTypes.Fire,
			DamagePerSecond = 100,
			Radius = 4,
			Duration = 0.3,
			StickDuration = 10
		}
	},
	Name = "Hand Throw",
	DisplayName = "Charged Throw",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 20,
	Animated = true,
	Delay = 0.883,
	ExecutionTime = 5.5,
	CustomQueryData = {
		Range = 200,
		MinimumRange = 10,
		StealthDetection = true,
		QueryType = "Strongest",
		CanTargetAir = true
	},
	Icon = "rbxassetid://85827690511495",
	FullSizeIcon = true,
	Description = "Throw mine at highest HP enemy",
	AnimationName = "HandThrow",
	ProjectileName = Enums.Projectiles.GoldenMineHandThrow,
	EffectParentInstanceNames = { "MineAbilityVFX", "HandThrowChargeVFX" }
}