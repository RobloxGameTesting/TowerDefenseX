local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local remoteEvent = NetworkingHandler.CreateRemoteEvent("ServerMessagePrompt", true)
local ServerPromptHandler = {}

function ServerPromptHandler.SendPromptToAll(p: string, p2: number?, flag: boolean?)
	remoteEvent:FireAll(p, p2, flag)
end

function ServerPromptHandler.SendPromptToPlayer(p, p2: string, p3: number?, flag: boolean?)
	remoteEvent:FireTo(p, p2, p3, flag)
end

return ServerPromptHandler