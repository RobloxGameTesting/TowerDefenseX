local Common = game.ReplicatedStorage.TDX_Shared:WaitForChild("Common")
local Director = require(game.ReplicatedStorage.TDX_Shared.Modules.Director)
local Cleaner = require(game.ReplicatedStorage.TDX_Shared.Modules.Cleaner)
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local CategoryNavigation = { ClassName = script.Name, ClassModule = script }
CategoryNavigation.__index = CategoryNavigation

function CategoryNavigation.new(instance)
	return (setmetatable(
		{
			Root = instance,
			Cleaner = Cleaner.new(),
			NavType = instance:GetAttribute("NavType"),
			CurrCategory = instance:GetAttribute("StartCategory")
		},
		CategoryNavigation
	))
end

function CategoryNavigation:Init()
	for _, image in self.Root.Frame:GetChildren() do
		if not image:IsA("ImageLabel") then
			continue
		end

		self.Cleaner:Add(image.TextButton.MouseButton1Down:Connect(function()
			SoundHandler.Play("ClickDown")
		end))
		local v = image
		self.Cleaner:Add(image.TextButton.MouseButton1Click:Connect(function()
			SoundHandler.Play("ClickUp")
			self:ViewCategory(v.Name)
		end))
		local v2 = image
		self.Cleaner:Add(image.TextButton.MouseEnter:Connect(function()
			if v2.Name == self.CurrCategory then
				return
			end

			v2.selected.ImageTransparency = 0.5
		end))
		local v3 = image
		self.Cleaner:Add(image.TextButton.MouseLeave:Connect(function()
			if v3.Name == self.CurrCategory then
				return
			end

			v3.selected.ImageTransparency = 1
		end))
	end

	if self.NavType == "Inventory" then
		self:ViewCategory(self.CurrCategory)
	end
end

function CategoryNavigation:ViewCategory(currCategory: string)
	self.CurrCategory = currCategory

	for _, image in self.Root.Frame:GetChildren() do
		if image:IsA("ImageLabel") then
			image.selected.ImageTransparency = image.Name == currCategory and 0 or 1
		end
	end

	if self.NavType == "Shop" then
		local v = Director.GetClassesFromItem(self.Root.Parent.ItemHolder)[Director.Classes.ItemGridWindow]

		if v then
			v:OpenCategory(currCategory)
		end
	elseif self.NavType == "Inventory" then
		local child = self.Root.Parent:FindFirstChild(currCategory)

		for _, image in self.Root.Frame:GetChildren() do
			if not image:IsA("ImageLabel") then
				continue
			end

			local child2 = self.Root.Parent:FindFirstChild(image.Name)

			if child2 then
				child2.Visible = child2 == child
			end
		end

		if child then
			local itemHolder = child:FindFirstChild("ItemHolder")
			local v = itemHolder ~= nil and Director.GetClassesFromItem(itemHolder)[Director.Classes.ItemGridWindow]

			if v then
				v:OpenCategory(currCategory)
			end
		end
	end
end

function CategoryNavigation.Destroy(p)
	p.Cleaner:Clean()
end

Director.Register(script.Name, { CategoryNavigation }, game.Players)
return CategoryNavigation