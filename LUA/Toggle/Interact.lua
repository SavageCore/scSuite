if tweak_data and tweak_data.SCSuiteConfiguration.toggle_interact_enable then
    -- TOGGLE INTERACTION (by LazyOzzy)
    if not _PlayerStandard__check_action_interact then _PlayerStandard__check_action_interact = PlayerStandard._check_action_interact end
    function PlayerStandard:_check_action_interact(t, input)
        if input.btn_interact_press and self:_interacting() then
            self:_interupt_action_interact()
            return false
        elseif input.btn_interact_release then
            return false
        end

        return _PlayerStandard__check_action_interact(self, t, input)
    end
end    