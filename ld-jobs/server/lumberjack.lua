PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)


RegisterServerEvent("ld-jobs:tree-collect")
AddEventHandler("ld-jobs:tree-collect", function (tip)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    if tip == "collect" then
        local miktar = math.random(1, 2)
        xPlayer.Functions.AddItem('odun', miktar)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['odun'], "add", miktar)
    elseif tip == "cut" then
        xPlayer.Functions.RemoveItem("odun", 5)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['odun'], "remove", 5)
        xPlayer.Functions.AddItem("talas", 3)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['talas'], "add", 3)
        xPlayer.Functions.AddItem("kereste", 2)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['kereste'], "add", 2)
    elseif tip == "timber-sell" then
        local itemcount = xPlayer.Functions.GetItemByName("kereste")
        xPlayer.Functions.RemoveItem('kereste', itemcount.amount)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['kereste'], "remove", itemcount.amount)
        xPlayer.Functions.AddMoney("cash", itemcount.amount * 35)
    elseif tip == "sawdust-sell" then
        local itemcount = xPlayer.Functions.GetItemByName("talas")
        xPlayer.Functions.RemoveItem('talas', itemcount.amount)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['talas'], "remove", itemcount.amount)
        xPlayer.Functions.AddMoney("cash", itemcount.amount * 31)
    end
end)