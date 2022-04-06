local playersHealing, deadPlayers = {}, {}

RegisterNetEvent("miyu:hapus-tato")
AddEventHandler("miyu:hapus-tato", function(player)
	local local_player = ESX.GetPlayerFromId(source)
	if local_player.job.name == 'ambulance' then
		local target_player = ESX.GetPlayerFromId(player)
		if target_player then
			MySQL.Async.execute("update users set tattoos = @ngentot where identifier = @memex",
			{
				["@ngentot"] = nil,
				["@memex"] = target_player.identifier
			})

			TriggerClientEvent("esx:showNotification", source, "Kamu telah menghapus tato seseorang.")
			TriggerClientEvent("esx:showNotification", player, "Tatomu telah terhapus, tetapi masih berbekas, akan hilang pada esok hari.")
		end
	end
end)

RegisterServerEvent('great_ems:revive')
AddEventHandler('great_ems:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('great_ems:revive', target)
	else
		print(('great_ems: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = 'dead'
	TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
end)

RegisterNetEvent('esx_ambulancejob:onPlayerDistress')
AddEventHandler('esx_ambulancejob:onPlayerDistress', function()
	if deadPlayers[source] then
		deadPlayers[source] = 'distress'
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
		TriggerClientEvent('esx_ambulancejob:setDeadPlayers', -1, deadPlayers)
	end
end)

RegisterServerEvent('great_ems:heal')
AddEventHandler('great_ems:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('great_ems:heal', target, type)
	else
		print(('great_ems: %s attempted to heal!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('great_ems:putInVehicle')
AddEventHandler('great_ems:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('great_ems:putInVehicle', target)
	else
		print(('great_ems: %s attempted to put in vehicle!'):format(xPlayer.identifier))
	end
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})



ESX.RegisterServerCallback('great_ems:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())
		end

		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)
		end
	end

	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)



-- ESX.RegisterServerCallback('great_ems:removeItemsAfterRPDeath', function(source, cb)
-- 	local xPlayer = ESX.GetPlayerFromId(source)

-- 	if Config.RemoveCashAfterRPDeath then
-- 		if xPlayer.getMoney() > 0 then
-- 			xPlayer.removeMoney(xPlayer.getMoney())
-- 		end

-- 		if xPlayer.getAccount('black_money').money > 0 then
-- 			xPlayer.setAccountMoney('black_money', 0)
-- 		end
-- 	end

-- 	if Config.RemoveItemsAfterRPDeath then
-- 		for i=1, #xPlayer.inventory, 1 do
-- 			if xPlayer.inventory[i].count > 0 then
-- 				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
-- 			end
-- 		end
-- 	end

-- 	local playerLoadout = {}
-- 	if Config.RemoveWeaponsAfterRPDeath then
-- 		for i=1, #xPlayer.loadout, 1 do
-- 			xPlayer.removeWeapon(xPlayer.loadout[i].name)
-- 		end
-- 	else -- save weapons & restore em' since spawnmanager removes them
-- 		for i=1, #xPlayer.loadout, 1 do
-- 			table.insert(playerLoadout, xPlayer.loadout[i])
-- 		end

-- 		-- give back wepaons after a couple of seconds
-- 		Citizen.CreateThread(function()
-- 			Citizen.Wait(5000)
-- 			for i=1, #playerLoadout, 1 do
-- 				if playerLoadout[i].label ~= nil then
-- 					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
-- 				end
-- 			end
-- 		end)
-- 	end

-- 	cb()
-- end)

if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('great_ems:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterServerEvent('great_ems:payFine')
	AddEventHandler('great_ems:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('great_ems:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('great_ems:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = AmbulancegetPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('great_ems: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)
	
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = 'Impound'
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('great_ems:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('great_ems: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function AmbulancegetPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AmbulanceAuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AmbulanceAuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

RegisterServerEvent('great_ems:removeItem')
AddEventHandler('great_ems:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	end
end)

RegisterServerEvent('great_ems:giveItem')
AddEventHandler('great_ems:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name ~= 'ambulance' then
		print(('great_ems: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage') then
		print(('great_ems: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if xItem.limit ~= -1 then
		count = xItem.limit - xItem.count
	end

	if xItem.count < xItem.limit then
		xPlayer.addInventoryItem(itemName, count)
	else
		TriggerClientEvent('esx:showNotification', source, _U('max_item'))
	end
end)

--[[TriggerEvent('es:addGroupCommand', 'revive', 'admin', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print(('great_ems: %s used admin revive'):format(GetPlayerIdentifiers(source)[1]))
			TriggerClientEvent('great_ems:revive', tonumber(args[1]))
		end
	else
		TriggerClientEvent('great_ems:revive', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = _U('revive_help'), params = {{ name = 'id' }} })--]]

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('great_ems:revive')
end, true, {help = _U('revive_help'), validate = true, arguments = {
	{name = 'playerId', help = 'the player id', type = 'player'}
}})

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('great_ems:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('great_ems:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('great_ems:getDeathStatus', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchScalar('SELECT is_dead FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(isDead)
		if isDead then
			print(('great_ems: %s attempted combat logging!'):format(xPlayer.identifier))
		end

		cb(isDead)
	end)
end)

RegisterServerEvent('great_ems:setDeathStatus')
AddEventHandler('great_ems:setDeathStatus', function(isDead)
	local xPlayer = ESX.GetPlayerFromId(source)

	if type(isDead) ~= 'boolean' then
		print(('great_ems: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
		['@isDead'] = isDead
	})
end)

RegisterServerEvent('great_jobChat:119')
AddEventHandler('great_jobChat:119', function(targetCoords, msg, streetName, emergency)
    local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	fal = xPlayer.getName(source)
	local messageFull
	if emergency == '119' then
		messageFull = {
			template = '<div style="padding: 6px; margin: 8px; background-color: rgba(255, 51, 51); border-radius: 5px;"><i class="fas fa-bell"style="font-size:15px"></i> [RS]: {0} | LOKASI : {1} | KORBAN : {2}</font></i></b></div>',
        	args = {fal, streetName, msg, ped}
		}
	end
	TriggerClientEvent('great_jobChat:119Marker', -1, targetCoords, emergency)
	TriggerClientEvent('great_jobChat:119EmergencySend', -1, messageFull)
end)