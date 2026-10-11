local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local Network = require(game.ReplicatedFirst.Client.Network)
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Data = require(TDX_Shared.Client.Services.Data)
local Lang = require(TDX_Shared.Modules.Lang)
local EmoteAnimationsV2 = require(TDX_Shared.Modules.EmoteAnimationsV2)
local EmoteVariants = require(TDX_Shared.Modules.EmoteVariants)
local ViewportCuller = require(game.ReplicatedFirst.Util.ViewportCuller)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local miscResource = ResourceManager.GetMiscResource("EmoteModels", true)

local function BuildEmotePreview(emotevp, p: string)
	if not LocalPlayer.Character then
		return
	end

	local v = EmoteAnimationsV2[EmoteVariants.Resolve(p, LocalPlayer.Character)]
	LocalPlayer.Character.Archivable = true
	local clone = LocalPlayer.Character:Clone()
	LocalPlayer.Character.Archivable = false

	for _, sound in clone:GetDescendants() do
		if sound:IsA("Sound") then
			sound:Destroy()
		end
	end

	if clone:FindFirstChild("EmoteGear") then
		clone.EmoteGear:Destroy()
	end

	clone.HumanoidRootPart.Anchored = true
	clone:PivotTo(CFrame.identity * CFrame.new(0, 1.5, 0))
	local modelNames = v and v.ModelNames

	if modelNames then
		for _, childName in pairs(modelNames) do
			local child = miscResource:FindFirstChild(childName)

			if not child then
				continue
			end

			local clone2 = child:Clone()
			clone2:SetAttribute("EmoteGear", true)

			if clone2:FindFirstChild("Motor") then
				local bodyPart = clone2.Motor:GetAttribute("BodyPart")

				if bodyPart ~= nil then
					bodyPart = clone:FindFirstChild(bodyPart)
				end

				if bodyPart == nil then
					bodyPart = clone.HumanoidRootPart
				end

				clone2.Motor.Part0 = bodyPart
				clone2.Parent = clone
			else
				for _, child2 in pairs(clone2:GetChildren()) do
					if not child2:GetAttribute("Motor") then
						continue
					end

					local bodyPart = child2:GetAttribute("BodyPart")
					local part

					if bodyPart == nil then
						part = clone.HumanoidRootPart
					else
						part = clone:FindFirstChild(bodyPart)
					end

					child2.Part0 = part
				end

				clone2.Parent = clone
			end
		end
	end

	local camera = Instance.new("Camera")
	camera.FieldOfView = 1
	camera.CFrame = CFrame.new(createVector(0, 0, -350), createVector(0, 0, 0))
	camera.Parent = emotevp.WorldModel
	emotevp.CurrentCamera = camera
	clone.Parent = emotevp.WorldModel

	if v then
		clone:WaitForChild("Humanoid"):LoadAnimation(v.Animations[math.random(1, #v.Animations)]):Play()
	end
end

local EmoteEquip = { ClassName = script.Name, ClassModule = script }
EmoteEquip.__index = EmoteEquip

function EmoteEquip.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), SelectedSlot = 0 }, EmoteEquip))
end

function EmoteEquip:Init()
	self.ListViewportCuller = ViewportCuller.new(self.Root.ScrollingFrame)
	self.BarViewportCuller = ViewportCuller.new(self.Root.select.Frame)
	self.Cleaner:Add(self.ListViewportCuller)
	self.Cleaner:Add(self.BarViewportCuller)

	for i = 1, 6 do
		local child = self.Root.select.Frame:FindFirstChild(i)
		local v = i
		self.BarViewportCuller:Add(child, function()
			child.emotevp.WorldModel:ClearAllChildren()
			local v2 = Data.Get("Emotes")[v]

			if v2 and v2 ~= "" then
				child.emotevp.Visible = true
				BuildEmotePreview(child.emotevp, v2)
			end

			return nil
		end, function()
			child.emotevp.WorldModel:ClearAllChildren()
		end)
		local imageButton = child.ImageButton
		self.Cleaner:Add(imageButton.MouseButton1Down:Connect(function()
			SoundHandler.Play("ClickDown")
		end))
		self.Cleaner:Add(imageButton.MouseButton1Up:Connect(function()
			SoundHandler.Play("ClickUp")
		end))
		local v2 = i
		self.Cleaner:Add(imageButton.Activated:Connect(function()
			self:SelectSlot(v2)
		end))
	end

	self.Cleaner:Add(Data.Updated:Connect(function(p)
		if p == "Emotes" then
			self:UpdateEmoteBar()
		elseif p == "Inventory" then
			self:UpdateEmoteList()
		end
	end))
	self:UpdateEmoteList()
	self:UpdateEmoteBar()
end

function EmoteEquip:UpdateEmoteList()
	local emotes = Data.Get("Inventory").Emotes
	local scrollingFrame = self.Root.ScrollingFrame

	for _, child in scrollingFrame:GetChildren() do
		if child.Name == "entry" then
			child:Destroy()
		end
	end

	local clone = table.clone(emotes)
	clone[""] = true

	for k in clone do
		local clone2 = scrollingFrame.template:Clone()
		clone2.Name = "entry"
		clone2.Visible = true
		local text = k == "" and "None" or Lang.Get(Lang.Strings.AssetInfo.Emotes[k].Name)

		if text == nil then
			continue
		end

		clone2.TextLabel.Text = text

		if k == "" then
			clone2.LayoutOrder = -1
		end

		local emotevp = clone2.emotevp
		emotevp.Visible = true
		emotevp.Position = UDim2.new(0.5, 0, 0.95, 0)
		clone2.Parent = scrollingFrame
		local v = k
		self.ListViewportCuller:Add(clone2, function()
			BuildEmotePreview(emotevp, v)
			return nil
		end, function()
			emotevp.WorldModel:ClearAllChildren()
		end)
		clone2.ImageButton.MouseButton1Down:Connect(function()
			SoundHandler.Play("ClickDown")
		end)
		clone2.ImageButton.MouseButton1Up:Connect(function()
			SoundHandler.Play("ClickUp")
		end)
		local v2 = k
		clone2.ImageButton.Activated:Connect(function()
			if self.SelectedSlot then
				local selectedSlot = self.SelectedSlot
				self:SelectSlot(0)

				if Network.Invoke("ClientEquipEmoteRequest", v2, selectedSlot) then
					SoundHandler.Play("Equip")
					self:UpdateEmoteBar()
				end
			end
		end)
	end
end

function EmoteEquip:UpdateEmoteBar()
	for i = 1, 6 do
		self.BarViewportCuller:Invalidate(self.Root.select.Frame:FindFirstChild(i))
	end
end

function EmoteEquip:SelectSlot(p: number)
	self.SelectedSlot = self.SelectedSlot == p and 0 or p

	for _, image in self.Root.select.Frame:GetChildren() do
		if image:IsA("ImageLabel") then
			image.selected.Visible = tonumber(image.Name) == self.SelectedSlot
		end
	end
end

function EmoteEquip:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { EmoteEquip })
return EmoteEquip