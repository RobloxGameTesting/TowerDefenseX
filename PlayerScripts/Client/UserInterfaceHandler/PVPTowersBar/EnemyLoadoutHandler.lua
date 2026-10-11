local EnemyLoadoutHandler = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local BindableHandler = require(common:WaitForChild("BindableHandler"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local SoundHandler = require(common:WaitForChild("SoundHandler"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local PlayerClass = require(script.Parent.Parent.Parent:WaitForChild("PlayerClass"))
local EnemyQueueHandler = require(script.Parent:WaitForChild("EnemyQueueHandler"))
local PVPSendButtonJuiceClass = require(script.Parent:WaitForChild("PVPSendButtonJuiceClass"))
local USE_PVP_TEST_ENEMY_LOADOUT = _G.USE_PVP_TEST_ENEMY_LOADOUT
local v = not USE_PVP_TEST_ENEMY_LOADOUT and {}
	or ResourceManager.GetSortedPVPEnemyLoadout(_G.PVP_TEST_ENEMY_LOADOUT)
	or {}
local v2 = NetworkingHandler.GetFunction("RequestSendPVPEnemy")
local event = BindableHandler.GetEvent("RequestSendPVPEnemy")
local event2 = BindableHandler.GetEvent("WaveChanged")
local event3 = BindableHandler.GetEvent("ErrorPrompt")
local event4 = BindableHandler.GetEvent("PVPEnemyLoadoutChangedWithAdmin")
local event5 = BindableHandler.GetEvent("TogglePVPAutoSend")
local LocalPlayer = Players.LocalPlayer
local localPlayerWrapper = PlayerClass.GetLocalPlayerWrapper()
local v3 = {}
local v4 = nil
local v5 = PVPSendButtonJuiceClass.New()
local v6 = 0
local v7 = 1
local v8 = {}
local enemyName = nil
local total = 0
local v9 = false

local function InvokeRequestSendPVPEnemy(p: string) -- 2 equivalent calls inferred from this helper
	return v2:InvokeServer(p)
end

local function NotifyPageStateChanged() -- 2 equivalent calls inferred from this helper
	if v4 then
		v4()
	end
end

local function GetTotalEnemyCount()
	local v10 = 0

	if USE_PVP_TEST_ENEMY_LOADOUT then
		v10 = #v
	else
		for i = 1, _G.PVP_ENEMY_LOADOUT_MAX_SIZE do
			local attribute = LocalPlayer:GetAttribute("PVPEnemySlot" .. i)

			if attribute and attribute ~= "" then
				v10 = i
			end
		end
	end

	for k in pairs(v8) do
		if v10 < k then
			v10 = k
		end
	end

	return v10
end

local function FailSend(p: string) -- 5 equivalent calls inferred from this helper
	event3:Fire(p)
	SoundHandler.Play("Error")
end

local function RefreshAutoSendVisuals()
	for _, v10 in ipairs(v3) do
		v10:SetAutoSendVisual(v10.EnemyName ~= nil and v10.EnemyName == enemyName)
	end
end

local function TryAutoSend()
	local v10 = enemyName

	if not v10 or (EnemyQueueHandler.CountByName(v10) >= 2 or EnemyQueueHandler.IsFull()) then
		return
	end

	local enemyConfig = ResourceManager.FindEnemyConfig(v10)

	if not enemyConfig then
		return
	end

	local unlockWave = enemyConfig.UnlockWave or 0

	if v6 < unlockWave then
		return
	end

	local stats = localPlayerWrapper.Stats

	if not (stats and stats:HasCash(enemyConfig.SendCost or 0) and InvokeRequestSendPVPEnemy(v10)) then -- inferred equivalent call
		return
	end

	for _, v11 in ipairs(v3) do
		if v11.EnemyName ~= v10 then
			continue
		end

		v5:Punch(v11.MainFrame)
		break
	end

	SoundHandler.Play((enemyConfig.IsBoss or enemyConfig.IsMiniBoss) == true and "PVPSendBoss" or "PVPSendEnemy")
end

function EnemyLoadoutHandler.ConsumeTemplates(instance, p: string)
	local v10 = nil

	for _, frame in ipairs(instance:GetChildren()) do
		if not (frame.Name == p and frame:IsA("Frame")) then
			continue
		end

		v10 = v10 or frame:Clone()
		frame:Destroy()
	end

	return v10
end

function EnemyLoadoutHandler.Bind(p, callback)
	v3 = p
	v4 = callback
end

function EnemyLoadoutHandler.GetTotalPages()
	local count = #v3

	if count == 0 then
		return 1
	end

	return (math.max(1, (math.ceil(GetTotalEnemyCount() / count))))
end

function EnemyLoadoutHandler.GetCurrentPage()
	return v7
end

function EnemyLoadoutHandler.ApplyLoadout()
	v7 = math.clamp(v7, 1, EnemyLoadoutHandler.GetTotalPages())
	local v10 = (v7 - 1) * #v3

	for i, v11 in ipairs(v3) do
		local v12 = v10 + i
		local attribute = LocalPlayer:GetAttribute("PVPEnemySlot" .. v12)

		if USE_PVP_TEST_ENEMY_LOADOUT and (not attribute or attribute == "") then
			attribute = v[v12]
		end

		local v13 = v8[v12] or attribute

		if v13 and v13 ~= "" then
			v11:SetEnemy(v13, v6)
		else
			v11:Disable()
		end
	end

	RefreshAutoSendVisuals()
end

function EnemyLoadoutHandler.Paginate(p: number)
	local v10 = math.clamp(v7 + p, 1, EnemyLoadoutHandler.GetTotalPages())

	if v10 == v7 then
		return
	end

	v7 = v10
	EnemyLoadoutHandler.ApplyLoadout()
	NotifyPageStateChanged() -- inferred equivalent call
	SoundHandler.Play("PVPEnemyPageSwitch")
end

function EnemyLoadoutHandler.RefreshAllLockStates()
	for _, v10 in ipairs(v3) do
		v10:RefreshLockState(v6)
	end
end

function EnemyLoadoutHandler.RefreshCosts()
	for _, v10 in ipairs(v3) do
		v10:RefreshCost()
	end
end

function EnemyLoadoutHandler.HandleSendRequest(p: number, p2: string)
	local v10 = v3[p]

	if not (v10 and v10.Enabled and p2) then
		return
	end

	if enemyName == nil or enemyName ~= v10.EnemyName then
		if v10.Locked then
			FailSend(`Unlocks at wave {v10.UnlockWave}!`) -- inferred equivalent call
			v5:Deny(v10.MainFrame, v10.WaveLabel)
		elseif EnemyQueueHandler.IsFull() then
			FailSend("Send queue is full!") -- inferred equivalent call
			v5:Deny(v10.MainFrame)
		else
			local stats = localPlayerWrapper.Stats

			if not stats then
				return
			end

			local sendCost = v10:GetSendCost()

			if stats:HasCash(sendCost) then
				v10:PlayClickedAnimation()
				local v11, v12 = InvokeRequestSendPVPEnemy(p2) -- inferred equivalent call

				if v11 then
					v5:Punch(v10.MainFrame)
					SoundHandler.Play(v10.IsBoss and "PVPSendBoss" or "PVPSendEnemy")
				else
					FailSend(v12 or "Send failed!") -- inferred equivalent call
					v5:Deny(v10.MainFrame)
				end
			else
				FailSend(`Need ${math.ceil(sendCost - stats:GetCash())} more cash!`) -- inferred equivalent call
				v5:Deny(v10.MainFrame, v10.CostLabel)
			end
		end
	else
		enemyName = nil
		RefreshAutoSendVisuals()
	end
end

function EnemyLoadoutHandler.SendBySlot(p: number)
	local v10 = v3[p]

	if v10 and v10.EnemyName then
		EnemyLoadoutHandler.HandleSendRequest(p, v10.EnemyName)
	end
end

local function ValidateTestEnemyLoadout()
	for _, v10 in ipairs(v) do
		local enemyConfig = ResourceManager.FindEnemyConfig(v10)

		if enemyConfig then
			if enemyConfig.IsPVP == nil or enemyConfig.SendCost == nil or enemyConfig.BuildDuration == nil then
				warn(`PVP test enemy loadout: "{v10}" is not a PVP enemy`)
			end
		else
			warn(`PVP test enemy loadout: no enemy config named "{v10}"`)
		end
	end
end

if USE_PVP_TEST_ENEMY_LOADOUT then
	ValidateTestEnemyLoadout()
end

event:AttachCallback(EnemyLoadoutHandler.HandleSendRequest)
event5:AttachCallback(function(p: number)
	local v10 = v3[p]

	if v10 and v10.EnemyName then
		enemyName = v10.EnemyName
		RefreshAutoSendVisuals()
	end
end)
RunService.Heartbeat:Connect(function(dt: number)
	if not enemyName then
		return
	end

	total += dt

	if total < 0.1 or v9 then
		return
	end

	total = 0
	v9 = true
	task.spawn(function()
		TryAutoSend()
		v9 = false
	end)
end)
event4:AttachCallback(function(p: number, p2: string)
	if ResourceManager.FindEnemyConfig(p2) then
		local v10 = (v7 - 1) * #v3 + p
		v8[v10] = p2
		EnemyLoadoutHandler.ApplyLoadout()
		NotifyPageStateChanged() -- inferred equivalent call
	else
		FailSend(`No enemy named "{p2}"`) -- inferred equivalent call
	end
end)
event2:AttachCallback(function(value: number)
	v6 = value or 0
	EnemyLoadoutHandler.RefreshAllLockStates()
end)
return EnemyLoadoutHandler