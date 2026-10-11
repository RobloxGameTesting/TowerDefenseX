local MaxButtonClass = {}
MaxButtonClass.__index = MaxButtonClass
game:GetService("ReplicatedStorage")
local parent = script.Parent.Parent.Parent
local gameClass = parent:WaitForChild("GameClass")
local PlayerClass = require(parent:WaitForChild("PlayerClass"))
local localPlayerWrapper = PlayerClass.GetLocalPlayerWrapper()
local v = {
	Inactive = {
		[Enum.GuiState.Idle] = "rbxassetid://72256293618683",
		[Enum.GuiState.Hover] = "rbxassetid://72256293618683",
		[Enum.GuiState.Press] = "rbxassetid://72256293618683"
	},
	Default = {
		[Enum.GuiState.Idle] = "rbxassetid://122477259140576",
		[Enum.GuiState.Hover] = "rbxassetid://88181844676142",
		[Enum.GuiState.Press] = "rbxassetid://83677587120647"
	},
	Active = {
		[Enum.GuiState.Idle] = "rbxassetid://123569625703899",
		[Enum.GuiState.Hover] = "rbxassetid://101585136656001",
		[Enum.GuiState.Press] = "rbxassetid://102449693867167"
	}
}
local v2 = {
	Inactive = Color3.fromRGB(113, 113, 113),
	Default = Color3.fromRGB(101, 135, 20),
	Active = Color3.fromRGB(180, 255, 0)
}

function MaxButtonClass.New(button, path: number)
	assert(button:IsA("ImageButton"), "Button must be an ImageButton!")
	local object = setmetatable({ Mode = "Hidden", Path = path, Button = button }, MaxButtonClass)
	button:GetPropertyChangedSignal("GuiState"):Connect(function()
		object:_UpdateButtonAppearance()
	end)
	return object
end

function MaxButtonClass:Update(object)
	if not object then
		return
	end

	local levelHandler = object.LevelHandler
	local levelOnPath = levelHandler:GetLevelOnPath(self.Path)
	local maxPossibleLevel = levelHandler:GetMaxPossibleLevel(self.Path)

	if levelOnPath == maxPossibleLevel then
		self.Mode = "Hidden"
		self:_UpdateButtonAppearance()
	else
		local discount = object.BuffHandler:GetDiscount()
		local module = require(gameClass)
		local towerCostMultiplier = module.GetTowerCostMultiplier(object.Type)
		local levelAttainableWithCash, v3 = levelHandler:GetLevelAttainableWithCash(
			self.Path,
			localPlayerWrapper.Stats:GetCash(),
			discount,
			towerCostMultiplier,
			object:GetDynamicPriceScalingData()
		)
		local v4 = v3 * towerCostMultiplier

		if levelAttainableWithCash == levelOnPath then
			self.Mode = "Inactive"
		elseif levelAttainableWithCash == maxPossibleLevel then
			local otherPath = levelHandler:GetOtherPath(self.Path)
			local maxPossibleLevel2 = levelHandler:GetMaxPossibleLevel(otherPath)

			if levelHandler:GetLevelAttainableWithCash(
				otherPath,
				localPlayerWrapper.Stats:GetCash() - v4,
				discount,
				towerCostMultiplier,
				object:GetDynamicPriceScalingData()
			) == maxPossibleLevel2 then
				self.Mode = "Active"
			else
				self.Mode = "Default"
			end
		else
			self.Mode = "Default"
		end

		self:_UpdateButtonAppearance()
	end
end

function MaxButtonClass:_UpdateButtonAppearance()
	if self.Mode == "Hidden" then
		self.Button.Visible = false
		return
	end

	self.Button.Visible = true
	self.Button.Image = v[self.Mode][self.Button.GuiState]
	self.Button.Label.TextColor3 = v2[self.Mode]
end

return MaxButtonClass