local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 325,
	Speed = 3.2,
	BodyHeat = 50,
	BodyHeatRegenerationRate = 10,
	Radius = 1,
	AnimationTimeScale = 1,
	DeathAbilityNames = { Enums.EnemyAbilities.EMP },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.EMP,
	FakeEnemy = false,
	FadeOutOnDeath = true,
	FadeOutCustomTime = 0.5
}