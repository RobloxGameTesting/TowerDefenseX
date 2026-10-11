local DifficultyVoteScreenHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
local Enums = require(Common:WaitForChild("Enums"))
local Utilities = require(Common:WaitForChild("Utilities"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local LobbyTypeUtilities = require(Common:WaitForChild("LobbyTypeUtilities"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local Shared = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Shared"))
local Data = require(TDX_Shared.Client.Services.Data)
local RewardsScreenHandler = require(script.Parent:WaitForChild("RewardsScreenHandler"))
local udim = UDim2.new(0.5, 0, 0.45, 0)
local udim2 = UDim2.new(0.5, 0, 0.35, 0)
local udim3 = UDim2.new(0.5, 0, -0.5, 0)
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(140, 140, 140)
local udim4 = UDim2.new(0.5, 0, 1, 0)
local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0.1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local tweenInfo3 = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local tweenInfo4 = TweenInfo.new(0)
local DIFFICULTIES_WITH_FIRST_TIME_BONUS = _G.DIFFICULTIES_WITH_FIRST_TIME_BONUS
local event = NetworkingHandler.GetEvent("DifficultyVoteCast")
local event2 = NetworkingHandler.GetEvent("DifficultyVoteStateUpdate")
local event3 = NetworkingHandler.GetEvent("DifficultyVoteReady")
local event4 = BindableHandler.GetEvent("ErrorPrompt")
local event5 = BindableHandler.GetEvent("MessagePrompt")
local event6 = BindableHandler.GetEvent("SetMapDifficulty")
local difficultyVoteScreen = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("DifficultyVoteScreen")
local background = difficultyVoteScreen:WaitForChild("Background")
local beginButton = difficultyVoteScreen:WaitForChild("BeginButton")
local default = difficultyVoteScreen:WaitForChild("Default")
local tutorial = difficultyVoteScreen:WaitForChild("Tutorial")
local christmas = difficultyVoteScreen:WaitForChild("Christmas")
local towerBattles = difficultyVoteScreen:WaitForChild("Tower Battles")
local halloweenPart1 = difficultyVoteScreen:WaitForChild("Halloween Part 1")
local halloweenPart2 = difficultyVoteScreen:WaitForChild("Halloween Part 2")
local halloweenPart3 = difficultyVoteScreen:WaitForChild("Halloween Part 3")
local halloweenPart4 = difficultyVoteScreen:WaitForChild("Halloween Part 4")
local christmas24Part1 = difficultyVoteScreen:WaitForChild("Christmas24Part1")
local christmas24Part2 = difficultyVoteScreen:WaitForChild("Christmas24Part2")
local halloween2025 = difficultyVoteScreen:WaitForChild("Halloween2025")
local christmas25Part1 = difficultyVoteScreen:WaitForChild("Christmas25Part1")
local christmas25Part2 = difficultyVoteScreen:WaitForChild("Christmas25Part2")
local easter26Part1 = difficultyVoteScreen:WaitForChild("Easter26Part1")
local easter26Part2 = difficultyVoteScreen:WaitForChild("Easter26Part2")
local tbPart2 = difficultyVoteScreen:WaitForChild("TBPart2")
local mlg = difficultyVoteScreen:WaitForChild("MLG")
local slimeEvent = difficultyVoteScreen:WaitForChild("Slime Event")
local nightmare = difficultyVoteScreen:WaitForChild("Nightmare")
local v = nil
local v2 = nil
local v3 = nil
local v4 = true
local v5 = nil
local v6 = nil
local votingScreenMusicName = nil
local Easy = Enums.MapDifficulties.Easy

local function StateUpdate(data)
	local voteMap = data.VoteMap

	for k, v7 in pairs(voteMap) do
		local v8 = v3[k]

		if v8 then
			v8:UpdateVoteCount(v7)
		else
			warn("DifficultyVoteScreenHandler state update: button not found for difficulty: " .. k)
		end
	end

	v:UpdateCounts(data.ReadyCount, data.PlayerCount)
end

local function NewDifficultyButton(instance, difficulty: string)
	local v7 = {
		Difficulty = difficulty,
		Enabled = not Utilities.TryReadChildValue(instance, "Disabled", false),
		IsHovered = false,
		IsSelected = false,
		Button = instance,
		VoteCountText = instance:FindFirstChild("VoteCount"),
		DefaultStateImage = instance:FindFirstChild("Default"),
		HighlightStateImage = instance:FindFirstChild("Hovered"),
		MedalImage = instance:FindFirstChild("MedalImage"),
		ButtonDefaultSize = instance.Size,
		ButtonHoveredSize = UDim2.new(instance.Size.X.Scale, 0, instance.Size.Y.Scale + 0.01, 0),
		ButtonSelectedSize = UDim2.new(instance.Size.X.Scale, 0, instance.Size.Y.Scale + 0.02, 0),
		Hovered = function(self)
			self.IsHovered = true
			self:_UpdateState()
		end,
		Unhovered = function(self)
			self.IsHovered = false
			self:_UpdateState()
		end,
		Clicked = function(self)
			if self.Enabled then
				event:FireServer(self.Difficulty)
				SoundHandler.Play("ClickTower")
				self:Select()
			else
				SoundHandler.Play("Error")
				event5:Fire("Mode unavailable!", 4)
			end
		end,
		Select = function(self)
			if v5 then
				v5:Deselect()
			end

			v5 = self
			self.IsSelected = true
			RewardsScreenHandler.Update(self.Difficulty, Easy)
			self:_UpdateState()

			if v then
				v:SelectionChanged()
			end
		end,
		Deselect = function(self)
			v5 = nil
			self.IsSelected = false
			self:_UpdateState()

			if v then
				v:SelectionChanged()
			end
		end,
		UpdateVoteCount = function(self, p)
			self.VoteCountText.Text = tostring(p)
		end,
		UpdateMedalImage = function(self, p: string)
			local medalImage = self.MedalImage

			if medalImage then
				if table.find(DIFFICULTIES_WITH_FIRST_TIME_BONUS, self.Difficulty) then
					local v7 = ((Data.Get("MapAndDifficultyWins") or {})[p] or {})[self.Difficulty] or 0
					medalImage.Image = Shared.MEDALS_LIST[self.Difficulty][v7 > 0]
				else
					medalImage.Visible = false
				end
			end
		end,
		_UpdateState = function(self)
			local button = self.Button
			local voteCountText = self.VoteCountText
			local defaultStateImage = self.DefaultStateImage
			local highlightStateImage = self.HighlightStateImage

			if self.Enabled then
				defaultStateImage.ImageTransparency = 0
				voteCountText.TextTransparency = 0
			else
				defaultStateImage.ImageTransparency = 0.5
				voteCountText.TextTransparency = 0.5
			end

			if self.Enabled and self.IsSelected then
				TweenService:Create(button, tweenInfo2, { Size = self.ButtonSelectedSize }):Play()
				highlightStateImage.ImageTransparency = 0
				highlightStateImage.Visible = true
			elseif self.Enabled and self.IsHovered then
				TweenService:Create(button, tweenInfo2, { Size = self.ButtonHoveredSize }):Play()
				highlightStateImage.ImageTransparency = 0
				highlightStateImage.Visible = true
			else
				TweenService:Create(button, tweenInfo, { Size = self.ButtonDefaultSize }):Play()
				highlightStateImage.ImageTransparency = 1
				highlightStateImage.Visible = false
			end

			button.Selectable = self.Enabled
		end
	}
	instance.MouseEnter:Connect(function()
		v7:Hovered()
	end)
	instance.MouseLeave:Connect(function()
		v7:Unhovered()
	end)
	instance.Activated:Connect(function()
		v7:Clicked()
	end)
	v7:_UpdateState()
	return v7
end

local function NewBeginButton(beginButton2)
	local v7 = {
		IsHovered = false,
		Enabled = false,
		Button = beginButton2,
		TextLabel = beginButton2:FindFirstChild("Text"),
		DefaultStateImage = beginButton2:FindFirstChild("Default"),
		HighlightStateImage = beginButton2:FindFirstChild("Hovered"),
		Hovered = function(self)
			self.IsHovered = true
			self:_UpdateState()
		end,
		Unhovered = function(self)
			self.IsHovered = false
			self:_UpdateState()
		end,
		Clicked = function(self)
			if not self.Enabled then
				event4:Fire("Vote for a mode first!")
				return
			end

			TweenService:Create(difficultyVoteScreen, tweenInfo3, { Position = udim2 }):Play()
			SoundHandler.Play("ClickTower")
			event3:FireServer()
		end,
		SelectionChanged = function(self)
			if v5 or v6 then
				self.Enabled = true
			else
				self.Enabled = false
			end

			self:_UpdateState()
		end,
		UpdateCounts = function(self, p: number, p2: number)
			self.TextLabel.Text = `BEGIN [{tostring(p)}/{tostring(p2)}]`
		end,
		_UpdateState = function(self)
			local defaultStateImage = self.DefaultStateImage
			local highlightStateImage = self.HighlightStateImage

			if self.Enabled then
				if self.IsHovered then
					highlightStateImage.ImageTransparency = 0.5
				else
					highlightStateImage.ImageTransparency = 1
				end

				defaultStateImage.ImageColor3 = color
			else
				highlightStateImage.ImageTransparency = 1
				defaultStateImage.ImageColor3 = color2
			end
		end
	}
	beginButton2.MouseEnter:Connect(function()
		v7:Hovered()
	end)
	beginButton2.MouseLeave:Connect(function()
		v7:Unhovered()
	end)
	beginButton2.Activated:Connect(function()
		v7:Clicked()
	end)
	v7:_UpdateState()
	return v7
end

function DifficultyVoteScreenHandler.DisplayScreen(p, p2: string?, childName: string?)
	if p2 then
		warn("TODO: OverrideDifficulty not done")
		v6 = p2
		v:SelectionChanged()
	elseif childName then
		local child = difficultyVoteScreen:WaitForChild(childName)

		if child then
			child.Visible = true
			default.Visible = false
			local beginButtonPosition = child:GetAttribute("BeginButtonPosition")

			if beginButtonPosition then
				v.Button.Position = beginButtonPosition
			else
				v.Button.Position = udim4
			end

			if child:GetAttribute("DisableDefaultBackground") then
				background.Visible = false
			else
				background.Visible = true
			end
		end
	else
		default.Visible = true
	end

	difficultyVoteScreen.Visible = true
	TweenService:Create(difficultyVoteScreen, tweenInfo4, { Position = udim }):Play()

	if v5 then
		v5:Deselect()
	end

	StateUpdate(p)
	v4 = false
	local lobbyType = workspace:GetAttribute("LobbyType")
	local v7 = lobbyType and LobbyTypeUtilities.GetLobbyTypeData(lobbyType)

	if v7 and v7.VotingScreenMusicName then
		votingScreenMusicName = v7.VotingScreenMusicName
	else
		votingScreenMusicName = "DifficultyVotingMusic"
	end

	if childName == "Tutorial" then
		v2:Select()
	end

	SoundHandler.Play(votingScreenMusicName)
end

function DifficultyVoteScreenHandler.HideScreen()
	local tween = TweenService:Create(difficultyVoteScreen, tweenInfo3, { Position = udim3 })
	tween.Completed:Connect(function(p)
		if p == Enum.PlaybackState.Completed and v4 then
			difficultyVoteScreen.Visible = false
		end
	end)
	tween:Play()
	v4 = true

	if votingScreenMusicName then
		SoundHandler.Stop(votingScreenMusicName, 3)
	end
end

v = NewBeginButton(beginButton)
v2 = NewDifficultyButton(tutorial:WaitForChild("Tutorial"), Enums.Difficulties.Tutorial)
v3 = {
	[Enums.Difficulties.Tutorial] = v2,
	[Enums.Difficulties.Easy] = NewDifficultyButton(default:WaitForChild("Easy"), Enums.Difficulties.Easy),
	[Enums.Difficulties.Intermediate] = NewDifficultyButton(
		default:WaitForChild("Intermediate"),
		Enums.Difficulties.Intermediate
	),
	[Enums.Difficulties.Elite] = NewDifficultyButton(default:WaitForChild("Elite"), Enums.Difficulties.Elite),
	[Enums.Difficulties.Expert] = NewDifficultyButton(default:WaitForChild("Expert"), Enums.Difficulties.Expert),
	[Enums.Difficulties.Christmas] = NewDifficultyButton(
		christmas:WaitForChild("Christmas"),
		Enums.Difficulties.Christmas
	),
	[Enums.Difficulties.ChristmasNightmare] = NewDifficultyButton(
		christmas:WaitForChild("ChristmasNightmare"),
		Enums.Difficulties.ChristmasNightmare
	),
	[Enums.Difficulties.Toilet] = NewDifficultyButton(default:WaitForChild("Toilet"), Enums.Difficulties.Toilet),
	[Enums.Difficulties.Endless] = NewDifficultyButton(default:WaitForChild("Endless"), Enums.Difficulties.Endless),
	[Enums.Difficulties.TowerBattles] = NewDifficultyButton(
		towerBattles:WaitForChild("TowerBattles"),
		Enums.Difficulties.TowerBattles
	),
	[Enums.Difficulties.TowerBattlesNightmare] = NewDifficultyButton(
		towerBattles:WaitForChild("TowerBattlesNightmare"),
		Enums.Difficulties.TowerBattlesNightmare
	),
	[Enums.Difficulties.HalloweenPart1] = NewDifficultyButton(
		halloweenPart1:WaitForChild("HalloweenPart1"),
		Enums.Difficulties.HalloweenPart1
	),
	[Enums.Difficulties.HalloweenPart2] = NewDifficultyButton(
		halloweenPart2:WaitForChild("HalloweenPart2"),
		Enums.Difficulties.HalloweenPart2
	),
	[Enums.Difficulties.HalloweenPart3] = NewDifficultyButton(
		halloweenPart3:WaitForChild("HalloweenPart3"),
		Enums.Difficulties.HalloweenPart3
	),
	[Enums.Difficulties.HalloweenPart4] = NewDifficultyButton(
		halloweenPart4:WaitForChild("HalloweenPart4"),
		Enums.Difficulties.HalloweenPart4
	),
	[Enums.Difficulties.HalloweenNightmarePart1] = NewDifficultyButton(
		halloweenPart1:WaitForChild("HalloweenNightmarePart1"),
		Enums.Difficulties.HalloweenNightmarePart1
	),
	[Enums.Difficulties.HalloweenNightmarePart2] = NewDifficultyButton(
		halloweenPart2:WaitForChild("HalloweenNightmarePart2"),
		Enums.Difficulties.HalloweenNightmarePart2
	),
	[Enums.Difficulties.HalloweenNightmarePart3] = NewDifficultyButton(
		halloweenPart3:WaitForChild("HalloweenNightmarePart3"),
		Enums.Difficulties.HalloweenNightmarePart3
	),
	[Enums.Difficulties.HalloweenNightmarePart4] = NewDifficultyButton(
		halloweenPart4:WaitForChild("HalloweenNightmarePart4"),
		Enums.Difficulties.HalloweenNightmarePart4
	),
	[Enums.Difficulties.Christmas24Part1] = NewDifficultyButton(
		christmas24Part1:WaitForChild("Christmas24Part1"),
		Enums.Difficulties.Christmas24Part1
	),
	[Enums.Difficulties.Christmas24Part1Nightmare] = NewDifficultyButton(
		christmas24Part1:WaitForChild("Christmas24Part1Nightmare"),
		Enums.Difficulties.Christmas24Part1Nightmare
	),
	[Enums.Difficulties.Christmas24Part2] = NewDifficultyButton(
		christmas24Part2:WaitForChild("Christmas24Part2"),
		Enums.Difficulties.Christmas24Part2
	),
	[Enums.Difficulties.Christmas24Part2Nightmare] = NewDifficultyButton(
		christmas24Part2:WaitForChild("Christmas24Part2Nightmare"),
		Enums.Difficulties.Christmas24Part2Nightmare
	),
	[Enums.Difficulties.Halloween2025] = NewDifficultyButton(
		halloween2025:WaitForChild("Halloween2025"),
		Enums.Difficulties.Halloween2025
	),
	[Enums.Difficulties.Halloween2025Nightmare] = NewDifficultyButton(
		halloween2025:WaitForChild("Halloween2025Nightmare"),
		Enums.Difficulties.Halloween2025Nightmare
	),
	[Enums.Difficulties.Christmas25Part1Easy] = NewDifficultyButton(
		christmas25Part1:WaitForChild("Christmas25Part1Easy"),
		Enums.Difficulties.Christmas25Part1Easy
	),
	[Enums.Difficulties.Christmas25Part1] = NewDifficultyButton(
		christmas25Part1:WaitForChild("Christmas25Part1"),
		Enums.Difficulties.Christmas25Part1
	),
	[Enums.Difficulties.Christmas25Part1Nightmare] = NewDifficultyButton(
		christmas25Part1:WaitForChild("Christmas25Part1Nightmare"),
		Enums.Difficulties.Christmas25Part1Nightmare
	),
	[Enums.Difficulties.Christmas25Part2Easy] = NewDifficultyButton(
		christmas25Part2:WaitForChild("Christmas25Part2Easy"),
		Enums.Difficulties.Christmas25Part2Easy
	),
	[Enums.Difficulties.Christmas25Part2] = NewDifficultyButton(
		christmas25Part2:WaitForChild("Christmas25Part2"),
		Enums.Difficulties.Christmas25Part2
	),
	[Enums.Difficulties.Christmas25Part2Nightmare] = NewDifficultyButton(
		christmas25Part2:WaitForChild("Christmas25Part2Nightmare"),
		Enums.Difficulties.Christmas25Part2Nightmare
	),
	[Enums.Difficulties.Easter26Part1Easy] = NewDifficultyButton(
		easter26Part1:WaitForChild("Easter26Part1Easy"),
		Enums.Difficulties.Easter26Part1Easy
	),
	[Enums.Difficulties.Easter26Part1] = NewDifficultyButton(
		easter26Part1:WaitForChild("Easter26Part1"),
		Enums.Difficulties.Easter26Part1
	),
	[Enums.Difficulties.Easter26Part1Nightmare] = NewDifficultyButton(
		easter26Part1:WaitForChild("Easter26Part1Nightmare"),
		Enums.Difficulties.Easter26Part1Nightmare
	),
	[Enums.Difficulties.Easter26Part2Easy] = NewDifficultyButton(
		easter26Part2:WaitForChild("Easter26Part2Easy"),
		Enums.Difficulties.Easter26Part2Easy
	),
	[Enums.Difficulties.Easter26Part2] = NewDifficultyButton(
		easter26Part2:WaitForChild("Easter26Part2"),
		Enums.Difficulties.Easter26Part2
	),
	[Enums.Difficulties.Easter26Part2Nightmare] = NewDifficultyButton(
		easter26Part2:WaitForChild("Easter26Part2Nightmare"),
		Enums.Difficulties.Easter26Part2Nightmare
	),
	[Enums.Difficulties.TBPart2Casual] = NewDifficultyButton(
		tbPart2:WaitForChild("TBPart2Casual"),
		Enums.Difficulties.TBPart2Casual
	),
	[Enums.Difficulties.TBPart2Hard] = NewDifficultyButton(
		tbPart2:WaitForChild("TBPart2Hard"),
		Enums.Difficulties.TBPart2Hard
	),
	[Enums.Difficulties.TBPart2Nightmare] = NewDifficultyButton(
		tbPart2:WaitForChild("TBPart2Nightmare"),
		Enums.Difficulties.TBPart2Nightmare
	),
	[Enums.Difficulties.TBPart2Voidmare] = NewDifficultyButton(
		tbPart2:WaitForChild("TBPart2Voidmare"),
		Enums.Difficulties.TBPart2Voidmare
	),
	[Enums.Difficulties.MLG] = NewDifficultyButton(mlg:WaitForChild("MLG"), Enums.Difficulties.MLG),
	[Enums.Difficulties.MLGNightmare] = NewDifficultyButton(
		mlg:WaitForChild("MLGNightmare"),
		Enums.Difficulties.MLGNightmare
	),
	[Enums.Difficulties.SlimeEvent] = NewDifficultyButton(
		slimeEvent:WaitForChild("SlimeEvent"),
		Enums.Difficulties.SlimeEvent
	),
	[Enums.Difficulties.SlimeEventNightmare] = NewDifficultyButton(
		slimeEvent:WaitForChild("SlimeEventNightmare"),
		Enums.Difficulties.SlimeEventNightmare
	),
	[Enums.Difficulties.Nightmare] = NewDifficultyButton(
		nightmare:WaitForChild("Nightmare"),
		Enums.Difficulties.Nightmare
	),
	[Enums.Difficulties.UltraNightmare] = NewDifficultyButton(
		nightmare:WaitForChild("UltraNightmare"),
		Enums.Difficulties.UltraNightmare
	)
}
event2:AttachCallback(StateUpdate)
event6:AttachCallback(function(p: string, p2: string)
	Easy = p2

	if v5 then
		RewardsScreenHandler.Update(v5.Difficulty, p2)
	end

	for _, v7 in pairs(v3) do
		v7:UpdateMedalImage(p)
	end
end)
return DifficultyVoteScreenHandler