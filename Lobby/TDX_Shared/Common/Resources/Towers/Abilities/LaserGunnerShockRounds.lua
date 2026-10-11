local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
local Enums = require(common:WaitForChild("Enums"))
return {
	Name = "LaserGunnerShockRounds",
	DisplayName = "Shock Rounds",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 30,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	TargetSelf = true,
	TowerBuffNames = { Enums.TowerBuffs.LaserGunnerExtraDamageBuff },
	MainAttackAddDamageData = {
		StunData = {
			StunType = Enums.StunTypes.LaserGunnerStun,
			StunDuration = 0.3,
			CanStunBoss = false
		}
	},
	MainAttackAddDamageDataDuration = 12,
	Icon = "rbxassetid://18762324322",
	Description = "Attack temporarily stuns enemies.",
	EffectParentInstanceNames = { "StunActivateSFX" },
	DisplayStatAdditions = {
		{
			Text = `ATTACKS STUN FOR {0.3} SECONDS`,
			ImageId = "rbxassetid://14376195685",
			ImageScale = 0.9
		},
		{ Text = `ACTIVE FOR {12} SECONDS`, ImageId = nil, ImageScale = nil }
	}
}