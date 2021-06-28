PantCore = nil
busy = false
PlayerData = {}
activeBlips = {}

Citizen.CreateThread(function()
    while PantCore == nil do
        TriggerEvent('PantCore:GetObject', function(obj) PantCore = obj end)
        Citizen.Wait(200)
    end
end)  

RegisterNetEvent('PantCore:Client:OnPlayerLoaded')
AddEventHandler('PantCore:Client:OnPlayerLoaded', function()
    PlayerData = PantCore.Functions.GetPlayerData()
end)

RegisterNetEvent('ld-job:xp-ver')
AddEventHandler('ld-job:xp-ver', function()
    -- if PantCore.Key == key then
        exports["ld-levelsistemi"]:expVer("tgimeslek")
    -- end
end)

-- Tavukculuk
cook = vector3(-78.03, 6229.37, 31.09)
packaged = vector3(-101.96, 6208.57, 31.03)
chickenSellLocation = vector3(-591.47, -892.59, 25.94)

-- Odunculuk
talasLocation = vector3(-552.65, 5327.18, 73.6)
woodSellLocation = vector3(1207.57, -1338.73, 34.23)

-- Kumaş
fabricCollect = vector3(717.24, -959.38, 30.4)
clothesCollect = vector3(714.03, -969.92, 31.4)
clothesSellLocation = vector3(464.68, -801.47, 27.24)

-- Temizlik İşi
markerKordinat = vector3(329.46, -1580.72, 32.8)

-- Süt
milkCollect = vector3(2271.03, 4876.79, 40.92)
milk = vector3(2327.02, 4894.46, 41.81)
milkSellLocation = vector3(379.69, 356.76, 101.59)

-- Şarap
wineJuice = vector3(-1886.59, 2050.32, 140.98)
wineFermentable = vector3(-50.39, 1911.22, 195.71)
wineSellLocation = vector3(-555.65, 295.85, 82.09)

-- Çöpçülük
garabageLocation = vector3(493.46, -570.9, 24.57)

--
tabaccoLocationProcess = vector3(2194.04, 5593.92, 53.75)

