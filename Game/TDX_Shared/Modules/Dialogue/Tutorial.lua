local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lang = require(ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Modules"):WaitForChild("Lang"))
require(script.Parent:WaitForChild("DialogueTypes"))
local udim = UDim2.new(1.5, 0, 1.2, 0)
return {
	TutorialWave1 = {
		Dialogue = {
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://99444093702690",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave1_1,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3.25,
				SoundId = "rbxassetid://96915076011784"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://99444093702690",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave1_2,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3.25,
				SoundId = "rbxassetid://106131852905408"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://99444093702690",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave1_3,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3,
				SoundId = "rbxassetid://111225659668393"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://98840110897586",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave1_4,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 6,
				SoundId = "rbxassetid://78590275367314"
			}
		}
	},
	TutorialWave2 = {
		Dialogue = {
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://73668615117439",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave2_1,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 4.5,
				SoundId = "rbxassetid://111047966663396"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://73668615117439",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave2_2,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 4.25,
				SoundId = "rbxassetid://70562396422116"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://88482183967844",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave2_3,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 6,
				SoundId = "rbxassetid://127170483127441"
			}
		}
	},
	TutorialWave3 = {
		Dialogue = {
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://98840110897586",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave3_1,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 2.5,
				SoundId = "rbxassetid://86683815599743"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://73668615117439",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave3_2,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 6,
				SoundId = "rbxassetid://111728883383523"
			}
		}
	},
	TutorialWave4 = {
		Dialogue = {
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://73668615117439",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave4_1,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 2.75,
				SoundId = "rbxassetid://106007217224147"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://99444093702690",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave4_2,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3.5,
				SoundId = "rbxassetid://127160531923299"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://99444093702690",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave4_3,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3.5,
				SoundId = "rbxassetid://133210485582058"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://88482183967844",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave4_4,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 5
			}
		}
	},
	TutorialWave5 = {
		Dialogue = {
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://99444093702690",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave5_1,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 4,
				SoundId = "rbxassetid://103255360416521"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://99444093702690",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave5_2,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3.5,
				SoundId = "rbxassetid://122307982603690"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://98840110897586",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave5_3,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 6,
				SoundId = "rbxassetid://96018996768580"
			}
		}
	},
	TutorialWave6 = {
		Dialogue = {
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://88482183967844",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave6_1,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3.75,
				SoundId = "rbxassetid://97140656923308"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://88482183967844",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave6_2,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 7,
				SoundId = "rbxassetid://93457457065712"
			}
		}
	},
	TutorialWave7 = {
		Dialogue = {
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://99444093702690",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave7_1,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3,
				SoundId = "rbxassetid://138519019172748"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://99444093702690",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave7_2,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 2.25,
				SoundId = "rbxassetid://107177316494229"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://99444093702690",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave7_3,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3,
				SoundId = "rbxassetid://128168455413237"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://97078771157329",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave7_4,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 6,
				SoundId = "rbxassetid://92189298464480"
			}
		}
	},
	TutorialWave8 = {
		Dialogue = {
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://88482183967844",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Wave8_1,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 8,
				SoundId = "rbxassetid://123343229110223"
			}
		}
	},
	TutorialPassed = {
		Dialogue = {
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://90945897079609",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Win_1,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3,
				SoundId = "rbxassetid://138909733771371"
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://83155287415664",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Win_2,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3.75
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://88482183967844",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Win_3,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 3.75
			},
			{
				Name = Lang.Strings.AdvisorNames.Xenon,
				Image = "rbxassetid://97078771157329",
				ImageSize = udim,
				Text = Lang.Strings.Game.Dialogue.Tutorial.Win_4,
				ImageRatio = 1,
				Pitch = 1.25,
				AfterTextDuration = 5
			}
		}
	}
}