local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	DisplayName = "Slash",
	StartingCooldown = 2.5,
	Cooldown = 2,
	Animated = true,
	Delay = 0.65,
	ExecutionTime = 1.083,
	AnimationName = "Slash",
	FaceTarget = true,
	EffectParentInstanceNames = { "Slash" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Slash" },
	PathEntityToEnemyRadiusEffectData = {
		MaximumRange = 5,
		Damage = 50000,
		DamageType = Enums.DamageTypes.Melee,
		DamageData = {
			StunData = {
				StunType = Enums.StunTypes.SlammerSlam,
				StunDuration = 3,
				CanStunBoss = true,
				IgnoreStunResistance = true
			}
		},
		RequeryBeforeExecution = true
	}
}