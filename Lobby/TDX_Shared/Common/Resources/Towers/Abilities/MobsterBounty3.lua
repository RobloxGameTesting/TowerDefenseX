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
				Percentage = 0.3,
				MaximumBounty = 23000,
				CoinDropData = { Count = 3, Scale = 0.6, ImpulseScale = 0.8 }
			}
		}
	},
	Name = "Place Bounty",
	DisplayName = `Place {30}% Bounty ({23000} MAX)`,
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 20,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://73059306018043",
	Description = "",
	ProjectileName = Enums.Projectiles.MobsterBountyProjectile,
	IsManualAimAtPath = true,
	EffectParentInstanceNames = { "Root>Ability" },
	OverrideDisplayStats = {},
	DisplayStatAdditions = {
		{
			Text = `PLACE {30}% BOUNTY ({23000} MAX)`
		},
		{ Text = "SELECTS STRONGEST ENEMY IN TARGET CIRCLE" }
	},
	HotbarData = { Level = 3 }
}