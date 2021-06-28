PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)


RegisterServerEvent('ld-meslekmaden:washing')
AddEventHandler('ld-meslekmaden:washing', function()
    local xPlayer = PantCore.Functions.GetPlayer(source)
    --TriggerClientEvent('ld-meslekmaden:washing', status)
    xPlayer.Functions.RemoveItem('stone', 1)
    xPlayer.Functions.AddItem('washed_stone', 1)
    TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['stone'], "remove", 1)
    TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['washed_stone'], "add", 1)
  
end)




RegisterServerEvent("ld-meslekmaden:givestone")
AddEventHandler("ld-meslekmaden:givestone", function ()
    local xPlayer = PantCore.Functions.GetPlayer(source)
    if xPlayer then
        xPlayer.Functions.AddItem('stone', math.random(1,2))
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['stone'], "add", 1)
    end
end)


RegisterServerEvent("ld-meslekmaden:remelting")
AddEventHandler("ld-meslekmaden:remelting", function ()
    local xPlayer = PantCore.Functions.GetPlayer(source)
    local sans = math.random(1, 100)
    if sans >= 40 then
        xPlayer.Functions.RemoveItem('washed_stone', 1)
        xPlayer.Functions.AddItem('copper', 5)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['copper'], "add", 5)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['washed_stone'], "remove", 1) 
    elseif sans <= 40 then
        xPlayer.Functions.RemoveItem('washed_stone', 1)
        xPlayer.Functions.AddItem('iron', 3)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['iron'], "add", 3)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['washed_stone'], "remove", 1)
    elseif sans <= 25 then
        xPlayer.Functions.RemoveItem('washed_stone', 1)
        xPlayer.Functions.AddItem('gold', 2)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['gold'], "add", 2)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['washed_stone'], "remove", 1)
    elseif sans <= 15 then
        xPlayer.Functions.RemoveItem('washed_stone', 1)
        xPlayer.Functions.AddItem('diamond', 1)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['diamond'], "add", 1)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['washed_stone'], "remove", 1)
    end
end)

