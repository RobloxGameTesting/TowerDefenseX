local CutsceneUtilities = {}
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local common = ReplicatedStorage:WaitForChild("TDX_Shared"):WaitForChild("Common")
require(common:WaitForChild("WaveTypes"))

function CutsceneUtilities.GetBlackTransition(p, p2: number)
	local segments = p.Segments

	if not segments or p2 < 1 or #segments <= p2 then
		return nil
	end

	local blackTransition = segments[p2].BlackTransition

	if blackTransition then
		return {
			FadeInTime = blackTransition.FadeInTime or 0,
			Duration = blackTransition.Duration or 0,
			FadeOutTime = blackTransition.FadeOutTime or 0
		}
	end

	return nil
end

function CutsceneUtilities.GetSegmentDurations(data)
	local result = {}

	for i, v in ipairs(data.Segments or {}) do
		local v2 = v.End - v.Start

		if i == 1 and data.PlayAnimationOnInitialBlackFadeOut then
			v2 -= data.InitialBlackFadeOutTime or 0
		end

		local blackTransition = CutsceneUtilities.GetBlackTransition(data, i - 1)

		if blackTransition then
			v2 -= blackTransition.FadeOutTime
		end

		local blackTransition2 = CutsceneUtilities.GetBlackTransition(data, i)

		if blackTransition2 then
			v2 -= blackTransition2.FadeInTime
		end

		table.insert(result, (math.max(v2, 0)))
	end

	return result
end

function CutsceneUtilities.GetDuration(data)
	if data.Segments then
		local total = 0

		for i, v in ipairs(CutsceneUtilities.GetSegmentDurations(data)) do
			total += v
			local blackTransition = CutsceneUtilities.GetBlackTransition(data, i)

			if blackTransition then
				total += blackTransition.FadeInTime + blackTransition.Duration + blackTransition.FadeOutTime
			end
		end

		return total
	else
		if not data.Duration then
			warn("CutsceneUtilities.GetDuration: No Duration or Segments for", data.Name)
		end

		return data.Duration or 0
	end
end

return CutsceneUtilities