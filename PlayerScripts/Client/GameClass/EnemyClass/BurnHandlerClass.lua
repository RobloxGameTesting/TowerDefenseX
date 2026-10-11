local BurnHandlerClass = {}
BurnHandlerClass.__index = BurnHandlerClass

function BurnHandlerClass.New(character)
	return (setmetatable(
		{ Character = character, VFXNameToBurnTimeLeftMap = {}, VFXNameToBurningMap = {} },
		BurnHandlerClass
	))
end

function BurnHandlerClass.SetBurnTimeLeft(p, p2: string, p3: number)
	p.VFXNameToBurnTimeLeftMap[p2] = p3
end

function BurnHandlerClass.Run(player, p: number)
	for k in pairs(player.VFXNameToBurnTimeLeftMap) do
		player.VFXNameToBurnTimeLeftMap[k] -= p

		if player.VFXNameToBurnTimeLeftMap[k] > 0 then
			if not player.VFXNameToBurningMap[k] then
				player.Character:StartBurn(k)
				player.VFXNameToBurningMap[k] = true
			end
		elseif player.VFXNameToBurningMap[k] then
			player.Character:StopBurn(k)
			player.VFXNameToBurningMap[k] = false
		end
	end
end

function BurnHandlerClass.Stop(player)
	for k in pairs(player.VFXNameToBurningMap) do
		if not player.VFXNameToBurningMap[k] then
			continue
		end

		player.Character:StopBurn(k)
		player.VFXNameToBurningMap[k] = false
	end
end

return BurnHandlerClass