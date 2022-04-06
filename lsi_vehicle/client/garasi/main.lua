local CurrentActionData, PlayerData, userProperties, this_Garage, vehInstance, BlipList, PrivateBlips, JobBlips = {}, {}, {}, {}, {}, {}, {}, {}
local HasAlreadyEnteredMarker, WasInPound, WasinJPound = false, false, false
local LastZone, CurrentAction, CurrentActionMsg, garage
local privateBlips            = {}

local spawnedPeds = {}

Citizen.CreateThread(function()
	exports.lsi_nativeui:AddTargetModel({`csb_trafficwarden`}, {
		options = {
			{
				event = "lsi_vehicle:OpenGarasi",
				icon = "fas fa-box-circle-check",
				label = "Akses Garasi",
				num = 1
			}
		},
		distance = 2
	})
	exports.lsi_nativeui:AddTargetModel({`a_m_y_golfer_01`}, {
		options = {
			{
				event = "lsi_vehicle:OpenAsuransi",
				icon = "fas fa-box-circle-check",
				label = "Akses Asuransi",
				num = 1
			}
		},
		distance = 2
	})

	while true do
		Citizen.Wait(5000)
		for k,v in pairs(Config.CarGarages) do
			if v.npc then
				local playerCoords = GetEntityCoords(PlayerPedId())
				local distance = #(playerCoords - v.Marker)

				if distance < Config.DistanceSpawn and not spawnedPeds[k] then
					local model = 'csb_trafficwarden'
					local spawnedPed = NearPed(model, v.Marker, v.npc.heading, v.npc.animDict, v.npc.animName, v.npc.scenario)
					spawnedPeds[k] = { spawnedPed = spawnedPed, text = v.npc.text or nil }
				end

				if distance >= Config.DistanceSpawn and spawnedPeds[k] then
					if Config.FadeIn then
						for i = 255, 0, -51 do
							Citizen.Wait(50)
							SetEntityAlpha(spawnedPeds[k].spawnedPed, i, false)
						end
					end
					DeletePed(spawnedPeds[k].spawnedPed)
					spawnedPeds[k] = nil
				end
			end
		end
		for k,v in pairs(Config.CarPounds) do
			if v.npc then
				local playerCoords = GetEntityCoords(PlayerPedId())
				local distance = #(playerCoords - v.Marker)

				if distance < Config.DistanceSpawn and not spawnedPeds[k] then
					local model = 'a_m_y_golfer_01'
					local spawnedPed = NearPed(model, v.Marker, v.npc.heading, v.npc.animDict, v.npc.animName, v.npc.scenario)
					spawnedPeds[k] = { spawnedPed = spawnedPed, text = v.npc.text or nil }
				end

				if distance >= Config.DistanceSpawn and spawnedPeds[k] then
					if Config.FadeIn then
						for i = 255, 0, -51 do
							Citizen.Wait(50)
							SetEntityAlpha(spawnedPeds[k].spawnedPed, i, false)
						end
					end
					DeletePed(spawnedPeds[k].spawnedPed)
					spawnedPeds[k] = nil
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local letSleep = 1000

		for k,v in pairs(spawnedPeds) do
			if v.text and v.spawnedPed then
				letSleep = 0
				if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(v.spawnedPed)) < 5.0 then
					DrawText3DProp(GetEntityCoords(v.spawnedPed), v.text)
				end
			end
		end

		Citizen.Wait(letSleep)
	end
end)

function NearPed(model, coords, heading, animDict, animName, scenario)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(50)
	end

	spawnedPed = CreatePed(4, model, coords, heading, false, true)

	SetEntityAlpha(spawnedPed, 0, false)

	if Config.Frozen then
		FreezeEntityPosition(spawnedPed, true)
	end

	if Config.Invincible then
		SetEntityInvincible(spawnedPed, true)
	end

	if Config.Stoic then
		SetBlockingOfNonTemporaryEvents(spawnedPed, true)
	end

	if animDict and animName then
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(50)
		end

		TaskPlayAnim(spawnedPed, animDict, animName, 8.0, 0, -1, 1, 0, 0, 0)
	end

    if scenario then
        TaskStartScenarioInPlace(spawnedPed, scenario, 0, true)
    end

	if Config.FadeIn then
		for i = 0, 255, 51 do
			Citizen.Wait(50)
			SetEntityAlpha(spawnedPed, i, false)
		end
	end

	return spawnedPed
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        for k,v in pairs(spawnedPeds) do
            DeleteEntity(v.spawnedPed)
        end
    end
end)

function DrawText3DProp(coords, text)
	SetDrawOrigin(coords)
	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextEntry('STRING')
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(0.0, 0.0)
	DrawRect(0.0, 0.0125, 0.015 + text:gsub('~.-~', ''):len() / 370, 0.03, 25, 25, 25, 180)
	ClearDrawOrigin()
end

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	CreateBlips()
	RefreshJobBlips()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	DeleteJobBlips()
	RefreshJobBlips()
end)

RegisterNetEvent('esx_advancedgarage:getPropertiesC')
AddEventHandler('esx_advancedgarage:getPropertiesC', function(xPlayer)
	if Config.UsePrivateCarGarages then
		ESX.TriggerServerCallback('esx_advancedgarage:getOwnedProperties', function(properties)
			userProperties = properties
			DeletePrivateBlips()
			RefreshPrivateBlips()
		end)

		ESX.ShowNotification(_U('get_properties'))
		TriggerServerEvent('esx_advancedgarage:printGetProperties')
	end
end)

local function has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end

