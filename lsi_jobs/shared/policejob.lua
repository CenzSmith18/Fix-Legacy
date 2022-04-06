Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }
Config.EnableArmoryManagement     = true
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = true -- enable if you're using esx_license
Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins
Config.EnableJobBlip              = false -- enable blips for colleagues, requires esx_society
Config.EnableESXIdentity = true -- only turn this on if you are using esx_identity and want to use RP names
Config.TackleDistance				= 3.0 -- Tackle

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(-292.26, -1058.24, 27.21),
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29
		},



		Cloakrooms = {
			vector3(-299.91, -1045.67, 27.21)
		},

		Armories = {
			vector3(0.0, 0.0, 0.0),
            vector3(0.0, 0.0, 0.0)
		},

		Vehicles = {
			{
				Spawner = vector3(-277.89, -1027.69 , 30.38),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(-284.63, -1023.76, 29.87), heading = 66.99, radius = 6.0 }
					--{ coords = vector3(442.5, -1025.14, 28.66), heading = 5.12, radius = 6.0 },
					--{ coords = vector3(438.47, -1026.96, 28.31), heading = 6.76, radius = 6.0 },
					--{ coords = vector3(435.06, -1026.46, 28.37), heading = 3.76, radius = 6.0 }
				}
			},

			{
				Spawner = vector3(473.3, -1018.8, 28.0),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{ coords = vector3(475.9, -1021.6, 28.0), heading = 276.1, radius = 6.0 },
					{ coords = vector3(484.1, -1023.1, 27.5), heading = 302.5, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(-306.92 , -1025.58 , 30.39),
				InsideShop = vector3(449.29, -981.63, 44.03),
				SpawnPoints = {
					{ coords = vector3(-321.64, -1017.2, 31.04), heading = 31.04, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(0.0, 0.0, 0.0)
		}

	},

	SSPD = {

		Blip = {
			Coords  = vector3(1845.67, 3692.54, 34.27),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.7,
			Colour  = 29
		},


		Cloakrooms = {
            vector3(1851.05, 3693.79, 34.27)
		},

		Armories = {
            vector3(0, 0, 0)
		},

		Vehicles = {
			{
				Spawner = vector3(1867.96, 3690.76, 33.80),
				InsideShop = vector3(228.5, -993.5, -99.3),
				SpawnPoints = {
					{ coords = vector3(1870.19, 3693.86, 32.6), heading = 208.5, radius = 6.0 },
					{ coords = vector3(1831.79, 3663.44, 33.8), heading = 90.0, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner = vector3(1838.05, 3684.8, 39.82),
				InsideShop = vector3(228.5, -993.5, -99.1),
				SpawnPoints = {
					{ coords = vector3(1831.78, 3690.89, 38.76), heading = 299.5, radius = 1.0 }
				}
			}
		},

		BossActions = {
            vector3(1861.94, 3689.26, 34.27)
		}

	},

    PBPD = {

		Blip = {
			Coords  = vector3(-453.81, 6013.1, 31.72),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.7,
			Colour  = 29
		},

			Cloakrooms = {
            vector3(-453.81, 6013.1, 31.72)
	    },

	    	Armories = {
            vector3(0, 0, 0)
	    },

	    Vehicles = {
            {
			    Spawner = vector3(-444.52, 6023.16, 31.49),
			    InsideShop = vector3(228.5, -993.5, -99.5),
			    SpawnPoints = {
				    { coords = vector3(-441.98, 6026.61, 30.38), heading = 214.61, radius = 1.0 }
			    }
		    },


		Helicopters = {
			{
				Spawner = vector3(-459.35, 5991.25, 31.29),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(-469.49, 5982.22, 31.34), heading = 316.64, radius = 1.0 }
				}
			},

			{
				Spawner = vector3(-473.73, 6004.8, 31.3),
				InsideShop = vector3(228.5, -993.5, -99.0),
				SpawnPoints = {
					{ coords = vector3(-482.49, 5995.57, 31.34), heading = 316.64, radius = 1.0 }}
				}
			}
		},

	    Helicopters = {	
		{
			Spawner = vector3(-459.35, 5991.25, 31.29),
			InsideShop = vector3(228.5, -993.5, -99.5),
			SpawnPoints = {
				{ coords = vector3(-469.49, 5982.22, 31.34), heading = 316.64, radius = 1.0 }
			}
		},

		{
			Spawner = vector3(-473.73, 6004.8, 31.3),
			InsideShop = vector3(228.5, -993.5, -99.0),
			SpawnPoints = {
				{ coords = vector3(-482.49, 5995.57, 31.34), heading = 316.64, radius = 1.0 }
			}
		}
	},

	    BossActions = {
			vector3(-447.02, 6014.16, 36.51)
	
		}

	}
    }

	--[[CPS = {

		Blip = {
			Coords  = vector3(-1635.81, -1022.68, 13.15),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.7,
			Colour  = 29
		},



		Cloakrooms = {
			vector3(-1622.69, -1035.16, 13.15)
		},

		Armories = {
			vector3(-1622.45, -1026.6, 13.15)
		},

		Vehicles = {
			{
				Spawner = vector3(-1615.9, -1014.78, 13.14),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(-1613.72, -1012.13, 13.07), heading = 46.61, radius = 1.0 },
					{ coords = vector3(-1610.95, -1007.75, 13.02), heading = 49.07, radius = 1.0 }
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(-1606.38, -1026.24, 13.09),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(-1595.41, -1028.56, 13.12), heading = 315.96, radius = 1.0 }
				}
			}
		},

		BossActions = {
			vector3(0.0, 0.0, 0.0)
		}

	},--]]

	--[[POLANTAS = {

		Blip = {
			Coords  = vector3(-2047.44, -457.07, 11.58),
			Sprite  = 60,
			Display = 4,
			Scale   = 0.7,
			Colour  = 29
		},



		Cloakrooms = {
			vector3(0.0, 0.0, 0.0)
		},

		Armories = {
			vector3(0.0, 0.0, 0.0)
		},

		Vehicles = {
			{
				Spawner = vector3(-2056.83, -458.6, 11.6),
				InsideShop = vector3(228.5, -993.5, -99.5),
				SpawnPoints = {
					{ coords = vector3(-2059.88, -458.49, 11.71), heading = 320.28, radius = 1.0 },
					{ coords = vector3(-2065.24, -458.42, 11.71), heading = 321.3, radius = 1.0 }
				}
			},
		},

		Helicopters = {
			{
				Spawner = vector3(0.0, 0.0, 0.0),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(0.0, 0.0, 0.0), heading = 0.0, radius = 0.0 }
				}
			}
		},

		BossActions = {
			vector3(0.0, 0.0, 0.0)
		}

	}
}]]--

