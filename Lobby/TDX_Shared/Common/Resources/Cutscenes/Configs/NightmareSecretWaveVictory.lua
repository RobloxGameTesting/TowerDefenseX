local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WaveTypes"))
return {
	{
		InitialBlackDuration = 2,
		InitialBlackFadeInTime = 0,
		InitialBlackFadeOutTime = 0.5,
		EndingBlackDuration = 2,
		EndingBlackFadeInTime = 0.25,
		EndingBlackFadeOutTime = 0.5,
		BlackScreenCustomColor = Color3.new(255, 255, 255),
		Duration = 156.3,
		Name = Enums.Cutscenes.NightmareSecretWaveVictory,
		SpawnArrows = false,
		InsertModelDuringInitialBlack = true,
		InsertModelDelay = 1,
		HideMapDuringCutscene = true,
		RemoveModelDuringEndingBlack = true,
		RemoveModelDelay = 1,
		ModelAnimationName = "Animation",
		PlayAnimationOnInitialBlackFadeOut = true,
		SubtitleData = {}
	}
}