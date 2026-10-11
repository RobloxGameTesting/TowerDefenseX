local createVector = vector.create
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local UserInputService = game:GetService("UserInputService")
local CurrentCamera = workspace.CurrentCamera
local now = tick()
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local ResourceManager = require(common:WaitForChild("ResourceManager"))
require(ReplicatedStorage.TDX_Shared.Common.SkinHandler)
local TowerUtilities = require(ReplicatedStorage.TDX_Shared.Common.TowerUtilities)
local Util = require(ReplicatedStorage.TDX_Shared.Modules.Util)
require(ReplicatedStorage.TDX_Shared.Common.Types)
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
local Network = require(ReplicatedFirst.Client.Network)
local PartyClient = require(ReplicatedFirst.Client.PartyClient)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local EnemyViewport = require(common.EnemyViewport)
local udim = UDim2.new(1.05, 0, 1.15, 0)
local udim2 = UDim2.new(0.5, 0, 0.475, 0)
local LocalPlayer = Players.LocalPlayer
local LoadoutWindow = { ClassName = script.Name, ClassModule = script }
LoadoutWindow.__index = LoadoutWindow

local function GetViewport(tower: string, skin: string, img, udim3: UDim2?) -- 1 equivalent call inferred from this helper
	local viewport = TowerUtilities.GetViewport(img, tower, skin)
	viewport.ZIndex = 3
	viewport.Size = udim3 or udim
	viewport.Position = udim2
	return viewport
end

local function IsInteractionBlocked()
	local v = workspace.CurrentCamera.ViewportSize * 0.5

	for _, v2 in LocalPlayer.PlayerGui:GetGuiObjectsAtPosition(v.X, v.Y) do
		if v2.Name ~= "CrateSpin" and v2.Name ~= "TouchControlFrame" and not v2:HasTag("WindowHandler") then
			return true
		end
	end

	return false
end

local function GetPlayerAtScreenPoint(x: number, y: number)
	local screenPointToRay = workspace.CurrentCamera:ScreenPointToRay(x, y)
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = { LocalPlayer.Character }
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	local raycastResult = workspace:Raycast(
		screenPointToRay.Origin,
		screenPointToRay.Direction.Unit * 100,
		raycastParams
	)

	if raycastResult then
		return Players:GetPlayerFromCharacter(raycastResult.Instance.Parent)
			or Players:GetPlayerFromCharacter(raycastResult.Instance.Parent.Parent)
	end

	return nil
end

function LoadoutWindow.new(instance)
	local highlight = Instance.new("Highlight")
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 0
	highlight.OutlineColor = Color3.new(1, 1, 1)
	highlight.Parent = workspace.Terrain
	return (setmetatable(
		{
			Root = instance,
			Core = instance:WaitForChild("Contents"):WaitForChild("Core"),
			Cleaner = Cleaner.new(),
			Highlight = highlight
		},
		LoadoutWindow
	))
end

