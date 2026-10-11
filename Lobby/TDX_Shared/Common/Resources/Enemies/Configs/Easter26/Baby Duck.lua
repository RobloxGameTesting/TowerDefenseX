local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 700,
	Shield = 500,
	Speed = 3,
	BodyHeat = 100,
	BodyHeatRegenerationRate = 15,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 3,
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	AbilityNames = { Enums.EnemyAbilities.BabyDuckRebirth },
	FakeEnemy = false,
	NoCash = true,
	DamageReductionTable = {},
	SecondLifeData = {
		NewDisplayName = "Flying Baby Duck",
		NewSpeed = 7,
		AbilityName = Enums.EnemyAbilities.BabyDuckRebirth
	}
}