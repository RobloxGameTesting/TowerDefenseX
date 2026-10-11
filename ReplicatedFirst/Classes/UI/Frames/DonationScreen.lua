local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Shared = require(TDX_Shared.Modules.Shared)
local DONATION_TIER_TO_DEV_ID_MAP = Shared.DONATION_TIER_TO_DEV_ID_MAP
local DONATION_DEV_ID_TO_AMOUNT_MAP = Shared.DONATION_DEV_ID_TO_AMOUNT_MAP
local LocalPlayer = Players.LocalPlayer
local gui = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("GUI")
local DonationScreen = { ClassName = script.Name, ClassModule = script }
DonationScreen.__index = DonationScreen

function DonationScreen.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), Hovered = false, Enabled = true }, DonationScreen))
end

function DonationScreen.Init(p)
	local bottomSection = p.Root.Main.BottomSection
	local template = bottomSection.Template
	template.Visible = false

	for k, v in pairs(DONATION_TIER_TO_DEV_ID_MAP) do
		local clone = template:Clone()
		clone.Name = tostring(k)
		clone.Visible = true
		clone.LayoutOrder = k
		clone.Parent = bottomSection
		local buyButton = clone.BuyButton
		local text = buyButton:FindFirstChild("Text")
		local v2 = DONATION_DEV_ID_TO_AMOUNT_MAP[v]
		text.Text = utf8.char(57346) .. tostring(v2)
		local v3 = v
		p.Cleaner:Add(buyButton.Activated:Connect(function()
			SoundHandler.Play("ShopSelectOption")
			MarketplaceService:PromptProductPurchase(LocalPlayer, v3)
		end))
	end
end

function DonationScreen.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { DonationScreen }, gui)
local ProximityPromptService = game:GetService("ProximityPromptService")

local function onPromptTriggered(p, _)
	if p.Name ~= "Donate" then
		return
	end

	for _, v in Director.GetItemsFromClass(Director.Classes.Sidebar) do
		v:ShowFrame("DonationScreen")
	end

	SoundHandler.Play("CurrencyJingle")
end

ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
return DonationScreen