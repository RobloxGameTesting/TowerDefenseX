local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Utilities = require(common:WaitForChild("Utilities"))
local InstanceControlUtilities = require(script.Parent:WaitForChild("InstanceControlUtilities"))
local EasingFunctions = require(script.Parent:WaitForChild("EasingFunctions"))
local LocalPlayer = Players.LocalPlayer
local v = false
local v2 = 0

local function GetSortedRawFrameData(child)
	local children = {}

	for _, child2 in pairs(child:GetChildren()) do
		table.insert(children, child2)
	end

	table.sort(children, function(a, b)
		return (tonumber(a.Name) or -1) < (tonumber(b.Name) or -1)
	end)
	return children
end

local function GetValue(instance)
	local value = instance.Value

	if instance:FindFirstChild("ColorSequence") or instance.Parent:FindFirstChild("ColorSequence") then
		return (ColorSequence.new(value))
	end

	if instance:FindFirstChild("NumberSequence") or instance.Parent:FindFirstChild("NumberSequence") then
		value = NumberSequence.new(value)
	end

	return value
end

local function GetValueFromFrameData(instance) -- 2 equivalent calls inferred from this helper
	if instance.ClassName ~= "Folder" then
		return (GetValue(instance))
	end

	local values = instance:FindFirstChild("Values")
	local _0 = values and values:FindFirstChild("0")

	if _0 then
		return (GetValue(_0))
	end

	return nil
end

local function GetEaseDataFromFrameData(instance)
	local eases = instance:FindFirstChild("Eases")
	local _0 = eases and eases:FindFirstChild("0")
	local kind = _0 and _0:FindFirstChild("Type")
	local value = kind and kind.Value
	local linear

	if value then
		if value == "Constant" or value == "None" then
			return nil, nil
		else
			linear = Enum.EasingStyle[value]
		end
	else
		linear = Enum.EasingStyle.Linear
	end

	local params = _0 and _0:FindFirstChild("Params")
	local direction = params and params:FindFirstChild("Direction")

	if direction and direction.Value then
		return linear, Enum.EasingDirection[direction.Value]
	end

	return linear, Enum.EasingDirection.Out
end

local function GetLerpFunction(instance, p: string)
	local className = instance.ClassName
	local instanceTypeData = InstanceControlUtilities.GetInstanceTypeData(className, p)

	if not instanceTypeData then
		return nil
	end

	local kind = instanceTypeData.Type
	local v3 = InstanceControlUtilities.PropertyToLerpFunction[kind]

	if v3 then
		return v3
	end

	warn("GetPropertyNameToFrameData: No lerp function for", `{className}.{p}`, "of type", kind)
	return nil
end

local function GetEasingFunction(p, p2)
	if not p then
		return EasingFunctions.Constant
	end

	if p == Enum.EasingStyle.Linear then
		return EasingFunctions.Linear
	end

	local v3 = p.Name .. p2.Name
	local easingFunction = EasingFunctions[v3]

	if easingFunction then
		return easingFunction
	end

	warn("GetEasingFunction: No easing function called", v3, "defaulting to Linear")
	return EasingFunctions.Linear
end

