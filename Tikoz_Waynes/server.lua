ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
TriggerEvent('esx_society:registerSociety', 'waynes', 'waynes', 'society_waynes', 'society_waynes', 'society_waynes', {type = 'public'})


TriggerEvent('esx_addonaccount:getSharedAccount', 'society_waynes', function(account)
	societyAccount = account
end)

RegisterServerEvent('Tikoz:GarageOuvert')
AddEventHandler('Tikoz:GarageOuvert', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Wayne's", '~b~Annonce', 'Nous sommes ~g~ouvert~s~ !', 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent('Tikoz:GarageFermer')
AddEventHandler('Tikoz:GarageFermer', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Wayne's", '~b~Annonce', 'Nous sommes ~r~fermé~s~ !', 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent('Tikoz:waynesMsgPerso')
AddEventHandler('Tikoz:waynesMsgPerso', function(msgpersowaynes)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], "Wayne's", '~b~Annonce', msgpersowaynes, 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent('Tikoz:Recruter')
AddEventHandler('Tikoz:Recruter', function(target, job, grade)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	targetXPlayer.setJob(job, grade)
	TriggerClientEvent('esx:showNotification', _source, "Vous avez ~g~recruté " .. targetXPlayer.name .. "~w~.")
	TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~embauché par " .. sourceXPlayer.name .. "~w~.")
end)

RegisterServerEvent('Tikoz:Promotionwaynes')
AddEventHandler('Tikoz:Promotionwaynes', function(target)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == 3) then
		TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~b~promouvoir~w~ d'avantage.")
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			local grade = tonumber(targetXPlayer.job.grade) + 1
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~b~promu " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~b~promu~s~ par " .. sourceXPlayer.name .. "~w~.")
		end
	end
end)


RegisterServerEvent('Tikoz:Retrograder')
AddEventHandler('Tikoz:Retrograder', function(target)
	local _source = source

	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if (targetXPlayer.job.grade == 0) then
		TriggerClientEvent('esx:showNotification', _source, "Vous ne pouvez pas plus ~r~rétrograder~w~ d'avantage.")
	else
		if (sourceXPlayer.job.name == targetXPlayer.job.name) then
			local grade = tonumber(targetXPlayer.job.grade) - 1
			local job = targetXPlayer.job.name

			targetXPlayer.setJob(job, grade)

			TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~rétrogradé " .. targetXPlayer.name .. "~w~.")
			TriggerClientEvent('esx:showNotification', target, "Vous avez été ~r~rétrogradé par " .. sourceXPlayer.name .. "~w~.")
		else
			TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
		end
	end
end)

RegisterServerEvent('Tikoz:Virer')
AddEventHandler('Tikoz:Virer', function(target)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)
	local job = "unemployed"
	local grade = "0"
	if (sourceXPlayer.job.name == targetXPlayer.job.name) then
		targetXPlayer.setJob(job, grade)
		TriggerClientEvent('esx:showNotification', _source, "Vous avez ~r~viré " .. targetXPlayer.name .. "~w~.")
		TriggerClientEvent('esx:showNotification', target, "Vous avez été ~g~viré par " .. sourceXPlayer.name .. "~w~.")
	else
		TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas ~r~l'autorisation~w~.")
	end
end)



ESX.RegisterServerCallback('Tikoz:Inventairewaynes', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory

	cb({items = items})
end)

RegisterServerEvent("Tikoz:CoffreDeposewaynes")
AddEventHandler("Tikoz:CoffreDeposewaynes", function(itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local sourceItem = xPlayer.getInventoryItem(itemName)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_waynes', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			TriggerClientEvent('esx:showNotification', _source, "Vous avez déposé ~y~x"..count.." ~b~"..inventoryItem.label)
		else
			TriggerClientEvent('esx:showNotification', _source, "quantité invalide")
		end
	end)
end)

ESX.RegisterServerCallback('Tikoz:CoffreSocietywaynes', function(source, cb)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_waynes', function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('Tikoz:RetireCoffrewaynes')
AddEventHandler('Tikoz:RetireCoffrewaynes', function(itemName, count, itemLabel)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_waynes', function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if count > 0 and inventoryItem.count >= count then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				TriggerClientEvent('esx:showNotification', _source, "Vous avez retiré ~y~x"..count.." ~b~"..itemLabel)
		else
			TriggerClientEvent('esx:showNotification', _source, "Quantité invalide")
		end
	end)
end)

RegisterServerEvent('Tikoz:alertwaynes')
AddEventHandler('Tikoz:alertwaynes', function() 
	local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'waynes' then
			TriggerClientEvent('Tikoz:alertwaynes', xPlayer.source)
		end
	end
end)

