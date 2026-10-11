local PVPInitialStatsDisplayHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local Utilities = require(common:WaitForChild("Utilities"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local ScalingCardClass = require(common:WaitForChild("ScalingCardClass"))
local v = { "Health", "Shield", "Speed" }

local function ShouldIgnore(p, p2)
	return not p2[p.StatName]
end

local bottomBar = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("BottomBar")
local pvpInitialStats = bottomBar:WaitForChild("PVPInitialStats")
local v2 = {}
local v3 = { bottomBar:WaitForChild("UIScale"), (pvpInitialStats:WaitForChild("UIScale")) }
local v4 = ScalingCardClass.New(pvpInitialStats, 5, v3)
local v5 = false
local v6 = false

local function UpdateVisibility() -- 3 equivalent calls inferred from this helper
	pvpInitialStats.Visible = v6 and v5
end

function PVPInitialStatsDisplayHandler.Show(p)
	v4:DeactivateAllItems()
	local enemyName = p.EnemyName

	if enemyName then
		local enemyConfig = ResourceManager.FindEnemyConfig(enemyName)

		if enemyConfig then
			local overrideDisplayName = enemyConfig.OverrideDisplayName or enemyName
			v4:ActivateItem(overrideDisplayName:upper(), {
				LayoutOrder = -1,
				TextSize = 24,
				TextYAlignment = Enum.TextYAlignment.Center
			})

			for _, v7 in ipairs(v) do
				local v8 = v2[v7]

				if v8 then
					if enemyConfig[v8.StatName] then
						v4:ActivateItem(v8:DescriptionFunction(enemyConfig), {
							LayoutOrder = v8._LayoutOrder,
							ImageId = v8.ImageId,
							ImageScale = v8.ImageScale
						})
					end
				else
					warn("PVPInitialStatsDisplayHandler: StatInfoData not implemented for", v7)
				end
			end

			v4:ScaleFrame()
			local anchor = p.Anchor
			local parent = pvpInitialStats.Parent
			local absolutePosition = anchor.AbsolutePosition
			local absoluteSize = anchor.AbsoluteSize
			local absolutePosition2 = parent.AbsolutePosition
			local absoluteSize2 = parent.AbsoluteSize
			local v7 = (absolutePosition.X + absoluteSize.X / 2 - absolutePosition2.X) / absoluteSize2.X
			local v8 = (absolutePosition.Y - absolutePosition2.Y) / absoluteSize2.Y
			v4:SetPosition(UDim2.new(v7, 0, v8, -8))
			v5 = v4:GetActiveItemCount() > 0
			v6 = true
			UpdateVisibility() -- inferred equivalent call
			return
		end
	end

	v5 = false
	UpdateVisibility() -- inferred equivalent call
end

function PVPInitialStatsDisplayHandler.Hide()
	v6 = false
	UpdateVisibility() -- inferred equivalent call
end

for i, v7 in ipairs({
	{
		StatName = "Health",
		ImageId = "rbxassetid://103814500469848",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p)
			return `HEALTH: {Utilities.FormatNumberStat(p.Health, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "Shield",
		ImageId = "rbxassetid://121224933813250",
		ImageScale = 1,
		DecimalPlaces = 0,
		DescriptionFunction = function(self, p)
			return `SHIELD: {Utilities.FormatNumberStat(p.Shield or 0, self.DecimalPlaces)}`
		end
	},
	{
		StatName = "Speed",
		ImageId = "rbxassetid://83017077237761",
		ImageScale = 1,
		DecimalPlaces = 1,
		DescriptionFunction = function(self, p)
			return `SPEED: {Utilities.FormatNumberStat(p.Speed, self.DecimalPlaces)}`
		end
	}
}) do
	v2[v7.StatName] = v7
	v7._LayoutOrder = i
end

PVPInitialStatsDisplayHandler.Hide()
return PVPInitialStatsDisplayHandler