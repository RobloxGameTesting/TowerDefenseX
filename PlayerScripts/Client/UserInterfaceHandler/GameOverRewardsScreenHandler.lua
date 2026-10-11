local GameOverRewardsScreenHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("Types"))
require(Common:WaitForChild("Utilities"))
local TowerUtilities = require(Common:WaitForChild("TowerUtilities"))
local PowerUpsData = require(Common:WaitForChild("PowerUpsData"))
local Lang = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Lang"))
local SkinUtilities = require(TDX_Shared:WaitForChild("SkinData"):WaitForChild("SkinUtilities"))
local NameTagData = require(TDX_Shared.Modules.NameTagData)
local LocalPlayer = Players.LocalPlayer
local rewards = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("GameOverScreen"):WaitForChild("Rewards")
local content = rewards:WaitForChild("Content")
local rowTemplate = content:WaitForChild("RowTemplate")
local v = {}
local count = 0

local function GetScreenStartPosition() -- 2 equivalent calls inferred from this helper
	return UDim2.new(1.1, rewards.AbsoluteSize.X, 0.5, 0)
end

local function GetScreenEndPosition() -- 1 equivalent call inferred from this helper
	return UDim2.new(1, rewards.AbsoluteSize.X / 2, 0.5, 0)
end

local function NewItem(clone, p: string, p2: string?, image: string?, callback)
	local image2 = clone:FindFirstChild("Image")
	local viewportHolder = clone:FindFirstChild("ViewportHolder")
	local nameText = clone:FindFirstChild("NameText")
	local countText = clone:FindFirstChild("CountText")
	image2.Visible = false
	viewportHolder.Visible = false

	if image then
		image2.Image = image
		image2.Visible = true
	else
		local v2 = callback and callback(viewportHolder)

		if v2 then
			v2.Size = UDim2.new(0.98, 0, 0.98, 0)
			v2.Position = UDim2.new(0.5, 0, 0.5, 0)
			v2.Visible = true
			viewportHolder.Visible = true
		end
	end

	nameText.Text = p
	nameText.Visible = true

	if p2 then
		countText.Text = "x" .. tostring(p2)
		countText.Visible = true
	else
		countText.Visible = false
	end

	clone.Name = p
	clone.Visible = true
end

local function NewRow(category: string)
	local v2 = not v[category] and 1 or #v[category] + 1 or 1
	local clone = rowTemplate:Clone()
	local items = clone:FindFirstChild("Items")
	local itemTemplate = items:FindFirstChild("ItemTemplate")
	itemTemplate.Visible = false
	local v3 = {
		Index = v2,
		Category = category,
		RowFrame = clone,
		ItemHolder = items,
		ItemTemplate = itemTemplate,
		Items = {},
		ItemCount = 0,
		CanAddNewItem = function(self)
			return self.ItemCount < 3
		end,
		NewItem = function(self, p: string, p2: string?, image: string?, callback)
			local clone2 = itemTemplate:Clone()
			clone2.Parent = self.ItemHolder
			local newItem = NewItem(clone2, p, p2, image, callback)
			table.insert(self.Items, newItem)
			self.ItemCount += 1
		end,
		Destroy = function(self)
			self.RowFrame:Destroy()
		end
	}
	clone.Name = category .. tostring(v2)
	clone.Visible = true
	clone.Parent = content
	clone.LayoutOrder = count

	if not v[category] then
		v[category] = {}
	end

	table.insert(v[category], v3)
	count += 1
	return v3
end

local function AddItem(category: string, p: string, p2: string?, p3: string?, callback)
	local v2 = v[category]

	if not v2 then
		v2 = {}
		v[category] = v2
	end

	local v3 = v2[#v2]

	if not (v3 and v3:CanAddNewItem()) then
		v3 = NewRow(category)
	end

	v3:NewItem(p, p2, p3, callback)
end

local function ClearRows()
	for _, v2 in pairs(v) do
		for _, v3 in pairs(v2) do
			v3:Destroy()
		end
	end

	v = {}
end

function GameOverRewardsScreenHandler.DisplayScreen(duration: number, duration2: number, data)
	local flag = false
	local name = LocalPlayer.Name
	ClearRows()
	local v2 = data.PlayerNameToPowerUpsRewardedMapMap[name]

	if v2 then
		for k, v3 in pairs(v2) do
			local powerUp = Lang.Strings.AssetInfo.PowerUps[k]
			local v4

			if powerUp then
				v4 = Lang.Get(powerUp.Name) or k
			else
				v4 = k
			end

			local v5 = PowerUpsData[k]

			if v5 then
				local mainImage = v5.MainImage
				AddItem("PowerUps", v4, tostring(v3), mainImage)
				flag = true
			else
				warn("PowerUpData not found for", k)
			end
		end
	end

	local v3 = data.PlayerNameToTowerRewardMap[name]

	if v3 then
		for _, v4 in pairs(v3) do
			local v5 = v4
			AddItem("Towers", v4, nil, nil, function(p)
				return TowerUtilities.GetViewport(p, v5, nil, "VictoryDance")
			end)
			flag = true
		end
	end

	local v4 = data.PlayerNameToSkinRewardMap[name]

	if v4 then
		for _, v5 in pairs(v4) do
			local v6 = string.split(v5, "_")
			local v7 = v6[1]
			local v8 = v6[2]
			AddItem("Skins", SkinUtilities.GetSkinData(v7, v8).DisplayName or v8, nil, nil, function(p)
				return TowerUtilities.GetViewport(p, v7, v8, "VictoryDance")
			end)
			flag = true
		end
	end

	local v5 = data.PlayerNameToNameTagEffectRewardMap[name]

	if v5 then
		for _, v6 in v5 do
			AddItem(
				"Name Tags",
				Lang.Get(Lang.Strings.AssetInfo.NameTagEffects[v6].Name),
				nil,
				NameTagData.Effects[v6].Image
			)
		end
	end

	if flag then
		rewards.Position = GetScreenStartPosition() -- inferred equivalent call
		rewards.Visible = true
		task.delay(duration, function()
			if rewards.Visible then
				TweenService:Create(
					rewards,
					TweenInfo.new(duration2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
					{ Position = GetScreenEndPosition() } -- inferred equivalent call
				):Play()
			end
		end)
	end

	return flag
end

function GameOverRewardsScreenHandler.HideScreen()
	rewards.Visible = false
	ClearRows()
end

rewards.Position = GetScreenStartPosition() -- inferred equivalent call
rowTemplate.Visible = false
return GameOverRewardsScreenHandler