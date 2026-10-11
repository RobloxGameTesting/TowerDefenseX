local TouchInput = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Utilities"))
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local event = BindableHandler.GetEvent("TouchTapInWorld")
local event2 = BindableHandler.GetEvent("DoubleTouchTapInWorld")
local event3 = BindableHandler.GetEvent("TouchStarted")
local event4 = BindableHandler.GetEvent("TouchMoved")
local LocalPlayer = Players.LocalPlayer
local v = true
local now = os.clock()
local v2 = nil

function TouchInput.Initialize()
	UserInputService.TouchTapInWorld:Connect(function(point: Vector2, flag: boolean)
		if not v then
			return
		end

		local now2 = os.clock()

		if v2 and (v2 - point).Magnitude <= 50 and now2 - now <= 0.5 then
			event2:Fire(flag)
			return
		end

		now = now2
		v2 = point
		event:Fire(point, flag)
	end)
	UserInputService.TouchStarted:Connect(function(p)
		if not v then
			return
		end

		event3:Fire(Vector2.new(p.Position.X, p.Position.Y + GuiService:GetGuiInset().Y))
	end)
	UserInputService.TouchMoved:Connect(function(p)
		if not v then
			return
		end

		event4:Fire(Vector2.new(p.Position.X, p.Position.Y + GuiService:GetGuiInset().Y))
	end)
end

function TouchInput.Enable()
	v = true
end

function TouchInput.Disable()
	v = false
end

return TouchInput