if tweak_data and tweak_data.SCSuiteConfiguration.mute_bain_enable then    
    -- Disable Bain's Dialogue (Menu Persistent Script) v0.2 by B1313 and Modinstaller
    if inGame() and isPlaying() then
        muteBain = true
        if isHost() and managers.job:current_level_id() == "roberts" and managers.groupai:state():whisper_mode() then
            managers.chat:_receive_message(1, "System", "Disabling MuteBain - required for this level.", tweak_data.system_chat_color)
            return
        end

        exceptions = { 
            "roberts", 
            "alex_1", 
            "escape_overpass", 
            "arm_hcm", 
            "arm_fac", 
            "watchdogs_2",
            "big"
        }
        for i,v in ipairs(exceptions) do
            if managers.job:current_level_id() == v then
                managers.chat:_receive_message(1, "System", "Disabling MuteBain - required for this level.", tweak_data.system_chat_color)
            return
            end
        end
        
        function DialogManager:queue_dialog( id, params )
            return
        end
    end
end    