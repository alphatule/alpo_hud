local minutes
local hours
local showHud = true
local temp = '0'
local temperature = '0'
local userjob = 'unemployed'

local ClothesCats = {
	0x9925C067, --hat
	0x2026C46D, --shirt
	0x1D4C528A, -- pants
	0x777EC6EF, -- boots 
	0xE06D30CE, -- coat
	0x662AC34, --open coat
	0xEABE0032, --gloves 
	0x485EE834, --vest
	0xAF14310B, -- poncho
}

local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N'}

RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function(charid)
    Citizen.CreateThread(function()
        while true do
            Wait(60000)
            TriggerEvent("vorp:ExecuteServerCallBack", "getjobUser", function(job)
                userjob = job
            end, 'i')
        end
    end)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local coords = GetEntityCoords(PlayerPedId(), true)
        temp = math.floor(GetTemperatureAtCoords(coords.x, coords.y, coords.z)*10)/10


        if Config.Fahrenheit then
            temp = (temp*9/5)+32
        end

        for k,v in pairs(ClothesCats) do
			local IsWearingClothes = Citizen.InvokeNative(0xFB4891BD7578CDC1, PlayerPedId(), v)
            if IsWearingClothes then
                if Config.Fahrenheit then
                    temperature = temp + 1.8
                    temperature = math.floor(temperature*10)/10
                else
                    temperature = temp + 1
                end
			      end
        end
        
        for k,v in pairs(directions)do
			      direction = GetEntityHeading(PlayerPedId())
			      if(math.abs(direction - k) < 22.5)then
				        direction = v
				        break
			      end
        end

        hours = GetClockHours()
        minutes = GetClockMinutes()
        if hours <= 9 then
            hours = "0"..hours
        end
        if minutes <= 9 then
            minutes = "0"..minutes
        end
        if showHud then
            if Config.Fahrenheit then
                if temp < Config.ExtremeColdF then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_PLATFORM_BLUE~'..temperature)..'°F~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp < Config.ColdF and temp >= Config.ExtremeColdF then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_BLUE~'..temperature)..'°F~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp < Config.CoolF and temp >= Config.ColdF then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_BLUELIGHT~'..temperature)..'°F~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp < Config.WarmF and temp >= Config.CoolF then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', temperature)..'°F~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp < Config.HotF and temp >= Config.WarmF then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_YELLOWSTRONG~'..temperature)..'°F~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp < Config.ExtremeHotF and temp >= Config.HotF then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_ORANGE~'..temperature)..'°F~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp >= Config.ExtremeHotF then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_NET_PLAYER2~'..temperature)..'°F~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                end
		DrawTxt(userjob, 0.0035, 0.968, 0.3, 0.3, true, 255, 255, 255, 255, false)
            else
                if temp < Config.ExtremeColdC then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_PLATFORM_BLUE~'..temperature)..'°C~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp < Config.ColdC and temp >= Config.ExtremeColdC then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_BLUE~'..temperature)..'°C~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp < Config.CoolC and temp >= Config.ColdC then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_BLUELIGHT~'..temperature)..'°C~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp < Config.WarmC and temp >= Config.CoolC then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', temperature)..'°C~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp < Config.HotC and temp >= Config.WarmC then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_YELLOWSTRONG~'..temperature)..'°C~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp < Config.ExtremeHotC and temp >= Config.HotC then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_ORANGE~'..temperature)..'°C~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                elseif temp >= Config.ExtremeHotC then
                    DrawTxt(_U('zona', GetCurentTownName())..'~q~ - '..direction..' - '.._U('dia', dayOfWeek())..'\n'.._U('temp', '~COLOR_NET_PLAYER2~'..temperature)..'°C~q~'..' - '.._U('hora', hours..':'..minutes), 0.12, 0.959, 0.3, 0.3, true, 255, 255, 255, 255, false)
                end
                DrawTxt(userjob, 0.0035, 0.968, 0.3, 0.3, true, 255, 255, 255, 255, false)
            end
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(15000)
		local ped = PlayerPedId()
        local stamina = GetAttributeCoreValue(ped, 1)
        if Config.Fahrenheit then
            if tonumber(temp) < Config.ExtremeColdF then
                Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, stamina - Config.LargeStaminaReduction)
            elseif tonumber(temp) < Config.ColdF and tonumber(temp) >= Config.ExtremeColdF then
                Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, stamina - Config.MediumStaminaReduction)
            elseif tonumber(temp) < Config.CoolF and tonumber(temp) >= Config.ColdF then
                Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, stamina - Config.LittleStaminaReduction)
            elseif tonumber(temp) < Config.HotF and tonumber(temp) >= Config.WarmF then
                TriggerEvent("vorpmetabolism:changeValue", "Thirst", Config.LittleWaterReduction)
            elseif tonumber(temp) < Config.ExtremeHotF and tonumber(temp) >= Config.HotF then
                TriggerEvent("vorpmetabolism:changeValue", "Thirst", Config.MediumWaterReduction)
            elseif tonumber(temp) >= Config.ExtremeHotF then
                TriggerEvent("vorpmetabolism:changeValue", "Thirst", Config.LargeWaterReduction)
            end
        else
            if tonumber(temp) < Config.ExtremeColdC then
                Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, stamina - Config.LargeStaminaReduction)
            elseif tonumber(temp) < Config.ColdC and tonumber(temp) >= Config.ExtremeColdC then
                Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, stamina - Config.MediumStaminaReduction)
            elseif tonumber(temp) < Config.CoolC and tonumber(temp) >= Config.ColdC then
                Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, stamina - Config.LittleStaminaReduction)
            elseif tonumber(temp) < Config.HotC and tonumber(temp) >= Config.WarmC then
                TriggerEvent("vorpmetabolism:changeValue", "Thirst", Config.LittleWaterReduction)
            elseif tonumber(temp) < Config.ExtremeHotC and tonumber(temp) >= Config.HotC then
                TriggerEvent("vorpmetabolism:changeValue", "Thirst", Config.MediumWaterReduction)
            elseif tonumber(temp) >= Config.ExtremeHotC then
                TriggerEvent("vorpmetabolism:changeValue", "Thirst", Config.LargeWaterReduction)
            end
        end
	  end
