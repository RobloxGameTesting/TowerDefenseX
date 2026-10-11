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
				Percentage = 0.25,
				MaximumBounty = 8000,
				CoinDropData = { Count = 2, Scale = 0.525, ImpulseScale = 0.775 }
			}
		}
	},
	Name = "Place Bounty",
	DisplayName = `Place {25}% Bounty ({8000} MAX)`,
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 23,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://118183427746230",
	Description = "",
	ProjectileName = Enums.Projectiles.MobsterBountyProjectile,
	IsManualAimAtPath = true,
	EffectParentInstanceNames = { "Root>Ability" },
	OverrideDisplayStats = {},
	DisplayStatAdditions = {
		{
			Text = `PLACE {25}% BOUNTY ({8000} MAX)`
		},
		{ Text = "SELECTS STRONGEST ENEMY IN TARGET CIRCLE" }
	},
	HotbarData = { Level = 2 }
}