local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	DoNotTryToUse = true,
	StartingCooldown = 1e999,
	Cooldown = 1e999,
	Animated = true,
	Delay = 0,
	ExecutionTime = 3.2,
	AnimationName = "Phase 2 Transition",
	SetInvulnerableForTime = 3.2,
	ReplaceAnimationMap = { Move = "Phase 2 Idle" },
	DisableAbilityListIfUsed = {
		Enums.EnemyAbilities.BunnyTank900LaserBeam,
		Enums.EnemyAbilities.BunnyTank900ArmRockets
	},
	DisableAbilityListWhileActive = { Enums.EnemyAbilities.BunnyTank900PassiveRockets },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Transition" }
}