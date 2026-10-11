local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 0,
	Cooldown = 1,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	EffectParentInstanceNames = { "Wall>Wall" },
	TriggeredAtNoShield = true,
	MaximumUses = 1,
	MovementSpeedIncrease = 2,
	ReplaceAnimationMap = { Move = "MoveNoWall" },
	DestroyInstanceNames = { "Root>WallDragSFX", "WallSparks" }
}