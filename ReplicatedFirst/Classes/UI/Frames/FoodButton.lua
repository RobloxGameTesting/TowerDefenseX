local createVector = vector.create
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Network = require(game.ReplicatedFirst.Client.Network)
local Keybinds = require(game.ReplicatedStorage.TDX_Shared.Common.Keybinds)
local FoodButton = { ClassName = script.Name, ClassModule = script }
FoodButton.__index = FoodButton
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local function getVendingMachinePrompts()
	local roots = {}

	for _, v in Director.GetItemsFromClass(Director.Classes.WorldSidebarOpen) do
		if v.Root.Name == "VendingPrompt" then
			table.insert(roots, v.Root)
		end
	end

	return roots
end

local function handleChar(character, root)
	local maid = Cleaner.new()
	local childAdded = character.ChildAdded
	maid:Add(childAdded:Connect(function(instance)
		if instance.Name == "_Food" then
			local real = instance:GetAttribute("Real")

			if root:FindFirstChild("ViewportFrame") then
				root.ViewportFrame:Destroy()
			end

			root.Visible = true
			local viewportFrame = Instance.new("ViewportFrame")
			viewportFrame.BackgroundTransparency = 1
			viewportFrame.BackgroundColor3 = Color3.fromHex("1e282f")
			viewportFrame.BorderSizePixel = 0
			viewportFrame.Size = UDim2.new(1, 0, 1, 0)
			local camera = Instance.new("Camera")
			camera.FieldOfView = 1
			camera.CFrame = CFrame.new(createVector(80, 0, 0), createVector(0, 0, 0))
			camera.Parent = viewportFrame
			viewportFrame.CurrentCamera = camera
			local child = game.ReplicatedStorage.LobbyResources.Food:FindFirstChild(real or "")

			if child then
				local clone = child:Clone()

				for _, part in clone:GetChildren() do
					if not part:IsA("BasePart") or part:GetAttribute("HideInVending") then
						continue
					end

					part.Transparency = 0
				end

				clone.Parent = viewportFrame
				clone:PivotTo(clone:GetAttribute("VendingOffset") or CFrame.identity)
			end

			viewportFrame.Parent = root

			for _, v in getVendingMachinePrompts() do
				v.Enabled = false
			end
		end
	end))
	local childRemoved = character.ChildRemoved
	maid:Add(childRemoved:Connect(function(p)
		if p.Name == "_Food" then
			root.Visible = false

			if root:FindFirstChild("ViewportFrame") then
				root.ViewportFrame:Destroy()
			end

			for _, v in getVendingMachinePrompts() do
				v.Enabled = true
			end
		end
	end))
	character.Destroying:Once(function()
		maid:Clean()
		maid = nil
	end)

	if not Director.Classes.WorldSidebarOpen then
		repeat
			task.wait()
		until Director.Classes.WorldSidebarOpen
	end

	for _, v in getVendingMachinePrompts() do
		v.Enabled = true
	end
end

function FoodButton.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new() }, FoodButton))
end

function FoodButton.Init(p)
	local key = p.Root:FindFirstChild("key", true)

	if key and key:IsA("TextLabel") then
		Keybinds.BindLabel(key, "EatFood")
	end

	p.Cleaner:Add(p.Root.Activated:Connect(function()
		Network.Fire("ClientEatFoodRequest")
	end))
	p.Cleaner:Add(UserInputService.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed or UserInputService:GetFocusedTextBox() ~= nil then
			return
		end

		if Keybinds.IsActionInput("EatFood", input) and p.Root.Visible then
			Network.Fire("ClientEatFoodRequest")
		end
	end))
	p.Cleaner:Add(LocalPlayer.CharacterAdded:Connect(function(character)
		handleChar(character, p.Root)
	end))

	if LocalPlayer.Character then
		handleChar(LocalPlayer.Character, p.Root)
	end
end

function FoodButton:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { FoodButton }, game.Players)
return FoodButton