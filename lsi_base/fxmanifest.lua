game {'gta5'}

fx_version 'cerulean'
author 'AvarianKnight'
description 'VOIP built using FiveM\'s built in mumble.'

lua54 'yes'

shared_script 'shared.lua'

ui_page('html/ui.html')

files {
    'html/**/*.*',
}

client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'client/**/*.lua',
}

server_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
	'mysql-async.js',
	'async.lua',
    'server/**/*.lua'
}

provides {
	'mumble-voip',
    'tokovoip',
    'toko-voip',
    'tokovoip_script'
}

exports {
	'SendAlert',
	'SendUniqueAlert',
	'DoHudText',
	'PersistentAlert',
	'PersistentHudText',
	'DoCustomHudText',
    'Progress',
    'ProgressWithStartEvent',
    'ProgressWithTickEvent',
    'ProgressWithStartAndTick'
}

server_exports {
	'SendAlert',
	'RemoveAlert'
}

convar_category 'PMA-Voice' {
    "PMA-Voice Configuration Options",
    {
		{ "Use native audio", "$voice_useNativeAudio", "CV_BOOL", "false" },
		{ "Use 2D audio", "$voice_use2dAudio", "CV_BOOL", "false" },
		{ "Use sending range only", "$voice_useSendingRangeOnly", "CV_BOOL", "false" },
		{ "Enable F11 proximity key", "$voice_enableProximityCycle", "CV_INT", "1" },
		{ "Proximity cycle key", "$voice_defaultCycle", "CV_STRING", "F11" },
		{ "Voice volume", "$voice_defaultVolume", "CV_STRING", "0.3" },
		{ "Enable radios", "$voice_enableRadios", "CV_INT", "1" },
		{ "Enable phones", "$voice_enablePhones", "CV_INT", "1" },
		{ "Enable sublix", "$voice_enableSubmix", "CV_INT", "0" },
		{ "Enable radio animation", "$voice_enableRadioAnim", "CV_INT", "0" },
		{ "Radio key", "$voice_defaultRadio", "CV_STRING", "LALT" },
		{ "Zone radius", "$voice_zoneRadius", "CV_INT", "256" },
		{ "Zone refresh rate", "$voice_zoneRefreshRate", "CV_INT", "200" },
		{ "Enable voice sync (state bags)", "$voice_syncData", "CV_INT", "0" },
		{ "Allow players to set audio intent", "$voice_allowSetIntent", "CV_INT", "1" },
		{ "External mumble server address", "$voice_externalAddress", "CV_STRING", "" },
		{ "External mumble server port", "$voice_externalPort", "CV_INT", "0" },
		{ "Voice debug mode", "$voice_debugMode", "CV_INT", "0" },
		{ "Disable players being allowed to join", "$voice_externalDisallowJoin", "CV_INT", "0" },
		{ "Hide server endpoints in logs", "$voice_hideEndpoints", "CV_INT", "1" },
    }
}