PantCore = nil

TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)

local active = false

local locations = {
    { ['x'] = -591.47,  ['y'] = 2076.52,  ['z'] = 131.37},
    { ['x'] = -590.35,  ['y'] = 2071.76,  ['z'] = 131.29},
    { ['x'] = -589.61,  ['y'] = 2069.3,  ['z'] = 131.19},
    { ['x'] = -588.6,  ['y'] = 2064.03,  ['z'] = 130.96},
}


RegisterNetEvent("ld-meslekmaden:remelting")
AddEventHandler("ld-meslekmaden:remelting", function(status)
    Remelting(status)
end)

Citizen.CreateThread(function()
    local blip1 = AddBlipForCoord(-597.01, 2091.42, 131.41)
    local blip2 = AddBlipForCoord(Config.WashingX, Config.WashingY, Config.WashingZ)
    local blip3 = AddBlipForCoord(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ)
    SetBlipSprite(blip1, 365)
    SetBlipColour(blip1, 5)
    SetBlipDisplay(blip1, 2)
    SetBlipAsShortRange(blip1, true)
    SetBlipScale(blip1, 0.5)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Maden")
    EndTextCommandSetBlipName(blip1)  

    SetBlipSprite(blip2, 365)
    SetBlipColour(blip2, 5)
    SetBlipDisplay(blip2, 2)
    SetBlipScale(blip2, 0.5)
    SetBlipAsShortRange(blip2, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Maden Yıkama")
    EndTextCommandSetBlipName(blip2)   

    SetBlipSprite(blip3, 365)
    SetBlipColour(blip3, 5)
    SetBlipDisplay(blip3, 2)
    SetBlipScale(blip3, 0.5)
    SetBlipAsShortRange(blip3, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Maden Eritme")
    EndTextCommandSetBlipName(blip3)  
end)

Citizen.CreateThread(function()
    while true do
        local time = 3000
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        if PantCore then
            for i=1, #locations, 1 do
                if #(pedCoords - vector3(locations[i].x, locations[i].y, locations[i].z)) < 4 and not active then
                    time = 1
                    local text = ""
                    if #(pedCoords - vector3(locations[i].x, locations[i].y, locations[i].z)) < 1.5 then
                        text = "[E] "
                        if IsControlJustReleased(1, 51)  then
                            active = true
                            exports["ld-levelsistemi"]:expVer("maden-toplama")
                            Animation()
                        end
                    end
                    PantCore.Functions.DrawText3D(locations[i].x, locations[i].y, locations[i].z, text.."Start Mining")
                end
            end

            if #(pedCoords - vector3(Config.WashingX, Config.WashingY, Config.WashingZ)) < 4 and not active then
                time = 1
                local text = ""
                if #(pedCoords - vector3(Config.WashingX, Config.WashingY, Config.WashingZ)) < 1.5 then
                    text = "[E] "
                    if IsControlJustReleased(1, 51) then
                        active = true
                        exports["ld-levelsistemi"]:expVer("maden-yıkama")
                        Washing()
                    end
                end
                PantCore.Functions.DrawText3D(Config.WashingX, Config.WashingY, Config.WashingZ+1.0, text.."Clean the rocks")
            end

            if #(pedCoords - vector3(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ)) < 4 and not active then
                time = 1
                local text = ""
                if #(pedCoords - vector3(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ)) < 1.5 then
                    text = "[E] "
                    if IsControlJustReleased(1, 51) then
                        active = true
                        exports["ld-levelsistemi"]:expVer("maden-eritme")
                        Remelting()
                    end
                end
                PantCore.Functions.DrawText3D(Config.RemeltingX, Config.RemeltingY, Config.RemeltingZ+1.0, text.."Melt the clean rcoks")
            end
        end
        Citizen.Wait(time)
    end
end)

function Animation()
    PantCore.Functions.Progressbar("maden_toplama", "Digging...", 30000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = "melee@large_wpn@streamed_core",
        anim = "ground_attack_on_spot",
        flags = 33,
    }, { -- prop1
        model = "prop_tool_pickaxe",
        bone = 57005,
        coords = { x = 0.18, y = -0.02, z = -0.02 },
        rotation = { x = 350.0, y = 100.0, z = 140.0 },
    }, {}, function() -- Done
        TriggerServerEvent("ld-meslekmaden:givestone")
        active = false
    end, function() -- Cancel
        active = false
    end)
end

function Washing()
    PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
        if amount > 1 then
            PantCore.Functions.Progressbar("maden_yikama", "Washing...", 5000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@prop_human_bum_bin@idle_a",
                anim = "idle_a",
                flags = 33,
            }, {}, {}, function() -- Done
                TriggerServerEvent("ld-meslekmaden:washing")
                active = false
            end, function() -- Cancel
                active = false
            end)
        else
            active = false
            PantCore.Functions.Notify('There are not enough stones on it.', "error")
        end
    end, 'stone')
end

-- function Washing(status)
--     if status then
--         PantCore.Functions.Progressbar("maden_yikama", "Yıkıyorsun...", 15000, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
--             disableMovement = false,
--             disableCarMovement = false,
--             disableMouse = false,
--             disableCombat = true,
--         }, {
--             animDict = "amb@prop_human_bum_bin@idle_a",
--             anim = "idle_a",
--             flags = 33,
--         }, {}, {}, function() -- Done
--             TriggerServerEvent("ld-meslekmaden:washing")
--             active = false
--         end, function() -- Cancel
--             -- Cancel
--         end)
--     else
--         active = false
--     end
-- end

function Remelting()
    PantCore.Functions.TriggerCallback("ld-jobs:check-item-amount", function(amount)
        if amount > 1 then
            PantCore.Functions.Progressbar("maden_eritme", "Melting...", 300, false, false, { -- p1: menu name, p2: yazı, p3: ölü iken kullan, p4:iptal edilebilir
                disableMovement = false,
                disableCarMovement = false,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = "amb@prop_human_bum_bin@idle_a",
                anim = "idle_a",
                flags = 33,
            }, {}, {}, function() -- Done
                TriggerServerEvent("ld-meslekmaden:remelting") 
                active = false
            end, function() -- Cancel
                active = false
            end)
        else
            active = false
            PantCore.Functions.Notify('There is not enough washed stone on it', 'error')
        end
    end, 'washed_stone')
end


