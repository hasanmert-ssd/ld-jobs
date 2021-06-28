TriggerEvent('PantCore:GetObject', function(obj)
    PantCore = obj
end)

RegisterServerEvent('ld-jobs:tabacco')
AddEventHandler('ld-jobs:tabacco', function (tip)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    if tip == "collect" then
        xPlayer.Functions.AddItem('tutunyapragi', 1)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['tutunyapragi'], "add", 1)
    elseif tip == "tabacco" then
        xPlayer.Functions.RemoveItem('tutunyapragi', 1)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['tutunyapragi'], "remove", 1)
        xPlayer.Functions.AddItem('tutun', 1)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['tutun'], "add", 1)
    end
end)

RegisterServerEvent('ld-job:cigar')
AddEventHandler('ld-job:cigar', function ()
    TriggerClientEvent('ld-jobs:client:cigar-smoke', -1)
end)