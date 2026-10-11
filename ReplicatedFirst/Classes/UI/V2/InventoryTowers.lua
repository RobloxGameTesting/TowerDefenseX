local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedFirst.Client.Network)
local ClientUtil = require(ReplicatedFirst.Util.ClientUtil)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
require(ReplicatedStorage.TDX_Shared.Common.ResourceManager)
local TowerUtilities = require(ReplicatedStorage.TDX_Shared.Common.TowerUtilities)
require(ReplicatedStorage.TDX_Shared.Common.SkinHandler)
local SoundHandler = require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local UIHelper = require(game.ReplicatedFirst.Util.UIHelper)
local InventoryTowers = { ClassName = script.Name, ClassModule = script }
InventoryTowers.__index = InventoryTowers
local v = { ["Current loadout"] = 0, ["Preset 1"] = 1, ["Preset 2"] = 2, ["Preset 3"] = 3 }
local udim = UDim2.new(1.05, 0, 1.15, 0)
local udim2 = UDim2.new(0.5, 0, 0.475, 0)

local function GetViewport(viewportName: string, p: string, mainFrame, udim3: UDim2?) -- 1 equivalent call inferred from this helper
	local viewport = TowerUtilities.GetViewport(mainFrame, viewportName, p)
	viewport.ZIndex = 3
	viewport.Size = udim3 or udim
	viewport.Position = udim2
	return viewport
end

function InventoryTowers.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), Preset = 0, Animations = {} }, InventoryTowers))
end

