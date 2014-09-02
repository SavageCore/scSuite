if tweak_data and tweak_data.SCSuiteConfiguration.force_ready_toggle then 
    ------------------------------------------------------------------------------------------------------------------
    -- hejoro's Force Ready - http://www.unknowncheats.me/forum/payday-2/117604-skip-endscreen-and-force-ready.html --
    ------------------------------------------------------------------------------------------------------------------
    oldMethods = oldMethods or {}
    oldMethods.MissionBriefingGui = oldMethods.MissionBriefingGui or {}
    oldMethods.MissionBriefingGui.init = oldMethods.MissionBriefingGui.init or MissionBriefingGui.init
    function MissionBriefingGui.init(self, ...)
        oldMethods.MissionBriefingGui.init(self, ...)
        self._ready_up_counter = 0
        if tonumber(tweak_data.SCSuiteConfiguration.force_ready_threshold_value) ~= nil then
            self._force_ready_threshold = tweak_data.SCSuiteConfiguration.force_ready_threshold_value
        else
            self._force_ready_threshold = 5
        end
        
    end

    oldMethods.MissionBriefingGui.on_ready_pressed = oldMethods.MissionBriefingGui.on_ready_pressed or MissionBriefingGui.on_ready_pressed
    function MissionBriefingGui.on_ready_pressed(self, ...)
        oldMethods.MissionBriefingGui.on_ready_pressed(self, ...)
        if Network:is_server() then
            for k, peer in pairs(managers.network:session():peers()) do
                if not peer:synched() then
                    return
                end

            end

            self._ready_up_counter = self._ready_up_counter + 1
            if self._ready_up_counter > self._force_ready_threshold then
                managers.network:game():spawn_players()
            end

        end

    end
end    