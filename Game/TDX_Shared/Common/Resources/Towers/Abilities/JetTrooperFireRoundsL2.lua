local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "JetTrooperFireRounds",
	DisplayName = "Fire Rounds LVL 2",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 22,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	TargetSelf = true,
	MainAttackAddDamageData = {
		BurnDamageData = { BurnEffectHash = script.Name, DamagePerSecond = 25, StickDuration = 9 }
	},
	MainAttackAddDamageDataDuration = 9,
	Icon = "rbxassetid://86358018671016",
	Description = "Attack temporarily gains burn damage.",
	EffectParentInstanceNames = { "Root>Ability" },
	DisplayStatAdditions = {
		{
			Text = `ADDITIONAL {25} DPS BURN DAMAGE FOR {9} SECONDS`,
			ImageId = "rbxassetid://15246030444",
			ImageScale = 0.9
		},
		{
			Text = `FIRE ROUNDS LAST FOR {9} SECONDS`,
			ImageId = "rbxassetid://15498074294",
			ImageScale = 0.9
		}
	}
}