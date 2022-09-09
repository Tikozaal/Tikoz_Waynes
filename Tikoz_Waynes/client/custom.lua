ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local Tikozaal = {}
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

function RefreshMoney()
    Citizen.CreateThread(function()
            ESX.Math.GroupDigits(ESX.PlayerData.money)
            ESX.Math.GroupDigits(ESX.PlayerData.accounts[1].money)
            ESX.Math.GroupDigits(ESX.PlayerData.accounts[2].money)
    end)
end

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


function Keyboardput(TextEntry, ExampleText, MaxStringLength) 
    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':')
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLength)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

menucustom = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Wayne's"},
    Data = { currentMenu = "Custom :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Cartographie d'origine" then

                local ped = PlayerPedId()

                local veh = GetVehiclePedIsIn(ped, true)
                local plate = GetVehicleNumberPlateText(veh)

                RequestAnimDict("random@car_theft_1@mcs_1")
                while not HasAnimDictLoaded("random@car_theft_1@mcs_1") do
                    Wait(1)
                end
                SetBlockingOfNonTemporaryEvents(ped, true)
                TaskPlayAnim(ped,"random@car_theft_1@mcs_1","car_returned_cam", 8.0, 0.0, 2000, 1, 0, 0, 0, 0)

                Citizen.Wait(2000)

                TriggerServerEvent("Tikoz:CartoStageZero", plate)

            end

            if btn.name == "Stage 1" then

                local ped = PlayerPedId()

                local veh = GetVehiclePedIsIn(ped, true)
                local plate = GetVehicleNumberPlateText(veh)
                RequestAnimDict("random@car_theft_1@mcs_1")
                while not HasAnimDictLoaded("random@car_theft_1@mcs_1") do
                    Wait(1)
                end
                SetBlockingOfNonTemporaryEvents(ped, true)
                TaskPlayAnim(ped,"random@car_theft_1@mcs_1","car_returned_cam", 8.0, 0.0, 5000, 1, 0, 0, 0, 0)

                Citizen.Wait(5000)


                TriggerServerEvent("Tikoz:CartoStageUn", plate)

            end
                

            if btn.name == "Stage 2" then
                local ped = PlayerPedId()

                local veh = GetVehiclePedIsIn(ped, true)
                local plate = GetVehicleNumberPlateText(veh)
                RequestAnimDict("random@car_theft_1@mcs_1")
                while not HasAnimDictLoaded("random@car_theft_1@mcs_1") do
                    Wait(1)
                end
                SetBlockingOfNonTemporaryEvents(ped, true)
                TaskPlayAnim(ped,"random@car_theft_1@mcs_1","car_returned_cam", 8.0, 0.0, 5000, 1, 0, 0, 0, 0)

                Citizen.Wait(5000)


                TriggerServerEvent("Tikoz:CartoStageDeux", plate)
            elseif btn.name == "Stage 3" then
                local ped = PlayerPedId()

                local veh = GetVehiclePedIsIn(ped, true)
                local plate = GetVehicleNumberPlateText(veh)
                RequestAnimDict("random@car_theft_1@mcs_1")
                while not HasAnimDictLoaded("random@car_theft_1@mcs_1") do
                    Wait(1)
                end
                SetBlockingOfNonTemporaryEvents(ped, true)
                TaskPlayAnim(ped,"random@car_theft_1@mcs_1","car_returned_cam", 8.0, 0.0, 5000, 1, 0, 0, 0, 0)

                Citizen.Wait(5000)


                TriggerServerEvent("Tikoz:CartoStageTrois", plate)    

            elseif btn.name == "Stage 4" then

                local ped = PlayerPedId()

                local veh = GetVehiclePedIsIn(ped, true)
                local plate = GetVehicleNumberPlateText(veh)
                RequestAnimDict("random@car_theft_1@mcs_1")
                while not HasAnimDictLoaded("random@car_theft_1@mcs_1") do
                    Wait(1)
                end
                SetBlockingOfNonTemporaryEvents(ped, true)
                TaskPlayAnim(ped,"random@car_theft_1@mcs_1","car_returned_cam", 8.0, 0.0, 5000, 1, 0, 0, 0, 0)

                Citizen.Wait(5000)

                TriggerServerEvent("Tikoz:CartoStageQuatre", plate)
            
            end
        end,
},
    Menu = {
        ["Custom :"] = {
            b = {
                {name = "Cartographie d'origine", ask = "", askX = true},
                {name = "Stage 1", ask = "", askX = true},
                {name = "Stage 2", ask = "", askX = true},
                {name = "Stage 3", ask = "", askX = true},
                {name = "Stage 4", ask = "", askX = true},

            }
        }
    }
}

