if tweak_data and tweak_data.SCSuiteConfiguration.toggle_mask_enabled then
    --PRESS ONCE TO MASK UP by hejoro (template script Toggle Interact by LazyOzzy)
    --Press your mask key only once to put it on (NOT instant mask up)
    if not _PlayerMaskOff__check_use_item then _PlayerMaskOff__check_use_item = PlayerMaskOff._check_use_item end
    function PlayerMaskOff:_check_use_item( t, input )
        if input.btn_use_item_press and self._start_standard_expire_t then
            self:_interupt_action_start_standard()
            return false
        elseif input.btn_use_item_release then
            return false
        end

        return _PlayerMaskOff__check_use_item(self, t, input)
    end
end    