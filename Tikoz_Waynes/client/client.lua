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


function facturewaynes()
    local amount = Keyboardput("Entré le montant", "", 15)
    
    if not amount then
      ESX.ShowNotification('~r~Montant invalide')
    else
  
      local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
  
        if closestPlayer == -1 or closestDistance > 3.0 then
            ESX.ShowNotification('Pas de joueurs à ~b~proximité')
        else
            local playerPed = PlayerPedId()
  
            Citizen.CreateThread(function()
                ClearPedTasks(playerPed)
                TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_waynes', "~b~Wayne's", amount)
                ESX.ShowNotification("Vous avez bien envoyer la ~b~facture")
            end)
        end
    end
end
  

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

menuwaynes = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Wayne's"},
    Data = { currentMenu = "Menu", "Test"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Annonce" then
                OpenMenu("Annonce")
            elseif btn.name == "~b~Wayne's ~s~Ouvert" then
                TriggerServerEvent('Tikoz:GarageOuvert')
            elseif btn.name == "~b~Wayne's ~s~Fermé" then
                TriggerServerEvent('Tikoz:GarageFermer')
            elseif btn.name == "~b~Wayne's ~s~personnalisé" then
                msgpersowaynes = Keyboardput("Message", "", 105)
                TriggerServerEvent('Tikoz:waynesMsgPerso', msgpersowaynes)
            elseif btn.name == "Facture" then
                facturewaynes()

            end

            if ESX.PlayerData.job.grade_name == 'boss' and ESX.PlayerData.job.name == "waynes" then
                if btn.name == "Gestion d'entreprise" then
                    menuwaynes.Menu["Gestion"].b = {}
                    table.insert(menuwaynes.Menu["Gestion"].b, { name = "Recruter", ask = "", askX = true})   
                    table.insert(menuwaynes.Menu["Gestion"].b, { name = "Promouvoir", ask = "", askX = true})
                    table.insert(menuwaynes.Menu["Gestion"].b, { name = "Destituer" , ask = "", askX = true})
                    table.insert(menuwaynes.Menu["Gestion"].b, { name = "Virer", ask = "", askX = true})
                    Citizen.Wait(200)
                    OpenMenu("Gestion")
                end
            end
            if btn.name == "Recruter" then 
                if ESX.PlayerData.job.grade_name == 'boss'  then
                    Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
                    if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
                        ESX.ShowNotification('Aucun joueur à ~b~proximité')
                    else
                        TriggerServerEvent('Tikoz:Recruter', GetPlayerServerId(Tikozaal.closestPlayer), ESX.PlayerData.job.name, 0)
                    end
                else
                    ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                end
            elseif btn.name == "Promouvoir" then
                if ESX.PlayerData.job.grade_name == 'boss' then
                    Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
                    if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
                        ESX.ShowNotification('Aucun joueur à ~b~proximité')
                    else
                        TriggerServerEvent('Tikoz:Promotionwaynes', GetPlayerServerId(Tikozaal.closestPlayer))
                    end
                else
                    ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                end
            elseif btn.name == "Virer" then 
                if ESX.PlayerData.job.grade_name == 'boss' then
                    Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
                    if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
                        ESX.ShowNotification('Aucun joueur à ~b~proximité')
                    else
                        TriggerServerEvent('Tikoz:Virer', GetPlayerServerId(Tikozaal.closestPlayer))
                    end
                else
                    ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                end
            elseif btn.name == "Destituer" then 
                if ESX.PlayerData.job.grade_name == 'boss' then
                    Tikozaal.closestPlayer, Tikozaal.closestDistance = ESX.Game.GetClosestPlayer()
                    if Tikozaal.closestPlayer == -1 or Tikozaal.closestDistance > 3.0 then
                        ESX.ShowNotification('Aucun joueur à ~b~proximité')
                    else
                        TriggerServerEvent('Tikoz:Retrograder', GetPlayerServerId(Tikozaal.closestPlayer))
                    end
                else
                    ESX.ShowNotification('Vous n\'avez pas les ~r~droits~w~')
                end
            end

           
end,
},
    Menu = {
        ["Menu"] = {
            b = {
                {name = "Annonce", ask = "", askX = true},
                {name = "Facture", ask = "", askX = true},
                {name = "Gestion d'entreprise", ask = "", askX = true},

            }
        },
        ["Annonce"] = {
            b = {
                {name = "~b~Wayne's ~s~Ouvert", ask = "", askX = true},
                {name = "~b~Wayne's ~s~Fermé", ask = "", askX = true},
                {name = "~b~Wayne's ~s~personnalisé", ask = "", askX = true},
            }
        },
        ["Gestion"] = {
            b = {
            }
        },
    }
}

Citizen.CreateThread(function()

    local blip = AddBlipForCoord(Config.Blip.Pos)
	SetBlipSprite (blip, Config.Blip.Id)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, Config.Blip.Taille)
	SetBlipColour (blip, Config.Blip.Couleur)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Blip.Nom)
	EndTextCommandSetBlipName(blip)
end)


RegisterNetEvent('Tikoz:alertwaynes')
AddEventHandler('Tikoz:alertwaynes', function()
	ESX.ShowAdvancedNotification("Wayne's", "~b~Secretaire", "Un client à sonné à~b~~h~ l'acceuil", "CHAR_CARSITE3", 4)
end)

local menudemande = {
    Base = { Header = {"commonmenu", "interaction_bgd"}, Color = {color_black}, HeaderColor = {0, 251, 255}, Title = "Acceuil"},
    Data = { currentMenu = "Menu"},
    Events = {
        onSelected = function(self, _, btn, PMenu, menuData, result)

            if btn.name == "Appelé un mécano" then
                TriggerServerEvent('Tikoz:alertwaynes')
                ESX.ShowNotification('Vous avez ~h~~b~appelé~s~ un ~b~~h~mécanicien')
                CloseMenu()
            elseif btn.name == "~r~Fermé" then
                CloseMenu()
            end
        end,
},
    Menu = {
        ["Menu"] = {
            b = {
                {name = "Appelé un mécano", ask = "", askX = true},
                {name = "~r~Fermé", ask = "", askX = true},
            }
        }
    }
}

Citizen.CreateThread(function()

    while true do 

        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local menu = Config.Pos.Acceuil
        local dist = #(pos - menu)

        if dist <= 2 then

            ESX.ShowHelpNotification("Appuie sur ~INPUT_CONTEXT~ pour ouvrir le ~b~menu")
            DrawMarker(6, menu, nil, nil, nil, -90, nil, nil, 0.7, 0.7, 0.7, 0, 251, 255, 200, false, true, 2, false, false, false, false)

            if IsControlJustPressed(1, 51) then
                CreateMenu(menudemande)
            end
        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end)


keyRegister("TikozOpenWaynes", "Menu F6", "F6", function()
    if ESX.PlayerData.job.name == "waynes" then
        CreateMenu(menuwaynes)
    end
end)
