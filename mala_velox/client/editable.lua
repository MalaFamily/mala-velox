function GetPlayerJob()
    if Config.Framework == "es_extended" then
        return ESX.GetPlayerData()?.job?.name
    elseif Config.Framework == "qb-core" then
        return QBCore.Functions.GetPlayerData()?.PlayerData?.job?.name
    elseif Config.Framework == 'qbx_core' then
        return exports.qbx_core:GetPlayerData()?.PlayerData?.job?.name
    end
end

function GetVehicleModelName(vehicle)
    return string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
    -- return exports["ch-garages"]:GetVehicleModel(GetEntityModel(vehicle))
end

function Notify(text, notifyType, duration)
    if Config.Framework == "es_extended" then
        return ESX.ShowNotification(text, notifyType, duration)
    elseif Config.Framework == "qb-core" then
        return QBCore.Functions.Notify(text, notifyType, duration)
    elseif Config.Framework == 'qbx_core' then
        return exports.qbx_core:Notify(text, notifyType, duration)
    else
        lib.notify({
            description = text,
            type = notifyType,
            duration = duration,
            allign = 'top'
        })
    end
end
RegisterNetEvent('mala_velox:client:notify', Notify)

function CallPolice(cds, msg, data)
    TriggerServerEvent("SendAlert:police", {
        coords = cds,
        title = 'AUTOVELOX',
        type = 'RADARS',
        message = msg,
        job = 'police',
        metadata = {
            model = data.model,
            plate = data.plate,
            speed = data.velocity .. ( Config.useKMH and ' KM/h' or " MPH/h") ,
            name = 'Speed limit',
            color = data.color
        }
    })
end
