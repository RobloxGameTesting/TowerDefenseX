local v = {
	Number = "number",
	Boolean = "boolean",
	CFrame = "CFrame",
	Color3 = "Color3",
	Vector2 = "Vector2",
	Vector3 = "Vector3",
	ColorSequence = "ColorSequence",
	NumberSequence = "NumberSequence",
	NumberRange = "NumberRange"
}
local InstanceControlUtilities = { PROPERTY_TYPES = v, TweenFunctions = {} }

function InstanceControlUtilities.TweenFunctions.Discrete(p, p2, p3: number)
	if p3 >= 1 then
		return p2
	end

	return p
end

function InstanceControlUtilities.TweenFunctions.Number(p, p2, p3: number)
	return p + (p2 - p) * p3
end

function InstanceControlUtilities.TweenFunctions:Lerp(p, p2: number)
	return self:Lerp(p, p2)
end

function InstanceControlUtilities.TweenFunctions.LerpColorSequence(sequence, sequence2, p: number)
	local value = sequence.Keypoints[1].Value
	local value2 = sequence2.Keypoints[1].Value
	return ColorSequence.new(value:Lerp(value2, p))
end

function InstanceControlUtilities.TweenFunctions.LerpNumberSeqeunce(sequence, sequence2, p: number)
	local value = sequence.Keypoints[1].Value
	local value2 = sequence2.Keypoints[1].Value
	return NumberSequence.new(value + (value2 - value) * p)
end

function InstanceControlUtilities.TweenFunctions.LerpNumberRange(range: NumberRange, range2: NumberRange, p: number)
	local min = range.Min
	local v2 = min + (range2.Min - min) * p
	return NumberRange.new(v2, v2)
end

InstanceControlUtilities.PropertyToLerpFunction = {
	[v.Number] = InstanceControlUtilities.TweenFunctions.Number,
	[v.Boolean] = InstanceControlUtilities.TweenFunctions.Discrete,
	[v.CFrame] = InstanceControlUtilities.TweenFunctions.Lerp,
	[v.Color3] = InstanceControlUtilities.TweenFunctions.Lerp,
	[v.Vector2] = InstanceControlUtilities.TweenFunctions.Lerp,
	[v.Vector3] = InstanceControlUtilities.TweenFunctions.Lerp,
	[v.ColorSequence] = InstanceControlUtilities.TweenFunctions.LerpColorSequence,
	[v.NumberSequence] = InstanceControlUtilities.TweenFunctions.LerpNumberSeqeunce,
	[v.NumberRange] = InstanceControlUtilities.TweenFunctions.LerpNumberRange
}
local v2 = {
	JointInstance = {
		C0 = { Type = v.CFrame },
		C1 = { Type = v.CFrame }
	},
	Weld = { _Inherits = "JointInstance" },
	Motor6D = { _Inherits = "JointInstance" },
	BasePart = {
		CFrame = { Type = v.CFrame },
		Size = { Type = v.Vector3 },
		Color = { Type = v.Color3 },
		Transparency = { Type = v.Number }
	},
	MeshPart = { _Inherits = "BasePart" },
	Light = {
		Enabled = { Type = v.Boolean, Default = true },
		Brightness = { Type = v.Number },
		Color = { Type = v.Color3 }
	},
	PointLight = {
		_Inherits = "Light",
		Range = { Type = v.Number }
	},
	SpotLight = {
		_Inherits = "Light",
		Range = { Type = v.Number }
	},
	SurfaceLight = {
		_Inherits = "Light",
		Range = { Type = v.Number }
	},
	ParticleEmitter = {
		Enabled = { Type = v.Boolean, Default = true },
		Size = { Type = v.NumberSequence },
		Color = { Type = v.ColorSequence },
		Transparency = { Type = v.NumberSequence },
		Speed = { Type = v.NumberRange },
		Squash = { Type = v.NumberSequence },
		Emit = {
			Type = v.Number,
			CustomFunction = function(instance, p: number)
				instance:Emit(p or instance:GetAttribute("EmitCount") or instance.Rate)
			end
		},
		Clear = {
			Type = v.Boolean,
			CustomFunction = function(object)
				object:Clear()
			end
		}
	}
}

for _, v3 in pairs(v2) do
	local inherits = v3._Inherits

	if not inherits then
		continue
	end

	local v4 = v2[inherits]

	for k, v5 in pairs(v4) do
		if k == "_Inherits" or v3[k] then
			continue
		end

		v3[k] = v5
	end
end

function InstanceControlUtilities.GetInstanceTypeData(p: string, p2: string)
	if v2[p] then
		local v3 = v2[p][p2]

		if v3 then
			return v3
		else
			warn("Not implemented: data for", p, p2)
		end
	else
		warn("Not implemented: data for", p)
	end

	return nil
end

return InstanceControlUtilities