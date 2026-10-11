local Players = game:GetService("Players")
local interface = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface")
local v = {
	DifficultyVoteScreen = interface:WaitForChild("DifficultyVoteScreen"),
	GameInfoBar = interface:WaitForChild("GameInfoBar"),
	SkipWaveVoteScreen = interface:WaitForChild("TopAreaQueueFrame"):WaitForChild("SkipWaveVoteScreen"),
	GameOverScreen = interface:WaitForChild("GameOverScreen"),
	TowerUI = interface:WaitForChild("TowerUI"),
	BottomBar = interface:WaitForChild("BottomBar")
}

for _, v2 in pairs(v) do
	v2.Visible = false
end

return {}