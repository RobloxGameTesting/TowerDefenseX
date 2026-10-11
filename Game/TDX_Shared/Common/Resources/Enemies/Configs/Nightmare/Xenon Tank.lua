local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("TurretTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 50000,
	Shield = 125000,
	Speed = 2.4,
	BodyHeat = 35000,
	BodyHeatRegenerationRate = 200,
	Radius = 1,
	NoHead = true,
	NoTorso = true,
	OverrideDisplayName = "X-Tank",
	AbilityNames = { Enums.EnemyAbilities.XTankDirectShot, Enums.EnemyAbilities.XTankArcShot },
	AbilityBufferTime = 3,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.M1AbramsDeath,
	DeathRemoveTextures = true,
	DeathColor = Color3.fromRGB(0, 0, 0),
	DeathMaterial = Enum.Material.CorrodedMetal,
	FadeOutOnDeath = true,
	FadeOutDelay = 1.5,
	FadeOutCustomTime = 0.5,
	FadeOutRemoveDelay = 2,
	FakeEnemy = false,
	TurretConfigs = {
		{
			ModelName = "TurretModel",
			RotationConstraintConfig = { CanRotateY = true },
			TurretGunConfigs = {}
		}
	},
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.65 },
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.5 }
	}
}