local CameraHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Enums = require(common:WaitForChild("Enums"))
require(common:WaitForChild("WaveTypes"))
require(common:WaitForChild("NetworkingHandler"))
require(common:WaitForChild("ResourceManager"))
require(common:WaitForChild("Utilities"))
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = workspace.CurrentCamera
local v = nil
local clones = {}
local v2 = nil
local connections = {}

function CameraHandler.SetCutscene(instance)
	local camera = instance:FindFirstChild("Camera")

	if not camera then
		return
	end

	if instance:GetAttribute("CameraFieldOfView") then
		CurrentCamera.FieldOfView = instance:GetAttribute("CameraFieldOfView")
	else
		CurrentCamera.FieldOfView = 70
	end

	local cameraEffects = instance:FindFirstChild("CameraEffects")

	if cameraEffects then
		for _, child in ipairs(cameraEffects:GetChildren()) do
			local clone = child:Clone()
			clone.Parent = Lighting
			table.insert(clones, clone)
		end
	end

	CurrentCamera.CameraType = Enum.CameraType.Scriptable
	v = camera
end

function CameraHandler.SetFOV(fieldOfView: number)
	CurrentCamera.FieldOfView = fieldOfView
end

local function SetCameraSubjectToCharacter()
	local v3 = v2 or LocalPlayer
	local character = v3.Character or v3.CharacterAdded:Wait()
	local humanoid = character:FindFirstChildOfClass("Humanoid") or character:WaitForChild("Humanoid", 10)

	if not humanoid then
		warn("CameraHandler: character has no Humanoid to use as the camera subject")
		return
	end

	if v3 ~= (v2 or LocalPlayer) then
		return
	end

	if CurrentCamera.CameraType == Enum.CameraType.Custom then
		CurrentCamera.CameraSubject = humanoid
	end
end

function CameraHandler.SetFollowedPlayer(p)
	for _, connection in ipairs(connections) do
		connection:Disconnect()
	end

	connections = {}
	v2 = p

	if p then
		for _, v3 in ipairs({ p, LocalPlayer }) do
			table.insert(connections, v3.CharacterAdded:Connect(function()
				task.defer(SetCameraSubjectToCharacter)
			end))
		end
	end

	task.spawn(SetCameraSubjectToCharacter)
end

function CameraHandler.GetFollowedPlayer()
	return v2
end

function CameraHandler.Reset()
	CurrentCamera.CameraType = Enum.CameraType.Custom
	CurrentCamera.FieldOfView = 70
	task.spawn(SetCameraSubjectToCharacter)
	v = nil

	for _, v3 in ipairs(clones) do
		v3:Destroy()
	end

	clones = {}
end

function CameraHandler.SetState(p: string)
	if p ~= Enums.GameStates.Cutscene then
		CameraHandler.Reset()
	end
end

RunService:BindToRenderStep("CameraHandler", Enum.RenderPriority.Camera.Value, function(_: number)
	if v then
		CurrentCamera.CFrame = v.CFrame
		CurrentCamera.Focus = v.CFrame
	end
end)
return CameraHandler