-- Start of Ambulance Code
function ListOwnedAmbulanceMenu()
	local elements = {}

	if Config.ShowVehicleLocation and Config.ShowSpacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.ShowVehicleLocation == false and Config.ShowSpacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAmbulanceCars', function(ownedAmbulanceCars)
		if #ownedAmbulanceCars == 0 then
			ESX.ShowNotification(_U('garage_no_ambulance'))
		else
			for _,v in pairs(ownedAmbulanceCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.ShowVehicleLocation then
					if v.stored then
						labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('loc_garage'))
					else
						labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span> |'):format(_U('loc_pound'))
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		table.insert(elements, {label = _U('spacer2'), value = nil})

		ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAmbulanceAircrafts', function(ownedAmbulanceAircrafts)
			if #ownedAmbulanceAircrafts == 0 then
				ESX.ShowNotification(_U('garage_no_ambulance_aircraft'))
			else
				for _,v in pairs(ownedAmbulanceAircrafts) do
					local hashVehicule = v.vehicle.model
					local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
					local vehicleName = GetLabelText(aheadVehName)
					local plate = v.plate
					local labelvehicle
					local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
					local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

					if Config.ShowVehicleLocation then
						if v.stored then
							labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('loc_garage'))
						else
							labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span> |'):format(_U('loc_pound'))
						end
					else
						if v.stored then
							labelvehicle = labelvehicle3
						else
							labelvehicle = labelvehicle3
						end
					end

					table.insert(elements, {label = labelvehicle, value = v})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_ambulance', {
				title = _U('garage_ambulance'),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				if data.current.value == nil then
				elseif data.current.value.vtype == 'aircraft' or data.current.value.vtype == 'helicopter' then
					if data.current.value.stored then
						menu.close()
						SpawnVehicle2(data.current.value.vehicle, data.current.value.plate)
					else
						ESX.ShowNotification(_U('ambulance_is_impounded'))
					end
				else
					if data.current.value.stored then
						menu.close()
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
					else
						ESX.ShowNotification(_U('ambulance_is_impounded'))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end)
end

function StoreOwnedAmbulanceMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.UseDamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.AmbulancePoundPrice*Config.DamageMult)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.AmbulancePoundPrice)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				--ESX.ShowNotification(_U('cannot_store_vehicle'))
                    exports['lsi_modernui']:Alert("GARASI", "Ini bukan kendaraanmu", 5000, 'error')
			end
		end, vehicleProps)
	else
		--ESX.ShowNotification(_U('no_vehicle_to_enter'))
        exports['lsi_modernui']:Alert("GARASI", "Tidak ada kendaraan yang bisa disimpan", 5000, 'error')
	end
end

function ReturnOwnedAmbulanceMenu()
	if WasinJPound then
		ESX.ShowNotification(_U('must_wait', Config.JPoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedAmbulanceCars', function(ownedAmbulanceCars)
			local elements = {}

			if Config.ShowVehicleLocation == false and Config.ShowSpacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedAmbulanceCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_ambulance', {
				title = _U('pound_ambulance', ESX.Math.GroupDigits(Config.AmbulancePoundPrice)),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyAmbulance', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('esx_advancedgarage:payAmbulance')
								if Config.UsePoundTimer then
									WasinJPound = true
								end
							end
						else
				--ESX.ShowNotification(_U('not_enough_money'))
                        exports['lsi_modernui']:Alert("GARASI", "Uang Kamu Tidak Cukup", 5000, 'error')
						end
					end)
				else
		--ESX.ShowNotification(_U('cant_take_out'))
            exports['lsi_modernui']:Alert("GARASI", "Kendaraan ini tidak bisa dikeluarkan", 5000, 'error')
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Ambulance Code

-- Start of Police Code
function ListOwnedPoliceMenu()
	local elements = {}

	if Config.ShowVehicleLocation and Config.ShowSpacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.ShowVehicleLocation == false and Config.ShowSpacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedPoliceCars', function(ownedPoliceCars)
		if #ownedPoliceCars == 0 then
			ESX.ShowNotification(_U('garage_no_police'))
		else
			for _,v in pairs(ownedPoliceCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.ShowVehicleLocation then
					if v.stored then
						labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('loc_garage'))
					else
						labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span> |'):format(_U('loc_pound'))
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		table.insert(elements, {label = _U('spacer2'), value = nil})

		ESX.TriggerServerCallback('esx_advancedgarage:getOwnedPoliceAircrafts', function(ownedPoliceAircrafts)
			if #ownedPoliceAircrafts == 0 then
				ESX.ShowNotification(_U('garage_no_police_aircraft'))
			else
				for _,v in pairs(ownedPoliceAircrafts) do
					local hashVehicule = v.vehicle.model
					local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
					local vehicleName = GetLabelText(aheadVehName)
					local plate = v.plate
					local labelvehicle
					local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
					local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

					if Config.ShowVehicleLocation then
						if v.stored then
							labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('loc_garage'))
						else
							labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span> |'):format(_U('loc_pound'))
						end
					else
						if v.stored then
							labelvehicle = labelvehicle3
						else
							labelvehicle = labelvehicle3
						end
					end

					table.insert(elements, {label = labelvehicle, value = v})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_police', {
				title = _U('garage_police'),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				if data.current.value == nil then
				elseif data.current.value.vtype == 'aircraft' or data.current.value.vtype == 'helicopter' then
					if data.current.value.stored then
						menu.close()
						SpawnVehicle2(data.current.value.vehicle, data.current.value.plate)
					else
						ESX.ShowNotification(_U('police_is_impounded'))
					end
				else
					if data.current.value.stored then
						menu.close()
						SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
					else
						ESX.ShowNotification(_U('police_is_impounded'))
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end)
end

function StoreOwnedPoliceMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.UseDamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.PolicePoundPrice*Config.DamageMult)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.PolicePoundPrice)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				--ESX.ShowNotification(_U('cannot_store_vehicle'))
                    exports['lsi_modernui']:Alert("GARASI", "Ini bukan kendaraanmu", 5000, 'error')
			end
		end, vehicleProps)
	else
		--ESX.ShowNotification(_U('no_vehicle_to_enter'))
        exports['lsi_modernui']:Alert("GARASI", "Tidak ada kendaraan yang bisa disimpan", 5000, 'error')
	end
end

