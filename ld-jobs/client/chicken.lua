PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

local collectLoaciton = 1
local marineChicken = vector3(40.705940246582, -1020.1619262695, 28.512180328369)
local chickenLocation = {
    ["collect"] = {
        vector3(-68.59, 6248.15, 31.08),
        vector3(-62.27, 6241.81, 31.09),
        vector3(-65.92, 6236.34, 31.09),
        vector3(-65.14, 6245.57, 31.09),
    },
}

Citizen.CreateThread(function()
    exports["pant-base"]:pedcreate("tavukped", `s_m_m_cntrybar_01`, marineChicken.x, marineChicken.y, marineChicken.z, 65.96)
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if PantCore then
            if #(playerCoords - chickenLocation["collect"][collectLoaciton]) < 15 and not busy then 
                time = 1
                DrawMarker(2, chickenLocation["collect"][collectLoaciton].x, chickenLocation["collect"][collectLoaciton].y, chickenLocation["collect"][collectLoaciton].z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 145, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - chickenLocation["collect"][collectLoaciton]) < 2 then 
                    PantCore.Functions.DrawText3D(chickenLocation["collect"][collectLoaciton].x, chickenLocation["collect"][collectLoaciton].y, chickenLocation["collect"][collectLoaciton].z, "[E] Take chickens")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount <= 15 then
                                collectLoaciton = math.random(1, #chickenLocation["collect"])
                                busy = true

                                PantCore.Functions.Progressbar("chicken_collect", "You Get Chickens", 15000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    busy = false
                                    TriggerServerEvent("ld-jobs:chicken-collect", "collect")
                                    exports["ld-levelsistemi"]:expVer("tgimeslek")
                                end, function() -- Cancel
                                    busy = false
                                end)
                            else
                                PantCore.Functions.Notify("You Can't Collect More Chickens", "error")
                                Citizen.Wait(5000)
                            end
                        end, "alive_chicken")
                    end
                end
            end

            if #(playerCoords - cook) < 15 and not busy then 
                time = 1
                DrawMarker(2, cook.x, cook.y, cook.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 145, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - cook) < 2 then 
                    PantCore.Functions.DrawText3D(cook.x, cook.y, cook.z, "[E] Cut Ckickens")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount > 0 then
                                busy = true
                                PantCore.Functions.Progressbar("chicken_cook", "Chickens are Slaughtered", 35000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    busy = false
                                    TriggerServerEvent("ld-jobs:chicken-collect", "cook")
                                end, function() -- Cancel
                                    busy = false
                                end)
                            else
                                PantCore.Functions.Notify("Not Enough Chickens On It", "error")
                            end
                        end, "alive_chicken")
                    end
                end
            end

            if #(playerCoords - packaged) < 15 and not busy then 
                time = 1
                DrawMarker(2, packaged.x, packaged.y, packaged.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 145, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - packaged) < 2 then 
                    PantCore.Functions.DrawText3D(packaged.x, packaged.y, packaged.z, "[E] Pack the chickens")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount >= 5 then
                                busy = true
                                PantCore.Functions.Notify("You're Preparing the Chickens to Pack")
                                Citizen.Wait(math.random(2000,4500))
                                local finished = exports["ld-skillbar"]:taskBar(math.random(1600,2000),math.random(5,10))
                                if not finished then
                                    busy = false
                                    PantCore.Functions.Notify("You Couldn't Pack the Chickens")
                                else
                                    TriggerServerEvent("ld-jobs:chicken-collect", "packaged")
                                    busy = false
                                    PantCore.Functions.Notify("You Have Successfully Packed Chicken")
                                end

                            else
                                PantCore.Functions.Notify("No 5 Sliced ​​Chickens on Top", "error")
                            end
                        end, "slaughtered_chicken")
                    end
                end
            end

            if #(playerCoords - chickenSellLocation) < 15 and not busy then 
                time = 1
                DrawMarker(2, chickenSellLocation.x, chickenSellLocation.y, chickenSellLocation.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 145, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - chickenSellLocation) < 2 then 
                    PantCore.Functions.DrawText3D(chickenSellLocation.x, chickenSellLocation.y, chickenSellLocation.z, "[E] Sell packaged chickens")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount >= 1 then
                                TriggerServerEvent("ld-jobs:chicken-collect", "sell")
                                Citizen.Wait(2000)
                            else
                                PantCore.Functions.Notify("No 4 Packaged Chicken On Top", "error")
                            end
                        end, "packaged_chicken")
                    end
                end
            end

            if #(playerCoords - marineChicken) < 15 and not busy then 
                time = 1
                if #(playerCoords - marineChicken) < 2 then 
                    PantCore.Functions.DrawText3D(marineChicken.x, marineChicken.y, marineChicken.z+2.0, "[E] Chicken Cem")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.Functions.TriggerCallback("ld-jobs:tavuk-can-item-check", function(success)
                            if success then
                                busy = true
                                PantCore.Functions.Progressbar("yigit_can", "Processing", 10000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    busy = false
                                    TriggerServerEvent("ld-jobs:chicken-collect", "marine-tavuk")
                                end, function() -- Cancel
                                    busy = false
                                end)
                            else
                                PantCore.Functions.Notify("Need pasteurized milk and packaged chicken!", "error")
                            end
                        end)
                    end
                end
            end
        end

        Citizen.Wait(time)
    end
end)