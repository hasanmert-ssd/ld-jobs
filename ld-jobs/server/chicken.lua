PantCore = nil
TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end) 

PantCore.Functions.CreateCallback("ld-jobs:check-item-amount", function (source, cb, item)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    local itemcheck = xPlayer.Functions.GetItemByName(item)
    if itemcheck ~= nil then
        cb(itemcheck.amount)
    else
        cb(0)
    end    
end)

RegisterServerEvent("ld-jobs:chicken-collect")
AddEventHandler("ld-jobs:chicken-collect", function (tip)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    if tip == "collect" then
        local itemvereceksayi = math.random(1, 2)
        xPlayer.Functions.AddItem('alive_chicken', itemvereceksayi)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['alive_chicken'], "add", itemvereceksayi)
    elseif tip == "cook" then
        local itemcheck = xPlayer.Functions.GetItemByName("alive_chicken")
        local davuksayisi = itemcheck.amount
        xPlayer.Functions.RemoveItem("alive_chicken", davuksayisi)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['alive_chicken'], "remove", davuksayisi)
        xPlayer.Functions.AddItem("slaughtered_chicken", davuksayisi)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['slaughtered_chicken'], "add", davuksayisi)
    elseif tip == "packaged" then
        if xPlayer.Functions.AddItem("packaged_chicken", 5) and xPlayer.Functions.RemoveItem("slaughtered_chicken", 5) then
            TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['slaughtered_chicken'], "remove",5)
            TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['packaged_chicken'], "add", 5)
        else
            TriggerClientEvent('PantCore:Notify', xPlayer.PlayerData.source, 'Üzerinde yeterli yer yok.', "error")
        end
    elseif tip == "sell" then
        local itemcheck2 = xPlayer.Functions.GetItemByName("packaged_chicken")
        local davuksayisi3 = itemcheck2.amount
        xPlayer.Functions.RemoveItem('packaged_chicken', davuksayisi3)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['packaged_chicken'], "remove", davuksayisi3)
        xPlayer.Functions.AddMoney("cash", 28 * davuksayisi3)
    elseif tip == "marine-tavuk" then
        xPlayer.Functions.RemoveItem('packaged_chicken', 1)
        xPlayer.Functions.RemoveItem('sut', 1)
        xPlayer.Functions.AddItem('marinetavuk', 1)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['packaged_chicken'], "remove", 1)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['sut'], "remove", 1)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['marinetavuk'], "add", 1)
    end
end)

PantCore.Functions.CreateCallback('ld-jobs:tavuk-can-item-check', function(source, cb)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    local item = xPlayer.Functions.GetItemByName("packaged_chicken")
    local item2 = xPlayer.Functions.GetItemByName("sut")
    if item ~= nil and item2 ~= nil then
        cb(true)
    else
        cb(false)
    end
end)