function InventoryTowers:Init()
	self.Root.buttons.Visible = self.Preset > 0
	local windowHandlerGroup = UIHelper.FindWindowHandlerGroup(self.Root)

	if not windowHandlerGroup then
		warn(`Failed to find WindowHandler from {self.Root:GetFullName()}`)
		windowHandlerGroup = "V2"
	end

	self.WindowGroup = windowHandlerGroup
	self:UpdateTowers()
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "Loadout" or p == "LoadoutPresets" or p == "TowerSkins" then
			self:UpdateTowers()
		end
	end))

	for i = 1, 6 do
		local child = self.Root.Frame:FindFirstChild(i)

		if not child then
			continue
		end

		local v2 = i
		child.Trash.MouseButton1Click:Connect(function()
			local v3 = self:GetLoadout()[v2]

			if v3 and v3 ~= "" and self.Preset == 0 and ClientUtil.UnequipItem("Towers", v3) then
				SoundHandler.Play("Unequip")
				self:UpdateTowers()
			end
		end)
		local v3 = i
		child.Button.MouseButton1Click:Connect(function()
			local v4 = self:GetLoadout()[v3]

			if v4 == "" then
				return
			end

			local v5 = Data.Get("TowerSkins")[v4] or ""
			local v6 = v5 == "" and "Default" or v5

			for _, v7 in Director.GetItemsFromClass(Director.Classes.TowerPreview) do
				v7:ShowTowerAndSkin(v4, v6)
			end

			UIHelper.NavigateToTowerPreview(self.WindowGroup, v4, v6, "Inventory", function()
				local firstItem = Director.GetFirstItemFromClass(Director.Classes.NewInventoryWindow)

				if firstItem then
					firstItem:Show()
				end
			end)
		end)
	end

	local selector = self.Root.selector

	for k, layoutOrder in v do
		local clone = selector.dropdown.ImageLabel.template:Clone()
		clone.Name = k
		clone.LayoutOrder = layoutOrder
		clone.TextButton.label.Text = k
		clone.TextButton.MouseButton1Down:Connect(function()
			SoundHandler.Play("ClickDown")
		end)
		local text = k
		local preset = layoutOrder
		clone.TextButton.MouseButton1Click:Connect(function()
			SoundHandler.Play("ClickUp")
			clone.TextButton.BackgroundTransparency = 1
			selector.label.Text = text
			selector.label.TextColor3 = Color3.fromRGB(129, 170, 36)
			selector.default.Visible = true
			selector.open.Visible = false
			selector.hover.Visible = false
			selector.dropdown.Visible = false
			self.Preset = preset
			self:UpdateTowers()
			self.Root.buttons.Visible = self.Preset > 0
		end)
		clone.TextButton.MouseEnter:Connect(function()
			clone.TextButton.BackgroundTransparency = 0.8
		end)
		clone.TextButton.MouseLeave:Connect(function()
			clone.TextButton.BackgroundTransparency = 1
		end)
		clone.Visible = true
		clone.Parent = selector.dropdown.ImageLabel
	end

	local color = Color3.fromRGB(129, 170, 36)
	local color2 = Color3.fromHex("B4FF00")
	local selector2 = self.Root.selector
	self.Cleaner:Add(selector2.TextButton.MouseEnter:Connect(function()
		if not selector2.dropdown.Visible then
			selector2.label.TextColor3 = color2
			selector2.default.Visible = false
			selector2.open.Visible = false
			selector2.hover.Visible = true
		end
	end))
	self.Cleaner:Add(selector2.TextButton.MouseLeave:Connect(function()
		if not selector2.dropdown.Visible then
			selector2.label.TextColor3 = color
			selector2.default.Visible = true
			selector2.open.Visible = false
			selector2.hover.Visible = false
		end
	end))
	self.Cleaner:Add(selector2.TextButton.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	self.Cleaner:Add(selector2.TextButton.MouseButton1Click:Connect(function()
		SoundHandler.Play("ClickUp")

		if selector2.dropdown.Visible then
			selector2.label.TextColor3 = color2
			selector2.default.Visible = false
			selector2.open.Visible = false
			selector2.hover.Visible = true
			selector2.dropdown.Visible = false
		else
			selector2.label.TextColor3 = color2
			selector2.default.Visible = false
			selector2.open.Visible = true
			selector2.hover.Visible = false
			selector2.dropdown.Visible = true
		end
	end))
	local main = self.Root.buttons.buytwo.main
	main.left.MouseEnter:Connect(function()
		main.hoverleft.ImageTransparency = 0
		main.hoverright.ImageTransparency = 1
		main.pressleft.ImageTransparency = 1
		main.pressright.ImageTransparency = 1
	end)
	main.left.MouseLeave:Connect(function()
		main.hoverleft.ImageTransparency = 1
	end)
	main.right.MouseEnter:Connect(function()
		main.hoverleft.ImageTransparency = 1
		main.hoverright.ImageTransparency = 0
		main.pressleft.ImageTransparency = 1
		main.pressright.ImageTransparency = 1
	end)
	main.right.MouseLeave:Connect(function()
		main.hoverright.ImageTransparency = 1
	end)
	main.left.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
		main.hoverleft.ImageTransparency = 1
		main.hoverright.ImageTransparency = 1
		main.pressleft.ImageTransparency = 0
		main.pressright.ImageTransparency = 1
	end)
	main.right.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
		main.hoverleft.ImageTransparency = 1
		main.hoverright.ImageTransparency = 1
		main.pressleft.ImageTransparency = 1
		main.pressright.ImageTransparency = 0
	end)
	main.left.MouseButton1Up:Connect(function()
		main.pressleft.ImageTransparency = 1
	end)
	main.left.Activated:Connect(function()
		SoundHandler.Play("ClickUp")

		if Network.Invoke("ClientManagePresetRequest", self.Preset, "a") then
			self.Preset = 0
			self:UpdateTowers()
			self.Root.buttons.Visible = false
			self.Root.selector.label.Text = "Current loadout"
		end
	end)
	main.right.MouseButton1Up:Connect(function()
		main.pressright.ImageTransparency = 1
	end)
	main.right.Activated:Connect(function()
		SoundHandler.Play("ClickUp")
		Network.Invoke("ClientManagePresetRequest", self.Preset, "b")
	end)
end

function InventoryTowers:GetLoadout()
	local loadout = Data.Get("Loadout")

	if self.Preset > 0 then
		loadout = Data.Get("LoadoutPresets")[self.Preset]
	end

	return loadout
end

function InventoryTowers:UpdateTowers()
	local loadout = self:GetLoadout()

	for i = 1, 6 do
		local v2 = loadout[i] or ""
		local child = self.Root.Frame:FindFirstChild(i)

		if not child then
			continue
		end

		local tower = ShopDataV2.Items.Towers[v2]

		if tower or v2 == "" then
			local viewportName = tower and tower.ViewportName or ""
			local viewportFrame = child.MainFrame:FindFirstChildOfClass("ViewportFrame")
			child:SetAttribute("LastTower", v2)

			if viewportFrame then
				viewportFrame:Destroy()
			end

			if self.Animations[i] then
				self.Animations[i]:Destroy()
			end

			if child.Trash then
				local trash = child.Trash
				trash.Visible = viewportName ~= "" and self.Preset == 0
			end

			if viewportName ~= "" then
				GetViewport(viewportName, Data.Get("TowerSkins")[viewportName] or "", child.MainFrame) -- inferred equivalent call
			end
		else
			warn("Didn't find tower with name " .. v2)
		end
	end
end

function InventoryTowers:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { InventoryTowers }, game.Players)
return InventoryTowers