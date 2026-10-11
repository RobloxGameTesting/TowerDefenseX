local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 5,
	Cooldown = 15,
	Animated = true,
	Delay = 0.6,
	ExecutionTime = 1.35,
	AnimationName = "Stomp",
	FaceTarget = false,
	PathEntityToEnemyRadiusEffectData = {
		RequeryBeforeExecution = true,
		MaximumRange = 10,
		Damage = 200,
		DamageType = Enums.DamageTypes.Melee,
		DamageData = {
			IgnoreResistance = false,
			StunData = {
				StunType = Enums.StunTypes.SlammerSlam,
				StunDuration = 1.5,
				CanStunBoss = true,
				IgnoreStunResistance = true
			}
		}
	},
	EffectParentInstanceNames = { "Stomp" },
	InstantPlayEffectParentInstanceNames = { "RootPart>SFX>Stomp" }
}