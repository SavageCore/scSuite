if tweak_data and tweak_data.SCSuiteConfiguration.bank_buster_stealth_enable then
    bankbuster = bankbuster or function()
        local depositboxes = {} --interacting while looping invalidates the table, so we have to build a list
        local id
        for _,v in pairs(managers.interaction._interactive_objects) do
            if v.interaction then
                id = string.sub(v:interaction()._unit:name():t(), 1, 10)
                if id == "@ID7999172" -- Harvest Bank
                --or id == "@IDe4bc870" or id == "@ID51da6d6" or id == "@ID8d8c766" or id == "@ID50aac55" or id == "@ID5dcd177" --Armoured Transport
                or id == "@IDe93c9b2" -- GO Bank
                or id == "@IDa95e021" then -- The Big Bank
                table.insert(depositboxes, v:interaction())
                end
            end
        end
        for _,v in pairs(depositboxes) do
            v:interact(managers.player:player_unit())
        end
    end

    MissionManager_client_run_mission_element = MissionManager_client_run_mission_element or MissionManager.client_run_mission_element
    function MissionManager:client_run_mission_element( id, unit, orientation_element_index )
        if managers.groupai:state():whisper_mode() and (id == 100731 or id == 100732) then bankbuster() end --Bank Heist
        if managers.groupai:state():whisper_mode() and id == 102890 then bankbuster() end --GO Bank
        MissionManager_client_run_mission_element( self, id, unit, orientation_element_index )
    end
end