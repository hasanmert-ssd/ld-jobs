PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

local locations = {}

local randomLacations = {
    {
        vector3(342.78, -1034.14, 30.5),
        vector3(379.05, -1118.74, 30.5),
        vector3(377.34, -1264.59, 33.5),
        vector3(301.24, -1284.95, 31.39),
        vector3(166.8, -1345.07, 30.33),
        vector3(64.77, -1470.71, 30.29),
        vector3(-94.2, -1471.22, 33.08),
        vector3(-11.04, -1812.39, 26.9),
        vector3(230.38, -1848.34, 27.85),
        vector3(152.74, -1973.77, 19.46),
        vector3(268.94, -2045.8, 18.91),
        vector3(338.22, -1968.1, 25.60),
        vector3(195.62, -1772.55, 30.18),
        vector3(-28.12, -1351.29, 30.32),
        vector3(-243.93, -1343.13, 32.24),
        vector3(6.69429063797, -1029.4122314453, 29.773001785278),
        vector3(33.06, -1009.38, 30.45),
        vector3(351.03, -196.59, 58.23),
        vector3(277.04, -168.39, 61.14),
    },
    {
        vector3(312.62902832031, -740.00982666016, 30.256967163086),
        vector3(244.22103881836, -824.28143310547, 31.051763153076),
        vector3(237.92852783203, -681.51538085938, 38.338971710205),
        vector3(48.090950012207, -302.02420043945, 48.612645721436),
        vector3(146.97618103027, -117.39861297607, 55.927068328857),
        vector3(94.997673034668, 0.26015248894691, 69.357781982422),
        vector3(-175.40821838379, -47.214752197266, 53.373132324219),
        vector3(-519.38958740234, 270.44732666016, 84.170152282715),
        vector3(-580.71356201172, 241.02746582031, 83.730531311035),
        vector3(-592.64239501953, 244.01438903809, 83.497277832031),
        vector3(-559.81701660156, -386.83923339844, 36.187329864502),
        vector3(-563.51324462891, -707.92358398438, 34.107957458496),
        vector3(-516.86370849609, -811.78900146484, 31.585372543335),
        vector3(-234.58930969238, -1299.6165771484, 32.395955657959),
        vector3(-168.69102478027, -1293.8596191406, 32.305305099487),
        vector3(-77.370162963867, -1384.6231689453, 31.416530227661),
        vector3(67.665168762207, -1408.5006103516, 30.452434158325),
        vector3(201.18183898926, -1266.0710449219, 30.325137710571),
    }
}

local nexLocation = 1
local work, collected = false, false
local truck, trashProp, garbageBlip = nil, nil, nil

function setBlip()
    if garbageBlip then
        RemoveBlip(garbageBlip)
    end
    if nexLocation ~= #locations + 1 then
        garbageBlip = AddBlipForCoord(locations[nexLocation].x, locations[nexLocation].y,locations[nexLocation].z)
        SetBlipSprite(garbageBlip, 1)
        SetBlipColour(garbageBlip, 16742399)
        SetBlipScale(garbageBlip, 0.5)
        SetNewWaypoint(locations[nexLocation].x, locations[nexLocation].y)
    end
