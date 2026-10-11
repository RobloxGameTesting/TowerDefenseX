return {
	Name = "getactivepass",
	Aliases = {},
	Description = "",
	Group = "Programmer",
	Args = {},
	ClientRun = function(_)
		local Data = require(game.ReplicatedStorage.TDX_Shared.Client.Services.Data)
		return (tostring(Data.Get("Passes").ActivePass))
	end
}