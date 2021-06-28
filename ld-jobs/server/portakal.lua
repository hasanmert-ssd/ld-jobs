PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj)
    PantCore = obj
end)

RegisterServerEvent('ld-meslekportakal:portakalver')
AddEventHandler('ld-meslekportakal:portakalver', function (sayi)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    if xPlayer then
        xPlayer.Functions.AddItem('portakal', sayi)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['portakal'], "add", sayi)
    end
end)

RegisterServerEvent('adiss:amkseyiniyap')
AddEventHandler('adiss:amkseyiniyap', function ()
    local xPlayer = PantCore.Functions.GetPlayer(source)
    xPlayer.Functions.RemoveItem('portakal', 5)
    xPlayer.Functions.AddItem('portakalsuyu', 1)
    TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['portakal'], "remove", 5)
    TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['portakalsuyu'], "add", 1)

end)

PantCore.Functions.CreateCallback('ld-meslekportakal:portakalisleme', function (source, cb)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    local item = xPlayer.Functions.GetItemByName('portakal')
    if item ~= nil then
        if item.amount >= 5 then
            cb(true)
        end
    else
        cb(false)
    end
end) 

PantCore.Functions.CreateCallback('ld-meslekportakal:portakalsatis', function (source, cb)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    local item = xPlayer.Functions.GetItemByName('portakalsuyu')
    if item ~= nil then
        cb(true) 
    else
        cb(false)
    end
end) 

RegisterServerEvent('portakalsuyu:sat')
AddEventHandler('portakalsuyu:sat', function ()
    local xPlayer = PantCore.Functions.GetPlayer(source)
    local itemcheck = xPlayer.Functions.GetItemByName("portakalsuyu")
    local davuksayisi = itemcheck.amount
    xPlayer.Functions.RemoveItem('portakalsuyu', davuksayisi)
    xPlayer.Functions.AddMoney('cash', 27 * davuksayisi)
    TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['portakalsuyu'], "remove", davuksayisi)
end)