ESX.RegisterServerCallback('Tikoz:waynesSalaire', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local salairewaynes = {}

    MySQL.Async.fetchAll('SELECT * FROM job_grades', {

    }, function(result)

        for i=1, #result, 1 do

            table.insert(salairewaynes, {
				id = result[i].id,
                job_name = result[i].job_name,
                label = result[i].label,
                salary = result[i].salary,
            })
        end
        cb(salairewaynes)
    end)
end)

RegisterServerEvent("Tikoz:waynesNouveauSalaire")
AddEventHandler("Tikoz:waynesNouveauSalaire", function(id, label, amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    MySQL.Async.fetchAll("UPDATE job_grades SET salary = "..amount.." WHERE id = "..id,
	{
		['@id'] = id,
		['@salary'] = amount
	}, function (rowsChanged)
	end)
end)


ESX.RegisterServerCallback('Tikoz:getSocietyMoney', function(source, cb, societyName)
	if societyName ~= nil then
	  local society = "society_waynes"
	  TriggerEvent('esx_addonaccount:getSharedAccount', society, function(account)
		cb(account.money)
	  end)
	else
	  cb(0)
	end
end)

ESX.RegisterServerCallback('Tikoz:waynesArgentEntreprise', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local compteentreprise = {}


    MySQL.Async.fetchAll('SELECT * FROM addon_account_data WHERE account_name = "society_waynes"', {

    }, function(result)

        for i=1, #result, 1 do
            table.insert(compteentreprise, {
                account_name = result[i].account_name,
                money = result[i].money,
            })
        end
        cb(compteentreprise)
    end)
end)

RegisterServerEvent("Tikoz:waynesdepotentreprise")
AddEventHandler("Tikoz:waynesdepotentreprise", function(money)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local total = money
    local xMoney = xPlayer.getMoney()
    
    TriggerEvent('esx_addonaccount:getSharedAccount', "society_waynes", function (account)
        if xMoney >= total then
            account.addMoney(total)
            xPlayer.removeAccountMoney('bank', total)
            TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque Société', "~b~Wayne's", "Vous avez déposé ~g~"..total.." $~s~ dans votre ~b~entreprise", 'CHAR_BANK_FLEECA', 9)
        else
            TriggerClientEvent('esx:showNotification', source, "<C>~r~Vous n'avez pas assez d'argent !")
        end
    end)   
end)

RegisterServerEvent("Tikoz:waynesRetraitEntreprise")
AddEventHandler("Tikoz:waynesRetraitEntreprise", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	local xMoney = xPlayer.getAccount("bank").money
	
	TriggerEvent('esx_addonaccount:getSharedAccount', "society_waynes", function (account)
		if account.money >= total then
			account.removeMoney(total)
			xPlayer.addAccountMoney('bank', total)
			TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque Société', "~b~Wayne's", "Vous avez retiré ~g~"..total.." $~s~ de votre ~b~entreprise", 'CHAR_BANK_FLEECA', 9)
		else
			TriggerClientEvent('esx:showAdvancedNotification', source, 'Banque Société', "~b~Wayne's", "Vous avez pas assez d'argent dans votre ~b~entreprise", 'CHAR_BANK_FLEECA', 9)
		end
	end)
end) 



RegisterServerEvent("Tikoz:AchatWaynesPiece")
AddEventHandler("Tikoz:AchatWaynesPiece", function(label, name, prix)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_waynes' , function (account)
		if account.money >= prix then
			account.removeMoney(prix)
			xPlayer.addInventoryItem(label, 1)
			TriggerClientEvent('esx:showAdvancedNotification', source, 'Fleeca Banque', "~b~Wayne's", "Vous avez acheté ~y~x1 ~b~"..name.."~s~ pour ~g~"..prix.."$", 'CHAR_BANK_FLEECA', 9)
		else
			TriggerClientEvent('esx:showAdvancedNotification', source, 'Fleeca Banque', "~b~Wayne's", "Vous avez pas assez d'argent dans votre ~b~~h~entreprise", 'CHAR_BANK_FLEECA', 9)
		end
	end)
end)

ESX.RegisterServerCallback('Tikoz:WaynesVehiList', function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)
    local waynelist = {}


    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles', {

    }, function(result)

        for i=1, #result, 1 do

            table.insert(waynelist, {
				owner = result[i].owner,
				plate = result[i].plate,
                vehicle = result[i].vehicle,
                vehiclename = result[i].vehiclename,
                reprog = result[i].reprog,
            })

        end

        cb(waynelist)
    
    end)

end)

------------------ REPROG MOTEUR ------------------------------

