local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 60,
	Animated = true,
	Delay = 2,
	ExecutionTime = 3.517,
	ContinueMovingWhileUsing = true,
	AnimationName = "CurseBase",
	EffectParentInstanceNames = { "CurseBase" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>CurseBase" },
	DamageBaseData = { Damage = 350 }
}