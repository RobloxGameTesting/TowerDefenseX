local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	ProjectileHitData = {
		IsSplash = true,
		SplashRadius = 2.5,
		SplashRadiusSelectStrongestWithNoBounty = true,
		DamageData = {
			BountyDamageData = {
				Percentage = 0.15,
				MaximumBounty = 5750,
				CoinDropData = { Count = 1, Scale = 0.45, ImpulseScale = 0.75 }
			}
		}
	},
	Name = "Place Bounty",
	DisplayName = `Place {15}% Bounty ({5750} MAX)`,
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 25,
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
			Text = `PLACE {15}% BOUNTY ({5750} MAX)`
		},
		{ Text = "SELECTS STRONGEST ENEMY IN TARGET CIRCLE" }
	},
	HotbarData = { Level = 1 }
}