local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Network = require(game.ReplicatedFirst.Client.Network)
local ScalingHandler = require(game.ReplicatedStorage.TDX_Shared.Common.ScalingHandler)
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local udim = UDim2.new(0.5, 0, 0.5, 0)
local tweenInfo = TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local Sidebar = { ClassName = script.Name, ClassModule = script }
Sidebar.__index = Sidebar

function Sidebar.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), List = {} }, Sidebar))
end

function Sidebar:Init()
	for _, button in ipairs(self.Root:GetChildren()) do
		if not button:IsA("ImageButton") then
			continue
		end

		local child = self.Root.Parent:FindFirstChild(button.Name)

		if not child then
			continue
		end

		self.List[button.Name] = child
		local v = button
		self.Cleaner:Add(button.Activated:Connect(function()
			self:ShowFrame(v.Name)
		end))
	end

	if Network.Invoke("ClientShouldPromptUpdateLog") then
		self:ShowFrame("Announcements")
	end
end

function Sidebar.AddFrame(p, p2: string, p3)
	p.List[p2] = p3
end

function Sidebar.IsFrameVisible(p, p2: string)
	return p.List[p2] ~= nil and p.List[p2].Visible
end

function Sidebar:ShowFrame(p, p2)
	for _, v in Director.GetItemsFromClass(Director.Classes.CrateSpin) do
		if v.Unboxing then
			return
		end
	end

	local v = false

	for _, v2 in self.List do
		if not v2.Visible then
			continue
		end

		v = true
		break
	end

	for k, v2 in pairs(self.List) do
		local visible = p == k and not v2.Visible

		if not visible then
			if p2 then
				visible = p2[k] or false
			else
				visible = false
			end
		end

		v2.Visible = visible

		if not v2.Visible or v then
			continue
		end

		local v3 = not v2:GetAttribute("NoScaling") and ScalingHandler.HasScaleData(v2)
		local defaultPosition = v2:GetAttribute("DefaultPosition")
			or v3 and ScalingHandler.GetPositionForElement(v2)
			or udim
		v2.Position = defaultPosition + UDim2.new(0, 0, 0.05, 0)
		TweenService:Create(v2, tweenInfo, { Position = defaultPosition }):Play()
	end
end

function Sidebar.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { Sidebar }, PlayerGui)
return Sidebar