Config.AuthorizedWeapons = {

	recruit = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{ weapon = 'WEAPON_STUNGUN', price = 5000},
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	bripda = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{ weapon = 'WEAPON_STUNGUN', price = 5000},
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	briptu = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{ weapon = 'WEAPON_STUNGUN', price = 5000},
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	brigpol = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_HEAVYPISTOL', components = { 0, 0, 0, 0, nil }, price = 80000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 63500 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{ weapon = 'WEAPON_STUNGUN', price = 5000},
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	bripka = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_HEAVYPISTOL', components = { 0, 0, 0, 0, nil }, price = 80000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 63500 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{ weapon = 'WEAPON_STUNGUN', price = 5000},
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	aipda = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_HEAVYPISTOL', components = { 0, 0, 0, 0, nil }, price = 80000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 63500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 63500 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{ weapon = 'WEAPON_STUNGUN', price = 5000},
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	officer = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_HEAVYPISTOL', components = { 0, 0, 0, 0, nil }, price = 80000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 63500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 63500 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000},
		{ weapon = 'WEAPON_STUNGUN', price = 5000},
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000},
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000}
	},

	ipda = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_HEAVYPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 50000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000 },
		{ weapon = 'WEAPON_STUNGUN', price = 5000 },
		{ weapon = 'WEAPON_KNIFE', price = 5000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000 }
	},

	iptu = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_HEAVYPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 50000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000 },
		{ weapon = 'WEAPON_STUNGUN', price = 5000 },
		{ weapon = 'WEAPON_KNIFE', price = 5000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000 }
	},

	sergeant = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_HEAVYPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 50000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 600000 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000 },
		{ weapon = 'WEAPON_KNIFE', price = 5000 },
		{ weapon = 'WEAPON_STUNGUN', price = 5000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000 }
	},

	kompol = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_HEAVYPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 50000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 600000 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000 },
		{ weapon = 'WEAPON_KNIFE', price = 5000 },
		{ weapon = 'WEAPON_STUNGUN', price = 5000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000 }
	},

	akbp = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_HEAVYPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 50000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_COMBATPDW', price = 600000 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 5000 },
		{ weapon = 'WEAPON_KNIFE', price = 5000 },
		{ weapon = 'WEAPON_STUNGUN', price = 100000 },
		{ weapon = 'WEAPON_HEAVYSNIPER', price = 1000000 },
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 1000000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 5000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 5000 }
	},

	intendent = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 35000},
		{ weapon = 'WEAPON_HEAVYPISTOL', components = { 0, 0, 0, 0, nil }, price = 80000 },
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 80000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 600000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 63500 },
		{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 0, 0, 0, nil }, price = 63500 },
		{ weapon = 'WEAPON_COMBATPDW', price = 63500 },
		{ weapon = 'WEAPON_KNIFE', price = 3500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 63500 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 3500 },
		{ weapon = 'WEAPON_STUNGUN', price = 3500 },
		{ weapon = 'WEAPON_HEAVYSNIPER', price = 1000000 },
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 1000000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 3500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 3500 }
	},

	brigjenpol = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 1500},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 2500},
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 32000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 40000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 4500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 42000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 3000 },
		{ weapon = 'WEAPON_STUNGUN', price = 10000 },
		{ weapon = 'WEAPON_ASSAULTSMG', price = 4500 },
		{ weapon = 'gadget_parachute', price = 10000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 1500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 80000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 80000 },
		{ weapon = 'WEAPON_HEAVYSNIPER', price = 80000 },
	},

	lieutenant = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 1500},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 2500},
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 32000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 40000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 4500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 42000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 3000 },
		{ weapon = 'WEAPON_STUNGUN', price = 10000 },
		{ weapon = 'WEAPON_ASSAULTSMG', price = 4500 },
		{ weapon = 'gadget_parachute', price = 10000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 1500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 80000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 80000 },
		{ weapon = 'WEAPON_HEAVYSNIPER', price = 80000 },
	},

	chef = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 1500},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 2500},
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 32000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 40000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 4500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 42000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 3000 },
		{ weapon = 'WEAPON_STUNGUN', price = 10000 },
		{ weapon = 'WEAPON_ASSAULTSMG', price = 4500 },
		{ weapon = 'gadget_parachute', price = 10000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 1500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 80000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 80000 },
		{ weapon = 'WEAPON_HEAVYSNIPER', price = 80000 },
	},

	boss = {
		{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 0, 0, nil }, price = 1500},
		{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 0, 0, 0, nil }, price = 2500},
		{ weapon = 'WEAPON_APPISTOL', components = { 0, 0, 0, 0, nil }, price = 32000 },
		{ weapon = 'WEAPON_SMG', components = { 0, 0, 0, 0, nil }, price = 40000 },
		{ weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 0, 0, 0, nil }, price = 4500 },
		{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 0, 0, 0, nil }, price = 42000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 3000 },
		{ weapon = 'WEAPON_STUNGUN', price = 10000 },
		{ weapon = 'WEAPON_ASSAULTSMG', price = 4500 },
		{ weapon = 'gadget_parachute', price = 10000 },
		{ weapon = 'WEAPON_PUMPSHOTGUN', price = 1500 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 500 },
		{ weapon = 'WEAPON_SNIPERRIFLE', price = 80000 },
		{ weapon = 'WEAPON_SPECIALCARBINE', price = 80000 },
		{ weapon = 'WEAPON_HEAVYSNIPER', price = 80000 },
	}
}

