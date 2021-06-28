PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

RegisterServerEvent('ld-jobs:mermer-ver')
AddEventHandler('ld-jobs:mermer-ver', function ()
    local xPlayer = PantCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddItem('mermer', 1)
    TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['mermer'], "add", 1)
end)

RegisterServerEvent('meat-farm:startSelling25')
AddEventHandler('meat-farm:startSelling25', function(item, qty, money)
    local src = source
    local xPlayer = PantCore.Functions.GetPlayer(src)
    if xPlayer.Functions.GetItemByName(item).amount >= qty then 
        if item == "mermer" then
            local time = (os.time() - xPlayer.PlayerData.metadata["mermer"])
            if time < 86400 and xPlayer.PlayerData.metadata["mermer"] ~= 0 then
                TriggerClientEvent("PantCore:Notify", xPlayer.PlayerData.source, 'You Can Only Sell Marble Once A Day! Next Grape '.. PantCore.Shared.Round(((86400-time)/60)/60,2) .. ' You Can Sell After Hours', 'error')	
                return
            else
                if qty <= 20 then
                    xPlayer.Functions.SetMetaData("mermer", os.time())
                    xPlayer.Functions.RemoveItem(item, qty)
                    xPlayer.Functions.AddMoney("cash", 7500)
                else
                    TriggerClientEvent("PantCore:Notify", xPlayer.PlayerData.source, 'You can sell a maximum of 20 marbles.', 'error')	
                    return
                end
            end
        end
    else
        TriggerClientEvent("PantCore:Notify", xPlayer.PlayerData.source, 'On or in a Slot '..qty..' piece ' .. PantCore.Shared.Items[item].label ..' none!', 'error')
    end
end)

RegisterServerEvent('ld-job:temizlik-para')
AddEventHandler('ld-job:temizlik-para', function (source)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddMoney('bank', math.random(5, 30))
end)