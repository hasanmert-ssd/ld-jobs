PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

local secilenKonum = nil
local isleniyor = false

local blipler = {
    {
        ["kordinat"] = vector3(350.0, 6518.0, 31.0),
        ["isim"] = "Portakal Toplama",
        ["sprite"] = 237
    },
    {
        ["kordinat"] = vector3(407.97, 6497.59, 27.79),
        ["isim"] = "Portakal işleme",
        ["sprite"] = 499
    },
    {
        ["kordinat"] = vector3(1980.44, 3049.69, 50.43),
        ["isim"] = "Portakal Satış",
        ["sprite"] = 434
    }
}

local agaclar = {
    vector3(377.09, 6505.79, 28.01),
    vector3(369.31, 6505.87, 28.48),
    vector3(362.56, 6505.76, 28.54),
    vector3(354.68, 6505.02, 28.51),
    vector3(346.88, 6505.32, 28.85),
    vector3(338.92, 6505.63, 28.64),
    vector3(329.79, 6505.73, 28.63),
    vector3(320.83, 6505.45, 29.28),
    vector3(320.86, 6517.31, 29.15),
    vector3(329.29, 6517.64, 28.98),
    vector3(337.84, 6517.22, 28.93),
    vector3(347.07, 6517.61, 28.82),
    vector3(354.51, 6517.28, 28.26),
    vector3(361.89, 6517.8, 28.26),
    vector3(369.29, 6517.65, 28.37),
    vector3(377.53, 6517.55, 28.38),
    vector3(368.56, 6531.72, 28.4),
    vector3(360.62, 6531.13, 28.34),
    vector3(352.79, 6530.6, 28.43),
    vector3(345.11, 6531.1, 28.76),
    vector3(337.66, 6531.29, 28.54),
    vector3(328.82, 6531.15, 28.67),
    vector3(320.93, 6531.01, 29.18),
}

Citizen.CreateThread(function()
    secilenKonum = agaclar[1]
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    while true do
        local time = 1000
        local PlayerPed = PlayerPedId()
        local PlayerKordinat = GetEntityCoords(PlayerPed)
        local mesafe = #(PlayerKordinat - secilenKonum)
        local mesafeIsleme = #(PlayerKordinat - blipler[2]["kordinat"])
        local mesafeSatis = #(PlayerKordinat - blipler[3]["kordinat"])
        if PantCore then
            if mesafe < 50 then 
                time = 1
                DrawMarker(2, secilenKonum.x, secilenKonum.y, secilenKonum.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 145, 0, 100, false, true, 2, false, false, false, false)
                if mesafe < 1.5 then
                    PantCore.Functions.DrawText3D(secilenKonum.x, secilenKonum.y, secilenKonum.z, "[E] Collect")
                    if IsControlJustReleased(0, 38) and not isleniyor and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        isleniyor = true
                        local rastgele = math.random(1,#agaclar)
                        secilenKonum = agaclar[rastgele]

                        PantCore.Functions.Progressbar("portakal_toplama", "Picking Oranges", 5000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@",
                            anim = "high_center_up",
                            flags = 49,
                        }, {}, {}, function() -- Done
                            exports["ld-levelsistemi"]:expVer("tgimeslek")
                            TriggerServerEvent("ld-meslekportakal:portakalver", math.random(3,5))
                            isleniyor = false
                        end, function() -- Cancel
                            isleniyor = false
                        end)

                    end
                end
            end

            if mesafeIsleme < 20 then
                time = 1
                DrawMarker(2, blipler[2]["kordinat"].x, blipler[2]["kordinat"].y, blipler[2]["kordinat"].z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 145, 0, 100, false, true, 2, false, false, false, false)
                if mesafeIsleme < 1.5 then
                    PantCore.Functions.DrawText3D(blipler[2]["kordinat"].x, blipler[2]["kordinat"].y, blipler[2]["kordinat"].z, "[E] Process the Oranges")
                    if IsControlJustReleased(0, 38) and not isleniyor and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        isleniyor = true
                        PantCore.Functions.TriggerCallback('ld-meslekportakal:portakalisleme', function(data)
                            if data then
                                PantCore.Functions.Progressbar("portakal_isleme", "Processing Oranges", 5000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    isleniyor = false
                                    TriggerServerEvent('adiss:amkseyiniyap')
                                end, function() -- Cancel
                                    isleniyor = false
                                end)
                            else
                                isleniyor = false
                                PantCore.Functions.Notify("Must Have At Least 5 Oranges On It!", "error")
                            end
                        end)
                    end
                end
            end

            if mesafeSatis < 20 then
                time = 1
                DrawMarker(2, blipler[3]["kordinat"].x, blipler[3]["kordinat"].y, blipler[3]["kordinat"].z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 145, 0, 100, false, true, 2, false, false, false, false)
                if mesafeSatis < 1.5 then
                    PantCore.Functions.DrawText3D(blipler[3]["kordinat"].x, blipler[3]["kordinat"].y, blipler[3]["kordinat"].z, "[E] Sell Orange Juices")
                    if IsControlJustReleased(0, 38) and not isleniyor and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        isleniyor = true
                        PantCore.Functions.TriggerCallback('ld-meslekportakal:portakalsatis', function(data)
                            if data then
                                PantCore.Functions.Progressbar("portakal_satis", "Orange Juices are Sold", 10000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                }, {}, {}, {}, function() -- Done
                                    exports["ld-levelsistemi"]:expVer("portakal-satma")
                                    isleniyor = false
                                    TriggerServerEvent('portakalsuyu:sat')
                                end, function() -- Cancel
                                    isleniyor = false
                                end)
                            else
                                isleniyor = false
                                PantCore.Functions.Notify("Must Have Orange On It!", "error")
                            end
                        end)
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)