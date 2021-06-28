PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

local tabaccoNext = 1
local IsAnimated = false
local tabaccoLocation = {
    vector3(2217.04, 5578.37, 53.72),
    vector3(2223.47, 5578.13, 53.72),
    vector3(2230.78, 5577.63, 53.82),
    vector3(2231.08, 5575.52, 53.79),
    vector3(2225.48, 5575.88, 53.64),
    vector3(2220.89, 5576.28, 53.64),
    vector3(2216.44, 5576.52, 53.61),
}

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        if PantCore then
            if #(playerCoords - tabaccoLocation[tabaccoNext]) < 15 and not busy then 
                time = 1
                DrawMarker(2, tabaccoLocation[tabaccoNext].x, tabaccoLocation[tabaccoNext].y, tabaccoLocation[tabaccoNext].z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 81, 125, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - tabaccoLocation[tabaccoNext]) < 2 then 
                    PantCore.Functions.DrawText3D(tabaccoLocation[tabaccoNext].x, tabaccoLocation[tabaccoNext].y, tabaccoLocation[tabaccoNext].z, "[E] Collect Tobacco Leaf")
                    if IsControlJustReleased(0, 38) then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount <= 5 then
                                tabaccoNext = math.random(1, #tabaccoLocation)
                                busy = true

                                Citizen.Wait(math.random(250,1250))
                                local finished = exports["ld-skillbar"]:taskBar(math.random(1100,1500),math.random(9,15))
                                if not finished then
                                    busy = false
                                    PantCore.Functions.Notify("You Uprooted the Tree")
                                else
                                    TriggerServerEvent("ld-jobs:tabacco", "collect")
                                    busy = false
                                    exports["ld-levelsistemi"]:expVer("tgimeslek")
                                    PantCore.Functions.Notify("You Picked the Leaf")
                                end
                            else
                                PantCore.Functions.Notify("You Can't Gather More Tobacco Leaves", "error")
                                Citizen.Wait(5000)
                            end
                        end, "tutunyapragi")
                    end
                end
            end

            if #(playerCoords - tabaccoLocationProcess) < 15 and not busy then 
                time = 1
                DrawMarker(2, tabaccoLocationProcess.x, tabaccoLocationProcess.y, tabaccoLocationProcess.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 81, 125, 0, 100, false, true, 2, false, false, false, false)
                if #(playerCoords - tabaccoLocationProcess) < 2 then 
                    PantCore.Functions.DrawText3D(tabaccoLocationProcess.x, tabaccoLocationProcess.y, tabaccoLocationProcess.z, "[E] Dry Tobacco Leaf")
                    if IsControlJustReleased(0, 38) then
                        PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
                            if amount >= 1 then
                                busy = true
                                PantCore.Functions.Progressbar("tabacco", "You Dry Tobacco", 60000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    busy = false
                                    TriggerServerEvent("ld-jobs:tabacco", "tabacco")
                                end, function() -- Cancel
                                    busy = false
                                end)
                            else
                                PantCore.Functions.Notify("No Tobacco Leaf To Dry On It", "error")
                            end
                        end, "tutunyapragi")
                    end
                end
            end
        end

        Citizen.Wait(time)
    end
end)

RegisterNetEvent("ld-job:cigar")
AddEventHandler("ld-job:cigar", function()
    if not IsAnimated then	
		IsAnimated = true
		exports["gamz-skillsystem"]:UpdateSkillRemove("Kondisyon", 0.05)
        local i = 0
        PantCore.Functions.Progressbar("jobs_cigaratte", "Smoking", 100000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
            disableMovement = false,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {
            animDict = "amb@world_human_aa_smoke@male@idle_a",
            anim = "idle_a",
            flags = 49,
        }, { -- prop1
            model = "ng_proc_cigarette01a",
            bone = 64096,
            coords = { x = 0.0, y = 0.0, z = -0.01 },
			rotation = { x = 0.0, y = 0.0, z = 70.0 },
        }, {}, function() -- Done
            -- Done
        end, function() -- Cancel
            i = 11
        end)

        while i >= 0 and i < 10 do
            Citizen.Wait(2500)
            TriggerServerEvent("ld-jobs:cigar-smoke")
            TriggerEvent("ld-stres:stres-dusur", 80)
            i = i + 1
            Citizen.Wait(8450)
		end
		IsAnimated = false		
	end
end)

RegisterNetEvent("ld-jobs:client:cigar-smoke")
AddEventHandler("ld-jobs:client:cigar-smoke", function(id)
    local player = GetPlayerFromServerId(id)
    if player ~= -1 then
        local playerPed = GetPlayerPed(player)
        local createdSmoke = UseParticleFxAssetNextCall("core")
        --Wait(250)
        RequestNamedPtfxAsset("core")
        while not HasNamedPtfxAssetLoaded("core") do
            Citizen.Wait(10)
        end
        SetPtfxAssetNextCall("core")
        local Smoke = StartParticleFxLoopedOnEntityBone("exp_grd_bzgas_smoke", playerPed, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, GetPedBoneIndex(playerPed, 20279), 0.3, 0.0, 0.0, 0.0)
        SetParticleFxLoopedAlpha(Smoke, 1.0)
        Citizen.Wait(6000)
        StopParticleFxLooped(Smoke, 0)
    end
end)