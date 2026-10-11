local DropCoinsHandler = {}
DropCoinsHandler.__index = DropCoinsHandler
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
local Enums = require(common:WaitForChild("Enums"))
local ResourceManager = require(common:WaitForChild("ResourceManager"))
local NetworkingHandler = require(common:WaitForChild("NetworkingHandler"))
local WrapperFactory = require(common:WaitForChild("WrapperFactory"))
local HashGeneratorClass = require(common:WaitForChild("HashGeneratorClass"))
local parent = script.Parent
local towerClass = parent:WaitForChild("TowerClass")
local enemyClass = parent:WaitForChild("EnemyClass")
local VisualEffectHandler = require(parent:WaitForChild("VisualEffectHandler"))
local raycastIgnore = workspace:WaitForChild("Game"):WaitForChild("RaycastIgnore")
local event = NetworkingHandler.GetEvent("NewCoinDropEvent")
local event2 = NetworkingHandler.GetEvent("ClientsideCoinCollectedEvent")
local event3 = NetworkingHandler.GetEvent("ClientsideCoinCollectedStartedEvent")
local event4 = NetworkingHandler.GetEvent("ClientsideCoinUpdate")
local event5 = NetworkingHandler.GetEvent("CurrencyDropHandlerRestarted")
local LocalPlayer = Players.LocalPlayer
local DEFAULT_SPEED_MULTIPLIER = _G.DEFAULT_SPEED_MULTIPLIER
local v = HashGeneratorClass.New()
local v2 = {}
local v3 = {}

local function GetRandomInitialVelocity() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-15, 15), math.random(25, 70), math.random(-15, 15)))
end

local function GetRandomInitialVelocity2() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-70, 70), math.random(0, 15), math.random(-70, 70)))
end

local function GetRandomInitialAngularImpulse() -- 1 equivalent call inferred from this helper
	return (Vector3.new(math.random(-85, 85) / 100, math.random(-95, 95) / 100, 0))
end

function DropCoinsHandler.DropCoins(data)
	local serverHash = data.ServerHash

	if serverHash and v3[serverHash] then
		v3[serverHash]:Destroy()
	end

	local hash = v:Get()
	local startPosition = data.StartPosition
	local playerList = data.PlayerList or Players:GetPlayers()
	local coinCount = data.CoinCount or 12 * #playerList
	local coinScale = data.CoinScale or 1
	local coinImpulseScale = data.CoinImpulseScale or 1
	local coinModelName = data.CoinModelName
	local startVFX = data.StartVFX
	local walkNearToCollect = data.WalkNearToCollect
	local walkNearToCollectRange = data.WalkNearToCollectRange
	local collectVisualEffectName = data.CollectVisualEffectName
	local _ = #playerList <= 0
	local v4 = {
		Hash = hash,
		StartPosition = startPosition,
		ServerHash = serverHash,
		PlayerList = playerList,
		CoinCoint = coinCount,
		CoinScale = coinScale,
		CoinImpulseScale = coinImpulseScale,
		CoinModelName = coinModelName,
		StartVFX = startVFX,
		CollectVisualEffectName = collectVisualEffectName,
		WalkNearToCollect = walkNearToCollect,
		WalkNearToCollectRange = walkNearToCollectRange,
		DelayRemaining = 0,
		Started = false,
		CoinsMap = {}
	}
	v2[hash] = v4

	if serverHash then
		v3[serverHash] = v4
	end

	setmetatable(v4, DropCoinsHandler)
	return v4
end

function DropCoinsHandler.SetSpeedMultiplier(p: number)
	for _, v4 in pairs(v2) do
		v4:SpeedMultiplierChanged(p)
	end

	DEFAULT_SPEED_MULTIPLIER = p
end