function ReturnOwnedPoliceMenu()
	if WasinJPound then
		ESX.ShowNotification(_U('must_wait', Config.JPoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedPoliceCars', function(ownedPoliceCars)
			local elements = {}

			if Config.ShowVehicleLocation == false and Config.ShowSpacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedPoliceCars) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_police', {
				title = _U('pound_police', ESX.Math.GroupDigits(Config.PolicePoundPrice)),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyPolice', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('esx_advancedgarage:payPolice')
								if Config.UsePoundTimer then
									WasinJPound = true
								end
							end
						else
				--ESX.ShowNotification(_U('not_enough_money'))
                        exports['lsi_modernui']:Alert("GARASI", "Uang Kamu Tidak Cukup", 5000, 'error')
						end
					end)
				else
		--ESX.ShowNotification(_U('cant_take_out'))
            exports['lsi_modernui']:Alert("GARASI", "Kendaraan ini tidak bisa dikeluarkan", 5000, 'error')
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Police Code

-- Start of Aircraft Code
function ListOwnedAircraftsMenu()
	local elements = {}

	if Config.ShowVehicleLocation and Config.ShowSpacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.ShowVehicleLocation == false and Config.ShowSpacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedAircrafts', function(ownedAircrafts)
		if #ownedAircrafts == 0 then
			ESX.ShowNotification(_U('garage_no_aircrafts'))
		else
			for _,v in pairs(ownedAircrafts) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.ShowVehicleLocation then
					if v.stored then
						labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('loc_garage'))
					else
						labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span> |'):format(_U('loc_pound'))
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_aircraft', {
			title = _U('garage_aircrafts'),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
				else
					ESX.ShowNotification(_U('aircraft_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedAircraftsMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.UseDamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.AircraftPoundPrice*Config.DamageMult)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.AircraftPoundPrice)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				--ESX.ShowNotification(_U('cannot_store_vehicle'))
                    exports['lsi_modernui']:Alert("GARASI", "Ini bukan kendaraanmu", 5000, 'error')
			end
		end, vehicleProps)
	else
		--ESX.ShowNotification(_U('no_vehicle_to_enter'))
        exports['lsi_modernui']:Alert("GARASI", "Tidak ada kendaraan yang bisa disimpan", 5000, 'error')
	end
end

function ReturnOwnedAircraftsMenu()
	if WasInPound then
		ESX.ShowNotification(_U('must_wait', Config.PoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedAircrafts', function(ownedAircrafts)
			local elements = {}

			if Config.ShowVehicleLocation == false and Config.ShowSpacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedAircrafts) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_aircraft', {
				title = _U('pound_aircrafts', ESX.Math.GroupDigits(Config.AircraftPoundPrice)),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyAircrafts', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('esx_advancedgarage:payAircraft')
								if Config.UsePoundTimer then
									WasInPound = true
								end
							end
						else
				--ESX.ShowNotification(_U('not_enough_money'))
                        exports['lsi_modernui']:Alert("GARASI", "Uang Kamu Tidak Cukup", 5000, 'error')
						end
					end)
				else
		--ESX.ShowNotification(_U('cant_take_out'))
            exports['lsi_modernui']:Alert("GARASI", "Kendaraan ini tidak bisa dikeluarkan", 5000, 'error')
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Aircraft Code

-- Start of Boat Code
function ListOwnedBoatsMenu()
	local elements = {}

	if Config.ShowVehicleLocation and Config.ShowSpacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.ShowVehicleLocation == false and Config.ShowSpacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedBoats', function(ownedBoats)
		if #ownedBoats == 0 then
			ESX.ShowNotification(_U('garage_no_boats'))
		else
			for _,v in pairs(ownedBoats) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.ShowVehicleLocation then
					if v.stored then
						labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('loc_garage'))
					else
						labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span> |'):format(_U('loc_pound'))
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_boat', {
			title = _U('garage_boats'),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
				else
					ESX.ShowNotification(_U('boat_is_impounded'))
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

function StoreOwnedBoatsMenu()
	local playerPed  = PlayerPedId()

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(PlayerPedId(), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				if engineHealth < 990 then
					if Config.UseDamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.BoatPoundPrice*Config.DamageMult)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.BoatPoundPrice)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else
					StoreVehicle(vehicle, vehicleProps)
				end	
			else
				--ESX.ShowNotification(_U('cannot_store_vehicle'))
                    exports['lsi_modernui']:Alert("GARASI", "Ini bukan kendaraanmu", 5000, 'error')
			end
		end, vehicleProps)
	else
		--ESX.ShowNotification(_U('no_vehicle_to_enter'))
        exports['lsi_modernui']:Alert("GARASI", "Tidak ada kendaraan yang bisa disimpan", 5000, 'error')
	end
end

function ReturnOwnedBoatsMenu()
	if WasInPound then
		ESX.ShowNotification(_U('must_wait', Config.PoundWait))
	else
		ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedBoats', function(ownedBoats)
			local elements = {}

			if Config.ShowVehicleLocation == false and Config.ShowSpacers then
				local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
				table.insert(elements, {label = spacer, value = nil})
			end

			for _,v in pairs(ownedBoats) do
				local hashVehicule = v.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)

				labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('return'))

				table.insert(elements, {label = labelvehicle, value = v})
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_owned_boat', {
				title = _U('pound_boats', ESX.Math.GroupDigits(Config.BoatPoundPrice)),
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				local doesVehicleExist = false

				for k,v in pairs (vehInstance) do
					if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.current.value.plate) then
						if DoesEntityExist(v.vehicleentity) then
							doesVehicleExist = true
						else
							table.remove(vehInstance, k)
							doesVehicleExist = false
						end
					end
				end

				if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.current.value.plate) then
					ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyBoats', function(hasEnoughMoney)
						if hasEnoughMoney then
							if data.current.value == nil then
							else
								SpawnVehicle(data.current.value, data.current.value.plate)
								TriggerServerEvent('esx_advancedgarage:payBoat')
								if Config.UsePoundTimer then
									WasInPound = true
								end
							end
						else
				--ESX.ShowNotification(_U('not_enough_money'))
                        exports['lsi_modernui']:Alert("GARASI", "Uang Kamu Tidak Cukup", 5000, 'error')
						end
					end)
				else
		--ESX.ShowNotification(_U('cant_take_out'))
            exports['lsi_modernui']:Alert("GARASI", "Kendaraan ini tidak bisa dikeluarkan", 5000, 'error')
				end
			end, function(data, menu)
				menu.close()
			end)
		end)
	end
