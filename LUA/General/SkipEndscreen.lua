if tweak_data and tweak_data.SCSuiteConfiguration.skip_endscreen_toggle then 
    ------------------------------------------------------------------------------------------------------------------
    -- hejoro's Skip Endscreen - http://www.unknowncheats.me/forum/payday-2/117604-skip-endscreen-and-force-ready.html --
    ------------------------------------------------------------------------------------------------------------------
    oldMethods = oldMethods or {}
    oldMethods.MissionEndState = oldMethods.MissionEndState or {}

    oldMethods.MissionEndState.setup_controller = oldMethods.MissionEndState.setup_controller or MissionEndState.setup_controller
    function MissionEndState.setup_controller(self, ...)
        oldMethods.MissionEndState.setup_controller(self, ...)
        self._completion_bonus_done = true
        self._continue_block_timer = nil
    end

    function MissionEndState._continue_blocked(...)
        return false
    end

    oldMethods.MissionEndState.completion_bonus_done = oldMethods.MissionEndState.completion_bonus_done or MissionEndState.completion_bonus_done
    function MissionEndState.completion_bonus_done(self, ...)
        oldMethods.MissionEndState.completion_bonus_done(self, ...)
        self._completion_bonus_done = true
    end  
end