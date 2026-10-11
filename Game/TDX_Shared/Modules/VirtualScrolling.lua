--!native
local RunService = game:GetService("RunService")
local Trove = require(script.Parent.Trove)
local udim = UDim2.fromScale(0, 0)

local function getCumulativeUIScale(parent, layerCollector)
	if not layerCollector then
		return 1
	end

	local v = 1

	while parent do
		local uiScale = parent:FindFirstChildOfClass("UIScale")

		if uiScale then
			v *= uiScale.Scale
		end

		if parent == layerCollector then
			return (math.max(v, 1e-6))
		else
			parent = parent.Parent
		end
	end

	return 1
end

local function bind(data)
	local scrollingFrame = assert(data.Container, "Expected config.Container")
	assert(scrollingFrame:IsA("ScrollingFrame"), "Expected config.Container to be a ScrollingFrame")
	local gridLayout = data.GridLayout
		or assert(
			scrollingFrame:FindFirstChildWhichIsA("UIGridLayout"),
			`UIGridLayout not found in Container {scrollingFrame:GetFullName()}`
		)
	local template = data.Template
	local itemIdentifier = data.ItemIdentifier
	local constructor = data.Constructor
	local v = math.max(0, (math.floor(data.BufferRows or 1)))
	local v2 = math.max(1, (math.floor(data.MaxBindsPerFrame or 1e999)))
	local v3 = math.max(0, (math.floor(data.PreloadSlots or 0)))
	local fitColumnsToMaxCells = data.FitColumnsToMaxCells == true
	local maid = Trove.new()
	local parent2 = maid:Add(Instance.new("Folder"))
	parent2.Name = "VirtualScrollSlots"
	parent2.Parent = scrollingFrame
	local automaticCanvasSize = scrollingFrame.AutomaticCanvasSize
	scrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.None
	maid:Add(function()
		scrollingFrame.AutomaticCanvasSize = automaticCanvasSize
	end)
	local v4 = {}
	local v5 = {}

	local function runDestructor(callback)
		if not callback then
			return
		end

		xpcall(callback, function(p)
			task.spawn(error, debug.traceback(p, 3))
		end)
	end

	local function cloneSlot() -- 1 equivalent call inferred from this helper
		debug.profilebegin("VirtualScrolling::CloneTemplate")
		local clone = template:Clone()
		clone.Visible = false
		clone.Parent = parent2
		debug.profileend()
		return clone
	end

	local function getSlot() -- 1 equivalent call inferred from this helper
		local clone = table.remove(v5)

		if clone then
			return clone
		end

		debug.profilebegin("VirtualScrolling::CloneTemplate")
		clone = template:Clone()
		clone.Visible = false
		clone.Parent = parent2
		debug.profileend()
		return clone
	end

	local function returnSlot(slot) -- 10 equivalent calls inferred from this helper
		slot.Visible = false
		table.insert(v5, slot)
	end

	local function destroyRendered(p: number)
		local v6 = v4[p]

		if not v6 then
			return
		end

		v4[p] = nil
		local destructor = v6.Destructor

		if destructor then
			xpcall(destructor, function(p2)
				task.spawn(error, debug.traceback(p2, 3))
			end)
		end

		returnSlot(v6.Slot) -- inferred equivalent call
	end

	local function destroyAllRendered()
		for k in pairs(v4) do
			local v6 = v4[k]

			if not v6 then
				continue
			end

			v4[k] = nil
			local destructor = v6.Destructor

			if destructor then
				xpcall(destructor, function(p)
					task.spawn(error, debug.traceback(p, 3))
				end)
			end

			returnSlot(v6.Slot) -- inferred equivalent call
		end
	end

	local count = 0
	local v6 = {}
	local count2 = 0
	local v7 = {}
	local v8 = {}

	for _ = 1, v3 do
		table.insert(v5, cloneSlot()) -- inferred equivalent call
	end

	local anchorPoint = template.AnchorPoint
	local cellSize = gridLayout.CellSize
	maid:Add(gridLayout:GetPropertyChangedSignal("CellSize"):Connect(function()
		cellSize = gridLayout.CellSize
	end))
	local cellPadding = gridLayout.CellPadding
	maid:Add(gridLayout:GetPropertyChangedSignal("CellPadding"):Connect(function()
		cellPadding = gridLayout.CellPadding
	end))
	local fillDirectionMaxCells = gridLayout.FillDirectionMaxCells
	maid:Add(gridLayout:GetPropertyChangedSignal("FillDirectionMaxCells"):Connect(function()
		fillDirectionMaxCells = gridLayout.FillDirectionMaxCells
	end))
	local horizontalAlignment = gridLayout.HorizontalAlignment
	maid:Add(gridLayout:GetPropertyChangedSignal("HorizontalAlignment"):Connect(function()
		horizontalAlignment = gridLayout.HorizontalAlignment
	end))
	local aspectRatio = nil
	local aspectType = nil
	local dominantAxis = nil
	local maid2 = maid:Extend()

	local function bindAspectRatio()
		maid2:Clean()
		local uiAspectRatioConstraint = gridLayout:FindFirstChildWhichIsA("UIAspectRatioConstraint")

		if uiAspectRatioConstraint then
			aspectRatio = uiAspectRatioConstraint.AspectRatio
			aspectType = uiAspectRatioConstraint.AspectType
			dominantAxis = uiAspectRatioConstraint.DominantAxis
			maid2:Add(uiAspectRatioConstraint:GetPropertyChangedSignal("AspectRatio"):Connect(function()
				aspectRatio = uiAspectRatioConstraint.AspectRatio
			end))
			maid2:Add(uiAspectRatioConstraint:GetPropertyChangedSignal("AspectType"):Connect(function()
				aspectType = uiAspectRatioConstraint.AspectType
			end))
			maid2:Add(uiAspectRatioConstraint:GetPropertyChangedSignal("DominantAxis"):Connect(function()
				dominantAxis = uiAspectRatioConstraint.DominantAxis
			end))
		else
			aspectRatio = nil
			aspectType = nil
			dominantAxis = nil
		end
	end

	bindAspectRatio()
	maid:Add(gridLayout.ChildAdded:Connect(function(uiAspectRatioConstraint)
		if uiAspectRatioConstraint:IsA("UIAspectRatioConstraint") then
			bindAspectRatio()
		end
	end))
	maid:Add(gridLayout.ChildRemoved:Connect(function(uiAspectRatioConstraint)
		if uiAspectRatioConstraint:IsA("UIAspectRatioConstraint") then
			bindAspectRatio()
		end
	end))
	local layerCollector = scrollingFrame:FindFirstAncestorWhichIsA("LayerCollector")
	maid:Add(scrollingFrame.AncestryChanged:Connect(function()
		layerCollector = scrollingFrame:FindFirstAncestorWhichIsA("LayerCollector")
	end))

	local function isHierarchyVisible()
		if not (layerCollector and layerCollector.Enabled) then
			return false
		end

		local parent = scrollingFrame

		while parent ~= layerCollector do
			if not parent then
				return false
			end

			if parent:IsA("GuiObject") and not parent.Visible then
				return false
			else
				parent = parent.Parent
			end
		end

		return true
	end

	local canvasPosition = nil
	local flag = false
	local v9 = nil
	local y = nil
	local v10 = -1
	local v11 = nil
	local v12 = nil
	local point = nil
	local v13 = nil
	local v14 = nil
	local v15 = nil
	local v16 = nil
	local v17 = nil
	local v18 = nil
	local v19 = nil
	local v20 = nil
	local v21 = nil
	local v22 = nil
	local v23 = nil
	local v24 = nil
	local v25 = nil

	local function computeSlotPosition(p: number, p2: number, p3: number, p4: number, p5: number, p6: number) -- 2 equivalent calls inferred from this helper
		local v26 = (p - 1) % p2
		local v27 = math.ceil(p / p2) - 1
		return UDim2.fromOffset(p5 + v26 * p3, p6 + v27 * p4)
	end

	local function applyCellAspectRatio(p: number, p2: number)
		if not aspectRatio then
			return p, p2
		end

		if aspectType == Enum.AspectType.FitWithinMaxSize then
			if dominantAxis == Enum.DominantAxis.Width then
				local v26 = p / aspectRatio

				if v26 <= p2 then
					return p, v26
				end

				return p2 * aspectRatio, p2
			else
				local v26 = p2 * aspectRatio

				if v26 <= p then
					return v26, p2
				end

				return p, p / aspectRatio
			end
		else
			if aspectType ~= Enum.AspectType.ScaleWithParentSize then
				return p, p2
			end

			if dominantAxis == Enum.DominantAxis.Width then
				return p, p / aspectRatio
			end

			return p2 * aspectRatio, p2
		end
	end

	maid:Add(RunService.PreRender:Connect(function()
		count += 1
		local v26 = count

		local function fn(p)
			task.spawn(error, debug.traceback(p, 3))
		end

		if isHierarchyVisible() then
			flag = false
			local count3 = #v6

			if count3 <= 0 then
				local y2 = scrollingFrame.CanvasPosition.Y

				if v9 ~= count2 or y ~= y2 or scrollingFrame.CanvasSize ~= udim or next(v4) ~= nil then
					if not canvasPosition then
						canvasPosition = scrollingFrame.CanvasPosition
					end

					scrollingFrame.CanvasSize = udim

					for k in pairs(v4) do
						local v27 = v4[k]

						if not v27 then
							continue
						end

						v4[k] = nil
						local destructor = v27.Destructor

						if destructor then
							xpcall(destructor, fn)
						end

						returnSlot(v27.Slot) -- inferred equivalent call
					end

					v9 = count2
					y = scrollingFrame.CanvasPosition.Y
				end
			else
				v9 = nil
				y = nil
				debug.profilebegin("VirtualScrolling")
				debug.profilebegin("VirtualScrolling::Calculate")
				local cumulativeUIScale = getCumulativeUIScale(scrollingFrame, layerCollector)
				local v27 = scrollingFrame.AbsoluteSize / cumulativeUIScale
				local v28 = scrollingFrame.AbsoluteWindowSize / cumulativeUIScale
				local v29 = cellSize.X.Offset + cellSize.X.Scale * v27.X
				local v30 = cellSize.Y.Offset + cellSize.Y.Scale * v27.Y
				local v31 = cellPadding.X.Offset + cellPadding.X.Scale * v27.X
				local v32 = cellPadding.Y.Offset + cellPadding.Y.Scale * v27.Y
				local v34 = 0
				local v35

				if fitColumnsToMaxCells and fillDirectionMaxCells > 0 and v28.X > 0 and v29 > 0 then
					v35 = (v28.X - (fillDirectionMaxCells - 1) * v31) / fillDirectionMaxCells

					if v35 >= 1 then
						v34 = fillDirectionMaxCells
						v30 = v35 * (v30 / v29)
					else
						v35 = v29
					end
				else
					v35 = v29
				end

				local v36, v37 = applyCellAspectRatio(v35, v30)
				local v38 = v36 + v31
				local v39 = v37 + v32

				if v34 == 0 then
					v34 = math.max(1, (math.floor((v28.X + v31) / v38)))

					if fillDirectionMaxCells > 0 then
						v34 = math.min(v34, fillDirectionMaxCells)
					end
				end

				local v40 = math.ceil(count3 / v34)
				local v41 = not (v40 > 0) and 0 or v40 * v39 - v32
				local udim2 = UDim2.fromOffset(v36, v37)
				local udim3 = UDim2.fromOffset(0, v41)
				local v42 = v38 * math.min(v34, count3) - v31
				local v43 = anchorPoint.X * v36
				local v44 = anchorPoint.Y * v37

				if horizontalAlignment == Enum.HorizontalAlignment.Center then
					v43 += (v28.X - v42) * 0.5
				elseif horizontalAlignment == Enum.HorizontalAlignment.Right then
					v43 += v28.X - v42
				end

				local v45 = count2
				local v46

				if
					v12 == cumulativeUIScale
					and point == v28
					and v13 == v36
					and v14 == v37
					and v15 == v31
					and v16 == v32
					and v17 == v38
					and v18 == v39
					and v19 == v34
					and v20 == v40
					and v21 == v41
					and v22 == v43
				then
					v46 = v23 == v44
				else
					v46 = false
				end

				local point2 = canvasPosition
				local v47

				if point2 or not v46 or v10 ~= v45 or scrollingFrame.CanvasSize ~= udim3 then
					scrollingFrame.CanvasSize = udim3
					v47 = true

					if point2 then
						scrollingFrame.CanvasPosition = point2
						canvasPosition = nil
					end
				else
					v47 = false
				end

				local v48 = scrollingFrame.CanvasPosition.Y / cumulativeUIScale
				local v49 = math.clamp(v48, 0, (math.max(0, v41 - v28.Y)))
				local v50 = math.clamp(math.floor((v49 + v32) / v39), 0, v40 - 1)
				local v51 = math.clamp(math.ceil((v49 + v28.Y) / v39) - 1, v50, v40 - 1)
				local v52 = math.max(0, v50 - v)
				local v53 = math.min(v40 - 1, v51 + v)
				local v54 = math.clamp(v52 * v34 + 1, 1, count3)
				local v55 = math.clamp((v53 + 1) * v34, v54, count3)
				local v56 = math.clamp(v50 * v34 + 1, v54, v55)
				local v57 = math.clamp((v51 + 1) * v34, v56, v55)
				local v58 = false

				for i = v54, v55 do
					local v59 = v4[i]

					if not (not v59 or v59.Identifier ~= v7[i]) then
						continue
					end

					v58 = true
					break
				end

				if v46 then
					if v10 == v45 and v11 == v48 and v24 == v54 and v25 == v55 then
						v46 = not v58
					else
						v46 = false
					end
				end

				if v46 then
					debug.profileend()
					debug.profileend()
				else
					if not v47 then
						scrollingFrame.CanvasSize = udim3
					end

					debug.profileend()
					debug.profilebegin("VirtualScrolling::DestroyOutOfBounds")

					for k, v59 in pairs(v4) do
						if not (k < v54 or v55 < k or v8[v59.Identifier] ~= k) then
							continue
						end

						local v60 = v4[k]

						if not v60 then
							continue
						end

						v4[k] = nil
						local destructor = v60.Destructor

						if destructor then
							xpcall(destructor, fn)
						end

						returnSlot(v60.Slot) -- inferred equivalent call
					end

					debug.profileend()
					debug.profilebegin("VirtualScrolling::RenderVisible")
					local v59 = {}
					local count4 = 0
					local flag2 = false

					for i = v56, v57 do
						table.insert(v59, i)
					end

					if v11 == nil or v11 <= v48 then
						for i = v57 + 1, v55 do
							table.insert(v59, i)
						end

						for i = v56 - 1, v54, -1 do
							table.insert(v59, i)
						end
					else
						for i = v56 - 1, v54, -1 do
							table.insert(v59, i)
						end

						for i = v57 + 1, v55 do
							table.insert(v59, i)
						end
					end

					for _, v61 in v59 do
						local v62 = v6[v61]
						local identifier = v7[v61]
						local v64 = v4[v61]

						if v64 and v64.Identifier == identifier then
							v64.Slot.Size = udim2
							local slot = v64.Slot
							slot.Position = computeSlotPosition(v61, v34, v38, v39, v43, v44) -- inferred equivalent call
						else
							local v65 = v64 and v4[v61]

							if v65 then
								v4[v61] = nil
								local destructor = v65.Destructor

								if destructor then
									xpcall(destructor, fn)
								end

								returnSlot(v65.Slot) -- inferred equivalent call
							end

							if not (v2 <= count4) then
								count4 += 1
								debug.profilebegin("VirtualScrolling::CreateSlot")
								local slot = getSlot() -- inferred equivalent call
								slot.Name = tostring(v61)
								slot.Size = udim2
								slot.Position = computeSlotPosition(v61, v34, v38, v39, v43, v44) -- inferred equivalent call
								local v66 = {
									Slot = slot,
									Identifier = identifier,
									Destructor = nil
								}
								v4[v61] = v66
								debug.profilebegin("VirtualScrolling::Constructor")
								local success, result = pcall(constructor, v62, slot)
								debug.profileend()
								local v67 = v4[v61] == v66
								local v68 = v8[identifier] == v61
								local v69

								if v26 == count and count2 == v45 then
									v69 = isHierarchyVisible()

									if v69 then
										if scrollingFrame.CanvasPosition.Y / getCumulativeUIScale(scrollingFrame, layerCollector) == v48 then
											v69 = v67 and v68
										else
											v69 = false
										end
									end
								else
									v69 = false
								end

								if success then
									if v69 then
										v66.Destructor = result
										slot.Visible = true
										debug.profileend()
									else
										if v67 then
											v4[v61] = nil
										end

										if result then
											xpcall(result, fn)
										end

										if v67 then
											returnSlot(slot) -- inferred equivalent call
										end

										debug.profileend()
										flag2 = true
										break
									end
								else
									if v67 then
										v4[v61] = nil
										returnSlot(slot) -- inferred equivalent call
									end

									task.spawn(error, debug.traceback(tostring(result), 2))
									debug.profileend()

									if not v69 then
										flag2 = true
										break
									end
								end
							end
						end
					end

					debug.profileend()

					if flag2 then
						debug.profileend()
						return
					end

					v10 = v45
					v11 = v48
					v12 = cumulativeUIScale
					point = v28
					v13 = v36
					v14 = v37
					v15 = v31
					v16 = v32
					v17 = v38
					v18 = v39
					v19 = v34
					v20 = v40
					v21 = v41
					v22 = v43
					v23 = v44
					v24 = v54
					v25 = v55
					debug.profileend()
				end
			end
		elseif not flag then
			if not canvasPosition then
				canvasPosition = scrollingFrame.CanvasPosition
			end

			scrollingFrame.CanvasSize = udim

			for k in pairs(v4) do
				local v27 = v4[k]

				if not v27 then
					continue
				end

				v4[k] = nil
				local destructor = v27.Destructor

				if destructor then
					xpcall(destructor, fn)
				end

				returnSlot(v27.Slot) -- inferred equivalent call
			end

			flag = true
			v9 = nil
			y = nil
		end
	end))
	maid:Add(function()
		for k in pairs(v4) do
			local v26 = v4[k]

			if not v26 then
				continue
			end

			v4[k] = nil
			local destructor = v26.Destructor

			if destructor then
				xpcall(destructor, function(p)
					task.spawn(error, debug.traceback(p, 3))
				end)
			end

			returnSlot(v26.Slot) -- inferred equivalent call
		end

		for _, v26 in ipairs(v5) do
			v26:Destroy()
		end

		table.clear(v5)
		v6 = {}
		v7 = {}
		v8 = {}
	end)

	local function setItems(p)
		debug.profilebegin("VirtualScrolling::SetItems")
		local clone = table.clone(p)
		local v26 = {}
		local v27 = {}

		for i, v28 in ipairs(clone) do
			local v29 = itemIdentifier(v28)

			if v26[v29] then
				debug.profileend()
				error(`Duplicate item identifier: {v29}`, 2)
			end

			v27[i] = v29
			v26[v29] = i
		end

		v6 = clone
		v7 = v27
		v8 = v26
		count += 1
		count2 += 1
		debug.profileend()
	end

	local function destroy()
		count += 1

		for k in pairs(v4) do
			local v26 = v4[k]

			if not v26 then
				continue
			end

			v4[k] = nil
			local destructor = v26.Destructor

			if destructor then
				xpcall(destructor, function(p)
					task.spawn(error, debug.traceback(p, 3))
				end)
			end

			returnSlot(v26.Slot) -- inferred equivalent call
		end

		maid:Destroy()
	end

	return table.freeze({ SetItems = setItems, Destroy = destroy })
end

return bind