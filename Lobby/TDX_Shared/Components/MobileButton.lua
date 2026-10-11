local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Director = require(ReplicatedStorage.TDX_Shared.Modules.Director)
local color = Color3.fromRGB(0, 0, 0)
local color2 = Color3.fromRGB(127, 127, 127)
local MobileButton = { ClassName = script.Name, ClassModule = script }
MobileButton.__index = MobileButton

function MobileButton.new(root)
	return (setmetatable({ Root = root }, MobileButton))
end

function MobileButton.Init(p)
	p.Root:GetAttributeChangedSignal("Active"):Connect(function()
		local active = p.Root:GetAttribute("Active")
		local background = p.Root.Background
		local backgroundColor

		if active then
			backgroundColor = color2
		else
			backgroundColor = color
		end

		background.BackgroundColor3 = backgroundColor
		p.Root.ImageLabel.ImageTransparency = active and 0 or 0.5
	end)
end

Director.Register(script.Name, { MobileButton }, Players)
return MobileButton