Citizen.CreateThread(function()

    while true do 

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local menu = Config.Pos.Custom
        local dist = #(pos - menu)

        if dist <= 2 and ESX.PlayerData.job.name == "waynes" then
            if IsPedInAnyVehicle(ped, true) then
                ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
                DrawMarker(6, menu, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

                if IsControlJustPressed(1, 51) then
                    CreateMenu(menucustom)
                end

            end

        else
            Citizen.Wait(1000)
        end

        Citizen.Wait(0)
    end
end)

menuvoiture = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Prog"},
    Data = { currentMenu = "Menu :"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)
            ESX.TriggerServerCallback("Tikoz:WaynesVehiList", function(waynelist) 

                if btn.name == "Cartographie" then
                    Citizen.CreateThread(function()
                        while true do 
                            for i=1, #waynelist, 1 do

                                    local ped = PlayerPedId()
                                    local veh = GetVehiclePedIsIn(ped, true)
                                    local plateveh = GetVehicleNumberPlateText(veh)
                                
                                if plateveh == waynelist[i].plate then 
                                
                                    menuvoiture.Menu["Cartographie"].b = {}
                                    if waynelist[i].reprog == 1 then
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Moteur d'origine", ask = "", askX = true})
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Stage 1", ask = "", askX = true})
                                    
                                    elseif waynelist[i].reprog == 2 then
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Moteur d'origine", ask = "", askX = true})
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Stage 1", ask = "", askX = true})
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Stage 2", ask = "", askX = true})
                                    
                                    elseif waynelist[i].reprog == 3 then
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Moteur d'origine", ask = "", askX = true})
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Stage 1", ask = "", askX = true})
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Stage 2", ask = "", askX = true})
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Stage 3", ask = "", askX = true})

                                    elseif waynelist[i].reprog == 4 then
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Moteur d'origine", ask = "", askX = true})
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Stage 1", ask = "", askX = true})
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Stage 2", ask = "", askX = true})
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Stage 3", ask = "", askX = true})
                                        table.insert(menuvoiture.Menu["Cartographie"].b, { name = "Stage 4", ask = "", askX = true})
                                    end
                                 
                                    
                                end
                            end
                            Citizen.Wait(0)
                        end
                    end)
                    OpenMenu('Cartographie')

                end

                if btn.name == "Moteur d'origine" then
                    SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(PlayerPedId(), false), 0.0)
                elseif btn.name == "Stage 1" then
                    SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(PlayerPedId(), false), 45.0)
                elseif btn.name == "Stage 2" then              
                    SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(PlayerPedId(), false), 75.0)
                elseif btn.name == "Stage 3" then
                    SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(PlayerPedId(), false), 100.0)
                elseif btn.name == "Stage 4" then
                    SetVehicleEnginePowerMultiplier(GetVehiclePedIsIn(PlayerPedId(), false), 130.0)
                end

            end, args)     
        end,
},
    Menu = {
        ["Menu :"] = {
            b = {
                {name = "Cartographie", ask = ">", askX = true},
            }
        },
        ["Cartographie"] = {
            b = {
            }
        }
    }
}

RegisterCommand("carto", function()
    ESX.TriggerServerCallback("Tikoz:WaynesVehiList", function(waynelist) 
        local ped = PlayerPedId()
        local vehped = GetVehiclePedIsIn(ped, true)
        local plateveh = GetVehicleNumberPlateText(vehped)
        
        for i=1, #waynelist, 1 do 
            if plateveh == waynelist[i].plate then
                CreateMenu(menuvoiture)
            end
        end
    end, args)
end, false)
