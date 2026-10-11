local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 50,
	Cooldown = 9999,
	Animated = true,
	Delay = 2.333,
	ExecutionTime = 4.633,
	MaximumUses = 1,
	AnimationName = "Nail Golem",
	EffectParentInstanceNames = {},
	SpawnEnemies = {},
	SpawnStasisEnemies = true
}