end
-- End of Boat Code

-- Start of Car Code
function ListOwnedCarsMenu(currentGarage)
	local elements = {}

	if Config.ShowVehicleLocation and Config.ShowSpacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - <span style="color:red;">%s</span> |'):format(_U('plate'), _U('vehicle'), _U('location'))
		table.insert(elements, {label = spacer, value = nil})
	elseif Config.ShowVehicleLocation == false and Config.ShowSpacers then
		local spacer = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> |'):format(_U('plate'), _U('vehicle'))
		table.insert(elements, {label = ('<span style="color:red;">%s</span>'):format(_U('spacer1')), value = nil})
		table.insert(elements, {label = spacer, value = nil})
	end

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedCars', function(ownedCars)
		if #ownedCars == 0 then
			ESX.ShowNotification(_U('garage_no_cars'))
		else
			for _,v in pairs(ownedCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local labelvehicle
				local labelvehicle2 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> - '):format(plate, vehicleName)
				local labelvehicle3 = ('| <span style="color:red;">%s</span> - <span style="color:darkgoldenrod;">%s</span> | '):format(plate, vehicleName)

				if Config.ShowVehicleLocation then
					if v.stored then
						labelvehicle = labelvehicle2 .. ('<span style="color:green;">%s</span> |'):format(_U('loc_garage'))
					else
						labelvehicle = labelvehicle2 .. ('<span style="color:red;">%s</span> |'):format(_U('loc_pound'))
					end
				else
					if v.stored then
						labelvehicle = labelvehicle3
					else
						labelvehicle = labelvehicle3
					end
				end

				table.insert(elements, {label = labelvehicle, value = v})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_owned_car', {
			title = _U('garage_cars'),
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == nil then
			else
				if data.current.value.stored then
					menu.close()
					SpawnVehicle(data.current.value.vehicle, data.current.value.plate)
				else
					--ESX.ShowNotification(_U('car_is_impounded'))
                            exports['lsi_modernui']:Alert("GARASI", "Kendaraan mu ada di Impound", 5000, 'info')
				end
			end
		end, function(data, menu)
			menu.close()
		end)
	end, currentgarage)
end

AddEventHandler('lsi_vehicle:OpenGarasi', function()
	this_Garage = nil
	for k,v in pairs(Config.CarGarages) do
		local distance = #(GetEntityCoords(PlayerPedId()) - v.Marker)

		if distance < Config.DrawDistance then
			if distance < 5.0 then
				currentgarage, this_Garage, currentZone = k, v, 'car_garage_point'
			end
		end
	end

	if not this_Garage then return end
	local elements = {
		{
			id = 1,
			header = 'Garasi Umum',
			txt = ' '
		},
	}

	ESX.TriggerServerCallback('esx_advancedgarage:getOwnedCars', function(ownedCars)
		local carscount = 1
		if #ownedCars == 0 then
			ESX.ShowNotification(_U('garage_no_cars'))
		else
			for _,v in pairs(ownedCars) do
				local hashVehicule = v.vehicle.model
				local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
				local vehicleName = GetLabelText(aheadVehName)
				local plate = v.plate
				local stored = v.stored and 'Garasi' or 'Asuransi'

				table.insert(elements, {id = carscount, header = vehicleName, txt = vehicleName .. ' [' .. plate .. '] ' .. stored, params = {
					event = 'lsi_vehicle:SpawnVehicle',
					args = {
						data = v
					}
				}})
				carscount = carscount + 1
			end

			for k,v in pairs(elements) do
				if v.header == nil then
					table.remove(elements, k)
				end
			end
	
			exports['lsi_nativeui']:openMenu(elements)
		end
	end, currentgarage)
end)

RegisterNetEvent('lsi_vehicle:SpawnVehicle')
AddEventHandler('lsi_vehicle:SpawnVehicle', function(data)
	data = data.data

	if data.stored then
		SpawnVehicle(data.vehicle, data.plate)
	end
end)

RegisterNetEvent('lsi_vehicle:AsuransiKendaraan')
AddEventHandler('lsi_vehicle:AsuransiKendaraan', function(data)
	data = data.data
	local doesVehicleExist = false

	for k,v in pairs (vehInstance) do
		if ESX.Math.Trim(v.plate) == ESX.Math.Trim(data.plate) then
			if DoesEntityExist(v.vehicleentity) then
				doesVehicleExist = true
			else
				table.remove(vehInstance, k)
				doesVehicleExist = false
			end
		end
	end

	if not doesVehicleExist and not DoesAPlayerDrivesVehicle(data.plate) then
		ESX.TriggerServerCallback('esx_advancedgarage:checkMoneyCars', function(hasEnoughMoney)
			if hasEnoughMoney then
				if data == nil then
				else
					SpawnVehicle(data, data.plate)
					TriggerServerEvent('esx_advancedgarage:payCar')
					if Config.UsePoundTimer then
						WasInPound = true
					end
				end
			else
				--ESX.ShowNotification(_U('not_enough_money'))
                        exports['lsi_modernui']:Alert("GARASI", "Uang Kamu Tidak Cukup", 5000, 'error')
			end
		end)
	else
		--ESX.ShowNotification(_U('cant_take_out'))
            exports['lsi_modernui']:Alert("GARASI", "Kendaraan ini tidak bisa dikeluarkan", 5000, 'error')
	end
end)

