if tweak_data and tweak_data.SCSuiteConfiguration.instant_drill_override_enable then
    -- SHOW HINT FUNCTION
    function showHint(msg,duration)
    if not managers or not managers.hud then 
        return 
    end
    managers.hud:show_hint({text = msg, time = duration})
    end

    ------------
    --- GAME ---
    ------------
    if inGame() and isPlaying() and isHost() then
        if not instadrill then
        instadrill = true
                        
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
            end end
            
            -- SHOWHINT
            showHint(tweak_data.SCSuiteLocalisation.instant_drill_override_toggle_on,3)
        
        else
        instadrill = false
            
            
            -- ENABLE DRILL TIMER
            if _jamTimer then TimerGui.start = _jamTimer end
        
            -- SHOWHINT
            showHint(tweak_data.SCSuiteLocalisation.instant_drill_override_toggle_off,3)    
        end
    end
else
    managers.chat:_receive_message(1, "scSuite", tweak_data.SCSuiteLocalisation.instant_drill_override_disabled, tweak_data.system_chat_color)
end