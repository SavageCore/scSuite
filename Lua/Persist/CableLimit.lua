if tweak_data and tweak_data.SCSuiteConfiguration.cable_tie_toggle and tweak_data.SCSuiteConfiguration.cable_tie_limit_value > 2 then
    --Console("DEBUG: cable_guy started")
    if managers.skilltree:skill_unlocked(nil, "cable_guy") then
        --Console("DEBUG: cable_guy unlocked")
        if managers.skilltree:skill_completed("cable_guy") then
            tie_quantity = tweak_data.SCSuiteConfiguration.cable_tie_limit_value - 2
            tweak_data.upgrades.values.cable_tie.quantity = { tie_quantity }
        end    
    end
end