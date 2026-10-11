local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local SoundDefinitions = require(common:WaitForChild("SoundDefinitions"))
return SoundDefinitions.Merge({
	HitShieldHeadshot1 = SoundDefinitions.SFX("rbxassetid://114147351055276", 0.1, {
		OverrideSoundGroup = "SFX"
	}),
	HitShieldHeadshot2 = SoundDefinitions.SFX("rbxassetid://86503460476731", 0.1, {
		OverrideSoundGroup = "SFX"
	}),
	HitShieldHeadshot3 = SoundDefinitions.SFX("rbxassetid://127978310912849", 0.1, {
		OverrideSoundGroup = "SFX"
	}),
	HitShield1 = SoundDefinitions.SFX("rbxassetid://105218036515182", 0.1, {
		OverrideSoundGroup = "SFX"
	}),
	HitShield2 = SoundDefinitions.SFX("rbxassetid://81317404731533", 0.1, {
		OverrideSoundGroup = "SFX"
	}),
	HitShield3 = SoundDefinitions.SFX("rbxassetid://85379275226950", 0.1, {
		OverrideSoundGroup = "SFX"
	}),
	HitShieldShatter = SoundDefinitions.SFX("rbxassetid://90119769252187", 0.15, {
		OverrideSoundGroup = "SFX"
	}),
	HitKill = SoundDefinitions.SFX("rbxassetid://120289965986309", 0.25, {
		OverrideSoundGroup = "SFX"
	}),
	HitHeadshot = SoundDefinitions.SFX("rbxassetid://82998182448847", 0.25, {
		OverrideSoundGroup = "SFX"
	}),
	HitStandard = SoundDefinitions.SFX("rbxassetid://126044619280601", 0.25, {
		OverrideSoundGroup = "SFX"
	}),
	AssaultModeCaptureProgress = SoundDefinitions.SFX("rbxassetid://127526918835895", 0.25, {
		OverrideSoundGroup = "SFX"
	}),
	AssaultModeCaptureComplete = SoundDefinitions.SFX("rbxassetid://76411122159720", 0.25, {
		OverrideSoundGroup = "SFX"
	}),
	Ping_Danger = SoundDefinitions.SFX("rbxassetid://79860538488283", 0.4, {
		OverrideSoundGroup = "SFX"
	}),
	Ping_Assist = SoundDefinitions.SFX("rbxassetid://111785345899505", 0.4, {
		OverrideSoundGroup = "SFX"
	}),
	Ping_Confirm = SoundDefinitions.SFX("rbxassetid://133067029785273", 0.4, {
		OverrideSoundGroup = "SFX"
	}),
	Ping_Sell = SoundDefinitions.SFX("rbxassetid://87680082687314", 0.4, {
		OverrideSoundGroup = "SFX"
	}),
	Ping_Question = SoundDefinitions.SFX("rbxassetid://114760595979337", 0.4, {
		OverrideSoundGroup = "SFX"
	}),
	CorruptedEradicatorMK2Jumpscare = SoundDefinitions.SFX("rbxassetid://98333532124418", 1.5)
})