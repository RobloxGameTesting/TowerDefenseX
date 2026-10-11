local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 0.5,
		Damage = 4,
		DamageType = Enums.DamageTypes.Explosive
	},
	ProjectileName = Enums.Projectiles.StingerHandgunBullet,
	Name = "StingerHandgun",
	DisplayName = "Handgun (%d DPS)",
	DisplayDPSFromHitData = true,
	Passive = true,
	StartingCooldown = 0,
	Cooldown = 0.35,
	Animated = true,
	Delay = 0,
	ExecutionTime = 0.3,
	Icon = "",
	Description = "Passive handgun sidearm. Ground targets only.",
	EffectParentInstanceNames = { "StingerHandgun>Gun" },
	AnimationName = "HandgunShoot",
	SessionStartAnimationName = "HandgunShootStart",
	SessionEndAnimationName = "HandgunShootEnd",
	SessionStartTime = 17 / 30,
	SessionEndTime = 1.1,
	SessionEndGracePeriod = 0.5,
	CustomQueryData = { Range = 10, CanTargetAir = false },
	HasRadiusEffect = true,
	EffectRadius = 10,
	FaceTargetPosition = true,
	SuppressPrimaryAttackWhileInRange = true,
	CannotUseAfterAttackForSeconds = 4
}