function DropCoinsHandler:_SpawnCoins()
	local playerList = self.PlayerList
	local coinModelName = self.CoinModelName or "GoldCoin"
	local walkNearToCollect = self.WalkNearToCollect
	local walkNearToCollectRange = self.WalkNearToCollectRange

	for i = 1, self.CoinCoint do
		local folder = ResourceManager.GetMiscResource(coinModelName, true)

		if folder then
			local clone

			if folder:IsA("Folder") then
				local children = folder:GetChildren()

				if #children > 0 then
					clone = children[math.random(1, #children)]:Clone()
				else
					warn(`DropCoinsHandler: Coin model ${coinModelName} is an empty folder`)
					continue
				end
			else
				clone = folder:Clone()
			end

			if self.ServerHash then
				clone.Name ..= tostring(self.ServerHash)
			end

			local primaryPart = clone.PrimaryPart
			primaryPart.Transparency = 0
			primaryPart.Anchored = false
			clone:ScaleTo(self.CoinScale)
			clone:PivotTo(CFrame.new(self.StartPosition))
			clone.Parent = raycastIgnore
			primaryPart:ApplyImpulse(self.CoinImpulseScale * GetRandomInitialVelocity() * primaryPart:GetMass()) -- inferred equivalent call
			primaryPart:ApplyAngularImpulse(GetRandomInitialAngularImpulse() * primaryPart:GetMass()) -- inferred equivalent call
			local delayRemaining, goalPlayer

			if walkNearToCollect then
				delayRemaining = 1e999
			else
				delayRemaining = math.random(150, 280) / 100
				goalPlayer = playerList[i % #playerList + 1] or playerList[1]
			end

			local goalOffset = Vector3.new(math.random(-3, 3), math.random(-4, 2), math.random(-3, 3)) / 3
			local randomInitialVelocity = GetRandomInitialVelocity2() -- inferred equivalent call
			local v4 = math.random(50, 190) / 100
			local emitterAndSoundWrapper = WrapperFactory.NewEmitterAndSoundWrapper(clone, DEFAULT_SPEED_MULTIPLIER)
			emitterAndSoundWrapper:PlayAll()
			self.CoinsMap[primaryPart] = {
				WalkNearToCollect = walkNearToCollect,
				WalkNearToCollectRange = walkNearToCollectRange,
				Collected = not walkNearToCollect,
				DelayRemaining = delayRemaining,
				Started = false,
				GoalPlayer = goalPlayer,
				CurrentVelocity = 0,
				GoalOffset = goalOffset,
				RandomInitialVelocity = randomInitialVelocity,
				RandomInitialVelocityTimeLeft = v4,
				RandomInitialVelocityTotalTimeLeft = v4,
				CoinModel = clone,
				EffectsWrapper = emitterAndSoundWrapper
			}
		else
			warn("DropCoinsHandler: Could not find coin model:", coinModelName)
		end
	end
end

function DropCoinsHandler:Logic(p: number)
	if self.DelayRemaining > 0 then
		self.DelayRemaining = math.max(0, self.DelayRemaining - p)
		return
	end

	if not self.Started then
		self:_SpawnCoins()

		if self.StartVFX then
			local v4 = { Name = Enums.VisualEffects.CoinDrop, Position = self.StartPosition }
			VisualEffectHandler.NewVisualEffect(v4)
		end

		self.Started = true
	end

	local spectator = LocalPlayer:GetAttribute("Spectator")

	for folder, v4 in pairs(self.CoinsMap) do
		if
			v4.WalkNearToCollect
			and not v4.Collected
			and not spectator
			and LocalPlayer.Character
			and self.ServerHash
			and LocalPlayer:DistanceFromCharacter(folder.Position) <= (v4.WalkNearToCollectRange or 8)
		then
			v4.Collected = true
			event3:FireServer(self.ServerHash)
		end

		if v4.DelayRemaining > 0 then
			v4.DelayRemaining -= p
		else
			if not v4.Started then
				folder.Anchored = true
				folder.CanCollide = false
				v4.Started = true
			end

			v4.RandomInitialVelocityTimeLeft = math.max(0, v4.RandomInitialVelocityTimeLeft - p)
			local goalPlayer = v4.GoalPlayer
			local character = goalPlayer.Character
			local primaryPart = character and character.PrimaryPart
			local flag = false

			if primaryPart then
				local position = primaryPart.Position + v4.GoalOffset
				local unit = (position - folder.Position).Unit
				local magnitude = (position - folder.Position).Magnitude
				local v5 = v4.CurrentVelocity * p

				if magnitude <= v5 then
					folder.Position = position
					local v6 = {
						Name = self.CollectVisualEffectName or Enums.VisualEffects.CoinCollect,
						Position = position
					}
					VisualEffectHandler.NewVisualEffect(v6)

					if
						self.ServerHash
						and not spectator
						and (goalPlayer == LocalPlayer or not v4.WalkNearToCollect)
					then
						event2:FireServer(self.ServerHash)
					end

					flag = true
				else
					local v6 = v4.RandomInitialVelocity * v4.RandomInitialVelocityTimeLeft / v4.RandomInitialVelocityTotalTimeLeft
					folder.Position += unit * v5 + v6 * p
				end

				v4.CurrentVelocity += p * 300
			else
				flag = true
			end

			if flag then
				self.CoinsMap[folder] = nil
				folder.Transparency = 1

				for _, descendant in pairs(folder:GetDescendants()) do
					if descendant:IsA("Decal") or descendant:IsA("Texture") then
						descendant.Transparency = 1
					end
				end

				for _, emitter in pairs(folder:GetChildren()) do
					if emitter:IsA("ParticleEmitter") then
						emitter.Enabled = false
					end
				end

				v4.EffectsWrapper:StopContinuous()
				local v5 = v4
				task.delay(2, function()
					v5.CoinModel:Destroy()
				end)
			end
		end
	end
end

function DropCoinsHandler:SpeedMultiplierChanged()
	for _, v4 in pairs(self.CoinsMap) do
		v4.EffectsWrapper:SpeedMultiplierChanged(DEFAULT_SPEED_MULTIPLIER)
	end
end

function DropCoinsHandler:Destroy()
	for _, v4 in pairs(self.CoinsMap) do
		v4.CoinModel:Destroy()
	end

	v2[self.Hash] = nil

	if self.ServerHash then
		v3[self.ServerHash] = nil
	end

	v:Return(self.Hash)
end

function DropCoinsHandler.Run(p: number)
	for _, v4 in pairs(v2) do
		v4:Logic(p)
		local count = 0

		for _ in pairs(v4.CoinsMap) do
			count += 1
		end

		if count <= 0 then
			v4:Destroy()
		end
	end
end

function DropCoinsHandler.Initialize()
	event:AttachCallback(function(list)
		local serverHash = list[1]
		local v4 = list[2]
		local v5 = list[3]
		local position = list[4]
		local v6 = list[5]
		local coinCount = list[6]
		local coinScale = list[7]
		local coinImpulseScale = list[8]
		local coinModelName = list[9]
		local walkNearToCollect = list[10]
		local walkNearToCollectRange = list[11]
		local collectVisualEffectName = list[12]

		if not position then
			local v7 = nil

			if v4 then
				local module = require(towerClass)
				v7 = module.GetTower(v4)
			elseif v5 then
				local module = require(enemyClass)
				v7 = module.GetEnemy(v5)
			end

			local character = v7 and v7.Character
			position = character and character:GetRealTorso().Position
		end

		local child = Players:FindFirstChild(v6)

		if position and child then
			DropCoinsHandler.DropCoins({
				StartPosition = position,
				ServerHash = serverHash,
				CoinCount = coinCount,
				CoinScale = coinScale,
				CoinImpulseScale = coinImpulseScale,
				CoinModelName = coinModelName,
				PlayerList = { child },
				WalkNearToCollect = walkNearToCollect,
				WalkNearToCollectRange = walkNearToCollectRange,
				CollectVisualEffectName = collectVisualEffectName
			})
		end
	end)
	event4:AttachCallback(function(childName: string, p: number)
		local v4 = v3[p]

		if not v4 then
			warn("ClientsideCoinUpdateEvent: No CoinsHandler found for ServerHash", p)
			return
		end

		local child = Players:FindFirstChild(childName)

		for _, v5 in pairs(v4.CoinsMap) do
			if child then
				v5.GoalPlayer = child
			else
				v5.GoalPlayer = LocalPlayer
			end

			v5.DelayRemaining = math.random(10, 30) / 100
			v5.Collected = true
		end
	end)
	event5:AttachCallback(function()
		for _, v4 in pairs(v2) do
			v4:Destroy()
		end
	end)
end

return DropCoinsHandler