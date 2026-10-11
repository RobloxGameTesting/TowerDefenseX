local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 42,
	Animated = false,
	Delay = 1,
	ExecutionTime = 2,
	ContinueMovingWhileUsing = true,
	InstantPlayEffectParentInstanceNames = { "EMP>SFX" },
	EffectParentInstanceNames = { "EMP>VFX" },
	EnemyToTowerRadiusEffectData = {
		MaximumRange = 45,
		MinimumTargets = 3,
		TowerBuffNames = { Enums.TowerBuffs.TheIlluminatiEMPDebuff }
	}
}