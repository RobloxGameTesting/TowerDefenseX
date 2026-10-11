local createVector = vector.create
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicatedFirst = game:GetService("ReplicatedFirst")
local ContentProvider = game:GetService("ContentProvider")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Director = require(TDX_Shared.Modules.Director)
local Crates = require(TDX_Shared.Modules.Crates)
local Shared = require(TDX_Shared.Modules.Shared)
local Cleaner = require(TDX_Shared.Modules.Cleaner)
local Util = require(TDX_Shared.Modules.Util)
local Network = require(ReplicatedFirst.Client.Network)
local Camera = require(ReplicatedFirst.Client.Camera)
local Data = require(TDX_Shared.Client.Services.Data)
local Lang = require(TDX_Shared.Modules.Lang)
require(ReplicatedFirst.Classes.UI.Sidebar)
require(ReplicatedStorage.Modules.ShopDataV2)
local ClientUtil = require(game.ReplicatedFirst.Util.ClientUtil)
local UIHelper = require(ReplicatedFirst.Util.UIHelper)
local PurchaseHelper = require(ReplicatedFirst.Util.PurchaseHelper)
local tweenInfo = TweenInfo.new(0.16, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local tweenInfo2 = TweenInfo.new(5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenInfo3 = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local crates = ReplicatedStorage.LobbyResources.Crates
local CrateSpin = { ClassName = script.Name, ClassModule = script }
CrateSpin.__index = CrateSpin

function CrateSpin.new(root)
	return (setmetatable({
		Root = root,
		Cleaner = Cleaner.new(),
		Unboxing = false,
		Billboard = Util.Create("BillboardGui", {
			MaxDistance = 50,
			ResetOnSpawn = false,
			StudsOffset = createVector(0, 1.25, 0),
			Size = UDim2.new(8, 0, 8, 0),
			AlwaysOnTop = true,
			Active = true,
			Parent = LocalPlayer:WaitForChild("PlayerGui")
		})
	}, CrateSpin))
end

function CrateSpin:Init()
	self.Template = self.Root.ImageLabel.items.Frame.ItemTemplate
	self.Template.Parent = nil
	self.Uncrate = Util.Create("Sound", {
		Name = "Uncrate",
		SoundId = "rbxassetid://15098083787",
		Volume = 0.5,
		Parent = self.Root
	})
	self.Cleaner:Add(Network.HookEvent("ClientCrateSpin", function(p: string, p2)
		for _, v in Director.GetItemsFromClass(Director.Classes.AnnouncementsWindow) do
			v.Root.Visible = false
		end

		UIHelper.HideMainShopWindows()
		self:Spin(p, p2)
	end))
end

function CrateSpin:ShowUnboxed(data, flag: boolean?)
	self.Uncrate:Play()
	local unboxed = self.Root.Unboxed
	local color = data.Color
	local textureImageId = data.TextureImageId
	unboxed.div.rarity.Text = string.upper(data.Rarity)
	unboxed.div.rarity.TextColor3 = Shared.RARITY_COLORS[data.Rarity]
	unboxed.div.item.Text = string.upper(data.DisplayName or data.Name)
	local v = data.Name:split("_")[1]
	local tower = Lang.Strings.AssetInfo.Towers[v]
	local towerName = unboxed.TowerName

	if tower then
		v = Lang.Get(tower.Name)
	end

	towerName.Text = string.upper(v)
	unboxed.back.img.Image = data.Image
	unboxed.back.clr.Visible = color ~= nil
	unboxed.back.texture.Visible = textureImageId ~= nil

	if color then
		unboxed.back.clr.BackgroundColor3 = color
	end

	if textureImageId then
		unboxed.back.texture.Image = textureImageId
	end

	unboxed.Position = UDim2.new(0.5, 0, 0.55, 0)
	unboxed.Visible = true
	TweenService:Create(unboxed, tweenInfo, { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
	unboxed.Purchase.TextLabel.Text = Lang.Get(Lang.Strings.General.OpenAnother)
	unboxed.Purchase.Visible = not flag
	local v2 = false
	local mouseButton1ClickConnection = unboxed.Purchase.MouseButton1Click:Connect(function()
		v2 = true
		unboxed.Visible = false
	end)
	unboxed:GetPropertyChangedSignal("Visible"):Wait()
	mouseButton1ClickConnection:Disconnect()
	return v2
end

local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://15177639994"
task.spawn(function()
	ContentProvider:PreloadAsync({ animation })
end)

function CrateSpin:Spin(p: string, p2)
	for _, v in Director.GetItemsFromClass(Director.Classes.TowerBar) do
		v:HideSkinSelect()
	end

	SoundHandler.Play("CrateOpen")
	self.Unboxing = true
	local clone = crates[Crates.GetCrateData(p).ModelType]:Clone()
	clone:PivotTo(workspace.CratePosition.CFrame)
	clone.Parent = workspace.CurrentCamera
	Camera.Enabled = true
	Camera.Target = clone.CamPart.Attachment
	Camera.SpeedOverride = 100
	local track = clone.AnimationController:LoadAnimation(animation)
	track.KeyframeReached:Connect(function(p3)
		if p3 == "End" then
			track:AdjustSpeed(0)
		end
	end)
	track:Play()
	local number = Random.new():NextNumber(-100, 100)
	local heartbeatConnection = RunService.Heartbeat:Connect(function(dt)
		local v = Vector3.new(
			math.noise(number, 0) * 0.5,
			math.noise(0, number) * 0.5,
			math.noise(number, number) * 0.5
		) * 2 * createVector(1, 0.5, 0.5)
		local cframe = CFrame.Angles(0, math.rad(v.Y), 0) * CFrame.Angles(math.rad(v.X), 0, (math.rad(v.Z)))
		clone.CamPart.Attachment.CFrame = cframe
		number += dt * 0.25
	end)
	task.wait(1.5)
	local imageLabel = self.Root.ImageLabel
	imageLabel.items.Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
	imageLabel.Position = UDim2.new(0.5, 0, 0.6, 0)
	TweenService:Create(imageLabel, tweenInfo, { Position = UDim2.new(0.5, 0, 0.5, 0) }):Play()
	local v = Util.Create("Sound", {
		Name = "RollingSound",
		SoundId = "rbxassetid://15098084770",
		Volume = 0.25,
		Parent = self.Root
	})

	for _, frame in imageLabel.items.Frame:GetChildren() do
		if frame:IsA("Frame") then
			frame:Destroy()
		end
	end

	local crateData = Crates.GetCrateData(p)
	local names

	if crateData.NoDupes then
		names = {}

		for _, skin in crateData.Skins do
			if skin.Name == p2.Name then
				continue
			end

			local v2, v3 = unpack(string.split(skin.Name, "_"))

			if ClientUtil.OwnsSkin(v2, v3) then
				table.insert(names, skin.Name)
			end
		end
	end

	for i = 1, 100 do
		local v2

		if i == 91 then
			v2 = p2
		else
			v2 = Crates.RollCrate(p, names)
		end

		local clone2 = self.Template:Clone()
		clone2.Name = i
		clone2.LayoutOrder = i

		if v2.Color then
			clone2.clr.Visible = true
			clone2.clr.BackgroundColor3 = v2.Color
			clone2.clr.BorderColor3 = Color3.new(1, 1, 1)
			clone2.clr.BorderSizePixel = 2
		end

		if v2.TextureImageId then
			clone2.texture.Visible = true
			clone2.texture.Image = v2.TextureImageId
			clone2.texture.BorderColor3 = Color3.new(1, 1, 1)
			clone2.texture.BorderSizePixel = 2
		end

		local imageColor = Shared.RARITY_COLORS[v2.Rarity]
		clone2.ImageLabel.ImageColor3 = imageColor
		clone2.ImageLabel2.ImageColor3 = imageColor
		clone2.ItemImage.Image = v2.Image
		clone2.Parent = imageLabel.items.Frame
	end

	imageLabel.Visible = true
	local v2 = 12 + math.random(72, 84) * 0.01
	TweenService:Create(imageLabel.items.Frame, tweenInfo2, {
		Position = UDim2.new(-v2, 0, 0.5, 0)
	}):Play()
	local now = tick()
	local activatedConnection = nil
	local flag = false
	activatedConnection = imageLabel.skip.Activated:Connect(function()
		TweenService:Create(imageLabel.items.Frame, tweenInfo3, {
			Position = UDim2.new(-v2, 0, 0.5, 0)
		}):Play()
		now = tick() - 5
		flag = true
		activatedConnection:Disconnect()
	end)
	local v3 = 0

	while not (tick() - now >= 7) do
		local skip = imageLabel.skip
		skip.Visible = not flag and tick() - now < 4
		local v4 = math.floor((imageLabel.items.Frame.Position.X.Scale - 0.07) / 0.152023)

		if v4 ~= v3 then
			v:Play()
			v3 = v4
		end

		task.wait()
	end

	v:Destroy()
	imageLabel.Visible = false
	local v4 = self:ShowUnboxed(p2)
	heartbeatConnection:Disconnect()
	track:Destroy()
	clone:Destroy()

	if v4 then
		local v5 = nil

		if (Data.Get("FreeCrates")[p] or 0) > 0 then
			v5 = Network.Invoke("ClientOpenFreeCrateRequest", p)
		elseif not PurchaseHelper.IsCratePurchaseRestricted(true, p, false) then
			v5 = Network.Invoke("ClientOpenCrateRequest", p, false, "Open Another")
		end

		if v5 then
			return
		end
	end

	self.Unboxing = false
	Camera.Enabled = false
	Camera.SpeedOverride = nil
	Camera.Target = nil
end

function CrateSpin:Destroy()
	self.Cleaner:Clean()
end

Director.Register(script.Name, { CrateSpin }, LocalPlayer:WaitForChild("PlayerGui"))
return CrateSpin