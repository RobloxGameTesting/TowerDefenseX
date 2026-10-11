local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("AbilityTypes"))
require(common:WaitForChild("ProjectileTypes"))
require(common:WaitForChild("Enums"))
local CombatDrone = require(script.Parent.Parent.Configs["Combat Drone"])
local FPS_MODE_STRONG_BOSS_THRESHOLD = _G.FPS_MODE_STRONG_BOSS_THRESHOLD
return {
	Name = "DirectControl",
	DisplayName = "Direct Control",
	Passive = false,
	StartingCooldown = 0,
	Cooldown = 2,
	Animated = false,
	Delay = 0,
	ExecutionTime = 0,
	Icon = "rbxassetid://97303234610379",
	Description = "Control tower directly.",
	ToggleDirectControl = true,
	EffectParentInstanceNames = { "Root" },
	DisplayStatAdditions = {
		{
			Text = `BASE MULTIPLIER: {CombatDrone.BASE_DAMAGE_MULTIPLIER}X`
		},
		{
			Text = `HEADSHOT MULTIPLIER: {CombatDrone.HEADSHOT_DAMAGE_MULTIPLIER}X`
		},
		{
			Text = `BOSS HEADSHOT MULTIPLIER: {CombatDrone.BOSS_HEADSHOT_DAMAGE_MULTIPLIER}X`
		},
		{
			Text = `STRONG BOSS (>{math.ceil(FPS_MODE_STRONG_BOSS_THRESHOLD / 1000000)}M HP) HEADSHOT MULTIPLIER: {CombatDrone.STRONG_BOSS_HEADSHOT_DAMAGE_MULTIPLIER}X`
		},
		{ Text = "HEADSHOTS IGNORE RESISTANCE" }
	}
}