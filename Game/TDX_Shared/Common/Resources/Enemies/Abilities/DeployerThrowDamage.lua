local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = { IsSplash = false },
	StartingCooldown = 5,
	Cooldown = 43,
	Animated = true,
	Delay = 0.967,
	ExecutionTime = 1.3,
	AnimationName = "Deploy",
	FaceTarget = true,
	EffectParentInstanceNames = { "Throw" },
	EnemyToTowerRangedDataSequence = {
		{
			ProjectileName = Enums.Projectiles.DeployerObjectDamage,
			Range = 22,
			TargetPath = true,
			DeployStaticEntityData = {
				ObjectName = Enums.StaticEntities.DeployerObjectDamage,
				Lifetime = 20
			}
		}
	}
}