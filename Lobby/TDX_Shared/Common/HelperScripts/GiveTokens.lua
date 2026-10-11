local Atrazine = game.Players:FindFirstChild("Atrazine")

if not Atrazine then
	warn("Couldn't find playerAtrazine")
end

local Data = require(game.ServerScriptService.Server.Data)
Data.Update(Atrazine, "Passes", function(p)
	local tb = p.TB

	if tb then
		tb.Tokens += 10000
	end

	return p
end)