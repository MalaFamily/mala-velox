Config = {}

Config.Framework = 'auto' -- es_extended, qbx_core, qb-core
Config.VelocityRadar = {
    { pos = vector4(239.2288, 446.2526, 121.4822, 0.0), radius = 30, max_speed = 75, name = "Civ. 587", settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
    { pos = vector4(-1772.4283, 71.7926, 68.8273, 0.0), radius = 30, max_speed = 75, name = "Civ. 639", settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
    { pos = vector4(2051.0842, 2614.7998, 53.26173, 0.0), radius = 40, max_speed = 135, name = "Autostrada 405", settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
    { pos = vector4(-783.9865, 5489.1807, 34.3538, 0.0), radius = 40, max_speed = 95, name = "Civ. 3003", multiplier = 1.5, settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
    { pos = vector4(-2157.8445, -350.9977, 13.1868, 0.0), radius = 40, max_speed = 75, name = "Autostrada 601", multiplier = 1.5, settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
    { pos = vector4(286.1552, 2637.6858, 44.6694, 0.0), radius = 40, max_speed = 75, name = "Civ. 920", settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
}
Config.useKMH = true
Config.cost = {
    per_velocity = 17,
    min = 1500
}
Config.blacklisted_jobs = {
    ['police'] = true,
    ['fib'] = true
}
