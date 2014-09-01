if tweak_data and tweak_data.SCSuiteConfiguration.mute_bain_enabled then    
    if not STFUBain then
        if not DialogManager then return end
        STFUBain = true
        local ingredient_dialog = {}
        ingredient_dialog["pln_rt1_20"] = "Muriatic Acid"
        ingredient_dialog["pln_rt1_22"] = "Caustic Soda"
        ingredient_dialog["pln_rt1_24"] = "Hydrogen Chloride"
        ingredient_dialog["pln_rat_stage1_20"] = "Muriatic Acid"
        ingredient_dialog["pln_rat_stage1_22"] = "Caustic Soda"
        ingredient_dialog["pln_rat_stage1_24"] = "Hydrogen Chloride"

        local _queue_dialog_orig = DialogManager.queue_dialog
        function DialogManager:queue_dialog(id, ...)
            if ingredient_dialog[id] then
                local mute_bain_rats = string.gsub(tweak_data.SCSuiteConfiguration.localization_strings["mute_bain_rats"], "{1}", ingredient_dialog[id])            
                if tweak_data.SCSuiteConfiguration.mute_bain_broadcast_toggle then 
                    managers.chat:send_message(ChatManager.GAME, managers.network.account:username() or "Offline", mute_bain_rats)
                else
                    managers.chat:_receive_message(1, "scSuite", mute_bain_rats, tweak_data.system_chat_color)
                end
            end
            return _queue_dialog_orig(self, id, ...)
        end
        
        if managers.job:current_level_id() ~= "big" and managers.job:current_level_id() ~= "roberts" then
            function DialogManager:_play_dialog(dialog, params, line)
                return
            end
        end
    end
end