AddEventHandler('lsi_vehicle:OpenAsuransi', function()
	this_Garage = nil
	for k,v in pairs(Config.CarPounds) do
		local distance = #(GetEntityCoords(PlayerPedId()) - v.Marker)
	
		if distance < Config.DrawDistance then
			if distance < 5.0 then
				currentgarage, this_Garage, currentZone = k, v, 'car_pound_point'
			end
		end
	end

	if not this_Garage then return end
	ESX.TriggerServerCallback('esx_advancedgarage:getOutOwnedCars', function(ownedCars)
		local elements = {
			{
				id = 1,
				header = 'Asuransi Kendaraan',
				txt = ' '
			},
		}

		local carscount = 1
		for _,v in pairs(ownedCars) do
			local hashVehicule = v.model
			local aheadVehName = GetDisplayNameFromVehicleModel(hashVehicule)
			local vehicleName = GetLabelText(aheadVehName)
			local plate = v.plate

			table.insert(elements, {id = carscount, header = vehicleName, txt = vehicleName .. ' [' .. plate .. ']', params = {
				event = 'lsi_vehicle:AsuransiKendaraan',
				args = {
					data = v
				}
			}})
			carscount = carscount + 1

			for k,v in pairs(elements) do
				if v.header == nil then
					table.remove(elements, k)
				end
			end
		end

		exports['lsi_nativeui']:openMenu(elements)
	end)
end)

function StoreOwnedCarsMenu(currentGarage)
	local playerPed  = GetPlayerPed(-1)

	if IsPedInAnyVehicle(playerPed,  false) then
		local playerPed = GetPlayerPed(-1)
		local coords = GetEntityCoords(playerPed)
		local vehicle = GetVehiclePedIsIn(playerPed, false)
		local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
		local current = GetPlayersLastVehicle(GetPlayerPed(-1), true)
		local engineHealth = GetVehicleEngineHealth(current)
		local plate = vehicleProps.plate

		ESX.TriggerServerCallback('esx_advancedgarage:storeVehicle', function(valid)
			if valid then
				--[[if engineHealth < 990 then
					if Config.UseDamageMult then
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.CarPoundPrice*Config.DamageMult)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					else
						local apprasial = math.floor((1000 - engineHealth)/1000*Config.CarPoundPrice)
						RepairVehicle(apprasial, vehicle, vehicleProps)
					end
				else]]
					StoreVehicle(vehicle, vehicleProps)
				--end	
			else
				ESX.ShowNotification(_U('cannot_store_vehicle'))
			end
		end, vehicleProps, currentGarage)
	else
		ESX.ShowNotification(_U('no_vehicle_to_enter'))
	end
end
-- End of Car Code

-- WasInPound & WasinJPound Code
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if Config.UsePoundTimer then
			if WasInPound then
				Citizen.Wait(Config.PoundWait * 60000)
				WasInPound = false
			end
		end

		if Config.UseJPoundTimer then
			if WasinJPound then
				Citizen.Wait(Config.JPoundWait * 60000)
				WasinJPound = false
			end
		end
	end
end)

-- Repair Vehicles
function RepairVehicle(apprasial, vehicle, vehicleProps)
	ESX.UI.Menu.CloseAll()

	local elements = {
		{label = _U('return_vehicle').." ($"..apprasial..")", value = 'yes'},
		{label = _U('see_mechanic'), value = 'no'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'delete_menu', {
		title = _U('damaged_vehicle'),
		align = Config.MenuAlign,
		elements = elements
	}, function(data, menu)
		menu.close()

		if data.current.value == 'yes' then
			TriggerServerEvent('esx_advancedgarage:payhealth', apprasial)
			vehicleProps.bodyHealth = 1000.0 -- must be a decimal value!!!
			vehicleProps.engineHealth = 1000
			StoreVehicle(vehicle, vehicleProps)
		elseif data.current.value == 'no' then
			ESX.ShowNotification(_U('visit_mechanic'))
		end
	end, function(data, menu)
		menu.close()
	end)
end

-- Store Vehicles

function StoreVehicle(vehicle, vehicleProps)
	for k,v in pairs (vehInstance) do
		if ESX.Math.Trim(v.plate) == ESX.Math.Trim(vehicleProps.plate) then
			table.remove(vehInstance, k)
		end
	end

	ESX.Game.DeleteVehicle(vehicle)
	TriggerServerEvent('esx_advancedgarage:setVehicleState', vehicleProps.plate, true)
	exports['lsi_modernui']:Alert("GARASI", "Kendaraan mu sudah tersimpan", 5000, 'success')
end

-- Spawn Vehicles
function SpawnVehicle(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, this_Garage.Spawner, this_Garage.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		if vehicle["engineHealth"] then
			SetVehicleEngineHealth(callback_vehicle, vehicle["engineHealth"] + 0.0) -- Might not be needed
			--SetVehicleBodyHealth(callback_vehicle, vehicle.bodyHealth) -- Might not be needed
		else
			SetVehicleEngineHealth(callback_vehicle, 1000.0) -- Might not be needed
			--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		end
		local carplate = GetVehicleNumberPlateText(callback_vehicle)
		table.insert(vehInstance, {vehicleentity = callback_vehicle, plate = carplate})
		TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
	end)

	this_Garage = nil
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, 'Impound')
end

function SpawnVehicle2(vehicle, plate)
	ESX.Game.SpawnVehicle(vehicle.model, this_Garage.Spawner2, this_Garage.Heading2, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		SetVehRadioStation(callback_vehicle, "OFF")
		SetVehicleFixed(callback_vehicle)
		SetVehicleDeformationFixed(callback_vehicle)
		SetVehicleUndriveable(callback_vehicle, false)
		SetVehicleEngineOn(callback_vehicle, true, true)
		if vehicle["engineHealth"] then
			SetVehicleEngineHealth(callback_vehicle, vehicle["engineHealth"] + 0.0) -- Might not be needed
			--SetVehicleBodyHealth(callback_vehicle, vehicle.bodyHealth) -- Might not be needed
		else
			SetVehicleEngineHealth(callback_vehicle, 1000.0) -- Might not be needed
			--SetVehicleBodyHealth(callback_vehicle, 1000) -- Might not be needed
		end
		local carplate = GetVehicleNumberPlateText(callback_vehicle)
		table.insert(vehInstance, {vehicleentity = callback_vehicle, plate = carplate})
		TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
	end)

	TriggerServerEvent('esx_advancedgarage:setVehicleState', plate, 'Impound')
