local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Util = require(game.ReplicatedStorage.TDX_Shared.Modules.Util)
require(TDX_Shared.Modules.Cleaner)
local Director = require(TDX_Shared.Modules.Director)
require(game.ReplicatedStorage.Modules.ShopDataV2)
local Shared = require(TDX_Shared.Modules.Shared)
require(TDX_Shared.Modules.Lang)
require(Common:WaitForChild("TowerUtilities"))
require(Common:WaitForChild("CurrencyTypes"))
require(game.ReplicatedStorage.Modules.Signal)
local text2 = utf8.char(57346)
local v = {
	Secondary = {
		Gold = {
			Default = "rbxassetid://104772322076195",
			Hover = "rbxassetid://85570639662257",
			Press = "rbxassetid://110953696540650"
		},
		Crystals = {
			Default = "rbxassetid://82953947125573",
			Hover = "rbxassetid://104184102052139",
			Press = "rbxassetid://87857438853167"
		},
		Cookies = {
			Default = "rbxassetid://88154501986131",
			Hover = "rbxassetid://88267551658822",
			Press = "rbxassetid://135740200862976"
		},
		Envelopes = {
			Default = "rbxassetid://118659536904494",
			Hover = "rbxassetid://86773449660806",
			Press = "rbxassetid://124218741785415"
		},
		Eggs = {
			Default = "rbxassetid://116767777201809",
			Hover = "rbxassetid://136464522034784",
			Press = "rbxassetid://116550664362562"
		},
		Burgers = {
			Default = "rbxassetid://74028652079779",
			Hover = "rbxassetid://135593854511903",
			Press = "rbxassetid://90000503725692"
		}
	}
}
local v2 = {
	Primary = {
		Default = "rbxassetid://129355077388343",
		Hover = "rbxassetid://134870880282353",
		Press = "rbxassetid://107033282294122"
	},
	Secondary = {
		Default = "rbxassetid://124726999679462",
		Hover = "rbxassetid://77374480487669",
		Press = "rbxassetid://113263066432891"
	}
}
local v3 = { Primary = Color3.fromRGB(0, 0, 0), Secondary = Color3.fromRGB(180, 255, 0) }

local function SetButtonLabel(p, text: string) -- 2 equivalent calls inferred from this helper
	p.Frame.Top.Icon.Visible = text == ""
	p.Frame.Bottom.Icon.Visible = text ~= ""
	p.Frame.Top.Label.Visible = text ~= ""
	p.Frame.Top.Label.Text = text
end

local SplitBuyButton = { ClassName = script.Name, ClassModule = script }
SplitBuyButton.__index = SplitBuyButton

function SplitBuyButton.new(root)
	return (setmetatable(
		{
			Root = root,
			RobuxButton = root.Left,
			RobuxButtonStyle = "Secondary",
			CurrencyButton = root.Right
		},
		SplitBuyButton
	))
end

function SplitBuyButton:Init()
	self:SetRobuxPrice(0)
	self:SetCurrencyPrice("Gold", 0)
	self:ClearCurrencyLocked()
	self:SetRobuxStyle(self.RobuxButtonStyle)
	self.CurrencyButton.Frame.Top.Icon.Visible = true
	self.CurrencyButton.Frame.Bottom.Icon.Visible = false
	self.CurrencyButton.Frame.Top.Label.Visible = false
	self.RobuxButton.Frame.Top.Icon.Visible = true
	self.RobuxButton.Frame.Bottom.Icon.Visible = false
	self.RobuxButton.Frame.Top.Label.Visible = false
end

function SplitBuyButton:SetRobuxStyle(robuxButtonStyle: string)
	self.RobuxButtonStyle = robuxButtonStyle
	self.RobuxButton.Frame.Top.Icon.Label.TextColor3 = v3[robuxButtonStyle]
	self.RobuxButton.Frame.Top.Label.TextColor3 = v3[robuxButtonStyle]
	self.RobuxButton.Frame.Bottom.Label.TextColor3 = v3[robuxButtonStyle]
	self.RobuxButton.Frame.Bottom.Icon.Label.TextColor3 = v3[robuxButtonStyle]
	self.RobuxButton.Image = v2[robuxButtonStyle].Default
	self.RobuxButton.HoverImage = v2[robuxButtonStyle].Hover
	self.RobuxButton.PressedImage = v2[robuxButtonStyle].Press
end

function SplitBuyButton:SetRobuxPrice(p: number)
	self.RobuxButton.Frame.Bottom.Label.Text = Util.FormatCurrency(p)
	self.RobuxButton.Frame.Top.Icon.Image = ""
	self.RobuxButton.Frame.Top.Icon.Label.Text = text2
	self.RobuxButton.Frame.Bottom.Icon.Image = ""
	self.RobuxButton.Frame.Bottom.Icon.Label.Text = text2
end

function SplitBuyButton:SetCurrencyPrice(p, p2: number)
	self.CurrencyButton.Frame.Bottom.Label.Text = Util.FormatCurrency(p2)
	self.CurrencyButton.Frame.Bottom.Label.TextColor3 = Shared.CURRENCY_COLORS[p]
	self.CurrencyButton.Frame.Top.Icon.Image = Shared.CURRENCY_ICONS[p]
	self.CurrencyButton.Frame.Bottom.Icon.Image = Shared.CURRENCY_ICONS[p]
	self.CurrencyButton.Image = v.Secondary[p].Default
	self.CurrencyButton.HoverImage = v.Secondary[p].Hover
	self.CurrencyButton.PressedImage = v.Secondary[p].Press
end

function SplitBuyButton.SetRobuxLabel(p, text: string)
	SetButtonLabel(p.RobuxButton, text) -- inferred equivalent call
end

function SplitBuyButton.SetCurrencyLabel(p, text: string)
	SetButtonLabel(p.CurrencyButton, text) -- inferred equivalent call
end

function SplitBuyButton.SetCurrencyLocked(p, text: string)
	p.CurrencyButton.Locked.Visible = true
	p.CurrencyButton.Locked.Label.Text = text
	p.CurrencyButton.Active = false
	p.CurrencyButton.Interactable = false
end

function SplitBuyButton:ClearCurrencyLocked()
	self.CurrencyButton.Locked.Visible = false
	self.CurrencyButton.Active = true
	self.CurrencyButton.Interactable = true
end

function SplitBuyButton.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { SplitBuyButton }, game.Players)
return SplitBuyButton