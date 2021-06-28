PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

local secilenKonum = nil
local isleniyor = false

local bliplerMermer = {
    {
        ["kordinat"] = vector3(2952.9057617188, 2790.7829589844, 41.231597900391),
    },
    {
        ["kordinat"] = vector3(1220.72 , -3005.43, 5.67),
    }
}

local mermerler = {
    vector3(2952.9057617188, 2790.7829589844, 41.231597900391),
    vector3(2949.0739746094, 2795.2482910156, 40.765819549561),
    vector3(2942.0317382812, 2790.4904785156, 40.258220672607),
    vector3(2944.9416503906, 2795.6862792969, 40.632858276367),
    vector3(2942.9753417969, 2785.1088867188, 39.812232971191),
    vector3(2947.8815917969, 2780.6254882812, 39.550605773926),
    vector3(2967.2436523438, 2801.6166992188, 41.37398147583),
    vector3(2969.4382324219, 2787.650390625, 39.617698669434),
    vector3(2959.02734375, 2805.2934570312, 42.102054595947),
    vector3(2973.5087890625, 2795.5385742188, 40.948085784912),
    vector3(2955.7580566406, 2777.9504394531, 40.246585845947),
    vector3(2963.2580566406, 2781.8947753906, 39.64005279541),
}

Citizen.CreateThread(function()
    secilenKonum = mermerler[1]
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        local time = 1000
        local PlayerPed = PlayerPedId()
        local PlayerKordinat = GetEntityCoords(PlayerPed)
        local mesafe = #(PlayerKordinat - secilenKonum)
        local mesafeSatis = #(PlayerKordinat - bliplerMermer[2]["kordinat"])
        if PantCore then
            if mesafe < 50 then 
                time = 1
                DrawMarker(2, secilenKonum.x, secilenKonum.y, secilenKonum.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 236, 185, 57, 185, false, true, 2, false, false, false, false)
                if mesafe < 1.5 then
                    PantCore.Functions.DrawText3D(secilenKonum.x, secilenKonum.y, secilenKonum.z, "[E] Collect")
                    if IsControlJustReleased(0, 38) and not isleniyor then
                        if not IsPedInAnyVehicle(PlayerPed) then
                            isleniyor = true
                            local rastgele = math.random(1,#mermerler)
                            secilenKonum = mermerler[rastgele]

                            PantCore.Functions.Progressbar("mermer_topla", "Collecting Marble Stone", 4000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "pickup_object",
                                anim = "pickup_low",
                                flags = 33,
                            }, {}, {}, function() -- Done
                                if math.random(1,3) == 2 then 
                                    exports["ld-levelsistemi"]:expVer("tgimeslek")
                                end
                                print("1")
                                TriggerServerEvent("ld-jobs:mermer-ver")
                                isleniyor = false
                            end, function() -- Cancel
                                -- Cancel
                                isleniyor = false
                            end)
                        else
                            PantCore.Functions.Notify("How to Get the Bulkcan Marble from Inside the Vehicle!", "error")
                        end
                    end
                end
            end

            if mesafeSatis < 20 then
                time = 1
                DrawMarker(2, bliplerMermer[2]["kordinat"].x, bliplerMermer[2]["kordinat"].y, bliplerMermer[2]["kordinat"].z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 244, 8, 14, 100, false, true, 2, false, false, false, false)
                if mesafeSatis < 1.5 then
                    PantCore.Functions.DrawText3D(bliplerMermer[2]["kordinat"].x, bliplerMermer[2]["kordinat"].y, bliplerMermer[2]["kordinat"].z, "[E] Sell Marble Stones")
                    if IsControlJustReleased(0, 38) then
                        if not IsPedInAnyVehicle(PlayerPed) then
                            PantCore.UI.Menu.Open('default', GetCurrentResourceName(), 'mermer', {
                                title    = 'Muammer Mermercilik',
                                align    = 'top-left',
                                elements = {
                                    {label = 'Mermer Sat', value = 'mermer'},
                                }
                            }, function(data, menu)
                                menu.close()
                                if data.current.value == 'mermer' then
                                    TriggerServerEvent('meat-farm:startSelling25', 'mermer', 20, 7500)
                                end
                            end, function(data3, menu)
                                menu.close()
                            end)
                        else
                            PantCore.Functions.Notify("You Don't Even Deign To Get Out Of The Bad Pimp Car, Come On!", "error")
                        end
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)