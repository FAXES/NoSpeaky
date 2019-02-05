---------------------------------
--- No Speaky, Made by FAXES ---
---------------------------------

--- Config ---
--[[
    1 = Use ACE permissions
    2 = Use ped whitelist (found in client.lua)
    3 = No whitelist
]]
permissionSet = 1 -- See above comment
muteCommand = "mute"

RegisterCommand(muteCommand, function(source, args, rawCommand)
    local player = tonumber(args[1])

    if player then
        if GetPlayerName(player) then
            if permissionSet == 1 then
                if IsPlayerAceAllowed(source, "FaxNoSpeaky") then
                    TriggerClientEvent("Fax:NoSpeaky", player)
                else
                    TriggerClientEvent("chatMessage", source, "^1Insufficient Permissions.")
                end
            elseif permissionSet == 2 then
                TriggerClientEvent("Fax:NoSpeaky:CheckPedPerms", source, player)
            elseif permissionSet == 3 then
                TriggerClientEvent("Fax:NoSpeaky", player)
            end
        else
            TriggerClientEvent("chatMessage", source, "^1Invalid Player.")
        end
    else
        TriggerClientEvent("chatMessage", source, "^1Invalid Player. ^rUsage: /" .. muteCommand .. " [ID]")
    end
end)

RegisterServerEvent("Fax:NoSpeaky:CheckPedPerms:Approved")
AddEventHandler("Fax:NoSpeaky:CheckPedPerms:Approved", function(player)
    TriggerClientEvent("Fax:NoSpeaky", player)
end)