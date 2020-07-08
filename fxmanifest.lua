fx_version 'adamant'

game 'rdr3'

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_script {
	'client/main.lua',
	'config.lua',
}

shared_scripts {
	'locale.lua',
	'locales/es.lua',
	'locales/en.lua',
}

dependency 'vorp_core' 
