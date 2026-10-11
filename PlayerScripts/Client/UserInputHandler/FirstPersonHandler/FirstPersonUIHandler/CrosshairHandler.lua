local CrosshairHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
local Spring = require(common:WaitForChild("Spring"))
local FirstPersonUIUtilities = require(script.Parent:WaitForChild("FirstPersonUIUtilities"))
Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("FirstPersonInterface"):WaitForChild("FirstPersonScreen"):WaitForChild("Frames")
local v = nil
local guiObjects = nil
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = Spring.New(1)
local crosshairConfig = nil
local v7 = Spring.New(1)

function CrosshairHandler.SetTower(_, p)
	v4 = p
end

function CrosshairHandler.RemoveTower()
	v4 = nil
end

function CrosshairHandler.SwitchAttackHandler(p: number)
	v5 = v4.AttackConfigs[p]

	if not v5 then
		warn("CrosshairHandler.SwitchAttackHandler - Invalid attack handler index: " .. tostring(p))
	end

	crosshairConfig = v5.CrosshairConfig

	if crosshairConfig then
		v6.Speed = crosshairConfig.Speed
		v6.Damper = crosshairConfig.Damper
		v = FirstPersonUIUtilities.GetHitmarker()

		if v then
			v7.Speed = 10
			v7.Damper = 0.7
			guiObjects = {}

			for _, guiObject in pairs(v:GetChildren()) do
				if guiObject:IsA("Frame") or guiObject:IsA("ImageLabel") then
					table.insert(guiObjects, guiObject)
				end
			end
		else
			v = nil
			guiObjects = nil
		end

		v2 = FirstPersonUIUtilities.GetCrosshair()

		if v2 and #v2:GetChildren() > 0 then
			v3 = {
				v2:FindFirstChild("Right"),
				v2:FindFirstChild("Left"),
				v2:FindFirstChild("Down"),
				v2:FindFirstChild("Up")
			}
		else
			v3 = nil
		end
	else
		v = nil
		v2 = nil
		v3 = nil
	end
end

function CrosshairHandler.HitEnemy(p: number?)
	v7.Position = -3

	if v then
		for _, guiObject in pairs(guiObjects) do
			if guiObject:IsA("Frame") then
				guiObject.BackgroundColor3 = p ~= nil and Color3.fromRGB(255, 247, 12) or Color3.fromRGB(255, 255, 255)
			elseif guiObject:IsA("ImageLabel") then
				guiObject.ImageColor3 = p ~= nil and Color3.fromRGB(255, 247, 12) or Color3.fromRGB(255, 255, 255)
			end
		end
	end
end

function CrosshairHandler.GetPosition()
	if v2 then
		return Vector2.new(v2.AbsolutePosition.X + v2.AbsoluteSize.X / 2, v2.AbsolutePosition.Y + v2.AbsoluteSize.Y / 2)
	end

	local viewportSize = workspace.CurrentCamera.ViewportSize
	local guiInset = GuiService:GetGuiInset()
	return Vector2.new(viewportSize.X / 2, (viewportSize.Y - guiInset.Y) / 2)
end

function CrosshairHandler.GetCurrentSpreadFactor()
	return 10 * (v6.Position / v6.Target - 1)
end

function CrosshairHandler.ShotFired()
	if crosshairConfig then
		v6:Accelerate(crosshairConfig.Expansion)
	end
end

function CrosshairHandler.OnRenderStepped(_: number, _: number)
	local v8 = v6.Position / v6.Target

	if v3 then
		v3[1].Position = UDim2.new(v8, 0, 0.5, 0)
		v3[2].Position = UDim2.new(1 - v8, 0, 0.5, 0)
		v3[3].Position = UDim2.new(0.5, 0, v8, 0)
		v3[4].Position = UDim2.new(0.5, 0, 1 - v8, 0)
	end

	if v then
		for _, guiObject in pairs(guiObjects) do
			if guiObject:IsA("Frame") then
				guiObject.BackgroundTransparency = v7.Position
			elseif guiObject:IsA("ImageLabel") then
				guiObject.ImageTransparency = v7.Position
			end
		end
	end
end

function CrosshairHandler.SetSpeedMultiplier(speedMultiplier: number)
	v6.SpeedMultiplier = speedMultiplier
	v7.SpeedMultiplier = speedMultiplier
end

return CrosshairHandler