local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 550,
	Speed = 3.2,
	BodyHeat = 200,
	BodyHeatRegenerationRate = 45,
	Radius = 1,
	AnimationTimeScale = 1,
	AbilityNames = { Enums.EnemyAbilities.JammerDisableAbilities },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	FakeEnemy = false
}