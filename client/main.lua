
-- JOIN FOR SUPPORT https://discord.gg/qRQ5f5rdmN
local QBCore = exports['qb-core']:GetCoreObject()


function openwasher()
    local input = lib.inputDialog('Wash Money', {'Black Money'})
        
    if not input then return end

    if tonumber(input[1]) == 0 then 
        lib.notify({
            title = 'Moneywash | Error',
            description = 'Value cant be 0',
            type = 'info',
            position = 'top'
        })
        return
    end
     if tonumber(input[1]) < 0  then 
         lib.notify({
             title = 'Moneywash | Error',
            description = 'Value must be above 0',
             type = 'info',
             position = 'top'
         })
         return

     end
    bidentax =  (input[1] * Config.Tax)  / 100 
    if Config.UseprogressCircle then 
    if lib.progressCircle({
        duration = Config.Misc.Progressduration,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            move = true,
            car = true,
        },
   
    }) then
    amounttobegivenincash = input[1] - bidentax
            print(tonumber(amounttobegivenincash))
            TriggerServerEvent('kezi:moneywash', amounttobegivenincash, input[1])
            lib.notify({
                title = 'Laundry | Success',
                description = "You Laundered $" .. input[1] .. " You got "  .." $".. tonumber(amounttobegivenincash) .. " Clean Money from it",
                type = 'success',
                position = 'top'
            })
        else 
        print("Oh no")
        end

end
if not Config.Misc.UseprogressCircle then 
    amounttobegivenincash = input[1] - bidentax
    TriggerServerEvent('kezi:moneywash', input[1])
    lib.notify({
        title = 'Laundry | Success',
        description = "You Laundered $" .. input[1] .. " You got "  .." $".. tonumber(amounttobegivenincash) .. " Clean Money from it",
        type = 'success',
        position = 'top'
    })
end
end 



CreateThread(function()
    while true do
        Wait(100)
        inRange = false
        local location = vector3(Config.location.x, Config.location.y, Config.location.z)
        local pos = GetEntityCoords(PlayerPedId())
        if #(pos - location) < 5.0 then
            inRange = true
            lib.showTextUI('[E] - Wash Money')
            if IsControlPressed(0,38) then
                openwasher()
                lib.hideTextUI()
            end
        else
        end
        if not inRange then
            lib.hideTextUI()
        end
    end
end)

