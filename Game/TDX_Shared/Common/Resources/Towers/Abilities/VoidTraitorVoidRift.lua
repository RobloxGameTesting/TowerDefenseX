local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "VoidTraitorVoidRift",
	DisplayName = "Void Rift",
	Passive = false,
	StartingCooldown = 5,
	Cooldown = 85,
	Animated = true,
	Delay = 0,
	ExecutionTime = 9.433333333333332,
	AnimationName = "WarshipFall",
	EffectParentInstanceNames = { "RootPart>VoidRiftSFX" },
	GlobalLockGroup = "VoidPortal",
	GlobalLockDuration = 16,
	GlobalLockErrorMessage = "Another void rift is already open!",
	Icon = "rbxassetid://88321594552901",
	FullSizeIcon = true,
	Description = "Tear open a rift that rains debris from the void onto nearby enemies.",
	BombardmentData = {
		ContinueWhileDisabled = true,
		Attacks = {
			{
				Delay = 181 / 30,
				Duration = 6,
				Count = 25,
				SpawnDistance = 90,
				SpawnOffsetFromOrigin = vector.create(0, 1, 0),
				TargetRandomEnemy = true,
				TargetEnemyRange = 100,
				CanTargetAir = true,
				ProjectileName = Enums.Projectiles.VoidTraitorMeteor,
				Damage = 3000,
				SplashRadius = 6,
				SplashAlwaysHitAirAndGround = true
			}
		}
	}
}