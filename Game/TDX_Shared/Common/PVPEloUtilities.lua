require(script.Parent:WaitForChild("GlobalConstants"))
local Util = require(script.Parent.Parent:WaitForChild("Modules"):WaitForChild("Util"))
local PVP_ELO_DEFAULT = _G.PVP_ELO_DEFAULT
local PVP_ELO_INITIAL_PER_RANK = _G.PVP_ELO_INITIAL_PER_RANK
local PVP_ELO_INITIAL_RANK_CAP = _G.PVP_ELO_INITIAL_RANK_CAP
return {
	GetInitialElo = function(value: number?)
		local xpToLevelAndProgress = Util.XPToLevelAndProgress(value or 0)
		return PVP_ELO_DEFAULT + math.min(xpToLevelAndProgress, PVP_ELO_INITIAL_RANK_CAP) * PVP_ELO_INITIAL_PER_RANK
	end
}