
ESX = nil

Citizen.CreateThread(function()

    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(100)
	end

end)


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
