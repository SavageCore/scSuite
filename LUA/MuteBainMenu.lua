if tweak_data and tweak_data.SCSuiteConfiguration.mute_bain_enable then
    -- Disable Bain's Dialogue (Menu Version [Needs Menu Persistent Script]) v0.2 by B1313 and Modinstaller
    function BainOFF()
        if inGame() and isPlaying() then
            if isHost() and managers.job:current_level_id() == "roberts" and managers.groupai:state():whisper_mode() then
                managers.chat:_receive_message(1, "Stealth Suite System", "This Level Needs Dialogue to Complete", tweak_data.system_chat_color)
                return
            end
            
            function DialogManager:queue_dialog( id, params )
                return
            end
        end
        if not GetPersistScript("muteBain") then
                AddPersistScript("muteBain","LUA\\_MuteBain.lua")
        end
        managers.chat:_receive_message(1, "Stealth Suite System", "Bain Dialogue OFF", tweak_data.system_chat_color)
    end

    function BainON()
        if GetPersistScript ("muteBain") then
            DelPersistScript ("muteBain")
        end
        
        if inGame() and isPlaying() then
            function DialogManager:queue_dialog( id, params )
                if not self._dialog_list[ id ] then
                    debug_pause( "The dialog script tries to queue a dialog with id '" .. tostring( id ) .. "' which doesn't seem to exist!" )
                    return false
                end
                
                if not self._current_dialog then
                    
                    
                    self._current_dialog = { id = id, params = params }
                    self:_play_dialog( self._dialog_list[ id ], params )
                else
                    
                    
                    local dialog = self._dialog_list[ id ]
                    
                    if self._next_dialog then
                        if dialog.priority > self._dialog_list[ self._next_dialog.id ].priority  then
                            self:_call_done_callback( params and params.done_cbk, "skipped" )
                            return false
                        end
                    end
                    
                    if dialog.priority < self._dialog_list[ self._current_dialog.id ].priority then
                        if self._next_dialog then
                            self:_call_done_callback( self._dialog_list[ self._next_dialog.id ].params and self._dialog_list[ self._next_dialog.id ].params.done_cbk, "skipped" )
                        end
                        
                        self._next_dialog = { id = id, params = params }
                    else
                        self:_call_done_callback( params and params.done_cbk, "skipped" )
                    end
                end
                
                return true
            end
        end
        managers.chat:_receive_message(1, "Stealth Suite System", "Bain Dialogue ON", tweak_data.system_chat_color)
    end

    local BainDialogueMenu = {} 
    BainDialogueMenu[#BainDialogueMenu+1] = { text = "Bain Dialogue OFF", callback = BainOFF } 
    BainDialogueMenu[#BainDialogueMenu+1] = { text = "Bain Dialogue ON", callback = BainON  } 
    BainDialogueMenu[#BainDialogueMenu+1] = { text = "Cancel", is_cancel_button = true } 
    SimpleMenu:new("Enable/Disable Bain's Dialogue", "Choose Option", BainDialogueMenu):show()
end    