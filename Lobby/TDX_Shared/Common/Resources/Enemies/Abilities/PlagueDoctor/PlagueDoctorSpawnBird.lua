local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false, BuffName = Enums.TowerBuffs.BirdStunDebuff },
	StartingCooldown = 10,
	Cooldown = 12,
	Animated = false,
	CanRunInParallel = true,
	Delay = 0,
	ExecutionTime = 0,
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.PlagueDoctorBird,
			Range = 15,
			TargetMostExpensiveTower = true
		}
	}
}