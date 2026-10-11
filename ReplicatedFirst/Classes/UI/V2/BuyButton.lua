local TDX_Shared = game.ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Util = require(game.ReplicatedStorage.TDX_Shared.Modules.Util)
local Director = require(TDX_Shared.Modules.Director)
local Shared = require(TDX_Shared.Modules.Shared)
require(Common:WaitForChild("CurrencyTypes"))
local text = utf8.char(57346)
local BuyButton = { ClassName = script.Name, ClassModule = script }
BuyButton.__index = BuyButton

function BuyButton.new(root)
	return (setmetatable({ Root = root, Button = root.Button }, BuyButton))
end

function BuyButton.Init(_) end

function BuyButton.SetRobuxPrice(p, p2: number)
	p.Button.Frame.Icon.Image = ""
	p.Button.Frame.Icon.Label.Text = text
	p.Button.Frame.Icon.Label.Visible = true
	p.Button.Frame.Label.Text = Util.FormatCurrency(p2)
end

function BuyButton.SetCurrencyPrice(p, p2, p3: number)
	assert(p2 == "Gold", "Other currencies are not supported yet!")
	p.Button.Frame.Label.Text = Util.FormatCurrency(p3)
	p.Button.Frame.Label.TextColor3 = Shared.CURRENCY_COLORS[p2]
	p.Button.Frame.Icon.Image = Shared.CURRENCY_ICONS[p2]
	p.Button.Frame.Icon.Label.Visible = false
end

function BuyButton.Destroy(_) end

Director.Register(script.Name, { BuyButton }, game.Players)
return BuyButton