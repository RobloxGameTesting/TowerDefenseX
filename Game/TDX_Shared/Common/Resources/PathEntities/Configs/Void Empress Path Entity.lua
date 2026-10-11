local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
return {
	OverrideDisplayName = "Void Empress",
	Health = 50000,
	Speed = 3,
	Radius = 1,
	AnimationTimeScale = 1,
	AnimationCalibratedSpeed = 2.63,
	NoPathOffset = false,
	ReverseDirection = true,
	RotationOffset = CFrame.Angles(0, 0, 0),
	DeathEffect = Enums.DeathEffects.ZombieBlood,
	ShieldModelName = "ForceField",
	AbilityNames = {
		Enums.PathEntityAbilities.VoidEmpressPathEntitySpinCharge,
		Enums.PathEntityAbilities.VoidEmpressPathEntityStab
	},
	AbilityBufferTime = 2
}