Config.AuthorizedVehicles2 = {
	Shared = {

	},

	tamtama = {
		{ model = 'police', label = 'Police', price = 50000 },
        		
		
	},

	bripda = {
		{ model = 'police', label = 'Police', price = 50000 },
        		
		
	},

	briptu = {
		{ model = 'police', label = 'Police', price = 50000 },
        		
		
	},


	brigpol = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},


	bripka = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},


	aipda = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},


	aiptu = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},

	ipda = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},

	iptu = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},

	akp = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},

	komjen = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        
		
	},

	akbp = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},
	
	kobes = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},

	brigjen = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},

	irjen = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},

	komjen = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	},

	boss = {
		{ model = 'police', label = 'Police', price = 50000 },
		
        	
		
	}
}

Config.AuthorizedHelicopters = {
	tamtama = {},

	bripda = {},

	briptu = {
	    { model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	},

	bripka = {
	    { model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	},

	aipda = {
		{ model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	},

	ipda = {
		{ model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	},

	iptu = {
		{ model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	},

	akp = {
		{ model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	},

	akbp = {
		{ model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	},

	kobes = {
		{ model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	},

	brigjen = {
		{ model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	},

	irjen = {
		{ model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	},

	komjen = {
		{ model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	},

	boss = {
		{ model = 'as350', label = 'Police Heli', livery = 0, price = 50000 }
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	tamtama = {
        male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	bripda = {
        male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 1,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 1,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	briptu = {
        male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	brigpol = {
        male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 3,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 3,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	bripka = { -- currently the same as intendent
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 4,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 4,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	aipda = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 5,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 5,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	aiptu = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 6,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 6,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	ipda = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 7,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 7,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	iptu = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 8,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 8,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	akp = {
		male = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 9,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 9,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	akbp = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 10,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 10,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	kobes = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 150,   torso_2 = 11,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 11,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	brigjen = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 149,   torso_2 = 3,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 12,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	irjen = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 149,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 13,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	komjen = {
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 149,   torso_2 = 1,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 14,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	boss = { -- currently the same as chef
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 149,   torso_2 = 2,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 24,   pants_2 = 0,
			shoes_1 = 10,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 17,  tshirt_2 = 0,
			torso_1 = 4,   torso_2 = 15,
			decals_1 = 0,   decals_2 = 0,
			arms = 14,
			pants_1 = 6,   pants_2 = 0,
			shoes_1 = 13,   shoes_2 = 0,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	kaos_wear = { -- currently the same as chef
		male = {
			tshirt_1 = 15,  tshirt_2 = 0,
			torso_1 = 2,   torso_2 = 0,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 10,   pants_2 = 0,
			shoes_1 = 31,   shoes_2 = 1,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		},
		female = {
			tshirt_1 = 58,  tshirt_2 = 0,
			torso_1 = 2,   torso_2 = 8,
			decals_1 = 0,   decals_2 = 0,
			arms = 0,
			pants_1 = 10,   pants_2 = 0,
			shoes_1 = 31,   shoes_2 = 1,
			helmet_1 = -1,  helmet_2 = 0,
			chain_1 = 0,    chain_2 = 0,
			ears_1 = 2,     ears_2 = 0
		}
	},
	bullet_wear = {
		male = {
			bproof_1 = 2,  bproof_2 = 0
		},
		female = {
			bproof_1 = 2,  bproof_2 = 2
		}
	}
}