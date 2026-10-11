local function GetPosePathMap(p) -- 1 equivalent call inferred from this helper
	local posesByName = {}
	local function Walk(instance, p2: string)
		for _, pose in pairs(instance:GetChildren()) do
			if not pose:IsA("Pose") then
				continue
			end

			local name = p2 == "" and pose.Name or p2 .. "/" .. pose.Name
			posesByName[name] = pose
			Walk(pose, name)
		end
	end

	Walk(p, "")
	return posesByName
end

local function EnsurePoseAtPath(parent, value: string)
	for k in string.gmatch(value, "[^/]+") do
		local v = nil

		for _, pose in pairs(parent:GetChildren()) do
			if not (pose:IsA("Pose") and pose.Name == k) then
				continue
			end

			v = pose
			break
		end

		if not v then
			v = Instance.new("Pose")
			v.Name = k
			v.Weight = 0
			v.Parent = parent
		end

		parent = v
	end

	return parent
end

local function CFramesEqual(cframe: CFrame, cframe2: CFrame) -- 1 equivalent call inferred from this helper
	return (cframe.Position - cframe2.Position).Magnitude < 0.00001
		and (cframe.XVector - cframe2.XVector).Magnitude < 0.00001
		and (cframe.YVector - cframe2.YVector).Magnitude < 0.00001
		and (cframe.ZVector - cframe2.ZVector).Magnitude < 0.00001
end

local function PruneEmptyPoses(instance)
	local total = 0

	for _, pose in pairs(instance:GetChildren()) do
		if not pose:IsA("Pose") then
			continue
		end

		total += PruneEmptyPoses(pose)

		if not (pose.Weight <= 0) or pose:FindFirstChildWhichIsA("Pose") then
			continue
		end

		pose:Destroy()
		total += 1
	end

	return total
end

local function GetSortedKeyframes(instance)
	local keyframes = {}

	for _, keyframe in pairs(instance:GetChildren()) do
		if keyframe:IsA("Keyframe") then
			table.insert(keyframes, keyframe)
		end
	end

	table.sort(keyframes, function(a, b)
		return a.Time < b.Time
	end)
	return keyframes
end

local total = 0
local total2 = 0
local total3 = 0
local total4 = 0

for _, keyframeSequence in pairs(game.Selection:Get()) do
	local keyframeSequences = keyframeSequence:IsA("KeyframeSequence") and ({ keyframeSequence } or {}) or {}

	for _, keyframeSequence2 in pairs(keyframeSequence:GetDescendants()) do
		if keyframeSequence2:IsA("KeyframeSequence") then
			table.insert(keyframeSequences, keyframeSequence2)
		end
	end

	for _, parent in pairs(keyframeSequences) do
		local sortedKeyframes = GetSortedKeyframes(parent)
		local v = {}

		for i in ipairs(sortedKeyframes) do
			local posesByName = {}
			local function Walk(instance, p: string)
				for _, pose in pairs(instance:GetChildren()) do
					if not pose:IsA("Pose") then
						continue
					end

					local name = p == "" and pose.Name or p .. "/" .. pose.Name
					posesByName[name] = pose
					Walk(pose, name)
				end
			end

			Walk(sortedKeyframes[i], "")
			v[i] = posesByName
		end

		local count = 0
		local v2 = {}
		local count2 = 0

		for i, v3 in ipairs(sortedKeyframes) do
			for k, v4 in pairs(v[i]) do
				if v4.EasingStyle ~= Enum.PoseEasingStyle.Constant then
					continue
				end

				v4.EasingStyle = Enum.PoseEasingStyle.Linear
				count += 1
				local v5 = nil
				local time = nil

				for j = i - 1, 1, -1 do
					local v6 = v[j][k]

					if not (v6 and v6.Weight > 0) then
						continue
					end

					time = sortedKeyframes[j].Time
					v5 = v6
					break
				end

				if not v5 then
					continue
				end

				local time2 = v3.Time - 1 / 60

				if time2 <= time then
					continue
				end

				local v6 = v2[time2]

				if not v6 then
					for _, v7 in ipairs(sortedKeyframes) do
						if v7.Time ~= time2 then
							continue
						end

						v6 = v7
						break
					end
				end

				if not v6 then
					v6 = Instance.new("Keyframe")
					v6.Name = "ConstantHold"
					v6.Time = time2
					v6.Parent = parent
				end

				v2[time2] = v6
				local poseAtPath = EnsurePoseAtPath(v6, k)
				poseAtPath.CFrame = v5.CFrame
				poseAtPath.Weight = v5.Weight
				poseAtPath.EasingStyle = Enum.PoseEasingStyle.Linear
				count2 += 1
			end
		end

		local sortedKeyframes2 = GetSortedKeyframes(parent)
		local v3 = {}

		for _, v4 in ipairs(sortedKeyframes2) do
			local posePathMap = GetPosePathMap(v4) -- inferred equivalent call

			for k, v5 in pairs(posePathMap) do
				if not (v5.Weight > 0) then
					continue
				end

				v3[k] = v3[k] or {}
				table.insert(v3[k], v5)
			end
		end

		local count3 = 0

		for _, v4 in pairs(v3) do
			local v5 = 1

			for i = 2, #v4 + 1 do
				if not (#v4 < i) and CFramesEqual(v4[i].CFrame, v4[v5].CFrame) then -- inferred equivalent call
					continue
				end

				for j = v5 + 1, i - 2 do
					v4[j].Weight = 0
					count3 += 1
				end

				v5 = i
			end
		end

		local time = sortedKeyframes2[1] and sortedKeyframes2[1].Time
		local time2 = sortedKeyframes2[#sortedKeyframes2] and sortedKeyframes2[#sortedKeyframes2].Time
		local count4 = 0

		for _, v4 in ipairs(sortedKeyframes2) do
			PruneEmptyPoses(v4)

			if not (v4.Time ~= time and v4.Time ~= time2 and v4.Name == "Keyframe") then
				continue
			end

			if v4:FindFirstChildWhichIsA("Pose") or v4:FindFirstChildWhichIsA("KeyframeMarker", true) then
				continue
			end

			v4:Destroy()
			count4 += 1
		end

		total += count
		total2 += count2
		total3 += count3
		total4 += count4
		print(parent:GetFullName() .. ": converted " .. count .. " Constant poses (" .. count2 .. " holds inserted), removed " .. count3 .. " redundant poses and " .. count4 .. " keyframes")
	end
end

print("---------------------------------------------")
print("Constant poses converted to Linear: " .. total .. " (" .. total2 .. " hold keys inserted)")
print("Keyframes removed by optimization: " .. total4 .. " (" .. total3 .. " redundant poses)")