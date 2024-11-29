fx_version 'cerulean'
game 'gta5'

author 'Lorenc'
description 'Daily Rewards System'
version '1.0.0'

shared_scripts {
    'config.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server.lua'
}
