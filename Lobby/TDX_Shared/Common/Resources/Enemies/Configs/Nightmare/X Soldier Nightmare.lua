local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideCharacterModelName = Enums.Enemies.XSoldier,
	OverrideDisplayName = Enums.Enemies.XSoldier,
	Health = 225,
	Speed = 2.8,
	BodyHeat = 75,
	BodyHeatRegenerationRate = 5,
	Radius = 1,
	FadeOutOnDeath = true,
	RotationOffset = CFrame.Angles(0, 3.141592653589793, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false,
	AbilityNames = { Enums.EnemyAbilities.XSoldierGunNightmare, Enums.EnemyAbilities.XSoldierGunNightmareAA },
	AbilityBufferTime = 2,
	DamageReductionTable = {
		{ DamageType = Enums.DamageTypes.Bullet, DamageReduction = 0.15 },
		{ DamageType = Enums.DamageTypes.Explosive, DamageReduction = 0.25 }
	}
}