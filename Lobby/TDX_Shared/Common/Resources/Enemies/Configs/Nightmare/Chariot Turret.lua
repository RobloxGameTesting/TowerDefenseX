local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 250,
	Shield = 500,
	Speed = 0,
	BodyHeat = 1000,
	BodyHeatRegenerationRate = 100,
	Radius = 1,
	NoAnimations = true,
	NoHead = true,
	NoTorso = true,
	AbilityNames = { Enums.EnemyAbilities.ChariotTurretGun },
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ChariotTurretDeathExplosion,
	FakeEnemy = false,
	TurretConfigs = {
		{
			ModelName = "Turret",
			RotationConstraintConfig = { CanRotateY = true },
			TurretGunConfigs = {
				{ ModelName = "Gun", RotationConstraintConfig = {} }
			}
		}
	},
	DamageReductionTable = {}
}