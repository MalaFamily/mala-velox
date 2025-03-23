Config = {
    VelocityRadar = {
        { pos = vector4(239.2288, 446.2526, 121.4822, 0.0), radius = 30, max_speed = 75, name = "Civ. 587", settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
        { pos = vector4(-1772.4283, 71.7926, 68.8273, 0.0), radius = 30, max_speed = 75, name = "Civ. 639", settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
        { pos = vector4(2051.0842, 2614.7998, 53.26173, 0.0), radius = 40, max_speed = 135, name = "Autostrada 405", settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
        { pos = vector4(-783.9865, 5489.1807, 34.3538, 0.0), radius = 40, max_speed = 95, name = "Civ. 3003", multiplier = 1.5, settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
        { pos = vector4(-2157.8445, -350.9977, 13.1868, 0.0), radius = 40, max_speed = 75, name = "Autostrada 601", multiplier = 1.5, settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
        { pos = vector4(286.1552, 2637.6858, 44.6694, 0.0), radius = 40, max_speed = 75, name = "Civ. 920", settings = { useZ = false, debugPoly = false, debugColor = { 255, 0, 0} } },
    },

    useKMH = true,
    cost = {
        per_velocity = 17,
        min = 1500
    },

    blacklisted_jobs = {
        ['police'] = true,
        ['fib'] = true
    },
    
    GetVehicleModelName = function(vehicle)
        -- USE THIS IF U HAVEN'T OTHER VERSION
        -- return string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))

        return exports["ch-garages"]:GetVehicleModel(GetEntityModel(vehicle))
    end,
    
    CallPolice = function(cds, msg, data)
        TriggerServerEvent("SendAlert:police", {
            coords = cds,
            title = 'AUTOVELOX',
            type = 'RADARS',
            message = msg,
            job = 'police',
            metadata = {
                model = data.model,
                plate = data.plate,
                speed = data.velocity .. ' KM/h' ,
                name = 'Limite di velocità',
                color = data.color
            }
        })
    end,

    -- CLIENT SIDE
    Notification = function(...)
        local message, _type, time, title = ...
        if IsDuplicityVersion() then return end -- Don't touch this
        -- MODIFY
        if not ESX then ESX = exports['es_extended']:getSharedObject() end
        if ESX then
            ESX.ShowNotification(message, _type, time, title)
        end
    end,

    -- CLIENT SIDE
    updateDeath = function(val)
        -- MODIFY
        if not ESX then ESX = exports['es_extended']:getSharedObject() end
        if ESX then
            ESX.SetPlayerData("dead", val)
        end
    end,

    isPlayerDeath = function()
        return exports['ch-death']:IsDead()
    end
}