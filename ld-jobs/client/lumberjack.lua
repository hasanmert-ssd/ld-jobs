PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

local lastTree = 1
local treeLocation = {
    vector3(-503.7, 5392.25, 75.98),
    vector3(-500.29, 5400.48, 75.21),
    vector3(-492.95, 5396.07, 77.12),
}

Citizen.CreateThread(function()
    exports["pant-base"]:pedcreate("odunped", `cs_old_man2`, woodSellLocation.x, woodSellLocation.y, woodSellLocation.z, 175.0)
end)

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if PantCore then
            if #(playerCoords - treeLocation[lastTree]) < 20 and not busy then 
                time = 1
                DrawMarker(2, treeLocation[lastTree].x, treeLocation[lastTree].y, treeLocation[lastTree].z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 180, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - treeLocation[lastTree]) < 2 then 
                    PantCore.Functions.DrawText3D(treeLocation[lastTree].x, treeLocation[lastTree].y, treeLocation[lastTree].z, "[E] Cut the tree")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        --PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                        --    if amount <= 10 then
                                lastTree = math.random(1, #treeLocation)
                                busy = true
                                PantCore.Functions.Notify("You're Getting Ready To Cut The Ax Tightly From The Grip")
                                Citizen.Wait(math.random(250,1850))
                                local finished = exports["ld-skillbar"]:taskBar(math.random(1600,2000),math.random(5,10))
                                if not finished then
                                    busy = false
                                    PantCore.Functions.Notify("Ax Slip From Hand")
                                else
                                    exports["ld-levelsistemi"]:expVer("tgimeslek")
                                    TriggerServerEvent("ld-jobs:tree-collect", "collect")
                                    busy = false
                                    PantCore.Functions.Notify("You Cut Part of the Tree")
                                end
                            
                            --else
                            --    PantCore.Functions.Notify("Daha Fazla Ağaç Kesemezsin", "error")
                            --    Citizen.Wait(5000)
                            --end
                        --end, "odun")
                    end
                end
            end

            if #(playerCoords - talasLocation) < 15 and not busy then 
                time = 1
                DrawMarker(2, talasLocation.x, talasLocation.y, talasLocation.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 180, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - talasLocation) < 2 then 
                    PantCore.Functions.DrawText3D(talasLocation.x, talasLocation.y, talasLocation.z, "[E]Turn wood into sawdust")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount >= 5 then
                                busy = true
                                PantCore.Functions.Progressbar("talas", "Processing", 15000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    busy = false
                                    TriggerServerEvent("ld-jobs:tree-collect", "cut")
                                end, function() -- Cancel
                                    busy = false
                                end)
                            else
                                PantCore.Functions.Notify("You Need At least 5 Woods", "error")
                            end
                        end, "odun")
                    end
                end
            end

            if #(playerCoords - woodSellLocation) < 15 and not busy then 
                time = 1
                DrawMarker(2, woodSellLocation.x, woodSellLocation.y, woodSellLocation.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 180, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - woodSellLocation) < 2 then 
                    PantCore.Functions.DrawText3D(woodSellLocation.x, woodSellLocation.y, woodSellLocation.z+2.0, "[E] Wood Ersin")
                    if IsControlJustReleased(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        PantCore.UI.Menu.Open('default', GetCurrentResourceName(), 'odun_ersin', {
                            title    = 'Odun Ersin',
                            align    = 'top-left',
                            elements = {
                                {label = 'Kereste Sat', value = 'timber'},
                                {label = 'Talaş Sat', value = 'sawdust'}
                            }
                        },function(data, menu)
                            if data.current.value == 'timber' then	
                                TriggerServerEvent("ld-jobs:tree-collect", "timber-sell")
                            elseif data.current.value == 'sawdust' then	
                                TriggerServerEvent("ld-jobs:tree-collect", "sawdust-sell")
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