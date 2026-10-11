local PathHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("MapHandler"))
require(common:WaitForChild("Utilities"))
require(common:WaitForChild("PathUtilities"))
local Analyzer = require(script:WaitForChild("Analyzer"))
require(script:WaitForChild("NodeClass"))
workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local v = {}
local v2 = {}
local v3 = {}
local v4 = {}
local v5 = {}
local result = {}
local v6 = {}

local function GenerateSpawnIndices()
	v3 = {}
	v4 = {}
	v5 = {}
	result = {}

	for k, v7 in pairs(v) do
		local spawnPathIndexes = {}
		local spawnPathIndexes2 = {}
		local spawnPathIndexes3 = {}

		for _, v8 in pairs(v7) do
			if v8:GetIsDisabled() then
				continue
			end

			if v8:GetIsBossSpawn() then
				table.insert(spawnPathIndexes, v8:GetSpawnPathIndex())
			elseif v8:GetIsPathEntitySpawn() then
				table.insert(spawnPathIndexes2, v8:GetSpawnPathIndex())
			elseif not v8:GetIsCustomPath() then
				table.insert(spawnPathIndexes3, v8:GetSpawnPathIndex())
			end
		end

		v3[k] = spawnPathIndexes3
		v4[k] = spawnPathIndexes
		v5[k] = spawnPathIndexes2
		table.insert(result, k)
	end
end

function PathHandler.GetPVPTeamIndices()
	return result
end

function PathHandler.CheckPathIndex(p: number, p2: number?)
	if p2 then
		local v7 = v[p2]

		if not v7 or (p < 0 or #v7 < p) then
			return false
		end
	else
		for _, v7 in pairs(v) do
			if p < 0 or #v7 < p then
				return false
			end
		end
	end

	return true
end

function PathHandler.GetSpawn(p: number, value: number?)
	local v7 = value or 1

	if PathHandler.CheckPathIndex(p, v7) then
		return v[v7][p]
	end

	error("PathHandler.GetSpawn - Invalid path index:", p)
end

function PathHandler.GetEnd(p: number, value: number?)
	local v7 = value or 1

	if PathHandler.CheckPathIndex(p, v7) then
		return v2[v7][p]
	end

	error("PathHandler.GetEnd - Invalid path index:", p)
end

function PathHandler.GetEndNodePositions(p: number?)
	local positions = {}

	if p then
		local v7 = v2[p]

		if not v7 then
			warn("No end nodes found for team index " .. p)
			return positions
		end

		for _, v8 in pairs(v7) do
			if not v8:GetQueryIgnore() then
				table.insert(positions, v8.Position)
			end
		end

		return positions
	else
		for _, v7 in pairs(v2) do
			for _, v8 in pairs(v7) do
				if not v8:GetQueryIgnore() then
					table.insert(positions, v8.Position)
				end
			end
		end

		return positions
	end
end

function PathHandler.HasBossSpawns(value: number?)
	local v7 = v4[value or 1]
	return v7 and #v7 > 0
end

function PathHandler.GetRandomBossPathIndex(value: number?)
	local v7 = v4[value or 1]
	return v7[math.random(1, #v7)]
end

function PathHandler.GetRandomPathIndex(value: number?)
	local v7 = v3[value or 1]
	return v7[math.random(1, #v7)]
end

function PathHandler.GetSpawnIndices(value: number?)
	return v3[value or 1]
end

function PathHandler.GetSpawnCount(value: number?)
	return #v3[value or 1]
end

function PathHandler.GetPathEntitySpawnIndices(value: number?)
	return v5[value or 1]
end

function PathHandler.GetPathEntitySpawnCount(value: number?)
	return #v5[value or 1]
end

function PathHandler.GetPathLength(p: number, value: number?)
	local v7 = value or 1

	if PathHandler.CheckPathIndex(p, v7) then
		local v8 = v[v7]

		if v8 then
			return v8[p]:GetTotalPathLength(p)
		else
			warn("No spawn nodes found for team index " .. v7)
		end
	else
		error("PathHandler.GetPathLength - Invalid path index:", p)
	end

	return 0
end

function PathHandler.GetPositionAtPathPercentage(p: number, value: number?, p2: number)
	local v7 = value or 1

	if not PathHandler.CheckPathIndex(p, v7) then
		warn("PathHandler.GetPositionAtPathPercentage - Invalid path index:", p)
		return (Vector3.new())
	end

	local v8 = v[v7][p]
	local nextNode = v8:GetNext(p)
	local percentageAlongPath = nextNode:GetPercentageAlongPath(p)

	while percentageAlongPath < p2 and nextNode do
		local nextNode2 = nextNode:GetNext(p)
		percentageAlongPath = nextNode2:GetPercentageAlongPath(p)
		v8 = nextNode
		nextNode = nextNode2
	end

	return v8:GetPositionFromPercentage(p, p2)
end

function PathHandler.GetPathLineSegments(p: number, flag: boolean?, flag2: boolean?)
	local v7 = flag and flag2 and 2 or flag and 3 or flag2 and 4 or 1
	local v8 = v6[p]

	if not v8 then
		v8 = {}
		v6[p] = v8
	end

	if v8[v7] then
		return v8[v7]
	end

	local v9 = {}
	local v10 = v[p]

	if not v10 then
		warn("No spawn nodes found for team index " .. p)
		return {}
	end

	for i, v11 in ipairs(v10) do
		if not ((flag or not v11:GetIsBossSpawn()) and (flag2 or not v11:GetIsCustomPath())) then
			continue
		end

		local nextNode = v11:GetNext(i)

		while nextNode do
			local x = v11.Position.X
			local z = v11.Position.Z
			local x2 = nextNode.Position.X
			local z2 = nextNode.Position.Z
			table.insert(v9, {
				Start = v11.Position,
				StartIsPathEnd = v11:IsStart(),
				End = nextNode.Position,
				EndIsPathEnd = nextNode:IsEnd(),
				XZLength = math.sqrt((x2 - x) ^ 2 + (z2 - z) ^ 2),
				Length = (nextNode.Position - v11.Position).Magnitude,
				PathIndex = i
			})
			local nextNode2 = nextNode:GetNext(i)

			if v11:GetIsLoop() then
				break
			end

			v11 = nextNode
			nextNode = nextNode2
		end
	end

	v8[v7] = v9
	return v8[v7]
end

function PathHandler.GetSpawnNodes(p: number?)
	if p then
		return v[p]
	end

	local result2 = {}

	for _, v7 in pairs(v) do
		for _, v8 in pairs(v7) do
			table.insert(result2, v8)
		end
	end

	return result2
end

function PathHandler.ToggleSpawnIndex(p: number, p2: number?, flag: boolean)
	if p2 then
		local spawn = PathHandler.GetSpawn(p, p2)

		if spawn then
			spawn:SetIsDisabled(not flag)
		else
			warn("Spawn node not found for spawn index " .. p)
		end
	else
		for _, v7 in pairs(v) do
			local v8 = v7[p]

			if v8 then
				v8:SetIsDisabled(not flag)
			else
				warn("Spawn node not found for spawn index " .. p)
			end
		end
	end

	GenerateSpawnIndices()
end

function PathHandler.Initialize()
	v = {}
	v2 = {}
	v3 = {}
	v4 = {}
	v5 = {}
	v6 = {}
	Analyzer.Analyze()
	v = Analyzer.GetTeamIndexToSpawnNodes()
	v2 = Analyzer.GetTeamIndexToEndNodes()
	GenerateSpawnIndices()
end

return PathHandler