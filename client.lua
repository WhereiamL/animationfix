
ESX = nil

Citizen.CreateThread(function()

    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
	end

end)


RegisterNetEvent('ejectUser')
AddEventHandler('ejectUser', function(vehicle)
	local playerPed = PlayerPedId()
	TaskLeaveAnyVehicle(playerPed, 0, 0)
	Wait(1500)
	SetPedToRagdoll(playerPed, 3000, 3000, 0, true, true, false)
end)


RegisterCommand("i", function(source, args, raw)
	Citizen.CreateThread(function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped, false)
	
	if GetVehiclePedIsIn(ped, false) == 0 then
		return
	end
	
	if GetPedInVehicleSeat(vehicle, -1) ~= ped then
		return
	end
	
	
	
	local seat = tonumber(args[1])
	local pedSeat = GetPedInVehicleSeat(vehicle, tonumber(args[1]))

	if vehicle ~= 0 then
		if pedSeat == ped then

			return
		end
		if pedSeat == 0 then

			return
		end
	end
	
	TriggerServerEvent('ejectUser', GetPlayerServerId(NetworkGetEntityOwner(pedSeat)), vehicle)
	end)
end, false)


-- FUNCTION
function refreshskin()

  local playerPed = PlayerPedId()
  local maxHealth = GetEntityMaxHealth(playerPed)
  local trenHP = GetEntityHealth(playerPed)

  local model, sex, fullSkin = nil

  TriggerEvent('skinchanger:getSkin', function(skin) sex = skin.sex fullSkin = skin end)

  if sex == 1 then 
    model = GetHashKey("mp_f_freemode_01") 
  else 
    model = GetHashKey("mp_m_freemode_01") 
  end 
  
  RequestModel(model)

  SetPlayerModel(PlayerId(), model)
  SetModelAsNoLongerNeeded(model)
  SetPedMaxHealth(PlayerId(), maxHealth)
  TriggerEvent('skinchanger:loadSkin', fullSkin)
  Wait(500)
  print(trenHP)
  SetEntityHealth(PlayerPedId(), trenHP)
end

---COMMAND
RegisterCommand("anim", function()
  refreshskin()
end)