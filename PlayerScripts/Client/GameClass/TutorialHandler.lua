local TutorialHandler = {}
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
local Enums = require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("WaveTypes"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local ResourceManager = require(Common:WaitForChild("ResourceManager"))
local BindableHandler = require(Common:WaitForChild("BindableHandler"))
local Director = require(TDX_Shared:WaitForChild("Modules"):WaitForChild("Director"))
local UserInterfaceHandler = script.Parent.Parent:WaitForChild("UserInterfaceHandler")
local TowersBar = UserInterfaceHandler:WaitForChild("TowersBar")
local TowerUIHandler = UserInterfaceHandler:WaitForChild("TowerUIHandler")
local UserInputHandler = script.Parent.Parent:WaitForChild("UserInputHandler")
local Placement = UserInputHandler:WaitForChild("Placement")
local parent = script.Parent
local event = NetworkingHandler.GetEvent("TutorialSequenceUpdate")
local event2 = NetworkingHandler.GetEvent("TutorialActionUpdate")
local event3 = BindableHandler.GetEvent("StopTowerPlacement")
local tutorialData = nil
local v = nil
local v2 = nil
local clones = {}
local clones2 = {}
local count = 0
local count2 = 0
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local v3 = nil
local arrow = nil
local c0 = nil
local v4 = false
local total = 0
local abilityHotbar = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("AbilityHotbar")

local function HandleDisplayElementIds(displayElementIds, visible: boolean)
	if not displayElementIds then
		return
	end

	for _, item in pairs(displayElementIds) do
		local module = require(UserInterfaceHandler)
		local tutorialElementsForElementId = module.GetTutorialElementsForElementId(item)

		if not tutorialElementsForElementId then
			continue
		end

		for _, v5 in pairs(tutorialElementsForElementId) do
			v5.Visible = visible
		end
	end
end

function TutorialHandler.DifficultyChanged(_, p: string)
	local waveConfig = ResourceManager.GetWaveConfig(p)
	assert(waveConfig ~= nil, "Error: waves config is nil")
	tutorialData = waveConfig.TutorialData
	local module = require(parent)
	v = module.GetCurrentGame()
	v2 = p
	clones = {}
	clones2 = {}
	count = 0
	count2 = 0
	local module2 = require(TowersBar)
	module2.SetTutorialMode(tutorialData ~= nil)
	local module3 = require(TowerUIHandler)
	module3.SetTutorialMode(tutorialData ~= nil)
	local module4 = require(Placement)
	module4.SetTutorialMode(tutorialData ~= nil)
	local module5 = require(UserInterfaceHandler)
	module5.HideAllTutorialElements()
	abilityHotbar.Visible = not tutorialData

	if v3 then
		v3.Parent = Lighting
	end

	if not tutorialData then
		return
	end

	for _, actionSequence in ipairs(tutorialData.ActionSequences) do
		count += 1
		local clone = table.clone(actionSequence)
		clone.Hash = count
		table.insert(clones, clone)
	end

	if not v3 then
		v3 = ResourceManager.GetMiscResource("TutorialArrow")
		arrow = v3.PrimaryPart:FindFirstChild("Arrow")
		c0 = arrow.C0
	end
end

function TutorialHandler:IsTutorialRunning()
	return tutorialData ~= nil
end

function TutorialHandler:TriggerSequence(data)
	for _, action in ipairs(data.Actions) do
		count2 += 1
		local clone = table.clone(action)
		clone.Hash = count2
		clone.Started = false
		clone.Completed = false
		table.insert(clones2, clone)
	end

	if data.EnableFreeBuild then
		local module = require(TowersBar)
		module.EnableTutorialFreebuild()
		local module2 = require(TowerUIHandler)
		module2.EnableTutorialFreebuild()
		local module3 = require(Placement)
		module3.EnableTutorialFreebuild()
	end

	if data.DialogueSequence then
		for _, v5 in Director.GetItemsFromClass(Director.Classes.DialogueBox) do
			v5:RunSequence(data.DialogueSequence, v2, data.WaveNumber)
		end
	end
end

function TutorialHandler:_RunAction(p)
	if p.Completed then
		return false
	end

	if not p.Started then
		self:_StartAction(p)
	end

	return true
end

function TutorialHandler:_StartAction(state)
	HandleDisplayElementIds(state.DisplayElementIds, true)
	local module = require(TowersBar)
	module.SetTutorialForceIndex(state.ForcedTowersBarIndex)
	local positionData = state.PositionData
	local module2 = require(Placement)
	module2.SetTutorialForcePosition(positionData and positionData.Position, positionData and positionData.Epsilon)
	local module3 = require(TowerUIHandler)
	module3.SetTutorialForceUpgrade(
		positionData and positionData.Position,
		positionData and positionData.Epsilon,
		state.UpgradeData and state.UpgradeData.Path1Level,
		state.UpgradeData and state.UpgradeData.Path2Level
	)
	event3:Fire()
	state.Started = true
end

function TutorialHandler:CompleteAction(p)
	HandleDisplayElementIds(p.DisplayElementIds, false)
	local module = require(TowersBar)
	module.SetTutorialForceIndex()
	local module2 = require(Placement)
	module2.SetTutorialForcePosition()
	p.Completed = true
end

function TutorialHandler:Run(p: number, _: number)
	if not self:IsTutorialRunning() then
		return
	end

	total += p
	local v5 = nil

	for _, v6 in ipairs(clones2) do
		if not self:_RunAction(v6) then
			continue
		end

		v5 = v6
		break
	end

	self:_RunTurorialArrow(p, v5)
end

function TutorialHandler:_RunTurorialArrow(_: number, p)
	local flag = false
	local position = nil
	local module = require(UserInputHandler)
	local isPlacingTower = module.IsPlacingTower()
	local v5 = p and p.ForcedAction == Enums.TutorialActions.Upgrade

	if isPlacingTower or v5 then
		for _, v6 in ipairs(clones2) do
			if v6.Completed or not v6.Started then
				continue
			end

			local positionData = v6.PositionData

			if not positionData then
				continue
			end

			position = positionData.Position
			flag = true
			break
		end
	end

	if flag ~= v4 then
		if flag then
			v3.Parent = raycastIgnore
		else
			v3.Parent = Lighting
		end
	end

	v4 = flag

	if v4 then
		v3:PivotTo(CFrame.new(position))
		arrow.C0 = (c0 + Vector3.new(0, math.sin(3.141592653589793 * total / 2) * 1.5)) * CFrame.Angles(0, total * 3.141592653589793 / 3, 0)
	end
end

event:AttachCallback(function(p: number)
	for _, v5 in ipairs(clones) do
		if v5.Hash == p then
			TutorialHandler:TriggerSequence(v5)
		end
	end
end)
event2:AttachCallback(function(p: number)
	for _, v5 in ipairs(clones2) do
		if v5.Hash == p then
			TutorialHandler:CompleteAction(v5)
		end
	end
end)
return TutorialHandler