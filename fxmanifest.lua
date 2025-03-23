fx_version 'cerulean'
use_experimental_fxv2_oal 'yes'
lua54        'yes'
game 'gta5'

author "ithurtslikehell_"
version '1.0.0'

description 'Autovelox system based on mala-fakeplate by ch-velox'
discord "https://discord.gg/r8qbjatjqx"
discord_hell "https://discord.gg/2UThJVJ7mK"
tebex " https://malastore.tebex.io/"

dependencies {
    "oxmysql",
    "ox_lib",
    "/onesync",
    "PolyZone"
}

shared_scripts {
    '@ox_lib/init.lua',
    "shared.lua",
    'langs.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    "clients/editable.lua",
	"clients/main.lua",
}

escrow_ignore {
    "langs.lua",
    "configs/**.lua",
    "*/editable.lua",
}