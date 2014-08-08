if tweak_data and tweak_data.SCSuiteConfiguration.civilian_follow_override_enable then
    -- Move Infinite Number of Hostages
    if tweak_data and tweak_data.player then
        if tweak_data.SCSuiteConfiguration.civilian_follow_override_limit then
            tweak_data.player.max_nr_following_hostages = tweak_data.SCSuiteConfiguration.civilian_follow_override_limit
        else
            tweak_data.player.max_nr_following_hostages = 500
        end
    end
end    