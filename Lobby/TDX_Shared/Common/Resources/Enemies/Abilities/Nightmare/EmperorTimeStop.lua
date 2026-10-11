local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 15,
	Cooldown = 150,
	Animated = true,
	Delay = 3.9,
	ExecutionTime = 13.35,
	ContinueMovingWhileUsing = true,
	AnimationName = "TimeStop",
	ParallelAbilityNames = {
		Enums.EnemyAbilities.EmperorTimeStop_LaserBlast,
		Enums.EnemyAbilities.EmperorTimeStop_Dash,
		Enums.EnemyAbilities.EmperorTimeStop_Invulnerable
	},
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>TimeStop" },
	EffectParentInstanceNames = { "TimeStop" },
	TimeManipulationData = { SpeedMultiplier = 0.1, Duration = 10 }
}