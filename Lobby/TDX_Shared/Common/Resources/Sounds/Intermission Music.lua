local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local SoundDefinitions = require(common:WaitForChild("SoundDefinitions"))
return SoundDefinitions.Merge({
	MapVoteMusic = SoundDefinitions.LoopedMusic("rbxassetid://122782267502256", 0.25),
	DifficultyVotingMusic = SoundDefinitions.LoopedMusic("rbxassetid://15903664566", 0.25),
	TBIntermissionMusic = SoundDefinitions.LoopedMusic("rbxassetid://18459837531", 0.25),
	HalloweenIntermissionMusic = SoundDefinitions.LoopedMusic("rbxassetid://77352919831386", 0.45),
	Christmas24IntermissionMusic = SoundDefinitions.LoopedMusic("rbxassetid://104887164859040", 0.25),
	Halloween2025IntermissionMusic = SoundDefinitions.LoopedMusic("rbxassetid://113577474905435", 0.45),
	Christmas25IntermissionMusic = SoundDefinitions.LoopedMusic("rbxassetid://125284039684894", 0.25),
	Easter26IntermissionMusic = SoundDefinitions.LoopedMusic("rbxassetid://76993260084309", 0.25),
	TB2IntermissionMusic = SoundDefinitions.LoopedMusic("rbxassetid://136835041490881", 0.25, "Pr0000000paganda")
})