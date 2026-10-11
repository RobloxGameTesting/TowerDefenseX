local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("ResourceManager"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
require(common:WaitForChild("Enums"))
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
require(ReplicatedStorage.TDX_Shared.Common.SkinHandler)
local TowerUtilities = require(ReplicatedStorage.TDX_Shared.Common.TowerUtilities)
require(ReplicatedStorage.TDX_Shared.Common.ScalingHandler)
require(ReplicatedStorage.TDX_Shared.Modules.Shared)
require(ReplicatedStorage.TDX_Shared.Modules.Crates)
require(ReplicatedStorage.TDX_Shared.SkinData.SkinUtilities)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
require(ReplicatedFirst.Client.Network)
local ShopDataV2 = require(ReplicatedStorage.Modules.ShopDataV2)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local udim = UDim2.new(1.05, 0, 1.15, 0)
local udim2 = UDim2.new(0.5, 0, 0.475, 0)
local TowerBar = { ClassName = script.Name, ClassModule = script }
TowerBar.__index = TowerBar

local function GetViewport(viewportName: string, p: string, mainFrame, udim3: UDim2?) -- 1 equivalent call inferred from this helper
	local viewport = TowerUtilities.GetViewport(mainFrame, viewportName, p, nil, nil, nil, nil, nil, true)
	viewport.ZIndex = 3
	viewport.Size = udim3 or udim
	viewport.Position = udim2
	return viewport
end

function TowerBar.new(root)
	return (setmetatable({ Root = root, Animations = {}, Cleaner = Cleaner.new() }, TowerBar))
end

function TowerBar:Init()
	local root = self.Root
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "Loadout" then
			self:Update()
		elseif p == "TowerSkins" then
			self:Update(true)
		end
	end))
	self.Cleaner:Add(root.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
	self.Cleaner:Add(root.Activated:Connect(function()
		Director.GetFirstItemFromClass(Director.Classes.V2Sidebar):NavigateToInventory("Towers")
		SoundHandler.Play("ClickUp")
	end))

	for i = 1, 6 do
		local child = root:FindFirstChild(i)

		if not child then
			continue
		end

		local v = i
		self.Cleaner:Add(child.Skins.Activated:Connect(function()
			self:ShowSkinSelect(Data.Get("Loadout")[v])
		end))
	end

	self:Update()
end

function TowerBar.HideSkinSelect(p)
	p.Root.Parent.SkinSelect.Visible = false
end

function TowerBar:ShowSkinSelect(p: string)
	for _, v in Director.GetItemsFromClass(Director.Classes.CrateSpin) do
		if v.Unboxing then
			return
		end
	end

	local v = Data.Get("TowerSkins")[p] or ""
	local v2 = v == "" and "Default" or v
	local v3 = _G.SHOP_V3_ENABLED and "V3" or "V2"
	UIHelper.NavigateToTowerPreview(v3, p, v2, "Shop")
end

function TowerBar:Update(flag: boolean?)
	local loadout = Data.Get("Loadout")

	for i = 1, 6 do
		local v = loadout[i] or ""
		local child = self.Root:FindFirstChild(i)

		if not child then
			continue
		end

		local tower = ShopDataV2.Items.Towers[v]

		if tower or v == "" then
			local viewportName = tower and tower.ViewportName or ""
			local viewportFrame = child.MainFrame:FindFirstChildOfClass("ViewportFrame")

			if child:GetAttribute("LastTower") ~= v or not viewportFrame or flag then
				child:SetAttribute("LastTower", v)

				if viewportFrame then
					viewportFrame:Destroy()
				end

				if self.Animations[i] then
					self.Animations[i]:Destroy()
				end

				child.Skins.Visible = viewportName ~= ""

				if viewportName ~= "" then
					GetViewport(viewportName, Data.Get("TowerSkins")[viewportName] or "", child.MainFrame) -- inferred equivalent call
				end
			end
		else
			warn("Didn't find tower with name " .. v)
			loadout[i] = ""
		end
	end
end

function TowerBar:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { TowerBar }, PlayerGui)
return TowerBar