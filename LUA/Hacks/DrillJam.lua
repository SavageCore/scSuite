if tweak_data and tweak_data.SCSuiteConfiguration.drill_jam_override_enable then
    if tweak_data.SCSuiteConfiguration.general_loaded then
        if inGame() and isPlaying() and isHost() then
            if not drilljam then
                drilljam = true
                -- DISABLE DRILL JAM
                if not _jamValue then _jamValue = TimerGui._set_jamming_values end
                function TimerGui:_set_jamming_values() return end
                managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.drill_jam_override_enabled, tweak_data.system_chat_color)
            end
        end
    end
end