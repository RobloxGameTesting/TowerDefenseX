local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Network = require(ReplicatedFirst.Client.Network)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local SoundHandler = require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local EmoteAnimationsV2 = require(ReplicatedStorage.TDX_Shared.Modules.EmoteAnimationsV2)
local EmoteUtilities = require(ReplicatedStorage.TDX_Shared.Modules.EmoteUtilities)
local EmoteVariants = require(ReplicatedStorage.TDX_Shared.Modules.EmoteVariants)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local InventoryEmotes = { ClassName = script.Name, ClassModule = script }
InventoryEmotes.__index = InventoryEmotes

local function IsVisibleOnScreen(parent)
	while parent do
		if parent:IsA("GuiObject") and not parent.Visible then
			return false
		else
			parent = parent.Parent
		end
	end

	return true
end

local function getSelectedFromXY(frame, p: number, p2: number, flag: boolean?)
	local absolutePosition = frame.AbsolutePosition
	local absoluteSize = frame.AbsoluteSize
	local v = absolutePosition.X + absoluteSize.X * 0.5
	local v2 = absolutePosition.Y + absoluteSize.Y * 0.5
	local v3 = math.fmod(math.deg((math.atan2(flag and p2 - v2 or v2 - p2, p - v))), 360) - 90

	if v3 < 0 then
		v3 += 360
	end

	return (math.ceil(v3 / 60))
end

function InventoryEmotes.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, InventoryEmotes))
end

function InventoryEmotes:SetupEmoteViewports()
	local baseCharacter = EmoteUtilities.CloneBaseCharacter()
	local emotes = Data.Get("Emotes")

	for i = 1, 6 do
		local child = self.Root.Frame:FindFirstChild(i)
		local emote = emotes[i]

		if not child then
			continue
		end

		child.ViewportFrame.WorldModel:ClearAllChildren()
		local equipped = child.equipped
		equipped.Visible = emote ~= nil and emote ~= ""
		child.empty.Visible = emote == nil or emote == ""

		if not emote then
			continue
		end

		local v = EmoteAnimationsV2[EmoteVariants.Resolve(emote, baseCharacter)]

		if v then
			EmoteUtilities.SetupViewport(child.ViewportFrame, baseCharacter, v)
		end
	end
end

function InventoryEmotes:UpdateSelected(p: number, p2: number, flag: boolean?)
	local absolutePosition = self.Root.Frame.AbsolutePosition
	local absoluteSize = self.Root.Frame.AbsoluteSize

	if
		absolutePosition.X <= p
		and p <= absolutePosition.X + absoluteSize.X
		and absolutePosition.Y <= p2
		and p2 <= absolutePosition.Y + absoluteSize.Y
	then
		local selectedFromXY = getSelectedFromXY(self.Root.Frame, p, p2, flag)
		self.Selected = selectedFromXY

		for i = 1, 6 do
			local child = self.Root.Frame:FindFirstChild(i)

			if not child then
				continue
			end

			if child.equipped.Visible then
				child.hover.Visible = i == selectedFromXY
			else
				child.hover.Visible = false
			end
		end
	else
		self.Selected = 0

		for i = 1, 6 do
			local child = self.Root.Frame:FindFirstChild(i)

			if child then
				child.hover.Visible = false
			end
		end
	end
end

function InventoryEmotes:RemoveEmote()
	if self.Selected and self.Selected ~= 0 and Network.Invoke("ClientEquipEmoteRequest", "", self.Selected) then
		SoundHandler.Play("Unequip")
		Data.Update("Emotes", function(options)
			local selected = options or {}
			selected[self.Selected] = ""
			return selected
		end)
		local itemHolder = self.Root.Parent.Parent:FindFirstChild("ItemHolder")
		local v = itemHolder and Director.GetClassesFromItem(itemHolder)[Director.Classes.ItemGridWindow]

		if v then
			v:UpdateAllBoxes(v.CurrPage)
		end
	end
end

function InventoryEmotes:Init()
	self.Cleaner:Add(UserInputService.InputChanged:Connect(function(input)
		if not IsVisibleOnScreen(self.Root) then
			return
		end

		if input.UserInputType == Enum.UserInputType.MouseMovement then
			self:UpdateSelected(input.Position.X, input.Position.Y)
		end
	end))
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "Emotes" then
			self:SetupEmoteViewports()
		end
	end))
	self.Cleaner:Add(UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed or not IsVisibleOnScreen(self.Root) then
			return
		end

		if
			self.Root.Frame.Visible
			and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.KeyCode == Enum.KeyCode.ButtonR2)
		then
			self:RemoveEmote()
		elseif self.Root.Frame.Visible and input.UserInputType == Enum.UserInputType.Touch then
			self:UpdateSelected(input.Position.X, input.Position.Y)
			self:RemoveEmote()
		end
	end))
	self.Root.BuyMore.Visible = _G.SHOP_V3_ENABLED
	self.Cleaner:Add(self.Root.BuyMore.MouseButton1Click:Connect(function()
		UIHelper.NavigateToWindow("NewShop", "V3")
		local firstItem = Director.GetFirstItemFromClass(Director.Classes.NewShopWindow)

		if firstItem then
			firstItem:ShowCategory("Emotes")
		end
	end))
	self:SetupEmoteViewports()
end

function InventoryEmotes.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { InventoryEmotes }, game.Players)
return InventoryEmotes