if tweak_data and tweak_data.SCSuiteConfiguration.toggle_equipment_enabled then
    if not _PlayerStandard__check_use_item then _PlayerStandard__check_use_item = PlayerStandard._check_use_item end
    function PlayerStandard:_check_use_item( t, input )
        if input.btn_use_item_press and self:is_deploying() then
            self:_interupt_action_use_item()
            return false
        elseif input.btn_use_item_release then
            return false
        end
        
        return _PlayerStandard__check_use_item(self, t, input)
    end
end    