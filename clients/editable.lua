if Config.Core == 'qb' then
    RegisterNetEvent("QBCore:Client:OnJobUptade", function(job) CreateBlips() end)
elseif Config.Core == 'esx' then
    RegisterNetEvent("esx:setJob", function(job) CreateBlips() end)
end

function getPlayerJob()
    local PlayerJob = nil
    if Config.Core == 'qb' then
        local PlayerData = QBCore.Functions.GetPlayerData()
        PlayerJob = PlayerData?.job?.name
    elseif Config.Core == 'esx' then
        PlayerJob =  ESX.GetPlayerData()?.job?.name
    end
    return PlayerJob
end

function Notify(text, notifyType, duration, title)
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
RegisterNetEvent('mala_fakeplates:client:notify', Notify)

Custom = {}

function Custom.GetPlayerData ()
    print('Custom.GetPlayerData not modified')
    return {}
end

function Custom.GetPlayers ()
    print('Custom.GetPlayers not modified')
    return {}
end

function Custom.Notify (text, notifyType, duration)
    print('Custom.Notify not modified')
    print(text)
end
