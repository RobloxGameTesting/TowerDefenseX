local createVector = vector.create
local Analyzer = {}
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Utilities = require(common:WaitForChild("Utilities"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local NodeClass = require(script.Parent:WaitForChild("NodeClass"))
RunService:IsServer()
local result = {}
local result2 = {}
local v = false

local function SortUnsortedParts(nodeParts, list, p: string)
	for i = 1, #nodeParts do
		local v2 = nil

		for _, v3 in ipairs(nodeParts) do
			if not (i == 1 and v3.Name == p or v3.Name == p .. i) then
				continue
			end

			v2 = v3
			break
		end

		if not v2 then
			error(p .. i .. " not found")
		end

		table.insert(list, v2)
	end
end

function Analyzer.Analyze()
	local nodesDataTable = MapHandler.GetNodesDataTable()
	local overrideActiveSpawns = MapHandler.GetOverrideActiveSpawns()
	result = {}
	result2 = {}
	v = false

	for k, v2 in pairs(nodesDataTable) do
		local nodeParts = {}
		local nodeParts2 = {}
		local v3 = {}
		local v4 = {}
		local v5 = {}
		local v6 = {}

		for _, nodePart in pairs(v2.NodeParts) do
			if Utilities.StringStartsWith(nodePart.Name, "End") then
				table.insert(nodeParts, nodePart)
			elseif Utilities.StringStartsWith(nodePart.Name, "Spawn") then
				table.insert(nodeParts2, nodePart)
			end

			nodePart:SetAttribute("PVPTeamIndex", v2.PVPTeamIndex)
		end

		SortUnsortedParts(nodeParts2, v3, "Spawn")
		SortUnsortedParts(nodeParts, v4, "End")
		assert(#v3 > 0, "No spawns found")
		assert(#v4 > 0, "No ends found")
		local v7 = {}

		for _, v8 in ipairs(v4) do
			local v9 = NodeClass.New(v8, true)
			v7[v8] = v9
			table.insert(v5, v9)
		end

		for i, v8 in ipairs(v3) do
			local v9 = NodeClass.New(v8, false, true, i)
			Utilities.NewRandomColor()
			local v10 = v9
			local v11 = v8
			local count = 0
			local total = 0
			local v12 = {}

			while true do
				local v13 = v11:FindFirstChild("Next" .. i) or v11:FindFirstChild("Next")

				if count > 10000 then
					warn("Cycle in path detected while searching for path for " .. v8.Name)
					break
				end

				if v13 then
					local value = v13.Value

					if value then
						local v14 = v7[value] or NodeClass.New(value)
						v10:SetNext(i, v14)
						v14:SetPrevious(i, v10)
						v10:SetDistanceAlongPath(i, total)
						total += v10:DistanceTo(v14)
						table.insert(v12, v10)
						v7[v11] = v10
						count += 1

						if v10:GetIsLoop() then
							break
						end

						v10 = v14
						v11 = value
					else
						warn("Next part not found for " .. v11:GetFullName())
						local partAtPosition = Utilities.PartAtPosition(v11.Position, "Bright red", true)
						partAtPosition.Size = createVector(0.05, 10, 0.05)
						break
					end
				else
					if not Utilities.StringStartsWith(v11.Name, "End") then
						warn("End not reachable from " .. v8.Name)
					end

					local v14 = v7[v11]
					v14:SetDistanceAlongPath(i, total)
					table.insert(v12, v14)
					break
				end
			end

			for _, v13 in pairs(v12) do
				v13:SetTotalPathLength(i, total)
				v13:CalculatePercentageAlongPath(i, total)
			end

			if not overrideActiveSpawns or table.find(overrideActiveSpawns, i) then
				table.insert(v6, v9)
			end
		end

		for _, nodePart in pairs(v2.NodeParts) do
			if v7[nodePart] then
				continue
			end

			warn("Unused node: " .. nodePart.Name)
			local partAtPosition = Utilities.PartAtPosition(nodePart.Position, "Pearl", true)
			partAtPosition.Size = createVector(0.05, 10, 0.05)
		end

		result[k] = v6
		result2[k] = v5
	end

	v = true
end

function Analyzer.GetTeamIndexToSpawnNodes()
	if not v then
		warn("Path analysis has not been run")
	end

	return result
end

function Analyzer.GetTeamIndexToEndNodes()
	if not v then
		warn("Path analysis has not been run")
	end

	return result2
end

return Analyzer