local function GetPropertyNameToFrameData(child, instance)
	local result = {}

	for _, child2 in pairs(child:GetChildren()) do
		local className = instance.ClassName
		local name = child2.Name
		local instanceTypeData = InstanceControlUtilities.GetInstanceTypeData(className, name)
		local className2 = instance.ClassName
		local instanceTypeData2 = InstanceControlUtilities.GetInstanceTypeData(className2, name)
		local lerpFunction

		if instanceTypeData2 then
			local kind = instanceTypeData2.Type
			lerpFunction = InstanceControlUtilities.PropertyToLerpFunction[kind]

			if not lerpFunction then
				warn("GetPropertyNameToFrameData: No lerp function for", `{className2}.{name}`, "of type", kind)
				lerpFunction = nil
			end
		end

		if not lerpFunction then
			continue
		end

		local sortedRawFrameData = GetSortedRawFrameData(child2)
		local v3 = { EaseDataTable = {}, Default = nil }

		for i, v4 in ipairs(sortedRawFrameData) do
			if v4.Name == "Default" or v4.Name == "default" then
				if not instanceTypeData.CustomFunction then
					local default = GetValue(v4)
					v3.Default = default
					instance[name] = default
				end
			else
				local name2 = tonumber(v4.Name)

				if name2 then
					local default = GetValueFromFrameData(v4) -- inferred equivalent call

					if default == nil then
						default = v3.Default
					end

					if default == nil then
						default = instanceTypeData.Default
					end

					if default == nil then
						warn("GetPropertyNameToFrameData: Value nil for", name, "->", v4.Name)
					else
						local v5 = sortedRawFrameData[i + 1]
						local nextFrameNumber = not v5 and 1e999 or tonumber(v5.Name) or 1e999
						local nextValue

						if v5 then
							nextValue = GetValueFromFrameData(v5) or default -- inferred equivalent call
						else
							nextValue = default
						end

						local easeStyle, easeDirection = GetEaseDataFromFrameData(v4)
						local linear

						if easeStyle then
							if easeStyle == Enum.EasingStyle.Linear then
								linear = EasingFunctions.Linear
							else
								local v6 = easeStyle.Name .. easeDirection.Name
								linear = EasingFunctions[v6]

								if not linear then
									warn("GetEasingFunction: No easing function called", v6, "defaulting to Linear")
									linear = EasingFunctions.Linear
								end
							end
						else
							linear = EasingFunctions.Constant
						end

						local v6 = {
							FrameNumber = name2,
							Value = default,
							NextFrameNumber = nextFrameNumber,
							NextValue = nextValue,
							EaseStyle = easeStyle,
							EaseDirection = easeDirection,
							LerpFunction = lerpFunction,
							EasingFunction = linear,
							instanceTypeData.CustomFunction
						}
						table.insert(v3.EaseDataTable, v6)
					end
				else
					warn("GetPropertyNameToFrameData: Invalid frame number for", name, "->", v4.Name)
				end
			end
		end

		result[name] = v3
	end

	return result
end

local InstanceControlHandler = {}

function InstanceControlHandler.AnimationStarted(value: number?)
	v = true
	v2 = os.clock() - (value or 0)
end

function InstanceControlHandler.AnimationStopped()
	v = false
end

function InstanceControlHandler.NewInstanceControlDataTable(p, instance)
	local result = {}

	for _, child in pairs(instance:GetChildren()) do
		local targetInstance = Utilities.TryGetInstanceFromPath(p, child.Name)

		if targetInstance then
			table.insert(result, {
				TargetInstance = targetInstance,
				PropertyNameToFrameData = GetPropertyNameToFrameData(child, targetInstance)
			})
		else
			warn("NewInstanceControlDataTable: Could not find target instance for", child.Name)
		end
	end

	return result
end

function InstanceControlHandler.RunInstanceControlDataTable(items)
	if not v then
		return
	end

	local v3 = 60 * (os.clock() - v2)
	local v4 = math.floor(v3)

	for _, item in pairs(items) do
		local targetInstance = item.TargetInstance

		for k, v5 in pairs(item.PropertyNameToFrameData) do
			for _, v6 in ipairs(v5.EaseDataTable) do
				if v4 < v6.FrameNumber or v6.NextFrameNumber <= v4 then
					continue
				end

				if v6.CustomFunction then
					v6.CustomFunction(targetInstance, v6.Value)
				else
					local v7 = (v3 - v6.FrameNumber) / (v6.NextFrameNumber - v6.FrameNumber)
					targetInstance[k] = v6.LerpFunction(v6.Value, v6.NextValue, v6.EasingFunction(v7))
				end

				break
			end
		end
	end
end

return InstanceControlHandler