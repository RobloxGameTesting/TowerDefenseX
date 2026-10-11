local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 10,
	Delay = 1.05,
	ExecutionTime = 43 / 15,
	Animated = true,
	AnimationName = "Slap",
	FaceTarget = true,
	EnemyToTowerRangedDataSequence = {
		{
			Range = 8,
			DamageData = { Damage = 200 }
		}
	},
	EffectParentInstanceNames = { "RootPart>SFX>Slap" },
	EffectsStartDelay = 0.85
}