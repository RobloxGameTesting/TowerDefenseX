local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TDX_Shared = ReplicatedStorage:WaitForChild("TDX_Shared")
local Common = TDX_Shared:WaitForChild("Common")
require(Common:WaitForChild("Types"))
require(Common:WaitForChild("Enums"))
require(Common:WaitForChild("Utilities"))
local NetworkingHandler = require(Common:WaitForChild("NetworkingHandler"))
local SoundHandler = require(Common:WaitForChild("SoundHandler"))
local Data = require(TDX_Shared.Client.Services.Data)
local event = NetworkingHandler.GetEvent("SkipWaveVoteStateUpdate")
local event2 = NetworkingHandler.GetEvent("SkipWaveVoteCast")
local skipWaveVoteScreen = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Interface"):WaitForChild("TopAreaQueueFrame"):WaitForChild("SkipWaveVoteScreen")
local innerFrame = skipWaveVoteScreen:WaitForChild("InnerFrame")
local votesText = innerFrame:WaitForChild("VotesText")
local declineButton = innerFrame:WaitForChild("DeclineButton")
local acceptButton = innerFrame:WaitForChild("AcceptButton")
local v = nil
local v2 = nil
local flag = false

local function StateUpdate(data)
	votesText.Text = `{data.YesVotes}/{math.ceil(data.VoterCount / 2)}`

	if data.VotingEnabled then
		if not Data.Get("Settings").AutoSkip then
			skipWaveVoteScreen.Visible = true
			return
		end

		v:Clicked(true)
		flag = true
		task.delay(0.25, function()
			if flag then
				skipWaveVoteScreen.Visible = true
			end
		end)
	else
		flag = false
		skipWaveVoteScreen.Visible = false

		if v2 then
			v2:Deselect()
		end
	end
end

local function NewButton(instance, flag2: boolean)
	local v3 = {
		Accept = flag2,
		IsHovered = false,
		IsSelected = false,
		TextLabel = instance:FindFirstChild("Text"),
		DefaultStateImage = instance:FindFirstChild("Default"),
		HighlightStateImage = instance:FindFirstChild("Hovered"),
		Hovered = function(self)
			self.IsHovered = true
			self:_UpdateState()
		end,
		Unhovered = function(self)
			self.IsHovered = false
			self:_UpdateState()
		end,
		Select = function(self)
			if v2 then
				v2:Deselect()
			end

			self.IsSelected = true
			v2 = self
			self:_UpdateState()
		end,
		Deselect = function(self)
			self.IsSelected = false
			v2 = nil
			self:_UpdateState()
		end,
		Clicked = function(self, flag3: boolean?)
			self:Select()

			if not flag3 then
				SoundHandler.Play("ClickTower")
			end

			event2:FireServer(self.Accept)
		end,
		_UpdateState = function(self)
			local highlightStateImage = self.HighlightStateImage

			if self.IsHovered or self.IsSelected then
				highlightStateImage.ImageTransparency = 0
			else
				highlightStateImage.ImageTransparency = 1
			end
		end
	}
	instance.MouseEnter:Connect(function()
		v3:Hovered()
	end)
	instance.MouseLeave:Connect(function()
		v3:Unhovered()
	end)
	instance.Activated:Connect(function()
		v3:Clicked()
	end)
	v3:_UpdateState()
	return v3
end

NewButton(declineButton, false)
v = NewButton(acceptButton, true)
event:AttachCallback(StateUpdate)
return {}