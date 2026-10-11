return {
	Name = "sologame",
	Aliases = {},
	Description = "Starts a solo game with the specified lobby type.",
	Group = "Programmer",
	Args = {
		{ Type = "lobbyType", Name = "lobbyType", Description = "The lobby type to start" }
	},
	ClientRun = function(_, p)
		if game.ReplicatedStorage:WaitForChild("Network"):WaitForChild("ClientRequestSoloGame"):InvokeServer(p) then
			return `Successfully started solo game for lobby type: {p}`
		end

		return "Solo game request failed"
	end
}