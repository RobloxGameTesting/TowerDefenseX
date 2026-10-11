local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local MapHandler = require(common:WaitForChild("MapHandler"))
local PathHandler = require(common:WaitForChild("PathHandler"))
local PathUtilities = require(common:WaitForChild("PathUtilities"))
local TeamUtilities = require(common:WaitForChild("TeamUtilities"))
local AimingGuideHandler = require(script.Parent:WaitForChild("AimingGuideHandler"))
local v = nil
local v2 = false
local v3 = 0
local v4 = 0
local v5 = 0
local PathAiming = {}

function PathAiming.Run(p: number, vector: Vector3)
	MapHandler.HidePathHighlight()
	local closestPointOnPath, v6, v7, v8 = PathUtilities.GetClosestPointOnPath(
		vector,
		PathHandler.GetPathLineSegments(TeamUtilities.GetLocalPlayerTeamIndex()),
		true,
		false
	)

	if v6 <= v5 then
		v3 = v7
		v4 = v8
		v2 = true
		vector = closestPointOnPath
	else
		v2 = false
	end

	AimingGuideHandler.Show(p, vector, vector, v2)
	v = vector
end

function PathAiming.BeginPathAiming(p: number)
	v5 = p
end

function PathAiming.GetCurrentAimPosition()
	return v2, v, v3, v4
end

function PathAiming.Hide()
	AimingGuideHandler.Hide()
end

return PathAiming