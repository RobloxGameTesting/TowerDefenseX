local WeaponFrameClass = {}
WeaponFrameClass.__index = WeaponFrameClass
local ReplicatedStorage = game:GetService("ReplicatedStorage")
game:GetService("Players")
game:GetService("GuiService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("FirstPersonTypes"))
require(common:WaitForChild("Utilities"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local Keybinds = require(common:WaitForChild("Keybinds"))
local parent = script.Parent.Parent.Parent
require(parent:WaitForChild("FirstPersonAttackManager"))
local color = Color3.fromRGB(255, 255, 255)
local color2 = Color3.fromRGB(0, 0, 0)
local event = BindableHandler.GetEvent("DirectControlSelectWeapon")

function WeaponFrameClass.New(p: number, frame)
	local reloadFrame = frame.ReloadFrame
	local defaultFrame = frame.DefaultFrame
	local hotkeyHolder = frame.HotkeyHolder
	local hotkey = hotkeyHolder.Hotkey
	local v = {
		Index = p,
		Frame = frame,
		ReloadFrame = reloadFrame,
		DefaultFrame = defaultFrame,
		ReloadWeaponNameText = reloadFrame.NameText,
		ReloadBarJuice = reloadFrame.BarHolder.Bar,
		DefaultWeaponNameText = defaultFrame.NameText,
		DefaultWeaponAmmoText = defaultFrame.AmmoTextHolder.AmmoText,
		Enabled = false,
		Selected = false,
		Reloading = false
	}
	Keybinds.BindLabel(hotkey, `DirectControlSelectWeapon{p}`, hotkeyHolder)
	setmetatable(v, WeaponFrameClass)
	v:_UpdateState()
	frame.Activated:Connect(function()
		event:Fire(p)
	end)
	return v
end

function WeaponFrameClass:SetAttackConfig(p)
	if p then
		self.Enabled = true
	else
		self.Enabled = false
	end

	if p then
		self.DefaultWeaponNameText.Text = p.WeaponName
		self.ReloadWeaponNameText.Text = p.WeaponName
	end

	self:_UpdateState()
end

function WeaponFrameClass:Deselect()
	self.Selected = false
	self:_UpdateState()
end

function WeaponFrameClass:Select()
	self.Selected = true
	self:_UpdateState()
end

function WeaponFrameClass:_UpdateState()
	if self.Enabled then
		self.Frame.Visible = true
	else
		self.Frame.Visible = false
	end

	if self.Selected then
		self.Frame.BackgroundColor3 = color
	else
		self.Frame.BackgroundColor3 = color2
	end

	self.Frame.BackgroundTransparency = 0.8

	if self.Reloading then
		self.ReloadFrame.Visible = true
		self.DefaultFrame.Visible = false
	else
		self.ReloadFrame.Visible = false
		self.DefaultFrame.Visible = true
	end
end

function WeaponFrameClass:_SetIsReloading(reloading: boolean)
	if self.Reloading == reloading then
		return
	end

	self.Reloading = reloading
	self:_UpdateState()
end

function WeaponFrameClass:Run(_: number, data)
	if not self.Enabled then
		return
	end

	self:_SetIsReloading(data.IsReloading)

	if not data.IsReloading then
		self.DefaultWeaponAmmoText.Text = string.format("%03d", data.ShotsRemaining)
		return
	end

	local v = data.ReloadTimeRemaining / data.TotalReloadTime
	self.ReloadBarJuice.Size = UDim2.new(v, 0, 1, 0)
end

return WeaponFrameClass