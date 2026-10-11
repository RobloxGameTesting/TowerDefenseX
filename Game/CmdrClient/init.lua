local RunService = game:GetService("RunService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Shared = script:WaitForChild("Shared")
local Util = require(Shared:WaitForChild("Util"))

if RunService:IsClient() == false then
	error("[Cmdr] Server scripts cannot require the client library. Please require the server library from the server to use Cmdr in your own code.")
end

local v = {
	ReplicatedRoot = script,
	RemoteFunction = script:WaitForChild("CmdrFunction"),
	RemoteEvent = script:WaitForChild("CmdrEvent"),
	ActivationKeys = { [Enum.KeyCode.F2] = true },
	Enabled = true,
	MashToEnable = false,
	ActivationUnlocksMouse = false,
	HideOnLostFocus = true,
	PlaceName = "Cmdr",
	Util = Util,
	Events = {}
}
local object = setmetatable(v, {
	__index = function(p, p2)
		local v2 = p.Dispatcher[p2]

		if v2 and type(v2) == "function" then
			return function(_, ...)
				return v2(p.Dispatcher, ...)
			end
		end
	end
})
local Registry = require(Shared.Registry)
object.Registry = Registry(object)
local Dispatcher = require(Shared.Dispatcher)
object.Dispatcher = Dispatcher(object)

if
	StarterGui:WaitForChild("Cmdr")
	and task.wait()
	and LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("Cmdr") == nil
then
	local clone = StarterGui.Cmdr:Clone()
	clone.Parent = LocalPlayer.PlayerGui
end

local CmdrInterface = require(script.CmdrInterface)
local cmdrInterface = CmdrInterface(object)

function object:SetActivationKeys(p)
	self.ActivationKeys = Util.MakeDictionary(p)
end

function object:SetPlaceName(placeName: string)
	self.PlaceName = placeName
	cmdrInterface.Window:UpdateLabel()
end

function object:SetEnabled(enabled: boolean)
	self.Enabled = enabled
end

function object:SetActivationUnlocksMouse(activationUnlocksMouse: boolean)
	self.ActivationUnlocksMouse = activationUnlocksMouse
end

function object:Show()
	if not self.Enabled then
		return
	end

	cmdrInterface.Window:Show()
end

function object:Hide()
	cmdrInterface.Window:Hide()
end

function object:Toggle()
	if self.Enabled then
		cmdrInterface.Window:SetVisible(not cmdrInterface.Window:IsVisible())
	else
		self:Hide()
	end
end

function object:SetMashToEnable(mashToEnable: boolean)
	self.MashToEnable = mashToEnable

	if mashToEnable then
		self:SetEnabled(false)
	end
end

function object:SetHideOnLostFocus(hideOnLostFocus: boolean)
	self.HideOnLostFocus = hideOnLostFocus
end

function object.HandleEvent(p, p2: string, callback)
	p.Events[p2] = callback
end

if RunService:IsServer() == false then
	object.Registry:RegisterTypesIn(script:WaitForChild("Types"))
	object.Registry:RegisterCommandsIn(script:WaitForChild("Commands"))
end

object.RemoteEvent.OnClientEvent:Connect(function(p, ...)
	if object.Events[p] then
		object.Events[p](...)
	end
end)
local DefaultEventHandlers = require(script.DefaultEventHandlers)
DefaultEventHandlers(object)
return object