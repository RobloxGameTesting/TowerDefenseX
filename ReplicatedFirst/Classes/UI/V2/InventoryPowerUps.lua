local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Network = require(ReplicatedFirst.Client.Network)
local Data = require(ReplicatedStorage.TDX_Shared.Client.Services.Data)
local PowerUpsData = require(ReplicatedStorage.TDX_Shared.Common.PowerUpsData)
local SoundHandler = require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local LocalPlayer = Players.LocalPlayer
local InventoryPowerUps = { ClassName = script.Name, ClassModule = script }
InventoryPowerUps.__index = InventoryPowerUps
local color = Color3.new(0.5, 0.5, 0.5)
local color2 = Color3.new(1, 1, 1)

function InventoryPowerUps.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, InventoryPowerUps))
end

function InventoryPowerUps:UpdateState()
	local vip = LocalPlayer:GetAttribute("VIP") == true
	local powerUpsLoadout = Data.Get("PowerUpsLoadout")
	self.Root.list.Frame.Folder.novip.Visible = not vip

	for i = 1, 6 do
		local child = self.Root.list.Frame:FindFirstChild(i)

		if not child then
			continue
		end

		if vip or i <= 4 then
			child.Visible = true
			local v = powerUpsLoadout[i]

			if v and v ~= "" then
				local text = Data.Get("Inventory").PowerUps[v] or 0
				child.main.icon.Visible = true
				child.main.icon.Image = PowerUpsData[v].MiniImage

				if text > 0 then
					child.main.ImageColor3 = color2
					child.main.icon.ImageColor3 = color2
					child.main.count.Visible = true
					child.main.count.labelOLD.Text = text
				else
					child.main.count.Visible = false
					child.main.ImageColor3 = color
					child.main.icon.ImageColor3 = color
				end
			else
				child.main.count.Visible = false
				child.main.icon.Visible = false
				child.main.ImageColor3 = color
			end
		else
			child.Visible = false
		end
	end
end

function InventoryPowerUps:Init()
	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "PowerUpsLoadout" or p == "Inventory" then
			self:UpdateState()
		end
	end))
	self.Cleaner:Add(self.Root.list.Frame.Folder.novip.MouseButton1Click:Connect(function()
		MarketplaceService:PromptGamePassPurchase(LocalPlayer, _G.VIP_GAMEPASS_ID)
	end))
	self.Cleaner:Add(LocalPlayer:GetAttributeChangedSignal("VIP"):Connect(function()
		self:UpdateState()
	end))

	for i = 1, 6 do
		local child = self.Root.list.Frame:FindFirstChild(i)

		if not child then
			continue
		end

		local v = i
		self.Cleaner:Add(child.main.TextButton.MouseButton1Down:Connect(function()
			local v2 = Data.Get("PowerUpsLoadout")[v]

			if v2 and v2 ~= "" then
				SoundHandler.Play("ClickDown")
			end
		end))
		local v2 = i
		self.Cleaner:Add(child.main.TextButton.MouseEnter:Connect(function()
			local v3 = Data.Get("PowerUpsLoadout")[v2]

			if v3 and v3 ~= "" then
				child.main.hover.Visible = true
				child.main.ImageColor3 = color
				child.main.icon.ImageColor3 = color
			end
		end))
		local v3 = i
		self.Cleaner:Add(child.main.TextButton.MouseLeave:Connect(function()
			child.main.hover.Visible = false
			local v4 = Data.Get("PowerUpsLoadout")[v3]

			if v4 and v4 ~= "" then
				if (Data.Get("Inventory").PowerUps[v4] or 0) > 0 then
					child.main.ImageColor3 = color2
					child.main.icon.ImageColor3 = color2
				else
					child.main.ImageColor3 = color
					child.main.icon.ImageColor3 = color
				end
			end
		end))
		local v4 = i
		self.Cleaner:Add(child.main.TextButton.MouseButton1Click:Connect(function()
			local v5 = Data.Get("PowerUpsLoadout")[v4]

			if v5 and v5 ~= "" then
				SoundHandler.Play("ClickUp")
				child.main.hover.Visible = false
				Network.Fire("ClientUnequipPowerUpRequest", v5)
			end
		end))
	end

	self:UpdateState()
end

function InventoryPowerUps.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { InventoryPowerUps }, game.Players)
return InventoryPowerUps