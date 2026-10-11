local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Health = 100,
	Speed = 2.8,
	BodyHeat = 5,
	BodyHeatRegenerationRate = 2.5,
	Radius = 1,
	HoverHeight = 1.626,
	AnimationTimeScale = 1,
	DeathAbilityNames = { Enums.EnemyAbilities.MultiplierAdminClone },
	NoPathOffset = false,
	RotationOffset = CFrame.Angles(0, -1.5707963267948966, 0),
	DeathEffect = Enums.DeathEffects.AtrazineDeath,
	FakeEnemy = false
}