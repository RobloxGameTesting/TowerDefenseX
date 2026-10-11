local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "MobsterGainIgnoreResistance",
	DisplayName = "Overload",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 60,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	TargetSelf = true,
	TowerBuffNames = { Enums.TowerBuffs.GoldenMobsterExtraDamageBuff },
	MainAttackAddDamageData = { IgnoreResistance = true },
	MainAttackAddDamageDataDuration = 18,
	Icon = "rbxassetid://82840612478206",
	Description = "Attack temporarily ignores bullet resistance.",
	EffectParentInstanceNames = { "Root>Ability" },
	DisplayStatAdditions = {
		{
			Text = `ATTACKS IGNORE RESISTANCE FOR {18} SECONDS`,
			ImageId = "rbxassetid://14376195685",
			ImageScale = 0.9
		}
	}
}