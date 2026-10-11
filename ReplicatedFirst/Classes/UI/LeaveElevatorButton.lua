local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Network = require(game.ReplicatedFirst.Client.Network)
local Players = game:GetService("Players")
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local LeaveElevatorButton = { ClassName = script.Name, ClassModule = script }
LeaveElevatorButton.__index = LeaveElevatorButton

function LeaveElevatorButton.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, LeaveElevatorButton))
end

function LeaveElevatorButton.Init(p)
	p.Cleaner:Add(p.Root.Activated:Connect(function()
		Network.Fire("LeaveQueue")
		GuiService.SelectedObject = nil

		for _, v in Director.GetItemsFromClass(Director.Classes.NightSelection) do
			v.Root.Visible = false
		end
	end))
	p.Cleaner:Add(Network.HookEvent("LeaveButtonState", function(visible)
		p.Root.Visible = visible

		if visible and UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
			GuiService.SelectedObject = p.Root
		end
	end))
end

function LeaveElevatorButton.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { LeaveElevatorButton }, PlayerGui)
return LeaveElevatorButton