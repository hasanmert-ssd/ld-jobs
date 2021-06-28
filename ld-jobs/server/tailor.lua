TriggerEvent('PantCore:GetObject', function(obj)
    PantCore = obj
end)

RegisterServerEvent('ld-jobs:tailor')
AddEventHandler('ld-jobs:tailor', function (tip)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    if tip == "collect"  then
        xPlayer.Functions.AddItem('fabric', 2)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['fabric'], "add", 2)
    elseif tip == "sewing" then
        xPlayer.Functions.RemoveItem('fabric', 4)
        xPlayer.Functions.AddItem('clothe', 4)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['fabric'], "add", 1)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['clothe'], "remove", 1)
    elseif tip == "sell" then
        local barisin3cmsi = xPlayer.Functions.GetItemByName('clothe')
        xPlayer.Functions.RemoveItem('clothe', barisin3cmsi.amount)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['clothe'], "remove", barisin3cmsi.amount)
        xPlayer.Functions.AddMoney('cash', 18 * barisin3cmsi.amount)
    end
end)

RegisterServerEvent('ld-job:garbage')
AddEventHandler('ld-job:garbage', function ()
    local xPlayer = PantCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddMoney('cash', math.random(550, 620))
end)

RegisterServerEvent('ld-job:temizlik-para')
AddEventHandler('ld-job:temizlik-para', function ()
    local xPlayer = PantCore.Functions.GetPlayer(source)
    xPlayer.Functions.AddMoney('bank', math.random(18, 22))
    TriggerClientEvent('PantCore:Notify', xPlayer.PlayerData.source, 'Some money has been deposited into your bank account for cleaning the floor.', "success")
end)