player = nil
status = false

RegisterCommand("emote", function(source, args)
    player = GetPlayerPed(-1);
    local emoteToPlay = args[1]
    if GetVehiclePedIsIn(player, false) ~= 0 then return end;
    startEmote(emoteToPlay)
end)

TriggerEvent("chat:addSuggestion", "/emote", "Emote List", {
    { name="emote_name", help="Emote Name" }
})

function startEmote(anim)
    if emotes[anim] and player and status == false then 
        TaskStartScenarioInPlace(player, emotes[anim].anim, 0, true)
        status = true
    else 
        return;
    end;
end

Citizen.CreateThread(function()
    while true do
        if status then
            if 
                IsControlPressed(1, 32) --[[ "W" key ]]
                or IsControlPressed(1, 34) --[[ "A" key ]] 
                or IsControlPressed(1, 33) --[[ "S" key ]]
                or IsControlPressed(1, 35) --[[ "D" key ]]
                or IsControlPressed(1, 55) --[[ "SPACEBAR" key ]] 
            then
                ClearPedTasks(player);
                status = false
            end
        end
        Citizen.Wait(0)
    end
end)