RegisterServerEvent('zyga_drugs:additem')
AddEventHandler('zyga_drugs:additem', function(nazwaitemu, ilosc)
    local xPedal = ESX.GetPlayerFromId(source)  
    if xPedal then
        xPedal.addInventoryItem(nazwaitemu, ilosc)
    end
end)

-- Register server callback for checking item
ESX.RegisterServerCallback('zyga_drugs:hasItem', function(source, cb, itemName, amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    -- Check if the player has the item
    local item = xPlayer.getInventoryItem(itemName)
    
    if item and item.count >= amount then
        -- Player has enough of the item
        cb(true)
    else
        -- Player does not have enough of the item
        cb(false)
    end
end)




RegisterServerEvent('zyga_drugs:removeitem')
AddEventHandler('zyga_drugs:removeitem', function(nazwaitemu, ilosc)
    local xPedal = ESX.GetPlayerFromId(source)  
    if xPedal then
        xPedal.removeInventoryItem(nazwaitemu, ilosc)
    end
end)