local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WaveTypes"))
return {
	{
		InitialBlackDuration = 2,
		InitialBlackFadeInTime = 0.5,
		InitialBlackFadeOutTime = 0.5,
		EndingBlackDuration = 2,
		EndingBlackFadeInTime = 0.25,
		EndingBlackFadeOutTime = 0.5,
		Duration = 109.3,
		Name = Enums.Cutscenes.Christmas25Part2Intro,
		SpawnArrows = false,
		InsertModelDuringInitialBlack = true,
		InsertModelDelay = 1,
		HideMapDuringCutscene = true,
		RemoveModelDuringEndingBlack = true,
		RemoveModelDelay = 1,
		ModelAnimationName = "Animation",
		PlayAnimationOnInitialBlackFadeOut = true,
		SubtitleData = {
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "Hey no, I already told you I don't care about your prototype—",
				Time = 0.75,
				Duration = 2.55
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "Oh! Advisor, sir right, didn't know it was you.",
				Time = 3.3,
				Duration = 2.6900000000000004
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "You want a coffee? Some tea maybe?",
				Time = 5.99,
				Duration = 2.1400000000000006
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "Probably not that kind of guy, actually. I've got a sodaaaa!",
				Time = 8.13,
				Duration = 2.869999999999999
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "Run me down on what exactly happened.",
				Time = 11,
				Duration = 3
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "Yeah, uh... buddy, Advisor. I was experimenting with the Eradicator MK 3, like you said,",
				Time = 14,
				Duration = 5.149999999999999
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "and, well... its AI mind kind of took control of some of my robo—",
				Time = 19.15,
				Duration = 4.600000000000001
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "You already told me this in your message.",
				Time = 23.75,
				Duration = 2.0500000000000007
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "Explain how it even activated in the first place unless you activated it.",
				Time = 25.8,
				Duration = 5.289999999999999
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "Well... you're not entirely wrong.",
				Time = 31.09,
				Duration = 2.7099999999999973
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "What? Don't tell me... you activated it?!",
				Time = 33.8,
				Duration = 4.880000000000003
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "I TOLD YOU NOT TO ACTIVATE IT!",
				Time = 38.68,
				Duration = 2.3699999999999974
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "Now, now, Advisor you told me to turn it on.",
				Time = 41.05,
				Duration = 2.3700000000000045
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "AS PER PROTOCOL, WITH OUR MIND STASIS FIELD",
				Time = 43.42,
				Duration = 4.409999999999997
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "THAT WAY, IT CAN'T EVEN BEGIN TO SEND A SIGNAL BACK TO XENON!",
				Time = 47.83,
				Duration = 3.6700000000000017
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "Yeah... that protocol didn't work. And I kind of knew it wouldn't,",
				Time = 51.5,
				Duration = 4
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "because you guys made it. The AI has taken control and now has a",
				Time = 55.5,
				Duration = 2.8100000000000023
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "mass producing facility not too far from where the scientists were picked up.",
				Time = 58.31,
				Duration = 3.4299999999999997
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "From war to war, there's never a break in this goddamn job.",
				Time = 62.46,
				Duration = 4.109999999999992
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "What do you expect us to do fight it? Can't you just hit an off switch?!",
				Time = 66.73,
				Duration = 4.109999999999999
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "No. The Eradicator MK 3's signal overtook the factory and started mass producing robots,",
				Time = 70.84,
				Duration = 4.640000000000001
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "each with their own security protocols. Hacking it would take years—that's time we don't have.",
				Time = 75.49,
				Duration = 5.6200000000000045
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "Does it have the capability of producing an explosion like the Emperor did a few weeks ago?",
				Time = 81.11,
				Duration = 4.709999999999994
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "No. I removed all of its weapons.",
				Time = 85.82,
				Duration = 1.8900000000000006
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "Only the head is connected, it can do nothing else since I quarantined it.",
				Time = 87.71,
				Duration = 3.240000000000009
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "At least ten million lives were lost in that explosion.",
				Time = 90.95,
				Duration = 3.9200000000000017
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "A piece of Earth was burned to a crisp and now we have to deal with your mess?",
				Time = 94.87,
				Duration = 5.929999999999993
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "Maybe.",
				Time = 100.8,
				Duration = 1.8800000000000097
			},
			{
				Name = "Advisor",
				NameColor = Color3.fromRGB(200, 200, 200),
				Text = "We'll clean up this mess. Then we'll talk later, Mr. Forge.",
				Time = 102.68,
				Duration = 4.089999999999989
			},
			{
				Name = "Mr. Forge",
				NameColor = Color3.fromRGB(80, 80, 255),
				Text = "Looking forward to it. Good luck.",
				Time = 106.77,
				Duration = 2.6000000000000085
			}
		}
	}
}