if tweak_data and tweak_data.SCSuiteConfiguration.bank_buster_keybind_enable then    
    -- Bankbuster v3
    bankbuster = bankbuster or function()
    local depositboxes = {}
    local id
        for _,v in pairs(managers.interaction._interactive_objects) do
            if v.interaction then
                id = string.sub(v:interaction()._unit:name():t(), 1, 10)
                    if id == "@ID7999172" -- Harvest Bank
                    or id == "@IDe4bc870" or id == "@ID51da6d6" or id == "@ID8d8c766" or id == "@ID50aac55" or id == "@ID5dcd177" --Armoured Transport
                    or id == "@IDa95e021" -- The Big Bank
                    or id == "@IDe93c9b2" then -- GO Bank
                    table.insert(depositboxes, v:interaction())
        end end end
        for _,v in pairs(depositboxes) do
            v:interact(managers.player:player_unit())
        end
    managers.hud:show_hint( { text = "OPEN ALL DEPOSIT BOXES" } )
    end
    bankbuster()
end    