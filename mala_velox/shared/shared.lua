lib.locale()

---@param ... any
---@return nil
function Debug(...)
    if Config.Debug then
        print('^0[^4DEBUG^0]',...)
    end
end

---@param ... any
---@return nil
function Error(...)
    print('^0[^1ERROR^0]^1',...,'^0')
end

local frameworks = {'es_extended','qb-core','qbx_core'}
if Config.Framework == 'auto' then
    local found = false
    for i= 1, #frameworks do
        if GetResourceState(frameworks[i]) == 'started' then
            Config.Framework = frameworks[i]
            Debug(('Detected %s as Framework'):format(Config.Framework))
            found = true
            break
        end
    end
    if not found then
        Error('Can\'t find framework automatically, use custom functions in editable.lua')
        Config.Framework = 'custom'
    end
end

if Config.Framework == "es_extended" then
    ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == "qb-core" then
    QBCore = exports["qb-core"]:GetCoreObject()
elseif Config.Framework == 'qbx_core' then
    QBCore = exports["qb-core"]:GetCoreObject()
end
