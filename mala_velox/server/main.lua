function GetVehicleOwner(model, plate)
    local done, res = false, false
    MySQL.query('SELECT * FROM `owned_vehicles` WHERE `plate` = ?' --[[.. ' `model` = ?']], {
        plate
        -- ['@model'] = string.lower(model),
    }, function(result)
        if result[1] then
            res = result[1].owner or nil
        end

        done = true
    end)

    while not done do Citizen.Wait(10) end

    return res
end
exports('GetVehicleOwner', GetVehicleOwner)

lib.callback.register("ch-velox:server:isVehicleOwned", function(source, model, plate)   
    local res = GetVehicleOwner(model, plate)

    return (res ~= nil and res ~= false) and true or false
end)

lib.callback.register("ch-velox:server:isVehicleOwned", function(source, velocity, multiplier, max_velocity)   
    multiplier = multiplier or 1
    local velocity_difference = velocity - max_velocity

    local cost = math.floor(velocity_difference * multiplier * Config.cost.per_velocity)

    cost = (cost >= Config.cost.min) and cost or Config.cost.min

    -- Aggiunta della fattura
    if cost then
        -- TODO : Integrate your billing system

        return true
    else
        print('cost doesn\'t exist')
        return false
    end
end)
