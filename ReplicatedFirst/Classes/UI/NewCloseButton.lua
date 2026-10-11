local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
TDX_Shared:WaitForChild("Common")
require(TDX_Shared.Modules.Cleaner)
local Director = require(TDX_Shared.Modules.Director)
local colors = {
	[Enum.GuiState.Idle] = Color3.fromHex("FF2D91"),
	[Enum.GuiState.Hover] = Color3.fromHex("FF60AC"),
	[Enum.GuiState.Press] = Color3.fromHex("FFA5D0")
}
local v = {
	[Enum.GuiState.Idle] = "rbxassetid://88980840576958",
	[Enum.GuiState.Hover] = "rbxassetid://88980840576958",
	[Enum.GuiState.Press] = "rbxassetid://104019921911299"
}
local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad)
local NewCloseButton = { ClassName = "NewCloseButton", ClassModule = script }
NewCloseButton.__index = NewCloseButton

function NewCloseButton.new(root)
	return (setmetatable({ Root = root, CurrentTween = nil }, NewCloseButton))
end

function NewCloseButton:Init()
	local root = self.Root
	root:GetPropertyChangedSignal("GuiState"):Connect(function()
		local guiState = root.GuiState

		if guiState == Enum.GuiState.NonInteractable then
			guiState = Enum.GuiState.Idle
		end

		root.ImageColor3 = colors[guiState]
		root.Fill.ImageColor3 = colors[guiState]
		root.Fill.Image = v[guiState]
		root.X.ImageColor3 = colors[guiState]

		if guiState == Enum.GuiState.Hover then
			self.CurrentTween = TweenService:Create(root.X, tweenInfo, { Rotation = 90 })
			self.CurrentTween:Play()
		elseif guiState == Enum.GuiState.Idle then
			if self.CurrentTween ~= nil then
				self.CurrentTween:Cancel()
				self.CurrentTween = nil
			end

			self.CurrentTween = TweenService:Create(root.X, tweenInfo, { Rotation = 0 })
			self.CurrentTween:Play()
		end
	end)
end

function NewCloseButton.Destroy(_) end

Director.Register(NewCloseButton.ClassName, { NewCloseButton }, game:GetService("Players"))
return NewCloseButton