function LoadoutWindow:Init()
	self.Root.Contents.PVP.Visible = _G.PVP_SHOP_ENABLED

	for i = 1, 6 do
		local child = self.Core.towers:FindFirstChild(i)
		self.Cleaner:Add(child.MouseEnter:Connect(function()
			child.TextLabel.Visible = true
			child.over.Visible = true
		end))
		self.Cleaner:Add(child.MouseLeave:Connect(function()
			child.TextLabel.Visible = false
			child.over.Visible = false
		end))
		self.Cleaner:Add(child.SelectionGained:Connect(function()
			child.TextLabel.Visible = true
			child.over.Visible = true
		end))
		self.Cleaner:Add(child.SelectionLost:Connect(function()
			child.TextLabel.Visible = false
			child.over.Visible = false
		end))
	end

	if _G.PVP_SHOP_ENABLED then
		local template = self.Root.Contents.PVP.EnemiesLoadout.Template

		for i = 1, _G.PVP_ENEMY_LOADOUT_MAX_SIZE do
			local clone = template:Clone()
			clone.Name = tostring(i)
			clone.Parent = self.Root.Contents.PVP.EnemiesLoadout
			clone.Visible = true
			self.Cleaner:Add(clone.MouseEnter:Connect(function()
				clone.NameLabel.Visible = true
				clone.Over.Visible = true
			end))
			self.Cleaner:Add(clone.MouseLeave:Connect(function()
				clone.NameLabel.Visible = false
				clone.Over.Visible = false
			end))
			self.Cleaner:Add(clone.SelectionGained:Connect(function()
				clone.NameLabel.Visible = true
				clone.Over.Visible = true
			end))
			self.Cleaner:Add(clone.SelectionLost:Connect(function()
				clone.NameLabel.Visible = false
				clone.Over.Visible = false
			end))
		end
	end

	self.Cleaner:Add(UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed or IsInteractionBlocked() then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			local playerAtScreenPoint = GetPlayerAtScreenPoint(input.Position.X, input.Position.Y)

			if playerAtScreenPoint and playerAtScreenPoint ~= LocalPlayer then
				self.Root.Visible = true
				self:Update(playerAtScreenPoint)
			end
		end
	end))
	self.Cleaner:Add(UserInputService.TouchTap:Connect(function(list, p)
		if p or IsInteractionBlocked() then
			return
		end

		if not IsInteractionBlocked() then
			local playerAtScreenPoint = GetPlayerAtScreenPoint(list[1].X, list[1].Y)

			if playerAtScreenPoint and playerAtScreenPoint ~= LocalPlayer then
				self.Root.Visible = true
				self:Update(playerAtScreenPoint)
			end
		end
	end))
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = { CurrentCamera }
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	self.Cleaner:Add(UserInputService.InputChanged:Connect(function(input, gameProcessed)
		if gameProcessed then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement then
			local playerAtScreenPoint = GetPlayerAtScreenPoint(input.Position.X, input.Position.Y)
			local character

			if playerAtScreenPoint and playerAtScreenPoint ~= LocalPlayer then
				character = playerAtScreenPoint.Character
			end

			if self.Highlight.Adornee ~= character then
				self.Highlight.Adornee = character
			end
		end
	end))
	self.Cleaner:Add(self.Core.rightholder.refresh.MouseButton1Down:Connect(function()
		self:Update(self.LastPlayer)
	end))
	self.Cleaner:Add(self.Core.gift.MouseButton1Click:Connect(function()
		if self.LastPlayer and self.LastPlayer.Parent then
			for _, v in Director.GetItemsFromClass(Director.Classes.GiftingWindow) do
				v:SetTargetPlayerId(self.LastPlayer.UserId, self.LastPlayer.Name)
				v:SetTargetGift(nil, nil, nil)
			end

			for _, v in Director.GetItemsFromClass(Director.Classes.PopupWindows) do
				v:DoPopup("Gifting", function() end)
			end
		end
	end))
	local v = nil
	local attachment = Instance.new("Attachment")
	local proximityPrompt = Instance.new("ProximityPrompt")
	proximityPrompt.ActionText = "View Loadout"
	proximityPrompt.ObjectText = ""
	proximityPrompt.Parent = attachment
	attachment.Parent = workspace.Terrain
	self.Cleaner:Add(RunService.Heartbeat:Connect(function()
		if UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
			local now2 = tick()

			if now2 - now >= 0.1 then
				now = now2
				local position = LocalPlayer.Character and LocalPlayer.Character:GetPivot().Position
					or createVector(0, 0, 0)
				local v2 = 1e999
				local v3 = nil

				for _, v4 in Players:GetPlayers() do
					if v4 == LocalPlayer then
						continue
					end

					local position2 = v4.Character and v4.Character:GetPivot().Position

					if not position2 then
						continue
					end

					local magnitude = (position - position2).Magnitude

					if not (magnitude < v2) then
						continue
					end

					v3 = v4
					v2 = magnitude
				end

				if v3 then
					local position2 = v3.Character and v3.Character:GetPivot().Position
					proximityPrompt.ObjectText = `{v3.Name}`
					v = v3
					attachment.CFrame = CFrame.new(position2)
				else
					v = nil
					attachment.CFrame = CFrame.identity
				end
			end
		end
	end))
	self.Cleaner:Add(proximityPrompt.Triggered:Connect(function()
		self.Root.Visible = true
		self:Update(v)
	end))
	self.Cleaner:Add(self.Core.invitetoparty.MouseButton1Click:Connect(function()
		Network.Fire("ClientInviteToPartyRequest", self.LastPlayer)
		self.Root.Visible = false

		for _, v2 in Director.GetItemsFromClass(Director.Classes.PartyMinimised) do
			v2.Root.Visible = false
		end

		for _, v2 in Director.GetItemsFromClass(Director.Classes.PartyWindow) do
			v2:Maximise()
		end
	end))
	self:Update(LocalPlayer)
end

function LoadoutWindow:LoadingState(player)
	self.Core.username.Text = "@" .. player.Name
	self.Core.displayname.Text = player.DisplayName
	self.Core.level.Text = "..."
	self.Core.headshot.Image = Players:GetUserThumbnailAsync(
		player.UserId,
		Enum.ThumbnailType.HeadShot,
		Enum.ThumbnailSize.Size100x100
	)
	self.Core.invitetoparty.Visible = false
	self.Core.noinvite.Visible = false

	for i = 1, 6 do
		self.Core.towers:FindFirstChild(i).img:ClearAllChildren()
		self.Core.towers[i].TextLabel.Text = "..."
	end

	if _G.PVP_SHOP_ENABLED then
		for i = 1, _G.PVP_ENEMY_LOADOUT_MAX_SIZE do
			local v = self.Root.Contents.PVP.EnemiesLoadout[tostring(i)]

			for _, viewportFrame in v.MainFrame:GetChildren() do
				if viewportFrame:IsA("ViewportFrame") then
					viewportFrame:Destroy()
				end
			end

			v.NameLabel.Text = "..."
		end
	end

	for _, image in self.Core.wins:GetChildren() do
		if image:IsA("ImageLabel") then
			image.TextLabel.Text = "..."
		end
	end
