local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundHandler = require(ReplicatedStorage.TDX_Shared.Common.SoundHandler)
local Cleaner = require(ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)

local function fn() end

local WindowHandler = { ClassName = script.Name, ClassModule = script }
WindowHandler.__index = WindowHandler

function WindowHandler.new(root)
	return (setmetatable({ Root = root, Cleaner = Cleaner.new(), Stack = {} }, WindowHandler))
end

function WindowHandler:Init()
	local back = self.Root.back
	self.Cleaner:Add(back.Folder.TextButton.MouseButton1Click:Connect(function()
		SoundHandler.Play("ClickUp")
		local v = table.remove(self.Stack, 1)

		if v then
			for _, image in self.Root:GetChildren() do
				if image:IsA("ImageLabel") then
					image.Visible = image.Name == v[1]
				end
			end

			task.spawn(v[2])

			if next(self.Stack) == nil then
				back.Visible = false
			else
				self:SetBackState(self.Stack[1][3])
			end
		end
	end))
	self.Cleaner:Add(back.Folder.TextButton.MouseButton1Down:Connect(function()
		SoundHandler.Play("ClickDown")
	end))
end

function WindowHandler.Navigate(p, p2: string)
	for _, image in p.Root:GetChildren() do
		if image:IsA("ImageLabel") then
			image.Visible = image.Name == p2
		end
	end
end

function WindowHandler:PushToBackStack(p: string, callback, p2: string?)
	table.insert(self.Stack, 1, { p, callback or fn, p2 or p })
	self:SetBackState(p2 or p)
end

function WindowHandler:SetBackState(value: string)
	self.Root.back.Visible = true
	self.Root.back.title.Text = string.upper(value)
end

function WindowHandler.ClearState(p)
	table.clear(p.Stack)
	p.Root.back.Visible = false
end

function WindowHandler.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { WindowHandler }, game.Players)
return WindowHandler