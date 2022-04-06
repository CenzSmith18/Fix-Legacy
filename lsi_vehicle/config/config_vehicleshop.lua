ConfigVehicleShop                            = {}
ConfigVehicleShop.DrawDistance               = 50.0
ConfigVehicleShop.MarkerColor                = { r = 120, g = 120, b = 240 }
ConfigVehicleShop.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
ConfigVehicleShop.EnableOwnedVehicles        = true
ConfigVehicleShop.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects

ConfigVehicleShop.Finance			  = false -- using Cryptos esx_finance?
ConfigVehicleShop.LicensePlate 		  = true  -- using jsfour-licenseplate?

ConfigVehicleShop.Locale                     = 'en'

ConfigVehicleShop.PlateLetters  = 1
ConfigVehicleShop.PlateNumbers  = 4
ConfigVehicleShop.PlateUseSpace = true

ConfigVehicleShop.Zones = {

	ShopEntering = {
        	--Pos   = { x = -781.21, y = -211.67, z = 36.35 },
		Pos   = { x = -783.1, y = -217.41, z = 36.35 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 27,
	},

	--[[ShopCatalog = {
        	Pos   = { x = -781.21, y = -211.67, z = 36.35 },
		--Pos   = { x = -783.1, y = -217.41, z = 36.35 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 27,
	},]]--

	ShopInside = {
		Pos     = { x = -791.6, y = -217.83, z = 36.77 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 220.06,
		Type    = -1,
	},

	ShopOutside = {
		Pos     = { x = -792.14, y = -217.26, z = 37.41 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 220.06,
		Type    = -1,
	},

	BossActions = {
		Pos   = { x = -811.21, y = -206.64, z = 36.25},
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 27,
	},

	GiveBackVehicle = {
		Pos   = { x = 0.0, y = 0.0, z = 0.0 },
		Size  = { x = 0.0, y = 0.0, z = 0.0 },
		Type  = (ConfigVehicleShop.EnablePlayerManagement and 1 or -1),
	},

	BlankPlate = {
		Pos   = { x = 0.0, y = 0.0, z = 0.0 },
		Size  = { x = 0.0, y = 0.0, z = 0.0 },
		Type  = -1,
	},

	MakePlate = {
		Pos   = { x = 0.0, y = 0.0, z = 0.0 },
		Size  = { x = 0.0, y = 0.0, z = 0.0 },
		Type  = -1,
	}

}

