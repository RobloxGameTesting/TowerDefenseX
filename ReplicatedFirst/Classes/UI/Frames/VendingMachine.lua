local createVector = vector.create
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Network = require(game.ReplicatedFirst.Client.Network)
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local v = {
	[0] = "5 GOLD EACH",
	[1] = "401 SELECTED",
	[2] = "402 SELECTED",
	[3] = "403 SELECTED",
	[4] = "301 SELECTED",
	[5] = "302 SELECTED",
	[6] = "303 SELECTED",
	[7] = "201 SELECTED",
	[8] = "202 SELECTED",
	[9] = "203 SELECTED",
	[10] = "101 SELECTED",
	[11] = "102 SELECTED",
	[12] = "103 SELECTED"
}
local v2 = {
	[2] = "CryoEnergy",
	[3] = "DeathChips",
	[4] = "EDJTriangles",
	[6] = "JohnsRed",
	[9] = "EDJTriangles",
	[11] = "JohnsRed"
}
local VendingMachine = { ClassName = script.Name, ClassModule = script }
VendingMachine.__index = VendingMachine

function VendingMachine.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), Selected = 0 }, VendingMachine))
end

function VendingMachine:Init()
	self:UpdateTopLabel()
	self.Cleaner:Add(self.Root:GetPropertyChangedSignal("Visible"):Connect(function()
		if self.Root.Visible then
			self:Open()
		end
	end))

	for i = 1, 12 do
		local child = self.Root.Frame:FindFirstChild(i)

		if not child then
			continue
		end

		self.Cleaner:Add(child.MouseButton1Click:Connect(function()
			local name = tonumber(child.Name)

			if self.Selected == name then
				self.Root.Visible = false
				Network.Fire("ClientBuyFoodRequest", v2[name] or "NA")
			else
				self.Selected = name
				self:UpdateTopLabel()
			end
		end))
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
		local child2 = game.ReplicatedStorage.LobbyResources.Food:FindFirstChild(v2[i] or "")

		if child2 then
			local clone = child2:Clone()

			for _, part in clone:GetChildren() do
				if not part:IsA("BasePart") or part:GetAttribute("HideInVending") then
					continue
				end

				part.Transparency = 0
			end

			clone.Parent = viewportFrame
			clone:PivotTo(clone:GetAttribute("VendingOffset") or CFrame.identity)
		end

		viewportFrame.Parent = child
	end
end

function VendingMachine:Open()
	self.Selected = 0

	if UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 then
		GuiService.SelectedObject = self.Root.Frame:FindFirstChild(self.Selected)
	end

	self:UpdateTopLabel()
end

function VendingMachine:UpdateTopLabel()
	for i = 1, 12 do
		local child = self.Root.Frame:FindFirstChild(i)

		if child then
			child.BackgroundTransparency = tonumber(child.Name) == self.Selected and 0.5 or 1
		end
	end

	self.Root.toplabel.Text = v[self.Selected] or ""
end

function VendingMachine.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { VendingMachine }, game.Players)
return VendingMachine