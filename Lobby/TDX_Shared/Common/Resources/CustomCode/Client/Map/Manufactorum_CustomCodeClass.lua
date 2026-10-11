local createVector = vector.create
local ManufactorumCustomCodeClass = {}
ManufactorumCustomCodeClass.__index = ManufactorumCustomCodeClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("CustomCodeTypes"))
require(common:WaitForChild("MapTypes"))
require(common:WaitForChild("WrapperFactory"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local LightAnimationHandlerClass = require(common:WaitForChild("LightAnimationHandlerClass"))
local PreloadHandler = require(common:WaitForChild("PreloadHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local v = CFrame.new(17.627, 56.045, 17.898) * CFrame.Angles(0, 1.5707963267948966, 0)
local v2 = nil
local event = BindableHandler.GetEvent("NewVisualEffectBindable")
local event2 = BindableHandler.GetEvent("EasterEngineerStart")
local v3 = 1
local miscResource = ResourceManager.GetMiscResource("Easter Engineer Env", true)
local v4 = nil
local v5 = nil

local function CleanUpEngineerEnvModel() -- 1 equivalent call inferred from this helper
	if v4 then
		v4:Destroy()
		v4 = nil
	end

	v5 = nil
end

local function NewEngineerEnvModel(flag: boolean?)
	CleanUpEngineerEnvModel() -- inferred equivalent call
	local clone = miscResource:Clone()
	clone:PivotTo(v)
	clone.Parent = raycastIgnore
	v5 = LightAnimationHandlerClass.New(clone, v3)

	if flag then
		v5:Play("Spawn")
	else
		v5:Play("Idle")
	end

	v5:SetTrackFinishedCallback("Teleport", function()
		event2:Fire()
		event:Fire(Enums.VisualEffects.EasterEngineerTeleport, v.Position + createVector(0, 4, 0))

		if v4 then
			v4:Destroy()
			v4 = nil
		end

		v5 = nil
	end)
	v4 = clone
end

function ManufactorumCustomCodeClass.New()
	return (setmetatable({}, ManufactorumCustomCodeClass))
end

function ManufactorumCustomCodeClass.OnLoaded(_, _, _, p: number)
	v3 = p
	PreloadHandler.PreloadCharacterModel(miscResource)

	if not v2 then
		v2 = NetworkingHandler.GetEvent("ManufactorumEngineerSpawn")
		v2:AttachCallback(function(flag: boolean?, flag2: boolean?, flag3: boolean?)
			if flag then
				if v4 then
					v4:Destroy()
					v4 = nil
				end
			elseif not flag3 then
				NewEngineerEnvModel(flag2)
			elseif v5 then
				v5:Play("Teleport")
				event:Fire(Enums.VisualEffects.EasterEngineerTeleportStart, v.Position)
			end
		end)
	end
end

function ManufactorumCustomCodeClass.ClientTick(_, _: number) end

function ManufactorumCustomCodeClass.SpeedMultiplierChanged(_, p: number)
	v3 = p

	if v5 then
		v5:SetSpeedMultiplier(p)
	end
end

return ManufactorumCustomCodeClass