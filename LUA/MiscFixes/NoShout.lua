if tweak_data and tweak_data.SCSuiteConfiguration.fixes_shout_civilians_enable then
    if not _PlayerStandard__get_interaction_target then _PlayerStandard__get_interaction_target = PlayerStandard._get_interaction_target end
    function PlayerStandard:_get_interaction_target(char_table, my_head_pos, cam_fwd)
        for i = #char_table, 1, -1 do
            if char_table[i] and char_table[i].unit_type == 1 and char_table[i].unit:anim_data().tied then
                if not char_table[i].unit:in_slot(22) then char_table[i].unit:set_slot(22) end
                table.remove(char_table, i)
            end
        end
        
        return _PlayerStandard__get_interaction_target(self, char_table, my_head_pos, cam_fwd)
    end   
end    