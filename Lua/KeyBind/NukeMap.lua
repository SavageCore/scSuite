if tweak_data and tweak_data.SCSuiteConfiguration.nuke_map_toggle then
    -- KILL EM ALL
    local function destroy_unit(unit)
        if unit:character_damage():pickup() and unit:character_damage():pickup()  ~= "ammo" then
            unit:character_damage():drop_pickup()
        end
        World:delete_unit(unit)
    end
    numapocalypse = numapocalypse or function()
        for u_key, u_data in pairs(managers.enemy:all_enemies()) do
            destroy_unit(u_data.unit)
        end

        for u_key, u_data in pairs(managers.enemy:all_civilians()) do
           destroy_unit(u_data.unit)
        end

        for _, cam_unit in ipairs(SecurityCamera.cameras) do
            if cam_unit:enabled() then
                cam_unit:base():set_detection_enabled(false)
    end end end

    numapocalypse()
    managers.hud:show_hint( { text = tweak_data.SCSuiteConfiguration.localization_strings["nuke_map_toggle_true"] } )  
else
    managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteConfiguration.localization_strings["nuke_map_disabled"], tweak_data.system_chat_color)
end