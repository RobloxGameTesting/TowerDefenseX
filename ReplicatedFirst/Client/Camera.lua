local Camera = { Target = CFrame.identity, Enabled = false, SpeedOverride = nil }
local RunService = game:GetService("RunService")
local Network = require(game.ReplicatedFirst.Client.Network)
local CurrentCamera = workspace.CurrentCamera
local identity = CFrame.identity
local identity2 = CFrame.identity
local identity3 = CFrame.identity
RunService:BindToRenderStep("GetCameraBase", Enum.RenderPriority.Camera.Value + 1, function()
	identity = CurrentCamera.CFrame
end)
RunService:BindToRenderStep("CameraOffset", Enum.RenderPriority.Last.Value, function(p)
	local speedOverride = Camera.SpeedOverride or 10
	local worldCFrame = Camera.Enabled and Camera.Target.WorldCFrame or identity
	local inverse = worldCFrame:ToObjectSpace(identity):Inverse()
	identity3 = identity3:Lerp(inverse, 1 - math.exp(-speedOverride * p))

	if Camera.Enabled then
		identity2 = identity2:Lerp(worldCFrame, 1 - math.exp(-speedOverride * p))
	else
		identity2 = identity * identity3
	end

	CurrentCamera.CFrame = identity2

	if Camera.Enabled then
		CurrentCamera.Focus = identity2
	end
end)
Network.HookEvent("CameraState", function(p, p2)
	if p == 0 then
		Camera.Enabled = false
	elseif p == 1 then
		Camera.Target = p2.Root.Attachment
		Camera.Enabled = true
	elseif p == 2 then
		Camera.Target = p2.Hull.Attachment
		Camera.Enabled = true
		task.wait(6)
		pcall(_G.StartTeleportUI)
	end
end)
return Camera