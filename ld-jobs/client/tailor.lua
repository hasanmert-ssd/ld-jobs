PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if PantCore then
            if #(playerCoords - fabricCollect) < 15 and not busy then 
                time = 1
                DrawMarker(2, fabricCollect.x, fabricCollect.y, fabricCollect.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 110, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - fabricCollect) < 2 then 
                    PantCore.Functions.DrawText3D(fabricCollect.x, fabricCollect.y, fabricCollect.z, "[E] Buy Fabrics")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount <= 15 then
                                busy = true
                                PantCore.Functions.Progressbar("fabric_collect", "You get the fabrics", 15000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    busy = false
                                    exports["ld-levelsistemi"]:expVer("tgimeslek")
                                    TriggerServerEvent("ld-jobs:tailor", "collect")
                                end, function() -- Cancel
                                    busy = false
                                end)
                            else
                                PantCore.Functions.Notify("You Can't Buy Any More Fabric", "error")
                            end
                        end, "fabric")
                    end
                end
            end

            if #(playerCoords - clothesCollect) < 15 and not busy then 
                time = 1
                DrawMarker(2, clothesCollect.x, clothesCollect.y, clothesCollect.z-0.6, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 110, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - clothesCollect) < 2 then 
                    PantCore.Functions.DrawText3D(clothesCollect.x, clothesCollect.y, clothesCollect.z-0.3, "[E] Sew Fabrics")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount >= 5  then
                                busy = true
                                PantCore.Functions.Notify("You Place the Fabric in the Machine")
                                Citizen.Wait(math.random(2000,4500))
                                local finished = exports["ld-skillbar"]:taskBar(math.random(1200,1800),math.random(9,15))
                                if not finished then
                                    busy = false
                                    PantCore.Functions.Notify("You Couldn't Sew the Fabric")
                                else
                                    TriggerServerEvent("ld-jobs:tailor", "sewing")
                                    busy = false
                                    PantCore.Functions.Notify("You Have Successfully Sewed Fabric")
                                end
                            
                            else
                                PantCore.Functions.Notify("Not Enough Fabric On It", "error")
                            end
                        end, "fabric")
                    end
                end
            end

            if #(playerCoords - clothesSellLocation) < 15 and not busy then 
                time = 1
                DrawMarker(2, clothesSellLocation.x, clothesSellLocation.y, clothesSellLocation.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 110, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - clothesSellLocation) < 2 then 
                    PantCore.Functions.DrawText3D(clothesSellLocation.x, clothesSellLocation.y, clothesSellLocation.z, "[E] Sell Clothes")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount >= 4 then
                                busy = true
                                PantCore.Functions.Progressbar("fabric_sell", "You Sell Clothes", 15000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    busy = false
                                    TriggerServerEvent("ld-jobs:tailor", "sell")
                                end, function() -- Cancel
                                    busy = false
                                end)
                            else
                                PantCore.Functions.Notify("Doesn't Have 4 Outfits On You", "error")
                            end
                        end, "clothe")
                    end
                end

            end
        end
        Citizen.Wait(time)
    end
end)