ESX = exports['es_extended']:getSharedObject()
Hell = exports['ch-lib']:getLib()

local Autovelox, blips = {}, {}
local isInVelox = false

Citizen.CreateThread(function()
    while not ESX.GetPlayerData().job do Citizen.Wait(100) end

    ESX.PlayerData = ESX.GetPlayerData()

    CreateBlips()
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job) ESX.PlayerData.job = job CreateBlips() end)

Citizen.CreateThread(function()
    -- VelocityRadarTaken()
    for _, v in ipairs(Config.VelocityRadar) do
        local velox = CircleZone:Create(vector2(v.pos.x, v.pos.y), v.radius, {
            name = v.name,
            
            useZ = v.settings.useZ,
            debugPoly = v.settings.debugPoly,
            debugColor = v.settings.debugColor or { 255, 0, 0 } 
        })

        table.insert(Autovelox, velox)
    end

    for idx, zone in ipairs(Autovelox) do
        AnimpostfxStopAll()
        zone:onPointInOut(PolyZone.getPlayerPosition, function(isPointInside, point)
            local ped = GetPlayerPed(-1)
            isInVelox = isPointInside

            if isInVelox and IsPedInAnyVehicle(ped, false) and not Config.blacklisted_jobs[ESX.PlayerData.job.name] then
                local vehicle = GetVehiclePedIsIn(ped, false)

                if Hell.IsPedDriver(vehicle, ped) then
                    local velocity = GetEntitySpeed(vehicle) * (Config.useKMH and 3.6 or 2.236936)

                    if velocity >= Config.VelocityRadar[idx].max_speed then
                        local r, g, b = GetVehicleColor(vehicle)
                        local data = { 
                            vehicle = vehicle,
                            velocity = math.floor(velocity), 
                            plate = GetVehicleNumberPlateText(vehicle), 
                            model = Config.GetVehicleModelName(vehicle),
                            color = { r, g, b }
                        }

                        print(point)
                        Config.CallPolice(point, "Veicolo ad alta velocità al " .. Config.VelocityRadar[idx].name, data)
                        VelocityRadarTaken(data, velocity, Config.VelocityRadar[idx].multiplier, Config.VelocityRadar[idx].max_speed)
                    end
                end
            end
        end)
    end
end)


function VelocityRadarTaken(data, velocity_atm, multiplier, max_speed)
    Config.Notification("Fai CHEEES!\nStavi andando a " .. math.floor(velocity_atm) .. "KM/h", "info", 5000, "AUTOVELOX")

    SetGpsFlashes(true)
    FlashMinimapDisplay()

    AnimpostfxPlay("InchPickup", 1100, false)
    Citizen.Wait(110)
    AnimpostfxPlay("InchPickup", 1100, false)
    Citizen.Wait(1150)

    AnimpostfxStop("InchPickup")

    local done, owned = false, false
    lib.callback('ch-velox:server:isVehicleOwned', false, function(isOwned)
        done, owned = true, isOwned
    end, data.model, data.plate)
    while not done do Citizen.Wait(10) end

    print("Is Vehicle owned", owned)
    if owned then
        Hell.tse('ch-velox:server:giveBill', velocity_atm, multiplier, max_speed)
    else
        Config.Notification("Il veicolo non è stato riconosciuto...", "info", 5000, "AUTOVELOX")
    end

    FlashMinimapDisplay()
    SetGpsFlashes(false)
end

function CreateBlips()
    for _, blip in ipairs(blips) do RemoveBlip(blip) end

    blips = {}

    for _, val in ipairs(Config.VelocityRadar) do
        local blip = AddBlipForCoord(val.pos.x, val.pos.y, val.pos.z)
        SetBlipSprite(blip, 184)
        SetBlipDisplay(blip, Config.blacklisted_jobs[ESX.PlayerData.job.name] and 4 or 5)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 3)

        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Autovelox")
        EndTextCommandSetBlipName(blip)
        table.insert(blips, blip)
    end
end
