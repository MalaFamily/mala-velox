local Autovelox, blips = {}, {}
local isInVelox = false

if Config.Framework == "es_extended" then
    RegisterNetEvent("esx:setJob", function(job) CreateBlips() end)
elseif Config.Framework == "qb-core" then
    RegisterNetEvent("QBCore:Client:OnJobUptade", function(job) CreateBlips() end)
elseif Config.Framework == 'qbx_core' then
    RegisterNetEvent("QBCore:Client:OnJobUptade", function(job) CreateBlips() end)
end

local function IsPedDriver(vehicle, ped)
    if not ped then ped = GetPlayerPed(-1) end
    if not vehicle then print("ERROR : NO VEHICLE TO CHECK") return false end
    return GetPedInVehicleSeat(vehicle, -1) == ped
end

local function VelocityRadarTaken(data, velocity_atm, multiplier, max_speed)
    Notify(string.format(locale("velox_notification"), math.floor(velocity_atm)), "info", 5000)

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

    -- print("Is Vehicle owned", owned)
    if owned then
        lib.callback('ch-velox:server:giveBill', false, function(billGived)
        end, velocity_atm, multiplier, max_speed)
    else
        Notify(locale("vehicle_hidden"), "info", 5000)
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
        SetBlipDisplay(blip, Config.blacklisted_jobs[GetPlayerJob()] and 4 or 5)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 3)

        SetBlipAsShortRange(blip, true)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(locale("autovelox"))
        EndTextCommandSetBlipName(blip)
        table.insert(blips, blip)
    end
end

Citizen.CreateThread(function()
    while not GetPlayerJob() do Citizen.Wait(100) end

    CreateBlips()

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

            if isInVelox and IsPedInAnyVehicle(ped, false) and not Config.blacklisted_jobs[GetPlayerJob()] then
                local vehicle = GetVehiclePedIsIn(ped, false)

                if IsPedDriver(vehicle, ped) then
                    local velocity = GetEntitySpeed(vehicle) * (Config.useKMH and 3.6 or 2.236936)

                    if velocity >= Config.VelocityRadar[idx].max_speed then
                        local r, g, b = GetVehicleColor(vehicle)
                        local data = { 
                            vehicle = vehicle,
                            velocity = math.floor(velocity), 
                            plate = GetVehicleNumberPlateText(vehicle), 
                            model = GetVehicleModelName(vehicle),
                            color = { r, g, b }
                        }

                        CallPolice(point, string.format(locale("vehicle_dispatch"), Config.VelocityRadar[idx].name), data)
                        VelocityRadarTaken(data, velocity, Config.VelocityRadar[idx].multiplier, Config.VelocityRadar[idx].max_speed)
                    end
                end
            end
        end)
    end
end)
