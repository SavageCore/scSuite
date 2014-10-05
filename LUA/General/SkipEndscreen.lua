if tweak_data and tweak_data.SCSuiteConfiguration.skip_endscreen_toggle then 
    local MES_sc_orig = MissionEndState.setup_controller
    function MissionEndState.setup_controller(self, ...)
        MES_sc_orig(self, ...)
        self._completion_bonus_done = true
        self._continue_block_timer = nil
    end

    function MissionEndState._continue_blocked(self, ...)
        return false
    end

    local MES_cbd_orig = MissionEndState.completion_bonus_done
    function MissionEndState.completion_bonus_done(self, ...)
        MES_cbd_orig(self, ...)
        self._completion_bonus_done = true
    end
end