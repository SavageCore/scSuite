if not FollowOverride then
    if tweak_data and tweak_data.SCSuiteConfiguration.follow_override_toggle then
        if tweak_data.player then
            tweak_data.player.max_nr_following_hostages = tweak_data.SCSuiteConfiguration.follow_override_limit_value
        end
    end    
    FollowOverride = true
end    