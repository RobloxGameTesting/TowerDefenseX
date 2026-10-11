local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	StartingCooldownVariance = 2,
	Cooldown = 5,
	CooldownVariance = 2,
	Animated = true,
	Delay = 0.1,
	ExecutionTime = 1.3,
	ContinueMovingWhileUsing = true,
	AnimationName = "Noscope",
	ParallelAbilityNames = { Enums.EnemyAbilities.NoscoperNoscope_Shot },
	EffectParentInstanceNames = { "Weapon" },
	MovementSpeedData = {
		StartTime = 0.1,
		TimingData = {
			{ Time = 0.1, MovementSpeed = 0 },
			{ Time = 0.7, ResetToDefault = true }
		}
	},
	EnemyTeleportData = {
		DistanceJumpData = { Studs = 8, MinimumPathStudsLeft = 10 },
		RemoveForceFaceOnStop = true,
		TweenToGoal = true,
		TweenTime = 0.6,
		TweenStartDelay = 0.1
	},
	SetInvulnerableForTime = 0.6
}