local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	StartingCooldown = 3,
	Cooldown = 25,
	Animated = true,
	Delay = 0,
	ExecutionTime = 6.933,
	AnimationName = "Jump",
	FaceTarget = true,
	ForceFaceOverideTime = 0.9,
	ForceFaceOverideTimeInitial = 1.2,
	InstantPlayEffectParentInstanceNames = { "RootPart>Jump" },
	EffectParentInstanceNames = { "RootPart>JumpLand" },
	EnemyMultiJumpData = {
		Sequence = {
			{
				Type = Enums.MultiJumpTypes.TargetPathEntity,
				StartTime = 2.633,
				EndTime = 3.8,
				TargetQueryData = { PathEntity_TargetStrongest = true },
				LandHitDataTable = {
					{ IsSplash = false, RemoveTowerInvulnerability = true, Damage = 10000000 },
					{
						IsSplash = true,
						SplashRadius = 10,
						Damage = 100,
						BuffName = Enums.TowerBuffs.BunnyOTronJumpStun
					}
				},
				RangeMaximum = 50,
				RangeMinimum = 15,
				Invulnerable = true,
				TweenToGoal = true,
				AdditionalJumpHeight = 5,
				LandEffectNames = { "Jump>VFX>Land" },
				JumpEffectNames = { "Jump>VFX>Takeoff" }
			},
			{ Type = Enums.MultiJumpTypes.FaceNextTarget, StartTime = 4.133, EndTime = 5.033 },
			{
				Type = Enums.MultiJumpTypes.Return,
				StartTime = 5.333,
				EndTime = 6.3,
				LandHitDataTable = {
					{
						IsSplash = true,
						SplashRadius = 10,
						Damage = 100,
						BuffName = Enums.TowerBuffs.BunnyOTronJumpStun
					}
				},
				Invulnerable = true,
				TweenToGoal = true,
				AdditionalJumpHeight = 7,
				LandEffectNames = { "Jump>VFX>Land" },
				JumpEffectNames = { "Jump>VFX>Takeoff" }
			}
		}
	}
}