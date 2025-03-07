ESX = exports['es_extended']:getSharedObject()

local markery = {}

function Sigmafunkcjazebyniewpadalypodmapemarkery(x, y)
    local a, b = GetGroundZFor_3dCoord(x, y, 1000.0, true)
    local c = 0
    while not a and c < 10 do
        Citizen.Wait(100)
        a, b = GetGroundZFor_3dCoord(x, y, 1000.0, true)
        c = c + 1
    end
    if a then
        return b
    else
        return 30.0 
    end
end

function Wygerenujmarkerix(strefa)
    local matematykarozszerzonax = math.random(-strefa.radius, strefa.radius)
    local matematykarozszerzonay = math.random(-strefa.radius, strefa.radius)
    local x, y = strefa.coords.x + matematykarozszerzonax, strefa.coords.y + matematykarozszerzonay
    local z = Sigmafunkcjazebyniewpadalypodmapemarkery(x, y)
    return {x = x, y = y, z = z, zone = strefa} 
end

function MARKERIXY()
    markery = {}
    for _, strefa in pairs(Config.Zbiorki) do
        for i = 1, strefa.maxmarkerow do
            table.insert(markery, Wygerenujmarkerix(strefa))
        end
    end
end

MARKERIXY()


Citizen.CreateThread(function()
    while true do
        local koordynatygracza = GetEntityCoords(PlayerPedId())
        local dymynakfc = 1000 

        for i, marker in ipairs(markery) do
            local dystansodmarkerow = #(koordynatygracza - vector3(marker.x, marker.y, marker.z))
            
            if dystansodmarkerow < Config.MarkerOptions.dystanszebyzobaczyc then
                dymynakfc = 0 
                DrawMarker(Config.MarkerOptions.type, marker.x, marker.y, marker.z + 1, 0, 0, 0, 0, 0, 0, 
                    Config.MarkerOptions.scalex or 1.0, Config.MarkerOptions.scaley or 1.0, Config.MarkerOptions.scalez or 1.0, 
                    Config.MarkerOptions.r or 255, Config.MarkerOptions.g or 255, Config.MarkerOptions.b or 255, 
                    Config.MarkerOptions.a or 200, Config.MarkerOptions.bobbing or true, true, 2, false, nil, nil, false)
                
                if dystansodmarkerow < 1.5 then
                    local strefa = marker.zone 
                    ESX.ShowHelpNotification(strefa.interakcjapowiadomienie)
                    if IsControlJustReleased(0, 38) then 
                        local strefa = marker.zone 
                        
                        TriggerEvent(Config.NazwaTwojegoEventu, {
                            name = "narko",  
                            duration = strefa.czaszbierania, 
                            label = strefa.progresslabel,
                            useWhileDead = false,
                            canCancel = true,
                            controlDisables = {
                                disableMovement = true,
                                disableCarMovement = true,
                                disableMouse = false,
                                disableCombat = true,
                            },
                            animation = {
                                animDict = strefa.animdict, 
                                anim = strefa.animka, 
                                flags = 49,
                            },
                        }, function(wasCancelled)
                            if not wasCancelled then
                                markery[i] = Wygerenujmarkerix(marker.zone) 
                                ClearPedTasks(GetPlayerPed(-1))
                                ESX.ShowNotification(strefa.powiadomienie)
                                TriggerServerEvent('zyga_drugs:additem', strefa.nazwaitemka, strefa.ileitemkadodaje)
                            else
                                ClearPedTasks(GetPlayerPed(-1))
                                ESX.ShowNotification(strefa.powiadomienieanulowano)
                            end
                        end)
                        Citizen.Wait(strefa.czaszbierania)
                    end
                end
            end
        end
        Citizen.Wait(dymynakfc)
    end
end)

------------------- PRZERÓBKI -------------------

function propastworz(coords, model, headingpropa)
    local a = GetHashKey(model)
    RequestModel(a)
    
    while not HasModelLoaded(a) do
        Wait(500)
    end

    local prop = CreateObject(a, coords.x, coords.y, coords.z-0.95, false, false, false)
    SetEntityHeading(prop, headingpropa)
    SetEntityAsMissionEntity(prop, true, true)
    return prop
end

function TEXT3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    if onScreen then
        SetTextScale(0.35, 0.35)
        SetTextFont(0)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(1, 1, 1, 1, 255)
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        local playerCoords = GetEntityCoords(PlayerPedId())

        for _, przerobka in pairs(Config.Przerobki) do
            local distance = #(playerCoords - przerobka.coords)

            if distance <= przerobka.dystans then
                TEXT3D(przerobka.coords, przerobka.text)

                if not przerobka.propEntity then
                    przerobka.propEntity = propastworz(przerobka.coords, przerobka.prop, przerobka.headingpropa)
                end

                if distance <= przerobka.dystansdowcisniecia then
                if IsControlJustPressed(0, 38) then 
                    ESX.TriggerServerCallback('zyga_drugs:hasItem', function(hasItem)
                        if hasItem then
                            TriggerEvent(Config.NazwaTwojegoEventu, {
                                name = "przerobka",  
                                duration = przerobka.czaszbierania, 
                                label = przerobka.progresslabel,
                                useWhileDead = false,
                                canCancel = true,
                                controlDisables = {
                                    disableMovement = true,
                                    disableCarMovement = true,
                                    disableMouse = false,
                                    disableCombat = true,
                                },
                                animation = {
                                    animDict = przerobka.animdict, 
                                    anim = przerobka.animka, 
                                    flags = 49,
                                },
                            }, function(wasCancelled)
                                if not wasCancelled then
                                    ClearPedTasks(GetPlayerPed(-1))
                                    ESX.ShowNotification(przerobka.powiadomienie)
                                    TriggerServerEvent('zyga_drugs:removeitem', przerobka.jakiitemusuwa, przerobka.ileitemausuwa)
                                    TriggerServerEvent('zyga_drugs:additem', przerobka.jakiitemdodaje, przerobka.ileitemadodaje)
                                else
                                    ClearPedTasks(GetPlayerPed(-1))
                                    ESX.ShowNotification("Przerobka anulowana.")
                                end
                            end)
                        else
                            ESX.ShowNotification(przerobka.niemaitemapowiadomienie)
                        end
                    end, przerobka.jakiitemusuwa, przerobka.ileitemausuwa)
                end
            end
            else
                if przerobka.propEntity then
                    DeleteObject(przerobka.propEntity)
                    przerobka.propEntity = nil
                end
            end
        end
    end
end)