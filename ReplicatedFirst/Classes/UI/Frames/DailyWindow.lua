local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Lang = require(TDX_Shared.Modules.Lang)
local Util = require(TDX_Shared.Modules.Util)
local Data = require(TDX_Shared.Client.Services.Data)
local Network = require(ReplicatedFirst.Client.Network)
local tweenInfo = TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local LocalPlayer = Players.LocalPlayer
local DailyWindow = { ClassName = script.Name, ClassModule = script }
DailyWindow.__index = DailyWindow

function DailyWindow.new(root)
	return (setmetatable(
		{ Root = root, Cleaner = Cleaner.new(), AlreadySetRewards = false, Claimed = false },
		DailyWindow
	))
end

function DailyWindow:Update()
	local canClaimDailyReward = LocalPlayer:GetAttribute("CanClaimDailyReward")
	local v

	if self.Root.Visible == false then
		v = canClaimDailyReward
	else
		v = false
	end

	if v then
		self.Root.Position = UDim2.new(0.5, 0, 0.55, 0)
		TweenService:Create(self.Root, tweenInfo, { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
	end

	self.Root.day.Text = Lang.Get(Lang.Strings.General.DayStreak, (Data.Get("DailyStreak") or 0) + 1)
	self.Root.Visible = canClaimDailyReward
end

function DailyWindow:SetRewards()
	if self.AlreadySetRewards then
		return
	end

	self.AlreadySetRewards = true
	local dailyStreak = Data.Get("DailyStreak")

	for i = 1, 6 do
		local v = dailyStreak + i
		local dailyReward = Util.GetDailyReward(Data.Get("DailySeed"), v)
		local child = self.Root.items.Frame:FindFirstChild(i)

		if not child then
			continue
		end

		local day = child:FindFirstChild("day")
		local amount = child:FindFirstChild("amount")
		day.Text = Lang.Get(Lang.Strings.General.Day, v)
		local kind = dailyReward.Type
		local text = tostring(dailyReward.Value)

		if kind == "Gold" then
			text = "$" .. text
		end

		amount.Text = text
		local child2 = child:FindFirstChild(kind)

		if child2 then
			child2.Visible = true
		end

		local background = child:FindFirstChild("Background")

		if i == 1 then
			continue
		end

		day.TextColor3 = Color3.fromRGB(150, 150, 150)
		amount.TextColor3 = Color3.fromRGB(150, 150, 150)
		background.ImageColor3 = Color3.fromRGB(116, 116, 116)

		if child2 then
			child2.ImageTransparency = 0.3
		end
	end
end

function DailyWindow:Init()
	local template = self.Root.items.Frame:FindFirstChild("Template")

	for i = 1, 6 do
		local clone = template:Clone()
		clone.Name = tostring(i)
		clone.Parent = self.Root.items.Frame
	end

	template:Destroy()
	self.Cleaner:Add(LocalPlayer:GetAttributeChangedSignal("CanClaimDailyReward"):Connect(function()
		self:Update()
	end))
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "DailySeed" then
			self:SetRewards()
		end
	end))
	self.Cleaner:Add(self.Root.claim.Activated:Connect(function()
		if Network.Invoke("DailyRewardClaim") and not self.Claimed then
			self.Claimed = true
			self.Root.Visible = false
			SoundHandler.Play("DailyLogin")
		end
	end))
	self:SetRewards()
	self:Update()
end

function DailyWindow:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { DailyWindow }, LocalPlayer)
return DailyWindow