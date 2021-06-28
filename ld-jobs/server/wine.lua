PantCore = nil
TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)



RegisterServerEvent("ld-wine:collect")
AddEventHandler("ld-wine:collect", function (tip)
    local xPlayer = PantCore.Functions.GetPlayer(source)
    local citizenid = xPlayer.PlayerData.citizenid
    if tip == "collect" then
        local itemvereceksayi = 2
        xPlayer.Functions.AddItem('uzum', itemvereceksayi)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['uzum'], "add", itemvereceksayi)
    elseif tip == "juice" then
        local itemcheck2 = xPlayer.Functions.GetItemByName("uzum")
        local uzumsayisi2 = itemcheck2.amount
        xPlayer.Functions.RemoveItem("uzum", uzumsayisi2)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['uzum'], "remove", uzumsayisi2)
        xPlayer.Functions.AddItem("uzumsuyu", uzumsayisi2)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['uzumsuyu'], "add", uzumsayisi2)
    elseif tip == "fermentable" then
        xPlayer.Functions.RemoveItem("uzumsuyu", 5)
        xPlayer.Functions.AddItem("wine", 5)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['uzumsuyu'], "remove",5)
        TriggerClientEvent('inventory:client:ItemBox', xPlayer.PlayerData.source, PantCore.Shared.Items['wine'], "add", 5)
    end
end)


local uzumRestart = false -- Her restartta üzüm satma aktif olsun
local uzumSatanlar = {}
RegisterServerEvent('meat-farm:startSelling31')
AddEventHandler('meat-farm:startSelling31', function(item, qty, money)
    local src = source
    --if PantCore.Functions.kickHacKer(src, key) then -- PantCore.Key
    local xPlayer = PantCore.Functions.GetPlayer(src)
    if xPlayer.Functions.GetItemByName(item).amount >= qty then 
        if item == "wine" then
            if uzumRestart then
                if uzumSatanlar[xPlayer.PlayerData.citizenid] then
                    TriggerClientEvent("PantCore:Notify", src, 'You Can Only Sell Grapes Once A Day!', 'error')	
                    return
                else
                    if qty <= 20 then
                        uzumSatanlar[xPlayer.PlayerData.citizenid] = true
                    else
                        TriggerClientEvent("PantCore:Notify", xPlayer.PlayerData.source, 'You Can Sell Up To 20 Grapes', 'error')	
                        return
                    end
                end
            else
                local time = (os.time() - xPlayer.PlayerData.metadata["uzum"])
                if time < 86400 and xPlayer.PlayerData.metadata["uzum"] ~= 0 then
                    TriggerClientEvent("PantCore:Notify", xPlayer.PlayerData.source, 'You Can Only Sell Grapes Once A Day! Next Grape '.. PantCore.Shared.Round(((86400-time)/60)/60,2) .. ' You Can Sell After Hours', 'error')	
                    return
                else
                    if qty <= 20 then
                        xPlayer.Functions.SetMetaData("uzum", os.time())
                        xPlayer.Functions.RemoveItem(item, qty)
                        xPlayer.Functions.AddMoney("cash", 7500)	
                    else
                        TriggerClientEvent("PantCore:Notify", xPlayer.PlayerData.source, 'You Can Sell Up To 20 Grapes', 'error')	
                        return
                    end
                end
            end
        end
    else
        TriggerClientEvent("PantCore:Notify", xPlayer.PlayerData.source, 'On or in a Slot '..qty..' piece ' .. PantCore.Shared.Items[item].label ..' none!', 'error')
    end
   -- end
end)

-- function SayiEkle(source, eklencekpara)
--     local xPlayer = PantCore.Functions.GetPlayer(source)
-- 	local citizenid = xPlayer.PlayerData.citizenid
-- 	exports.ghmattimysql:execute("SELECT issatispara FROM players WHERE citizenid = @citizenid", {
-- 		['@citizenid'] = citizenid
-- 	}, function(result)
-- 		local players = result[1]
-- 		local issatispara = players['issatispara']
-- 		local issatiparaekle = issatispara + eklencekpara
 
-- 		exports.ghmattimysql:execute("UPDATE players SET issatispara = @issatispara, lastLimit = @lastLimit WHERE citizenid = @citizenid", {
-- 			['@citizenid'] =  xPlayer.PlayerData.citizenid,
-- 			['@issatispara'] = issatiparaekle,
-- 			['@lastLimit']  = os.time()
-- 		}, function(result)
--             print(json.encode(result))
--         end)
--    	end) 
-- end