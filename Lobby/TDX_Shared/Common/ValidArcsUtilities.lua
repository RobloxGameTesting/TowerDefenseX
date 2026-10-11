local ValidArcsUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("PlacementHandler"))
local Utilities = require(common:WaitForChild("Utilities"))
require(common:WaitForChild("MapHandler"))
local floor = math.floor
local atan2 = math.atan2

local function GetArcs(p: number, list) -- 1 equivalent call inferred from this helper
	local count = #list
	local v = floor(count * p / 6.283185307179586) % count

	if v == 0 then
		v = count
	end

	local v2 = (v + 1) % count

	if v2 == 0 then
		v2 = count
	end

	return list[v], list[v2]
end

function ValidArcsUtilities.GetMaximumDistanceAtAngle(p: number, p2: number, p3: number, p4: number, list)
	local v = #list
	local v2 = atan2(p4 - p2, p3 - p)
	local arcs, v3 = GetArcs(v2, list) -- inferred equivalent call
	local v4 = (v2 - atan2(arcs.GoalDirection.Z, arcs.GoalDirection.X)) % 6.283185307179586 / (6.283185307179586 / v)
	local distanceBeforeHit = arcs.DistanceBeforeHit
	local distanceBeforeHit2 = v3.DistanceBeforeHit
	return (Utilities.Lerp(distanceBeforeHit, distanceBeforeHit2, v4))
end

return ValidArcsUtilities