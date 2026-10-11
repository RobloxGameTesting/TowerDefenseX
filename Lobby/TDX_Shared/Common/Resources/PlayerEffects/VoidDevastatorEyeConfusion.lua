local createVector = vector.create
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local color = Color3.fromRGB(162, 115, 255)
local LocalPlayer = Players.LocalPlayer
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local count = 0
local VoidDevastatorEyeConfusion = {}

function VoidDevastatorEyeConfusion.Start(state)
	if not state.IsLocalPlayerTargeted then
		return
	end

	local parameters = state.Parameters
	local tintColor = parameters.TintColor or color
	local contrast = parameters.Contrast or 3
	local brightness = parameters.Brightness or 0
	local saturation = parameters.Saturation or -0.4
	local fadeTime = parameters.FadeTime or 3
	local shakeIntensity = parameters.ShakeIntensity or 1.2
	local state2 = {}
	state.State = state2
	local colorCorrectionEffect = Instance.new("ColorCorrectionEffect")
	colorCorrectionEffect.Name = "VoidDevastatorEyeConfusion"
	colorCorrectionEffect.TintColor = Color3.new(1, 1, 1)
	colorCorrectionEffect.Parent = Lighting
	state2.ColorCorrection = colorCorrectionEffect
	TweenService:Create(colorCorrectionEffect, TweenInfo.new(fadeTime), {
		TintColor = tintColor,
		Contrast = contrast,
		Brightness = brightness,
		Saturation = saturation
	}):Play()
	local part = Instance.new("Part")
	part.Name = "VoidDevastatorEyeConfusionStatic"
	part.Transparency = 1
	part.Anchored = true
	part.CanCollide = false
	part.CanQuery = false
	part.CanTouch = false
	part.CastShadow = false
	part.Parent = raycastIgnore
	state2.StaticPart = part
	local miscResource = ResourceManager.GetMiscResource("VideoTapeStaticEffectGUI")
	miscResource.Face = Enum.NormalId.Back
	miscResource.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	miscResource.LightInfluence = 0
	miscResource.Adornee = part
	miscResource.Parent = LocalPlayer:WaitForChild("PlayerGui")
	state2.StaticGui = miscResource
	count += 1
	local formatted = `VoidDevastatorEyeConfusionStatic{count}`
	state2.RenderStepName = formatted
	RunService:BindToRenderStep(formatted, Enum.RenderPriority.Camera.Value + 1, function()
		local currentCamera = workspace.CurrentCamera
		local viewportSize = currentCamera.ViewportSize
		local v = math.tan((math.rad(currentCamera.FieldOfView / 2))) * 2 * 0.101
		local v2 = viewportSize.X / viewportSize.Y * v
		part.Size = Vector3.new(v2, v, 0.101)
		part.CFrame = currentCamera.CFrame * CFrame.new(0, 0, -(0.101 + part.Size.Z / 2))
		miscResource.PixelsPerStud = viewportSize.X / v2
	end)
	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChildOfClass("Humanoid")
	state2.Humanoid = humanoid

	if humanoid then
		state2.Connection = RunService.Heartbeat:Connect(function()
			humanoid.CameraOffset = Vector3.new(math.random() - 0.5, math.random() - 0.5, math.random() - 0.5) * shakeIntensity
		end)
	end
end

function VoidDevastatorEyeConfusion.Stop(state)
	local state2 = state.State

	if not state2 then
		return
	end

	state.State = nil

	if state2.Connection then
		state2.Connection:Disconnect()
	end

	if state2.Humanoid then
		state2.Humanoid.CameraOffset = createVector(0, 0, 0)
	end

	local fadeTime = state.Parameters.FadeTime or 3
	local staticGui = state2.StaticGui
	local staticPart = state2.StaticPart
	local renderStepName = state2.RenderStepName

	local function DestroyStatic() -- 1 equivalent call inferred from this helper
		if renderStepName then
			RunService:UnbindFromRenderStep(renderStepName)
		end

		if staticGui then
			staticGui:Destroy()
		end

		if staticPart then
			staticPart:Destroy()
		end
	end

	local count2 = 0

	if staticGui and fadeTime > 0 then
		local tweenInfo = TweenInfo.new(fadeTime)

		for _, image in staticGui:GetDescendants() do
			if not image:IsA("ImageLabel") then
				continue
			end

			count2 += 1
			TweenService:Create(image, tweenInfo, { ImageTransparency = 1 }):Play()
		end
	end

	if count2 > 0 then
		task.delay(fadeTime, DestroyStatic)
	else
		DestroyStatic() -- inferred equivalent call
	end

	local colorCorrection = state2.ColorCorrection

	if colorCorrection then
		local tween = TweenService:Create(colorCorrection, TweenInfo.new(fadeTime), {
			TintColor = Color3.new(1, 1, 1),
			Contrast = 0,
			Brightness = 0,
			Saturation = 0
		})
		tween.Completed:Once(function()
			colorCorrection:Destroy()
		end)
		tween:Play()
	end
end

return VoidDevastatorEyeConfusion