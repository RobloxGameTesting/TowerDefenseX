game:GetService("MarketplaceService")
game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
require(TDX_Shared.Modules.DataTemplate)
require(Common:WaitForChild("SoundHandler"))
require(script.Parent.Tabs)
local Shared = require(TDX_Shared.Modules.Shared)
require(TDX_Shared.Client.Services.Data)
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
require(TDX_Shared.Modules.Lang)
require(game.ReplicatedFirst.Client.Network)
local Enums = require(TDX_Shared.Common.Enums)
local ItemBox = require(script.Parent.Parent.V2.ItemBox)
local v = {
	XMAS25 = {
		{ Type = "Towers", Item = Enums.Towers.PsychoSlayer },
		{ Type = "Crates", Item = "WinterOpsCrate" },
		{ Type = "NameTagEffects", Item = "NorthPoleStars" },
		{ Type = "Skins", Item = "EDJ_Jolly" },
		{ Type = "PowerUps", Item = "MegaZed" }
	},
	LNY26 = {
		{ Type = "Crates", Item = "LunarCrate" },
		{ Type = "Emotes", Item = "Lantern" },
		{ Type = "Emotes", Item = "Rice Cake Soup" },
		{ Type = "NameTagEffects", Item = "LunarNewYear2026" }
	},
	EASTER26 = {
		{ Type = "Skins", Item = "Oil Derrick_Candy Mine" },
		{ Type = "NameTagEffects", Item = "EasterStickers" },
		{ Type = "PowerUps", Item = Enums.PowerUps.GoldenZed },
		{ Type = "Towers", Item = Enums.Towers.BubbleBlower, OverrideInactiveText = "Coming Soon" }
	},
	FOURTHOFJULY26 = {
		{ Type = "Towers", Item = Enums.Towers.MLRS },
		{ Type = "Skins", Item = "Refractor_Home Defender" },
		{ Type = "Skins", Item = "Oil Derrick_WowBurger" },
		{ Type = "Skins", Item = "Behemoth Factory_Spider Tank" },
		{ Type = "PowerUps", Item = Enums.PowerUps.B52Bomber },
		{ Type = "Crates", Item = "JulyCrate" },
		{ Type = "Emotes", Item = "BBQ" },
		{ Type = "Emotes", Item = "Fountain" }
	}
}
local v2 = { FOURTHOFJULY26 = UDim.new(0, 220) }

local function CreateItemBox(parent, udim: UDim?)
	local clone = game.ReplicatedStorage.LobbyResources.GuiTemplates.ItemBox:Clone()
	clone.Parent = parent
	clone:AddTag("ItemBox")
	local classObjectYields = Director.GetClassObjectYields(clone, ItemBox)
	classObjectYields:SetHeight(udim or UDim.new(1, 0))
	return classObjectYields
end

local EventShopWindow = { ClassName = script.Name, ClassModule = script }
EventShopWindow.__index = EventShopWindow

function EventShopWindow.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, EventShopWindow))
end

function EventShopWindow:Init()
	local devHotkey = Shared.IS_DEV_PLACE and self.Root:GetAttribute("DevHotkey")

	if devHotkey then
		self.Cleaner:Add(UserInputService.InputBegan:Connect(function(input, _)
			if
				input.UserInputType == Enum.UserInputType.Keyboard
				and input.KeyCode == Enum.KeyCode:FromName(devHotkey)
			then
				self.Root.Visible = not self.Root.Visible
			end
		end))
	end

	self.EventShopType = self.Root:GetAttribute("EventShopType")

	if not v[self.EventShopType] then
		warn(`Unknown shop type: {self.EventShopType}`)
		return
	end

	for _, v3 in ipairs(v[self.EventShopType]) do
		self:AddItemBox(v3)
	end

	print(`EventShopWindow {self.EventShopType} init!`)
end

function EventShopWindow:AddItemBox(data)
	local itemBox = CreateItemBox(self.Root.Items, v2[self.EventShopType])
	itemBox:SetItem(data.Type, data.Item)
	itemBox.Activated:Connect(function()
		if data.Type == "NameTagEffects" or data.Type == "Emotes" then
			return
		end

		self:Hide()

		local function fn()
			self.Root.Visible = true
		end

		local v3 = _G.SHOP_V3_ENABLED and "V3" or "V2"

		if data.Type == "Towers" then
			UIHelper.NavigateToTowerPreview(v3, data.Item, nil, "Event Shop", fn)
		elseif data.Type == "Skins" then
			local v4, v5 = unpack(string.split(data.Item, "_"))
			UIHelper.NavigateToTowerPreview(v3, v4, v5, "Event Shop", fn)
		elseif data.Type == "PowerUps" then
			UIHelper.NavigateToPowerUpPreview(v3, data.Item, "Event Shop", fn)
		elseif data.Type == "Crates" then
			UIHelper.NavigateToCratePreview(v3, data.Item, "Event Shop", fn)
		end
	end)

	if data.OverrideInactiveText then
		itemBox.Root.Buttons.Inactive.Button.Holder.Label.Text = data.OverrideInactiveText
	end

	return itemBox
end

function EventShopWindow:Hide()
	self.Root.Visible = false
end

function EventShopWindow.Update(_) end

function EventShopWindow.Destroy(p)
	p.Cleaner:Clean()
end

if _G.FOURTH_OF_JULY_2026_EVENT_ENABLED then
	Director.Register(script.Name, { EventShopWindow }, game.Players)
end

return EventShopWindow