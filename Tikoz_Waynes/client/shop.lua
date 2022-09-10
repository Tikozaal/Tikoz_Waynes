ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
    ESX.PlayerData.job2 = job2
end)

local commandeprepa = {}

menushop = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Commande"},
    Data = { currentMenu = "Shop :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Boitier reprog" then
                local label = "boitierreprog"
                local name = "boitier reprog"
                local prix = 1000
                TriggerServerEvent('Tikoz:AchatWaynesPiece', label, name, prix)
            elseif btn.name == "Embrayage" then
                local label = "embrayage"
                local name = "embrayage"
                local prix = 300
                TriggerServerEvent('Tikoz:AchatWaynesPiece', label, name, prix)
            elseif btn.name == "Injecteurs" then
                local label = "injecteurs"
                local name = "injecteurs"
                local prix = 350
                TriggerServerEvent('Tikoz:AchatWaynesPiece', label, name, prix)
            elseif btn.name == "Turbo" then
                local label = "turbo"
                local name = "turbo"
                local prix = 500
                TriggerServerEvent('Tikoz:AchatWaynesPiece', label, name, prix)
            elseif btn.name == "Arbres à cames" then
                local name = "arbres à cames"
                local label = "arbreacame"
                local prix = 250
                TriggerServerEvent('Tikoz:AchatWaynesPiece', label, name, prix)
            end

        end,
},
    Menu = {
        ["Shop :"] = {
            b = {
                {name = "Boitier reprog", ask = "~g~1000$", askX = true},
                {name = "Embrayage", ask = "~g~300$", askX = true},
                {name = "Injecteurs", ask = "~g~350$", askX = true},
                {name = "Turbo", ask = "~g~500$", askX = true},
                {name = "Arbres à cames", ask = "~g~250$", askX = true},
            }
        }
    }
}

Citizen.CreateThread(function()

    while true do
       
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local menu = Config.Pos.Shop
        local dist = #(pos - menu)

        if dist <= 2 and ESX.PlayerData.job.name == "waynes" then

            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour passer une ~b~commande")
            DrawMarker(6, menu, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1, 51) then
                CreateMenu(menushop)
            end
        else
            Citizen.Wait(1000)
        end
        
        Citizen.Wait(0)
    end
end)


