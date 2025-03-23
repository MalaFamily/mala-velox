lib.callback.register("ch-velox:server:isVehicleOwned", function(source, model, plate)   
    local res = exports['ch-misc']:GetVehicleOwner(model, plate, true)

    return (res ~= nil and res ~= false) and true or false
end)

RegisterServerEvent('ch-velox:server:giveBill', function(velocity, multiplier, max_velocity)
    local src = source
    multiplier = multiplier or 1
    local velocity_difference = velocity - max_velocity

    local cost = math.floor(velocity_difference * multiplier * Config.cost.per_velocity)

    cost = (cost >= Config.cost.min) and cost or Config.cost.min

    -- Aggiunta della fattura
    if cost then
        exports["ch-billings"]:addToBill("velox" .. src, "Eccesso di velocità : " .. velocity_difference .. " km/h evasi!", cost or 100)
        -- TriggerEvent("ch-billings:addToBill", label or "", amount or 100)
        Citizen.Wait(150)
        TriggerEvent("ch-billings:giveBill", 0, false, src, false, 'society_police', "velox" .. src)
        Citizen.Wait(100)
        exports["ch-billings"]:clearBill("velox" .. src)
    else
        print('cost doesn\'t exist')
    end
end)