end

-- Check Vehicles
function DoesAPlayerDrivesVehicle(plate)
	local isVehicleTaken = false
	local players = ESX.Game.GetPlayers()
	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])
		if target ~= PlayerPedId() then
			local plate1 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, true))
			local plate2 = GetVehicleNumberPlateText(GetVehiclePedIsIn(target, false))
			if plate == plate1 or plate == plate2 then
				isVehicleTaken = true
				break
			end
		end
	end
	return isVehicleTaken
end

-- Entered Marker
AddEventHandler('esx_advancedgarage:hasEnteredMarker', function(zone)
	if zone == 'ambulance_garage_point' then
		CurrentAction = 'ambulance_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'ambulance_store_point' then
		CurrentAction = 'ambulance_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'ambulance_pound_point' then
		CurrentAction = 'ambulance_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'police_garage_point' then
		CurrentAction = 'police_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'police_store_point' then
		CurrentAction = 'police_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'police_pound_point' then
		CurrentAction = 'police_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'aircraft_garage_point' then
		CurrentAction = 'aircraft_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'aircraft_store_point' then
		CurrentAction = 'aircraft_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'aircraft_pound_point' then
		CurrentAction = 'aircraft_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'boat_garage_point' then
		CurrentAction = 'boat_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {}
	elseif zone == 'boat_store_point' then
		CurrentAction = 'boat_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {}
	elseif zone == 'boat_pound_point' then
		CurrentAction = 'boat_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	elseif zone == 'car_garage_point' then
		CurrentAction = 'car_garage_point'
		CurrentActionMsg = _U('press_to_enter')
		CurrentActionData = {garage = garage}
	elseif zone == 'car_store_point' then
		CurrentAction = 'car_store_point'
		CurrentActionMsg = _U('press_to_delete')
		CurrentActionData = {garage = garage}
	elseif zone == 'car_pound_point' then
		CurrentAction = 'car_pound_point'
		CurrentActionMsg = _U('press_to_impound')
		CurrentActionData = {}
	end
end)

-- Exited Marker
AddEventHandler('esx_advancedgarage:hasExitedMarker', function()
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Resource Stop
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		ESX.UI.Menu.CloseAll()
	end
end)