end

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if PantCore then
            if #(playerCoords - garabageLocation) < 20 and not work then 
                time = 1
                DrawMarker(2, garabageLocation.x, garabageLocation.y, garabageLocation.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 100, 253, 7, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - garabageLocation) < 2 then 
                    PantCore.Functions.DrawText3D(garabageLocation.x, garabageLocation.y, garabageLocation.z, "[E] Start Scavenging")
                    if IsControlJustReleased(0, 38) then
                        work = true
                        locations = randomLacations[math.random(1, #randomLacations)]
                        PantCore.Functions.Notify("I Started Scavenging Business Go To The Location On The Map And Load The Garbage On The Vehicle")
                    
                        PantCore.Functions.SpawnVehicle(`trash`, function(veh)
                            truck = veh    
                            TaskWarpPedIntoVehicle(playerPed, truck, -1)
                            TriggerEvent("x-hotwire:give-keys", truck)
                            nexLocation = 1
                            setBlip()
                        end, {x=505.46, y=-574.7, z=24.75, h=180.0 }, true) -- coords, isnetwork
                        
                    end
                end
            end

            if nexLocation ~= #locations + 1 then
                if #(playerCoords - locations[nexLocation]) < 20 and not busy and work and not collected then 
                    time = 1
                    DrawMarker(2, locations[nexLocation].x, locations[nexLocation].y, locations[nexLocation].z-0.2, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 100, 253, 7, 100, false, true, 2, false, false, false, false)
                    if #(playerCoords - locations[nexLocation]) < 2.3 then 
                        PantCore.Functions.DrawText3D(locations[nexLocation].x, locations[nexLocation].y, locations[nexLocation].z+0.3, "[E] Pick up the garbage")
                        if IsControlJustReleased(0, 38) then
                            if not IsPedInAnyVehicle(playerPed) then
                                if GetPlayersLastVehicle(playerPed) == truck then
                                    busy = true
                                    PantCore.Functions.Progressbar("cop_topla", "Garbage Collection", 18000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    }, {
                                        animDict = "missexile3",
                                        anim = "ex03_dingy_search_case_base_michael",
                                        flags = 49,
                                    }, {}, {}, function() -- Done
                                        PantCore.Functions.Notify("Now Go Throw the Trash Behind the Vehicle")
                                        collected = true
                                        trashProp = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true)
                                        AttachEntityToEntity(trashProp, playerPed, GetPedBoneIndex(playerPed, 57005), 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true)
                                        PantCore.Shared.RequestAnimDict('anim@heists@narcotics@trash', function() -- animasyon oynatma
                                            TaskPlayAnim(playerPed, 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1, 49, 0, 0, 0,0)
                                        end)
                                        Citizen.CreateThread(function()
                                            while collected do
                                                Citizen.Wait(500)
                                                local playerPed = PlayerPedId()
                                                if not IsEntityPlayingAnim(playerPed, "anim@heists@narcotics@trash", "walk", 1) then
                                                    TaskPlayAnim(playerPed, 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1, 49, 0, 0, 0,0)
                                                end
                                            end
                                        end)
                                        busy = false
                                    end, function() -- Cancel
                                        busy = false
                                    end)
                                else
                                    PantCore.Functions.Notify("You have to be in the vehicle given to you to do the garbage disposal.")
                                end
                            else
                                PantCore.Functions.Notify("You Can't Pick Up Garbage While In The Vehicle")
                            end
                        end
                    end
                elseif work and collected and not busy then
                    local garbageTruckCoord = GetWorldPositionOfEntityBone(truck, GetEntityBoneIndexByName(truck, 'platelight'))
                    local distance = #(playerCoords - garbageTruckCoord)
                    if distance < 20 then
                        PantCore.Functions.DrawText3D(garbageTruckCoord.x, garbageTruckCoord.y, garbageTruckCoord.z + 1.0, "[E] Throw the trash")
                        if distance < 1 and IsControlJustReleased(0, 38) then
                            collected = false
                            nexLocation = nexLocation + 1
                            busy = true
                            PantCore.Functions.Progressbar("cop_at", "Garbage Throwing Behind the Vehicle", 1600, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "anim@heists@narcotics@trash",
                                anim = "throw_b",
                                flags = 49,
                            }, {}, {}, function() -- Done
                                DeleteEntity(trashProp)
                                setBlip()
                                if nexLocation ~= #locations + 1 then
                                    exports["ld-levelsistemi"]:expVer("tgimeslek")
                                    PantCore.Functions.Notify("You Picked Up The Garbage Now Go To The Next Location")
                                else
                                    PantCore.Functions.Notify("You've Finished All The Garbage Now Go Back To Where You Got The Job")
                                    SetNewWaypoint(498.17, -584.16)
                                end
                                busy = false
                            end, function() -- Cancel
                                busy = false
                                collected = true
                                nexLocation = nexLocation - 1
                            end)
                        end
                        time = 1
                    end
                end
                 
            end

            if #(playerCoords - garabageLocation) < 20 and work and nexLocation == #locations + 1 and not busy then 
                time = 1
                DrawMarker(2, garabageLocation.x, garabageLocation.y, garabageLocation.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 100, 253, 7, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - garabageLocation) < 2 then 
                    PantCore.Functions.DrawText3D(garabageLocation.x, garabageLocation.y, garabageLocation.z, "[E] End the scavenger")
                    if IsControlJustReleased(0, 38) then
                        busy = true
                        TriggerServerEvent("ld-job:garbage")
                        PantCore.Functions.DeleteVehicle(truck)
                        Citizen.Wait(5000)
                        work = false
                        nexLocation = 1
                        busy = false
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)