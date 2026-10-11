local AttributeHoverHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Enums"))
require(common:WaitForChild("Types"))
require(common:WaitForChild("NetworkingHandler"))
require(common:WaitForChild("QueryType"))
require(common:WaitForChild("SoundHandler"))
require(common:WaitForChild("BindableHandler"))
require(common:WaitForChild("ResourceManager"))
local ScalingCardClass = require(common:WaitForChild("ScalingCardClass"))
local towerUI = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("TowerUI")
local uiScale = towerUI:WaitForChild("UIScale")
local attributesHover = towerUI:WaitForChild("AttributesHover")
local v = ScalingCardClass.New(attributesHover, 1, { uiScale }, true)
local v2 = nil

function AttributeHoverHandler.Hovered(p, value: string)
	v2 = p
	local v3 = p.AbsolutePosition.Y - towerUI.AbsolutePosition.Y + p.AbsoluteSize.Y / 2
	v:DeactivateAllItems()
	v:ActivateItem(string.upper(value), { LayoutOrder = 1 })
	v:ScaleFrame()
	v:SetPosition(UDim2.new(1, -36, 0, v3))
	v:ShowIfActiveItems()
end

function AttributeHoverHandler.Unhovered(p)
	if p == v2 then
		v:Hide()
	end
end

AttributeHoverHandler.Unhovered()
return AttributeHoverHandler