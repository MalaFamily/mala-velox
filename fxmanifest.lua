fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54        'yes'
game 'gta5'

description "Autovelox"
author "ithurtslikehell_"
version '1.0.0'

shared_script '@ox_lib/init.lua'

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'langs.lua',
    'server.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    'config.lua',
    'langs.lua',
    'client.lua',
}

escrow_ignore {
    'clients/open.lua',
    'servers/open.lua',
    'config.lua',
    'langs.lua',
}