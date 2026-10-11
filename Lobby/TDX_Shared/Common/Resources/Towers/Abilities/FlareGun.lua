local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
return {
	Name = "FlareGun",
	DisplayName = "Flare Gun",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 10,
	Animated = true,
	Delay = 1.367,
	ExecutionTime = 4.367,
	BurstSize = 30,
	BurstInterval = 0.1,
	BlockUpgradesWhileActive = true,
	AnimationName = "Flare",
	Icon = "rbxassetid://15245965000",
	Description = "Temporarily reveal nearby enemies.",
	HasRadiusEffect = true,
	EffectRadius = 40,
	HasRevealEffect = true,
	RevealTime = 8,
	DisplayStatAdditions = {
		{ Text = "FLARE LASTS 3.0 SECONDS" }
	}
}