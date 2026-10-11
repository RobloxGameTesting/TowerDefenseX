local GuiService = game:GetService("GuiService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
require(ReplicatedStorage.TDX_Shared.Common.ResourceManager)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local EmoteAnimationsV2 = require(ReplicatedStorage.TDX_Shared.Modules.EmoteAnimationsV2)
local EmoteUtilities = require(ReplicatedStorage.TDX_Shared.Modules.EmoteUtilities)
local EmoteVariants = require(ReplicatedStorage.TDX_Shared.Modules.EmoteVariants)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Shared = require(ReplicatedStorage.TDX_Shared.Modules.Shared)
require(ReplicatedStorage.TDX_Shared.Common.CurrencyTypes)
local TowerUtilities = require(ReplicatedStorage.TDX_Shared.Common.TowerUtilities)
local Util = require(ReplicatedStorage.TDX_Shared.Modules.Util)
local UIHelper = require(game.ReplicatedFirst.Util.UIHelper)
local EnemyViewport = require(ReplicatedStorage.TDX_Shared.Common.EnemyViewport)
local udim = UDim2.new(1.2, 0, 1.2, 0)
local udim2 = UDim2.new(0.5, 0, 0.5, 0)
local v = {
	Confirmation = "confirmation",
	NotEnoughGold = "moregold",
	Gifting = "gifting",
	TextConfirmation = "TextConfirmation"
}
local PopupWindows = { ClassName = script.Name, ClassModule = script }
PopupWindows.__index = PopupWindows

local function SetupTowerViewport(p: string, p2: string?, p3)
	local viewport = TowerUtilities.GetViewport(p3, p, p2)
	viewport.ZIndex = 3
	viewport.Size = udim
	viewport.Position = udim2
	viewport.ImageColor3 = Color3.new(1, 1, 1)
end

local function SetWindowHandlerInteractable(interactable: boolean) -- 2 equivalent calls inferred from this helper
	for _, v2 in Director.GetItemsFromClass(Director.Classes.WindowHandler) do
		v2.Root.Interactable = interactable
	end
end

function PopupWindows.new(root)
	return (setmetatable({ Root = root, CurrCallback = nil, Cleaner = Cleaner.new() }, PopupWindows))
end

function PopupWindows:Init()
	local blurEffect = Instance.new("BlurEffect")
	blurEffect.Enabled = false
	blurEffect.Size = 20
	blurEffect.Name = "PopupBlur"
	blurEffect.Parent = game:GetService("Lighting")
	self.BlurEffect = blurEffect

	for _, childName in v do
		local child = self.Root:FindFirstChild(childName)

		if not child then
			continue
		end

		local buttons = child:FindFirstChild("Buttons")

		if not (buttons and buttons:FindFirstChild("Cancel") and buttons:FindFirstChild("Buy")) then
			continue
		end

		self.Cleaner:Add(buttons.Cancel.MouseButton1Click:Connect(function()
			self:HideAll()

			if self.CurrCallback then
				task.spawn(
					self.CurrCallback,
					false,
					self.CurrOptions and self.CurrOptions.ItemOptions and self.CurrOptions.ItemOptions.Currency
				)
				self.CurrCallback = nil
			end
		end))
		self.Cleaner:Add(buttons.Buy.MouseButton1Click:Connect(function()
			self:HideAll()

			if self.CurrCallback then
				task.spawn(
					self.CurrCallback,
					true,
					self.CurrOptions and self.CurrOptions.ItemOptions and self.CurrOptions.ItemOptions.Currency
				)
				self.CurrCallback = nil
			end
		end))
	end
end

function PopupWindows:HideAll()
	self.Root.Visible = false
	self.BlurEffect.Enabled = false
	SetWindowHandlerInteractable(true) -- inferred equivalent call

	for _, childName in v do
		local child = self.Root:FindFirstChild(childName)

		if child then
			child.Visible = false
		end
	end
end

function PopupWindows:_ShowTextConfirmation(callback, p)
	local textConfirmationOptions = p.TextConfirmationOptions

	if not textConfirmationOptions then
		warn("TextConfirmationOptions cannot be nil for TextConfirmation")
		return
	end

	local buttons = self.Root.TextConfirmation.Buttons
	local textConfirmation = self.Root.TextConfirmation
	textConfirmation.Title.Text = textConfirmationOptions.Title
	textConfirmation.Subtitle.Text = textConfirmationOptions.Subtitle
	textConfirmation.Info.Text = textConfirmationOptions.Description
	textConfirmation.Bar.BackgroundColor3 = textConfirmationOptions.Color
	textConfirmation.Title.TextColor3 = textConfirmationOptions.Color
	buttons.Primary.TextLabel.Text = textConfirmationOptions.PrimaryButtonText
	buttons.Secondary.TextLabel.Text = textConfirmationOptions.SecondaryButtonText
	buttons.Primary.Visible = textConfirmationOptions.PrimaryButtonText ~= ""
	buttons.Secondary.Visible = textConfirmationOptions.SecondaryButtonText ~= ""
	local maid = Cleaner.new()
	maid:Add(buttons.Primary.Activated:Connect(function()
		self:HideAll()

		if callback then
			task.spawn(callback, true)
			maid:Clean()
		end
	end))
	maid:Add(buttons.Secondary.Activated:Connect(function()
		self:HideAll()

		if callback then
			task.spawn(callback, false)
			maid:Clean()
		end
	end))
	textConfirmation.Visible = true
	self.Root.Visible = true
end

function PopupWindows:DoPopup(p: string, currCallback, currOptions)
	self.CurrCallback = currCallback
	self.CurrOptions = currOptions
	self:HideAll()
	local child = self.Root:FindFirstChild(v[p] or "")

	if child then
		self.BlurEffect.Enabled = true
		SetWindowHandlerInteractable(false) -- inferred equivalent call

		if p == "Gifting" then
			self.Root.Visible = true
			child.Visible = true
			return
		else
			if currOptions == nil then
				warn(`PopupOptions cannot be nil for style {p}`)
				return
			end

			if p == "TextConfirmation" then
				return self:_ShowTextConfirmation(currCallback, currOptions)
			end

			if currOptions.ItemOptions == nil then
				warn(`ItemOptions cannot be nil for style {p}`)
				return
			end

			if p == "Confirmation" then
				local titleVerb = currOptions.ItemOptions.TitleVerb
					or currOptions.ItemOptions.ItemType == "Crates" and "Spin"
					or "Buy"
				child.itemtitle.Text = `{titleVerb} {currOptions.ItemOptions.DisplayName}`
				child.balanceholder.label2.Text = ` {Util.FormatCurrency(currOptions.ItemOptions.CurrentBalance - currOptions.ItemOptions.Price)}`
				child.balanceholder.icon.Image = Shared.CURRENCY_ICONS_NO_COLOR[currOptions.ItemOptions.Currency]
			elseif p == "NotEnoughGold" then
				child.itemtitle.Text = `Insufficient {currOptions.ItemOptions.Currency}`
				local isCurrencyPurchasable = UIHelper.IsCurrencyPurchasable(currOptions.ItemOptions.Currency)
				child.itemtitle2.Text = not isCurrencyPurchasable and ""
					or `Would you like to buy more {currOptions.ItemOptions.Currency}?`
					or ""
				child.Buttons.Buy.Visible = isCurrencyPurchasable
			end

			child.itemname.Text = currOptions.ItemOptions.DisplayName
			child.priceholder.label.Text = ` {Util.FormatCurrency(currOptions.ItemOptions.Price)}`
			child.priceholder.label.TextColor3 = Shared.CURRENCY_COLORS[currOptions.ItemOptions.Currency]
			child.priceholder.icon.Image = Shared.CURRENCY_ICONS[currOptions.ItemOptions.Currency]
			local v2 = ShopDataV2.Items[currOptions.ItemOptions.ItemType][currOptions.ItemOptions.InternalName]
			local viewportFrame = child.icon:FindFirstChildOfClass("ViewportFrame")

			if viewportFrame then
				viewportFrame:Destroy()
			end

			if currOptions.ItemOptions.ItemType == "Towers" then
				child.icon.Image = ""
				task.spawn(SetupTowerViewport, currOptions.ItemOptions.InternalName, nil, child.icon)
			elseif currOptions.ItemOptions.ItemType == "Skins" then
				child.icon.Image = ""
				local v3, v4 = unpack(string.split(currOptions.ItemOptions.InternalName, "_"))
				task.spawn(SetupTowerViewport, v3, v4, child.icon)
			elseif currOptions.ItemOptions.ItemType == "Emotes" then
				child.icon.Image = ""

				if EmoteAnimationsV2[currOptions.ItemOptions.InternalName] then
					local clone = game.ReplicatedStorage.LobbyResources.emotevp:Clone()
					clone.Visible = true
					local baseCharacter = EmoteUtilities.CloneBaseCharacter()
					EmoteUtilities.SetupViewport(
						clone,
						baseCharacter,
						EmoteAnimationsV2[EmoteVariants.Resolve(currOptions.ItemOptions.InternalName, baseCharacter)]
					)
					clone.Parent = child.icon
				end
			elseif currOptions.ItemOptions.ItemType == "Enemies" then
				child.icon.Image = ""
				task.spawn(EnemyViewport.Build, child.icon, currOptions.ItemOptions.InternalName, {
					RotationOffset = v2.ViewportRotationOffset,
					Zoom = v2.ViewportZoom
				})
			else
				child.icon.Image = v2.Image or ""

				if v2.ShopCardOverrideAspectRatio then
					child.icon.UIAspectRatioConstraint.AspectRatio = v2.ShopCardOverrideAspectRatio
				else
					child.icon.UIAspectRatioConstraint.AspectRatio = 1
				end
			end

			child.Visible = true
		end
	end

	self.Root.Visible = true

	if
		child
		and UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1
		and child:FindFirstChild("Buttons")
	then
		GuiService.SelectedObject = child.Buttons.Buy
	end
end

function PopupWindows:Destroy() end

Director.Register(script.Name, { PopupWindows }, game.Players)
return PopupWindows