local VisualEffectHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local HashGeneratorClass = require(common:WaitForChild("HashGeneratorClass"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local EntityUtilities = require(common:WaitForChild("EntityUtilities"))
local ProjectileUtilities = require(common:WaitForChild("ProjectileUtilities"))
local VisualEffectClass = require(script:WaitForChild("VisualEffectClass"))
local event = NetworkingHandler.GetEvent("NewVisualEffect")
local event2 = NetworkingHandler.GetEvent("ClearVisualEffects")
local event3 = BindableHandler.GetEvent("NewVisualEffectBindable")
local v = HashGeneratorClass.New()
local v2 = {}
local v3 = 0
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER

function VisualEffectHandler.NewVisualEffect(p)
	local v4 = v:Get()
	local v5 = VisualEffectClass.New(v4, p, DEFAULT_SPEED_MULTIPLIER)
	v2[v4] = v5
	v3 += 1
	return v5
end

function VisualEffectHandler.HandleVisualEffectOnEntity(object, items)
	for _, item in pairs(items) do
		local name = item[1]
		local v4 = item[2]
		local v5 = item[3]
		local v6 = item[4]
		local v7 = item[5]
		local delay = item[6]
		local effectFollowPart = EntityUtilities.GetEffectFollowPart(object, v4, v5)
		local v8

		if object:GetCharacterModel():GetAttribute("TargetTorsoBounds") then
			v8 = EntityUtilities.GetPointOnPartBounds(
				effectFollowPart.Position + Vector3.new(
					math.random(-100, 100),
					math.random(-100, 100),
					math.random(-100, 100)
				),
				effectFollowPart
			)
		end

		local v9 = {
			Name = name,
			Position = ProjectileUtilities.RandomOffsetPosition(v8 or effectFollowPart.Position, v6, v7),
			Delay = delay
		}
		VisualEffectHandler.NewVisualEffect(v9)
	end
end

local function IsVisualEffectCorrupted(p) -- 1 equivalent call inferred from this helper
	return type(p.TimeLeft) ~= "number" or type(p.TimeLeftUntilRemove) ~= "number"
end

local function RemoveCorruptedVisualEffect(k: number, data)
	warn(string.format(
		"Removing corrupted visual effect %s (TimeLeft: %s, TimeLeftUntilRemove: %s, IsContinuous: %s, PlayUntilManuallyStopped: %s, ManuallyStopped: %s, Started: %s, Done: %s, Destroyed: %s)",
		tostring(data.Name),
		tostring(data.TimeLeft),
		tostring(data.TimeLeftUntilRemove),
		tostring(data.IsContinuous),
		tostring(data.PlayUntilManuallyStopped),
		tostring(data.ManuallyStopped),
		tostring(data.Started),
		tostring(data.Done),
		(tostring(data.Destroyed))
	))
	v2[k] = nil
	v3 -= 1
	pcall(data.Destroy, data)
end

function VisualEffectHandler:Run()
	for k, v4 in pairs(v2) do
		if IsVisualEffectCorrupted(v4) then -- inferred equivalent call
			RemoveCorruptedVisualEffect(k, v4)
		else
			v4:Run(self)

			if v4:CanRemove() then
				v2[v4.Hash] = nil
				v3 -= 1
				v4:Destroy()
			end
		end
	end
end

function VisualEffectHandler.SetSpeedMultiplier(p: number)
	for _, v4 in pairs(v2) do
		v4:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

event:AttachCallback(function(name: string, vector: Vector3)
	VisualEffectHandler.NewVisualEffect({ Name = name, Position = vector })
end)
event2:AttachCallback(function()
	for _, v4 in pairs(v2) do
		v2[v4.Hash] = nil
		v3 -= 1
		v4:Destroy()
	end
end)
event3:AttachCallback(function(name: string, vector: Vector3)
	VisualEffectHandler.NewVisualEffect({ Name = name, Position = vector })
end)
return VisualEffectHandler