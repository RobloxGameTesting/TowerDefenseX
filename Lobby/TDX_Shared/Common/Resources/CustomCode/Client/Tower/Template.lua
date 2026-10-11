local Template = {}
Template.__index = Template
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("Types"))
require(common:WaitForChild("Enums"))
require(common:WaitForChild("WrapperFactory"))

function Template.New(_: number)
	return (setmetatable({}, Template))
end

function Template.Initialize(_, _, _) end

function Template.Run_FromCharacter(_, _: number) end

function Template.AbilityUsed(_, _) end

function Template.AbilityAnimationKeyframeReached(_, _: string, _: string) end

function Template.SpeedMultiplierChanged_FromCharacter(_, _: number) end

function Template.Upgraded(_, _) end

function Template.CharacterCleanedUp(_) end

function Template.AnimationStateChanged(_, _: string, _) end

function Template.Attacked(_, _, _: boolean?) end

function Template.Death(_) end

return Template