local AdminHoverPanelHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local TooltipUtilities = require(script.Parent:WaitForChild("TooltipUtilities"))
require(script:WaitForChild("CommandTypes"))
local Commands = script:WaitForChild("Commands")
local LeftShift = Enum.KeyCode.LeftShift
local RightShift = Enum.KeyCode.RightShift
local v = NetworkingHandler.GetFunction("AdminHoverPanelRequest")
local event = BindableHandler.GetEvent("ResetAbilities")
local CurrentCamera = workspace.CurrentCamera
local adminHoverPanel = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("Tooltips"):WaitForChild("AdminHoverPanel")
local scrollingFrame = adminHoverPanel:WaitForChild("ScrollingFrame")
local template = scrollingFrame:WaitForChild("Template")
local header = adminHoverPanel:WaitForChild("Header")
local entityName = header:WaitForChild("EntityName")
local entityClassName = header:WaitForChild("EntityClassName")
local errorSound = adminHoverPanel:WaitForChild("ErrorSound")
local successSound = adminHoverPanel:WaitForChild("SuccessSound")
local modules = {}
local v2 = nil
local v3 = nil
local v4 = {}

local function ShiftDown() -- 2 equivalent calls inferred from this helper
	return UserInputService:IsKeyDown(LeftShift) or UserInputService:IsKeyDown(RightShift)
end

local function GetAdjustableText(data, p: number)
	local adjustableNumberAppendString = data.AdjustableNumberAppendString

	if data.AdjustablePercentage then
		return math.floor(p * 100) .. (adjustableNumberAppendString or "%")
	end

	if not data.AdjustableNumberRange then
		return ""
	end

	local adjustableNumberRangeCustomIncrement = data.AdjustableNumberRangeCustomIncrement

	if not adjustableNumberRangeCustomIncrement or adjustableNumberRangeCustomIncrement % 1 == 0 then
		return tostring((math.floor(p))) .. (adjustableNumberAppendString or "")
	end

	local match = tostring(adjustableNumberRangeCustomIncrement):match("%.(%d+)")
	local v5 = match and #match or 0
	return string.format("%." .. v5 .. "f", p) .. (adjustableNumberAppendString or "")
end

local function Clear()
	v2 = nil
	v3 = nil

	for _, v5 in pairs(v4) do
		for _, connection in ipairs(v5.Connections) do
			connection:Disconnect()
		end

		v5.Button:Destroy()
	end

	adminHoverPanel.Visible = false
end

function AdminHoverPanelHandler.ToggleAdminHoverPanel(data, text: string?)
	Clear()

	if not data then
		return
	end

	v2 = data
	v3 = text
	entityName.Text = data.DisplayName or "Unknown"
	entityClassName.Text = text

	for _, command in pairs(modules) do
		if not (not command.ValidEntityClasses or table.find(command.ValidEntityClasses, text)) then
			continue
		end

		if command.AbilityHandlerRequired then
			if not data.AbilityHandler then
				continue
			end

			local count = 0

			for _ in pairs(data.AbilityHandler.Abilities) do
				count += 1
			end

			if count == 0 then
				continue
			end
		end

		if not (not command.InStasisRequired or data.InStasis) then
			continue
		end

		local clone = template:Clone()
		local textLabel = clone:FindFirstChild("TextLabel")
		local adjustableFrame = clone:FindFirstChild("AdjustableFrame")
		local textLabel2 = adjustableFrame:FindFirstChild("TextLabel")
		local adjustablePercentage = command.AdjustablePercentage
		local adjustableNumberRange = command.AdjustableNumberRange
		local v5 = adjustablePercentage or adjustableNumberRange
		local adjustableDefaultValue = nil

		if v5 then
			if command.AdjustableDefaultValue then
				adjustableDefaultValue = command.AdjustableDefaultValue
			elseif adjustablePercentage then
				adjustableDefaultValue = 0.5
			elseif adjustableNumberRange then
				adjustableDefaultValue = (adjustableNumberRange.Min + adjustableNumberRange.Max) / 2
			end

			textLabel2.Text = GetAdjustableText(command, adjustableDefaultValue)
		else
			adjustableFrame.Visible = false
		end

		local v6 = command
		local v7 = {
			Command = command,
			Button = clone,
			CurrentValue = adjustableDefaultValue,
			Connections = {},
			OnScrolled = function(self, flag: boolean)
				if not v5 then
					return
				end

				local v7 = ShiftDown() and 0.2 or adjustablePercentage and 0.03 or 0.02 -- inferred equivalent call

				if flag then
					v7 *= -1
				end

				if adjustablePercentage then
					self.CurrentValue = math.clamp(self.CurrentValue + v7, 0, 1)
				elseif adjustableNumberRange then
					local min = adjustableNumberRange.Min
					local max = adjustableNumberRange.Max
					local adjustableNumberRangeCustomIncrement = v6.AdjustableNumberRangeCustomIncrement

					if adjustableNumberRangeCustomIncrement then
						if ShiftDown() then -- inferred equivalent call
							adjustableNumberRangeCustomIncrement *= 5
						end

						self.CurrentValue = math.clamp(
							self.CurrentValue + math.sign(v7) * adjustableNumberRangeCustomIncrement,
							min,
							max
						)
					else
						self.CurrentValue = math.clamp(self.CurrentValue + v7 * (max - min), min, max)
					end
				end

				textLabel2.Text = GetAdjustableText(v6, self.CurrentValue)
			end
		}
		textLabel.Text = command.Name
		clone.Name = command.Name
		clone.Parent = scrollingFrame
		clone.Visible = true
		local v8 = command
		table.insert(v7.Connections, clone.MouseButton1Click:Connect(function()
			if v:InvokeServer(false, v8.Name, v7.CurrentValue, v2 and v2.UniqueId, v3) then
				successSound:Play()

				if v8.TriggerTowerResetAbilities then
					event:Fire(v2.Hash)
				end

				if v8.ClientCallback then
					v8.ClientCallback(v2, v3, v7.CurrentValue)
				end
			else
				errorSound:Play()
			end
		end))
		local v9 = command
		table.insert(v7.Connections, clone.MouseButton2Click:Connect(function()
			if v:InvokeServer(true, v9.Name, v7.CurrentValue, v2 and v2.UniqueId, v3) then
				successSound:Play()

				if v9.TriggerTowerResetAbilities then
					event:Fire(v2.Hash)
				end

				if v9.ClientCallback then
					v9.ClientCallback(v2, v3, v7.CurrentValue)
				end
			else
				errorSound:Play()
			end
		end))
		table.insert(v7.Connections, clone.MouseWheelForward:Connect(function()
			v7:OnScrolled(false)
		end))
		table.insert(v7.Connections, clone.MouseWheelBackward:Connect(function()
			v7:OnScrolled(true)
		end))
		table.insert(v4, v7)
	end

	TooltipUtilities.PositionTooltipAtMousePosition(adminHoverPanel, UDim2.new(0.01, 10, -0.03, -10))
	adminHoverPanel.Visible = true
end

function AdminHoverPanelHandler.Update()
	if v2 and v3 ~= "StaticEntity" and v2:Alive() and (v3 ~= "Tower" or not v2.Destroyed) then
		return
	end

	Clear()
end

for _, moduleScript in ipairs(Commands:GetChildren()) do
	local module = require(moduleScript)
	table.insert(modules, module)
end

table.sort(modules, function(a, b)
	return a.Name < b.Name
end)
template.Visible = false
Clear()
return AdminHoverPanelHandler