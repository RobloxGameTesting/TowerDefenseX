local GuiService = game:GetService("GuiService")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Network = require(ReplicatedFirst.Client.Network)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local SoundHandler = require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local now = tick()
local NightSelection = { ClassName = script.Name, ClassModule = script }
NightSelection.__index = NightSelection

function NightSelection.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), Elevator = nil }, NightSelection))
end

function NightSelection:Update()
	local winsPerMode = Data.Get("WinsPerMode")

	for _, frame in self.Root.Frame:GetChildren() do
		if not frame:IsA("Frame") then
			continue
		end

		local name = tonumber(frame.Name)
		local v = "locked"
		local v2

		if name == 1 then
			v2 = ((winsPerMode[`HalloweenPart{1}`] or 0) > 0 or (winsPerMode[`HalloweenNightmarePart{1}`] or 0) > 0)
				and "complete"
				or "current"
		else
			v2 = ((winsPerMode[`HalloweenPart{name}`] or 0) > 0 or (winsPerMode[`HalloweenNightmarePart{name}`] or 0) > 0)
				and "complete"
				or ((winsPerMode[`HalloweenPart{name - 1}`] or 0) > 0 or (winsPerMode[`HalloweenNightmarePart{name - 1}`] or 0) > 0)
				and "current"
				or v
		end

		for _, child in frame.bg:GetChildren() do
			child.Visible = child.Name == v2
		end
	end
end

function NightSelection:Init()
	self.Cleaner:Add(self.Root.Close.MouseButton1Click:Connect(function()
		Network.Fire("LeaveQueue")
		GuiService.SelectedObject = nil
	end))
	self.Cleaner:Add(Network.HookEvent("SelectNight", function(elevator, flag: boolean?)
		if flag then
			self.Root.Visible = false
			self.Elevator = nil
		else
			self:Update()
			self.Root.Visible = true
			self.Elevator = elevator
		end
	end))
	self.Cleaner:Add(RunService.Heartbeat:Connect(function()
		local now2 = tick()

		if now2 - now > 1 / 30 then
			now = now2

			if self.Elevator then
				self.Root.timer.Text = self.Elevator.Parent:GetAttribute("Status"):match("%d+") or ""
			end
		end
	end))

	for _, frame in self.Root.Frame:GetChildren() do
		if not frame:IsA("Frame") then
			continue
		end

		self.Cleaner:Add(frame.TextButton.MouseButton1Down:Connect(function()
			SoundHandler.Play("ClickDown")
		end))
		local v = frame
		self.Cleaner:Add(frame.TextButton.MouseButton1Click:Connect(function()
			SoundHandler.Play("ClickUp")

			if self.Elevator and (v.bg.current.Visible or v.bg.complete.Visible) then
				Network.Fire("SetNight", (tonumber(v.Name)))
				self.Elevator = nil
				self.Root.Visible = false
			end
		end))
	end
end

function NightSelection.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { NightSelection }, game.Players)
return NightSelection