PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

local lastWine = 1
local cocktails = vector3(161.02, 172.67, 104.92)
local wineLocation = {
    vector3(-1832.13, 2134.58, 123.58),
    vector3(-1823.2, 2136.19, 123.23),
    vector3(-1811.81, 2144.91, 119.97),
    vector3(-1801.06, 2146.72, 120.08),
    vector3(-1818.63, 2146.68, 118.44),
}

Citizen.CreateThread(function()
    exports["pant-base"]:pedcreate("wineped1", `mp_m_execpa_01`, wineSellLocation.x, wineSellLocation.y, wineSellLocation.z, 350.0)
    exports["pant-base"]:pedcreate("wineped2", `mp_m_weed_01`, cocktails.x, cocktails.y, cocktails.z, 73.0)
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if PantCore then
            if #(playerCoords - wineLocation[lastWine]) < 50 and not busy then 
                time = 1
                DrawMarker(2, wineLocation[lastWine].x, wineLocation[lastWine].y, wineLocation[lastWine].z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.7, 0.7, 0.7, 100, 0, 254, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - wineLocation[lastWine]) < 2 then 
                    PantCore.Functions.DrawText3D(wineLocation[lastWine].x, wineLocation[lastWine].y, wineLocation[lastWine].z, "[E] Pick Grapes")
                    if IsControlJustReleased(0, 38) then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount <= 15 then
                                lastWine = math.random(1, #wineLocation)
                                busy = true
                                PantCore.Functions.Notify("You're Gently Picking the Grapes")
                                Citizen.Wait(math.random(850,1850))
                                local finished = exports["ld-skillbar"]:taskBar(math.random(1000,1800),math.random(5,10))
                                if not finished then
                                    busy = false
                                    PantCore.Functions.Notify("Crushed Grape, Slow!")
                                else
                                    TriggerServerEvent("ld-wine:collect", "collect", PantCore.Key)
                                    busy = false
                                    PantCore.Functions.Notify("You Picked the Grapes")
                                    exports["ld-levelsistemi"]:expVer("tgimeslek", PantCore.Key)
                                end
                            
                            else
                                PantCore.Functions.Notify("You Can't Pick Any More Grapes", "error")
                                Citizen.Wait(5000)
                            end
                        end, "uzum")
                    end
                end
            end

            if #(playerCoords - wineJuice) < 15 and not busy then 
                time = 1
                DrawMarker(2, wineJuice.x, wineJuice.y, wineJuice.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 100, 0, 254, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - wineJuice) < 2 then 
                    PantCore.Functions.DrawText3D(wineJuice.x, wineJuice.y, wineJuice.z, "[E] Squeeze the Grapes")
                    if IsControlJustReleased(0, 38) then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount >= 5 then
                                busy = true
                                PantCore.Functions.Progressbar("juice_wine", "You're Squeezing the Grapes", 18000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    busy = false
                                    TriggerServerEvent("ld-wine:collect", "juice", PantCore.Key)
                                end, function() -- Cancel
                                    busy = false
                                end)
                            else
                                PantCore.Functions.Notify("You Need At least 5 Grapes", "error")
                            end
                        end, "uzum")
                    end
                end
            end

            if #(playerCoords - wineFermentable) < 15 and not busy then 
                time = 1
                DrawMarker(2, wineFermentable.x, wineFermentable.y, wineFermentable.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 100, 0, 254, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - wineFermentable) < 2 then 
                    PantCore.Functions.DrawText3D(wineFermentable.x, wineFermentable.y, wineFermentable.z, "[E] Buy Wine for Grape Juice")
                    if IsControlJustReleased(0, 38) then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount >= 5 then
                                busy = true
                                PantCore.Functions.Progressbar("fermentable_wine", "Giving Grape Juice", 15000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    busy = false
                                    TriggerServerEvent("ld-wine:collect", "fermentable", PantCore.Key)
                                end, function() -- Cancel
                                    busy = false
                                end)
                            else
                                PantCore.Functions.Notify("It Must Have At Least 5 Grape Juice On It!", "error")
                            end
                        end, "uzumsuyu")
                    end
                end
            end

            if #(playerCoords - wineSellLocation) < 15 and not busy then 
                time = 1
                DrawMarker(2, wineSellLocation.x, wineSellLocation.y, wineSellLocation.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 145, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - wineSellLocation) < 2 then 
                    PantCore.Functions.DrawText3D(wineSellLocation.x, wineSellLocation.y, wineSellLocation.z+2.0, "[E] Alcohol Sam")
                    if IsControlJustReleased(0, 38) then
                        if not IsPedInAnyVehicle(PlayerPed) then
                            PantCore.UI.Menu.Open('default', GetCurrentResourceName(), 'alkol_ayvaz', {
                                title    = 'Alkol Ayvaz',
                                align    = 'top-left',
                                elements = {
                                    {label = 'Şarap Sat', value = 'wine'},
                                }
                            },function(data, menu)
                                if data.current.value == 'wine' then
                                     TriggerServerEvent("meat-farm:startSelling31", 'wine', 20, 7500)
                                end
                                menu.close()
                            end, function(data, menu)
                                menu.close()
                            end)
                        else
                            PantCore.Functions.Notify("Get out of the vehicle!", "error")
                        end
                    end
                end
            end

            if #(playerCoords - cocktails) < 15 and not busy then 
                time = 1
                if #(playerCoords - cocktails) < 2 then 
                    PantCore.Functions.DrawText3D(cocktails.x, cocktails.y, cocktails.z+2.0, "[E] Justin Brother")
                    if IsControlJustReleased(0, 38) then
                        PantCore.Functions.TriggerCallback("ld-jobs:alican-abi-item-check", function(success)
                            if success then
                                busy = true
                                PantCore.Functions.Progressbar("alican_abi", "Processing", 15000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    busy = false
                                    TriggerServerEvent("ld-wine:collect", "cocktails", PantCore.Key)
                                end, function() -- Cancel
                                    busy = false
                                end)
                            end
                        end, "kovasut")
                    end
                end
            end
        end
        Citizen.Wait(time)

    end
end)