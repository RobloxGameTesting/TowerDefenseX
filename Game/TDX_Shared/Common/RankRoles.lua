local common = game.ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("GlobalConstants"))
return {
	JohnRoblox = {
		GroupRank = 255,
		TagText = "i'm john roblox",
		TagColor = Color3.fromRGB(235, 64, 52),
		TextColor = Color3.fromRGB(242, 93, 82)
	},
	Atrazine = {
		GroupRank = 254,
		TagText = "LEAD DEV",
		TagColor = Color3.fromRGB(94, 207, 255),
		TextColor = Color3.fromRGB(173, 243, 254)
	},
	Programmer = {
		GroupRank = 205,
		TagText = "DEV",
		TagColor = Color3.fromRGB(247, 124, 86),
		TextColor = Color3.fromRGB(247, 124, 86)
	},
	Manager = {
		GroupRank = 201,
		TagText = "MANAGER",
		TagColor = Color3.fromRGB(210, 86, 247),
		TextColor = Color3.fromRGB(210, 86, 247)
	},
	SuperDuperBreadTester = {
		GroupRank = 200,
		TagText = "SUPER TESTER",
		TagColor = Color3.fromRGB(86, 247, 121),
		TextColor = Color3.fromRGB(86, 247, 121)
	},
	Developer = {
		GroupRank = 198,
		TagText = "DEV",
		TagColor = Color3.fromRGB(247, 124, 86),
		TextColor = Color3.fromRGB(247, 124, 86)
	},
	SuperBreadTester = {
		GroupRank = 112,
		TagText = "TESTER",
		TagColor = Color3.fromRGB(247, 236, 86),
		TextColor = Color3.fromRGB(247, 236, 86)
	},
	VoiceActor = {
		GroupRank = 111,
		TagText = "VOICE ACTOR",
		TagColor = Color3.fromRGB(93, 104, 255),
		TextColor = Color3.fromRGB(93, 104, 255)
	},
	Contractor = {
		GroupRank = 12,
		TagText = "CONTRACTOR",
		TagColor = Color3.fromRGB(143, 89, 255),
		TextColor = Color3.fromRGB(143, 89, 255)
	}
}