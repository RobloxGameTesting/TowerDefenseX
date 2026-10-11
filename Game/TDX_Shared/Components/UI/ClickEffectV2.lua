local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local tweenInfo = TweenInfo.new(0.1)
local ClickEffectV2 = { ClassName = script.Name, ClassModule = script }
ClickEffectV2.__index = ClickEffectV2

local function CONVERT()
	local v = game.Selection:Get()

	for _, parent in pairs(v) do
		local hoverImage = parent.HoverImage

		if not (hoverImage and hoverImage ~= "") then
			continue
		end

		local hovered = parent:FindFirstChild("Hovered") or Instance.new("ImageLabel")
		hovered.Name = "Hovered"
		hovered.BackgroundTransparency = 1
		hovered.Image = hoverImage
		hovered.AnchorPoint = Vector2.new(0.5, 0.5)
		hovered.Position = UDim2.new(0.5, 0, 0.5, 0)
		hovered.Size = UDim2.new(1, 0, 1, 0)
		hovered.Parent = parent
		hovered.ImageTransparency = 1
		parent.HoverImage = ""
	end
end

function ClickEffectV2.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		Scale = nil,
		Enabled = true,
		Hovered = false,
		Selected = false,
		Flashing = false,
		LastFlashSwitchTime = 0,
		TextLabel = nil
	}, ClickEffectV2))
end

function ClickEffectV2:Init()
	local root = self.Root
	local noTween = root:GetAttribute("NoTween")
	local flag = false
	self.TextLabel = root:FindFirstChild("TextLabel")
	self.HoveredImage = root:FindFirstChild("Hovered")
	self.HasSelectedState = root:GetAttribute("Selected") ~= nil
	self.SelectedImage = self.HasSelectedState and root:FindFirstChild("Selected")
	self.DisabledIfSelected = root:GetAttribute("DisabledIfSelected")
	self.HasFlashingState = root:GetAttribute("Flashing") ~= nil
	self.FlashingImage = self.HasFlashingState and root:FindFirstChild("Flashing")
	self.NoSound = root:GetAttribute("NoSound")

	if not noTween then
		local customTweenScale = root:GetAttribute("CustomTweenScale") or 0.92
		self.Scale = Instance.new("UIScale")
		self.Scale.Scale = 1
		self.Scale.Parent = root
		self.TweenDown = TweenService:Create(self.Scale, tweenInfo, { Scale = customTweenScale })
		self.TweenUp = TweenService:Create(self.Scale, tweenInfo, { Scale = 1 })
		self.Cleaner:Add(self.Scale)
		self.Cleaner:Add(self.TweenDown)
		self.Cleaner:Add(self.TweenUp)
	end

	if self.HasSelectedState and self.SelectedImage then
		self.Cleaner:Add(root:GetAttributeChangedSignal("Selected"):Connect(function()
			self.Selected = root:GetAttribute("Selected")
			self:_UpdateState()
		end))

		if root:GetAttribute("Selected") then
			self.Selected = root:GetAttribute("Selected")
			self:_UpdateState()
		end
	end

	self.Cleaner:Add(root.MouseEnter:Connect(function()
		self.Hovered = true
		self:_UpdateState()
	end))
	self.Cleaner:Add(root.MouseLeave:Connect(function()
		if flag then
			self:MouseButton1Up()
		end

		self.Hovered = false
		self:_UpdateState()
	end))
	self.Cleaner:Add(root.MouseButton1Down:Connect(function()
		if not self.Enabled then
			return
		end

		flag = true
		self:MouseButton1Down()

		if not self.NoSound then
			SoundHandler.Play("ClickDown")
		end
	end))
	self.Cleaner:Add(root.MouseButton1Up:Connect(function()
		if not self.Enabled then
			return
		end

		flag = false
		self:MouseButton1Up()
	end))
	self.Cleaner:Add(root.Activated:Connect(function()
		if not self.Enabled then
			return
		end

		if not self.NoSound then
			SoundHandler.Play("ClickUp")
		end
	end))

	if self.HasFlashingState then
		self.Cleaner:Add(root:GetAttributeChangedSignal("Flashing"):Connect(function()
			self.Flashing = root:GetAttribute("Flashing")
			self.LastFlashSwitchTime = os.clock()

			if not self.Flashing then
				self.FlashingImage.Visible = false
			end
		end))
		self.Cleaner:Add(RunService.Heartbeat:Connect(function()
			if not self.Flashing then
				return
			end

			local flashingImage = self.FlashingImage

			if os.clock() - self.LastFlashSwitchTime < 0.75 then
				return
			end

			self.LastFlashSwitchTime = os.clock()
			flashingImage.Visible = not flashingImage.Visible
		end))
		self.Flashing = root:GetAttribute("Flashing")
	end

	self:_UpdateState()
end

function ClickEffectV2:MouseButton1Down()
	if self.TweenDown then
		self.TweenDown:Play()
	end
end

function ClickEffectV2:MouseButton1Up()
	if self.TweenUp then
		self.TweenUp:Play()
	end
end

function ClickEffectV2:_UpdateState()
	if self.DisabledIfSelected then
		self.Enabled = not self.Selected
	end

	local hovered = self.Hovered
	local selected = self.Selected
	local enabled = self.Enabled
	local root = self.Root
	local textLabel = self.TextLabel
	local hoveredImage = self.HoveredImage
	local selectedImage = self.SelectedImage
	local defaultTextColor = root:GetAttribute("DefaultTextColor")
	local hoveredTextColor = root:GetAttribute("HoveredTextColor") or defaultTextColor
	local selectedTextColor = root:GetAttribute("SelectedTextColor") or hoveredTextColor

	if self.TextLabel and defaultTextColor then
		if enabled and not selected then
			if hovered then
				textLabel.TextColor3 = hoveredTextColor
			else
				textLabel.TextColor3 = defaultTextColor
			end
		else
			textLabel.TextColor3 = selectedTextColor
		end
	end

	if hoveredImage then
		hoveredImage.ImageTransparency = enabled and hovered and 0 or 1
	end

	if selectedImage then
		selectedImage.ImageTransparency = selected and 0 or 1
	end
end

function ClickEffectV2.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { ClickEffectV2 })
return ClickEffectV2