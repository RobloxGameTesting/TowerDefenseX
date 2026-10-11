local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
local Data = require(TDX_Shared:WaitForChild("Client"):WaitForChild("Services"):WaitForChild("Data"))
require(TDX_Shared:WaitForChild("Modules"):WaitForChild("DataTemplate"))
require(Common:WaitForChild("CustomCodeTypes"))
require(Common:WaitForChild("MapTypes"))
local WrapperFactory = require(Common:WaitForChild("WrapperFactory"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local FinalityCustomCodeClass = {}
FinalityCustomCodeClass.__index = FinalityCustomCodeClass
FinalityCustomCodeClass.MapName = "Finality"

function FinalityCustomCodeClass.New()
	return (setmetatable({ PillarFXWrappers = {} }, FinalityCustomCodeClass))
end

function FinalityCustomCodeClass:_SetupRiddles(instance, childName: string, p: number)
	local child = instance:FindFirstChild(childName)

	for _, model in instance:GetChildren() do
		if model:IsA("Model") and model.Name ~= childName then
			model:Destroy()
		end
	end

	if not child then
		return
	end

	local animationController = child:FindFirstChild("AnimationController")
	local animations = child:FindFirstChild("Animations")

	if not (animationController and animations) then
		return
	end

	local animator = Instance.new("Animator")
	animator.Parent = animationController
	local track = animator:LoadAnimation((animations:FindFirstChild("Shake")))
	track.Looped = true
	track:Play()
	self.AmbientSoundWrapper = WrapperFactory.NewSoundWrapper(instance, p)
	self.AmbientSoundWrapper:PlayContinuous()
end

function FinalityCustomCodeClass:_SetupPillar(instance, p: number)
	self.PillarFXWrappers[instance.Name] = WrapperFactory.NewEmitterAndSoundWrapper(instance.Flame, p)
	instance:GetAttributeChangedSignal("Activated"):Connect(function()
		if instance:GetAttribute("Activated") then
			self.PillarFXWrappers[instance.Name]:PlayAll()
		else
			self.PillarFXWrappers[instance.Name]:StopContinuous()
		end
	end)
end

function FinalityCustomCodeClass:OnLoaded(instance, _, p: number)
	task.spawn(function()
		local puzzle = instance:WaitForChild("Puzzle", 5)

		if puzzle then
			local lobbyPuzzle = Data.Get("LobbyPuzzle")
			local v = lobbyPuzzle and lobbyPuzzle.HasTranslator and "English" or "Calamity"
			self:_SetupRiddles(puzzle:FindFirstChild("Riddle"), v, p)
			local pillars = puzzle:FindFirstChild("Pillars")

			if pillars then
				for _, model in pairs(pillars:GetChildren()) do
					if model:IsA("Model") then
						self:_SetupPillar(model, p)
					end
				end
			end

			self.SolutionCorrectSFXWrapper = WrapperFactory.NewSoundWrapper(puzzle.SFX.Correct, p)
			self.SolutionIncorrectSFXWrapper = WrapperFactory.NewSoundWrapper(puzzle.SFX.Incorrect, p)
		end
	end)
	self.RemoteEvent = NetworkingHandler.GetEvent("FinalityMapEvent")
	self.RemoteEvent:AttachCallback(function(p2: string, ...)
		if p2 == "Result" then
			local v = table.pack(...)[1]

			if v and self.SolutionCorrectSFXWrapper then
				self.SolutionCorrectSFXWrapper:PlayAll()
			elseif not v and self.SolutionIncorrectSFXWrapper then
				self.SolutionIncorrectSFXWrapper:PlayAll()
			end
		end
	end)
end

function FinalityCustomCodeClass.ClientTick(_, _: number) end

function FinalityCustomCodeClass:SpeedMultiplierChanged(p: number)
	if self.AmbientSoundWrapper then
		self.AmbientSoundWrapper:SpeedMultiplierChanged(p)
	end

	for _, pillarFXWrapper in self.PillarFXWrappers do
		pillarFXWrapper:SpeedMultiplierChanged(p)
	end

	if self.SolutionCorrectSFXWrapper then
		self.SolutionCorrectSFXWrapper:SpeedMultiplierChanged(p)
	end

	if self.SolutionIncorrectSFXWrapper then
		self.SolutionIncorrectSFXWrapper:SpeedMultiplierChanged(p)
	end
end

return FinalityCustomCodeClass