-- Enter / Exit marker events & Draw Markers
Citizen.CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId())
		local isInMarker, letSleep, currentZone = false, 1000

		if Config.UseAmbulanceGarages then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
				for k,v in pairs(Config.AmbulanceGarages) do
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)
					local distance3 = #(playerCoords - v.Deleter2)

					if distance < Config.DrawDistance then
						letSleep = 0

						if Config.PointMarker.Type ~= -1 then
							DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.PointMarker.x then
							currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'ambulance_garage_point'
						end
					end

					if distance2 < Config.DrawDistance then
						letSleep = 0

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance2 < Config.DeleteMarker.x then
							currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'ambulance_store_point'
						end
					end

					if distance3 < Config.DrawDistance then
						letSleep = 0

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(Config.DeleteMarker.Type, v.Deleter2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance3 < Config.DeleteMarker.x then
							currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'ambulance_store_point'
						end
					end
				end
			end
		end

		if Config.UseAmbulancePounds then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
				for k,v in pairs(Config.AmbulancePounds) do
					local distance = #(playerCoords - v.Marker)

					if distance < Config.DrawDistance then
						letSleep = 0

						if Config.JPoundMarker.Type ~= -1 then
							DrawMarker(Config.JPoundMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.JPoundMarker.x, Config.JPoundMarker.y, Config.JPoundMarker.z, Config.JPoundMarker.r, Config.JPoundMarker.g, Config.JPoundMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.JPoundMarker.x then
							currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'ambulance_pound_point'
						end
					end
				end
			end
		end

		if Config.UsePoliceGarages then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				for k,v in pairs(Config.PoliceGarages) do
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)
					local distance3 = #(playerCoords - v.Deleter2)

					if distance < Config.DrawDistance then
						letSleep = 0

						if Config.PointMarker.Type ~= -1 then
							DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.PointMarker.x then
							currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'police_garage_point'
						end
					end

					if distance2 < Config.DrawDistance then
						letSleep = 0

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance2 < Config.DeleteMarker.x then
							currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'police_store_point'
						end
					end

					if distance3 < Config.DrawDistance then
						letSleep = 0

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(Config.DeleteMarker.Type, v.Deleter2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance3 < Config.DeleteMarker.x then
							currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'police_store_point'
						end
					end
				end
			end
		end

		if Config.UsePolicePounds then
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
				for k,v in pairs(Config.PolicePounds) do
					local distance = #(playerCoords - v.Marker)

					if distance < Config.DrawDistance then
						letSleep = 0

						if Config.JPoundMarker.Type ~= -1 then
							DrawMarker(Config.JPoundMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.JPoundMarker.x, Config.JPoundMarker.y, Config.JPoundMarker.z, Config.JPoundMarker.r, Config.JPoundMarker.g, Config.JPoundMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.JPoundMarker.x then
							currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'police_pound_point'
						end
					end
				end
			end
		end

		if Config.UseAircraftGarages then
			for k,v in pairs(Config.AircraftGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.DrawDistance then
					letSleep = 0

					if Config.PointMarker.Type ~= -1 then
						DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PointMarker.x then
						currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'aircraft_garage_point'
					end
				end

				if distance2 < Config.DrawDistance then
					letSleep = 0

					if Config.DeleteMarker.Type ~= -1 then
						DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < Config.DeleteMarker.x then
						currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'aircraft_store_point'
					end
				end
			end

			for k,v in pairs(Config.AircraftPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.DrawDistance then
					letSleep = 0

					if Config.PoundMarker.Type ~= -1 then
						DrawMarker(Config.PoundMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PoundMarker.x then
						currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'aircraft_pound_point'
					end
				end
			end
		end

		if Config.UseBoatGarages then
			for k,v in pairs(Config.BoatGarages) do
				local distance = #(playerCoords - v.Marker)
				local distance2 = #(playerCoords - v.Deleter)

				if distance < Config.DrawDistance then
					letSleep = 0

					if Config.PointMarker.Type ~= -1 then
						DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PointMarker.x then
						currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'boat_garage_point'
					end
				end

				if distance2 < Config.DrawDistance then
					letSleep = 0

					if Config.DeleteMarker.Type ~= -1 then
						DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < Config.DeleteMarker.x then
						currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'boat_store_point'
					end
				end
			end

			for k,v in pairs(Config.BoatPounds) do
				local distance = #(playerCoords - v.Marker)

				if distance < Config.DrawDistance then
					letSleep = 0

					if Config.PoundMarker.Type ~= -1 then
						DrawMarker(Config.PoundMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PoundMarker.x, Config.PoundMarker.y, Config.PoundMarker.z, Config.PoundMarker.r, Config.PoundMarker.g, Config.PoundMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance < Config.PoundMarker.x then
						currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'boat_pound_point'
					end
				end
			end
		end

		if Config.UseCarGarages then
			for k,v in pairs(Config.CarGarages) do
				local distance2 = #(playerCoords - v.Deleter)

				if not v.npc then
					local distance = #(playerCoords - v.Marker)
					if distance < Config.DrawDistance then
						letSleep = 0

						if Config.PointMarker.Type ~= -1 then
							DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.PointMarker.x then
							currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'car_garage_point'
						end
					end
				end

				if distance2 < Config.DrawDistance then
					letSleep = 0

					if Config.DeleteMarker.Type ~= -1 then
						DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
					end

					if distance2 < Config.DeleteMarker.x then
						isInMarker, this_Garage, currentZone, garage = true, v, 'car_store_point', k
					end
				end
			end
		end

		if Config.UsePrivateCarGarages then
			for k,v in pairs(Config.PrivateCarGarages) do
				if not v.Private or has_value(userProperties, v.Private) then
					local distance = #(playerCoords - v.Marker)
					local distance2 = #(playerCoords - v.Deleter)

					if distance < Config.DrawDistance then
						letSleep = 0

						if Config.PointMarker.Type ~= -1 then
							DrawMarker(Config.PointMarker.Type, v.Marker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.PointMarker.x, Config.PointMarker.y, Config.PointMarker.z, Config.PointMarker.r, Config.PointMarker.g, Config.PointMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance < Config.PointMarker.x then
							currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'car_garage_point'
						end
					end

					if distance2 < Config.DrawDistance then
						letSleep = 0

						if Config.DeleteMarker.Type ~= -1 then
							DrawMarker(Config.DeleteMarker.Type, v.Deleter, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.DeleteMarker.x, Config.DeleteMarker.y, Config.DeleteMarker.z, Config.DeleteMarker.r, Config.DeleteMarker.g, Config.DeleteMarker.b, 100, false, true, 2, false, nil, nil, false)
						end

						if distance2 < Config.DeleteMarker.x then
							currentgarage, isInMarker, this_Garage, currentZone = k, true, v, 'car_store_point'
						end
					end
				end
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker, LastZone = true, currentZone
			LastZone = currentZone
			TriggerEvent('esx_advancedgarage:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_advancedgarage:hasExitedMarker', LastZone)
		end

		Citizen.Wait(letSleep)
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerPed = GetPlayerPed(-1)
		local playerVeh = GetVehiclePedIsIn(playerPed, false)
		local model = GetEntityModel(playerVeh)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'ambulance_garage_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
						ListOwnedAmbulanceMenu()
					else
						ESX.ShowNotification(_U('must_ambulance'))
					end
				elseif CurrentAction == 'ambulance_store_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
						if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAHeli(model) then
							if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
								StoreOwnedAmbulanceMenu()
							else
								ESX.ShowNotification(_U('driver_seat'))
							end
						else
							ESX.ShowNotification(_U('not_correct_veh'))
						end
					else
						ESX.ShowNotification(_U('must_ambulance'))
					end
				elseif CurrentAction == 'ambulance_pound_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
						ReturnOwnedAmbulanceMenu()
					else
						ESX.ShowNotification(_U('must_ambulance'))
					end
				elseif CurrentAction == 'police_garage_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
						ListOwnedPoliceMenu()
					else
						ESX.ShowNotification(_U('must_police'))
					end
				elseif CurrentAction == 'police_store_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
						if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAHeli(model) then
							if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
								StoreOwnedPoliceMenu()
							else
								ESX.ShowNotification(_U('driver_seat'))
							end
						else
							ESX.ShowNotification(_U('not_correct_veh'))
						end
					else
						ESX.ShowNotification(_U('must_police'))
					end
				elseif CurrentAction == 'police_pound_point' then
					if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
						ReturnOwnedPoliceMenu()
					else
						ESX.ShowNotification(_U('must_police'))
					end
				elseif CurrentAction == 'aircraft_garage_point' then
					ListOwnedAircraftsMenu()
				elseif CurrentAction == 'aircraft_store_point' then
					if IsThisModelAHeli(model) or IsThisModelAPlane(model) then
						if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
							StoreOwnedAircraftsMenu()
						else
							ESX.ShowNotification(_U('driver_seat'))
						end
					else
						ESX.ShowNotification(_U('not_correct_veh'))
					end
				elseif CurrentAction == 'aircraft_pound_point' then
					ReturnOwnedAircraftsMenu()
				elseif CurrentAction == 'boat_garage_point' then
					ListOwnedBoatsMenu()
				elseif CurrentAction == 'boat_store_point' then
					if IsThisModelABoat(model) then
						if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
							StoreOwnedBoatsMenu()
						else
							ESX.ShowNotification(_U('driver_seat'))
						end
					else
						ESX.ShowNotification(_U('not_correct_veh'))
					end
				elseif CurrentAction == 'boat_pound_point' then
					ReturnOwnedBoatsMenu()
				elseif CurrentAction == 'car_garage_point' then
					ListOwnedCarsMenu(CurrentActionData.garage)
				elseif CurrentAction == 'car_store_point' then
					if IsThisModelACar(model) or IsThisModelABicycle(model) or IsThisModelABike(model) or IsThisModelAQuadbike(model) then
						if (GetPedInVehicleSeat(playerVeh, -1) == playerPed) then
							StoreOwnedCarsMenu(CurrentActionData.garage)
						else
							ESX.ShowNotification(_U('driver_seat'))
						end
					else
						ESX.ShowNotification(_U('not_correct_veh'))
					end
				elseif CurrentAction == 'car_pound_point' then
					ReturnOwnedCarsMenu()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Create Blips
function CreateBlips()
	if Config.UseAircraftGarages and Config.UseAircraftBlips then
		for k,v in pairs(Config.AircraftGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.GarageBlip.Sprite)
			SetBlipColour (blip, Config.GarageBlip.Color)
			SetBlipDisplay(blip, Config.GarageBlip.Display)
			SetBlipScale  (blip, Config.GarageBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.AircraftPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.PoundBlip.Sprite)
			SetBlipColour (blip, Config.PoundBlip.Color)
			SetBlipDisplay(blip, Config.PoundBlip.Display)
			SetBlipScale  (blip, Config.PoundBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_pound'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end

	if Config.UseBoatGarages and Config.UseBoatBlips then
		for k,v in pairs(Config.BoatGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.GarageBlip.Sprite)
			SetBlipColour (blip, Config.GarageBlip.Color)
			SetBlipDisplay(blip, Config.GarageBlip.Display)
			SetBlipScale  (blip, Config.GarageBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.BoatPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.PoundBlip.Sprite)
			SetBlipColour (blip, Config.PoundBlip.Color)
			SetBlipDisplay(blip, Config.PoundBlip.Display)
			SetBlipScale  (blip, Config.PoundBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_pound'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end

	if Config.UseCarGarages and Config.UseCarBlips then
		for k,v in pairs(Config.CarGarages) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.GarageBlip.Sprite)
			SetBlipColour (blip, Config.GarageBlip.Color)
			SetBlipDisplay(blip, Config.GarageBlip.Display)
			SetBlipScale  (blip, Config.GarageBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end

		for k,v in pairs(Config.CarPounds) do
			local blip = AddBlipForCoord(v.Marker)

			SetBlipSprite (blip, Config.PoundBlip.Sprite)
			SetBlipColour (blip, Config.PoundBlip.Color)
			SetBlipDisplay(blip, Config.PoundBlip.Display)
			SetBlipScale  (blip, Config.PoundBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_pound'))
			EndTextCommandSetBlipName(blip)
			table.insert(BlipList, blip)
		end
	end
end

-- Handles Private Blips
function DeletePrivateBlips()
	if PrivateBlips[1] ~= nil then
		for i=1, #PrivateBlips, 1 do
			RemoveBlip(PrivateBlips[i])
			PrivateBlips[i] = nil
		end
	end
end

function RefreshPrivateBlips()
	for zoneKey,zoneValues in pairs(Config.PrivateCarGarages) do
		if zoneValues.Private and has_value(userProperties, zoneValues.Private) then
			local blip = AddBlipForCoord(zoneValues.Marker)

			SetBlipSprite(blip, Config.PGarageBlip.Sprite)
			SetBlipColour(blip, Config.PGarageBlip.Color)
			SetBlipDisplay(blip, Config.PGarageBlip.Display)
			SetBlipScale(blip, Config.PGarageBlip.Scale)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_garage_private'))
			EndTextCommandSetBlipName(blip)
			table.insert(PrivateBlips, blip)
		end
	end
end

-- Handles Job Blips
function DeleteJobBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function RefreshJobBlips()
	if Config.UseAmbulanceGarages and Config.UseAmbulanceBlips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			for k,v in pairs(Config.AmbulanceGarages) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.JGarageBlip.Sprite)
				SetBlipColour (blip, Config.JGarageBlip.Color)
				SetBlipDisplay(blip, Config.JGarageBlip.Display)
				SetBlipScale  (blip, Config.JGarageBlip.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_ambulance_garage'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.UseAmbulancePounds and Config.UseAmbulanceBlips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
			for k,v in pairs(Config.AmbulancePounds) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.JPoundBlip.Sprite)
				SetBlipColour (blip, Config.JPoundBlip.Color)
				SetBlipDisplay(blip, Config.JPoundBlip.Display)
				SetBlipScale  (blip, Config.JPoundBlip.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_ambulance_pound'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.UsePoliceGarages and Config.UsePoliceBlips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			for k,v in pairs(Config.PoliceGarages) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.JGarageBlip.Sprite)
				SetBlipColour (blip, Config.JGarageBlip.Color)
				SetBlipDisplay(blip, Config.JGarageBlip.Display)
				SetBlipScale  (blip, Config.JGarageBlip.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_police_garage'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end

	if Config.UsePolicePounds and Config.UsePoliceBlips then
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'police' then
			for k,v in pairs(Config.PolicePounds) do
				local blip = AddBlipForCoord(v.Marker)

				SetBlipSprite (blip, Config.JPoundBlip.Sprite)
				SetBlipColour (blip, Config.JPoundBlip.Color)
				SetBlipDisplay(blip, Config.JPoundBlip.Display)
				SetBlipScale  (blip, Config.JPoundBlip.Scale)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('blip_police_pound'))
				EndTextCommandSetBlipName(blip)
				table.insert(JobBlips, blip)
			end
		end
	end
end
