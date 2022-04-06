Config.Marker                     = { type = 21, x = 1.5, y = 1.5, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = false }

Config.ReviveReward               = 0  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

--- AUTOREVIVE
Config.ServiceCount	    = 1 
Config.FeeAfterRevive   = true -- true/false
Config.Account          = bank -- bank/money
Config.Fee              = 10000

Config.EarlyRespawnTimer          = 10 * 60000  -- Time til respawn is available
Config.BleedoutTimer              = 30 * 60000 -- Time til the player bleeds out

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 10000

Config.RespawnPoint = { coords = vector3(365.22, -583.62, 43.28), heading = 76.42}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(295.26779174805, -601.34332275391, 43.303451538086), -- pilbox
			sprite = 61,
			scale  = 0.7,
			color  = 2
		},
		Blip2 = {
			coords = vector3(1830.7633056641, 3676.4401855469, 10.685400009155), -- sandy
			sprite = 61,
			scale  = 0.7,
			color  = 2
		},
		Blip3 = {
			coords = vector3(-248.81, 6326.22, 31.43), --paleto
			sprite = 61,
			scale  = 0.7,
			color  = 2
		},

		AmbulanceActions = {
			vector3(301.48, -599.41, 43.28)
			--vector3(334.84, -594.08, 43.28),
			--vector3(-248.81, 6326.22, 31.43),
			--vector3(1825.88, 3674.99, 33.27),
			--vector3(360.09, -1425.63, 32.51),
			--vector3(-790.61, -1244.54, 6.53),
			--vector3(342.64, -584.39, 28.89)
		},

		Pharmacies = {

		},

		Vehicles = {
			{
				Spawner = vector3(294.54, -596.36, 43.27),
				InsideShop = vector3(285.3, -596.6, 43.1),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(285.3, -596.6, 43.1), heading = 338.77, radius = 10.0 }				}
			},
			
			{
                Spawner = vector3(-847.16, -1230.6, 6.93),
                InsideShop = vector3(-841.99, -1233.81, 7.17),
                Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
                SpawnPoints = {
                    { coords = vector3(-851.43, -1225.64, 7.89), heading = 11.14, radius = 4.0 }
                }
			},

			{
				Spawner = vector3(1823.66, 3688.88, 34.22),
				InsideShop = vector3(1812.17, 3684.87, 33.79),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1812.17, 3684.87, 34.79), heading = 300.12, radius = 10.0 }
				}
			},
			
			{
				Spawner = vector3(299.69366455078, -574.18957519531, 43.260848999023),
				InsideShop = vector3(291.60418701172, -572.28930664063, 43.188148498535),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(290.99, -585.82, 42.98), heading = 340.32, radius = 10.0 }
				}

			},
			
			{
				Spawner = vector3(334.01, -561.88, 28.74),
				InsideShop = vector3(291.60418701172, -572.28930664063, 43.188148498535),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(328.11, -557.44, 29.72), heading = 345.36, radius = 4.0 }
				}
			},

			{
				Spawner = vector3(-268.65466308594, 6327.2333984375, 32.42110824585),
				InsideShop = vector3(-266.91705322266, 6334.0717773438, 32.34122467041),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-279.88, 6321.68, 32.99), heading = 225.26, radius = 4.0 }
				}
			},

			{
				Spawner = vector3(354.69631958008, -603.52429199219, 28.784856796265),
				InsideShop = vector3(358.82437133789, -601.35260009766, 28.643795013428),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(358.82437133789, -601.35260009766, 29.643795013428), heading = 227.6, radius = 4.0 }
				}
			},

			{
				Spawner = vector3(336.6, -576.24, 28.9),
				InsideShop = vector3(325.9, -568.15, 28.81),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(337.22, -570.93, 29.36), heading = 338.66, radius = 4.0 }
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(317.5, -1449.5, 46.5),
				InsideShop = vector3(313.5, -1465.1, 46.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(313.5, -1465.1, 46.5), heading = 142.7, radius = 10.0 },
					{ coords = vector3(299.5, -1453.2, 46.5), heading = 142.7, radius = 10.0 }
				}
			},
			
			{
				Spawner = vector3(1835.9974365234, 3674.2136230469, 38.955680847168),
				InsideShop = vector3(1822.5161132813, 3673.5417480469, 40.279106140137),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1822.5161132813, 3673.5417480469, 40.279106140137), heading = 142.7, radius = 10.0 },
					{ coords = vector3(1822.5161132813, 3673.5417480469, 40.279106140137), heading = 142.7, radius = 10.0 }
				}
			},
			
			{
				Spawner = vector3(337.76, -586.59, 74.16),
				InsideShop = vector3(351.79867553711, -587.77990722656, 74.165733337402),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.79867553711, -587.77990722656, 74.165733337402), heading = 142.7, radius = 10.0 }
				}
			},

			{
				Spawner = vector3(-248.58880615234, 6331.2724609375, 37.617290496826),
				InsideShop = vector3(-253.93045043945, 6318.8637695313, 39.629055023193),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-253.93045043945, 6318.8637695313, 39.629055023193), heading = 142.7, radius = 10.0 }
				}
			},

			{
				Spawner = vector3(-855.64, -1234.15, 14.83),
				InsideShop = vector3(-821.58, 1255.48, 12.46),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-847.7, -1240.94, 15.21), heading = 90.0, radius = 10.0 }
				}
			},
			

			{
				Spawner = vector3(1680.74, 2576.31, 50.62),
				InsideShop = vector3(1690.03, 2582.46, 50.78),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 255, g = 255, b = 255, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1690.03, 2582.46, 50.78), heading = 1.88, radius = 10.0 }
				}
			}
		},

		FastTravels = {

	},

		FastTravelsPrompt = {
			{
				From = vector3(332.3, -595.8, 43.3),
				To = { coords = vector3(339.31, -584.14, 74.17), heading = 248.91 },
				Marker = { type = 20, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = true },
				Prompt = 'Press ~INPUT_CONTEXT~ to fast travel to the roof.'
			},

			{
				From = vector3(339.31, -584.14, 74.17),
				To = { coords = vector3(332.3, -595.8, 43.3), heading = 69.12 },
				Marker = { type = 20, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = true },
				Prompt = 'Press ~INPUT_CONTEXT~ to fast travel to the hospital.'
			}
		}

	}
}

