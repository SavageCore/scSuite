if tweak_data and tweak_data.SCSuiteConfiguration.force_ready_toggle then 
    local MBG_init_orig = MissionBriefingGui.init
    function MissionBriefingGui.init(self, ...)
        MBG_init_orig(self, ...)
        self._ready_up_counter = 0
        self._ready_up_threshold = tweak_data.SCSuiteConfiguration.force_ready_threshold_value
    end

    local MBG_orp_orig = MissionBriefingGui.on_ready_pressed
    function MissionBriefingGui.on_ready_pressed(self, ...)
        MBG_orp_orig(self, ...)
        if Network:is_server() then
            local all_synced = true
            for _, peer in pairs(managers.network:session():peers()) do
                if not peer:synched() then
                    all_synced = false
                end
            end
            if all_synced then
                self._ready_up_counter = self._ready_up_counter + 1
                if self._ready_up_counter > self._ready_up_threshold then
                    managers.network:game():spawn_players()
                end
            end
        end
    end
end    