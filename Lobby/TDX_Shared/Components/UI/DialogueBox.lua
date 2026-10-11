local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Util = require(game.ReplicatedStorage.TDX_Shared.Modules.Util)
local GameSoundHandler = require(game.ReplicatedStorage.TDX_Shared.Components.GameSoundHandler)
local Dialogue = require(game.ReplicatedStorage.TDX_Shared.Modules.Dialogue)
require(game.ReplicatedStorage.TDX_Shared.Modules.Dialogue.DialogueTypes)
local Keybinds = require(game.ReplicatedStorage.TDX_Shared.Common.Keybinds)
local numberSequence = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0),
	NumberSequenceKeypoint.new(0.85, 0),
	NumberSequenceKeypoint.new(1, 1)
})
local numberSequence2 = NumberSequence.new({
	NumberSequenceKeypoint.new(0, 0),
	NumberSequenceKeypoint.new(0.75, 0),
	NumberSequenceKeypoint.new(1, 1)
})
local udim = UDim2.new(0.5, 0, 0.115, 0)
local udim2 = UDim2.new(1.5, 0, 1.4, 0)
local udim3 = UDim2.new(0.13, 0, 0.95, 0)
local tweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local tweenInfo3 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo4 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo5 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo6 = TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo7 = TweenInfo.new(3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local LocalPlayer = Players.LocalPlayer
local interface = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Interface")
local dialogueBoxBounds = interface and interface:FindFirstChild("DialogueBoxBounds")
local uiScale = dialogueBoxBounds and dialogueBoxBounds:FindFirstChildOfClass("UIScale")
local absoluteSize = interface and interface.AbsoluteSize
local DialogueBox = { ClassName = script.Name, ClassModule = script }
DialogueBox.__index = DialogueBox

local function GetDialogueBoxStartPosition() -- 2 equivalent calls inferred from this helper
	if dialogueBoxBounds then
		return UDim2.new(0.4, 0, 0.5, 0)
	end

	return UDim2.new(0.4, 0, 0.88, 0)
end

local function GetDialogueBoxEndPosition() -- 1 equivalent call inferred from this helper
	if dialogueBoxBounds then
		return UDim2.new(0.5, 0, 0.5, 0)
	end

	return UDim2.new(0.5, 0, 0.88, 0)
end

local function GetCharDelay(text: string, graphemeEnd: number) -- 1 equivalent call inferred from this helper
	local v = string.sub(text, math.max(1, graphemeEnd - 1), graphemeEnd)

	if v == ". " or v == "! " then
		return 0.20299999999999999
	end

	if v == ", " then
		return 0.11299999999999999
	end

	return 0.023
end

function DialogueBox.new(root)
	return (setmetatable({
		Root = root,
		Box = nil,
		Cleaner = Cleaner.new(),
		Ongoing = false,
		Playback = nil,
		Pending = nil
	}, DialogueBox))
end

function DialogueBox:Init()
	local v = Util.Create("ScreenGui", {
		Enabled = false,
		Name = "Dialogue",
		ResetOnSpawn = false,
		IgnoreGuiInset = true,
		DisplayOrder = 100,
		Parent = self.Root,
		Util.Create("ImageLabel", {
			Name = "Box",
			Image = "rbxassetid://13890056757",
			BackgroundTransparency = 1,
			Size = dialogueBoxBounds and UDim2.new(1, 0, 1, 0) or udim,
			Position = GetDialogueBoxStartPosition(), -- inferred equivalent call
			AnchorPoint = dialogueBoxBounds and Vector2.new(0.5, 0.5) or Vector2.new(0.5, 1),
			ImageTransparency = 1,
			Util.Create("ImageLabel", {
				Name = "TitleBox",
				Image = "rbxassetid://13890058015",
				BackgroundTransparency = 1,
				Size = UDim2.new(0.25, 0, 0.25, 0),
				Position = UDim2.new(0.256, 0, 0.05, 0),
				ImageTransparency = 1,
				Util.Create("TextLabel", {
					Name = "TitleText",
					Size = UDim2.new(0.8, 0, 0.75, 0),
					TextScaled = true,
					Text = "NAME",
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					TextColor3 = Color3.fromRGB(0, 0, 0),
					Position = UDim2.new(0.45, 0, 0.47, 0),
					AnchorPoint = Vector2.new(0.5, 0.5),
					TextTransparency = 1
				}),
				Util.Create("UIAspectRatioConstraint", { AspectRatio = 5 })
			}),
			Util.Create("TextLabel", {
				Name = "DialogueText",
				Size = UDim2.new(0.63, 0, 0.5, 0),
				TextWrapped = true,
				Text = "TEXT HERE!",
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				TextXAlignment = Enum.TextXAlignment.Left,
				TextYAlignment = Enum.TextYAlignment.Top,
				TextColor3 = Color3.fromRGB(240, 240, 240),
				Position = UDim2.new(0.256, 0, 0.4, 0),
				AnchorPoint = Vector2.new(0, 0),
				TextTransparency = 1
			}),
			Util.Create("ImageLabel", {
				Name = "Mascot",
				Size = udim2,
				Position = udim3,
				AnchorPoint = Vector2.new(0.5, 1),
				BackgroundTransparency = 1,
				Image = "rbxassetid://14063853703",
				ImageTransparency = 1,
				Util.Create("UIAspectRatioConstraint", { Name = "Ratio", AspectRatio = 0.776 }),
				Util.Create("UIGradient", { Rotation = 90, Transparency = numberSequence2 })
			}),
			Util.Create("Frame", {
				Name = "ProgressHolder",
				Size = UDim2.new(0.885, 0, 0.015, 0),
				Position = UDim2.new(0, 0, 0, 0),
				AnchorPoint = Vector2.new(0, 1),
				BackgroundTransparency = 1,
				ZIndex = 0,
				Util.Create("Frame", {
					Name = "Bar",
					Size = UDim2.new(1, 0, 1, 0),
					Position = UDim2.new(0, 0, 0.5, 0),
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Color3.fromRGB(205, 228, 169),
					BorderSizePixel = 0
				})
			}),
			Util.Create("UIAspectRatioConstraint", { AspectRatio = 4.75 }),
			Util.Create("UIGradient", { Rotation = 90, Transparency = numberSequence })
		})
	})
	self.Gui = v
	self.Cleaner:Add(v)
	self.TypingSound = Util.Create("Sound", {
		Name = "TypingSound",
		SoundId = "rbxassetid://13891400106",
		Volume = 0.05,
		Parent = v
	})
	GameSoundHandler.AddSoundToSoundGroup(self.TypingSound, "UI")
	self.Cleaner:Add(RunService.RenderStepped:Connect(function(dt: number)
		self:_Step(dt)
	end))
	self:ScreenSizeChanged()
end

function DialogueBox:_GetBox()
	local box = self.Box or self.Gui.Box

	if dialogueBoxBounds and not self.Box then
		self.Box = box
		self.Cleaner:Add(box)
		box.Parent = dialogueBoxBounds
	end

	return box
end

function DialogueBox:RunSequence(p: string, p2: string?, p3: number?, _: boolean?)
	local lines = Dialogue.ResolveLines(p, p2, p3)

	if lines then
		self:_Play(lines)
	end
end

function DialogueBox:RunDialogue(text: string, value: string, imageRatio: number?, image: string?, pitch: number?)
	if not text then
		return
	end

	self:_Play({
		{
			Text = text,
			Name = value or "",
			Image = image,
			ImageRatio = imageRatio,
			Pitch = pitch,
			AfterTextDuration = 10,
			PlayTypingSound = true
		}
	})
end

function DialogueBox:_Play(pending)
	if self.Ongoing then
		self.Pending = pending
		return
	end

	for _, v in pending do
		v.Text = Keybinds.FormatText(v.Text)
	end

	self.Ongoing = true
	self.Gui.Enabled = true
	local box = self:_GetBox()
	TweenService:Create(box, tweenInfo3, { ImageTransparency = 0 }):Play()
	TweenService:Create(box.Mascot, tweenInfo3, { ImageTransparency = 0 }):Play()
	TweenService:Create(box.TitleBox, tweenInfo3, { ImageTransparency = 0 }):Play()
	TweenService:Create(box.TitleBox.TitleText, tweenInfo3, { TextTransparency = 0 }):Play()
	TweenService:Create(box.DialogueText, tweenInfo3, { TextTransparency = 0 }):Play()
	box.TitleBox.TitleText.MaxVisibleGraphemes = 0
	self.Playback = {
		Lines = pending,
		Index = 0,
		Phase = "Typing",
		Timer = 0,
		GraphemeEnds = {},
		VisibleGraphemes = 0,
		NextCharDelay = 0.023
	}
	self:_BeginLine(1)
end

function DialogueBox:_BeginLine(p: number)
	local playback = self.Playback
	local line = playback.Lines[p]
	local line2 = playback.Lines[p - 1]
	local box = self:_GetBox()
	local mascot = box.Mascot
	local titleText = box.TitleBox.TitleText
	local dialogueText = box.DialogueText
	local bar = box.ProgressHolder.Bar
	playback.Index = p

	if line.ImageRatio then
		mascot.Ratio.AspectRatio = line.ImageRatio
	end

	mascot.Size = line.ImageSize or udim2

	if line.Image then
		mascot.Image = line.Image
	end

	if line2 and line2.Image ~= line.Image then
		TweenService:Create(mascot, tweenInfo3, { ImageTransparency = 0, Position = udim3 }):Play()
	end

	titleText.Text = line.Name
	TweenService:Create(titleText, tweenInfo5, {
		MaxVisibleGraphemes = utf8.len(line.Name) or #line.Name
	}):Play()
	dialogueText.Text = line.Text
	dialogueText.MaxVisibleGraphemes = 0
	self:ScreenSizeChanged()
	table.clear(playback.GraphemeEnds)

	for _, v in utf8.graphemes(line.Text) do
		table.insert(playback.GraphemeEnds, v)
	end

	playback.VisibleGraphemes = 0
	playback.NextCharDelay = 0.023
	playback.Timer = 0
	playback.Phase = "Typing"
	bar.BackgroundTransparency = 1
	bar.Size = UDim2.new(1, 0, 1, 0)
	TweenService:Create(box, tweenInfo, { Position = GetDialogueBoxEndPosition() }):Play() -- inferred equivalent call
	self.TypingSound.Pitch = line.Pitch or 1

	if line.SoundId then
		local v = Util.Create("Sound", {
			Name = `DialogueSound{p}`,
			SoundId = line.SoundId,
			Volume = 1.5,
			Pitch = 1,
			Parent = self.Gui
		})
		GameSoundHandler.AddSoundToSoundGroup(v, "UI")
		v.Ended:Once(function()
			v:Destroy()
		end)
		v:Play()
	end

	if #playback.GraphemeEnds == 0 then
		self:_BeginHold()
	end
end

function DialogueBox:_BeginHold()
	local playback = self.Playback
	TweenService:Create(self:_GetBox().ProgressHolder.Bar, tweenInfo7, {
		BackgroundTransparency = 0
	}):Play()
	playback.Phase = "Hold"
	playback.Timer = 0
end

function DialogueBox:_Step(p: number)
	local playback = self.Playback

	if not playback then
		return
	end

	playback.Timer += math.min(p, 0.1)

	if playback.Phase == "Typing" then
		self:_StepTyping(playback)
	elseif playback.Phase == "Hold" then
		self:_StepHold(playback)
	elseif playback.Phase == "LineTransition" and playback.Timer >= tweenInfo4.Time then
		self:_BeginLine(playback.Index + 1)
	end
end

function DialogueBox:_StepTyping(state)
	local line = state.Lines[state.Index]
	local dialogueText = self:_GetBox().DialogueText

	while state.Timer >= state.NextCharDelay do
		state.Timer -= state.NextCharDelay
		state.VisibleGraphemes += 1
		dialogueText.MaxVisibleGraphemes = state.VisibleGraphemes

		if line.PlayTypingSound then
			self.TypingSound:Play()
		end

		if state.VisibleGraphemes >= #state.GraphemeEnds then
			self:_BeginHold()
			break
		end

		state.NextCharDelay = GetCharDelay(line.Text, state.GraphemeEnds[state.VisibleGraphemes]) -- inferred equivalent call
	end
end

function DialogueBox:_StepHold(state)
	local line = state.Lines[state.Index]
	local bar = self:_GetBox().ProgressHolder.Bar
	local v = math.clamp(state.Timer / line.AfterTextDuration, 0, 1)
	bar.Size = UDim2.new(1 - v, 0, 1, 0)

	if v < 1 then
		return
	end

	if not state.Lines[state.Index + 1] then
		self:_Finish()
		return
	end

	TweenService:Create(self:_GetBox().TitleBox.TitleText, tweenInfo6, { MaxVisibleGraphemes = 0 }):Play()
	state.Phase = "LineTransition"
	state.Timer = 0
end

function DialogueBox:_Finish()
	self.Playback = nil
	self.Ongoing = false
	local pending = self.Pending

	if not pending then
		self:_FadeOut()
		return
	end

	self.Pending = nil
	self:_Play(pending)
end

function DialogueBox:Cancel()
	self.Pending = nil

	if not self.Ongoing then
		return
	end

	self.Playback = nil
	self.Ongoing = false

	for _, sound in self.Gui:GetChildren() do
		if sound:IsA("Sound") and sound ~= self.TypingSound then
			sound:Destroy()
		end
	end

	self:_FadeOut()
end

function DialogueBox:_FadeOut()
	local box = self:_GetBox()
	TweenService:Create(box, tweenInfo2, { Position = GetDialogueBoxStartPosition() }):Play() -- inferred equivalent call
	TweenService:Create(box.ProgressHolder.Bar, tweenInfo4, { BackgroundTransparency = 1 }):Play()
	TweenService:Create(box, tweenInfo4, { ImageTransparency = 1 }):Play()
	TweenService:Create(box.Mascot, tweenInfo4, { ImageTransparency = 1 }):Play()
	TweenService:Create(box.TitleBox, tweenInfo4, { ImageTransparency = 1 }):Play()
	TweenService:Create(box.TitleBox.TitleText, tweenInfo4, { TextTransparency = 1 }):Play()
	TweenService:Create(box.DialogueText, tweenInfo4, { TextTransparency = 1 }):Play()
	TweenService:Create(box.TitleBox.TitleText, tweenInfo6, { MaxVisibleGraphemes = 0 }):Play()
end

function DialogueBox:Destroy()
	self.Playback = nil
	self.Cleaner:Clean()
end

function DialogueBox:ScreenSizeChanged()
	local box = self.Box or self.Gui.Box
	local scale = uiScale and uiScale.Scale or 1
	box.DialogueText.TextSize = box.DialogueText.AbsoluteSize.Y * 0.25 / scale
end

Director.Register(script.Name, { DialogueBox }, LocalPlayer)
Director.Tag(LocalPlayer:WaitForChild("PlayerGui"), "DialogueBox")

if dialogueBoxBounds then
	RunService.RenderStepped:Connect(function()
		local absoluteSize2 = interface.AbsoluteSize

		if absoluteSize2 ~= absoluteSize then
			absoluteSize = absoluteSize2

			for _, v in Director.GetItemsFromClass(Director.Classes.DialogueBox) do
				v:ScreenSizeChanged()
			end
		end
	end)
end

return DialogueBox