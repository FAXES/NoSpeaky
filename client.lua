---------------------------------
--- No Speaky, Made by FAXES ---
---------------------------------

--- Config --
local NoSpeakyPedList = {
    "s_m_y_cop_01",
    "s_m_y_fireman_01",
    "s_m_m_paramedic_01",
}

--- Code ---
canPlayerTalk = true
playerMuted = false

function drawTextVoice(text, x, y, size, center, font, r, g, b, a)
    local resx, resy = GetScreenResolution()
    SetTextFont(font)
    SetTextScale(size, size)
    SetTextProportional(0)
    SetTextCentre(false)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextColour(r, g, b, a)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextEntry("STRING")
    SetTextOutline()
    AddTextComponentString(text)
    DrawText((float(x) / 1.5) / resx, ((float(y) - 6) / 1.5) / resy)
end

function checkPed(ped)
	for i = 1, #NoSpeakyPedList do
		if GetHashKey(NoSpeakyPedList[i]) == GetEntityModel(ped) then
			return true
		end
	end
	return false
end

function ShowInfo(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function DisplayHelp(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("Fax:NoSpeaky")
AddEventHandler("Fax:NoSpeaky", function()

    local player = PlayerId()
    canPlayerTalk = not canPlayerTalk
    playerMuted = not playerMuted
    
    if canPlayerTalk == true then
        print("player can talk")
    else 
        print("play cannot talk!!!")
    end

    SetPlayerTalkingOverride(player, canPlayerTalk)
end)

RegisterNetEvent("Fax:NoSpeaky:CheckPedPerms")
AddEventHandler("Fax:NoSpeaky:CheckPedPerms", function(player)
    local ped = GetPlayerPed(PlayerId())

    if checkPed(ped) then
        TriggerServerEvent("Fax:NoSpeaky:CheckPedPerms:Approved", player)
    else
        TriggerEvent("chatMessage", "^1Insufficient Permissions.")
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if playerMuted then
            local player = PlayerId()
            DisableControlAction(0, 249, true)

            DisplayHelp("~r~Voice Chat Muted.")

            if NetworkIsPlayerTalking(player) then
                SetPlayerTalkingOverride(player, false)
            end

            if IsDisabledControlJustPressed(0, 249) then
                ShowInfo("~r~Voice chat is muted.")
            end
        end
    end
end)
