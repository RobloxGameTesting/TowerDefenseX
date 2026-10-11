local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Keybinds = require(TDX_Shared.Common.Keybinds)
local Data = require(TDX_Shared.Client.Services.Data)
local EmoteAnimationsV2 = require(TDX_Shared.Modules.EmoteAnimationsV2)
local EmotePlayer = require(TDX_Shared.Modules.EmotePlayer)
local EmoteUtilities = require(TDX_Shared.Modules.EmoteUtilities)
local EmoteVariants = require(TDX_Shared.Modules.EmoteVariants)
local WheelUI = require(TDX_Shared.Modules.WheelUI)
local LocalPlayer = Players.LocalPlayer
local EmoteUI = { ClassName = script.Name, ClassModule = script }
EmoteUI.__index = EmoteUI

function EmoteUI:SetupEmoteViewports()
	local baseCharacter = EmoteUtilities.CloneBaseCharacter()
	local emotes = Data.Get("Emotes")

	if _G.DEBUG_EMOTE_TESTING then
		for k, v in _G.EMOTE_OVERRIDE_LOADOUT do
			emotes[k] = v
		end
	end

	for i = 1, 6 do
		local emote = emotes[i]
		self.Wheel:SetSlotContent(i, function(instance)
			local viewportFrame = instance:FindFirstChild("ViewportFrame")

			if viewportFrame then
				local worldModel = viewportFrame:FindFirstChild("WorldModel")

				if worldModel then
					worldModel:ClearAllChildren()
				end

				local v = emote and EmoteAnimationsV2[EmoteVariants.Resolve(emote, baseCharacter)]

				if v then
					EmoteUtilities.SetupViewport(viewportFrame, baseCharacter, v)
				end
			end
		end)
	end
end

function EmoteUI:PlayEmote(p: string?)
	if self.EmotePlayer.CleaningUp then
		return
	end

	self.Wheel:Hide()

	if self.EmoteButton then
		self.EmoteButton:SetAttribute("Active", false)
	end

	local selected = self.Wheel:GetSelected()
	local v = p or Data.Get("Emotes")[selected]
	self.EmotePlayer:Play(v)
end

function EmoteUI.new(root)
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local emoteEvent = ReplicatedStorage2:WaitForChild("EmoteEvent")
	return (setmetatable(
		{
			Root = root,
			Cleaner = Cleaner.new(),
			EmotePlayer = EmotePlayer.new(emoteEvent),
			Wheel = WheelUI.new(root.Frame)
		},
		EmoteUI
	))
end

function EmoteUI:EmoteToggle()
	if self.EmotePlayer:IsPlaying() then
		self.EmotePlayer:Stop()
		return
	end

	for _, v in Players:GetPlayers() do
		if not (v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("EmotePartner") and (v.Character.PrimaryPart.Position - LocalPlayer.Character.PrimaryPart.Position).Magnitude <= 8) then
			continue
		end

		self:PlayEmote((v.Character.EmotePartner:GetAttribute("EmoteName")))
		return
	end

	local v = self.Wheel:Toggle()

	if self.EmoteButton then
		self.EmoteButton:SetAttribute("Active", v)
	end

	if v then
		self:SetupEmoteViewports()
	end
end

function EmoteUI:Init()
	pcall(function()
		StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu, false)
	end)
	self.Cleaner:Add(self.EmotePlayer.Stopped:Connect(function()
		self:EmoteToggle()
	end))
	self.Cleaner:Add(UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed or workspace:GetAttribute("FPSMode") then
			return
		end

		if Keybinds.IsActionInput("Emote", input) or input.KeyCode == Enum.KeyCode.ButtonL3 then
			self:EmoteToggle()
		elseif
			self.Wheel:IsVisible()
			and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.KeyCode == Enum.KeyCode.ButtonR2)
		then
			self:PlayEmote()
		elseif self.Wheel:IsVisible() and input.UserInputType == Enum.UserInputType.Touch then
			self.Wheel:UpdateSelectedFromPosition(input.Position.X, input.Position.Y)
			self:PlayEmote()
		end

		if
			self.EmotePlayer:IsPlaying()
			and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.KeyCode == Enum.KeyCode.ButtonR2)
		then
			self.EmotePlayer:PlayInteract()
		end
	end))
	self.Cleaner:Add(UserInputService.TouchTapInWorld:Connect(function(_: Vector2, flag: boolean)
		if flag then
			return
		end

		if self.EmotePlayer:IsPlaying() then
			self.EmotePlayer:PlayInteract()
		end
	end))
	self.Cleaner:Add(UserInputService.JumpRequest:Connect(function()
		if not self.EmotePlayer:IsPlaying() then
			return
		end

		self.EmotePlayer:Stop()
	end))
	self.Cleaner:Add(UserInputService.InputChanged:Connect(function(input)
		if not self.Wheel:IsVisible() then
			return
		end

		local viewportSize = workspace.CurrentCamera.ViewportSize

		if input.UserInputType == Enum.UserInputType.MouseMovement then
			self.Wheel:UpdateSelectedFromPosition(input.Position.X, input.Position.Y)
		elseif
			input.UserInputType == Enum.UserInputType.Gamepad1
			and input.KeyCode == Enum.KeyCode.Thumbstick1
			and math.sqrt(input.Position.X ^ 2 + input.Position.Y ^ 2) > 0.5
		then
			local midpoint = (input.Position.X + 1) / 2
			local midpoint2 = (input.Position.Y + 1) / 2
			self.Wheel:UpdateSelectedFromPosition(viewportSize.X * midpoint, viewportSize.Y * midpoint2, true)
		end
	end))
	local emotesButton = LocalPlayer.PlayerGui:WaitForChild("EmotesButton"):WaitForChild("EmotesButton", 15)

	if emotesButton then
		self.EmoteButton = emotesButton
		self.Cleaner:Add(emotesButton.Activated:Connect(function()
			self:EmoteToggle()
		end))

		local function UpdateVisibility() -- 2 equivalent calls inferred from this helper
			emotesButton.Visible = not workspace:GetAttribute("FPSMode")
				and UserInputService:GetLastInputType() == Enum.UserInputType.Touch
		end

		self.Cleaner:Add(UserInputService.LastInputTypeChanged:Connect(function()
			UpdateVisibility() -- inferred equivalent call
		end))
		self.Cleaner:Add(workspace:GetAttributeChangedSignal("FPSMode"):Connect(function()
			UpdateVisibility() -- inferred equivalent call
		end))
		self.ButtonThread = task.spawn(function()
			while true do
				task.wait(1)
				local touchGui = LocalPlayer.PlayerGui:WaitForChild("TouchGui", 10)

				if not touchGui then
					break
				end

				local jumpButton = touchGui:FindFirstChild("JumpButton", true)

				if not jumpButton then
					continue
				end

				local v = jumpButton.Size.X.Offset / 70
				emotesButton.Position = jumpButton.Position - UDim2.new(0, 25 * v, 0, 55 * v)
				emotesButton.Size = UDim2.new(0, 50 * v, 0, 50 * v)
			end
		end)
		emotesButton.Visible = UserInputService:GetLastInputType() == Enum.UserInputType.Touch
	end
end

function EmoteUI:Destroy()
	self.EmotePlayer:Destroy()
	self.Wheel:Destroy()
	self.Cleaner:Clean()

	if self.ButtonThread then
		task.cancel(self.ButtonThread)
	end
end

Director.Register(script.Name, { EmoteUI }, game.Players)
return EmoteUI