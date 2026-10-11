local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 5.25,
		SplashRadiusSelectStrongestWithNoBounty = true,
		DamageData = {
			BountyDamageData = {
				Percentage = 0.2,
				MaximumBounty = 8000,
				CoinDropData = { Count = 1, Scale = 0.45, ImpulseScale = 0.75 }
			}
		}
	},
	Name = "Place Bounty",
	DisplayName = `Place {20}% Bounty ({8000} MAX)`,
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 8,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://84419315330651",
	Description = "",
	ProjectileName = Enums.Projectiles.MobsterBountyProjectile,
	IsManualAimAtPath = true,
	EffectParentInstanceNames = { "Root>Ability" },
	OverrideDisplayStats = {},
	DisplayStatAdditions = {
		{
			Text = `PLACE {20}% BOUNTY ({8000} MAX)`
		},
		{ Text = "SELECTS STRONGEST ENEMY IN TARGET CIRCLE" }
	},
	HotbarData = { Level = 1 }
}