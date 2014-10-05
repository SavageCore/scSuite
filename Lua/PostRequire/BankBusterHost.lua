if tweak_data and tweak_data.SCSuiteConfiguration.bank_buster_toggle then
    --AUTOMATIC STEALTH BANKBUSTER by hejoro, original Bankbuster by Harfatus
    --If you've successfully stealthed and opened the vault, automatically open all lockboxes
    bankbuster = bankbuster or function()
        local depositboxes = {} --interacting while looping invalidates the table, so we have to build a list
        local id
        for _,v in pairs(managers.interaction._interactive_objects) do
            if v.interaction then
                id = string.sub(v:interaction()._unit:name():t(), 1, 10)
                if id == "@ID7999172" -- Harvest Bank
                or id == "@IDe4bc870" or id == "@ID51da6d6" or id == "@ID8d8c766" or id == "@ID50aac55" or id == "@ID5dcd177" --Armoured Transport
                or id == "@IDe93c9b2"  -- GO Bank
                or id == "@IDa95e021" then  -- The Big Bank
                table.insert(depositboxes, v:interaction())
                end
            end
        end
        for _,v in pairs(depositboxes) do
            v:interact(managers.player:player_unit())
        end
    end
    CoreUnitDamage_run_sequence = CoreUnitDamage_run_sequence or CoreUnitDamage.run_sequence
    function CoreUnitDamage:run_sequence( name, endurance_type, source_unit, dest_body, normal, position, direction, damage, velocity, params )
        if name == "timer_done" and self._unit:name():key() == "51001ab8e0aaa382" and managers.groupai:state():whisper_mode() then bankbuster() end --Bank Heists
        if name == "timer_reach_zero" and self._unit:name():key() == "261a2eb7b6bb561a" and managers.groupai:state():whisper_mode() then bankbuster() end --GO Bank
        CoreUnitDamage_run_sequence( self, name, endurance_type, source_unit, dest_body, normal, position, direction, damage, velocity, params )
    end
end 