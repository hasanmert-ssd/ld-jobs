PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

local rastgeleMekan, rastgeleKonum = nil, 1

local gorevAktif = false

local copler = {
    {
        ["isim"] = "Karakol",
        ["kordinatlar"] = {
            vector3(424.24, -984.13, 30.71),
            vector3(424.49, -978.59, 30.71),
            vector3(429.1, -973.83, 30.71),
            vector3(433.6, -975.32, 30.71),
            vector3(432.93, -985.36, 30.71),
            vector3(418.64, -974.41, 29.43),
            vector3(418.57, -982.05, 29.42),
            vector3(431.52, -978.8, 30.71),
            vector3(437.82, -985.07, 30.69)
        }
    },
    {
        ["isim"] = "Hastane",
        ["kordinatlar"] = {
            vector3(271.96102905273, -611.32403564453, 42.926792144775),
            vector3(278.09664916992, -610.75610351562, 43.177364349365),
            vector3(275.01699829102, -600.19152832031, 43.141300201416),
            vector3(284.60699462891, -610.36999511719, 43.307567596436),
            vector3(289.50076293945, -606.02429199219, 43.330497741699),
            vector3(284.88613891602, -600.83624267578, 43.181571960449),
            vector3(281.39630126953, -604.833984375, 43.117500305176),
            vector3(286.91552734375, -612.20104980469, 43.385410308838),
            vector3(290.86254882812, -610.34722900391, 43.371131896973),
        }
    },
    {
        ["isim"] = "Motel",
        ["kordinatlar"] = {
            vector3(303.93, -232.95, 54.04),
            vector3(311.06, -232.02, 54.0),
            vector3(318.95, -237.31, 54.03),
            vector3(322.67, -242.65, 53.95),
            vector3(321.22, -232.47, 54.03),
            vector3(302.31, -227.76, 53.99),
            vector3(316.81, -227.71, 54.01),
            vector3(311.09, -239.58, 54.09),
            vector3(320.47, -245.34, 53.92)
        }
    }
}

Citizen.CreateThread(function()
    while true do
        local time = 1000
        local PlayerPed = PlayerPedId()
        local PlayerKordinat = GetEntityCoords(PlayerPed)
        local mesafe = #(PlayerKordinat - markerKordinat)
        if PantCore then
            if mesafe < 20 then 
                time = 1
                DrawMarker(2, markerKordinat.x, markerKordinat.y, markerKordinat.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.6, 0.6, 0.6, 0, 88, 155, 100, false, true, 2, false, false, false, false)
                if mesafe < 0.5 then
                    PantCore.Functions.DrawText3D(markerKordinat.x, markerKordinat.y, markerKordinat.z, "[E] Apply for a Cleaning Job")
                    if IsControlJustPressed(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                        if not gorevAktif then
                            gorevAktif = true
                            rastgeleMekan = math.random(1, #copler)
                            PantCore.Functions.Notify("Your Application for Cleaning Job has been Accepted!, Place to be Cleaned ".. copler[rastgeleMekan]["isim"] .."")
                        
                            SetNewWaypoint(copler[rastgeleMekan]["kordinatlar"][1].x, copler[rastgeleMekan]["kordinatlar"][1].y)
                            PantCore.Functions.Notify("Location marked on GPS")
                        else
                            PantCore.Functions.Notify("You Are Already Doing This Job Now!", "error")
                        end
                    end
                end
            end

            if gorevAktif then
                local konum = copler[rastgeleMekan]["kordinatlar"][rastgeleKonum]
                local copMesafe = #(PlayerKordinat - konum)
                if copMesafe < 30 then 
                    time = 1
                    DrawMarker(2, konum.x, konum.y, konum.z-0.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 88, 155, 100, false, true, 2, false, false, false, false)
                    if copMesafe < 0.5 then
                        PantCore.Functions.DrawText3D(konum.x, konum.y, konum.z, "[E] Clean")
                        if IsControlJustPressed(0, 38) and exports["pant-base"]:illegal(false, "We Can't Employ Notorious Criminals Like You Here") then
                            local yeniRastgeleKonum = math.random(1, #copler[rastgeleMekan]["kordinatlar"])
                            rastgeleKonum = yeniRastgeleKonum

                            PantCore.Functions.Progressbar("ozel_name", "The ground is swept", 30000, false, true, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            }, {
                                animDict = "amb@world_human_janitor@male@idle_a",
                                anim = "idle_a",
                                flags = 33,
                            }, { -- prop1
                                model = "prop_tool_broom",
                                bone = 28422,
                                coords = { x = -0.005, y = 0.0, z = 0.0 },
                                rotation = { x = 360.0, y = 360.0, z = 0.0 },
                            }, {}, function() -- Done
                                exports["ld-levelsistemi"]:expVer("temizlik-isi")
                                TriggerServerEvent("ld-job:temizlik-para")
                            end, function() -- Cancel
                                -- Cancel
                            end)

                        end
                    end
                end
            end
        end
        Citizen.Wait(time)
    end
end)