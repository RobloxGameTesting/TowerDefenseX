local RunService = game:GetService("RunService")

local function IsGuiHierarchyVisible(parent)
	while parent do
		if parent:IsA("GuiObject") and not parent.Visible then
			return false
		end

		if parent:IsA("LayerCollector") then
			return parent.Enabled
		else
			parent = parent.Parent
		end
	end

	return false
end

local function IsVisibleWithin(parent, container)
	while parent and parent ~= container do
		if parent:IsA("GuiObject") and not parent.Visible then
			return false
		else
			parent = parent.Parent
		end
	end

	return parent == container
end

local function GetVisibleRect(parent)
	local absolutePosition = parent.AbsolutePosition
	local v = absolutePosition + parent.AbsoluteSize

	while parent and not parent:IsA("LayerCollector") do
		if parent:IsA("ScrollingFrame") then
			local absolutePosition2 = parent.AbsolutePosition
			local v2 = absolutePosition2 + parent.AbsoluteWindowSize
			absolutePosition = absolutePosition:Max(absolutePosition2)
			v = v:Min(v2)
		end

		parent = parent.Parent
	end

	return absolutePosition, v
end

local function Intersects(p, point: Vector2, point2: Vector2)
	local absolutePosition = p.AbsolutePosition
	local v = absolutePosition + p.AbsoluteSize
	return absolutePosition.X < point2.X and v.X > point.X and absolutePosition.Y < point2.Y and v.Y > point.Y
end

local ViewportCuller = {}
ViewportCuller.__index = ViewportCuller

function ViewportCuller.new(container, p)
	local object = setmetatable({
		Container = container,
		MaxBuildsPerUpdate = not p and 2 or p.MaxBuildsPerUpdate or 2,
		BufferScale = p and p.BufferScale or 0.5,
		_entries = {},
		_enabledCount = 0,
		_timeSinceUpdate = 1e999,
		_connection = nil
	}, ViewportCuller)
	object._connection = RunService.Heartbeat:Connect(function(dt)
		object._timeSinceUpdate += dt

		if object._timeSinceUpdate < 0.05 then
			return
		end

		object._timeSinceUpdate = 0
		object:_Update()
	end)
	return object
end

function ViewportCuller:Add(instance, build, callback)
	self:Remove(instance)
	self._entries[instance] = {
		Build = build,
		Clear = callback,
		Enabled = false,
		Generation = 0,
		DestroyingConnection = instance.Destroying:Connect(function()
			self:Remove(instance)
		end)
	}
end

function ViewportCuller:Remove(p)
	local entry = self._entries[p]

	if not entry then
		return
	end

	self:_SetEnabled(entry, false)
	entry.DestroyingConnection:Disconnect()
	self._entries[p] = nil
end

function ViewportCuller:Invalidate(p)
	local entry = self._entries[p]

	if entry then
		self:_SetEnabled(entry, false)
	end
end

function ViewportCuller:Destroy()
	if self._connection then
		self._connection:Disconnect()
		self._connection = nil
	end

	for k in self._entries do
		self:Remove(k)
	end
end

function ViewportCuller:_SetEnabled(state, enabled: boolean)
	if state.Enabled == enabled then
		return
	end

	state.Enabled = enabled
	state.Generation += 1
	self._enabledCount += enabled and 1 or -1

	if not enabled then
		state.Clear()
		return
	end

	local generation = state.Generation
	task.spawn(function()
		local v = state.Build()

		if v and (state.Generation ~= generation or not state.Enabled) then
			v:Destroy()
		end
	end)
end

function ViewportCuller:_Update()
	debug.profilebegin("ViewportCuller::Update")

	if IsGuiHierarchyVisible(self.Container) then
		local v, v2 = GetVisibleRect(self.Container)
		local v3 = (v2 - v) * self.BufferScale
		local v4 = v - v3
		local v5 = v2 + v3
		local v6 = {}
		local v7 = {}

		for k, entry in self._entries do
			local visibleWithin = IsVisibleWithin(k, self.Container)

			if visibleWithin then
				local absolutePosition = k.AbsolutePosition
				local v8 = absolutePosition + k.AbsoluteSize

				if absolutePosition.X < v5.X and v8.X > v4.X and absolutePosition.Y < v5.Y then
					visibleWithin = v8.Y > v4.Y
				else
					visibleWithin = false
				end
			end

			if visibleWithin then
				if not entry.Enabled then
					local absolutePosition = k.AbsolutePosition
					local v8 = absolutePosition + k.AbsoluteSize
					local v9

					if absolutePosition.X < v2.X and v8.X > v.X and absolutePosition.Y < v2.Y then
						v9 = v8.Y > v.Y
					else
						v9 = false
					end

					local v10

					if v9 then
						v10 = v6
					else
						v10 = v7
					end

					table.insert(v10, entry)
				end
			else
				self:_SetEnabled(entry, false)
			end
		end

		local maxBuildsPerUpdate = self.MaxBuildsPerUpdate

		for _, v8 in { v6, v7 } do
			for _, v9 in v8 do
				if maxBuildsPerUpdate <= 0 then
					break
				else
					self:_SetEnabled(v9, true)
					maxBuildsPerUpdate -= 1
				end
			end
		end

		debug.profileend()
	else
		if self._enabledCount > 0 then
			for _, entry in self._entries do
				self:_SetEnabled(entry, false)
			end
		end

		debug.profileend()
	end
end

return ViewportCuller