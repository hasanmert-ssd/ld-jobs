PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj)
    PantCore = obj
end)

RegisterServerEvent("ld-jobs:milk-collect")
AddEventHandler("ld-jobs:milk-collect", function(tip)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    if xPlayer then
        if tip == "collect" then
            xPlayer.Functions.AddItem("kovasut", 1)
            TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['kovasut'], "add", 1)
        elseif tip == "pasteurized" then
            local item = xPlayer.Functions.GetItemByName('kovasut')
            xPlayer.Functions.RemoveItem("kovasut", item.amount)
            xPlayer.Functions.AddItem("sut", item.amount)
            TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['kovasut'], "remove", item.amount)
            TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['sut'], "add", item.amount)
        elseif tip == "milk-sell" then
            if xPlayer.Functions.GetItemByName('sut') ~= nil then
                local item = xPlayer.Functions.GetItemByName('sut')
                local sut = item.amount
                xPlayer.Functions.RemoveItem('sut', sut)
                xPlayer.Functions.AddMoney('cash', 11 * sut)
                TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['sut'], "remove", sut)
            else
                TriggerClientEvent('PantCore:Notify', xPlayer.PlayerData.source, 'Not Enough Pasteurized Milk On It!', "error")
            end
        elseif tip == "milk-chicken-sell" then
            if xPlayer.Functions.GetItemByName('marinetavuk') ~= nil then
                local marine = xPlayer.Functions.GetItemByName('marinetavuk')
                local mtavuk = marine.amount
                xPlayer.Functions.RemoveItem('marinetavuk', mtavuk)
                TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['marinetavuk'], "remove", mtavuk)
                xPlayer.Functions.AddMoney('cash', 108 * mtavuk)
            else
                TriggerClientEvent('PantCore:Notify', xPlayer.PlayerData.source, 'No Over Marinated Chicken!', "error")
            end
        end
    end -- Üzerinde Marine Edilmiş Tavuk Yok!
end)