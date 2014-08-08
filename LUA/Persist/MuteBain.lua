if tweak_data and tweak_data.SCSuiteConfiguration.mute_bain_enable then    
    -- Disable Bain's Dialogue (Menu Persistent Script) v0.2 by B1313 and Modinstaller
    if inGame() and isPlaying() then
        muteBain = true
        if isHost() and managers.job:current_level_id() == "roberts" and managers.groupai:state():whisper_mode() then
            managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.mute_bain_disabled, tweak_data.system_chat_color)
            return
        end

        for i,v in ipairs(tweak_data.SCSuiteConfiguration.mute_bain_blacklist) do
            if managers.job:current_level_id() == v then
                managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.mute_bain_disabled, tweak_data.system_chat_color)
            return
            end
        end
        
        function DialogManager:queue_dialog( id, params )
            return
        end
    end
end    