local blips = {
    -- ["Tabacco"] = { -- Çöpçülük
    --     ["pos"] = tabaccoLocationProcess, 
    --     ["name"] = "Tütün Toplama ve Kurutma",
    --     ["sprite"] = 140,
    --     ["color"] = 35
    -- },
    ["Garbage"] = { -- Çöpçülük
        ["pos"] = garabageLocation, 
        ["name"] = "Çöpçülük",
        ["sprite"] = 318,
        ["color"] = 2
    },
    ["üzümtarla"] = { -- Üzüm Tarlası ve Üzüm Suyu
        ["pos"] = vector3(-1832.13, 2134.58, 123.58), 
        ["name"] = "Üzüm Tarlası",
        ["sprite"] = 270,
        ["color"] = 27
    },
    ["wineJuice"] = { -- Üzüm Tarlası ve Üzüm Suyu
        ["pos"] = wineJuice, 
        ["name"] = "Üzüm Sıkma",
        ["sprite"] = 270,
        ["color"] = 27
    },
    ["wineFermentable"] = { -- Şarap Yapma
        ["pos"] = wineFermentable, 
        ["name"] = "Üzüm Suyu İşleme",
        ["sprite"] = 270,
        ["color"] = 27
    },
    ["wineSellLocation"] = { -- Şarap Satış
        ["pos"] = wineSellLocation, 
        ["name"] = "Alkol Satış",
        ["sprite"] = 270,
        ["color"] = 27
    },
    ["milkFactory"] = { -- Süt Toplama
        ["pos"] = milkCollect, 
        ["name"] = "Süt Toplama",
        ["sprite"] = 120,
        ["color"] = 45
    },
    ["milkProcessing"] = { -- Süt işleme
        ["pos"] = milk, 
        ["name"] = "Süt İşleme",
        ["sprite"] = 120,
        ["color"] = 45
    },
    ["milkSell"] = { -- Süt Satış
        ["pos"] = milkSellLocation, 
        ["name"] = "Pastorize Süt Satış",
        ["sprite"] = 120,
        ["color"] = 45
    },
    ["ChickenFactory"] = { -- Tavuk Fabrikası
        ["pos"] = packaged, 
        ["name"] = "Tavuk Fabrikası",
        ["sprite"] = 268,
        ["color"] = 45
    },
    ["ChickenSell"] = { -- Tavuk Satış
        ["pos"] = chickenSellLocation, 
        ["name"] = "Tavuk Satış",
        ["sprite"] = 434,
        ["color"] = 45
    },
    ["WoodFactory"] = { -- Odun Kesme
        ["pos"] = talasLocation, 
        ["name"] = "Odun Fabrikası",
        ["sprite"] = 478,
        ["color"] = 21
    },
    ["LogCut"] = { -- Odun Kesme
        ["pos"] = vector3(-503.7, 5392.25, 75.98), 
        ["name"] = "Odun Kesme",
        ["sprite"] = 478,
        ["color"] = 21
    },
    ["LogSell"] = { -- Odun Satış
        ["pos"] = woodSellLocation, 
        ["name"] = "Talaş Satış",
        ["sprite"] = 434,
        ["color"] = 21
    },
    ["PortakalToplama"] = { -- Portakal Toplama
        ["pos"] = vector3(350.0, 6518.0, 31.0),
        ["name"] = "Portakal Toplama",
        ["sprite"] = 237,
        ["color"] = 47
    },
    ["Portakalİşleme"] = { -- Portakal İşleme
        ["pos"] = vector3(407.97, 6497.59, 27.79),
        ["name"] = "Portakal işleme",
        ["sprite"] = 499,
        ["color"] = 47
    },
    ["PortakalSatış"] = { -- Portakal Satış
        ["pos"] = vector3(1980.44, 3049.69, 50.43),
        ["name"] = "Portakal Satış",
        ["sprite"] = 434,
        ["color"] = 47
    },
    ["FabricFactory"] = { -- Terzi Dükkanı
        ["pos"] = fabricCollect,
        ["name"] = "Terzi",
        ["sprite"] = 366,
        ["color"] = 3
    },
    ["FabricSell"] = { -- Kiyafet Satış
        ["pos"] = clothesSellLocation,
        ["name"] = "Kıyafet Satış",
        ["sprite"] = 434,
        ["color"] = 3
    },
    ["CleanerJob"] = { -- Temizlik
        ["pos"] = markerKordinat,
        ["name"] = "Temizlik İşi",
        ["sprite"] = 318,
        ["color"] = 43
    },

    ["mermerJob"] = { -- 
        ["pos"] = vector3(2952.9057617188, 2790.7829589844, 41.231597900391),
        ["name"] = "Mermer Taşı Toplama [Günlük İş]",
        ["sprite"] = 501,
        ["color"] = 55
    },
    ["mermerSell"] = { -- 
        ["pos"] = vector3(1220.72 , -3005.43, 4.67),
        ["name"] = "Mermer Taşı Satış [Günlük İş]",
        ["sprite"] = 501,
        ["color"] = 55
    }

}

local blip = false
RegisterNetEvent("ldjob")
AddEventHandler("ldjob", function()
	if blip then
        PantCore.Functions.Notify("Profession Blips Passive")
		blipPassive()
		blip = false
	else
        PantCore.Functions.Notify("Profession Blips Aktive")
		blipActive()
		blip = true
	end
end)

function blipActive()
    for x,y in pairs(blips) do
        local blip = AddBlipForCoord(y["pos"])
        SetBlipSprite(blip, y["sprite"])
        SetBlipDisplay(blip, 2)
        SetBlipScale(blip, 0.5)
        SetBlipColour(blip, y["color"])
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(y["name"])
        EndTextCommandSetBlipName(blip)
        table.insert(activeBlips, blip)
    end
end

function blipPassive()
    for i=1, #activeBlips do
		RemoveBlip(activeBlips[i])
	end
	activeBlips = {}
end



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