end)

function GetCurentTownName()
    local pedCoords = GetEntityCoords(PlayerPedId())
    local town_hash = Citizen.InvokeNative(0x43AD8FC02B429D33, pedCoords, 1)
    if town_hash == GetHashKey("Annesburg") then
        return "~COLOR_GREEN~Annesburg"
    elseif town_hash == GetHashKey("Armadillo") then
        return "~COLOR_GREEN~Armadillo"
    elseif town_hash == GetHashKey("Blackwater") then
        return "~COLOR_GREEN~Blackwater"
    elseif town_hash == GetHashKey("BeechersHope") then
        return "~COLOR_GREEN~BeechersHope"
    elseif town_hash == GetHashKey("Braithwaite") then
        return "~COLOR_GREEN~Braithwaite"
    elseif town_hash == GetHashKey("Butcher") then
        return "~COLOR_GREEN~Butcher"
    elseif town_hash == GetHashKey("Caliga") then
        return "~COLOR_GREEN~Caliga"
    elseif town_hash == GetHashKey("cornwall") then
        return "~COLOR_GREEN~Cornwall"
    elseif town_hash == GetHashKey("Emerald") then
        return "~COLOR_GREEN~Emerald"
    elseif town_hash == GetHashKey("lagras") then
        return "~COLOR_GREEN~lagras"
    elseif town_hash == GetHashKey("Manzanita") then
        return "~COLOR_GREEN~Manzanita"
    elseif town_hash == GetHashKey("Rhodes") then
        return "~COLOR_GREEN~Rhodes"
    elseif town_hash == GetHashKey("Siska") then
        return "~COLOR_GREEN~Siska"
    elseif town_hash == GetHashKey("StDenis") then
        return "~COLOR_GREEN~Saint Denis"
    elseif town_hash == GetHashKey("Strawberry") then
        return "~COLOR_GREEN~Strawberry"
    elseif town_hash == GetHashKey("Tumbleweed") then
        return "~COLOR_GREEN~Tumbleweed"
    elseif town_hash == GetHashKey("valentine") then
        return "~COLOR_GREEN~Valentine"
    elseif town_hash == GetHashKey("VANHORN") then
        return "~COLOR_GREEN~Vanhorn"
    elseif town_hash == GetHashKey("Wallace") then
        return "~COLOR_GREEN~Wallace"
    elseif town_hash == GetHashKey("wapiti") then
        return "~COLOR_GREEN~Wapiti"
    elseif town_hash == GetHashKey("AguasdulcesFarm") then
        return "~COLOR_GREEN~Aguasdulces Farm"
    elseif town_hash == GetHashKey("AguasdulcesRuins") then
        return "~COLOR_GREEN~Aguasdulces Ruins"
    elseif town_hash == GetHashKey("AguasdulcesVilla") then
        return "~COLOR_GREEN~Aguasdulces Villa"
    elseif town_hash == GetHashKey("Manicato") then
        return "~COLOR_GREEN~Manicato"
    else
        return _U('fuera_ciudad')
    end
end

function dayOfWeek()
	local dayOfWeek = GetClockDayOfWeek()
	
	if dayOfWeek == 0 then
		return _U('domingo')
	elseif dayOfWeek == 1 then
		return _U('lunes')
	elseif dayOfWeek == 2 then
		return _U('martes')
	elseif dayOfWeek == 3 then
		return _U('miercoles')
	elseif dayOfWeek == 4 then
		return _U('jueves')
	elseif dayOfWeek == 5 then
		return _U('viernes')
	elseif dayOfWeek == 6 then
		return _U('sabado')
	end
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    --Citizen.InvokeNative(0x66E0276CC5F6B9DA, 2)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
	SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
	Citizen.InvokeNative(0xADA9255D, 1)
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

RegisterCommand('hud', function(source, args, rawCommand)
--    if showHud then
--        showHud = false
--    else
--        showHud = true
--    end
    showHud = not showHud
end)
