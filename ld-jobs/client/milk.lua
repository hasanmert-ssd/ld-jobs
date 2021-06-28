PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

local lastTree = 1

Citizen.CreateThread(function()
    exports["pant-base"]:pedcreate("sutped", `u_m_m_markfost`, milkSellLocation.x, milkSellLocation.y, milkSellLocation.z, 350.0)
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if PantCore then
            if #(playerCoords - milkCollect) < 20 and not busy then 
                time = 1
                DrawMarker(2, milkCollect.x, milkCollect.y, milkCollect.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 57, 35, 1, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - milkCollect) < 2 then 
                    PantCore.Functions.DrawText3D(milkCollect.x, milkCollect.y, milkCollect.z, "[E] Fill Milk Bucket")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount <= 16 then
                                busy = true
                                PantCore.Functions.Notify("You Pick Up the Bucket")
                                Citizen.Wait(math.random(250,1250))
                                local finished = exports["ld-skillbar"]:taskBar(math.random(1600,2000),math.random(5,10))
                                if not finished then
                                    busy = false
                                    PantCore.Functions.Notify("You Spilled All the Milk")
                                else
                                    TriggerServerEvent("ld-jobs:milk-collect", "collect")
                                    busy = false
                                end
                            else
                                PantCore.Functions.Notify("You Can't Put Any More Milk In The Bucket", "error")
                            end
                        end, "kovasut")
                    end
                end
            end

            if #(playerCoords - milk) < 15 and not busy then 
                time = 1
                DrawMarker(2, milk.x, milk.y, milk.z+1.0, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 145, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - milk) < 2 then 
                    PantCore.Functions.DrawText3D(milk.x, milk.y, milk.z+0.3, "[E] Pasteurize the Milk")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount >= 1 then
                                busy = true
                                PantCore.Functions.Progressbar("milk", "Processing", 23500, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    busy = false
                                    TriggerServerEvent("ld-jobs:milk-collect", "pasteurized")
                                end, function() -- Cancel
                                    busy = false
                                end)
                            else
                                PantCore.Functions.Notify("You Need At least 4 Buckets of Milk", "error")
                            end
                        end, "kovasut")
                    end
                end
            end

            if #(playerCoords - milkSellLocation) < 15 and not busy then 
                time = 1
                DrawMarker(2, milkSellLocation.x, milkSellLocation.y, milkSellLocation.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 145, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - milkSellLocation) < 2 then 
                    PantCore.Functions.DrawText3D(milkSellLocation.x, milkSellLocation.y, milkSellLocation.z+2.0, "[E] Milkman Fahri")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.UI.Menu.Open('default', GetCurrentResourceName(), 'sut_fahir', {
                            title    = 'Sütcü Fahri',
                            align    = 'top-right',
                            elements = {
                                {label = 'Süt Sat', value = 'milk'},
                                {label = 'Marine Edilmiş Paketlenmiş Tavuk Sat', value = 'milk-chicken'},
                            }
                        },function(data, menu)
                            if data.current.value == 'milk' then
                                TriggerServerEvent("ld-jobs:milk-collect", "milk-sell")
                            elseif data.current.value == 'milk-chicken' then	
                                TriggerServerEvent("ld-jobs:milk-collect", "milk-chicken-sell")
                            end
                            menu.close()
                        end, function(data, menu)
                            menu.close()
                        end)
                    end
                end
            end
        end

        Citizen.Wait(time)
    end
end)