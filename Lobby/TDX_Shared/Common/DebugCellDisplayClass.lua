local DebugCellDisplayClass = {}
DebugCellDisplayClass.__index = DebugCellDisplayClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local MapHandler = require(common:WaitForChild("MapHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local folder = Instance.new("Folder", raycastIgnore)
folder.Name = "DebugCellDisplays"

function DebugCellDisplayClass.New(p: number, p2: number, p3: number, flag: boolean)
	local miscResource = ResourceManager.GetMiscResource("DebugCellDisplay")
	local textLabel = miscResource:FindFirstChild("GUI"):FindFirstChild("TextLabel")
	local selectionBox = miscResource:FindFirstChild("SelectionBox")
	textLabel.Visible = false
	selectionBox.Visible = flag or false
	miscResource.Position = Vector3.new(p, MapHandler.GetRangeDisplayHeight(), p2)
	miscResource.Size = Vector3.new(p3, 0.05, p3)
	miscResource.Parent = folder
	return (setmetatable(
		{ DebugPart = miscResource, TextLabel = textLabel, SelectionBox = selectionBox },
		DebugCellDisplayClass
	))
end

function DebugCellDisplayClass.SetText(p, p2: string)
	p.TextLabel.Text = tostring(p2)
end

function DebugCellDisplayClass.ToggleText(p, flag: boolean)
	p.TextLabel.Visible = flag or false
end

function DebugCellDisplayClass.ToggleSelectionBox(p, flag: boolean)
	p.SelectionBox.Visible = flag or false
end

return DebugCellDisplayClass