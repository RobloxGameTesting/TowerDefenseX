local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = true,
	Delay = 0,
	ExecutionTime = 12.4,
	AnimationName = "Rage",
	ParallelAbilityNames = { Enums.EnemyAbilities.DestructorRage_FistSlam },
	EffectParentInstanceNames = { "Jetpack", "Rage" },
	TriggeredAtHealthPercentage = 0.5,
	MaximumUses = 1,
	NextAbilityName = Enums.EnemyAbilities.DestructorFocusedShock,
	SetInvulnerableForTime = 9.1,
	DisableAbilityListIfUsed = { Enums.EnemyAbilities.DestructorJetpack },
	ReplaceAnimationMap = {
		Move = "MoveDamaged",
		FocusedShock = "FocusedShockDamaged",
		AreaShock = "AreaShockDamaged",
		EMP = "EMPDamaged",
		Railgun = "RailgunDamaged",
		RailgunAntiAir = "RailgunAntiAirDamaged"
	}
}