end

function LoadoutWindow:Update(lastPlayer)
	if lastPlayer then
		self.LastPlayer = lastPlayer
		self:LoadingState(lastPlayer)
		local v = Network.Invoke("ClientGetLoadoutForPlayerRequest", lastPlayer)

		if v then
			local xpToLevelAndProgress = Util.XPToLevelAndProgress(v.XP)
			self.Core.username.Text = "@" .. lastPlayer.Name
			self.Core.displayname.Text = lastPlayer.DisplayName
			self.Core.level.Text = "Level " .. xpToLevelAndProgress
			self.Core.headshot.Image = Players:GetUserThumbnailAsync(
				lastPlayer.UserId,
				Enum.ThumbnailType.HeadShot,
				Enum.ThumbnailSize.Size100x100
			)

			for i = 1, 6 do
				self.Core.towers:FindFirstChild(i).img:ClearAllChildren()
				local tower = v.Towers[i]

				if not (tower and tower ~= "") then
					continue
				end

				local skin = v.Skins[tower]
				self.Core.towers[i].TextLabel.Text = tower
				GetViewport(tower, skin, self.Core.towers:FindFirstChild(i).img) -- inferred equivalent call
			end

			if _G.PVP_SHOP_ENABLED then
				for i = 1, _G.PVP_ENEMY_LOADOUT_MAX_SIZE do
					local v2 = self.Root.Contents.PVP.EnemiesLoadout[tostring(i)]

					for _, viewportFrame in v2.MainFrame:GetChildren() do
						if viewportFrame:IsA("ViewportFrame") then
							viewportFrame:Destroy()
						end
					end

					local enemy = v.Enemies[i]

					if enemy and enemy ~= "" then
						local enemy2 = ShopDataV2.Items.Enemies[enemy]
						local overrideDisplayName = ResourceManager.GetEnemyConfig(enemy).OverrideDisplayName or enemy
						v2.NameLabel.Text = overrideDisplayName
						EnemyViewport.Build(v2.MainFrame, enemy, {
							RotationOffset = enemy2.ViewportRotationOffset,
							Zoom = enemy2.ViewportZoom
						})
					else
						v2.NameLabel.Text = "..."
					end
				end
			end

			local v2 = {}

			for _, medal in v.Medals do
				for k, v3 in medal do
					v2[k] = (v2[k] or 0) + math.max(v3, 1)
				end
			end

			for _, image in self.Core.wins:GetChildren() do
				if image:IsA("ImageLabel") then
					image.TextLabel.Text = v2[image.Name] or "0"
				end
			end

			self.Core.QuestStreaks.Daily.Streak.Text = v.QuestStreaks.Daily
			self.Core.QuestStreaks.Weekly.Streak.Text = v.QuestStreaks.Weekly
			local partyData = PartyClient.GetPartyData()

			if v.CanBeInvitedToParty == false then
				self.Core.noinvite.Visible = true
				self.Core.noinvite.reason.Text = "User is already in a party."
			elseif partyData.Leader == LocalPlayer then
				if #partyData.Players == partyData.MaxPlayers then
					self.Core.noinvite.Visible = true
					self.Core.noinvite.reason.Text = "Party is at maximum capacity."
				elseif partyData.Matchmaking.State == "Inactive" then
					if LocalPlayer == lastPlayer then
						self.Core.noinvite.Visible = true
						self.Core.noinvite.reason.Text = "You can't invite yourself."
					elseif
						partyData.Invited[lastPlayer.Name]
						and partyData.Invited[lastPlayer.Name].State == "Declined"
					then
						self.Core.noinvite.Visible = true
						self.Core.noinvite.reason.Text = "User declined invitation to this party."
					else
						self.Core.invitetoparty.Visible = true
					end
				else
					self.Core.noinvite.Visible = true
					self.Core.noinvite.reason.Text = "Game is starting/being searched for."
				end
			else
				self.Core.noinvite.Visible = true
				self.Core.noinvite.reason.Text = "You aren't the party leader."
			end
		end
	end
end

function LoadoutWindow:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { LoadoutWindow }, LocalPlayer)
return LoadoutWindow