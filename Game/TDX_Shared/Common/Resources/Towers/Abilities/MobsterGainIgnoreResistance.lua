local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "MobsterGainIgnoreResistance",
	DisplayName = "AP Rounds",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 22,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	TargetSelf = true,
	TowerBuffNames = { Enums.TowerBuffs.MobsterExtraDamageBuff },
	MainAttackAddDamageData = { IgnoreResistance = true },
	MainAttackAddDamageDataDuration = 10,
	Icon = "rbxassetid://77354863623745",
	Description = "Attack temporarily ignores bullet resistance.",
	EffectParentInstanceNames = { "Root>Ability" },
	DisplayStatAdditions = {
		{
			Text = `ATTACKS IGNORE RESISTANCE FOR {10} SECONDS`,
			ImageId = "rbxassetid://14376195685",
			ImageScale = 0.9
		}
	}
}