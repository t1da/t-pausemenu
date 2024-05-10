fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "t-pausemenu"
description "pausemenu"
author "Toda"
version "1.0.0"

shared_scripts {
	'@ox_lib/init.lua',
	'lua/config.lua'
}

client_script 'lua/client.lua'

server_script 'lua/server.lua'

ui_page 'web/build/index.html'

files {
	'web/build/**'
}