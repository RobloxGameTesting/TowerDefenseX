local PingConfig = { SlotCount = 5 }
PingConfig.AngleOffsetDegrees = -360 / PingConfig.SlotCount / 2
PingConfig.Pings = {
	{
		Id = "Danger",
		InactiveColor = Color3.fromHex("#BB7F80"),
		ActiveColor = Color3.fromHex("#FF0004"),
		Text = "DANGER",
		WorldIcon = "rbxassetid://136532354264033",
		Sfx = "Ping_Danger"
	},
	{
		Id = "Assist",
		InactiveColor = Color3.fromHex("#3965bd"),
		ActiveColor = Color3.fromHex("#4d88ff"),
		Text = "NEED HELP",
		WorldIcon = "rbxassetid://137829789459638",
		Sfx = "Ping_Assist"
	},
	{
		Id = "Confirm",
		InactiveColor = Color3.fromHex("#69A58E"),
		ActiveColor = Color3.fromHex("#00FFB2"),
		Text = "GOT IT",
		WorldIcon = "rbxassetid://92646595665287",
		Sfx = "Ping_Confirm"
	},
	{
		Id = "Sell",
		InactiveColor = Color3.fromHex("#8CB48A"),
		ActiveColor = Color3.fromHex("#15FF00"),
		Text = "SELL",
		WorldIcon = "rbxassetid://123352600836392",
		Sfx = "Ping_Sell"
	},
	{
		Id = "Question",
		InactiveColor = Color3.fromHex("#BEAA70"),
		ActiveColor = Color3.fromHex("#FFFB00"),
		Text = "WHAT'S THIS?",
		WorldIcon = "rbxassetid://123090971673631",
		Sfx = "Ping_Question"
	}
}
PingConfig.NoneText = "None"
PingConfig.NoneInactiveColor = Color3.fromHex("#A2A2A2")
PingConfig.MaxPings = 5
PingConfig.WindowSeconds = 5
PingConfig.WorldLifetimeSeconds = 5
PingConfig.WorldOffset = vector.create(0, 0.05, 0)
PingConfig.MaxRangeStuds = 1000
PingConfig.LandingCircle = "rbxassetid://106667034725507"
PingConfig.ActivePingTag = "ActivePing"
return PingConfig