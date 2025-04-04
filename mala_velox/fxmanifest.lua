fx_version 'cerulean'
game 'gta5'

use_experimental_fxv2_oal 'yes'
lua54 'yes'

author "ithurtslikehell_"
version '1.0.2'

description 'Autovelox system based on mala_fakeplate by ch-velox'
discord "https://discord.gg/r8qbjatjqx"
discord_hell "https://discord.gg/2UThJVJ7mK"
tebex " https://malastore.tebex.io/"

dependencies {
    "ox_lib",
    "oxmysql",
    "/onesync",
    "PolyZone"
}

files {
    "config.lua",
    "locales/*.json"
}

shared_scripts {
    '@ox_lib/init.lua',
    "shared.lua",
    "config.lua"
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/CircleZone.lua',
    "client/editable.lua",
	"client/main.lua",
}

escrow_ignore {
    "config.lua",
    "locales/*.json",
    "*/editable.lua",
}
