if tweak_data and tweak_data.SCSuiteConfiguration.instant_drill_toggle then
    if inGame() and isPlaying() and isHost() then
        if not instadrill then
        instadrill = true
            
            -- DISABLE DRILL JAM
            if not _jamValue then _jamValue = TimerGui._set_jamming_values end
            function TimerGui:_set_jamming_values() return end
            
            -- DISABLE DRILL TIMER
            if not _jamTimer then _jamTimer = TimerGui.start end
                function TimerGui:start( timer )
                    timer = 0.01
                    if self._jammed then
                        self:_set_jammed( false )
                        return
                    end
                        if not self._powered then
                                self:_set_powered( true )
                                return
                        end
                            if self._started then
                                return
                            end
                    self:_start( timer )
                    if managers.network:session() then
                    managers.network:session():send_to_peers_synched( "start_timer_gui", self._unit, timer )
                end 
            end
        
        -- Chat Message
        managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteConfiguration.localization_strings["instant_drill_toggle_true"], tweak_data.system_chat_color)
        
        else
        instadrill = false
            
            -- ENABLE DRILL JAM
            if _jamValue then TimerGui._set_jamming_values = _jamValue end
            
            -- ENABLE DRILL TIMER
            if _jamTimer then TimerGui.start = _jamTimer end
        
        -- Chat Message        
        managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteConfiguration.localization_strings["instant_drill_toggle_false"], tweak_data.system_chat_color)
        end 
    end  
else
    managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteConfiguration.localization_strings["instant_drill_disabled"], tweak_data.system_chat_color)
end