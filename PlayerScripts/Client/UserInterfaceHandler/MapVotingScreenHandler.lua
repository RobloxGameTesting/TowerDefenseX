local MapVotingScreenHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local TweenService = game:GetService("TweenService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("Utilities"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local MapHandler = require(common:WaitForChild("MapHandler"))
local MapUtilities = require(common:WaitForChild("MapUtilities"))
local MapData = require(common:WaitForChild("MapData"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local PlayerClass = require(script.Parent.Parent:WaitForChild("PlayerClass"))
local MapOverrideScreenHandler = require(script.Parent:WaitForChild("MapOverrideScreenHandler"))
local MEDALS_LIST = Shared.MEDALS_LIST
local udim = UDim2.new(0.5, 0, 0.92, 0)
local udim2 = UDim2.new(0.5, 0, 1.2, 0)
local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(0)
local VIP_GAMEPASS_ID = _G.VIP_GAMEPASS_ID
local event = NetworkingHandler.GetEvent("MapVoteCast")
local event2 = NetworkingHandler.GetEvent("MapChangeVoteCast")
local event3 = NetworkingHandler.GetEvent("MapVoteStateUpdate")
local event4 = NetworkingHandler.GetEvent("MapVoteReady")
local event5 = NetworkingHandler.GetEvent("GamepassPurchased")
local event6 = BindableHandler.GetEvent("ErrorPrompt")
local LocalPlayer = Players.LocalPlayer
local mapVotingScreen = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("MapVotingScreen")
local begin = mapVotingScreen:WaitForChild("Begin")
local bottom = mapVotingScreen:WaitForChild("Bottom")
local override = bottom:WaitForChild("Override")
local changeMap = bottom:WaitForChild("ChangeMap")
local flag = false
local v = true
local v2 = nil
local v3 = nil
local v4 = nil
local v5 = nil
local v6 = nil
local v7 = nil
local v8 = {}

local function StateUpdate(data, flag2: boolean)
	if not flag then
		return
	end

	if flag2 and v2 and data.PlayerVoteMap[LocalPlayer.Name] ~= v2.CurrentMapName then
		v2:Deselect()
	end

	local options = data.Options
	local voteMap = data.VoteMap

	for i = 1, 4 do
		local option = options[i]
		local v9 = v8[i]

		if v9 then
			if option then
				v9:SetMap(option)
				v9:UpdateVoteCount(voteMap[option] or 0)
			else
				v9:Disable()
			end
		else
			warn("DifficultyVoteScreenHandler state update: screen not found for map: " .. option)
		end
	end

	v5:DataChanged(data, flag2)
	v6:DataChanged(data, flag2)
	v7:DataChanged(data, flag2)
	MapOverrideScreenHandler:DataChanged(data)
end

local function NewVotingScreen(child, proximityPrompt)
	local screenPart = child:FindFirstChild("ScreenPart")
	local screenPart2 = child:FindFirstChild("ScreenPart2")
	local medals = child:FindFirstChild("Medals")
	local surfaceGui = screenPart:FindFirstChild("SurfaceGui")
	local disabled = screenPart:FindFirstChild("Disabled")
	local surfaceGui2 = screenPart2:FindFirstChild("SurfaceGui")
	local surfaceGui3 = medals:FindFirstChild("SurfaceGui")
	local icon = surfaceGui:FindFirstChild("Icon")
	local creator = surfaceGui:FindFirstChild("Creator")
	local mapDifficulty = surfaceGui:FindFirstChild("MapDifficulty")
	local mapName = surfaceGui:FindFirstChild("MapName")
	local voteCount = surfaceGui2:FindFirstChild("VoteCount")
	local frame = surfaceGui3:FindFirstChild("Frame")
	local uiStroke = mapDifficulty:FindFirstChild("UIStroke")
	local v9 = {
		CurrentMapName = nil,
		Enabled = false,
		UpdateVoteCount = function(self, p: number)
			voteCount.Text = `VOTES: {p}`
		end,
		Disable = function(self)
			self.Enabled = false
			self:_UpdateState()
		end,
		SetMap = function(self, p: string)
			if self.CurrentMapName == p then
				return
			end

			local v9 = MapData[p]

			if not v9 then
				warn("MapVotingHandler: Map data not found for map: " .. p)
				return
			end

			local difficulty = v9.Difficulty
			local colorDataForMapDifficulty = MapUtilities.GetColorDataForMapDifficulty(difficulty)
			icon.Image = v9.Image
			creator.Text = `CREATOR: {string.upper(v9.Creator)}`
			mapDifficulty.Text = `{string.upper(difficulty)}`
			mapName.Text = `{string.upper(MapUtilities.GetDisplayName(p))}`
			mapDifficulty.TextColor3 = colorDataForMapDifficulty.Color
			uiStroke.Color = colorDataForMapDifficulty.BorderColor
			proximityPrompt.ObjectText = p
			proximityPrompt.Enabled = true
			self:_HandleMedals(p, v9)
			self.CurrentMapName = p
			self.Enabled = true
			self:_UpdateState()
		end,
		_HandleMedals = function(self, p: string, p2)
			local mapAndDifficultyWins = Data.Get("MapAndDifficultyWins") or {}
			local customMedalDifficulties = p2.CustomMedalDifficulties
			local count = 0

			for childName, v9 in MEDALS_LIST do
				local v10 = not mapAndDifficultyWins[p] and 0 or mapAndDifficultyWins[p][childName] or 0
				local child2 = frame:FindFirstChild(childName)

				if not child2 then
					continue
				end

				if customMedalDifficulties and not table.find(customMedalDifficulties, childName) then
					child2.Visible = false
				else
					child2.Image = v9[v10 > 0]
					child2.Visible = true
					count += 1
				end
			end

			if p2.IsEventOnlyMap or not (count > 0) then
				frame.Visible = false
			else
				frame.Visible = true
			end
		end,
		Select = function(self)
			if v2 then
				v2:Deselect()
			end

			v2 = self

			if self.CurrentMapName then
				event:FireServer(self.CurrentMapName)
			end

			if v5 then
				v5:SelectionChanged()
			end

			SoundHandler.Play("SettingOn")
		end,
		Deselect = function(self)
			v2 = nil

			if v5 then
				v5:SelectionChanged()
			end
		end,
		_UpdateState = function(self)
			disabled.Enabled = not self.Enabled
			surfaceGui.Enabled = self.Enabled
			surfaceGui2.Enabled = self.Enabled
			surfaceGui3.Enabled = self.Enabled
		end
	}
	proximityPrompt.Triggered:Connect(function(player)
		if v or player ~= LocalPlayer then
			return
		end

		v9:Select()
	end)
	return v9
end

local function NewBeginButton(begin2)
	local v9 = {
		IsHovered = false,
		IsSelected = false,
		Enabled = false,
		Button = begin2,
		TextLabel = begin2:FindFirstChild("TextLabel"),
		DefaultStateImage = begin2:FindFirstChild("Default"),
		DisabledStateImage = begin2:FindFirstChild("Disabled"),
		HighlightStateImage = begin2:FindFirstChild("Hovered"),
		SelectedStateImage = begin2:FindFirstChild("Selected"),
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
				event6:Fire("Vote for a map first!")
				return
			end

			self.IsSelected = true
			self:_UpdateState()
			SoundHandler.Play("ClickTower")
			event4:FireServer()
		end,
		SelectionChanged = function(self)
			if v2 then
				self.Enabled = true
			else
				self.Enabled = false
			end

			self:_UpdateState()
		end,
		DataChanged = function(self, p, _: boolean)
			local readyCount = p.ReadyCount
			local playerCount = p.PlayerCount
			self.TextLabel.Text = `READY [{tostring(readyCount)}/{tostring(playerCount)}]`

			if p.ReadyCount == 0 then
				self.IsSelected = false
				self:_UpdateState()
			end
		end,
		_UpdateState = function(self)
			local defaultStateImage = self.DefaultStateImage
			local disabledStateImage = self.DisabledStateImage
			local highlightStateImage = self.HighlightStateImage
			local selectedStateImage = self.SelectedStateImage

			if self.Enabled then
				if self.IsSelected then
					self:_HideImagesExcept(selectedStateImage)
					self.TextLabel.TextColor3 = Color3.fromRGB(0, 0, 0)
				else
					if self.IsHovered then
						self:_HideImagesExcept(highlightStateImage)
					else
						self:_HideImagesExcept(defaultStateImage)
					end

					self.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				end
			else
				self:_HideImagesExcept(disabledStateImage)
				self.TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			end

			self.Button.Selectable = self.Enabled
		end,
		_HideImagesExcept = function(self, p)
			local v9 = {
				self.DefaultStateImage,
				self.DisabledStateImage,
				self.HighlightStateImage,
				self.SelectedStateImage
			}

			for _, v10 in ipairs(v9) do
				if v10 ~= p then
					v10.Visible = false
				end
			end

			p.Visible = true
		end
	}
	begin2.MouseEnter:Connect(function()
		v9:Hovered()
	end)
	begin2.MouseLeave:Connect(function()
		v9:Unhovered()
	end)
	begin2.Activated:Connect(function()
		v9:Clicked()
	end)
	v9:_UpdateState()
	return v9
end

local function NewOverrideMapButton(override2)
	local v9 = {
		IsHovered = false,
		IsSelected = false,
		Enabled = true,
		CanOverrideMap = true,
		Button = override2,
		TextLabel = override2:FindFirstChild("TextLabel"),
		DefaultStateImage = override2:FindFirstChild("Default"),
		DisabledStateImage = override2:FindFirstChild("Disabled"),
		HighlightStateImage = override2:FindFirstChild("Hovered"),
		SelectedStateImage = override2:FindFirstChild("Selected"),
		Hovered = function(self)
			self.IsHovered = true
			self:_UpdateState()
		end,
		Unhovered = function(self)
			self.IsHovered = false
			self:_UpdateState()
		end,
		Clicked = function(self)
			if not self.CanOverrideMap then
				event6:Fire("Map override unavailble!")
			elseif not self.Enabled then
				event6:Fire("Can only override once!")
			elseif PlayerClass.LocalPlayerIsVIP() then
				SoundHandler.Play("ClickTower")
				MapOverrideScreenHandler:Open()
			else
				SoundHandler.Play("ShopSelectOption")
				MarketplaceService:PromptGamePassPurchase(LocalPlayer, VIP_GAMEPASS_ID)
			end
		end,
		DataChanged = function(self, p, _: boolean)
			if p.PlayerNameToHasOverridenMap[LocalPlayer.Name] then
				self.Enabled = false
			else
				self.Enabled = true
			end

			self.CanOverrideMap = p.CanOverrideMap
			self:_UpdateState()
		end,
		_UpdateState = function(self)
			local defaultStateImage = self.DefaultStateImage
			local disabledStateImage = self.DisabledStateImage
			local highlightStateImage = self.HighlightStateImage

			if not (self.Enabled and self.CanOverrideMap) then
				self:_HideImagesExcept(disabledStateImage)
			elseif self.IsHovered then
				self:_HideImagesExcept(highlightStateImage)
			else
				self:_HideImagesExcept(defaultStateImage)
			end
		end,
		_HideImagesExcept = function(self, p)
			local v9 = {
				self.DefaultStateImage,
				self.DisabledStateImage,
				self.HighlightStateImage,
				self.SelectedStateImage
			}

			for _, v10 in ipairs(v9) do
				if v10 ~= p then
					v10.Visible = false
				end
			end

			p.Visible = true
		end
	}
	override2.MouseEnter:Connect(function()
		v9:Hovered()
	end)
	override2.MouseLeave:Connect(function()
		v9:Unhovered()
	end)
	override2.Activated:Connect(function()
		v9:Clicked()
	end)
	v9:_UpdateState()
	return v9
end

local function NewChangeMapButton(changeMap2)
	local v9 = {
		IsHovered = false,
		IsSelected = false,
		Enabled = true,
		CanChangeMaps = true,
		Button = changeMap2,
		TextLabel = changeMap2:FindFirstChild("TextLabel"),
		DefaultStateImage = changeMap2:FindFirstChild("Default"),
		DisabledStateImage = changeMap2:FindFirstChild("Disabled"),
		HighlightStateImage = changeMap2:FindFirstChild("Hovered"),
		SelectedStateImage = changeMap2:FindFirstChild("Selected"),
		Hovered = function(self)
			self.IsHovered = true
			self:_UpdateState()
		end,
		Unhovered = function(self)
			self.IsHovered = false
			self:_UpdateState()
		end,
		Clicked = function(self)
			if not self.CanChangeMaps then
				event6:Fire("Cannot change maps!")
				return
			end

			if not self.Enabled then
				event6:Fire("No more map changes remaining!")
				return
			end

			self.IsSelected = not self.IsSelected
			self:_UpdateState()
			SoundHandler.Play("ClickTower")
			event2:FireServer(self.IsSelected)
		end,
		DataChanged = function(self, data, flag2: boolean)
			local playerCount = data.PlayerCount
			local changeMapYesVotes = data.ChangeMapYesVotes

			if flag2 then
				self.IsSelected = false
			end

			if data.MapChangesRemaining <= 0 then
				self.Enabled = false
			else
				self.Enabled = true
			end

			self.CanChangeMaps = data.CanChangeMaps
			self.TextLabel.Text = `CHANGE MAPS [{tostring(changeMapYesVotes)}/{tostring(playerCount)}]`
			self:_UpdateState()
		end,
		_UpdateState = function(self)
			local defaultStateImage = self.DefaultStateImage
			local disabledStateImage = self.DisabledStateImage
			local highlightStateImage = self.HighlightStateImage
			local selectedStateImage = self.SelectedStateImage

			if not (self.Enabled and self.CanChangeMaps) then
				self:_HideImagesExcept(disabledStateImage)
			elseif self.IsSelected then
				self:_HideImagesExcept(selectedStateImage)
			elseif self.IsHovered then
				self:_HideImagesExcept(highlightStateImage)
			else
				self:_HideImagesExcept(defaultStateImage)
			end
		end,
		_HideImagesExcept = function(self, p)
			local v9 = {
				self.DefaultStateImage,
				self.DisabledStateImage,
				self.HighlightStateImage,
				self.SelectedStateImage
			}

			for _, v10 in ipairs(v9) do
				if v10 ~= p then
					v10.Visible = false
				end
			end

			p.Visible = true
		end
	}
	changeMap2.MouseEnter:Connect(function()
		v9:Hovered()
	end)
	changeMap2.MouseLeave:Connect(function()
		v9:Unhovered()
	end)
	changeMap2.Activated:Connect(function()
		v9:Clicked()
	end)
	v9:_UpdateState()
	return v9
end

local function Initialize()
	if flag then
		return
	end

	v3 = MapHandler.GetMapVotingLobby()

	if not v3 then
		error("MapVotingHandler: Map voting lobby not found!")
		return
	end

	local votingScreens = v3:FindFirstChild("VotingScreens")

	if not votingScreens then
		error("MapVotingHandler: Voting screens folder not found!")
		return
	end

	local proximityPrompts = v3:FindFirstChild("ProximityPrompts")

	if not proximityPrompts then
		error("MapVotingHandler: Proximity prompts folder not found!")
		return
	end

	for i = 1, 4 do
		local child = votingScreens:FindFirstChild("VotingScreen" .. i)

		if not child then
			error("MapVotingHandler: Voting screen " .. i .. " not found!")
			return
		end

		local child2 = proximityPrompts:FindFirstChild("Prompt" .. i)

		if child2 then
			child2.Transparency = 1
		end

		local proximityPrompt = child2 and child2:FindFirstChildOfClass("ProximityPrompt")

		if proximityPrompt then
			v8[i] = NewVotingScreen(child, proximityPrompt)
		else
			error("MapVotingHandler: Proximity prompt " .. i .. " not found!")
			return
		end
	end

	flag = true
end

function MapVotingScreenHandler.Start(p)
	Initialize()

	if v2 then
		v2:Deselect()
	end

	StateUpdate(p)
	v5:SelectionChanged()
	v = false
	mapVotingScreen.Visible = true
	TweenService:Create(mapVotingScreen, tweenInfo2, { Position = udim }):Play()
	v4 = "MapVoteMusic"
	SoundHandler.Play(v4)
end

function MapVotingScreenHandler.Stop()
	v = true
	local tween = TweenService:Create(mapVotingScreen, tweenInfo, { Position = udim2 })
	tween.Completed:Connect(function(p)
		if p == Enum.PlaybackState.Completed and v then
			mapVotingScreen.Visible = false
		end
	end)
	tween:Play()

	if v4 then
		SoundHandler.Stop(v4, 3)
	end

	MapOverrideScreenHandler:Close()
end

v5 = NewBeginButton(begin)
v6 = NewOverrideMapButton(override)
v7 = NewChangeMapButton(changeMap)
event3:AttachCallback(StateUpdate)
event5:AttachCallback(function(p: string, p2: number)
	if p ~= LocalPlayer.Name or p2 ~= VIP_GAMEPASS_ID then
		return
	end

	v6:_UpdateState()
end)
return MapVotingScreenHandler