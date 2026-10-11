local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Network = require(game.ReplicatedFirst.Client.Network)
local Lang = require(game.ReplicatedStorage.TDX_Shared.Modules.Lang)
local SoundHandler = require(game.ReplicatedStorage.TDX_Shared.Common.SoundHandler)
local v = {
	[0] = Lang.Strings.Codes.Success,
	[1] = Lang.Strings.Codes.Expired,
	[2] = Lang.Strings.Codes.Unknown,
	[3] = Lang.Strings.Codes.Redeemed
}

local function GetRewardString(data)
	if data.Type == "Crystals" then
		return `{data.Amount} Crystals`
	end

	if data.Type == "Gold" then
		return `{data.Amount} Gold`
	end

	if data.Type == "Cookies" then
		return `{data.Amount} Cookies`
	end

	if data.Type == "Eggs" then
		return `{data.Amount} Eggs`
	end

	if data.Type == "Burgers" then
		return `{data.Amount} Burgers`
	end

	if data.Type == "Envelopes" then
		return `{data.Amount} Envelopes`
	end

	if data.Type == "PowerUp" then
		return `{data.Amount} {Lang.Get(Lang.Strings.AssetInfo.PowerUps[data.Item].Name)}`
	end

	if data.Type == "NameTagEffect" then
		return `{Lang.Get(Lang.Strings.AssetInfo.NameTagEffects[data.Item].Name)} Name Tag`
	end

	return ""
end

local CodesWindow = { ClassName = script.Name, ClassModule = script }
CodesWindow.__index = CodesWindow

function CodesWindow.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, CodesWindow))
end

function CodesWindow.Init(p)
	local textBox = p.Root.box.TextBox
	local lastTime = os.clock()
	local flag = false
	textBox.ClearTextOnFocus = true
	p.Cleaner:Add(textBox.Focused:Connect(function()
		flag = true
	end))
	p.Cleaner:Add(p.Root.Purchase.MouseButton1Click:Connect(function()
		if os.clock() - lastTime < 2 then
			return
		end

		local v2, v3 = Network.Invoke("RedeemCode", textBox.Text)
		lastTime = os.clock()
		textBox.Text = Lang.Get(v[v2])
		flag = false

		if v3 then
			local v4 = {}

			for _, v5 in v3 do
				local rewardString = GetRewardString(v5)

				if rewardString ~= "" then
					table.insert(v4, rewardString)
				end
			end

			SoundHandler.Play("HeavyPurchase")
			p.Root.yougot.Text = "You got: " .. table.concat(v4, ", ")
			p.Root.yougot.Visible = true
			task.delay(3, function()
				p.Root.yougot.Visible = false
			end)
		end

		task.wait(3)

		if flag then
			return
		end

		textBox.Text = ""
	end))
end

function CodesWindow.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { CodesWindow })
return CodesWindow