RegisterServerEvent("Tikoz:CartoStageZero")
AddEventHandler("Tikoz:CartoStageZero", function(plate)

    local xPlayer = ESX.GetPlayerFromId(source)
	local carto = xPlayer.getInventoryItem("boitierreprog").count

	if carto > 0 then
		MySQL.Async.execute('UPDATE owned_vehicles SET reprog = 0 WHERE plate = @plate', {
			['@plate'] = plate
		}, function(rowsChanged)
		
		end)


		TriggerClientEvent('esx:showAdvancedNotification', source, "Wayne's", "~b~Cartographie", "Vous avez remis le vehicule ~b~~h~stage 0", 'CHAR_CARSITE3', 8)

	else
		TriggerClientEvent('esx:showAdvancedNotification', source, "Wayne's", "~b~Cartographie", "Vous avez besoin d'un ~b~~h~boitier pour reprog", 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent("Tikoz:CartoStageUn")
AddEventHandler("Tikoz:CartoStageUn", function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	local carto = xPlayer.getInventoryItem("boitierreprog").count

	if carto > 0 then 

		MySQL.Async.execute('UPDATE owned_vehicles SET reprog = 1 WHERE plate = @plate', {
			['@plate'] = plate
		}, function(rowsChanged)
		
		end)
		TriggerClientEvent('esx:showAdvancedNotification', source, "Wayne's", "~b~Cartographie", "Le véhicule est maintenant en ~b~~h~stage 1", 'CHAR_CARSITE3', 8)

	else
		TriggerClientEvent('esx:showAdvancedNotification', source, "Wayne's", "~b~Cartographie", "Vous avez besoin d'un ~b~~h~boitier pour reprog", 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent("Tikoz:CartoStageDeux")
AddEventHandler("Tikoz:CartoStageDeux", function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	local carto = xPlayer.getInventoryItem("boitierreprog").count
	local embra = xPlayer.getInventoryItem("embrayage").count

	if carto and embra > 0 then 

		xPlayer.removeInventoryItem("embrayage", 1)
		
		MySQL.Async.execute('UPDATE owned_vehicles SET reprog = 2 WHERE plate = @plate', {
			['@plate'] = plate
		}, function(rowsChanged)
		
		end)
		TriggerClientEvent('esx:showAdvancedNotification', source, "Wayne's", "~b~Cartographie", "Le véhicule est maintenant en ~b~~h~stage 2", 'CHAR_CARSITE3', 8)

	else
		TriggerClientEvent('esx:showAdvancedNotification', source, "Wayne's", "~b~Cartographie", "Vous avez besoin d'un ~b~~h~boitier pour reprog ~s~et d'un ~b~~h~embrayage sport", 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent("Tikoz:CartoStageTrois")
AddEventHandler("Tikoz:CartoStageTrois", function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	local carto = xPlayer.getInventoryItem("boitierreprog").count
	local inject = xPlayer.getInventoryItem("injecteurs").count

	if carto and inject > 0 then 

		xPlayer.removeInventoryItem("injecteurs", 1)
		
		MySQL.Async.execute('UPDATE owned_vehicles SET reprog = 3 WHERE plate = @plate', {
			['@plate'] = plate
		}, function(rowsChanged)
		
		end)
		TriggerClientEvent('esx:showAdvancedNotification', source, "Wayne's", "~b~Cartographie", "Le véhicule est maintenant en ~b~~h~stage 3", 'CHAR_CARSITE3', 8)

	else
		TriggerClientEvent('esx:showAdvancedNotification', source, "Wayne's", "~b~Cartographie", "Vous avez besoin d'un ~b~~h~boitier pour reprog ~s~et d'un ~b~~h~injecteur", 'CHAR_CARSITE3', 8)
	end
end)

RegisterServerEvent("Tikoz:CartoStageQuatre")
AddEventHandler("Tikoz:CartoStageQuatre", function(plate)
    local xPlayer = ESX.GetPlayerFromId(source)
	local carto = xPlayer.getInventoryItem("boitierreprog").count
	local turbo = xPlayer.getInventoryItem("turbo").count
	local arbre = xPlayer.getInventoryItem("arbreacame").count


	if turbo > 0 and arbre > 1 then 

		xPlayer.removeInventoryItem("turbo", 1)
		xPlayer.removeInventoryItem("arbreacame", 2)

		
		MySQL.Async.execute('UPDATE owned_vehicles SET reprog = 4 WHERE plate = @plate', {
			['@plate'] = plate
		}, function(rowsChanged)
		
		end)
		TriggerClientEvent('esx:showAdvancedNotification', source, "Wayne's", "~b~Cartographie", "Le véhicule est maintenant en ~b~~h~stage 4", 'CHAR_CARSITE3', 8)

	else
		TriggerClientEvent('esx:showAdvancedNotification', source, "Wayne's", "~b~Cartographie", "Vous avez besoin d'un ~b~~h~turbo ~s~et ~b~~h~2 arbre à cames", 'CHAR_CARSITE3', 8)
	end
end)
