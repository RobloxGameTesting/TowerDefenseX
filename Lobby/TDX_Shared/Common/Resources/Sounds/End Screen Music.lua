local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local SoundDefinitions = require(common:WaitForChild("SoundDefinitions"))
return SoundDefinitions.Merge({
	VictoryMusic = SoundDefinitions.Music("rbxassetid://11982721437"),
	DefeatMusic = SoundDefinitions.Music("rbxassetid://11982721639", 0.45),
	NightmareDefeatMusic = SoundDefinitions.Music("rbxassetid://121448983191509", 0.45),
	ToiletVictoryMusic = SoundDefinitions.Music("rbxassetid://16929063545"),
	HalloweenVictoryMusic = SoundDefinitions.Music("rbxassetid://118897661378693"),
	HalloweenDefeatMusic = SoundDefinitions.Music("rbxassetid://77782738911827", 0.45),
	Christmas24DefeatMusicNormal = SoundDefinitions.Music("rbxassetid://118565600095185", 0.45),
	Christmas24DefeatMusicNightmare = SoundDefinitions.Music("rbxassetid://91034335298625", 0.45),
	MLGVictoryMusic = SoundDefinitions.Music("rbxassetid://223131308", 0.25),
	MLGDefeatMusic = SoundDefinitions.Music("rbxassetid://9072304992", 0.5),
	SlimeEventVictoryMusic = SoundDefinitions.Music("rbxassetid://88082515663770", 0.45),
	SlimeEventDefeatMusic = SoundDefinitions.Music("rbxassetid://91304775220443", 0.45),
	Halloween2025VictoryMusic = SoundDefinitions.Music("rbxassetid://112322160420075", 0.45),
	Halloween2025DefeatMusic = SoundDefinitions.Music("rbxassetid://133275975794332", 0.45),
	Christmas25VictoryMusic = SoundDefinitions.Music("rbxassetid://75638071503165", 0.45),
	Christmas25DefeatMusic = SoundDefinitions.Music("rbxassetid://113864311886052", 0.45),
	Easter26VictoryMusic = SoundDefinitions.Music("rbxassetid://89228244210233", 0.45),
	Easter26DefeatMusic = SoundDefinitions.Music("rbxassetid://105249453398062", 0.45),
	TB2VictoryMusic = SoundDefinitions.Music("rbxassetid://121961413265838", 0.45, "Push Back"),
	TB2DefeatMusic = SoundDefinitions.Music("rbxassetid://128183132410852", 0.45, "Dishonorable")
})