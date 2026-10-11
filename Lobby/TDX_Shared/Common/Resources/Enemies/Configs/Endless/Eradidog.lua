local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 100000,
	Shield = 75000,
	Speed = 10,
	AnimationCalibratedSpeed = 10,
	BodyHeat = 18000,
	BodyHeatRegenerationRate = 750,
	Radius = 1,
	HoverHeight = 2.239,
	AnimationTimeScale = 1,
	AbilityNames = {
		Enums.EnemyAbilities.EradidogBark,
		Enums.EnemyAbilities.EradidogMissiles,
		Enums.EnemyAbilities.EradidogRailgun
	},
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(1.5707963267948966, 0, -1.5707963267948966),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutDelay = 1,
	FadeOutCustomTime = 1,
	FadeOutRemoveDelay = 1,
	TurretConfigs = {
		{
			ModelName = "Turret",
			RotationConstraintConfig = { CanRotateY = true },
			TurretGunConfigs = {
				{
					ModelName = "Gun",
					RotationConstraintConfig = {
						CanRotateX = true,
						MaxRotationX = 20,
						MinRotationX = -8
					}
				}
			}
		}
	}
}