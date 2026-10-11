local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 10,
	Cooldown = 40,
	Animated = true,
	Delay = 0.5,
	ExecutionTime = 5.367,
	ContinueMovingWhileUsing = true,
	AnimationName = "SwordSpin",
	EnemyToTowerRangedDataSequence = {
		{
			TowerBuffNames = { Enums.TowerBuffs.SlimeKingSwordSpinDebuff },
			Range = 6,
			HitAllTargetsInRange = true
		}
	},
	ContinuouslyExecuteRangedDataSequence = true,
	MovementSpeedData = {
		StartTime = 0,
		TimingData = {
			{ Time = 0, MovementSpeed = 2 },
			{ Time = 0.5, MovementSpeed = 5 },
			{ Time = 2.5, MovementSpeed = 0 }
		}
	}
}