Config.AmbulanceAuthorizedVehicles = {

	training = {
		{ model = 'ambulance', label = 'Mobil Ofrroad EMS', price = 25000 }
	},

	perawat = {
		{ model = 'ambulance', label = 'Mobil Ofrroad EMS', price = 25000 }
	},

	drmj = {
		{ model = 'ambulance', label = 'Mobil Ofrroad EMS', price = 25000 }
	},

	drm = {
		{ model = 'ambulance', label = 'Mobil Ofrroad EMS', price = 25000 }
	},

	dru = {
		{ model = 'ambulance', label = 'Mobil Ofrroad EMS', price = 25000 }
	},

	drs = {
		{ model = 'ambulance', label = 'Mobil Ofrroad EMS', price = 25000 }
	},

	wboss = {
		{ model = 'ambulance', label = 'Mobil Ofrroad EMS', price = 25000 }
	},

	boss = {
		{ model = 'ambulance', label = 'Mobil Ofrroad EMS', price = 25000 }
	}

}

Config.AmbulanceAuthorizedHelicopters = {

    dru = {
		{ model = 'polmav', label = 'Helicopter', price = 25000 }
	},
    drs = {
		{ model = 'polmav', label = 'Helicopter', price = 25000 }
	},
	wboss = {
		{ model = 'polmav', label = 'Helicopter', price = 25000 }
	},

	boss = {
		{ model = 'polmav', label = 'Helicopter', price = 25000 }
	}

}
