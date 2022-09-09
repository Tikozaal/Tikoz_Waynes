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


RegisterNetEvent('Tikoz:Livreuroajzd')
AddEventHandler('Tikoz:Livreuroajzd', function()

    ESX.ShowAdvancedNotification('Fleeca Banque', "~b~Wayne's", "Merci pour votre ~b~~h~commande~s~ !", 'CHAR_BANK_FLEECA', 9)
    
    local pi = "s_m_m_autoshop_01"
    local po = GetHashKey(pi)
    RequestModel(po)
    while not HasModelLoaded(po) do Citizen.Wait(0) end
    local pipo = CreatePed(6, po, 123.4, 123.4, 123.4, 123.5, true, false)

    local car = "mule" 
    local carh = GetHashKey(car)
    RequestModel(carh)
    while not HasModelLoaded(carh) do Citizen.Wait(0) end
    local creacar = CreateVehicle(carh, 1054.88, 2673.54, 38.54, 295.96, true, false)
    
    SetPedIntoVehicle(pipo, creacar, -1)
    TaskVehicleDriveToCoord(pipo, creacar, Config.Pos.Blip, 40.0, 0, GetEntityModel(carh), 411, 10.0)
    
    Citizen.Wait(15000)

    TaskWanderStandard(pipo, 10.0, 10)

    TaskPedSlideToCoord(pipo, 1176.95, 2648.19, 37.79, 162.91, 10000)

    Citizen.Wait(27000)

        Citizen.CreateThread(function()
            while true do 
                local ped = PlayerPedId()
                local pos = GetEntityCoords(ped)
                local achat = vector3(1176.38, 2647.46, 36.78)
                local dist = #(pos - achat)

                if dist <= 2 and ESX.PlayerData.job.name == "waynes" then

                    ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour prendre votre ~b~commande")
                    DrawMarker(6, achat, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)


                    if IsControlJustPressed(1, 51) then
                    
                        for i=1, #commandeprepa, 1 do

                            local label = commandeprepa[i].label
        
                            TriggerServerEvent('Tikoz:RecupCommandeWaynes', label)
        
                            ESX.ShowAdvancedNotification("Wayne's", "~b~Livraison", "Vous avez récupérer votre ~b~commande~s~ !", 'CHAR_LS_CUSTOMS', 9)
                        end
                        TaskPedSlideToCoord(pipo, 1205.59, 2674.31, 37.64, 162.91, 10000)

                        Citizen.Wait(20000)

                        SetPedIntoVehicle(pipo, creacar, -1)

                        TaskVehicleDriveToCoord(pipo, creacar, 1054.88, 2673.54, 38.54, 295.96, 40.0, 0, GetEntityModel(carh), 411, 10.0)

                        Citizen.Wait(17000)

                        DeleteVehicle(creacar)
                        DeletePed(pipo)
                        return
                    end

                else
                    Citizen.Wait(1000)
                end
                Citizen.Wait(0)
            end
            
        end)
end)

