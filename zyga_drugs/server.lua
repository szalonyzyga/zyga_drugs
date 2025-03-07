RegisterServerEvent('zyga_drugs:additem')
AddEventHandler('zyga_drugs:additem', function(nazwaitemu, ilosc)
    local xPedal = ESX.GetPlayerFromId(source)  
    if xPedal then
        xPedal.addInventoryItem(nazwaitemu, ilosc)
    end
end)

ESX.RegisterServerCallback('zyga_drugs:hasItem', function(source, cb, itemName, amount)
    local xPedal = ESX.GetPlayerFromId(source)
    
    local item = xPedal.getInventoryItem(itemName)
    
    if item and item.count >= amount then
        cb(true)
    else
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
