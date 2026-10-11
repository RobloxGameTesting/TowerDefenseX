local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "Jump",
	DisplayName = "Jump LVL 1",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 12,
	Animated = true,
	AnimationName = "RelocateStart",
	AdditionalAnimationsForKeyframeEventsNames = { "RelocateLoop", "RelocateEnd" },
	Delay = 0,
	ExecutionTime = 3,
	IsManualRelocation = true,
	ManualAimCustomRange = 100,
	CooldownPausedWhileActive = true,
	BlockUpgradesWhileActive = true,
	TowerAbilityJumpData = {
		TakeoffDuration = 1.2830000000000001,
		LandingDuration = 0.767,
		EndingDuration = 1.75,
		TakeoffAnimationName = "RelocateStart",
		FlyingAnimationName = "RelocateLoop",
		LandingAnimationName = "RelocateEnd",
		Altitude = NumberRange.new(10, 12),
		MoveSpeed = 35,
		AccelerationTime = 0.7,
		LandingDamageData = {
			SplashRadius = 7,
			Damage = 1000,
			DamageType = Enums.DamageTypes.ExplosiveIgnoreResistance,
			StunDuration = 1,
			StunType = Enums.StunTypes.PsychoSlayerSlamStun
		}
	},
	Icon = "rbxassetid://84001356720165",
	Description = "Relocate to new location.",
	EffectParentInstanceNames = { "Landing", "Relocate" }
}